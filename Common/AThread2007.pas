{**
@Abstract(Оболочка для процесса)
@Author(Prof1983 prof1983@ya.ru)
@Created(03.10.2005)
@LastMod(26.04.2012)
@Version(0.5)
}
unit AThread2007;

// TODO: Use AThreadObj.pas

interface

uses
  Classes,
  ATypes;

type
  //** @abstract(Состояние процесса)
  TThreadState = (
      //** Запущен. Работает.
    tsStarted,
      //** Происходит запуск
    tsStarting,
      //** Не запущен. Не работает.
    tsTerminated,
      //** Происходит завершение
    tsTerminating,
      //** Пауза
    tsPaused,
      //** Происходит постановка на паузу
    tsPausing,
      //** Нет соединения
    tsNotConnected
    );

type //** @abstract(Оболочка для процесса)
  TProfThread = class(TThread)
  protected
    //FConfig: TConfigNode;       // Конфигурации
    //FLog: TLogNode;             // Логирование
    FOnAddToLog: TProfAddToLog;
    FState: TThreadState;       // Состояние процесса
  protected
    procedure DoCreate(); virtual; safecall;
    procedure DoDestroy(); virtual; safecall;
    procedure Execute; override;
    //procedure Set_Log(Value: TLogNode); virtual;
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer; virtual;
  public
    procedure Pause();
    procedure Start();
    procedure Stop();
  public
    //function AddToLogProf(AType: TTypeMessage; APlace: TPlaceMessage; AMsg, AParams: String): UInt32; virtual;
    //property Config: TConfigNode read FConfig write FConfig;
    //function ConfigureLoad: WordBool; virtual;
    //function ConfigureSave: WordBool; virtual;
    constructor Create(); //(AConfig: TConfigNode = nil; ALog: TLogNode = nil);
    //function Finalize: WordBool; virtual;
    //procedure Free; virtual;
    //function Initialize: WordBool; virtual;
    //property Log: TLogNode read FLog write Set_Log;
    property OnAddToLog: TProfAddToLog read FOnAddToLog write FOnAddToLog;
    property State: TThreadState read FState;
  end;

const // -----------------------------------------------------------------------
  INT_THREAD_PRIORITY: array[TThreadPriority] of Integer = (0, 1, 2, 3, 4, 5, 6);
  STR_THREAD_PRIORITY: array[TThreadPriority] of String = ('Idle', 'Lowest', 'Lower', 'Normal', 'Higher', 'Highest', 'TimeCritical');

const // Сообщения -------------------------------------------------------------
  stConfigureLoadOk = 'Конфигурации процесса загружены. Priority = %s';

implementation

// TProfThread -----------------------------------------------------------------
// -----------------------------------------------------------------------------
{function TProfThread.ConfigureLoad: WordBool;
var
  I: Int32;
  iPriority: Integer;
  tmpPriority: TThreadPriority;
begin
  Result := Assigned(FConfig);
  if not(Result) then Exit;
  if Config.ReadInteger('Priority', iPriority) then
    for tmpPriority := Low(TThreadPriority) to High(TThreadPriority) do
      if INT_THREAD_PRIORITY[tmpPriority] = iPriority then begin
        Priority := tmpPriority;
        AddToLog(lgGeneral, ltInformation, stConfigureLoadOk, [STR_THREAD_PRIORITY[Priority]]);
        Exit;
      end;
  //Priority := Int32ToThreadPriority(I);
  //AddToLog(lgGeneral, ltInformation, stConfigureLoadOk, [ThreadPriority_String[Priority]]);
end;}

// -----------------------------------------------------------------------------
{function TProfThread.ConfigureSave: WordBool;
begin
  Result := Assigned(FConfig);
  if not(Result) then Exit;
  Config.WriteInt32('Priority', INT_THREAD_PRIORITY[Priority]);
end;}

// -----------------------------------------------------------------------------
constructor TProfThread.Create(); //(AConfig: TConfigNode = nil; ALog: TLogNode = nil);
begin
  inherited Create(True);
  DoCreate();
  {FConfig := AConfig;
  FLog := ALog;
  AddToLog(lgGeneral, ltInformation, stCreateOk, []);}
end;

// -----------------------------------------------------------------------------
procedure TProfThread.DoCreate();
begin
end;

// -----------------------------------------------------------------------------
procedure TProfThread.DoDestroy();
begin
end;

// -----------------------------------------------------------------------------
procedure TProfThread.Execute();
begin
  //if Assigned(FOnExecute) then FOnExecute;
end;

// -----------------------------------------------------------------------------
procedure TProfThread.Pause();
begin
  Self.Suspend();
end;

// -----------------------------------------------------------------------------
procedure TProfThread.Start();
begin
  Self.Resume();
end;

// -----------------------------------------------------------------------------
procedure TProfThread.Stop();
begin
  Self.Terminate();
end;

// -----------------------------------------------------------------------------
function TProfThread.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := 0;
  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(AGroup, AType, AStrMsg, AParams);
  except
  end;
end;

end.
