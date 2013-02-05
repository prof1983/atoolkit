{**
@Abstract AProcess implementation
@Author Prof1983 <prof1983@ya.ru>
@Created 02.09.2007
@LastMod 04.02.2013
}
unit AProcessImpl2007;

interface

uses
  AProcessIntf2007, AProcessThread, ARunnable;

type
  TProcess = class(TInterfacedObject, IProcess)
  private
    FRunnable: IARunnable;
    FThread: TProcessThread;
  protected
    function GetPriority(): Integer; virtual;
    function GetState(): Integer; virtual;
    procedure SetPriority(Value: Integer); virtual;
  public
    procedure Initialize(); virtual;
    procedure Finalize(); virtual;
    procedure Start(); virtual;
    procedure Stop(); virtual;
    procedure Pause(); virtual;
  public
    property Priority: Integer read GetPriority write SetPriority;
    property Runnable: IARunnable read FRunnable write FRunnable;
    property State: Integer read GetState;
  end;

implementation

{ TProcess }

procedure TProcess.Finalize();
begin
  Stop();
  if Assigned(FThread) then
  try
    FThread.Free();
    FThread := nil;
  except
  end;
end;

function TProcess.GetPriority(): Integer;
begin
  Result := 0;
  // ...
end;

function TProcess.GetState(): Integer;
begin
  Result := 0;
  // ...
end;

procedure TProcess.Initialize();
begin
  if not(Assigned(FThread)) and Assigned(FRunnable) then
    FThread := TProcessThread.Create(FRunnable);
end;

procedure TProcess.Pause();
begin
  if Assigned(FThread) then
    FThread.Suspend();
end;

procedure TProcess.SetPriority(Value: Integer);
begin
  // ...
end;

procedure TProcess.Start();
begin
  if Assigned(FThread) then
  try
    FThread.Resume();
  except
  end;
end;

procedure TProcess.Stop();
begin
  if Assigned(FThread) then
  try
    FThread.Terminate();
    FThread.WaitFor();
  except
  end;
end;

end.
