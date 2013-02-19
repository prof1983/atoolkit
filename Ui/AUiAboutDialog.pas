{**
@Abstract AUi common about dialog win
@Author Prof1983 <prof1983@ya.ru>
@Created 14.11.2012
@LastMod 19.02.2013
}
unit AUiAboutDialog;

{define AStdCall}

interface

uses
  Controls,
  ExtCtrls,
  Forms,
  Graphics,
  StdCtrls,
  ABase,
  ABaseTypes,
  AConsts2,
  ASystemMain,
  AUtilsMain,
  AUiBase,
  AUiBox,
  AUiControls,
  AUiData,
  AUiImages,
  AUiLabels,
  AUiTextView;

// --- AUiAboutDialog ---

function AUiAboutDialog_Init2(AboutDialog: ADialog): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiAboutDialog_New(): ADialog; {$ifdef AStdCall}stdcall;{$endif}

// --- AUi ---

function AUi_ExecuteAboutDialog(): AError; {$ifdef AStdCall}stdcall;{$endif}

//function AUi_InitAboutDialog1(AboutDialog: AWindow): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_InitAboutDialogWin2(AboutDialog: AWindow): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_NewAboutDialog(): AWindow; {$ifdef AStdCall}stdcall;{$endif} deprecated {$ifdef ADeprText}'Use AUiAboutDialog_New()'{$endif};

implementation

uses
  AUiDialogs;

type
  AUiAboutFlags = type AInt;
const
  AUiAboutFlags_NoShowComment = $00010000;
  AUiAboutFlags_ShowAll = $0000FFFF;

type
  TAboutWin = record
    Dialog: ADialog;
    Window: AWindow;
    ButtonsBox: AControl;
    UrlText: AControl;
    Panel: AControl;
    Image: AControl;
    NameText: AControl;
    Memo: AControl;
  end;

var
  AboutWin: TAboutWin;

// --- Forward ---

function _AboutForm_LoadApplicationIcon(const AboutWin: TAboutWin): AError; forward;

function _AboutForm_SetReferenceP(const AboutForm: TAboutWin; const Value: APascalString): AError; forward;

// --- Events ---

function DoAboutWinUrlTextClick(Obj, Data: AInt): AError; stdcall;
begin
  if (Obj = AboutWin.UrlText) then
    ASystem_ShellExecuteP('Open', AUiControl_GetTextP(AboutWin.UrlText), '', '');
  Result := 0;
end;

// --- Private ---

function _AboutForm_Init2(var AboutWin: TAboutWin; Flags: AUiAboutFlags;
    MemoWidth, MemoHeight: AInt): AError;

  procedure Print(const ParamName, ParamValue: APascalString);
  begin
    if (ParamValue <> '') then
      AUiTextView_AddLineP(AboutWin.Memo, ParamName + ParamValue);
  end;

var
  I: AInt;
  J: AInt;
  S: APascalString;
begin
  _AboutForm_SetReferenceP(AboutWin, ASystem_GetUrlP());
  S := ASystem_GetProductNameP();
  if (S <> '') then
    AUiControl_SetTextP(AboutWin.NameText, S);
  S := ASystem_GetProgramNameP();
  Print(cProgramName, S);
  S := ASystem_GetProgramVersionStrP();
  Print(cProgramVersion, S);
  S := ASystem_GetProductVersionStrP();
  Print(cProductVersion, S);
  S := ASystem_GetCopyrightP();
  Print('', S);
  S := ASystem_GetCompanyNameP();
  Print(cCompanyName, S);
  S := ASystem_GetDescriptionP();
  Print('', S);

  if (Flags and AUiAboutFlags_NoShowComment = 0) then
  begin
    S := ASystem_GetCommentsP();
    Print('', S);
  end;

  AUiControl_SetTextP(AboutWin.Window, cAboutCaption);

  S := ASystem_GetDirectoryPathP() + ASystem_GetProgramNameP() + '.bmp';

  if AUtils_FileExistsP(S) then
  try
    AUiImage_LoadFromFileP(AboutWin.Image, S);
  except
    _AboutForm_LoadApplicationIcon(AboutWin);
  end
  else
    _AboutForm_LoadApplicationIcon(AboutWin);

  if (MemoWidth > 0) then
  begin
    AUiControl_SetWidth(AboutWin.NameText, MemoWidth);
    AUiControl_SetWidth(AboutWin.Memo, MemoWidth);
  end;

  if (MemoHeight > 0) then
    AUiControl_SetHeight(AboutWin.Memo, MemoHeight);

  AUiControl_GetPosition(AboutWin.Memo, I, J);
  AUiControl_SetClientSize(
      AboutWin.Window,
      I + AUiControl_GetWidth(AboutWin.Memo) + 8,
      J + AUiControl_GetHeight(AboutWin.Memo) + AUiControl_GetHeight(AboutWin.UrlText) + AUiControl_GetHeight(AboutWin.ButtonsBox) + 8);

  Result := 0;
end;

function _AboutForm_LoadApplicationIcon(const AboutWin: TAboutWin): AError;
begin
  TImage(AboutWin.Image).Picture.Assign(Application.Icon);
  Result := 0;
end;

function _AboutForm_SetReferenceP(const AboutForm: TAboutWin; const Value: APascalString): AError;
begin
  AUiControl_SetTextP(AboutWin.UrlText, Value);
  Result := 0;
end;

function _CreateAboutWin(Dialog: ADialog): AError;
var
  H: AInt;
begin
  AboutWin.Dialog := Dialog;
  AboutWin.Window := AUiDialog_GetWindow(Dialog);

  AboutWin.ButtonsBox := 0;
  AboutWin.UrlText := 0;
  AboutWin.Panel := 0;
  AboutWin.Image := 0;
  AboutWin.NameText := 0;
  AboutWin.Memo := 0;

  // -- ButtonsBox --

  AboutWin.ButtonsBox := AUiDialog_GetButtonsBox(Dialog);
  H := AUiControl_GetClientHeight(AboutWin.Window);

  // -- UrlText --

  AboutWin.UrlText := AUiLabel_New(AboutWin.Window);
  AUiControl_SetPosition(AboutWin.UrlText, 4, H - 16 - DialogButtonsBoxHeight);
  AUiControl_SetAnchors(AboutWin.UrlText, uiakLeft + uiakBottom);
  AUiControl_SetCursor(AboutWin.UrlText, crHandPoint);
  AUiControl_SetFontColor(AboutWin.UrlText, clBlue);
  AUiControl_SetFontStyle(AboutWin.UrlText, uifsUnderline);
  AUiControl_SetOnClick(AboutWin.UrlText, DoAboutWinUrlTextClick);

  // --- Panel1 ---

  AboutWin.Panel := AUiBox_New(AboutWin.Window, ABoxType_Simple);
  AUiControl_SetPosition(AboutWin.Panel, 4, 16);
  AUiControl_SetSize(AboutWin.Panel, 83, 83);
  AUiControl_SetBevel(AboutWin.Panel, AUiBevel_InnerLowered, -1);

  AboutWin.Image := AUiImage_New(AboutWin.Panel);
  AUiControl_SetPosition(AboutWin.Image, 2, 2);
  AUiControl_SetAlign(AboutWin.Image, uiAlignClient);
  AUiImage_SetCenter(AboutWin.Image, True);
  AUiImage_SetTransparent(AboutWin.Image, True);

  // -- NameText --

  AboutWin.NameText := AUiLabel_New(AboutWin.Window);
  AUiControl_SetAnchors(AboutWin.NameText, uiakLeft + uiakTop + uiakRight);
  AUiControl_SetFont1P(AboutWin.NameText, 'Times New Roman', 11);
  AUiControl_SetPosition(AboutWin.NameText, 96, 0);
  AUiControl_SetSize(AboutWin.NameText, 250, 40);
  AUiLabel_SetAlignment(AboutWin.NameText, uitaCenter + uitlCenter);
  AUiLabel_SetAutoSize(AboutWin.NameText, False);
  AUiLabel_SetWordWrap(AboutWin.NameText, True);
  AUiControl_SetTextP(AboutWin.NameText, 'Assistant');

  // -- Memo --

  AboutWin.Memo := AUiTextView_New(AboutWin.Window, 0);
  AUiControl_SetColor(AboutWin.Memo, clBtnFace);
  AUiControl_SetPosition(AboutWin.Memo, 96, 40);
  AUiControl_SetSize(AboutWin.Memo, 260, 140);
  AUiTextView_SetScrollBars(AboutWin.Memo, AInt(ssVertical));
  AUiTextView_SetReadOnly(AboutWin.Memo, True);
  AUiTextView_SetWordWrap(AboutWin.Memo, True);
  AUiControl_SetTabStop(AboutWin.Memo, False);

  Result := 0;
end;

// --- AUi ---

function AUi_ExecuteAboutDialog(): AError;
var
  Dialog: ADialog;
begin
  Dialog := AUiAboutDialog_New();
  Result := AUiAboutDialog_Init2(Dialog);
  {try
    ShowAboutWinA(UiAboutWinMemoWidthDefault, UiAboutWinMemoHeightDefault);
    Result := 0;
  except
    Result := -1;
  end;}
end;

{function AUi_InitAboutDialog1(AboutDialog: AWindow): AError;
begin
  if not(TObject(AboutDialog) is TAboutForm) then
  begin
    Result := -2;
    Exit;
  end;

  try
    Result := AboutForm_Init1(TAboutForm(AboutDialog).FAboutForm);
  except
    Result := -1;
  end;
end;}

function AUi_InitAboutDialogWin2(AboutDialog: AWindow): AError;
begin
  if (AboutWin.Window <> AboutDialog) then
  begin
    Result := -2;
    Exit;
  end;

  try
    Result := _AboutForm_Init2(AboutWin, AUiAboutFlags_ShowAll + AUiAboutFlags_NoShowComment,
        UiAboutWinMemoWidthDefault, UiAboutWinMemoHeightDefault);
  except
    Result := -1;
  end;
end;

function AUi_NewAboutDialog(): AWindow;
var
  Dialog: ADialog;
begin
  Dialog := AUiAboutDialog_New();
  Result := AUiDialog_GetWindow(Dialog);
end;

// --- AUiAboutDialog ---

function AUiAboutDialog_Init2(AboutDialog: ADialog): AError;
begin
  if not(AboutWin.Dialog = AboutDialog) then
  begin
    Result := -2;
    Exit;
  end;

  try
    Result := _AboutForm_Init2(AboutWin, AUiAboutFlags_ShowAll + AUiAboutFlags_NoShowComment,
        UiAboutWinMemoWidthDefault, UiAboutWinMemoHeightDefault);
  except
    Result := -1;
  end;
end;

function AUiAboutDialog_New(): ADialog;
var
  Dialog: ADialog;
begin
  try
    Dialog := AUiDialog_New(AMessageBoxFlags_Ok);
    _CreateAboutWin(Dialog);
    Result := Dialog;
  except
    Result := 0;
  end;
end;

{ Public procs }

{function AboutForm_AddButton(const AboutForm: TAboutFormRec; Left, Width: AInt;
    const Text: APascalString; OnClick: ACallbackProc): AControl;
begin
  TODO: Use AUiDialog_AddButton1P()
end;}

{function AboutForm_GetProgramNameP(const AboutForm: TAboutFormRec): APascalString;
begin
  Result := AUiControl_GetTextP(AboutForm.NameText);
end;}

{function AboutForm_LoadApplicationIcon(const AboutForm: TAboutFormRec): AError;
begin
  AboutForm.Image.Picture.Assign(Application.Icon);
  Result := 0;
end;}

{function AboutForm_SetProgramNameP(const AboutForm: TAboutFormRec; const Value: APascalString): AError;
begin
  Result := AUiControl_SetTextP(AboutForm.NameText, Value);
end;}

{ TAboutForm }

{procedure TAboutWin.FormResize(Sender: TObject);
begin
  AUiControl_SetWidth(
      OkButton,
      AUiControl_GetWidth(ButtonsBox) - AUiControl_GetWidth(OkButton) - 4);
  AUiControl_SetTop(UrlText, AUiControl_GetTop(ButtonsBox) - AUiControl_GetHeight(UrlText) - 4);
end;}

{function TAboutWin.GetPicture(): TPicture;
begin
  Result := FAboutForm.Image.Picture;
end;}

{function TAboutWin.GetReference(): APascalString;
begin
  Result := FAboutForm.UrlText.Caption;
end;}

end.
