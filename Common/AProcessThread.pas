{**
@Abstract AProcess thread
@Author Prof1983 <prof1983@ya.ru>
@Created 21.08.2007
@LastMod 05.05.2012
}
unit AProcessThread;

interface

uses
  Classes,
  ARunnable;

type
  TProcessThread = class(TThread)
  private
    FRunnable: IARunnable;
  protected
    procedure Execute(); override;
  public
    constructor Create(Runnable: IARunnable);
  public
    property Runnable: IARunnable read FRunnable;
  end;

type
  TRuntimeThread = TProcessThread;

implementation

{ TProcessThread }

constructor TProcessThread.Create(Runnable: IARunnable);
begin
  inherited Create(True);
  FRunnable := Runnable;
end;

procedure TProcessThread.Execute();
begin
  repeat
    FRunnable.Run();
  until Terminated;
end;

end.
