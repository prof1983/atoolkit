﻿{**
@Abstract(Реализация основной функциональности для главного объекта)
@Author(Prof1983 <prof1983@ya.ru>)
@Created(22.05.2006)
@LastMod(18.07.2012)
}
unit AProgram20060925;

// TODO: Rename to AProgramObj.pas

interface

uses
  ActiveX, Classes, ComObj, ComServ, Messages, SysUtils, Windows, WinSock, WinSvc,
  ABase, AConfig2007, AConsts2, ALogDocuments, ALogObj, ATypes, AXmlNodeImpl;

type //** Основной объект сервиса
  TAProgramObject = class(TLoggerObject)
  private
    FCSAddToLog: TRTLCriticalSection; // Критическая секция для добавления в лог
    FConfigPath: APascalString;
    FDataPath: APascalString;
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
    FIsComServer: ABoolean;
    FIsConsole: Boolean;
    FIsDebug: Boolean;
    //FIsDemo: Boolean;
    FIsSilent: Boolean;
    FIsSplash: Boolean;
    FIsTeach: Boolean;
    FIsTest: Boolean;
  protected
    FConfig: AConfig;
    FConfigDocument: TConfigDocument;
    FDateStart: TDateTime;
    FLogDocuments: TALogDocuments;

    FGlbTypeLib: ITypeLib;
    FSrvTypeLib: ITypeLib;
    FStdTypeLib: ITypeLib;
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
    function Finalize(): WordBool;
    // Инициализировать программу
    function Initialize(): WordBool;
  public
    // Конфигурации программы
    property ConfigDocument: TConfigDocument read FConfigDocument;
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
    property LogDocuments: TALogDocuments read FLogDocuments;
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
  FGlbTypeLib := nil;
  FSrvTypeLib := nil;
  FStdTypeLib := nil;

  FTimerInterval := 1000;

  FDateStart := Now;

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
    FLogDocuments := TALogDocuments.Create();
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

function TAProgramObject.Finalize(): WordBool;
begin
  Result := True;
  if not(DoStop(False)) then Result := False;
  if not(DoStoped(False)) then Result := False;
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
  Result := Round((Now - FDateStart) * 24 * 60);
end;

function TAProgramObject.Initialize(): WordBool;
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
    FConfigDocument := TConfigDocument.Create(FConfigPath + Self.ProgramName + '.' +
        FILE_EXT_CONFIG, 'Config', AddToLog);
  FConfig := FConfigDocument.GetDocumentElement();

  if FIsComServer and Assigned(ComServer) then
  try // Здесь возникнет Exception, если программа не является COM объектом. Создайте и присоедините TLB.
    FSrvTypeLib := ComServer.TypeLib;
  except
  end;

  Result := True;
  if not(DoStart()) then Result := False;
  if not(DoStarted()) then Result := False;
  AddToLog(lgGeneral, ltInformation, 'Программа инициализирована');
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
  Self.FProgramName := Value;
end;

end.



