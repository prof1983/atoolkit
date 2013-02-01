{**
@Author Prof1983 <prof1983@ya.ru>
@Created 29.01.2013
@LastMod 29.01.2013
}
unit AUiErrorDialog;

{define AStdCall}

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
    Button1: AButton;
    Button2: AButton;
  public
    DetailStr: string;
    MessageStr: string;
  end;

var
  ErrorWin: TErrorWin;

// --- Events ---

function DoErrorWinButtonClick(Obj, Data: AInt): AError; stdcall;
begin
  if (ErrorWin.Button1 = Obj) then
    AUiControl_SetTextP(ErrorWin.Memo, ErrorWin.MessageStr)
  else if (ErrorWin.Button2 = Obj) then
    AUiControl_SetTextP(ErrorWin.Memo, ErrorWin.DetailStr);
  Result := 0;
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
  AUiControl_SetTextP(Window, 'ВНИМАНИЕ!');
  AUiWindow_SetPosition(Window, AUiWindowPosition_ScreenCenter);

  ErrorWin.Button1 := AUiButton_New(Window);
  AUiControl_SetPosition(ErrorWin.Button1, 176, 63);
  AUiControl_SetSize(ErrorWin.Button1, 100, 30);
  AUiControl_SetTextP(ErrorWin.Button1, 'Кратко');
  AUiControl_SetOnClick(ErrorWin.Button1, DoErrorWinButtonClick);

  ErrorWin.Button2 := AUiButton_New(Window);
  AUiControl_SetPosition(ErrorWin.Button2, 272, 63);
  AUiControl_SetSize(ErrorWin.Button2, 100, 30);
  AUiControl_SetTextP(ErrorWin.Button2, 'Подробно');
  AUiControl_SetOnClick(ErrorWin.Button2, DoErrorWinButtonClick);

  ErrorWin.Memo := AUiTextView_New(Window, 0);
  AUiControl_SetPosition(ErrorWin.Memo, 1, 6);
  AUiControl_SetSize(ErrorWin.Memo, 370, 50);
  AUiControl_SetColor(ErrorWin.Memo, clBtnFace);

  Result := ErrorWin;
end;

procedure _ShowErrorA(const Caption, UserMessage, ExceptMessage: string);
var
  Dialog: ADialog;
  Window: AWindow;
begin
  Dialog := AUiDialog_New(AMessageBoxFlags_Ok);
  Window := AUiDialog_GetWindow(Dialog);
  ErrorWin := _CreateErrorForm(Window);
  ErrorWin.MessageStr := UserMessage;
  ErrorWin.DetailStr := ExceptMessage;
  AUiControl_SetTextP(Window, Caption);
  AUiControl_SetTextP(ErrorWin.Memo, UserMessage);
  if (ExceptMessage = '') then
    AUiControl_SetEnabled(ErrorWin.Button2, False);
  AUiWindow_ShowModal(Window);
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
