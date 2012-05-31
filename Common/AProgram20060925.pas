{**
@Abstract(Реализация основной функциональности для главного объекта)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.05.2006)
@LastMod(02.05.2012)
@Version(0.5)
}
unit AProgram20060925;

interface

uses
  ActiveX, Classes, ComObj, ComServ, Messages, SysUtils, Windows, WinSock, WinSvc,
  AConfig2007, AConsts2, ALogDocuments2006, ALogObj, ATypes;

type //** Основной объект сервиса
  TProgram = class(TLoggerObject)
  private
    FCSAddToLog: TRTLCriticalSection; // Критическая секция для добавления в лог
    FDependencies: WideString;
    FExeFullName: WideString;
    FExeName: WideString;
    FExePath: WideString;
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
    FConfigDocument: TConfigDocument1;
    FDateStart: TDateTime;
    FLogDocuments: TLogDocuments;

    FGlbTypeLib: ITypeLib;
    FSrvTypeLib: ITypeLib;
    FStdTypeLib: ITypeLib;

    function GetIsDemo(): Boolean; virtual;
    procedure SetIsDemo(Value: Boolean); virtual;
  protected
    // Срабатывает при добавлении записи в лог
    function DoAddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer; virtual;
    // Срабатывает, когда нужно выполнить внешнюю команду. см. TProfMessage
    function DoCommand(const AMsg: WideString): WordBool; virtual;
    procedure DoCreate(); virtual;
    procedure DoDestroy(); virtual;
    // Срабатывает при начале запуска
    function DoStart(): WordBool; virtual;
    // Срабатывает после удачного запуска
    function DoStarted(): WordBool; virtual;
    // Срабатывает при начале процедуры остановки
    function DoStop(AIsShutDown: WordBool): WordBool; virtual;
    // Срабатывает при завершении процедуры остановки
    function DoStoped(AIsShutDown: WordBool): WordBool; virtual;
    // Срабатывает при событии таймера
    function DoTimer(): WordBool; virtual;
  public
    // Добавление записи в лог
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Boolean; override;
    constructor Create(); virtual;
    procedure Free(); virtual;
    class function GetInstance(): TProgram;
    // Добавление записи в лог
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer; virtual;
  public
    // Финализировать программу
    function Finalize(): WordBool;
    // Инициализировать программу
    function Initialize(): WordBool; 
  public
    // Конфигурации программы
    property ConfigDocument: TConfigDocument1 read FConfigDocument;
    // Время запуска сервиса
    property DateStart: TDateTime read FDateStart;
    // Зависимости от других сервисов
    property Dependencies: WideString read FDependencies write FDependencies;
    // Полный путь и имя фийла "C:\AR\BIN\Modules\AR_Core.exe"
    property ExeFullName: WideString read FExeFullName;
    // Имя файла "AR_Core.exe"
    property ExeName: WideString read FExeName;
    // Путь расположения программы "C:\AR\BIN\Modules\"
    property ExePath: WideString read FExePath;
    // Класс, объединяющий вывод логов сразу в несколько мест
    property LogDocuments: TLogDocuments read FLogDocuments;
    // Глобальный ID объекта - владельца
    property ObjectGlobalID: Integer read FObjectGlobalID write FObjectGlobalID;
    // Название объекта - владельца
    property ObjectOwnerName: WideString read FObjectOwnerName write FObjectOwnerName;
    // Название организации - владельца
    property OrgOwnerName: WideString read FOrgOwnerName write FOrgOwnerName;
    // Уникальный номер модуля
    property ProgramID: LongWord read FProgramID write FProgramID;
    // Системное имя программы (сервиса) (имя файла баз расширения)
    property ProgramName: WideString read FProgramName;
    // Описание сервиса
    property ProgramDescription: WideString read FProgramDescription write FProgramDescription;
    // Имя сервиса для отображения
    property ProgramNameDisplay: WideString read FProgramNameDisplay write FProgramNameDisplay;
    // Версия программы
    property ProgramVersion: WideString read FProgramVersion;
    // Системное имя
    property SystemName: WideString read FSystemName write FSystemName;
    // Время срабатывания таймера (в мс)
    property TimerInterval: LongWord read FTimerInterval write FTimerInterval;
    // Время непрерывной работы в минутах
    property TimeWork: Integer read GetTimeWork;
    //property MaxClientAccount: Integer read GetMaxClientAccount;
  public
    property GlbTypeLib: ITypeLib read FGlbTypeLib; // Глобальная библиотека типов AR
    property SrvTypeLib: ITypeLib read FSrvTypeLib; // Библиотека типов данного приложения
    property StdTypeLib: ITypeLib read FStdTypeLib; // Стандартная библиотека типов
  published // Глобальные свойства программы
    // Консольный вид программы
    property IsConsole: Boolean read FIsConsole default False;
    // Режим отладки - выводить все сообщения, логировать все события
    property IsDebug: Boolean read FIsDebug write FIsDebug default False;
    // Демо режим (ключ защиты не найден)
    property IsDemo: Boolean read GetIsDemo write SetIsDemo default True;
    // Тихий (автономный) режим - не выводить запросов
    property IsSilent: Boolean read FIsSilent write FIsSilent default False;
    // Показывать заставку при старте и завершении программы
    property IsSplash: Boolean read FIsSplash write FIsSplash default True;
    // Режим обучения (выводить подробные подсказки по функциям)
    property IsTeach: Boolean read FIsTeach write FIsTeach default False;
    // Признак режима тестирования
    property IsTest: Boolean read FIsTest write FIsTest default False;
  end;

implementation

var
  Prog: TProgram;

// TProgram --------------------------------------------------------------------
// -----------------------------------------------------------------------------
function TProgram.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
begin
  Result := (ToLog(AGroup, AType, AStrMsg, AParams) >= 0);
end;

// -----------------------------------------------------------------------------
constructor TProgram.Create();
begin
  inherited Create();
  FConfigDocument := nil;
  FLogDocuments := nil;
  FGlbTypeLib := nil;
  FSrvTypeLib := nil;
  FStdTypeLib := nil;

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

  FProgramName := ChangeFileExt(FExeName, '');
  FProgramNameDisplay := FProgramName;
  FTimerInterval := 1000;

  FDateStart := Now;

  Prog := Self;

  InitializeCriticalSection(FCSAddToLog);
  DoCreate();
end;

// -----------------------------------------------------------------------------
function TProgram.DoAddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
begin
  if Assigned(FLogDocuments) then
    Result := FLogDocuments.ToLog(AGroup, AType, AStrMsg, AParams)
  else
    Result := -1;
end;

// -----------------------------------------------------------------------------
function TProgram.DoCommand(const AMsg: WideString): WordBool;
begin
  Result := False;
end;

// -----------------------------------------------------------------------------
procedure TProgram.DoCreate();
begin
  // Создать конфигурации программы
  if not(Assigned(FConfigDocument)) then
    FConfigDocument := TConfigDocument1.Create(Self.ExePath + '\' + Self.ProgramName + '.' + FILE_EXT_CONFIG, AddToLog);

  if Assigned(ComServer) then
  try // Здесь возникнет Exception, если программа не является COM объектом. Создайте и присоедините TLB.
    FSrvTypeLib := ComServer.TypeLib;
  except
  end;
end;

// -----------------------------------------------------------------------------
procedure TProgram.DoDestroy();
begin
  DeleteCriticalSection(FCSAddToLog);
end;

// -----------------------------------------------------------------------------
function TProgram.DoStart(): WordBool;
begin
  if not(Assigned(FLogDocuments)) then
  try
    FLogDocuments := TLogDocuments.Create();
  except
  end;

  Result := True;
end;

// -----------------------------------------------------------------------------
function TProgram.DoStarted(): WordBool;
begin
  Result := True;
end;

// -----------------------------------------------------------------------------
function TProgram.DoStop(AIsShutDown: WordBool): WordBool;
begin
  Result := True;
end;

// -----------------------------------------------------------------------------
function TProgram.DoStoped(AIsShutDown: WordBool): WordBool;
begin
  if Assigned(FLogDocuments) then
  try
    FLogDocuments.Finalize();
    FLogDocuments.Free();
  finally
    FLogDocuments := nil;
  end;

  Result := True;
end;

// -----------------------------------------------------------------------------
function TProgram.DoTimer(): WordBool;
begin
  Result := True;
end;

// -----------------------------------------------------------------------------
function TProgram.Finalize(): WordBool;
begin
  Result := True;
  if not(DoStop(False)) then Result := False;
  if not(DoStoped(False)) then Result := False;
end;

// -----------------------------------------------------------------------------
procedure TProgram.Free();
begin
  DoDestroy();

  Prog := nil;
  inherited Free();
end;

// -----------------------------------------------------------------------------
class function TProgram.GetInstance(): TProgram;
begin
  Result := Prog;
end;

// -----------------------------------------------------------------------------
function TProgram.GetIsDemo(): Boolean;
begin
  Result := True;
end;

// -----------------------------------------------------------------------------
function TProgram.GetTimeWork(): Integer;
begin
  Result := Round((Now - FDateStart) * 24 * 60);
end;

// -----------------------------------------------------------------------------
function TProgram.Initialize(): WordBool;
begin
  AddToLog(lgGeneral, ltInformation, 'Инициализация программы', []);
  Result := True;
  if not(DoStart()) then Result := False;
  if not(DoStarted()) then Result := False;
  AddToLog(lgGeneral, ltInformation, 'Программа инициализирована', []);
end;

// -----------------------------------------------------------------------------
procedure TProgram.SetIsDemo(Value: Boolean);
begin
end;

// -----------------------------------------------------------------------------
function TProgram.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
begin
  EnterCriticalSection(FCSAddToLog);
  Result := DoAddToLog(AGroup, AType, AStrMsg, AParams);
  LeaveCriticalSection(FCSAddToLog);
end;

end.



