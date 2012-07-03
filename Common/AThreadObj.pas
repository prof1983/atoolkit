{**
@Abstract(Оболочка для процесса)
@Author(Prof1983 prof1983@ya.ru)
@Created(03.10.2005)
@LastMod(03.07.2012)
@Version(0.5)
}
unit AThreadObj;

interface

uses
  Classes,
  ATypes;

type //** Оболочка для процесса
  TProfThread = class(TThread)
  protected
    FLogGroup: TLogGroupMessage;
    FLogMsg: WideString;
    FLogResult: Integer;
    FLogType: TLogTypeMessage;
    //** CallBack функция логирования
    FOnAddToLog: TAddToLogProc;
    //** CallBack функция progress
    FOnProgress: TProcProgress;
    FProgressID: Integer;
    FProgressMsg: WideString;
    FProgressResult: Integer;
    FProgressValue: Integer;
    //** Состояние процесса
    FState: TThreadState;
  protected // Процедуры для синхронизации
    procedure DoAddToLog();
    procedure DoProgress();
  protected
    //** Добавить лог-сообщение
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; virtual; safecall;
    //** Срабатывает при создании
    procedure DoCreate(); virtual; safecall;
    //** Срабатывает при уничтожении
    procedure DoDestroy(); virtual; safecall;
    //** Главная выполняемая функция
    procedure Execute(); override;
    function Progress(AID, AProgress: Integer; const Msg: WideString): Integer; virtual; safecall;
  public
      //** Временно приостанавливает выполнения процесса
    procedure Pause();
      //** Запускает/возобновляет выполнения подпроцесса
    procedure Start();
      //** Останавливает выполнение подпроцесса
    procedure Stop();
  public
    constructor Create();
    //function Finalize: WordBool; virtual;
    //procedure Free; virtual;
    //function Initialize: WordBool; virtual;
    //** CallBack функция логирования
    property OnAddToLog: TAddToLogProc read FOnAddToLog write FOnAddToLog;
    //** CallBack функция progress
    property OnProgress: TProcProgress read FOnProgress write FOnProgress;
    property State: TThreadState read FState;
  end;
  TProfThread3 = TProfThread;

const // -----------------------------------------------------------------------
  INT_THREAD_PRIORITY: array[TThreadPriority] of Integer = (0, 1, 2, 3, 4, 5, 6);
  STR_THREAD_PRIORITY: array[TThreadPriority] of String = ('Idle', 'Lowest', 'Lower', 'Normal', 'Higher', 'Highest', 'TimeCritical');

const // Сообщения -------------------------------------------------------------
  stConfigureLoadOk = 'Конфигурации процесса загружены. Priority = %s';

implementation

{ TProfThread }

function TProfThread.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  FLogGroup := AGroup;
  FLogType := AType;
  FLogMsg := AStrMsg;
  Synchronize(DoAddToLog);
  Result := FLogResult;
end;

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

{function TProfThread.ConfigureSave: WordBool;
begin
  Result := Assigned(FConfig);
  if not(Result) then Exit;
  Config.WriteInt32('Priority', INT_THREAD_PRIORITY[Priority]);
end;}

constructor TProfThread.Create();
begin
  inherited Create(True);
  DoCreate();
end;

procedure TProfThread.DoAddToLog();
begin
  FLogResult := 0;
  if Assigned(FOnAddToLog) then
  try
    FLogResult := FOnAddToLog(FLogGroup, FLogType, FLogMsg);
  except
  end;
end;

procedure TProfThread.DoCreate();
begin
end;

procedure TProfThread.DoDestroy();
begin
end;

procedure TProfThread.DoProgress();
begin
  FProgressResult := 0;
  if Assigned(FOnProgress) then
  try
    FProgressResult := FOnProgress(FProgressID, FProgressValue, FProgressMsg);
  except
  end;
end;

procedure TProfThread.Execute();
begin
  //if Assigned(FOnExecute) then FOnExecute;
end;

procedure TProfThread.Pause();
begin
  Self.Suspend();
end;

function TProfThread.Progress(AID, AProgress: Integer; const Msg: WideString): Integer;
begin
  FProgressID := AID;
  FProgressValue := AProgress;
  FProgressMsg := Msg;
  Synchronize(DoProgress);
  Result := FProgressResult;
end;

procedure TProfThread.Start();
begin
  Self.Resume();
end;

procedure TProfThread.Stop();
begin
  Self.Terminate();
end;

end.
