{**
@Abstract AUi about dialog win 2
@Author Prof1983 <prof1983@ya.ru>
@Created 14.11.2012
@LastMod 14.11.2012
}
unit AUiAboutDialog1;

interface

uses
  ABase, AProgramUtils,
  AUiAboutDialog, AUiControls;

function AboutForm_Init1(var AboutForm: TAboutFormRec): AError;

implementation

function AboutForm_Init1(var AboutForm: TAboutFormRec): AError;
begin
  Result := AUiControl_SetTextP(AboutForm.Memo, GetProgramVersionInfoStr(ParamStr(0)));
end;

end.
