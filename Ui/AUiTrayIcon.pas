﻿{**
@Abstract(Иконка в трее)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.12.2007)
@Lastmod(25.04.2012)
@Version(0.5)
}
unit AUiTrayIcon;

interface

uses
  {$IFDEF FPC}
  ExtCtrls;
  {$ELSE}
  Classes, Controls, Forms, Graphics, Menus, Messages, ShellApi, SysUtils, Windows,
  ABase;
  {$ENDIF}

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

  { Класс иконки в трее

    Данный класс реализует основную функциональность, для работы с иконкой
    в трее. Основным отличием от аналогичных компонентов является возможность
    отображать всплывающие подсказки.

    @member(Create          Конструктор объекта.
                            @param(AOwner Владелец данного объекта))
    @member(Destroy         Деструктор объекта. )
    @member(ShowToolTip     Показывает всплывающую подсказку в трее около активной иконки.
                            @param(ATimeOut Время в мс в течении которого подсказка
                                            будет отображаться в трее.)
                            @param(AType Тип иконки отображаемой слева в окне
                                         подсказки unGlobals.TLogTypeMessage.)
                            @param(ATitle Заголовок окна всплывающей подсказки.)
                            @param(AInfo Сообщение всплывающей подсказки.))
    @member(IsActive        Признак отображения иконки в трее.)
    @member(IsShowDesigning Признак разрешающий показывать иконку в режиме разработки.)
    @member(Icon            Иконка отображающаяся в трее.)
    @member(IDMessage       Текстовый идентификатор оконного сообщения. Должен быть
                            уникальным для каждого приложения.)
    @member(IsShowApp       Признак отображения окна приложения.)
    @member(Hint            Текст отображаемый при наведении курсора на иконку в трее.)
    @member(PopupMenu       Указатель на всплывающее меню связанное с иконкой в трее.
                            Отображается при возникновении события @link(OnDblClick).)
    @member(OnLeftClick     Событие возникающее при щелчке левой кнопкой мыши по иконке в трее.)
    @member(OnDblClick      Событие возникающее при двойном щелчке левой кнопкой мыши по иконке в трее.)
    @member(OnRightClick    Событие возникающее при щелчке правой кнопкой мыши по иконке в трее.
                            При этом если заданно всплывающее меню @link(PopupMenu)(), то сначала
                            будет произведенно отображение меню, а потом передано управление
                            в этот обработчик.)
  }
  TAUITrayIcon = class
  private
    FWindowHandle: HWND;
    FIcon: TIcon;
    FNID_50: TNotifyIconData_50;
    FHint: AnsiString;
    FPopupMenu: TPopupMenu;
    FTrayIconMsg: LongWord;
    FIsActive: Boolean;
    FIsShowDesigning: Boolean;
    FIDMessage: string;
    procedure SetIsActive(Value: Boolean);
    procedure SetIsShowDesigning(Value: Boolean);
    procedure SetIcon(Value: TIcon);
    procedure ModifyIcon(ACommand: LongWord);
    procedure OnChangeIcon(Sender: TObject);
    procedure SetHint(Value: AnsiString);
    procedure WndProc(var AMsg: TMessage);
    procedure DoRightClick(Sender: TObject);
    procedure SetIDMessage(AValue: string);
    procedure DoDblClick(Sender: TObject);
    procedure DoLeftClick(Sender: TObject);
  public
    FOnLeftClick: AProc;
    FOnDblClick: AProc;
    FOnRightClick: AProc;
    constructor Create;
    destructor Destroy; override;
  public
    procedure ShowToolTip(ATimeOut: LongWord; AType: TLogTypeMessage; const ATitle, AInfo: AnsiString);
  public //published
    // Отображать иконку
    property IsActive: Boolean read FIsActive write SetIsActive;
    property IsShowDesigning: Boolean read FIsShowDesigning write SetIsShowDesigning;
    // Изображение иконки
    property Icon: TIcon read FIcon write SetIcon;
    property IDMessage: string read FIDMessage write SetIDMessage;
    // Всплывающая подсказка
    property Hint: AnsiString read FHint write SetHint;
    // Контекстное меню
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu;
    // Событие. Срабытывает при нажатии левой кнопкой.
    //property OnLeftClick: TAProc read FOnLeftClick write FOnLeftClick;
    // Событие. Срабатывает при двойном нажатии.
    //property OnDblClick: TAProc read FOnDblClick write FOnDblClick;
    // Событие. Срабатывает при нажатии правой кнопкой.
    //property OnRightClick: TAProc read FOnRightClick write FOnRightClick;
  end;

procedure TrayIcon_Free(TrayIcon: Integer);
function TrayIcon_GetHint(TrayIcon: Integer): APascalString; stdcall;
function TrayIcon_GetPopupMenu(TrayIcon: Integer): Integer; stdcall;
procedure TrayIcon_SetHint(TrayIcon: Integer; const Value: APascalString); stdcall;
procedure TrayIcon_SetOnLeftClick(TrayIcon: Integer; Value: AProc); stdcall;
procedure TrayIcon_SetOnRightClick(TrayIcon: Integer; Value: AProc); stdcall;
procedure TrayIcon_SetPopupMenu(TrayIcon, Value: Integer); stdcall;

{$ENDIF}

implementation

{$IFNDEF FPC}

{ TrayIcon }

procedure TrayIcon_Free(TrayIcon: Integer);
begin
  TAUITrayIcon(TrayIcon).Free;
end;

function TrayIcon_GetHint(TrayIcon: Integer): APascalString;
begin
  Result := TAUITrayIcon(TrayIcon).Hint;
end;

function TrayIcon_GetPopupMenu(TrayIcon: Integer): Integer;
begin
  Result := Integer(TAUITrayIcon(TrayIcon).PopupMenu);
end;

procedure TrayIcon_SetHint(TrayIcon: Integer; const Value: APascalString);
begin
  TAUITrayIcon(TrayIcon).Hint := Value;
end;

procedure TrayIcon_SetOnLeftClick(TrayIcon: Integer; Value: AProc);
begin
  TAUITrayIcon(TrayIcon).FOnLeftClick := Value;
end;

procedure TrayIcon_SetOnRightClick(TrayIcon: Integer; Value: AProc);
begin
  TAUITrayIcon(TrayIcon).FOnRightClick := Value;
end;

procedure TrayIcon_SetPopupMenu(TrayIcon, Value: Integer);
begin
  TAUITrayIcon(TrayIcon).PopupMenu := TPopupMenu(Value);
end;

{ TAUITrayIcon }

constructor TAUITrayIcon.Create;
begin
  inherited;
  ZeroMemory(@FNID_50, SizeOf(FNID_50));
  FHint := '';
  FIsActive := False;
  FIsShowDesigning := False;
  FIDMessage := 'Assistant';
  FIcon := TIcon.Create();
  FIcon.OnChange := OnChangeIcon;
  FTrayIconMsg := RegisterWindowMessage(PChar(FIDMessage + '_TrayIcon'));

  // Prof1983: 24.06.2011
  FWindowHandle := Classes.AllocateHWnd(WndProc);
  (*
  {$IFDEF COMPILER_12_UP}
  FWindowHandle := Classes.AllocateHWnd(WndProc);
  {$ELSE}
  FWindowHandle := Forms.AllocateHWnd(WndProc);
  {$ENDIF}
  *)

  FIcon.Assign(Application.Icon);
  IsActive := True;
  //FTrayPopupMenu := TPopupMenu.Create(nil);
  //FTrayIcon.PopupMenu := FTrayPopupMenu;
end;

destructor TAUITrayIcon.Destroy();
begin
  FPopupMenu := nil;
  FOnLeftClick := nil;
  FOnRightClick := nil;

  if (IsActive) then
    // Prof1983
    //if (not (csDesigning in ComponentState))or((csDesigning in ComponentState) and IsShowDesigning) then
      ModifyIcon(NIM_DELETE);

  // Prof1983: 24.06.2011
  Classes.DeallocateHWnd(FWindowHandle);
  //{$IFDEF VER130}Forms.DeallocateHWnd(FWindowHandle){$ELSE}Classes.DeallocateHWnd(FWindowHandle){$ENDIF};

  FreeAndNil(FIcon);
  inherited;
end;

procedure TAUITrayIcon.SetIDMessage(AValue: string);
begin
  if (AValue <> FIDMessage) then
  begin
    FIDMessage := AValue;
    FTrayIconMsg := RegisterWindowMessage(PChar(FIDMessage + '_TrayIcon'));
    // Prof1983
    //if (not (csDesigning in ComponentState))or((csDesigning in ComponentState) and IsShowDesigning) then
      if (FIsActive) then
        ModifyIcon(NIM_MODIFY);
  end;
end;

procedure TAUITrayIcon.SetIsActive(Value: Boolean);
begin
  if (Value <> FIsActive) then
  begin
    FIsActive := Value;
    // Prof1983
    //if (not (csDesigning in ComponentState))or((csDesigning in ComponentState) and IsShowDesigning) then
      if (FIsActive) then
        ModifyIcon(NIM_ADD)
      else
        ModifyIcon(NIM_DELETE);
  end;
end;

procedure TAUITrayIcon.SetIsShowDesigning(Value: Boolean);
begin
  if (Value <> FIsShowDesigning) then
  begin
    // Prof1983
    //if ((csDesigning in ComponentState)and(IsActive)) then
    if (IsActive) then
    begin
      FIsShowDesigning := Value;
      if (FIsShowDesigning) then
        ModifyIcon(NIM_ADD)
      else
        ModifyIcon(NIM_DELETE);
    end;    
  end;
end;

procedure TAUITrayIcon.ModifyIcon(ACommand: LongWord);
begin
  with FNID_50 do
  begin
    cbSize := SizeOf(FNID_50);
    uID := 1;
    uFlags := (NIF_ICON or NIF_TIP or NIF_MESSAGE);
    Wnd := FWindowHandle;
    uCallBackMessage := FTrayIconMsg;
    StrPCopy(szTip, Hint);
    hIcon := FIcon.Handle;
    StrPCopy(szInfo, '');
    StrPCopy(szInfoTitle, '');
    uTimeout := 0;
    dwInfoFlags := 0;
  end;
  Shell_NotifyIcon(ACommand, @FNID_50);
end;

procedure TAUITrayIcon.SetIcon(Value: TIcon);
begin
  if (Value = FIcon) then Exit;
  FIcon.Assign(Value);
  if (IsActive) then
    //if (not (csDesigning in ComponentState))or((csDesigning in ComponentState) and IsShowDesigning) then
      ModifyIcon(NIM_MODIFY);
end;

procedure TAUITrayIcon.OnChangeIcon(Sender: TObject);
begin
  if (IsActive) then
    //if (not (csDesigning in ComponentState))or((csDesigning in ComponentState) and IsShowDesigning) then
      ModifyIcon(NIM_MODIFY);
end;

procedure TAUITrayIcon.SetHint(Value: AnsiString);
begin
  if (Value = FHint) then Exit;
  if (Length(Value) > 62) then
    Value := Copy(Value, 1, 62);
  FHint := Value;
  if (IsActive) then
    //if (not (csDesigning in ComponentState))or((csDesigning in ComponentState) and IsShowDesigning) then
      ModifyIcon(NIM_MODIFY);
end;

procedure TAUITrayIcon.WndProc(var AMsg: TMessage);
begin
  with AMsg do
    if (Msg = FTrayIconMsg) then
    begin
      case LParam of
        WM_LBUTTONDBLCLK:
          DoDblClick(Self);
        WM_LBUTTONUP:
          DoLeftClick(Self);
        WM_RBUTTONUP:
          DoRightClick(Self);
      end;
    end else
      Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);
end;

procedure TAUITrayIcon.DoDblClick(Sender: TObject);
begin
  if Assigned(FOnDblClick) then
    FOnDblClick;
end;

procedure TAUITrayIcon.DoLeftClick(Sender: TObject);
begin
  if Assigned(FOnLeftClick) then
    FOnLeftClick;
  //else
  //  IsShowApp := not(IsShowApp);
end;

procedure TAUITrayIcon.DoRightClick(Sender: TObject);
var
  tmpMouseCo: TPoint;
begin
  GetCursorPos(tmpMouseCo);
  if Assigned(FPopupMenu) then
  begin
    SetForegroundWindow(Application.Handle);
    Application.ProcessMessages;
    PopupMenu.Popup(tmpMouseCo.X, tmpMouseCo.Y);
  end;
  if Assigned(FOnRightClick) then
    FOnRightClick; //(Self, mbRight, [], tmpMouseCo.x, tmpMouseCo.y);
end;

procedure TAUITrayIcon.ShowToolTip(ATimeOut: LongWord; AType: TLogTypeMessage; const ATitle, AInfo: AnsiString);
const
  NIF_INFO = $00000010;
  TOOL_TIP_CONST: array [TLogTypeMessage] of Word = ($00000000, $00000003, $00000002, $00000001);
begin
  with FNID_50 do
  begin
    uFlags := (uFlags or NIF_INFO);
    hIcon := hIcon;
    StrPCopy(szTip, Hint);
    StrPCopy(szInfo, AInfo);
    StrPCopy(szInfoTitle, ATitle);
    uTimeout := ATimeOut;
    dwInfoFlags := TOOL_TIP_CONST[AType];
  end;
  if (IsActive) then
    //if (not (csDesigning in ComponentState))or((csDesigning in ComponentState) and IsShowDesigning) then
      Shell_NotifyIcon(NIM_MODIFY, @FNID_50);
end;

{$ENDIF}

end.