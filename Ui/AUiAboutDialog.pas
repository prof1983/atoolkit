{**
@Abstract AUi common about dialog win
@Author Prof1983 <prof1983@ya.ru>
@Created 14.11.2012
@LastMod 14.11.2012
}
unit AUiAboutDialog;

interface

uses
  Controls, ExtCtrls, Forms, StdCtrls,
  ABase,
  AUiBase, AUiButtons, AUiControls;

type
  AUiAboutFlags = type AInt;
const
  AUiAboutFlags_NoShowComment = $00010000;
  AUiAboutFlags_ShowAll = $0000FFFF;

type
  TAboutFormRec = record
    Form: TForm;
    ButtonsPanel: TPanel;
    OkButton: AControl;
    UrlText: TLabel;
    Panel: TPanel;
    Image: TImage;
    NameText: AControl{TLabel};
    Memo: AControl;
  end;

function AboutForm_AddButton(const AboutForm: TAboutFormRec; Left, Width: AInt;
    const Text: APascalString; OnClick: ACallbackProc): AControl;

implementation

function AboutForm_AddButton(const AboutForm: TAboutFormRec; Left, Width: AInt;
    const Text: APascalString; OnClick: ACallbackProc): AControl;
var
  Button: AControl;
begin
  Button := AUiButton_New(AControl(AboutForm.ButtonsPanel));
  if (Button <> 0) then
  begin
    AUiControl_SetPosition(Button, Left, 4);
    AUiControl_SetSize(Button, Width, 25);
    AUiControl_SetTextP(Button, Text);
    AUiControl_SetOnClick(Button, OnClick);
    AUiControl_SetAnchors(Button, uiakRight + uiakBottom);
  end;
  Result := Button;
end;

end.
