{**
@Abstract AUi about form
@Author Prof1983 <prof1983@ya.ru>
@Created 04.04.2006
@LastMod 16.11.2012
}
unit fAbout;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  {$IFDEF FPC}LResources,{$ENDIF}
  {$IFDEF MSWINDOWS}ShellAPI, Windows,{$ENDIF}
  Buttons, Classes, Controls, Dialogs, ExtCtrls, Graphics, Forms, Messages, StdCtrls, SysUtils,
  ABase, ABaseUtils, ASystem,
  AUiAboutDialog, AUiBase, AUiButtons, AUiControls, AUiLabels, AUiTextView;

type
  TAboutForm = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    procedure FormResize(Sender: TObject);
  private
    procedure UrlTextClick(Sender: TObject);
  private
    function GetPicture: TPicture;
    function GetReference: APascalString;
    procedure SetReference(const Value: APascalString);
  protected
    procedure DoCreate; override;
  public
    FAboutForm: TAboutFormRec;
  public
    function AddButton(Left, Width: Integer; const Text: APascalString; OnClick: ACallbackProc): AControl;
    function AddButton02(Left, Width: Integer; const Text: APascalString; OnClick: ACallbackProc02): AControl;
    //procedure Init(); deprecated; // Use AboutForm_InitR()
    //procedure Init1(Flags: AUIAboutFlags); deprecated; // Use AboutForm_InitR()
    //procedure Init2(Flags: AUIAboutFlags; MemoWidth, MemoHeight: Integer); deprecated; // Use AboutForm_InitR()
    //procedure InitA(MemoWidth, MemoHeight: Integer); deprecated; // Use AboutForm_InitR()
    procedure LoadApplicationIcon;
  public
    {** Картинка для отображения }
    property Picture: TPicture read GetPicture;
    {** Ссылка на сайт программы }
    property Reference: APascalString read GetReference write SetReference;
  end;

function AboutForm_AddButton02(const AboutForm: TAboutFormRec; Left, Width: AInt;
    const Text: APascalString; OnClick: ACallbackProc02): AControl;

function AboutForm_GetProgramNameP(const AboutForm: TAboutFormRec): APascalString;

function AboutForm_LoadApplicationIcon(const AboutForm: TAboutFormRec): AError;

function AboutForm_SetReferenceP(const AboutForm: TAboutFormRec; const Value: APascalString): AError;

function AboutForm_SetProgramNameP(const AboutForm: TAboutFormRec; const Value: APascalString): AError;

implementation

{$IFNDEF FPC}
  {$R *.dfm}
{$ENDIF}

{ Public procs }

function AboutForm_AddButton02(const AboutForm: TAboutFormRec; Left, Width: AInt;
    const Text: APascalString; OnClick: ACallbackProc02): AControl;
var
  Button: AControl;
begin
  Button := AUiButton_New(AControl(AboutForm.ButtonsPanel));
  if (Button <> 0) then
  begin
    AUiControl_SetPosition(Button, Left, 4);
    AUiControl_SetSize(Button, Width, 25);
    AUiControl_SetTextP(Button, Text);
    AUiControl_SetOnClick02(Button, OnClick);
    {$IFNDEF FPC}TBitBtn(Button).Anchors := [akRight, akBottom];{$ENDIF}
  end;
  Result := Button;
end;

function AboutForm_GetProgramNameP(const AboutForm: TAboutFormRec): APascalString;
begin
  Result := AUiControl_GetTextP(AboutForm.NameText);
end;

function AboutForm_LoadApplicationIcon(const AboutForm: TAboutFormRec): AError;
begin
  AboutForm.Image.Picture.Assign(Application.Icon);
  Result := 0;
end;

function AboutForm_SetReferenceP(const AboutForm: TAboutFormRec; const Value: APascalString): AError;
begin
  AboutForm.UrlText.Caption := Value;
  Result := 0;
end;

function AboutForm_SetProgramNameP(const AboutForm: TAboutFormRec; const Value: APascalString): AError;
begin
  Result := AUiControl_SetTextP(AboutForm.NameText, Value);
end;

{ TAboutForm }

function TAboutForm.AddButton(Left, Width: Integer; const Text: APascalString;
    OnClick: ACallbackProc): AControl;
begin
  Result := AboutForm_AddButton(FAboutForm, Left, Width, Text, OnClick);
end;

function TAboutForm.AddButton02(Left, Width: Integer; const Text: APascalString;
    OnClick: ACallbackProc02): AControl;
begin
  Result := AboutForm_AddButton02(FAboutForm, Left, Width, Text, OnClick);
end;

procedure TAboutForm.DoCreate();
begin
  inherited;
  FAboutForm.ButtonsPanel := nil;
  FAboutForm.OkButton := 0;
  FAboutForm.UrlText := nil;
  FAboutForm.Panel := nil;
  FAboutForm.Image := nil;
  FAboutForm.NameText := 0;
  FAboutForm.Memo := 0;

  FAboutForm.Form := Self;

  // -- ButtonsPanel --

  FAboutForm.ButtonsPanel := TPanel.Create(FAboutForm.Form);
  FAboutForm.ButtonsPanel.Parent := FAboutForm.Form;
  FAboutForm.ButtonsPanel.Align := alBottom;
  FAboutForm.ButtonsPanel.Height := 34;

  // - OkButton -

    FAboutForm.OkButton := AboutForm_AddButton(FAboutForm, 270, 75, 'OK', nil);
    TBitBtn(FAboutForm.OkButton).TabOrder := 1;
    TBitBtn(FAboutForm.OkButton).Kind := bkOK;

  // -- UrlText --

  FAboutForm.UrlText := TLabel.Create(FAboutForm.Form);
  FAboutForm.UrlText.Parent := FAboutForm.Form;
  FAboutForm.UrlText.Left := 4;
  FAboutForm.UrlText.Top := 143;
  FAboutForm.UrlText.Anchors := [akLeft, akBottom];
  FAboutForm.UrlText.Cursor := crHandPoint;
  FAboutForm.UrlText.Font.Style := [fsUnderline];
  FAboutForm.UrlText.Font.Color := clBlue;
  FAboutForm.UrlText.OnClick := UrlTextClick;

  FAboutForm.Panel := Panel1;
  FAboutForm.Image := Image1;

  // -- NameText --

  FAboutForm.NameText := AUiLabel_New(AControl(FAboutForm.Form));
  AUiControl_SetAnchors(FAboutForm.NameText, uiakLeft + uiakTop + uiakRight);
  AUiControl_SetFont1P(FAboutForm.NameText, 'Arial', 11);
  AUiControl_SetPosition(FAboutForm.NameText, 92, 0);
  AUiControl_SetSize(FAboutForm.NameText, 250, 40);
  AUiLabel_SetAlignment(FAboutForm.NameText, uitaCenter + uitlCenter);
  AUiLabel_SetAutoSize(FAboutForm.NameText, False);
  AUiLabel_SetWordWrap(FAboutForm.NameText, True);
  AUiControl_SetTextP(FAboutForm.NameText, 'Assistant');

  // -- Memo --

  FAboutForm.Memo := AUiTextView_New(AControl(FAboutForm.Form), 0);
  AUiControl_SetColor(FAboutForm.Memo, clBtnFace);
  AUiControl_SetPosition(FAboutForm.Memo, 96, 40);
  AUiControl_SetSize(FAboutForm.Memo, 250, 114);
  AUiTextView_SetScrollBars(FAboutForm.Memo, AInt(ssVertical));
  AUiTextView_SetReadOnly(FAboutForm.Memo, True);
  AUiTextView_SetWordWrap(FAboutForm.Memo, True);
  AUiControl_SetTabStop(FAboutForm.Memo, False);
end;

procedure TAboutForm.FormResize(Sender: TObject);
begin
  AUiControl_SetSize(FAboutForm.OkButton, FAboutForm.ButtonsPanel.Width - AUiControl_GetWidth(FAboutForm.OkButton) - 4, AUiControl_GetHeight(FAboutForm.OkButton));
  FAboutForm.UrlText.Top := FAboutForm.ButtonsPanel.Top - FAboutForm.UrlText.Height - 4;
end;

function TAboutForm.GetPicture(): TPicture;
begin
  Result := FAboutForm.Image.Picture;
end;

function TAboutForm.GetReference(): APascalString;
begin
  Result := FAboutForm.UrlText.Caption;
end;

{procedure TAboutForm.Init();
begin
  AboutForm_Init2(FRec, AUiAboutFlags_ShowAll + AUiAboutFlags_NoShowComment, 0, 115);
end;}

{procedure TAboutForm.Init1(Flags: AUIAboutFlags);
begin
  AboutForm_Init2(FRec, 0, 115, Flags);
end;}

{procedure TAboutForm.Init2(Flags: AUiAboutFlags; MemoWidth, MemoHeight: AInt);
begin
  AboutForm_Init2(FRec, Flags, MemoWidth, MemoHeight);
end;}

{procedure TAboutForm.InitA(MemoWidth, MemoHeight: Integer);
begin
  AboutForm_Init2(FRec, AUiAboutFlags_ShowAll + AUiAboutFlags_NoShowComment, MemoWidth, MemoHeight);
end;}

procedure TAboutForm.LoadApplicationIcon();
begin
  AboutForm_LoadApplicationIcon(FAboutForm);
end;

procedure TAboutForm.SetReference(const Value: APascalString);
begin
  AboutForm_SetReferenceP(FAboutForm, Value);
end;

procedure TAboutForm.UrlTextClick(Sender: TObject);
begin
  ASystem.ShellExecuteWS('Open', FAboutForm.UrlText.Caption, '', '');
end;

initialization
{$IFDEF FPC}
  {$I fAbout.lrs}
{$ENDIF}
end.
