{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(28.06.2011)
@LastMod(25.08.2011)
@Version(0.5)
}
unit AUiButton;

interface

uses
  Buttons, Controls,
  AUiBase, AUiData, AUiEvents;

function UI_Button_New(Parent: AControl): AButton;
procedure UI_Button_SetKind(Button: AButton; Kind: TAUIButtonKind);

implementation

{ UI_Button }

function UI_Button_New(Parent: AControl): AButton;
var
  Button: TBitBtn;
  I: Integer;
begin
  Button := TBitBtn.Create(TWinControl(Parent));
  Button.Parent := TWinControl(Parent);
  Button.OnClick := UI_.ButtonClick;
  Result := AddObject(Button);

  I := Length(FButtons);
  SetLength(FButtons, I + 1);
  FButtons[I].Button := Result;
end;

procedure UI_Button_SetKind(Button: AButton; Kind: TAUIButtonKind);
begin
  TBitBtn(Button).Kind := TBitBtnKind(Kind);
end;

end.
 