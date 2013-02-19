{**
@Abstract The icon in the system tray
@Author Prof1983 <prof1983@ya.ru>
@Created 22.12.2007
@Lastmod 19.02.2013
}
unit AUiTrayIcon;

{define AStdCall}

interface

uses
  {$IFDEF FPC}
  ExtCtrls,
  {$ELSE}
  Classes, Controls, Forms, Graphics, Menus, Messages, ShellApi, SysUtils, Windows,
  AStringMain,
  {$ENDIF}
  ABase, AUiBase;

// --- AUiTrayIcon ---

function AUiTrayIcon_Free(TrayIcon: ATrayIcon): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiTrayIcon_GetHint(TrayIcon: ATrayIcon; out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiTrayIcon_GetHintP(TrayIcon: ATrayIcon): APascalString;

function AUiTrayIcon_GetMenuItems(TrayIcon: ATrayIcon): AMenuItem; {$ifdef AStdCall}stdcall;{$endif}

function AUiTrayIcon_GetPopupMenu(TrayIcon: ATrayIcon): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUiTrayIcon_New(): ATrayIcon; {$ifdef AStdCall}stdcall;{$endif}

function AUiTrayIcon_SetHint(TrayIcon: ATrayIcon; const Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiTrayIcon_SetHintP(TrayIcon: ATrayIcon; const Value: APascalString): AError;

function AUiTrayIcon_SetIcon(TrayIcon: ATrayIcon; Icon: AIcon): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiTrayIcon_SetIsActive(TrayIcon: ATrayIcon; Value: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiTrayIcon_SetOnLeftClick(TrayIcon: ATrayIcon; Value: AProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiTrayIcon_SetOnRightClick(TrayIcon: ATrayIcon; Value: AProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiTrayIcon_SetPopupMenu(TrayIcon: ATrayIcon; Value: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

// ----

{$IFDEF FPC}

type
  TAUITrayIcon = ExtCtrls.TTrayIcon;

{$ELSE}

type
  TLogTypeMessage = (ltNone, ltInformation, ltWarning, ltError);

type
  TNotifyIconData_50 = record
    cbSize: DWORD;
    Wnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array[0..MAXCHAR] of AnsiChar;
    dwState: DWORD;
    dwStateMask: DWORD;
    szInfo: array[0..MAXBYTE] of AnsiChar;
    uTimeout: UINT;
    szInfoTitle: array[0..63] of AnsiChar;
    dwInfoFlags: DWORD;
  end;

  ATrayIcon_Type = record
    TrayIconObj: ATrayIcon;
    FWindowHandle: HWND;
    FIcon: TIcon;
    FNID_50: TNotifyIconData_50;
    FHint: AnsiString;
    FPopupMenu: TPopupMenu;
    FTrayIconMsg: LongWord;
    FIsActive: Boolean;
    FIsShowDesigning: Boolean;
    FIDMessage: string;
    FOnLeftClick: AProc;
    FOnDblClick: AProc;
    FOnRightClick: AProc;
  end;

  TAUiTrayIcon = class
  private
    procedure OnChangeIcon(Sender: TObject);
    procedure WndProc(var AMsg: TMessage);
  public
    constructor Create;
    destructor Destroy; override;
  public
    procedure ShowToolTip(ATimeOut: LongWord; AType: TLogTypeMessage; const ATitle, AInfo: AnsiString);
  end;

{$ENDIF}

implementation

{$IFNDEF FPC}

var
  Items: array of ATrayIcon_Type;

procedure _ModifyIcon(Index: AInteger; Command: LongWord); forward;
procedure _SetIsActive(Index: AInteger; Value: ABoolean); forward;

// --- Private ---

function _Add(): AInteger;
var
  I: AInteger;
begin
  I := Length(Items);
  SetLength(Items, I + 1);
  Result := I;
end;

procedure _Delete(Index: AInteger);
var
  I: AInteger;
begin
  for I := Index to High(Items) - 1 do
    Items[I] := Items[I + 1];
  SetLength(Items, High(Items));
end;

function _Find(TrayIcon: AInteger): AInteger;
var
  I: Integer;
begin
  for I := 0 to High(Items) do
  begin
    if (Items[I].TrayIconObj = TrayIcon) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

procedure _DoDblClick(Index: AInteger);
begin
  if Assigned(Items[Index].FOnDblClick) then
    Items[Index].FOnDblClick();
end;

procedure _DoLeftClick(Index: AInteger);
begin
  if Assigned(Items[Index].FOnLeftClick) then
    Items[Index].FOnLeftClick();
end;

procedure _DoRightClick(Index: AInteger);
var
  tmpMouseCo: TPoint;
begin
  GetCursorPos(tmpMouseCo);
  if Assigned(Items[Index].FPopupMenu) then
  begin
    SetForegroundWindow(Application.Handle);
    Application.ProcessMessages();
    Items[Index].FPopupMenu.Popup(tmpMouseCo.X, tmpMouseCo.Y);
  end;
  if Assigned(Items[Index].FOnRightClick) then
    Items[Index].FOnRightClick();
end;

procedure _Free(Index: AInteger);
begin
  Items[Index].FPopupMenu := nil;
  Items[Index].FOnLeftClick := nil;
  Items[Index].FOnRightClick := nil;

  if (Items[Index].FIsActive) then
    _ModifyIcon(Index, NIM_DELETE);

  Classes.DeallocateHWnd(Items[Index].FWindowHandle);

  FreeAndNil(Items[Index].FIcon);
end;

function _GetMenuItems(Index: AInteger): AMenuItem;
begin
  if not(Assigned(Items[Index].FPopupMenu)) then
    Items[Index].FPopupMenu := TPopupMenu.Create(nil);
  Result := AMenuItem(Items[Index].FPopupMenu.Items);
end;

procedure _ModifyIcon(Index: AInteger; Command: LongWord);
begin
  Items[Index].FNID_50.cbSize := SizeOf(Items[Index].FNID_50);
  Items[Index].FNID_50.uID := 1;
  Items[Index].FNID_50.uFlags := (NIF_ICON or NIF_TIP or NIF_MESSAGE);
  Items[Index].FNID_50.Wnd := Items[Index].FWindowHandle;
  Items[Index].FNID_50.uCallBackMessage := Items[Index].FTrayIconMsg;
  StrPCopy(Items[Index].FNID_50.szTip, Items[Index].FHint);
  Items[Index].FNID_50.hIcon := Items[Index].FIcon.Handle;
  StrPCopy(Items[Index].FNID_50.szInfo, '');
  StrPCopy(Items[Index].FNID_50.szInfoTitle, '');
  Items[Index].FNID_50.uTimeout := 0;
  Items[Index].FNID_50.dwInfoFlags := 0;
  Shell_NotifyIcon(Command, @Items[Index].FNID_50);
end;

function _New(TrayIcon: ATrayIcon; OnChangeIcon: TNotifyEvent; WndProc: TWndMethod): AInteger;
var
  I: Integer;
begin
  I := _Add();

  Items[I].TrayIconObj := TrayIcon;

  ZeroMemory(@Items[I].FNID_50, SizeOf(Items[I].FNID_50));
  Items[I].FHint := '';
  Items[I].FIsActive := False;
  Items[I].FIsShowDesigning := False;
  Items[I].FIDMessage := 'Assistant';
  Items[I].FIcon := TIcon.Create();
  Items[I].FIcon.OnChange := OnChangeIcon;
  Items[I].FTrayIconMsg := RegisterWindowMessage(PChar(Items[I].FIDMessage + '_TrayIcon'));

  Items[I].FWindowHandle := Classes.AllocateHWnd(WndProc);

  Items[I].FIcon.Assign(Application.Icon);
  _SetIsActive(I, True);
  //FTrayPopupMenu := TPopupMenu.Create(nil);
  //FTrayIcon.PopupMenu := FTrayPopupMenu;

  Result := I;
end;

procedure _SetHint(Index: AInteger; Value: AnsiString);
begin
  if (Value = Items[Index].FHint) then
    Exit;
  if (Length(Value) > 62) then
    Value := Copy(Value, 1, 62);
  Items[Index].FHint := Value;
  if (Items[Index].FIsActive) then
    _ModifyIcon(Index, NIM_MODIFY);
end;

procedure _SetIcon(Index: AInteger; Value: TIcon);
begin
  if (Value = Items[Index].FIcon) then Exit;
  Items[Index].FIcon.Assign(Value);
  if (Items[Index].FIsActive) then
    _ModifyIcon(Index, NIM_MODIFY);
end;

procedure _SetIdMessage(Index: AInteger; const Value: string);
begin
  if (Value <> Items[Index].FIdMessage) then
  begin
    Items[Index].FIdMessage := Value;
    Items[Index].FTrayIconMsg := RegisterWindowMessage(PChar(Items[Index].FIdMessage + '_TrayIcon'));
    if (Items[Index].FIsActive) then
      _ModifyIcon(Index, NIM_MODIFY);
  end;
end;

procedure _SetIsActive(Index: AInteger; Value: ABoolean);
begin
  if (Value <> Items[Index].FIsActive) then
  begin
    Items[Index].FIsActive := Value;
    if (Items[Index].FIsActive) then
      _ModifyIcon(Index, NIM_ADD)
    else
      _ModifyIcon(Index, NIM_DELETE);
  end;
end;

procedure _SetIsShowDesigning(Index: AInteger; Value: Boolean);
begin
  if (Value <> Items[Index].FIsShowDesigning) then
  begin
    if (Items[Index].FIsActive) then
    begin
      Items[Index].FIsShowDesigning := Value;
      if (Items[Index].FIsShowDesigning) then
        _ModifyIcon(Index, NIM_ADD)
      else
        _ModifyIcon(Index, NIM_DELETE);
    end;
  end;
end;

procedure _ShowToolTip(Index: AInteger; TimeOut: LongWord; LogType: TLogTypeMessage; const Title, Info: AnsiString);
const
  NIF_INFO = $00000010;
  TOOL_TIP_CONST: array [TLogTypeMessage] of Word = ($00000000, $00000003, $00000002, $00000001);
begin
  //with FNID_50 do
  begin
    Items[Index].FNID_50.uFlags := (Items[Index].FNID_50.uFlags or NIF_INFO);
    Items[Index].FNID_50.hIcon := Items[Index].FNID_50.hIcon;
    StrPCopy(Items[Index].FNID_50.szTip, Items[Index].FHint);
    StrPCopy(Items[Index].FNID_50.szInfo, Info);
    StrPCopy(Items[Index].FNID_50.szInfoTitle, Title);
    Items[Index].FNID_50.uTimeout := TimeOut;
    Items[Index].FNID_50.dwInfoFlags := TOOL_TIP_CONST[LogType];
  end;
  if (Items[Index].FIsActive) then
    Shell_NotifyIcon(NIM_MODIFY, @Items[Index].FNID_50);
end;

procedure _WndProc(Index: AInteger; var Msg: TMessage);
begin
  if (Msg.Msg = Items[Index].FTrayIconMsg) then
  begin
    case Msg.LParam of
      WM_LBUTTONDBLCLK:
        _DoDblClick(Index);
      WM_LBUTTONUP:
        _DoLeftClick(Index);
      WM_RBUTTONUP:
        _DoRightClick(Index);
    end;
  end
  else
    DefWindowProc(Items[Index].FWindowHandle, Msg.Msg, Msg.wParam, Msg.lParam);
end;

// --- AUiTrayIcon ---

function AUiTrayIcon_Free(TrayIcon: ATrayIcon): AError;
var
  I: AInteger;
begin
  try
    I := _Find(TrayIcon);
    if (I < 0) then
    begin
      Result := -2;
      Exit;
    end;

    _Free(I);
    _Delete(I);
    Result := 0;
  except
    Result := -2;
  end;
end;

function AUiTrayIcon_GetHint(TrayIcon: ATrayIcon; out Value: AString_Type): AError;
var
  I: AInteger;
begin
  try
    I := _Find(TrayIcon);
    if (I < 0) then
    begin
      Result := -2;
      Exit;
    end;

    AString_AssignP(Value, Items[I].FHint);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiTrayIcon_GetHintP(TrayIcon: ATrayIcon): APascalString;
var
  I: AInteger;
begin
  try
    I := _Find(TrayIcon);
    if (I < 0) then
    begin
      Result := '';
      Exit;
    end;

    Result := Items[I].FHint;
  except
    Result := '';
  end;
end;

function AUiTrayIcon_GetMenuItems(TrayIcon: ATrayIcon): AMenuItem;
var
  I: AInteger;
begin
  try
    I := _Find(TrayIcon);
    if (I < 0) then
    begin
      Result := 0;
      Exit;
    end;
    Result := _GetMenuItems(I);
  except
    Result := 0;
  end;
end;

function AUiTrayIcon_GetPopupMenu(TrayIcon: ATrayIcon): AInt;
var
  I: AInteger;
begin
  try
    I := _Find(TrayIcon);
    if (I < 0) then
    begin
      Result := 0;
      Exit;
    end;

    Result := AInteger(Items[I].FPopupMenu);
  except
    Result := 0;
  end;
end;

function AUiTrayIcon_New(): ATrayIcon;
begin
  Result := ATrayIcon(TAUiTrayIcon.Create());
end;

function AUiTrayIcon_SetHint(TrayIcon: ATrayIcon; const Value: AString_Type): AError;
begin
  Result := AUiTrayIcon_SetHintP(TrayIcon, AString_ToPascalString(Value));
end;

function AUiTrayIcon_SetHintP(TrayIcon: ATrayIcon; const Value: APascalString): AError;
var
  I: AInteger;
begin
  try
    I := _Find(TrayIcon);
    if (I < 0) then
    begin
      Result := -2;
      Exit;
    end;

    _SetHint(I, Value);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiTrayIcon_SetIcon(TrayIcon: ATrayIcon; Icon: AIcon): AError;
var
  I: AInteger;
begin
  I := _Find(TrayIcon);
  if (I < 0) then
  begin
    Result := -2;
    Exit;
  end;
  if (Icon = 0) then
  begin
    Result := -3;
    Exit;
  end;
  if not(TObject(Icon) is TIcon) then
  begin
    Result := -4;
    Exit;
  end;

  try
    Items[I].FIcon.Assign(TIcon(Icon));
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiTrayIcon_SetIsActive(TrayIcon: ATrayIcon; Value: ABoolean): AError;
var
  I: AInteger;
begin
  try
    I := _Find(TrayIcon);
    if (I < 0) then
    begin
      Result := -2;
      Exit;
    end;

    _SetIsActive(I, Value);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiTrayIcon_SetOnLeftClick(TrayIcon: ATrayIcon; Value: AProc): AError;
var
  I: AInteger;
begin
  try
    I := _Find(TrayIcon);
    if (I < 0) then
    begin
      Result := -2;
      Exit;
    end;

    Items[I].FOnLeftClick := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiTrayIcon_SetOnRightClick(TrayIcon: ATrayIcon; Value: AProc): AError;
var
  I: AInteger;
begin
  try
    I := _Find(TrayIcon);
    if (I < 0) then
    begin
      Result := -2;
      Exit;
    end;

    Items[I].FOnRightClick := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiTrayIcon_SetPopupMenu(TrayIcon: ATrayIcon; Value: AInt): AError;
var
  I: AInteger;
begin
  try
    I := _Find(TrayIcon);
    if (I < 0) then
    begin
      Result := -2;
      Exit;
    end;
    if (Value = 0) then
    begin
      Result := -3;
      Exit;
    end;
    if not(TObject(Value) is TPopupMenu) then
    begin
      Result := -4;
      Exit;
    end;

    Items[I].FPopupMenu := TPopupMenu(Value);
    Result := 0;
  except
    Result := -2;
  end;
end;

{ TAUITrayIcon }

constructor TAUiTrayIcon.Create;
begin
  inherited;
  _New(ATrayIcon(Self), OnChangeIcon, WndProc);
end;

destructor TAUiTrayIcon.Destroy();
var
  I: AInteger;
begin
  I := _Find(ATrayIcon(Self));
  if (I < 0) then
    Exit;
  _Free(I);
  inherited;
end;

procedure TAUiTrayIcon.OnChangeIcon(Sender: TObject);
var
  I: AInteger;
begin
  I := _Find(ATrayIcon(Self));
  if (I < 0) then
    Exit;
  if (Items[I].FIsActive) then
    _ModifyIcon(I, NIM_MODIFY);
end;

procedure TAUiTrayIcon.WndProc(var AMsg: TMessage);
var
  I: AInteger;
begin
  I := _Find(ATrayIcon(Self));
  if (I < 0) then
    Exit;
  _WndProc(I, AMsg);
end;

procedure TAUiTrayIcon.ShowToolTip(ATimeOut: LongWord; AType: TLogTypeMessage; const ATitle, AInfo: AnsiString);
var
  I: AInteger;
begin
  I := _Find(ATrayIcon(Self));
  if (I < 0) then
    Exit;
  _ShowToolTip(I, ATimeOut, AType, ATitle, AInfo);
end;

{$ENDIF}

end.
