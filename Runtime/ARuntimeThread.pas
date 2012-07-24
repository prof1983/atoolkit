{**
@Abstract AThread
@Author Prof1983 <prof1983@ya.ru>
@Created 03.10.2005
@Lastmod 24.07.2012
}
unit ARuntimeThread;

// TODO: Use AThreadObj.pas

interface

uses
  Classes, SysUtils;

type
  TThreadState = (
    tsStoped,
    tsStoping,
    tsStarted,
    tsStarting,
    tsTerminated,
    tsTerminating,
    tsPaused,
    tsPausing
    );

type
  AThread = type Integer;

type
  TThreadProc = procedure; stdcall;

type
  TProfThread = class(TThread)
  protected
    FOnExecute: TThreadProc;
    FState: TThreadState;
  protected
    procedure Execute; override;
  public
    procedure Pause;
    procedure Start;
    procedure Stop;
  public
    constructor Create;
    property State: TThreadState read FState;
  end;

const
  INT_THREAD_PRIORITY: array[TThreadPriority] of Integer = (0, 1, 2, 3, 4, 5, 6);
  STR_THREAD_PRIORITY: array[TThreadPriority] of String = ('Idle', 'Lowest', 'Lower', 'Normal', 'Higher', 'Highest', 'TimeCritical');

function Runtime_Thread_New(OnExecute: TThreadProc): AThread; stdcall;
procedure Runtime_Thread_Start(Thread: AThread); stdcall;
procedure Runtime_Thread_Stop(Thread: AThread); stdcall;

implementation

{ Runtime_Thread }

function Runtime_Thread_New(OnExecute: TThreadProc): AThread; stdcall;
var
  Thread: TProfThread;
begin
  Thread := TProfThread.Create;
  Thread.FOnExecute := OnExecute;
  Thread.Priority := tpLower;
  Result := AThread(Thread);
end;

procedure Runtime_Thread_Start(Thread: AThread); stdcall;
begin
  TProfThread(Thread).Start;
end;

procedure Runtime_Thread_Stop(Thread: AThread); stdcall;
begin
  TProfThread(Thread).Stop;
end;

{ TProfThread }

constructor TProfThread.Create;
begin
  inherited Create(True);
  FState := tsStoped;
end;

procedure TProfThread.Execute;
begin
  FState := tsStarted;
  while not(Terminated) do
  begin
    if Assigned(FOnExecute) then
      FOnExecute
    else
      Sleep(10);
  end;
  FState := tsStoped;
end;

procedure TProfThread.Pause;
begin
  FState := tsPausing;
  Self.Suspend;
  if (Suspended) then
    FState := tsPaused;
end;

procedure TProfThread.Start;
begin
  FState := tsStarting;
  Self.Resume;
end;

procedure TProfThread.Stop;
begin
  FState := tsStoping;
  Self.Terminate;
end;

end.
