{**
@Author Prof1983 <prof1983@ya.ru>
@Created 29.01.2013
@LastMod 16.04.2013
}
unit AUiErrorDialog;

{$define AStdCall}

interface

uses
  Graphics,
  ABase,
  ABaseTypes,
  AStringMain,
  AUiBase,
  AUiButtons,
  AUiControls,
  AUiTextView,
  AUiWindows;

function AUi_ExecuteErrorDialog(const Caption, UserMessage,
    ExceptMessage: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteErrorDialogA(Caption, UserMessage,
    ExceptMessage: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteErrorDialogP(const Caption, UserMessage,
    ExceptMessage: APascalString): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

uses
  AUiDialogs;

type
  TErrorWin = class
  public
    Window: AWindow;
    Memo: AControl;
  public
    DetailStr: string;
    MessageStr: string;
  end;

var
  ErrorWin: TErrorWin;

// --- Events ---

function DoDetailButtonClick(Obj, Data: AInt): AError; stdcall;
begin
  Result := AUiControl_SetTextP(ErrorWin.Memo, ErrorWin.MessageStr + #13#10#13#10 + ErrorWin.DetailStr);
  AUiTextView_SetScrollBars(ErrorWin.Memo, AUiScrollStyle_Vertical);
  AUiControl_SetHeight(ErrorWin.Window, 200);
end;

// --- Private ---

function _CreateErrorForm(Window: AWindow): TErrorWin;
var
  ErrorWin: TErrorWin;
begin
  ErrorWin := TErrorWin.Create();
  ErrorWin.Window := Window;
  AUiControl_SetClientSize(Window, 380, 100);
  AUiControl_SetPosition(Window, 200, 100);
  AUiWindow_SetPosition(Window, AUiWindowPosition_ScreenCenter);

  ErrorWin.Memo := AUiTextView_New(Window, 0);
  AUiControl_SetPosition(ErrorWin.Memo, 1, 6);
  AUiControl_SetSize(ErrorWin.Memo, 370, 50);
  AUiControl_SetColor(ErrorWin.Memo, clBtnFace);
  AUiControl_SetAlign(ErrorWin.Memo, uiAlignClient);

  Result := ErrorWin;
end;

procedure _ShowErrorA(const Caption, UserMessage, ExceptMessage: string);
var
  Dialog: ADialog;
  Window: AWindow;
begin
  Dialog := AUiDialog_New(AMessageBoxFlags_Ok);
  if (ExceptMessage <> '') then
    AUiDialog_AddButton1P(Dialog, 100, 100, 'œÓ‰Ó·ÌÓ', DoDetailButtonClick);
  Window := AUiDialog_GetWindow(Dialog);
  ErrorWin := _CreateErrorForm(Window);
  ErrorWin.MessageStr := UserMessage;
  ErrorWin.DetailStr := ExceptMessage;
  if (Caption <> '') then
    AUiControl_SetTextP(Window, Caption)
  else
    AUiControl_SetTextP(Window, '¬Õ»Ã¿Õ»≈!');
  AUiControl_SetTextP(ErrorWin.Memo, UserMessage);
  AUiDialog_ShowModal(Dialog);
  AUiDialog_Free(Dialog);
end;

// --- AUi ---

function AUi_ExecuteErrorDialog(const Caption, UserMessage, ExceptMessage: AString_Type): AError;
begin
  Result := AUi_ExecuteErrorDialogP(
      AString_ToPascalString(Caption),
      AString_ToPascalString(UserMessage),
      AString_ToPascalString(ExceptMessage));
end;

function AUi_ExecuteErrorDialogA(Caption, UserMessage, ExceptMessage: AStr): AError;
begin
  Result := AUi_ExecuteErrorDialogP(AnsiString(Caption), AnsiString(UserMessage),
      AnsiString(ExceptMessage));
end;

function AUi_ExecuteErrorDialogP(const Caption, UserMessage, ExceptMessage: APascalString): AError;
begin
  try
    _ShowErrorA(Caption, UserMessage, ExceptMessage);
    Result := 0;
  except
    Result := -1;
  end;
end;

end.
