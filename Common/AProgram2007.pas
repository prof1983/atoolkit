{**
@Abstract(Реализация основной функциональности для главного объекта)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.05.2006)
@LastMod(25.05.2012)
@Version(0.5)
}
unit AProgram2007;

// TODO: Use AProgramImpl

interface

uses
  ActiveX, Classes, ComObj, ComServ, Messages, SysUtils, Windows, WinSock, WinSvc, XmlIntf,
  AConsts2, ALogDocumentIntf, ALogDocuments2007, AObjectImpl, AProgramUtils, ATypes, AXml3;

type // Основной объект программы
  TProgram2007 = class(TProfObject2{TProfObject2})
  private
      // Критическая секция для добавления в лог
    FCSAddToLog: TRTLCriticalSection;
    FDataDirectoryPath: string;
    FExeFullName: WideString;
    FExeName: WideString;
    FExePath: WideString;
    FFileVersionInfo: TFileVersionInfo;
  protected
    FDependencies: WideString;
    FObjectGlobalID: Integer;
    FObjectOwnerName: WideString;
    FOrgOwnerName: WideString;
    FProgramDescription: WideString;
    FProgramID: LongWord;
    FProgramName: WideString;
    FProgramNameDisplay: WideString;
    FProgramVersion: WideString;
    FSystemName: WideString;
    FTimerInterval: LongWord;
  private
    function GetTimeWork(): Integer;
  private
    FIsConsole: Boolean;
    FIsDebug: Boolean;
    //FIsDemo: Boolean;
    FIsSilent: Boolean;
    FIsSplash: Boolean;
    FIsTeach: Boolean;
    FIsTest: Boolean;
  protected
    FConfigDocument: IXmlDocument;
    FConfigFileName: WideString;
    FConfigInitialize: Boolean;
    FDateStart: TDateTime;
    FIsComServer: Boolean;
    FIsService: Boolean;
    FMaxClientAccount: Integer;
    FLogDocuments: ILogDocuments2;

    FGlbTypeLib: ITypeLib;
    FSrvTypeLib: ITypeLib;

    function GetIsDemo(): Boolean; virtual;
    procedure SetIsDemo(Value: Boolean); virtual;
  protected
    //** Срабатывает при добавлении записи в лог
    function DoAddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; virtual;
    //** Срабатывает, когда нужно выполнить внешнюю команду. см. TProcMessageStr
    function DoCommand(const AMsg: WideString): WordBool; override; safecall;
    //** Срабатывает при создании объекта
    procedure DoCreate(); override; safecall;
    procedure DoCreated(); override; safecall;
    //** Срабатывает при уничтожении объекта
    procedure DoDestroy(); override; safecall;
    //** Срабатывает при финализации
    function DoFinalize(): WordBool; override; safecall;
    //** Срабатывает после успешной финализации
    function DoFinalized(): WordBool; override; safecall;
    //** Срабатывает при инициализации
    function DoInitialize(): WordBool; override; safecall;
    //** Срабатывает при начале запуска
    function DoStart(): WordBool; override; safecall;
    //** Срабатывает после удачного запуска
    function DoStarted(): WordBool; override; safecall;
    //** Срабатывает при начале процедуры остановки
    function DoStop(AIsShutDown: WordBool): WordBool; override; safecall;
    //** Срабатывает при завершении процедуры остановки
    function DoStoped(AIsShutDown: WordBool): WordBool; override; safecall;
    //** Срабатывает при событии таймера
    function DoTimer(): WordBool; virtual; safecall;
  public
    //** Добавление записи в лог
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Boolean; override;
    procedure AfterConstruction(); override;
    constructor Create(); override;
    procedure Free(); override;
    function GetDataDirectoryPath(): string;
    class function GetInstance(): TProgram2007;
    //** Добавление записи в лог
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; override;
    //function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; override;
  public
    class procedure DoneProgram(); virtual;
    //** Финализировать программу
    function Finalize(): TProfError; override;
    //** Инициализировать программу
    function Initialize(): TProfError; override;
  public
    //** Конфигурации программы
    property ConfigDocument: IXmlDocument read FConfigDocument;
    //** Имя файла конфигураций
    property ConfigFileName: WideString read FConfigFileName write FConfigFileName;
    property DataDirectoryPath: string read FDataDirectoryPath write FDataDirectoryPath;
    //** Время запуска сервиса
    property DateStart: TDateTime read FDateStart;
    //** Зависимости от других сервисов
    property Dependencies: WideString read FDependencies write FDependencies;
    //** Выполнить событие тайм
    function DoTime(): WordBool; safecall;
    //** Полный путь и имя фийла "C:\AR\BIN\Modules\AR_Core.exe"
    property ExeFullName: WideString read FExeFullName;
    //** Имя файла "AR_Core.exe"
    property ExeName: WideString read FExeName;
    //** Путь расположения программы "C:\AR\BIN\Modules\"
    property ExePath: WideString read FExePath;
    //** Информация прошитая в файле
    property FileVersionInfo: TFileVersionInfo read FFileVersionInfo;
    //** Максимальное число клиентов
    property MaxClientAccount: Integer read FMaxClientAccount default 100;
    //** Класс, объединяющий вывод логов сразу в несколько мест
    property LogDocuments: ILogDocuments2 read FLogDocuments;
    //** Глобальный ID объекта - владельца
    property ObjectGlobalID: Integer read FObjectGlobalID write FObjectGlobalID;
    //** Название объекта - владельца
    property ObjectOwnerName: WideString read FObjectOwnerName write FObjectOwnerName;
    //** Название организации - владельца
    property OrgOwnerName: WideString read FOrgOwnerName write FOrgOwnerName;
    //** Уникальный номер модуля
    property ProgramID: LongWord read FProgramID write FProgramID;
    //** Системное имя программы (сервиса) (имя файла баз расширения)
    property ProgramName: WideString read FProgramName;
    //** Описание сервиса
    property ProgramDescription: WideString read FProgramDescription write FProgramDescription;
    //** Имя сервиса для отображения
    property ProgramNameDisplay: WideString read FProgramNameDisplay write FProgramNameDisplay;
    //** Версия программы
    property ProgramVersion: WideString read FProgramVersion;
    //** Системное имя
    property SystemName: WideString read FSystemName write FSystemName;
    //** Время срабатывания таймера (в мс)
    property TimerInterval: LongWord read FTimerInterval write FTimerInterval;
    //** Время непрерывной работы в минутах
    property TimeWork: Integer read GetTimeWork;
  public
    //** Глобальная библиотека типов AR
    property GlbTypeLib: ITypeLib read FGlbTypeLib;
    //** Библиотека типов данного приложения
    property SrvTypeLib: ITypeLib read FSrvTypeLib;
  published // Глобальные свойства программы
    //** Программа является COM сервером
    property IsComServer: Boolean read FIsComServer default False;
    //** Консольный вид программы
    property IsConsole: Boolean read FIsConsole default False;
    //** Режим отладки - выводить все сообщения, логировать все события
    property IsDebug: Boolean read FIsDebug write FIsDebug default False;
    //** Демо режим (ключ защиты не найден)
    property IsDemo: Boolean read GetIsDemo write SetIsDemo default True;
    //** Признак, что программа в данный момент запущена как сервис
    property IsService: Boolean read FIsService;
    //** Тихий (автономный) режим - не выводить запросов
    property IsSilent: Boolean read FIsSilent write FIsSilent default False;
    //** Показывать заставку при старте и завершении программы
    property IsSplash: Boolean read FIsSplash write FIsSplash default True;
    //** Режим обучения (выводить подробные подсказки по функциям)
    property IsTeach: Boolean read FIsTeach write FIsTeach default False;
    //** Признак режима тестирования
    property IsTest: Boolean read FIsTest write FIsTest default False;
  end;
  //TProgram = TProgram2007;

implementation

var
  Prog: TProgram2007;

{ TProgram }

function TProgram2007.AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: string; AParams: array of const): Boolean;
begin
  Result := (ToLog(AGroup, AType, AStrMsg, AParams) >= 0);
end;

procedure TProgram2007.AfterConstruction();
begin
  inherited AfterConstruction();
  // ...
end;

constructor TProgram2007.Create();
begin
  FConfigDocument := nil;
  FLogDocuments := nil;
  FGlbTypeLib := nil;
  FSrvTypeLib := nil;
  inherited Create();

  //DoCreate();
  //DoCreated();
end;

function TProgram2007.DoAddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
begin
  if Assigned(FLogDocuments) then
    Result := FLogDocuments.ToLogA(AGroup, AType, Format(AStrMsg, AParams))
  else
    Result := -1;
end;

function TProgram2007.DoCommand(const AMsg: WideString): WordBool;
begin
  //Result := inherited DoCommand(AMsg);
end;

procedure TProgram2007.DoCreate();
begin
  inherited DoCreate();

  // В виде консоли
  FIsConsole := FindCmdLineSwitch(STR_SWITCH[sConsole], ['-','/'], True);
  // Режим отладки
  FIsDebug := FindCmdLineSwitch(STR_SWITCH[sDebug], ['-','/'], True);
  // Тихий (автономный) режим
  FIsSilent := FindCmdLineSwitch(STR_SWITCH[sSilent], ['-','/'], True);
  // Показывать заставку при старте и завершении програмы
  FIsSplash := not(FindCmdLineSwitch(STR_SWITCH[sNoSplash], ['-','/'], True));
  // Режим обучения
  FIsTeach := FindCmdLineSwitch(STR_SWITCH[sTeach], ['-','/'], True);

  FExeFullName := ParamStr(0);
  FExeName := ExtractFileName(FExeFullName);
  FExePath := ExtractFilePath(FExeFullName);

  FDataDirectoryPath := ExpandFileName(FExePath + '..\Data\');

  FProgramName := ChangeFileExt(FExeName, '');
  FProgramNameDisplay := FProgramName;
  FTimerInterval := 1000;

  FDateStart := Now;

  FFileVersionInfo := AProgramUtils.GetProgramVersionInfo(FExeFullName);
  FProgramVersion := FFileVersionInfo.FileVersion;

  Prog := Self;

  InitializeCriticalSection(FCSAddToLog);

  if FIsComServer and Assigned(ComServer) then
  try // Здесь возникнет Exception, если программа не является COM объектом. Создайте и присоедините TLB.
    FSrvTypeLib := ComServer.TypeLib;
  except
  end;
end;

procedure TProgram2007.DoCreated();
var
  doc: TProfXmlDocument3;
begin
  CoInitialize(nil);
  inherited DoCreated();
  // Создать конфигурации программы
  if not(Assigned(FConfigDocument)) then
  try
    if Self.ConfigFileName = '' then
      Self.ConfigFileName := Self.ExePath + Self.ProgramName + '.' + FILE_EXT_CONFIG;
    doc := TProfXmlDocument3.Create(Self.ConfigFileName, 'Config', AddToLog);
    doc.Initialize();
    //doc.DocumentElement.Attributes['app'] := Self.ProgramName;
    FConfigDocument := doc.Controller;
    FConfigInitialize := True;
    Self.FConfig := FConfigDocument.DocumentElement;
  except
    FConfigDocument := nil;
  end;
end;

procedure TProgram2007.DoDestroy();
begin
  DeleteCriticalSection(FCSAddToLog);
  inherited DoDestroy();
end;

function TProgram2007.DoFinalize(): WordBool;
begin
  Result := inherited DoFinalize();
end;

function TProgram2007.DoFinalized(): WordBool;
begin
  {if Assigned(FLogDocuments) then
  try
    FLogDocuments.Finalize();
    FLogDocuments.Free();
  finally
    FLogDocuments := nil;
  end;}

  // Сохраняем конфигурации программы
  if FConfigInitialize and Assigned(FConfigDocument) then
  try
    //TProfXmlDocument3.Normalize();
    FConfigDocument.SaveToFile('');
  finally
    try
      FConfigDocument := nil;
    except
    end;
  end;
  Result := inherited DoFinalized();
end;

function TProgram2007.DoInitialize(): WordBool;
begin
  Result := inherited DoInitialize();
  if not(Assigned(FLogDocuments)) then
  try
    FLogDocuments := TLogDocuments.Create();
  except
  end;
end;

class procedure TProgram2007.DoneProgram();
begin
  if Assigned(Prog) then
  try
    Prog.Finalize();
    Prog.Free();
  finally
    Prog := nil;
  end;
end;

function TProgram2007.DoStart(): WordBool;
begin
  Result := inherited DoStart();
end;

function TProgram2007.DoStarted(): WordBool;
begin
  Result := inherited DoStarted();
end;

function TProgram2007.DoStop(AIsShutDown: WordBool): WordBool;
begin
  Result := inherited DoStop(AIsShutDown);
end;

function TProgram2007.DoStoped(AIsShutDown: WordBool): WordBool;
begin
  Result := inherited DoStoped(AIsShutDown);
end;

function TProgram2007.DoTime(): WordBool;
begin
  Result := DoTimer();
end;

function TProgram2007.DoTimer(): WordBool;
begin
  Result := True;
end;

function TProgram2007.Finalize(): TProfError;
begin
  Result := inherited Finalize();
end;

procedure TProgram2007.Free();
begin
  DoDestroy();

  Prog := nil;
  //inherited Free();
end;

function TProgram2007.GetDataDirectoryPath: string;
begin
  Result := FDataDirectoryPath;
end;

class function TProgram2007.GetInstance(): TProgram2007;
begin
  Result := Prog;
end;

function TProgram2007.GetIsDemo(): Boolean;
begin
  Result := True;
end;

function TProgram2007.GetTimeWork(): Integer;
begin
  Result := Round((Now - FDateStart) * 24 * 60);
end;

function TProgram2007.Initialize(): TProfError;
begin
  AddToLog(lgGeneral, ltInformation, 'Инициализация программы');
  Result := inherited Initialize();
  AddToLog(lgGeneral, ltInformation, 'Программа инициализирована');
end;

procedure TProgram2007.SetIsDemo(Value: Boolean);
begin
end;

function TProgram2007.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
begin
  EnterCriticalSection(FCSAddToLog);
  Result := DoAddToLog(AGroup, AType, AStrMsg, AParams);
  LeaveCriticalSection(FCSAddToLog);
end;

end.



