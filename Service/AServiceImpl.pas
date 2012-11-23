{**
@Abstract Реализация основной функциональности для сервиса WindowsNT
@Author Prof1983 <prof1983@ya.ru>
@Created 17.05.2006
@LastMod 14.11.2012

Возможные состояния сервиса для процедуры ReportStatus
  SERVICE_STOPPED        - сервис успешно остановлен
  SERVICE_START_PENDING  - сервис в процессе запуска
  SERVICE_STOP_PENDING   - сервис в процессе остановки
  SERVICE_RUNNING        - сервис работает
}
unit AServiceImpl;

interface

{$IFDEF ver100} {$DEFINE Delphi6Up} {$ENDIF}
{$IFDEF ver110} {$DEFINE Delphi6Up} {$ENDIF}
{$IFDEF ver120} {$DEFINE Delphi6Up} {$ENDIF}
{$IFDEF VER125} {$DEFINE Delphi6Up} {$ENDIF}
{$IFDEF VER130} {$DEFINE Delphi6Up} {$ENDIF}
{$IFDEF VER140} {$DEFINE Delphi6Up} {$ENDIF}

uses
  ActiveX, Classes, ComObj, ComServ, Messages, SysUtils, Windows, WinSock, WinSvc,
  {$IFNDEF Delphi6Up}Variants,{$ENDIF}
  ABase, AStdWinDialog,
  AConnectedAccount, AConsts2, {ProfGlobals,}
  AModuleList, AObjectImpl, {ProfProcessImpl,} AProgramImpl,
  AServiceTypes, AServiceUtils, ATypes, AUtils1;

type //** Основной объект сервиса
  TProfService = class(TProfObject)
  private
    FClientList: TThreadList;
    FConnectedAccount: TProfConnectedAccount;
    FModules: TModulesInfoList;
    FRaiseEvents: Variant;
    FServiceProcHandle: THandle;
    FServiceStatus: TServiceStatus;
    FServiceStatusHandle: SERVICE_STATUS_HANDLE;
    FCSReportStatus: TRTLCriticalSection;
    procedure InstallInterface(Factory: TComObjectFactory);
    procedure UninstallInterface(Factory: TComObjectFactory);
    procedure FactoryRegisterClassObject(Factory: TComObjectFactory);
    procedure InstallService(AIsSilent: boolean);
    procedure UnInstallService(AIsSilent: boolean);
    procedure ExecCmdStart(AIsSilent: boolean);
    procedure ExecCmdStop(AIsSilent: boolean);
    function GetIsConsole(): WordBool;
    procedure StartService();
    procedure InitService();
    procedure DoneService(AIsShutDown: boolean);
    procedure ServiceProc(argc: LongWord; var argv: array of PChar);
    function ServiceCtrl(dwControl: LongWord; dwEventType: LongWord; lpEventData: pointer; lpContext: pointer): LongWord;
  protected
    FProgram: TProfProgram;
    FTimerInterval: Integer;
  protected
    //** Сообщить о своем состоянии
    procedure ReportStatus(lCurrentState: LongWord);
    //** Показать сообщение об ошибке и добавить в файловый лог
    procedure ShowErrorAndLog(const AStrMsg: WideString);
    procedure WriteToConsole(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string);
  protected
    procedure DoCreate(); override; safecall;
    procedure DoCreated(); override; safecall;
    //** Срабатывает при начале запуска
    function DoStart(): WordBool; virtual; safecall;
    //function DoStart(): WordBool; override; safecall;
    //** Срабатывает после удачного запуска
    function DoStarted(): WordBool; virtual; safecall;
    //** Срабатывает при начале процедуры остановки
    function DoStop(AIsShutDown: WordBool): WordBool; virtual; safecall;
    //function DoStop(AIsShutDown: WordBool): WordBool; override; safecall;
    //** Срабатывает при завершении процедуры остановки
    function DoStoped(AIsShutDown: WordBool): WordBool; virtual; safecall;
  public
    //** Срабатывает при добавлении записи в лог
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override;
    constructor Create(); override;
    constructor Create2(Prog: TProfProgram);
    class function GetInstance(): TProfService;
    destructor Destroy(); override;
    //** Запуск сервиса на исполнение
    procedure RunService();
  public
    function Start(): WordBool; virtual; safecall;
    function Stop(): WordBool; virtual; safecall;
  public
    //** Хендл для сообщения текущего статуса
    property ServiceStatusHandle: SERVICE_STATUS_HANDLE read FServiceStatusHandle;
    property ServiceStatus: TServiceStatus read FServiceStatus;
  public
    //** Список клиентов
    property ClientList: TThreadList read FClientList;
    //** Список подключенных аккаунтов
    property ConnectedAccount: TProfConnectedAccount read FConnectedAccount;
    //** Список зарегистрированных модулей
    property Modules: TModulesInfoList read FModules;
  public
    property IsConsole: WordBool read GetIsConsole;
    //** Для передачи события
    property Events: Variant read FRaiseEvents;
  end;

{** Запускает сервис на исполнение }
procedure ProfService_Run(Service: TProfService);

implementation

type // Вспомогательный обьект для работы с событиями
  TEvents = class(TInterfacedObject, IUnknown, IDispatch)
  private
    FController: TProfService;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
  public
    constructor Create(Controller: TProfService);
  end;

const // Для регистрации категории COM объектов
  Ar_CategoryComDesc_409 = 'AReason OLE Automation';
  Ar_CategoryComDesc_419 = 'AReason OLE Automation';
  CATID_ArAppServer: TGUID = '{C3D94DD9-3B4A-4010-BE1D-0873DC0AF5A7}';

const // Название группы в которой регистрируются все сервисы
  LOAD_GROUP: PChar = 'AServices';

const
  WM_STOP_USER     = WM_USER + 1;
  WM_STOP_SYSTEM   = WM_USER + 2;
  WM_REPORT_STATUS = WM_USER + 3;

const
  strSwitchInstall   = 'INSTALL';
  strSwitchUninstall = 'UNINSTALL';
  strSwitchSilent    = 'SILENT';
  strSwitchStart     = 'START';
  strSwitchStop      = 'STOP';
  strSwitchConsole   = 'CONSOLE';

resourcestring
  info_Start_Init_Module = '===> Старт инициализации модуля: name - "%s", id - "%d".';
  info_Start_OS_Version  = 'Операционная система: %s %d.%d.%d (%s).';
  info_Start_Comp_Name   = 'Компьютер: %s (%s).';
  info_Started_Module    = '--> Модуль "%s" успешно инициализирован.';
  info_Start_Done_Shut   = '--> Завершение работы модуля "%s" при выключении системы.';
  info_Module_Done_Work  = '===> Модуль "%s" завершил работу.';

  warn_Start_Done_User   = '--> Завершение работы модуля "%s" по команде пользователя.';

  err_Caption            = 'Ошибка!';
  err_Server_Exists      = 'Нельзя создать два сервиса в одном приложении!';
  err_Win_Version        = 'Данная программа предназначенна для работы в Windows 2000, Windows XP, Windows 2003.';
  err_Name_Not_Def       = 'Неуказано системное имя сервиса.';
  err_DName_Not_Def      = 'Неуказано отображаемое имя сервиса.';
  err_Install_Open_SC    = 'Ошибка установки сервиса: "%s".'#13#10 +
                           'Не удалось открыть менеджер сервисов.'#13#10 +
                           'Сообщение: "%s".';
  err_Install_Create_Sv  = 'Ошибка установки сервиса: %s.'#13#10 +
                           'Сообщение: "%s".';
  err_Delete_Open_SC     = 'Ошибка удаления сервиса: %s.'#13#10 +
                           'Не удалось открыть менеджер сервисов.'#13#10 +
                           'Сообщение: "%s".';
  err_Delete_Open_Sv     = 'Ошибка удаления сервиса: %s.'#13#10 +
                           'Не удалось получить доступ к сервису.'#13#10 +
                           'Сообщение: "%s".';
  err_Delete_Sv          = 'Ошибка удаления сервиса: %s.'#13#10 +
                           'Сообщение: "%s".';
  err_Reg_Svc_Handler    = 'Ошибка регистрации обработчика команд: svc - "%s", err - "%s".';
  err_Duplicate_Handle   = 'Ошибка получения хендла потока: svc - "%s", err - "%s".';
  err_Start_Sv           = 'Ошибка запуска сервиса: %s.'#13#10 +
                           'Сообщение: "%s".';
  err_Stop_Sv            = 'Ошибка остановки сервиса: %s.'#13#10 +
                           'Сообщение: "%s".';

var
  ServiceNT: TProfService;
  ServiceProcID: LongWord;

{ Private }

function ConsoleCtrlProc(ACtrlType: LongWord): Boolean; stdcall;
begin
  Result := True;
  case ACtrlType of
    CTRL_CLOSE_EVENT:
      PostThreadMessage(ServiceProcID, WM_STOP_USER, 0, 0);
  else
    Result := False;
  end;
end;

function WServiceCtrl(dwControl: LongWord; dwEventType: LongWord; lpEventData: pointer; lpContext: pointer): LongWord; stdcall;
begin
  Result := ServiceNT.ServiceCtrl(dwControl, dwEventType, lpEventData, lpContext);
end;

procedure WServiceProc(argc: LongWord; var argv: array of PChar); stdcall;
begin
  ServiceNT.ServiceProc(argc, argv);
end;

{ Public }

procedure AService_InstallInterface(Factory: TComObjectFactory);
var
  tmpClassID: string;
  tmpProgID: string;
  tmpFileName: string;
  tmpCatReg: ICatRegister;
  tmpCatInfo: TCATEGORYINFO;
begin
  if (Factory.Instancing = ciInternal) then Exit;
  try
    tmpClassId := GuidToString(Factory.ClassId);
    tmpProgId := Factory.ProgId;
    tmpFileName := ParamStr(0);
    CreateRegKey('CLSID\' + tmpClassId, '', Factory.Description);
    if not(IsConsole) then
      CreateRegKey('CLSID\' + tmpClassId + '\LocalServer32', '', tmpFileName)
    else
      CreateRegKey('CLSID\' + tmpClassId + '\LocalServer32', '', '"' + tmpFileName + '"' + ' /console');
    CreateRegKey('CLSID\' + tmpClassID + '\ProgID', '', tmpProgID);
    CreateRegKey('CLSID\' + tmpClassID, 'AppID', tmpClassID);
    CreateRegKey(tmpProgId, '', Factory.Description);
    CreateRegKey(tmpProgId + '\Clsid', '', tmpClassID);
    if not(IsConsole) then
    begin
      CreateRegKey('AppID\' + tmpClassId, '', Factory.Description);
      CreateRegKey('AppID\' + tmpClassId, 'LocalService', FProgram.ProgramName);
    end;
  except
    on E: Exception do
      ShowErrorAndLog(E.Message);
  end;
  try
    // Регистрируем категорию
    OleCheck(CoCreateInstance(CLSID_StdComponentCategoryMgr, nil, CLSCTX_INPROC_SERVER, ICatRegister, tmpCatReg));
    tmpCatInfo.catid := CATID_ArAppServer;
    tmpCatInfo.lcid := $0409;
    StringToWideChar(Ar_CategoryComDesc_409, tmpCatInfo.szDescription, Length(Ar_CategoryComDesc_409) + 1);
    OleCheck(tmpCatReg.RegisterCategories(1, @tmpCatInfo));
    tmpCatInfo.lcid := $0419;
    StringToWideChar(Ar_CategoryComDesc_419, tmpCatInfo.szDescription, Length(Ar_CategoryComDesc_419) + 1);
    OleCheck(tmpCatReg.RegisterCategories(1, @tmpCatInfo));
    OleCheck(tmpCatReg.RegisterClassImplCategories(Factory.ClassID, 1, @CATID_ArAppServer));
  except
    on E: Exception do
      ShowErrorAndLog(E.Message);
  end;
end;

procedure ProfService_Run(Service: TProfService);
var
  tmpIsSilent: Boolean;
  Version: TWinVersion;
begin
  Version := GetWinVersion();
  if (Version in [wvW2K, wvXP, wv2003]) then
  try
    ComServer.SetServerName(Service.FProgram.ProgramName);
    ComServer.IsInprocServer := False;
    // Ключь тихого режима
    tmpIsSilent := FindCmdLineSwitch(strSwitchSilent, ['-','/'], True);
    if FindCmdLineSwitch(strSwitchInstall, ['-','/'], True) then
      Service.InstallService(tmpIsSilent)
    else if FindCmdLineSwitch(strSwitchUninstall, ['-','/'], True) then
      Service.UnInstallService(tmpIsSilent)
    else if FindCmdLineSwitch(strSwitchStart, ['-','/'], True) then
      Service.ExecCmdStart(tmpIsSilent)
    else if FindCmdLineSwitch(strSwitchStop, ['-','/'], True) then
      Service.ExecCmdStop(tmpIsSilent)
    else
      Service.StartService();
  except
  end
  else
    Service.ShowErrorAndLog(err_Win_Version);
end;

{ TEvents }

constructor TEvents.Create(Controller: TProfService);
begin
  inherited Create;
  FController := Controller;
end;

function TEvents.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word;
    var Params; VarResult, ExcepInfo, ArgErr: Pointer): HRESULT;
{
var
  n: integer;
  tmpList: TList;
  tmpClient: TProfAutoObject;
}
begin
  Result := S_OK;
{
  tmpList := FController.ClientList.LockList();
  try
    for n := 0 to tmpList.Count - 1 do
    begin
      tmpClient := TProfAutoObject(tmpList.Items[n]);
//      if (tmpClient.ClientType = cltWork) then
      try
        IDispatch(tmpClient.Events).Invoke(DispID, IID, LocaleID, Flags, Params, VarResult, ExcepInfo, ArgErr);
      except
      end;
    end;
  finally
    FController.ClientList.UnlockList();
  end;
}
end;

function TEvents.QueryInterface(const IID: TGUID; out Obj): HRESULT;
{
var
  n: integer;
  tmpList: TList;
  tmpClient: TProfAutoObject;
}
begin
  Result := S_OK;
{
  tmpList := FController.ClientList.LockList();
  try
    for n := 0 to tmpList.Count - 1 do
    begin
      tmpClient := TProfAutoObject(tmpList.Items[n]);
//      if (tmpClient.ClientType = cltWork) then
      try
        IDispatch(tmpClient.Events).QueryInterface(IID, Obj);
        Exit;
      except
      end;
    end;
  finally
    FController.ClientList.UnlockList();
  end;
}
end;

function TEvents.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Result := S_OK;
end;

function TEvents.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Result := S_OK;
end;

function TEvents.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
{
var
  n: integer;
  tmpList: TList;
  tmpClient: TProfAutoObject;
}
begin
  Result := S_OK;
{
  tmpList := FController.ClientList.LockList();
  try
    for n := 0 to tmpList.Count - 1 do
    begin
      tmpClient := TProfAutoObject(tmpList.Items[n]);
//      if (tmpClient.ClientType = cltWork) then
      try
        if (tmpClient.AutoFactory.EventTypeInfo <> nil) then
          tmpClient.AutoFactory.EventTypeInfo.GetIDsOfNames(Names, NameCount, DispIDs);
        Exit;
      except
      end;
    end;
  finally
    FController.ClientList.UnlockList();
  end;
}
end;

{ TProfService }

function TProfService.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  WriteToConsole(AGroup, AType, AStrMsg);
  Result := 0;
  //Result := inherited AddToLog(AGroup, AType, AStrMsg);
end;

constructor TProfService.Create();
begin
  inherited Create();
  if Assigned(ServiceNT) then
    raise Exception.Create(err_Server_Exists);

  ServiceNT := Self;

  InitializeCriticalSection(FCSReportStatus);
  FClientList := TThreadList.Create();
  FServiceProcHandle := 0;
  FServiceStatusHandle := 0;
end;

constructor TProfService.Create2(Prog: TProfProgram);
begin
  FProgram := Prog;
  Create();
end;

destructor TProfService.Destroy();
begin
  DeleteCriticalSection(FCSReportStatus);
  FreeAndNil(FClientList);
  ServiceNT := nil;
  inherited;
end;

procedure TProfService.DoCreate();
begin
  inherited DoCreate();
end;

procedure TProfService.DoCreated();
begin
  inherited DoCreated();
  if Assigned(FProgram) then
  begin
//    Self.Log := FProgram.LogDocuments;
    //ToLog(lgGeneral, ltInformation, 'Объект сервиса создан', []);
    FProgram.Initialize();
    //ToLog(lgGeneral, ltInformation, 'Сервис инициализирован', []);
  end;
end;

procedure TProfService.DoneService(AIsShutDown: boolean);
begin
  DoStop(AIsShutDown);

  try
    // Сохраним текущие настройки
    //SetupRecord.SaveParams();
    // Остановим таймер
    KillTimer(0, 0);
    ReportStatus(SERVICE_STOP_PENDING);
    // Логируем остановку
    if AIsShutDown then
      AddToLog(lgGeneral, ltInformation, info_Start_Done_Shut)
    else
      AddToLog(lgGeneral, ltWarning, warn_Start_Done_User);
    ReportStatus(SERVICE_STOP_PENDING);
    AddToLog(lgGeneral, ltInformation, info_Module_Done_Work);
    ReportStatus(SERVICE_STOP_PENDING);
    DoStoped(AIsShutDown);
    FreeAndNil(FModules);
    FreeAndNil(FConnectedAccount);
    ReportStatus(SERVICE_STOP_PENDING);
    FRaiseEvents := Null;
  except
  end;
end;

function TProfService.DoStart(): WordBool;
begin
  //inherited DoStart();
  Result := Assigned(FProgram);
  if Result then
    Result := FProgram.Start();
end;

function TProfService.DoStarted: WordBool;
begin
  Result := True;
end;

function TProfService.DoStop(AIsShutDown: WordBool): WordBool;
begin
  if not(Assigned(FProgram)) then
  begin
    Result := False;
    Exit;
  end;
  Result := FProgram.Stop();
  //inherited DoStop(AIsShutDown);
end;

function TProfService.DoStoped(AIsShutDown: WordBool): WordBool;
begin
  Result := True;
end;

procedure TProfService.ExecCmdStop(AIsSilent: boolean);
begin
  if (IsConsole) then
    Exit;
  // Проверим на запуск
  if not(IsServiceRun(FProgram.ProgramName)) then
    Exit;
  // Остановим
  if not(AServiceUtils.StopService(FProgram.ProgramName)) then
    if not(AIsSilent) then
      ShowErrorAndLog(err_Stop_Sv); //[SysErrorMessage(GetLastError())]);
end;

procedure TProfService.FactoryRegisterClassObject(Factory: TComObjectFactory);
begin
  Factory.RegisterClassObject();
end;

class function TProfService.GetInstance(): TProfService;
begin
  Result := ServiceNT;
end;

function TProfService.GetIsConsole(): WordBool;
begin
  if Assigned(FProgram) then
    Result := FProgram.IsConsole
  else
    Result := System.IsConsole;
end;

procedure TProfService.InitService();
var
  tmpModuleInfo: TModuleInfo;
  Version: TWinVersion;
begin
  try
    ReportStatus(SERVICE_START_PENDING);
    // Проверим наличие заданной директории
    //ForceDirectories(GetUpLevelDir(ExtractFilePath(ParamStr(0))) + DEFAULT_DB_DIR);
    // Запустим сервер
    DoStart();
    ReportStatus(SERVICE_START_PENDING);
    // Дальнейшая обработка
    AddToLog(lgGeneral, ltInformation, Format(info_Start_Init_Module, [FProgram.ProgramName, FProgram.ProgramId]));
    // Выведем немного информации
    Version := GetWinVersion();
    AddToLog(lgGeneral, ltInformation, Format(info_Start_OS_Version, [STR_WIN_VERSION[Version], Win32MajorVersion, Win32MinorVersion, Win32BuildNumber, Win32CSDVersion]));
    AddToLog(lgGeneral, ltInformation, Format(info_Start_Comp_Name, [GetCompName(), GetStrIPAddress(GetCompName())]));

    // Создадим вспомогательный объекты
    FModules := TModulesInfoList.Create();
    FConnectedAccount := TProfConnectedAccount.Create();
    FConnectedAccount.OnAddToLog := AddToLog;
    // Проверим что информация о модуле есть в настройках
    tmpModuleInfo := Modules.GetModuleInfoByName(GetCompName(), FProgram.ProgramName);
    if (tmpModuleInfo.Name = '')
    or (tmpModuleInfo.Host <> GetCompName())
    {or (tmpModuleInfo.ID <> FProgram.ProgramID)} then
    begin
      tmpModuleInfo.Name := FProgram.ProgramName;
      {tmpModuleInfo.ID := FProgram.ProgramID;}
      tmpModuleInfo.Host := GetCompName();
      tmpModuleInfo.Descr := FProgram.ProgramNameDisplay;
      Modules.AddModule(tmpModuleInfo);
    end;
    // Создадим объект событий
    FRaiseEvents := IDispatch(TEvents.Create(Self));
    // Загрузим настройки
    //SetupRecord.LoadParams();
    // Создадим таймер
    SetTimer(0, 0, FTimerInterval, nil);
    ReportStatus(SERVICE_START_PENDING);
    DoStarted();
    AddToLog(lgGeneral, ltInformation, Format(info_Started_Module, [FProgram.ProgramName]));
  except
    on E: Exception do
      ShowError(0, 'ServiceNT', 'Ошибка при инициализации сервиса: ' + E.Message);
  end;
end;

procedure TProfService.InstallInterface(Factory: TComObjectFactory);
var
  tmpClassID: string;
  tmpProgID: string;
  tmpFileName: string;
  tmpCatReg: ICatRegister;
  tmpCatInfo: TCATEGORYINFO;
begin
  if (Factory.Instancing = ciInternal) then Exit;
  try
    tmpClassID := GUIDToString(Factory.ClassID);
    tmpProgID := Factory.ProgID;
    tmpFileName := ParamStr(0);
    CreateRegKey('CLSID\' + tmpClassID, '', Factory.Description);
    if (not IsConsole) then
      CreateRegKey('CLSID\' + tmpClassID + '\LocalServer32', '', tmpFileName)
    else
      CreateRegKey('CLSID\' + tmpClassID + '\LocalServer32', '', '"' + tmpFileName + '"' + ' /console');
    CreateRegKey('CLSID\' + tmpClassID + '\ProgID', '', tmpProgID);
    CreateRegKey('CLSID\' + tmpClassID, 'AppID', tmpClassID);
    CreateRegKey(tmpProgID, '', Factory.Description);
    CreateRegKey(tmpProgID + '\Clsid', '', tmpClassID);
    if (not IsConsole) then
    begin
      CreateRegKey('AppID\' + tmpClassID, '', Factory.Description);
      CreateRegKey('AppID\' + tmpClassID, 'LocalService', FProgram.ProgramName);
    end;
  except
    on E: Exception do
      ShowErrorAndLog(E.Message);
  end;
  try
    // Регистрируем категорию
    OleCheck(CoCreateInstance(CLSID_StdComponentCategoryMgr, nil, CLSCTX_INPROC_SERVER, ICatRegister, tmpCatReg));
    tmpCatInfo.catid := CATID_ArAppServer;
    tmpCatInfo.lcid := $0409;
    StringToWideChar(Ar_CategoryComDesc_409, tmpCatInfo.szDescription, Length(Ar_CategoryComDesc_409) + 1);
    OleCheck(tmpCatReg.RegisterCategories(1, @tmpCatInfo));
    tmpCatInfo.lcid := $0419;
    StringToWideChar(Ar_CategoryComDesc_419, tmpCatInfo.szDescription, Length(Ar_CategoryComDesc_419) + 1);
    OleCheck(tmpCatReg.RegisterCategories(1, @tmpCatInfo));
    OleCheck(tmpCatReg.RegisterClassImplCategories(Factory.ClassID, 1, @CATID_ArAppServer));
  except
    on E: Exception do
      ShowErrorAndLog(E.Message);
  end;
end;

procedure TProfService.InstallService(AIsSilent: boolean);
var
  SvcMgr: Integer;
  Svc: Integer;
  sDesc: SERVICE_DESCRIPTION;
  tmpTypeLib: ITypeLib;
begin
  CoInitialize(nil);
  try
    // Проверим параметры
    if (FProgram.ProgramName = '') then
    begin
      if (not AIsSilent) then
        ShowErrorAndLog(err_Name_Not_Def);
      Exit;
    end;
    if (FProgram.ProgramNameDisplay = '') then
    begin
      if (not AIsSilent) then
        ShowErrorAndLog(err_DName_Not_Def);
      Exit;
    end;
    if (not IsConsole) then
    begin
      // Откроем менеджер сервисов
      SvcMgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
      if (SvcMgr = 0) then
      begin
        if (not AIsSilent) then
          ShowErrorAndLog(Format(err_Install_Open_SC, [FProgram.ProgramName, SysErrorMessage(GetLastError())]));
        Exit;
      end;
      try
        // Зарегистрируем сервис
        Svc := CreateServiceA(
            SvcMgr,                                                   // hSCManager: SC_HANDLE
            PAnsiChar(AnsiString(FProgram.ProgramName)),              // lpServiceName: PAnsiChar;
            PAnsiChar(AnsiString(FProgram.ProgramNameDisplay)),       // lpDisplayName: PAnsiChar;
            SERVICE_ALL_ACCESS,                                       // dwDesiredAccess: DWORD;
            SERVICE_WIN32_OWN_PROCESS or SERVICE_INTERACTIVE_PROCESS, // dwServiceType: DWORD;
            SERVICE_AUTO_START,                                       // dwStartType: DWORD;
            SERVICE_ERROR_NORMAL,                                     // dwErrorControl: DWORD;
            PAnsiChar(AnsiString(ParamStr(0))),                       // lpLoadOrderGroup: PAnsiChar;
            PAnsiChar(AnsiString(LOAD_GROUP)),                        // lpBinaryPathName: PAnsiChar;
            nil,                                                      // lpdwTagId: LPDWORD;
            PAnsiChar(AnsiString(FProgram.Dependencies)),             // lpDependencies: PAnsiChar
            nil,                                                      // lpPassword: PAnsiChar
            nil                                                       // lpServiceStartName: PAnsiChar
            );
      except
        Svc := 0;
      end;
      // Проверим результат
      if (Svc = 0) then
      begin
        if (not AIsSilent) then
          ShowErrorAndLog(Format(err_Install_Create_Sv, [FProgram.ProgramName, SysErrorMessage(GetLastError())]))
      end
      else
      begin
        // Зарегистрируем описание
        {$IFDEF UNICODE}
        sDesc.lpDescription := PWideChar(WideString(FProgram.ProgramDescription));
        {$ELSE}
        sDesc.lpDescription := PAnsiChar(AnsiString(FProgram.ProgramDescription));
        {$ENDIF}
        ChangeServiceConfig2(Svc, SERVICE_CONFIG_DESCRIPTION, @sDesc);
        CloseServiceHandle(Svc);
      end;
      // Закроем менеджер
      CloseServiceHandle(SvcMgr);
    end;
    // Инсталируем COM объекты
    LoadTypeLib(PWideChar(WideString(ParamStr(0))), tmpTypeLib);
    RegisterTypeLib(tmpTypeLib, PWideChar(WideString(ParamStr(0))), PWideChar(WideString(ExtractFilePath(ParamStr(0)))));
    ComClassManager.ForEachFactory(ComServer, InstallInterface);
  except
    on E: Exception do
      if (not AIsSilent) then
        ShowErrorAndLog(E.Message);
  end;
  CoUninitialize();
end;

procedure TProfService.UninstallInterface(Factory: TComObjectFactory);
var
  tmpClassID, tmpProgID: string;
  tmpCatReg: ICatRegister;
begin
  if (Factory.Instancing = ciInternal) then
    Exit;
  // Удалим унфу из категории
  try
    OleCheck(CoCreateInstance(CLSID_StdComponentCategoryMgr, nil, CLSCTX_INPROC_SERVER, ICatRegister, tmpCatReg));
    OleCheck(tmpCatReg.UnRegisterClassImplCategories(Factory.ClassID, 1, @CATID_ArAppServer));
  except
  end;
  // Из реестра
  try
    tmpClassID := GUIDToString(Factory.ClassID);
    tmpProgID := Factory.ProgID;
    DeleteRegKey('CLSID\' + tmpClassID + '\Implemented Categories');
    DeleteRegKey('CLSID\' + tmpClassID + '\LocalServer32');
    DeleteRegKey('CLSID\' + tmpClassID + '\ProgID');
    DeleteRegKey('CLSID\' + tmpClassID);
    DeleteRegKey(tmpProgID  + '\Clsid');
    DeleteRegKey(tmpProgID);
    if (not IsConsole) then
      DeleteRegKey('AppID\' + tmpClassID);
  except
  end;
end;

procedure TProfService.UnInstallService(AIsSilent: boolean);
type
  TUnregisterProc = function(const GUID: TGUID; VerMajor, VerMinor: Word; LCID: TLCID; SysKind: TSysKind): HResult stdcall;
var
  SvcMgr: Integer;
  Svc: Integer;
  Handle: THandle;
  UnregisterProc: TUnregisterProc;
  LibAttr: PTLibAttr;
begin
  CoInitialize(nil);
  try
    // Удалим COM интерфейсы
    ComClassManager.ForEachFactory(ComServer, UninstallInterface);
    Handle := GetModuleHandle('OLEAUT32.DLL');
    @UnregisterProc := GetProcAddress(Handle, 'UnRegisterTypeLib');
    ComServer.TypeLib.GetLibAttr(LibAttr);
    with LibAttr^ do
      UnregisterProc(guid, wMajorVerNum, wMinorVerNum, lcid, syskind);
    ComServer.TypeLib.ReleaseTLibAttr(LibAttr);
    // Проверим параметры
    if (FProgram.ProgramName = '') then
    begin
      if (not AIsSilent) then
        ShowErrorAndLog(err_Name_Not_Def);
      Exit;
    end;
    if (not IsConsole) then
    begin
      // Откроем менеджер сервисов
      SvcMgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
      if (SvcMgr = 0) then
      begin
        if (not AIsSilent) then
          ShowErrorAndLog(err_Delete_Open_SC); //[FProgram.ProgramName, SysErrorMessage(GetLastError())]);
        Exit;
      end;
      Svc := OpenService(SvcMgr, PChar(string(FProgram.ProgramName)), SERVICE_ALL_ACCESS);
      if (Svc = 0) then
      begin
        if (not AIsSilent) then
          ShowErrorAndLog(err_Delete_Open_Sv); //[FProgram.ProgramName, SysErrorMessage(GetLastError())])
      end else
      begin
        if (not DeleteService(Svc)) then
          if (not AIsSilent) then
            ShowErrorAndLog(err_Delete_Sv); //[FProgram.ProgramName, SysErrorMessage(GetLastError())]);
        CloseServiceHandle(Svc);
      end;
      // Закроем менеджер
      CloseServiceHandle(SvcMgr);
    end;
  except
    on E: Exception do
      if (not AIsSilent) then
        ShowErrorAndLog(E.Message);
  end;
  CoUninitialize();
end;

procedure TProfService.RunService();
begin
  ProfService_Run(Self);
end;

procedure TProfService.ShowErrorAndLog(const AStrMsg: WideString);
begin
  try
    AddToLog(lgGeneral, ltError, AStrMsg);
    ShowError(0, FProgram.ProgramName + ' : ' + err_Caption, AStrMsg);
  except
  end;
end;

procedure TProfService.ExecCmdStart(AIsSilent: boolean);
begin
  if (IsConsole) then
    Exit;
  // Проверим на регистрацию
  if (not IsServiceInstall(FProgram.ProgramName)) then
    InstallService(AIsSilent);
  // Проверим на запуск
  if (IsServiceRun(FProgram.ProgramName)) then
    Exit;
  // Запустим
  if not(AServiceUtils.StartService(FProgram.ProgramName)) then
    if not(AIsSilent) then
      ShowErrorAndLog(Format(err_Start_Sv, [FProgram.ProgramName, SysErrorMessage(GetLastError())]));
end;

function TProfService.Start: WordBool;
begin
  Result := DoStart();
  if Result then
    Result := DoStarted();
end;

procedure TProfService.StartService();
var
  tmpDispatchTable: array [0..1] of TServiceTableEntry;
  tmpArgv: array of PChar;
begin
  //Initialize();
  try
    if not(IsConsole) then
    begin
      tmpDispatchTable[0].lpServiceName := PChar(string(FProgram.ProgramName));
      tmpDispatchTable[0].lpServiceProc := @WServiceProc;
      tmpDispatchTable[1].lpServiceName := nil;
      tmpDispatchTable[1].lpServiceProc := nil;
      // Запускаем сервис
      StartServiceCtrlDispatcher(tmpDispatchTable[0]);
      // Дождемся корректного завершения
      if (FServiceProcHandle <> 0) then
      begin
        WaitForSingleObject(FServiceProcHandle, INFINITE);
        CloseHandle(FServiceProcHandle);
      end;
    end
    else
    begin
      SetLength(tmpArgv, 0);
      ServiceProc(0, tmpArgv);
    end;
  except
//    on E: Exception do
//      ShowError(0, 'ServiceNT', 'Ошибка при старте сарвиса: '+E.Message, []);
  end;
end;

function TProfService.Stop: WordBool;
begin
  Result := DoStop(False);
  if Result then
    Result := DoStoped(False);
end;

procedure TProfService.ServiceProc(argc: LongWord; var argv: array of PChar);
var
  tmpMsg: TMsg;
  tmpCoord: TCoord;
  tmpLongWord: LongWord;
  tmpFill: integer;
  tmpScrBufInfo: TConsoleScreenBufferInfo;
begin
  try
    try
      // Инициализируем ActiveX
      CoInitializeEx(nil, COINIT_MULTITHREADED);
      // Создадим консоль
      if IsConsole then
      begin
        AllocConsole();
        SetConsoleTitle(PChar(string(FProgram.ProgramName + ' (' + FormatFloat('000', FProgram.ProgramId) + ')')));
        tmpCoord.X := 0;
        tmpCoord.Y := 0;
        tmpLongWord := 0;
        SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), BACKGROUND_BLUE or BACKGROUND_GREEN or BACKGROUND_RED);
        GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), tmpScrBufInfo);
        tmpFill := tmpScrBufInfo.dwSize.X * tmpScrBufInfo.dwSize.Y;
        FillConsoleOutputCharacter(GetStdHandle(STD_OUTPUT_HANDLE) ,' ', tmpFill, tmpCoord, tmpLongWord);
        FillConsoleOutputAttribute(GetStdHandle(STD_OUTPUT_HANDLE), tmpScrBufInfo.wAttributes, tmpFill, tmpCoord, tmpLongWord);
        SetConsoleCtrlHandler(@ConsoleCtrlProc, True);
      end;
      // Говорим что у нас мультипотоковое приложение
      IsMultiThread := True;
      // Создаем очередь сообщений
      PeekMessage(tmpMsg, 0, WM_USER, WM_USER, PM_NOREMOVE);
      // Продублируем хендл для ожидания завершения
      if not(DuplicateHandle(GetCurrentProcess(), GetCurrentThread(), GetCurrentProcess(), @FServiceProcHandle, 0, True, DUPLICATE_SAME_ACCESS)) then
      begin
        ShowErrorAndLog(Format(err_Duplicate_Handle, [FProgram.ProgramName, SysErrorMessage(GetLastError())]));
        FServiceProcHandle := 0;
        Exit;
      end;
      // Получим ID потока
      InterlockedExchange(Integer(ServiceProcID), GetCurrentThreadId());
      // Инициализируем сервер COM
      ReportStatus(SERVICE_START_PENDING);
      if not(IsConsole) then
      try
        ComClassManager.ForEachFactory(ComServer, FactoryRegisterClassObject);
      except
        on E: Exception do
          AddToLog(lgGeneral, ltError, Format('%s <%s.%s>', [E.Message, ClassName, 'ServiceProc']));
      end;
      ReportStatus(SERVICE_START_PENDING);
      // Зарегистрируем обработчик событий
      if not(IsConsole) then
      begin
        FServiceStatusHandle := RegisterServiceCtrlHandlerEx(PChar(string(FProgram.ProgramName)), @WServiceCtrl, nil);
        if (FServiceStatusHandle = 0) then
        begin
          ShowErrorAndLog(Format(err_Reg_Svc_Handler, [FProgram.ProgramName, SysErrorMessage(GetLastError())]));
          Exit;
        end;
      end;
      ReportStatus(SERVICE_START_PENDING);
      // Инициализируем сервис
      InitService();
      ReportStatus(SERVICE_RUNNING);
      // Запускаем основной цикл
      while (True) do
        if GetMessage(tmpMsg, 0, 0, 0) then
        begin
          case tmpMsg.message of
            WM_TIMER:
              begin
                if Assigned(FProgram) then
                  FProgram.DoTime();
                //DoTimer();
              end;
            WM_STOP_USER:
              begin
                DoneService(False);
                Break;
              end;
            WM_STOP_SYSTEM:
              begin
                DoneService(True);
                Break;
              end;
            WM_REPORT_STATUS:
              ReportStatus(FServiceStatus.dwCurrentState);
          else
            TranslateMessage(tmpMsg);
            DispatchMessage(tmpMsg);
          end;
        end
        else
          Break;
      ReportStatus(SERVICE_STOP_PENDING);
    except
      on E: Exception do
        if IsConsole then
          ShowError(0, FProgram.ProgramName, E.Message)
        else
          raise;
    end;
  finally
    // Завершение работы
    ReportStatus(SERVICE_STOPPED);
    // Завершаем работу с ActiveX
    CoUninitialize();
    // Завершим поток
    if IsConsole then
      ExitProcess(0)
    else
      ExitThread(0);
  end;
end;

procedure TProfService.ReportStatus(lCurrentState: LongWord);
begin
  EnterCriticalSection(FCSReportStatus);
  try
    with FServiceStatus do
    begin
      dwCurrentState := lCurrentState;
      dwServiceType := SERVICE_WIN32_OWN_PROCESS;
      dwControlsAccepted := SERVICE_ACCEPT_SHUTDOWN or
                            SERVICE_ACCEPT_STOP;
      dwWin32ExitCode := 0;
      dwServiceSpecificExitCode := 0;
      if dwCurrentState in [SERVICE_START_PENDING, SERVICE_STOP_PENDING] then
        Inc(dwCheckPoint)
      else
        dwCheckPoint := 0;
      dwWaitHint := 10000;
    end;
    if (FServiceStatusHandle <> 0)and(not IsConsole) then
      SetServiceStatus(FServiceStatusHandle, FServiceStatus);
  finally
    LeaveCriticalSection(FCSReportStatus);
  end;
end;

function TProfService.ServiceCtrl(dwControl: LongWord; dwEventType: LongWord; lpEventData: pointer; lpContext: pointer): LongWord;
begin
  Result := 0;
  case dwControl of
    SERVICE_CONTROL_CONTINUE:              ; // рестарт после паузы (не обрабатывается)
    SERVICE_CONTROL_PAUSE:                 ; // пауза (не обрабатывается)
    SERVICE_CONTROL_INTERROGATE:           PostThreadMessage(ServiceProcID, WM_REPORT_STATUS, 0, 0); // сообщить статус
    SERVICE_CONTROL_SHUTDOWN:              PostThreadMessage(ServiceProcID, WM_STOP_SYSTEM, 0, 0); // завершение работы системы
    SERVICE_CONTROL_STOP:                  PostThreadMessage(ServiceProcID, WM_STOP_USER, 0, 0); // стоп
    SERVICE_CONTROL_HARDWAREPROFILECHANGE: ;
    SERVICE_CONTROL_POWEREVENT:            ;
    SERVICE_CONTROL_DEVICEEVENT:           ;
  end;
end;

procedure TProfService.WriteToConsole(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string);

  function GetRusStrA(const AStr: AnsiString): AnsiString;
  begin
    SetLength(Result, Length(AStr));
    CharToOemA(PAnsiChar(AStr), PAnsiChar(Result));
  end;

  function GetRusStr(const AStr: string): string;
  begin
    Result := string(GetRusStrA(AnsiString(AStr)));
  end;

var
  S: string;
begin
  if IsConsole then
  try
    case AType of
      ltError:
        SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), BACKGROUND_BLUE or BACKGROUND_GREEN or BACKGROUND_RED or FOREGROUND_RED);
      ltWarning:
        SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), BACKGROUND_BLUE or BACKGROUND_GREEN or BACKGROUND_RED or FOREGROUND_RED or FOREGROUND_GREEN);
      ltInformation:
        SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), BACKGROUND_BLUE or BACKGROUND_GREEN or BACKGROUND_RED or FOREGROUND_BLUE);
    else
      SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), BACKGROUND_BLUE or BACKGROUND_GREEN or BACKGROUND_RED);
    end;
    S := FormatDateTime('hh:nn:ss:zzz', Now()) + ' [' + CHR_LOG_GROUP_MESSAGE[AGroup] + '] ' + GetRusStr(AStrMsg);
    WriteLn(S);
  except
  end;
end;

end.



