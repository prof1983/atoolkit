{**
@Abstract AUi about form
@Author Prof1983 <prof1983@ya.ru>
@Created 04.04.2006
@LastMod 14.11.2012
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
  AUiBase, AUiButtons, AUiControls, AUiLabels, AUiTextView;

type
  AUIAboutFlags = type AInteger;
const
  AUIAboutFlags_NoShowComment = $00010000;
  AUIAboutFlags_ShowAll = $0000FFFF;

type
  TAboutFormRec = record
    Form: TForm;
    ButtonsPanel: TPanel;
    OkButton: AControl;
    UrlText: TLabel;
    Panel: TPanel;
    Image: TImage;
    NameText: {AControl}TLabel;
    Memo: AControl;
  end;

type
  TAboutForm = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    lbName: TLabel;
    procedure FormResize(Sender: TObject);
  private
    FRec: TAboutFormRec;
    procedure UrlTextClick(Sender: TObject);
  private
    function GetPicture: TPicture;
    function GetProgramName: APascalString;
    function GetReference: APascalString;
    procedure SetProgramName(const Value: APascalString);
    procedure SetReference(const Value: APascalString);
  protected
    procedure DoCreate; override;
  public
    function AddButton(Left, Width: Integer; const Text: APascalString; OnClick: ACallbackProc): AControl;
    function AddButton02(Left, Width: Integer; const Text: APascalString; OnClick: ACallbackProc02): AControl;
    procedure Init; deprecated; // Use AboutForm_InitR()
    procedure Init1(Flags: AUIAboutFlags); deprecated; // Use AboutForm_InitR()
    procedure Init2(Flags: AUIAboutFlags; MemoWidth, MemoHeight: Integer); deprecated; // Use AboutForm_InitR()
    procedure InitA(MemoWidth, MemoHeight: Integer); deprecated; // Use AboutForm_InitR()
    procedure LoadApplicationIcon;
  public
    {** Картинка для отображения }
    property Picture: TPicture read GetPicture;
    {** Название программы }
    property ProgramName: APascalString read GetProgramName write SetProgramName;
    {** Ссылка на сайт программы }
    property Reference: APascalString read GetReference write SetReference;
  end;

function AboutForm_AddButton(var AboutForm: TAboutFormRec; Left, Width: AInt;
    const Text: APascalString; OnClick: ACallbackProc): AControl;

function AboutForm_AddButton02(var AboutForm: TAboutFormRec; Left, Width: AInt;
    const Text: APascalString; OnClick: ACallbackProc02): AControl;

function AboutForm_InitR(var AboutForm: TAboutFormRec; Flags: AUiAboutFlags; MemoWidth, MemoHeight: AInt): AError;

function AboutForm_LoadApplicationIcon(const AboutForm: TAboutFormRec): AError;

function AboutForm_SetReferenceP(var AboutForm: TAboutFormRec; const Value: APascalString): AError;

// Default MemoWidth=250, MemoHeight=115
procedure ShowAboutWinA(MemoWidth, MemoHeight: Integer);

implementation

{$IFNDEF FPC}
  {$R *.dfm}
{$ENDIF}

const
  {$IFDEF FPC}
  cCaption = 'About...';
  cCompanyName = 'Company: ';
  cDesctiption = 'Description: ';
  cProgramName = 'Program name: ';
  cProgramVersion = 'Version: ';
  cProductVersion = 'Product version: ';
  {$ELSE}
  cCaption = 'О программе';
  cCompanyName = 'Компания: ';
  cDesctiption = 'Описание: ';
  cProgramName = 'Имя файла: ';
  cProgramVersion = 'Версия: ';
  cProductVersion = 'Версия продукта: ';
  {$ENDIF}

{ Public procs }

function AboutForm_AddButton(var AboutForm: TAboutFormRec; Left, Width: AInt;
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
    {$IFNDEF FPC}TBitBtn(Button).Anchors := [akRight, akBottom];{$ENDIF}
  end;
  Result := Button;
end;

function AboutForm_AddButton02(var AboutForm: TAboutFormRec; Left, Width: AInt;
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

function AboutForm_InitR(var AboutForm: TAboutFormRec; Flags: AUiAboutFlags;
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
  {if (ASystem.Info_GetUrlP() <> '') then
  begin
    I := AUiControl_GetHeight(AboutForm.Memo);
    AUiControl_SetHeight(AboutForm.Memo, I - 10);
  end;}
  AboutForm_SetReferenceP(AboutForm, ASystem.Info_GetUrlP());
  AboutForm.NameText.Caption := ASystem.Info_GetProductNameP();
  //AUiControl_SetTextP(AboutForm.NameText, ASystem.Info_GetProductNameP());
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

  if (Flags and AUIAboutFlags_NoShowComment = 0) then
  begin
    S := ASystem.Info_GetCommentsWS();
    Print('', S);
  end;

  AboutForm.Form.Caption := cCaption;

  S := ASystem.Info_GetDirectoryPathWS() + ASystem.Info_GetProgramNameWS() + '.bmp';

  if FileExists(S) then
  try
    AboutForm.Image.Picture.LoadFromFile(S);
  except
    AboutForm_LoadApplicationIcon(AboutForm);
  end
  else
    AboutForm_LoadApplicationIcon(AboutForm);

  if (MemoWidth > 0) then
    AUiControl_SetWidth(AboutForm.Memo, MemoWidth);

  if (MemoHeight > 0) then
    AUiControl_SetWidth(AboutForm.Memo, MemoHeight);

  AUiControl_GetPosition(AboutForm.Memo, I, J);
  AboutForm.Form.ClientWidth :=  I + AUiControl_GetWidth(AboutForm.Memo) + 8;
  AboutForm.Form.ClientHeight := J + AUiControl_GetHeight(AboutForm.Memo) + AboutForm.UrlText.Height + AboutForm.ButtonsPanel.Height + 8;
  if (ASystem.Info_GetUrlP() <> '') then
    AboutForm.Form.ClientHeight := AboutForm.Form.ClientHeight + 18;

  Result := 0;
end;

function AboutForm_LoadApplicationIcon(const AboutForm: TAboutFormRec): AError;
begin
  AboutForm.Image.Picture.Assign(Application.Icon);
  Result := 0;
end;

function AboutForm_SetReferenceP(var AboutForm: TAboutFormRec; const Value: APascalString): AError;
begin
  AboutForm.UrlText.Caption := Value;
  Result := 0;
end;

procedure ShowAboutWinA(MemoWidth, MemoHeight: Integer);
var
  Form: TAboutForm;
begin
  Form := TAboutForm.Create(nil);
  try
    Form.InitA(MemoWidth, MemoHeight);
    Form.ShowModal;
  finally
    Form.Free;
  end;
end;

{ TAboutForm }

function TAboutForm.AddButton(Left, Width: Integer; const Text: APascalString;
    OnClick: ACallbackProc): AControl;
begin
  Result := AboutForm_AddButton(FRec, Left, Width, Text, OnClick);
end;

function TAboutForm.AddButton02(Left, Width: Integer; const Text: APascalString;
    OnClick: ACallbackProc02): AControl;
begin
  Result := AboutForm_AddButton02(FRec, Left, Width, Text, OnClick);
end;

procedure TAboutForm.DoCreate();
begin
  inherited;
  FRec.ButtonsPanel := nil;
  FRec.OkButton := 0;
  FRec.UrlText := nil;
  FRec.Panel := nil;
  FRec.Image := nil;
  FRec.NameText := nil;
  FRec.Memo := 0;

  FRec.Form := Self;

  // -- ButtonsPanel --

  FRec.ButtonsPanel := TPanel.Create(FRec.Form);
  FRec.ButtonsPanel.Parent := FRec.Form;
  FRec.ButtonsPanel.Align := alBottom;
  FRec.ButtonsPanel.Height := 34;

  // - OkButton -

    FRec.OkButton := AboutForm_AddButton(FRec, 270, 75, 'OK', nil);
    TBitBtn(FRec.OkButton).TabOrder := 1;
    TBitBtn(FRec.OkButton).Kind := bkOK;

  // -- UrlText --

  FRec.UrlText := TLabel.Create(FRec.Form);
  FRec.UrlText.Parent := FRec.Form;
  FRec.UrlText.Left := 4;
  FRec.UrlText.Top := 143;
  FRec.UrlText.Anchors := [akLeft, akBottom];
  FRec.UrlText.Cursor := crHandPoint;
  FRec.UrlText.Font.Style := [fsUnderline];
  FRec.UrlText.Font.Color := clBlue;
  FRec.UrlText.OnClick := UrlTextClick;

  FRec.Panel := Panel1;
  FRec.Image := Image1;

  // -- NameText --

  FRec.NameText := lbName;
  {FRec.NameText := AUiLabel_New(FRec.Form);
  AUiControl_SetAnchors(FRec.NameText, uiakLeft + uiakTop + uiakRight);
  AUiControl_SetFont1P(FRec.NameText, 'Arial', 11);
  AUiLabel_SetAlignment(FRec.NameText, uitaCenter + uitlCenter);
  AUiLabel_SetAutoSize(FRec.NameText, False);
  AUiLabel_SetWordWrap(FRec.NameText, True);}

  // -- Memo --

  FRec.Memo := AUiTextView_New(AControl(FRec.Form), 0);
  AUiControl_SetColor(FRec.Memo, clBtnFace);
  AUiControl_SetPosition(FRec.Memo, 96, 40);
  AUiControl_SetSize(FRec.Memo, 250, 114);
  AUiTextView_SetScrollBars(FRec.Memo, AInt(ssVertical));
  AUiTextView_SetReadOnly(FRec.Memo, True);
  AUiTextView_SetWordWrap(FRec.Memo, True);
  AUiControl_SetTabStop(FRec.Memo, False);
end;

procedure TAboutForm.FormResize(Sender: TObject);
begin
  AUiControl_SetSize(FRec.OkButton, FRec.ButtonsPanel.Width - AUiControl_GetWidth(FRec.OkButton) - 4, AUiControl_GetHeight(FRec.OkButton));
  FRec.UrlText.Top := FRec.ButtonsPanel.Top - FRec.UrlText.Height - 4;
end;

function TAboutForm.GetPicture(): TPicture;
begin
  Result := FRec.Image.Picture;
end;

function TAboutForm.GetProgramName(): APascalString;
begin
  Result := FRec.NameText.Caption;
end;

function TAboutForm.GetReference(): APascalString;
begin
  Result := FRec.UrlText.Caption;
end;

procedure TAboutForm.Init();
begin
  AboutForm_InitR(FRec, AUiAboutFlags_ShowAll + AUiAboutFlags_NoShowComment, 0, 115);
end;

procedure TAboutForm.Init1(Flags: AUIAboutFlags);
begin
  AboutForm_InitR(FRec, 0, 115, Flags);
end;

procedure TAboutForm.Init2(Flags: AUiAboutFlags; MemoWidth, MemoHeight: AInt);
begin
  AboutForm_InitR(FRec, Flags, MemoWidth, MemoHeight);
end;

procedure TAboutForm.InitA(MemoWidth, MemoHeight: Integer);
begin
  AboutForm_InitR(FRec, AUiAboutFlags_ShowAll + AUiAboutFlags_NoShowComment, MemoWidth, MemoHeight);
end;

procedure TAboutForm.LoadApplicationIcon();
begin
  AboutForm_LoadApplicationIcon(FRec);
end;

procedure TAboutForm.SetProgramName(const Value: APascalString);
begin
  FRec.NameText.Caption := Value;
end;

procedure TAboutForm.SetReference(const Value: APascalString);
begin
  AboutForm_SetReferenceP(FRec, Value);
end;

procedure TAboutForm.UrlTextClick(Sender: TObject);
begin
  ASystem.ShellExecuteWS('Open', FRec.UrlText.Caption, '', '');
end;

initialization
{$IFDEF FPC}
  {$I fAbout.lrs}
{$ENDIF}
end.
