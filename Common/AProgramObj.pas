{**
@Abstract Реализация основной функциональности для главного объекта
@Author Prof1983 <prof1983@ya.ru>
@Created 22.05.2006
@LastMod 19.12.2012
}
unit AProgramObj;

interface

uses
  SysUtils,
  Windows,
  ABase,
  AConfig2007,
  AConsts2,
  ALogDocumentListObj,
  ALogObj,
  AProgramData,
  ASystemData,
  ATypes,
  AUtilsMain,
  AXmlNodeImpl;

type //** Основной объект сервиса
  TAProgramObject = class(TLoggerObject)
  private
    function GetTimeWork(): Integer;
  protected
    FConfigDocument: TConfigDocument;
    FLogDocuments: TALogDocumentListObject;
  public
    function GetIsDemo(): Boolean; virtual;
    procedure SetIsComServer(Value: ABoolean);
    procedure SetIsDemo(Value: Boolean); virtual;
    procedure SetProgramName(const Value: APascalString);
  protected
    // Срабатывает при добавлении записи в лог
    function DoAddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; virtual;
    // Срабатывает, когда нужно выполнить внешнюю команду. см. TProcMessageStr
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
    function AddToLog(MsgGroup: TLogGroupMessage; MsgType: TLogTypeMessage;
        const StrMsg: WideString): AInt; override;
    constructor Create(); virtual;
    procedure Free(); virtual;
    class function GetInstance(): TAProgramObject;
  public
    // Финализировать программу
    function Finalize(): AError; virtual;
    // Инициализировать программу
    function Initialize(): AError; virtual;
  public
    // Конфигурации программы
    property ConfigDocument: TConfigDocument read FConfigDocument;
    {
    // Время запуска сервиса
    property DateStart: TDateTime read FDateStart;
    // Зависимости от других сервисов
    property Dependencies: WideString read FDependencies write FDependencies;
    // Полный путь и имя файла
    property ExeFullName: WideString read FExeFullName;
    // Имя файла
    property ExeName: WideString read FExeName;
    // Путь расположения программы
    property ExePath: WideString read FExePath;
    }
    // Класс, объединяющий вывод логов сразу в несколько мест
    property LogDocuments: TALogDocumentListObject read FLogDocuments;
    {
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
    }
  published // Глобальные свойства программы
    {
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
    }
  end;

  TProgram = TAProgramObject;

implementation

var
  Prog: TAProgramObject;

{ TAProgramObject }

function TAProgramObject.AddToLog(MsgGroup: TLogGroupMessage; MsgType: TLogTypeMessage;
    const StrMsg: WideString): AInt;
begin
  EnterCriticalSection(FCSAddToLog);
  if Assigned(FLogDocuments) then
    Result := FLogDocuments.AddToLog(MsgGroup, MsgType, StrMsg)
  else
    Result := -1;
  LeaveCriticalSection(FCSAddToLog);
end;

constructor TAProgramObject.Create();
begin
  inherited Create();
  FIsComServer := True;
  FConfigDocument := nil;
  FLogDocuments := nil;

  FTimerInterval := 1000;

  FDateStart := AUtils_GetNowDateTime();

  Prog := Self;

  InitializeCriticalSection(FCSAddToLog);
  DoCreate();
end;

function TAProgramObject.DoAddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := AddToLog2(AGroup, AType, AStrMsg, AParams);
end;

function TAProgramObject.DoCommand(const AMsg: WideString): WordBool;
begin
  Result := False;
end;

procedure TAProgramObject.DoCreate();
begin
end;

procedure TAProgramObject.DoDestroy();
begin
  DeleteCriticalSection(FCSAddToLog);
end;

function TAProgramObject.DoStart(): WordBool;
begin
  if not(Assigned(FLogDocuments)) then
  try
    FLogDocuments := TALogDocumentListObject.Create();
  except
  end;

  Result := True;
end;

function TAProgramObject.DoStarted(): WordBool;
begin
  Result := True;
end;

function TAProgramObject.DoStop(AIsShutDown: WordBool): WordBool;
begin
  Result := True;
end;

function TAProgramObject.DoStoped(AIsShutDown: WordBool): WordBool;
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

function TAProgramObject.DoTimer(): WordBool;
begin
  Result := True;
end;

function TAProgramObject.Finalize(): AError;
begin
  Result := 0;
  if not(DoStop(False)) then Result := 1;
  if not(DoStoped(False)) then Result := 2;
end;

procedure TAProgramObject.Free();
begin
  DoDestroy();

  Prog := nil;
  inherited Free();
end;

class function TAProgramObject.GetInstance(): TAProgramObject;
begin
  Result := Prog;
end;

function TAProgramObject.GetIsDemo(): Boolean;
begin
  Result := True;
end;

function TAProgramObject.GetTimeWork(): Integer;
begin
  Result := Round((AUtils_GetNowDateTime() - FDateStart) * 24 * 60);
end;

function TAProgramObject.Initialize(): AError;
var
  Res: Boolean;
begin
  AddToLog(lgGeneral, ltInformation, 'Инициализация программы');

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

  FConfigPath := ExpandFileName(FExePath + '..\Configs\');
  FDataPath := ExpandFileName(FExePath + '..\Data\');

  if (FProgramName = '') then
    FProgramName := ChangeFileExt(FExeName, '');
  FProgramNameDisplay := FProgramName;

  // Создать конфигурации программы
  if not(Assigned(FConfigDocument)) then
    FConfigDocument := TConfigDocument.Create(FConfigPath + FProgramName + '.' +
        FILE_EXT_CONFIG, 'Config', AddToLog);
  FConfig := FConfigDocument.GetDocumentElement();

  Res := True;
  if not(DoStart()) then
    Res := False;
  if not(DoStarted()) then
    Res := False;
  AddToLog(lgGeneral, ltInformation, 'Программа инициализирована');
  if Res then
    Result := 0
  else
    Result := 1;
end;

procedure TAProgramObject.SetIsComServer(Value: ABoolean);
begin
  FIsComServer := Value;
end;

procedure TAProgramObject.SetIsDemo(Value: Boolean);
begin
end;

procedure TAProgramObject.SetProgramName(const Value: APascalString);
begin
  FProgramName := Value;
end;

end.



