{**
@Abstract(Реализация основной функциональности для главного объекта)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.05.2006)
@LastMod(05.07.2012)
@Version(0.5)

0.0.5.7 - 21.07.2011
[*] Rename ProfProgramImpl.pas(AIKernel) -> ProfProgram.pas
}
unit AProgramImpl;

interface

// TODO: Deliver from ProfProcess

uses
  ActiveX, Classes, ComObj, ComServ, Messages, SysUtils, Windows, WinSock, WinSvc, XmlIntf{MSXML24_TLB},
  AConsts2, ALogDocumentIntf, ALogDocuments, ALogJournal, ALogNodeImpl, AProcessImpl, AProgramUtils, ATypes;

  //ALogDocuments2007, AObjectImpl, AXmlDocumentImpl;

type //** Основной объект программы
  TProfProgram = class(TProfProcess)
  protected
      //** Критическая секция для добавления в лог
    FCSAddToLog: TRTLCriticalSection;
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
    FConfigDocument: IXmlDomDocument;
    FConfigFileName: WideString;
    FConfigInitialize: Boolean;
    FDateStart: TDateTime;
    FIsComServer: Boolean;
    FIsService: Boolean;
    FMaxClientAccount: Integer;
    FLogDocuments: IProfLogDocuments;
    FLogJournal: TLogJournal;
  protected
    FGlbTypeLib: ITypeLib;
    FSrvTypeLib: ITypeLib;
    FStdTypeLib: ITypeLib;
  protected
    function GetIsDemo(): Boolean; virtual;
    function GetTimeWork(): Integer;
    procedure SetIsDemo(Value: Boolean); virtual;
  protected
      //** Срабатывает при добавлении записи в лог
    function DoAddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; virtual; safecall;
      //** Срабатывает, когда нужно выполнить внешнюю команду. см. TProcMessageStr
    //function DoCommand(const AMsg: WideString): Integer; override; safecall;
      //** Срабатывает при создании объекта
    procedure DoCreate(); override; safecall;
    procedure DoCreated(); override; safecall;
      //** Срабатывает при уничтожении объекта
    procedure DoDestroy(); override; safecall;
      //** Срабатывает после успешной финализации
    function DoFinalized(): TProfError; override; safecall;
      //** Срабатывает при инициализации
    function DoInitialize(): TProfError; override; safecall;
      //** Срабатывает при событии таймера
    function DoTimer(): WordBool; virtual; safecall;
  public
      //** Добавление записи в лог
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override;
      //** Получить эобъкт Program
    class function GetInstance(): TProfProgram;
  public
      //** Завершить работу программы
    class procedure DoneProgram(); virtual;
      //** Инициализировать программу
    function Initialize(): TProfError; override;
  public
    constructor Create(); override;
    procedure Free(); override;
  public
    //** Конфигурации программы
    property ConfigDocument: IXmlDomDocument read FConfigDocument;
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
    property ExeName: WideString read FExeName;
    //** Путь расположения программы "C:\example\"
    property ExePath: WideString read FExePath;
    //** Информация прошитая в файле
    property FileVersionInfo: TFileVersionInfo read FFileVersionInfo;
    //** Максимальное число клиентов
    property MaxClientAccount: Integer read FMaxClientAccount default 100;
    //** Класс, объединяющий вывод логов сразу в несколько мест
    property LogDocuments: IProfLogDocuments read FLogDocuments;
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

  //TProgram = TProfProgram;

implementation

var
  Prog: TProfProgram;

{ TProfProgram }

function TProfProgram.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  EnterCriticalSection(FCSAddToLog);

  inherited AddToLog(AGroup, AType, AStrMsg);
  if Assigned(FLogDocuments) then
    Result := FLogDocuments.AddToLog(AGroup, AType, AStrMsg)
  else
    Result := -1;

  LeaveCriticalSection(FCSAddToLog);
end;

constructor TProfProgram.Create();
begin
  FConfigDocument := nil;
  FLogDocuments := nil;
  FLogJournal := nil;
  FGlbTypeLib := nil;
  FSrvTypeLib := nil;
  FStdTypeLib := nil;
  inherited Create();
end;

function TProfProgram.DoAddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  Result := AddToLog(AGroup, AType, AStrMsg);
end;

procedure TProfProgram.DoCreate;
begin
  inherited DoCreate;

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

  Prog := Self;

  InitializeCriticalSection(FCSAddToLog);

  if FIsComServer and Assigned(ComServer) then
  try // Здесь возникнет Exception, если программа не является COM объектом. Создайте и присоедините TLB.
    FSrvTypeLib := ComServer.TypeLib;
  except
  end;
end;

procedure TProfProgram.DoCreated;
//var
//  doc: TProfXmlDocument3;
begin
  CoInitialize(nil);
  inherited DoCreated;
  // Создать конфигурации программы
  if not(Assigned(FConfigDocument)) then
  try
    FConfigDocument := CoDOMDocument.Create();
    if not(FConfigDocument.load(Self.ExePath + Self.ExeName + FILE_EXT_CONFIG)) then
      FConfigDocument := nil;

    {if Self.ConfigFileName = '' then
      Self.ConfigFileName := Self.ExePath + Self.ProgramName + '.' + FILE_EXT_CONFIG;
    doc := TProfXmlDocument3.Create();
    doc.FileName := ConfigFileName;
    doc.DocumentElementName := 'Config';
    //doc.OnAddToLog := AddToLog;
    doc.Initialize();
    //doc.DocumentElement.Attributes['app'] := Self.ProgramName;
    FConfigDocument := doc;
    FConfigInitialize := True;
    Self.FConfig := FConfigDocument.DocumentElement;}
  except
    FConfigDocument := nil;
  end;
end;

procedure TProfProgram.DoDestroy();
begin
  DeleteCriticalSection(FCSAddToLog);
  inherited DoDestroy();
end;

function TProfProgram.DoFinalized(): TProfError;
begin
  if Assigned(FLogJournal) then
  try
    //FLogJournal.Finalize();
    FLogJournal.Free();
  finally
    FLogJournal := nil;
  end;

  // Сохраняем конфигурации программы
  if Assigned(FConfigDocument) then
  try
    FConfigDocument.save(Self.ExePath + Self.ExeName + FILE_EXT_CONFIG);
  finally
    try
      FConfigDocument := nil;
    except
    end;
  end;

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
    //TProfXmlDocument.Normalize();
    FConfigDocument.SaveToFile('');
  finally
    try
      FConfigDocument := nil;
    except
    end;
  end;
  Result := inherited DoFinalized();
end;

function TProfProgram.DoInitialize(): TProfError;
var
  LogNode1: TALogNode;
begin
  Result := inherited DoInitialize();
  if not(Assigned(FLogDocuments)) then
  try
    FLogDocuments := TProfLogDocuments3.Create();
  except
  end;
  if not(Assigned(FLog)) then
  begin
    LogNode1 := TALogNode.Create(nil, '', 0);
    LogNode1.OnAddToLog := AddToLog;
    FLog := LogNode1;
  end;
  {if not(Assigned(FLogJournal)) then
  try
    FLogJournal := TLogJournal.Create();
  except
  end;}
end;

class procedure TProfProgram.DoneProgram();
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

function TProfProgram.DoTime(): WordBool;
begin
  Result := DoTimer;
end;

function TProfProgram.DoTimer(): WordBool;
begin
  Result := True;
end;

procedure TProfProgram.Free();
begin
  DoDestroy();
  Prog := nil;
  //inherited Free();
end;

class function TProfProgram.GetInstance(): TProfProgram;
begin
  Result := Prog;
end;

function TProfProgram.GetIsDemo(): Boolean;
begin
  Result := FIsDemo;
end;

function TProfProgram.GetTimeWork(): Integer;
begin
  Result := Round((Now - FDateStart) * 24 * 60);
end;

function TProfProgram.Initialize(): TProfError;
begin
  AddToLog(lgGeneral, ltInformation, 'Инициализация программы');
  Result := inherited Initialize;
  AddToLog(lgGeneral, ltInformation, 'Программа инициализирована');
end;

procedure TProfProgram.SetIsDemo(Value: Boolean);
begin
  FIsDemo := Value;
end;

end.
