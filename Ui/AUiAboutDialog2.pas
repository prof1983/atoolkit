{**
@Abstract AUi about dialog win 1
@Author Prof1983 <prof1983@ya.ru>
@Created 14.11.2012
@LastMod 20.11.2012
}
unit AUiAboutDialog2;

interface

uses
  ABase, AConsts2, AUtils, ASystem,
  AUiAboutDialog, AUiControls, AUiTextView,
  fAbout;

function AboutForm_Init2(var AboutForm: TAboutFormRec; Flags: AUiAboutFlags;
    MemoWidth, MemoHeight: AInt): AError;

// Default MemoWidth=250, MemoHeight=115
//procedure ShowAboutWinA(MemoWidth, MemoHeight: Integer);

implementation

// --- Public ---

function AboutForm_Init2(var AboutForm: TAboutFormRec; Flags: AUiAboutFlags;
    MemoWidth, MemoHeight: AInt): AError;

  procedure Print(const ParamName, ParamValue: APascalString);
  begin
    if (ParamValue <> '') then
      AUiTextView_AddLineP(AboutForm.Memo, ParamName + ParamValue);
  end;

var
  I: AInt;
  J: AInt;
  S: APascalString;
begin
  AboutForm_SetReferenceP(AboutForm, ASystem.Info_GetUrlP());
  S := ASystem.Info_GetProductNameP();
  if (S <> '') then
    AUiControl_SetTextP(AboutForm.NameText, S);
  S := ASystem.Info_GetProgramNameP();
  Print(cProgramName, S);
  S := ASystem.Info_GetProgramVersionStrP();
  Print(cProgramVersion, S);
  S := ASystem.Info_GetProductVersionStrP();
  Print(cProductVersion, S);
  S := ASystem.Info_GetCopyrightP();
  Print('', S);
  S := ASystem.Info_GetCompanyNameP();
  Print(cCompanyName, S);
  S := ASystem.Info_GetDescriptionP();
  Print('', S);

  if (Flags and AUiAboutFlags_NoShowComment = 0) then
  begin
    S := ASystem.Info_GetCommentsWS();
    Print('', S);
  end;

  AboutForm.Form.Caption := cAboutCaption;

  S := ASystem.Info_GetDirectoryPathWS() + ASystem.Info_GetProgramNameWS() + '.bmp';

  if FileExistsP(S) then
  try
    AboutForm.Image.Picture.LoadFromFile(S);
  except
    AboutForm_LoadApplicationIcon(AboutForm);
  end
  else
    AboutForm_LoadApplicationIcon(AboutForm);

  if (MemoWidth > 0) then
  begin
    AUiControl_SetWidth(AboutForm.NameText, MemoWidth);
    AUiControl_SetWidth(AboutForm.Memo, MemoWidth);
  end;

  if (MemoHeight > 0) then
    AUiControl_SetHeight(AboutForm.Memo, MemoHeight);

  AUiControl_GetPosition(AboutForm.Memo, I, J);
  AboutForm.Form.ClientWidth :=  I + AUiControl_GetWidth(AboutForm.Memo) + 8;
  AboutForm.Form.ClientHeight := J + AUiControl_GetHeight(AboutForm.Memo) + AboutForm.UrlText.Height + AboutForm.ButtonsPanel.Height + 8;

  Result := 0;
end;

{procedure ShowAboutWinA(MemoWidth, MemoHeight: Integer);
var
  Form: TAboutForm;
begin
  Form := TAboutForm.Create(nil);
  try
    AboutForm_Init2(Form.FAboutForm, AUiAboutFlags_ShowAll + AUiAboutFlags_NoShowComment, MemoWidth, MemoHeight);
    Form.ShowModal;
  finally
    Form.Free;
  end;
end;}

end.
