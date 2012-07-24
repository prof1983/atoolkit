{**
@abstract ASystem timer
@author Prof1983 <prof1983@ya.ru>
@created 08.12.2009
@lastmod 24.07.2012
}
unit ASysTimer;

interface

uses
  Classes, Messages, Windows,
  ABase, ASystemBase;

{ Public }

function Timer_New(): ATimer; stdcall;
procedure Timer_Free(Timer: ATimer); stdcall;
procedure Timer_SetEnabled(Timer: ATimer; Value: ABoolean); stdcall;
procedure Timer_SetInterval(Timer: ATimer; Value: AUInt32); stdcall;
procedure Timer_SetOnTimer(Timer: ATimer; Proc: AProc); stdcall;

{ Private }

type
  TATimer = class
  private
    FInterval: Cardinal;
    FWindowHandle: HWND;
    FEnabled: Boolean;
    FOnTimer: AProc;
    procedure UpdateTimer;
    procedure SetEnabled(Value: Boolean);
    procedure SetInterval(Value: Cardinal);
    procedure WndProc(var Msg: TMessage);
  protected
    procedure Timer; dynamic;
  public
    constructor Create;
    destructor Destroy; override;
    function GetOnTimer: AProc;
    procedure SetOnTimer(Value: AProc);
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Interval: Cardinal read FInterval write SetInterval default 1000;
  end;

implementation

const
  SNoTimers = 'Not enough timers available';

{ Public procs }

procedure Timer_Free(Timer: ATimer);
begin
  TATimer(Timer).Free;
end;

function Timer_New: ATimer;
var
  T: TATimer;
begin
  T := TATimer.Create;
  T.Enabled := False;
  Result := ATimer(T);
end;

procedure Timer_SetEnabled(Timer: ATimer; Value: ABoolean);
begin
  TATimer(Timer).Enabled := Value;
end;

procedure Timer_SetInterval(Timer: ATimer; Value: AUInt32);
begin
  TATimer(Timer).Interval := Value;
end;

procedure Timer_SetOnTimer(Timer: ATimer; Proc: AProc); stdcall;
begin
  TATimer(Timer).SetOnTimer(Proc);
end;

{ TATimer }

constructor TATimer.Create;
begin
  FEnabled := True;
  FInterval := 1000;
{$IFDEF MSWINDOWS}
  FWindowHandle := Classes.AllocateHWnd(WndProc);
{$ENDIF}
{$IFDEF LINUX}
  FWindowHandle := WinUtils.AllocateHWnd(WndProc);
{$ENDIF}   
end;

destructor TATimer.Destroy;
begin
  FEnabled := False;
  UpdateTimer;
{$IFDEF MSWINDOWS}   
  Classes.DeallocateHWnd(FWindowHandle);
{$ENDIF}
{$IFDEF LINUX}
  WinUtils.DeallocateHWnd(FWindowHandle);
{$ENDIF}
  inherited Destroy;
end;

function TATimer.GetOnTimer: AProc;
begin
  Result := FOnTimer;
end;

procedure TATimer.UpdateTimer;
begin
  KillTimer(FWindowHandle, 1);
  if (FInterval <> 0) and FEnabled and Assigned(FOnTimer) then
    if SetTimer(FWindowHandle, 1, FInterval, nil) = 0 then
      raise EOutOfResources.Create(SNoTimers);
end;

procedure TATimer.SetEnabled(Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    UpdateTimer;
  end;
end;

procedure TATimer.SetInterval(Value: Cardinal);
begin
  if Value <> FInterval then
  begin
    FInterval := Value;
    UpdateTimer;
  end;
end;

procedure TATimer.SetOnTimer(Value: AProc);
begin
  FOnTimer := Value;
  UpdateTimer;
end;

procedure TATimer.Timer;
begin
  if Assigned(FOnTimer) then
    FOnTimer;
end;

procedure TATimer.WndProc(var Msg: TMessage);
begin
  with Msg do
    if Msg = WM_TIMER then
      try
        Timer;
      except
        //Application.HandleException(Self);
      end
    else
      Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);
end;

end.
 