{**
@Abstract Оболочка для процесса
@Author Prof1983 <prof1983@ya.ru>
@Created 03.10.2005
@LastMod 04.02.2013
}
unit AThreadObj;

interface

uses
  Classes,
  SysUtils,
  ABase,
  ATypes;

type //** Оболочка для процесса
  TAThread = class(TThread)
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
    {** Добавляет лог-сообщение }
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: APascalString): AInt; virtual;
    {** Добавляет лог-сообщение }
    function AddToLogW(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: WideString): AInt; virtual;
    //** Срабатывает при создании
    procedure DoCreate(); virtual;
    //** Срабатывает при уничтожении
    procedure DoDestroy(); virtual;
    //** Главная выполняемая функция
    procedure Execute(); override;
    function Progress(AID, AProgress: Integer; const Msg: WideString): Integer; virtual;
    function ToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: WideString; Params: array of const): AInt; virtual;
  public
      //** Временно приостанавливает выполнения процесса
    procedure Pause();
      //** Запускает/возобновляет выполнения подпроцесса
    procedure Start();
      //** Останавливает выполнение подпроцесса
    procedure Stop();
  public
    constructor Create();
  public
    //** CallBack функция логирования
    property OnAddToLog: TAddToLogProc read FOnAddToLog write FOnAddToLog;
    //** CallBack функция progress
    property OnProgress: TProcProgress read FOnProgress write FOnProgress;
    property State: TThreadState read FState;
  end;

  TProfThread = TAThread;

const // -----------------------------------------------------------------------
  INT_THREAD_PRIORITY: array[TThreadPriority] of Integer = (0, 1, 2, 3, 4, 5, 6);
  STR_THREAD_PRIORITY: array[TThreadPriority] of String = ('Idle', 'Lowest', 'Lower', 'Normal', 'Higher', 'Highest', 'TimeCritical');

const // Сообщения -------------------------------------------------------------
  stConfigureLoadOk = 'Конфигурации процесса загружены. Priority = %s';

implementation

{ TAThread }

function TAThread.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: APascalString): AInt;
begin
  FLogGroup := LogGroup;
  FLogType := LogType;
  FLogMsg := StrMsg;
  Synchronize(DoAddToLog);
  Result := FLogResult;
end;

function TAThread.AddToLogW(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: WideString): AInt;
begin
  Result := AddToLog(LogGroup, LogType, StrMsg);
end;

constructor TAThread.Create();
begin
  inherited Create(True);
  DoCreate();
end;

procedure TAThread.DoAddToLog();
begin
  FLogResult := 0;
  if Assigned(FOnAddToLog) then
  try
    FLogResult := FOnAddToLog(FLogGroup, FLogType, FLogMsg);
  except
  end;
end;

procedure TAThread.DoCreate();
begin
end;

procedure TAThread.DoDestroy();
begin
end;

procedure TAThread.DoProgress();
begin
  FProgressResult := 0;
  if Assigned(FOnProgress) then
  try
    FProgressResult := FOnProgress(FProgressID, FProgressValue, FProgressMsg);
  except
  end;
end;

procedure TAThread.Execute();
begin
  //if Assigned(FOnExecute) then FOnExecute;
end;

procedure TAThread.Pause();
begin
  Self.Suspend();
end;

function TAThread.Progress(AID, AProgress: Integer; const Msg: WideString): Integer;
begin
  FProgressID := AID;
  FProgressValue := AProgress;
  FProgressMsg := Msg;
  Synchronize(DoProgress);
  Result := FProgressResult;
end;

procedure TAThread.Start();
begin
  Self.Resume();
end;

procedure TAThread.Stop();
begin
  Self.Terminate();
end;

function TAThread.ToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: WideString; Params: array of const): AInt;
begin
  Result := AddToLog(LogGroup, LogType, Format(StrMsg, Params));
end;

end.
