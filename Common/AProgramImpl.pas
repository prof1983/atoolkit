{**
@Abstract Реализация основной функциональности для главного объекта
@Author Prof1983 <prof1983@ya.ru>
@Created 22.05.2006
@LastMod 18.12.2012
}
unit AProgramImpl;

interface

// TODO: Deliver from ProfProcess

uses
  ActiveX, Classes, ComObj, ComServ, Messages, SysUtils, Windows, WinSock, WinSvc,
  ABase, AConsts2, ALogDocuments, ALogJournal, ALogNodeUtils,
  AProcessImpl, AProgramUtils, ASystemData, ATypes, AXmlDocumentUtils;

type
  {$IFDEF UseComXml}
  //IXmlDocument = IXmlDomDocument;
  {$ENDIF}

  //** Основной объект программы
  TAProgram = class(TProfProcess)
  protected
    FConfigDir: APascalString;
      //** Критическая секция для добавления в лог
    FCSAddToLog: TRTLCriticalSection;
    FDataDir: APascalString;
    FExeFullName: WideString;
    FFileVersionInfo: TFileVersionInfoA;
  protected
    FDependencies: WideString;
    FObjectGlobalID: Integer;
    FObjectOwnerName: WideString;
    FOrgOwnerName: WideString;
    FProgramDescription: WideString;
    FProgramId: LongWord;
    FProgramIdStr: WideString;
    FProgramName: WideString;
    FProgramNameDisplay: WideString;
    FProgramVersion: WideString;
    FProgramVersionStr: WideString;
    FSystemName: WideString;
    FTimerInterval: LongWord;
  protected
    FIsConsole: Boolean;
    FIsDebug: Boolean;
    FIsDemo: Boolean;
    FIsSilent: Boolean;
    FIsSplash: Boolean;
    FIsTeach: Boolean;
    FIsTest: Boolean;
  protected
    FConfigDocument: AXmlDocument;
    FConfigFileName: WideString;
    FConfigInitialize: Boolean;
    FDateStart: TDateTime;
    FIsComServer: Boolean;
    FIsService: Boolean;
    FMaxClientAccount: Integer;
    FLogDocuments: TALogDocuments;
    FLogJournal: TLogJournal;
  protected
    FGlbTypeLib: ITypeLib;
    FSrvTypeLib: ITypeLib;
    FStdTypeLib: ITypeLib;
  protected
    function GetConfigDocument(): AProfXmlNode;
    function GetIsDemo(): Boolean; virtual;
    procedure SetIsDemo(Value: Boolean); virtual;
  protected
      //** Срабатывает при добавлении записи в лог
    function DoAddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; virtual; safecall;
      //** Срабатывает при уничтожении объекта
    procedure DoDestroy(); override; safecall;
      //** Срабатывает после успешной финализации
    function DoFinalized(): AError; override; safecall;
      //** Срабатывает при инициализации
    function DoInitialize(): AError; override; safecall;
      //** Срабатывает при событии таймера
    function DoTimer(): WordBool; virtual; safecall;
  public
      //** Добавление записи в лог
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override;
    function GetConfigFileName(): APascalString;
    function GetConfigPath(): APascalString;
    function GetDataPath(): APascalString;
    function GetTimeWork(): Integer;
      //** Инициализировать программу
    function Initialize(): AError; override;
  public
    constructor Create(); override;
    procedure Free(); override;
  public
      //** Завершить работу программы
    class procedure DoneProgram(); virtual;
      //** Получить эобъкт Program
    class function GetInstance(): TAProgram;
  public
    //** Конфигурации программы
    property ConfigDocument: AXmlDocument read FConfigDocument;
    //** Конфигурации программы
    property ConfigDocument2: AProfXmlNode read GetConfigDocument;
    //** Имя файла конфигураций
    property ConfigFileName: WideString read FConfigFileName write FConfigFileName;
    //** Время запуска сервиса
    property DateStart: TDateTime read FDateStart;
    //** Зависимости от других сервисов
    property Dependencies: WideString read FDependencies write FDependencies;
    //** Выполнить событие тайм
    function DoTime(): WordBool; safecall;
    //** Полный путь и имя фийла "C:\example\program.exe"
    property ExeFullName: WideString read FExeFullName;
    //** Имя файла "program.exe"
    //property ExeName: WideString read FExeName; - Use ASystemData.FExeName
    //** Путь расположения программы "C:\example\"
    //property ExePath: WideString read FExePath; - Use ASystemData.FExePath
    //** Информация прошитая в файле
    property FileVersionInfo: TFileVersionInfoA read FFileVersionInfo;
    //** Максимальное число клиентов
    property MaxClientAccount: Integer read FMaxClientAccount default 100;
    //** Класс, объединяющий вывод логов сразу в несколько мест
    property LogDocuments: TALogDocuments read FLogDocuments;
    //** Класс, объединяющий вывод логов сразу в несколько мест
    property LogJournal: TLogJournal read FLogJournal write FLogJournal;
    //** Глобальный ID объекта - владельца
    property ObjectGlobalID: Integer read FObjectGlobalID write FObjectGlobalID;
    //** Название объекта - владельца
    property ObjectOwnerName: WideString read FObjectOwnerName write FObjectOwnerName;
    //** Название организации - владельца
    property OrgOwnerName: WideString read FOrgOwnerName write FOrgOwnerName;
    //** Уникальный номер модуля
    property ProgramId: LongWord read FProgramId write FProgramId;
    property ProgramIdStr: WideString read FProgramIdStr write FProgramIdStr;
    //** Системное имя программы (сервиса) (имя файла баз расширения)
    property ProgramName: WideString read FProgramName;
    //** Описание сервиса
    property ProgramDescription: WideString read FProgramDescription write FProgramDescription;
    //** Имя сервиса для отображения
    property ProgramNameDisplay: WideString read FProgramNameDisplay write FProgramNameDisplay;
    //** Версия программы
    property ProgramVersion: WideString read FProgramVersion;
    property ProgramVersionStr: WideString read FProgramVersionStr;
    //** Системное имя
    property SystemName: WideString read FSystemName write FSystemName;
    //** Время срабатывания таймера (в мс)
    property TimerInterval: LongWord read FTimerInterval write FTimerInterval;
    //** Время непрерывной работы в минутах
    property TimeWork: Integer read GetTimeWork;
  public
    //** Глобальная библиотека типов
    property GlbTypeLib: ITypeLib read FGlbTypeLib;
    //** Библиотека типов данного приложения
    property SrvTypeLib: ITypeLib read FSrvTypeLib;
    //** Стандартная библиотека типов
    property StdTypeLib: ITypeLib read FStdTypeLib;
  public
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

  TProfProgram = TAProgram;
  //TProgram = TProfProgram;

implementation

var
  Prog: TAProgram;

{ TAProgram }

function TAProgram.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  EnterCriticalSection(FCSAddToLog);
  Result := inherited AddToLog(AGroup, AType, AStrMsg);
  LeaveCriticalSection(FCSAddToLog);
end;

constructor TAProgram.Create();
var
  Doc: AXmlDocument;
begin
  FConfigDocument := 0;
  FLogDocuments := nil;
  FLogJournal := nil;
  FGlbTypeLib := nil;
  FSrvTypeLib := nil;
  FStdTypeLib := nil;

  inherited Create();

  Prog := Self;

  // В виде консоли
  FIsConsole := FindCmdLineSwitch(STR_SWITCH[sConsole], ['-','/'], True);
  // Режим отладки
  FIsDebug := FindCmdLineSwitch(STR_SWITCH[sDebug], ['-','/'], True);
  // Демо режим
  FIsDemo := FindCmdLineSwitch(STR_SWITCH[sDemo], ['-','/'], True);
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

  FFileVersionInfo := AProgramUtils.GetProgramVersionInfo(FExeFullName);
  FProgramVersion := FFileVersionInfo.FileVersion;

  InitializeCriticalSection(FCSAddToLog);

  if FIsComServer and Assigned(ComServer) then
  try // Здесь возникнет Exception, если программа не является COM объектом. Создайте и присоедините TLB.
    FSrvTypeLib := ComServer.TypeLib;
  except
  end;

  // ---

  // Создать конфигурации программы
  if (FConfigDocument = 0) then
  try
    Doc := AXmlDocument_New();
    AXmlDocument_SetFileNameP(Doc, GetConfigFileName());
    AXmlDocument_SetDefElementNameP(Doc, 'Config');
    AXmlDocument_SetOnAddToLog(Doc, AddToLog);
    AXmlDocument_Initialize(Doc);
    Self.FConfig := AXmlDocument_GetDocumentElement(Doc);
    FConfigDocument := Doc;
    Self.FConfigInitialize := True;
  except
    FConfigDocument := 0;
  end;

  GetDataPath();
end;

function TAProgram.DoAddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  Result := AddToLog(AGroup, AType, AStrMsg);
end;

procedure TAProgram.DoDestroy();
begin
  DeleteCriticalSection(FCSAddToLog);
  inherited DoDestroy();
end;

function TAProgram.DoFinalized(): AError;
begin
  if Assigned(FLogJournal) then
  try
    //FLogJournal.Finalize();
    FLogJournal.Free();
  finally
    FLogJournal := nil;
  end;

  {if Assigned(FLogDocuments) then
  try
    FLogDocuments.Finalize();
    FLogDocuments.Free();
  finally
    FLogDocuments := nil;
  end;}

  // Сохраняем конфигурации программы
  if FConfigInitialize and (FConfigDocument <> 0) then
  try
    AXmlDocument_SaveToFileP(FConfigDocument, '');
  finally
    AXmlDocument_Free(FConfigDocument);
    FConfigDocument := 0;
  end;
  Result := inherited DoFinalized();
end;

function TAProgram.DoInitialize(): AError;
begin
  Result := inherited DoInitialize();
  if not(Assigned(FLogDocuments)) then
  try
    FLogDocuments := TALogDocuments.Create();
  except
  end;
  if (FLog = 0) then
    FLog := FLogDocuments.GetDocumentElement();
  if (FLog = 0) then
  begin
    FLog := ALogNode_New(0, 0, '', 0);
    ALogNode_SetOnAddToLog(FLog, FLogDocuments.AddToLog);
  end;
  {if not(Assigned(FLogJournal)) then
  try
    FLogJournal := TLogJournal.Create();
  except
  end;}
end;

class procedure TAProgram.DoneProgram();
begin
  if Assigned(Prog) then
  try
    Prog.Stop();
    Prog.Finalize();
    Prog.Free();
    Prog := nil;
  except
    Prog := nil;
  end;
end;

function TAProgram.DoTime(): WordBool;
begin
  Result := DoTimer;
end;

function TAProgram.DoTimer(): WordBool;
begin
  Result := True;
end;

procedure TAProgram.Free();
begin
  DoDestroy();
  Prog := nil;
  //inherited Free();
end;

function TAProgram.GetConfigDocument(): AProfXmlNode;
begin
  Result := AXmlDocument_GetDocumentElement(FConfigDocument);
end;

function TAProgram.GetConfigFileName(): APascalString;
begin
  if (FConfigFileName = '') then
    FConfigFileName := GetConfigPath() + Self.ProgramName + '.' + FILE_EXT_CONFIG;
  Result := FConfigFileName;
end;

function TAProgram.GetConfigPath(): APascalString;
begin
  if (FConfigPath = '') then
    FConfigPath := ExpandFileName(FExePath + FConfigDir);
  if (Length(FConfigPath) > 0) and (FConfigPath[Length(FConfigPath)] <> '\') and (FConfigPath[Length(FConfigPath)] <> '/') then
    FConfigPath := FConfigPath + '\';
  Result := FConfigPath;
end;

function TAProgram.GetDataPath(): APascalString;
begin
  if (FDataPath = '') then
    FDataPath := ExpandFileName(FExePath + FDataDir);
  if (Length(FDataPath) > 0) and (FDataPath[Length(FDataPath)] <> '\') and (FDataPath[Length(FDataPath)] <> '/') then
    FDataPath := FDataPath + '\';
  Result := FDataPath;
end;

class function TAProgram.GetInstance(): TAProgram;
begin
  Result := Prog;
end;

function TAProgram.GetIsDemo(): Boolean;
begin
  Result := FIsDemo;
end;

function TAProgram.GetTimeWork(): Integer;
begin
  Result := Round((Now - FDateStart) * 24 * 60);
end;

function TAProgram.Initialize(): AError;
begin
  AddToLog(lgGeneral, ltInformation, 'Инициализация программы');
  Result := inherited Initialize;
  AddToLog(lgGeneral, ltInformation, 'Программа инициализирована');
end;

procedure TAProgram.SetIsDemo(Value: Boolean);
begin
  FIsDemo := Value;
end;

end.
