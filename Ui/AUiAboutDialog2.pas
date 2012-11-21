{**
@Abstract AUi about dialog win 1
@Author Prof1983 <prof1983@ya.ru>
@Created 14.11.2012
@LastMod 21.11.2012
}
unit AUiAboutDialog2;

interface

uses
  ABase, AConsts2, AUtils, ASystem,
  AUiAboutDialog, AUiBase, AUiControls, AUiTextView,
  fAbout;

function AboutForm_Init2(AboutForm: TAboutForm; Flags: AUiAboutFlags;
    MemoWidth, MemoHeight: AInt): AError;

implementation

// --- Public ---

function AboutForm_Init2(AboutForm: TAboutForm; Flags: AUiAboutFlags;
    MemoWidth, MemoHeight: AInt): AError;

  procedure Print(const ParamName, ParamValue: APascalString);
  begin
    if (ParamValue <> '') then
      AUiTextView_AddLineP(AControl(AboutForm.Memo), ParamName + ParamValue);
  end;

var
  I: AInt;
  J: AInt;
  S: APascalString;
begin
  AboutForm_SetReferenceP(AboutForm, ASystem.Info_GetUrlP());
  S := ASystem.Info_GetProductNameP();
  if (S <> '') then
    AUiControl_SetTextP(AControl(AboutForm.lbName), S);
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

  AboutForm.Caption := cAboutCaption;

  S := ASystem.Info_GetDirectoryPathWS() + ASystem.Info_GetProgramNameWS() + '.bmp';

  if FileExistsP(S) then
  try
    AboutForm.Image1.Picture.LoadFromFile(S);
  except
    AboutForm_LoadApplicationIcon(AboutForm);
  end
  else
    AboutForm_LoadApplicationIcon(AboutForm);

  if (MemoWidth > 0) then
  begin
    AUiControl_SetWidth(AControl(AboutForm.lbName), MemoWidth);
    AUiControl_SetWidth(AControl(AboutForm.Memo), MemoWidth);
  end;

  if (MemoHeight > 0) then
    AUiControl_SetHeight(AControl(AboutForm.Memo), MemoHeight);

  AUiControl_GetPosition(AControl(AboutForm.Memo), I, J);
  AboutForm.ClientWidth :=  I + AUiControl_GetWidth(AControl(AboutForm.Memo)) + 8;
  AboutForm.ClientHeight := J + AUiControl_GetHeight(AControl(AboutForm.Memo)) + AboutForm.UrlText.Height + AboutForm.ButtonsPanel.Height + 8;

  Result := 0;
end;

end.
