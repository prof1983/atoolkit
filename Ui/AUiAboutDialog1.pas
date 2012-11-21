{**
@Abstract AUi about dialog win 2
@Author Prof1983 <prof1983@ya.ru>
@Created 14.11.2012
@LastMod 21.11.2012
}
unit AUiAboutDialog1;

interface

uses
  Forms,
  ABase, AProgramUtils,
  AUiAboutDialog, AUiBase, AUiControls,
  fAbout;

function AboutForm_Init1(AboutForm: TAboutForm): AError;

implementation

function AboutForm_Init1(AboutForm: TAboutForm): AError;
begin
  Result := AUiControl_SetTextP(AControl(AboutForm.Memo), GetProgramVersionInfoStr(ParamStr(0)));
  AboutForm.Image1.Picture.Assign(Application.Icon);
end;

end.
