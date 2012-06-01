{**
@Abstract(Форма "О программе")
@Author(Prof1983 prof1983@ya.ru)
@Created(04.04.2006)
@LastMod(25.10.2011)
@Version(0.5)
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
  ABase, ABaseUtils,
  {$IFDEF A0}ASystem0{$ELSE}ASystem{$ENDIF},
  AUiBase, AUiButton, AUiControls;

type
  TAboutForm = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    lbName: TLabel;
    Memo: TMemo;
    procedure FormResize(Sender: TObject);
  private
    ButtonsPanel: TPanel;
    OkButton: AControl{TBitBtn};
    UrlText: TLabel;
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
    procedure Init;
    procedure InitA(MemoWidth, MemoHeight: Integer);
    procedure LoadApplicationIcon;
    // Картинка для отображения
    property Picture: TPicture read GetPicture;
    // Название программы
    property ProgramName: APascalString read GetProgramName write SetProgramName;
    // Ссылка на сайт программы
    property Reference: APascalString read GetReference write SetReference;
  end;

// Default MemoWidth=250, MemoHeight=115
procedure ShowAboutWinA(MemoWidth, MemoHeight: Integer);

implementation

uses
  AUi;

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

function TAboutForm.AddButton(Left, Width: Integer; const Text: APascalString; OnClick: ACallbackProc): AControl;
var
  Button: AControl;
begin
  Button := AUIButton.UI_Button_New(AControl(ButtonsPanel));
  if (Button <> 0) then
  begin
    AUIControls.UI_Control_SetPosition(Button, Left, 4);
    AUIControls.UI_Control_SetSize(Button, Width, 25);
    AUIControls.UI_Control_SetTextP(Button, Text);
    AUIControls.UI_Control_SetOnClick03(Button, OnClick);
    {$IFNDEF FPC}TBitBtn(Button).Anchors := [akRight, akBottom];{$ENDIF}
  end;
  Result := Button;
end;

function TAboutForm.AddButton02(Left, Width: Integer; const Text: APascalString; OnClick: ACallbackProc02): AControl;
var
  Button: AControl;
begin
  Button := AUIButton.UI_Button_New(AControl(ButtonsPanel));
  if (Button <> 0) then
  begin
    AUIControls.UI_Control_SetPosition(Button, Left, 4);
    AUIControls.UI_Control_SetSize(Button, Width, 25);
    AUIControls.UI_Control_SetTextP(Button, Text);
    AUIControls.UI_Control_SetOnClick02(Button, OnClick);
    {$IFNDEF FPC}TBitBtn(Button).Anchors := [akRight, akBottom];{$ENDIF}
  end;
  Result := Button;
end;

procedure TAboutForm.DoCreate;
begin
  inherited;

  ButtonsPanel := TPanel.Create(Self);
  ButtonsPanel.Parent := Self;
  ButtonsPanel.Align := alBottom;
  ButtonsPanel.Height := 34;

    OkButton := AddButton(270, 75, 'OK', nil);
    TBitBtn(OkButton).TabOrder := 1;
    TBitBtn(OkButton).Kind := bkOK;

  UrlText := TLabel.Create(Self);
  UrlText.Parent := Self;
  UrlText.Left := 4;
  UrlText.Top := 143;
  UrlText.Anchors := [akLeft, akBottom];
  UrlText.Cursor := crHandPoint;
  UrlText.Font.Style := [fsUnderline];
  UrlText.Font.Color := clBlue;
  UrlText.OnClick := UrlTextClick;
end;

procedure TAboutForm.FormResize(Sender: TObject);
begin
  AUIControls.UI_Control_SetSize(OkButton, ButtonsPanel.Width - UI_Control_GetWidth(OkButton) - 4, UI_Control_GetHeight(OkButton));
  UrlText.Top := ButtonsPanel.Top - UrlText.Height - 4;
end;

function TAboutForm.GetPicture(): TPicture;
begin
  Result := Image1.Picture;
end;

function TAboutForm.GetProgramName(): APascalString;
begin
  Result := lbName.Caption;
end;

function TAboutForm.GetReference(): APascalString;
begin
  Result := UrlText.Caption;
end;

procedure TAboutForm.Init();
begin
  InitA(0, 115);
end;

procedure TAboutForm.InitA(MemoWidth, MemoHeight: Integer);
var
  S: string;
begin
  if (ASystem.Info_GetUrlWS() <> '') then
    Memo.Height := Memo.Height - 10;
  Self.Reference := ASystem.Info_GetUrlWS();
  Self.lbName.Caption := ASystem.Info_GetProductNameWS();
  S := ASystem.Info_GetProgramNameWS();
  if (S <> '') then Memo.Lines.Add(cProgramName+S);
  S := ASystem.Info_GetProgramVersionStrWS();
  if (S <> '') then Memo.Lines.Add(cProgramVersion+S);
  S := ASystem.Info_GetProductVersionStrWS();
  if (S <> '') then Memo.Lines.Add(cProductVersion+S);
  S := ASystem.Info_GetCopyrightWS();
  if (S <> '') then Memo.Lines.Add(S);
  S := ASystem.Info_GetCompanyNameWS();
  if (S <> '') then Memo.Lines.Add(cCompanyName+S);
  S := ASystem.Info_GetDescriptionWS();
  if (S <> '') then Memo.Lines.Add(S);
  S := ASystem.Info_GetCommentsWS();
  if (S <> '') then Memo.Lines.Add(S);

  Caption := cCaption;

  S := ASystem.Info_GetDirectoryPathWS() + ASystem.Info_GetProgramNameWS() + '.bmp';

  if FileExists(S) then
  try
    Image1.Picture.LoadFromFile(S);
  except
    Self.LoadApplicationIcon();
  end
  else
    Self.LoadApplicationIcon();

  if (MemoWidth > 0) then
    Memo.Width := MemoWidth;

  if (MemoHeight > 0) then
    Memo.Height := MemoHeight;

  Self.ClientWidth := Memo.Left + Memo.Width + 8;
  Self.ClientHeight := Memo.Top + Memo.Height + UrlText.Height + ButtonsPanel.Height + 8;
end;

procedure TAboutForm.LoadApplicationIcon();
begin
  Image1.Picture.Assign(Application.Icon);
end;

procedure TAboutForm.SetProgramName(const Value: APascalString);
begin
  lbName.Caption := Value;
end;

procedure TAboutForm.SetReference(const Value: APascalString);
begin
  UrlText.Caption := Value;
end;

procedure TAboutForm.UrlTextClick(Sender: TObject);
begin
  ASystem.ShellExecuteWS('Open', UrlText.Caption, '', '');
end;

initialization
{$IFDEF FPC}
  {$I fAbout.lrs}
{$ENDIF}
end.
