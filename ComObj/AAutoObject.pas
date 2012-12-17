{**
@Abstract Объект подключения клиента. Создается автоматический системой для каждого клиента
@Author Prof1983 <prof1983@ya.ru>
@Created 25.04.2006
@LastMod 17.12.2012
}
unit AAutoObject;

interface

uses
  ActiveX, AxCtrls, Classes, ComObj, Messages, SysUtils, Variants, Windows, WinSock, WinSvc,
  AProgramImpl, ATypes;

type
  {**
    @abstract(Объект подключения клиента)
    Создается автоматический системой для каждого клиента
    и добавляется к TServiceX.ClientList.
  }
  TProfAutoObject = class(TAutoObject, IConnectionPointContainer)
  private
    FEvents: IUnknown;
    FClientID: Integer;
    FClientName: WideString;
    FClientAccount: WideString;
    FClientHost: WideString;
    FConnectionPoint: TConnectionPoint;
    FConnectionPoints: TConnectionPoints;
    FRaiseEvents: Variant;
    FSinkList: TList;
  protected
    FProgram: TProfProgram;
  protected
    procedure EventSinkChanged(const EventSink: IUnknown); override;
    property ConnectionPoints: TConnectionPoints read FConnectionPoints implements IConnectionPointContainer;
  protected
    procedure RegisterClient(AClientID: Integer; const AClientName: WideString); safecall;
    function Get_SystemName(): WideString; safecall;
    function Get_ObjectGlobalID(): WideString; safecall;
    function Get_ObjectOwnerName(): WideString; safecall;
    function Get_OrgOwnerName(): WideString; safecall;
    function Get_ModuleName(): WideString; safecall;
    function Get_ModuleDescription(): WideString; safecall;
    function Get_ModuleID(): WideString; safecall;
    function Get_ModuleVersion(): WideString; safecall;
    function Get_DateStartWork(): TDateTime; safecall;
    function Get_TimeWork(): Integer; safecall;
  public
    destructor Destroy(); override;
    procedure Initialize(); override;
  public
    // Срабатывает при возникновении исключения
    function SafeCallException(ExceptObject: TObject; ExceptAddr: Pointer): HResult; override;
    // Добавление записи в лог (см. unGlobals.TAddToLog)
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; virtual; safecall;
  public
    property AutoFactory;
    property Events: Variant read FRaiseEvents;
  public
    //** Уникальный номер клиента
    property ClientID: Integer read FClientID;
    //** Наименование клиента
    property ClientName: WideString read FClientName;
    //** Аккаунт под которым работает клиент
    property ClientAccount: WideString read FClientAccount;
    //** Хост на котором работает клиент
    property ClientHost: WideString read FClientHost;
    //** Программа владелец
    property Prog: TProfProgram read FProgram;
  end;

implementation

resourcestring
  info_InitConnectClent = '--> Инициализация подключения клиента.';
  info_ConnectClent     = 'Подключение клиента "%s" к интерфейсу "%s".';
  into_DisconnectClient = '--> Отключение клиента "%s" от интерфейса "%s".';
  into_RegisterClient   = 'Клиент зарегистрировался: id - "%d", name - "%s".';

  err_ErrorClientType    = 'Неизвестный тип клиента.';
  err_ImpersonateClient  = 'Ошибка имперсонации клиента.';
  err_OleAutoErrorEx     = 'ОШИБКА: msg - "%s", code - "%s", class - "%s", exception - "%s".';
  err_OpenToken          = 'Ошибка открытия токена потока: msg - "%s".';
  err_GetTokenInfo       = 'Ошибка получения информации токена: msg - "%s".';
  err_Not_ModifyObject   = 'Объект открыт только для чтения!';
  err_GetUserInfo        = 'Ошибка получения информации пользователя: msg - "%s".';
  err_MaxAccount         = 'Превышено максимальное количество подключений: "%d".';

type
  //** @abstract(Вспомогательный обьект для работы с событиями)
  TEvents = class(TInterfacedObject, IUnknown, IDispatch)
  private
    FController: TProfAutoObject;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
  public
    constructor Create(Controller: TProfAutoObject);
  end;

{ TProfAutoObject }

function TProfAutoObject.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  Result := FProgram.AddToLog(AGroup, AType, AStrMsg);
end;

function TProfAutoObject.SafeCallException(ExceptObject: TObject; ExceptAddr: Pointer): HResult;
begin
  if (ExceptObject is EOleException) then
  begin
    AddToLog(lgGeneral, ltError, err_OleAutoErrorEx); //[EOleException(ExceptObject).Message, '$' + IntToHex(EOleException(ExceptObject).ErrorCode, 8), ClassName, ExceptObject.ClassName]);
  end else
  if (ExceptObject is Exception) then
  begin
    AddToLog(lgGeneral, ltError, err_OleAutoErrorEx); //[(ExceptObject as Exception).Message, 0, ClassName, ExceptObject.ClassName]);
  end;
  Result := inherited SafeCallException(ExceptObject, ExceptAddr);
end;

procedure TProfAutoObject.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink;
  if (FConnectionPoint <> nil) then
     FSinkList := FConnectionPoint.SinkList;
end;

procedure TProfAutoObject.Initialize();
type
  TSidAndAttributes = packed record
    Sid: PSID;
    Attributes: DWORD;
  end;
  TTokenUser = packed record
    User: TSidAndAttributes;
  end;
var
  tmpLen: LongWord;
  tknHandle: Windows.THandle;
  tmpBuffer: pointer;
  tmpName: array[0..200]of char;
  tmpDomain: array[0..200]of char;
  tmpSizeName: LongWord;
  tmpSizeDomain: LongWord;
  tmpUse: LongWord;
begin
  inherited;
  FProgram := TProfProgram.GetInstance();
  {while (ServiceNT.ServiceStatus.dwCurrentState = SERVICE_START_PENDING) do
    Sleep(10);}
  try
    AddToLog(lgNetwork, ltInformation, info_InitConnectClent);
    FClientID := 0;
    FClientName := 'unknown';
    GetMem(tmpBuffer, 100);
    tmpSizeName := SizeOf(tmpName);
    tmpSizeDomain := SizeOf(tmpDomain);
    try
      if (CoImpersonateClient() <> S_OK) then
      begin
        raise Exception.Create(err_ImpersonateClient);
      end;
      if (not OpenThreadToken(GetCurrentThread(), TOKEN_QUERY, True, tknHandle)) then
        raise Exception.CreateFmt(err_OpenToken, [SysErrorMessage(GetLastError())]);
      try
        if (not GetTokenInformation(tknHandle, TokenUser, tmpBuffer, 100, tmpLen)) then
          raise Exception.CreateFmt(err_GetTokenInfo, [SysErrorMessage(GetLastError())]);
        if (CoRevertToSelf() <> S_OK) then
          raise Exception.Create(err_ImpersonateClient);
        if (not LookupAccountSid(nil, TTokenUser(tmpBuffer^).User.Sid, tmpName, tmpSizeName, tmpDomain, tmpSizeDomain, tmpUse)) then
          raise Exception.CreateFmt(err_GetUserInfo, [SysErrorMessage(GetLastError())]);
        if (AnsiUpperCase(tmpDomain) = 'NT AUTHORITY') then
        begin
          FClientHost := ''; //AnsiUpperCase(GetCompName());
          FClientAccount := FClientHost + '\' + tmpName;
        end else
        begin
          FClientHost := tmpDomain;
          FClientAccount := FClientHost + '\' + tmpName;
        end;
      finally
        CloseHandle(tknHandle);
      end;
    finally
      FreeMem(tmpBuffer, 100);
    end;
    // Проверяем на максимальное количество пользователей
    {with ServiceNT.ConnectedAccount do
    begin
      if (not IsExists(ClientAccount)) then
        if (Count >= ServiceNT.MaxClientAccount) then
          raise Exception.CreateFmt(err_MaxAccount, [ServiceNT.MaxClientAccount]);
      Add(ClientAccount);
    end;}
    // Для событий
    FConnectionPoints := TConnectionPoints.Create(Self);
    if (AutoFactory.EventTypeInfo <> nil) then
      FConnectionPoint := FConnectionPoints.CreateConnectionPoint(AutoFactory.EventIID, ckSingle, EventConnect)
    else
      FConnectionPoint := nil;

    // все ОК
    //AddToLog(lgNetwork, ltInformation, info_ConnectClent, [ClientAccount, STR_CLIENT_TYPE[ClientType]]);
    //ServiceNT.ClientList.Add(Self);
  except
    on E: Exception do
    begin
      AddToLog(lgNetwork, ltError, E.Message);
      raise;
    end;
  end;
end;

destructor TProfAutoObject.Destroy();
{var
  tmpList: TList;
  tmpIsConnected: boolean;}
begin
  // Определим что клиент был подключен
  {tmpList := ServiceNT.ClientList.LockList();
  try
    tmpIsConnected := (tmpList.IndexOf(Self) >= 0);
  finally
    ServiceNT.ClientList.UnlockList();
  end;
  // Если клиент был подключен
  if (tmpIsConnected) then
  begin
    // Удалим себя из списка
    ServiceNT.ClientList.Remove(Self);
    // Пошлем событие
    ServiceNT.Events.OnChangeClientsList(ClientHost, ClientAccount, Ord(ClientType), ClientID, ClientName);
    // Прологируем
    AddToLog(lgNetwork, ltInformation, into_DisconnectClient, [ClientAccount, STR_CLIENT_TYPE[ClientType]]);
  end;
  // Удалим аккаунт из списка
  ServiceNT.ConnectedAccount.Delete(ClientAccount);}
  // Отключим события
  FRaiseEvents := Null;
  inherited;
end;

procedure TProfAutoObject.RegisterClient(AClientID: Integer; const AClientName: WideString);
begin
  FClientID := AClientID;
  FClientName := AClientName;
  // Прологируем
  AddToLog(lgNetwork, ltInformation, into_RegisterClient); //[ClientID, ClientName]);
  // Пошлем событие
  {ServiceNT.Events.OnChangeClientsList(ClientHost, ClientAccount, Ord(ClientType), ClientID, ClientName);}
end;

function TProfAutoObject.Get_SystemName(): WideString;
begin
  Result := WideString(Self.FProgram.SystemName);
end;

function TProfAutoObject.Get_ObjectGlobalID(): WideString;
begin
  //Result := Self.ProgramNT.ObjectGlobalID;
  Result := '';
end;

function TProfAutoObject.Get_ObjectOwnerName(): WideString;
begin
  Result := Self.FProgram.ObjectOwnerName;
end;

function TProfAutoObject.Get_OrgOwnerName(): WideString;
begin
  Result := Self.FProgram.OrgOwnerName;
end;

function TProfAutoObject.Get_ModuleName(): WideString;
begin
  Result := Self.FProgram.ProgramName;
end;

function TProfAutoObject.Get_ModuleDescription(): WideString;
begin
  Result := Self.FProgram.ProgramDescription;
end;

function TProfAutoObject.Get_ModuleID(): WideString;
begin
  //Result := Self.ProgramNT.ProgramID;
  Result := '';
end;

function TProfAutoObject.Get_ModuleVersion(): WideString;
begin
  //Result := Self.ProgramNT.ProgramVersionStr;
  Result := '';
end;

function TProfAutoObject.Get_DateStartWork(): TDateTime;
begin
  Result := Self.FProgram.DateStart;
end;

function TProfAutoObject.Get_TimeWork(): Integer;
begin
  Result := Self.FProgram.TimeWork;
end;

{ TEvents }

constructor TEvents.Create(Controller: TProfAutoObject);
begin
  inherited Create;
  FController := Controller;
end;

function TEvents.Invoke(DispID: integer; const IID: TGUID; LocaleID: integer; Flags: Word; var Params; VarResult,ExcepInfo,ArgErr:Pointer): HRESULT;
begin
  if Assigned(FController.FEvents) then
    Result := IDispatch(FController.FEvents).Invoke(DispID, IID, LocaleID, Flags, Params, VarResult, ExcepInfo, ArgErr)
  else
    Result := E_NOTIMPL;
end;

function TEvents.QueryInterface(const IID: TGUID; out Obj): HRESULT;
begin
  if Assigned(FController.FEvents) then
    Result := IDispatch(FController.FEvents).QueryInterface(IID, Obj)
  else
    Result := E_NOINTERFACE;
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
begin
  if (FController.AutoFactory.EventTypeInfo <> nil) then
    Result := FController.AutoFactory.EventTypeInfo.GetIDsOfNames(Names, NameCount, DispIDs)
  else
    Result := E_NOTIMPL;
end;

end.
