{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(21.07.2008)
@LastMod(03.05.2011)
@Version(0.5)
}
unit fError;

interface

uses
  {$IFDEF FPC}LResources,{$ELSE}WinProcs, WinTypes,{$ENDIF}
  Buttons, Classes, Controls, Dialogs, ExtCtrls, Forms, Graphics,
  StdCtrls, SysUtils;

type
  TErrorForm = class(TForm)
    BitBtn1: TBitBtn;
    Panel1: TPanel;
    Memo: TMemo;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure BitBtn2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  public
    MessageStr: string;
    DetailStr: string;
  protected
    procedure DoCreate; override;
  end;

procedure ShowErrorA(const Caption, UserMessage, ExceptMessage: string);
procedure ShowMess(const UserMessage, ExceptMessage: string);

implementation

{$IFNDEF FPC}
  {$R *.DFM}
{$ENDIF}

procedure ShowErrorA(const Caption, UserMessage, ExceptMessage: string);
var
  ErrForm: TErrorForm;
begin
  ErrForm := TErrorForm.Create(nil);
  try
    ErrForm.Caption := Caption;
    //ErrForm.MemoErr.BringToFront();
    //ErrForm.MemoDetail.SendToBack();
    ErrForm.MessageStr := UserMessage;
    ErrForm.DetailStr := ExceptMessage;
    ErrForm.SpeedButton1.Down := True;
    if (ExceptMessage = '') then
      ErrForm.SpeedButton2.Enabled := False;
    ErrForm.ShowModal();
  finally
    ErrForm.Free();
  end;
end;

procedure ShowMess(const UserMessage, ExceptMessage: string);
begin
  ShowErrorA('', UserMessage, ExceptMessage);
end;

{ TErrorForm }

procedure TErrorForm.BitBtn2Click(Sender: TObject);
begin
  Memo.Text := DetailStr;
end;

procedure TErrorForm.DoCreate;
begin
  inherited;

  {$IFDEF FPC}
  //object ErrorForm: TErrorForm
  Self.Left := 204;
  Self.Top := 101;
  Self.BorderIcons := [biSystemMenu];
  Self.BorderStyle := bsDialog;
  Self.Caption := #1042#1053#1048#1052#1040#1053#1048#1045'!';
  Self.ClientHeight := 97;
  Self.ClientWidth := 369;
  Self.Color := clBtnFace;
  //Self.Font.Charset := DEFAULT_CHARSET;
  Self.Font.Color := clBlack;
  Self.Font.Height := -11;
  Self.Font.Name := 'MS Sans Serif';
  Self.Font.Style := [];
  //Self.OldCreateOrder := True;
  Self.Position := poScreenCenter;
  Self.OnShow := FormShow;
  Self.PixelsPerInch := 96;
  //Self.TextHeight := 13;

    SpeedButton1 := TSpeedButton.Create(Self);
    SpeedButton1.Parent := Self;
    SpeedButton1.Left := 176;
    SpeedButton1.Top := 63;
    SpeedButton1.Width := 97;
    SpeedButton1.Height := 30;
    SpeedButton1.GroupIndex := 1;
    SpeedButton1.Caption := '&'#1050#1088#1072#1090#1082#1086;
    SpeedButton1.Flat := True;
    //SpeedButton1.Font.Charset := DEFAULT_CHARSET;
    SpeedButton1.Font.Color := clBlack;
    SpeedButton1.Font.Height := -11;
    SpeedButton1.Font.Name := 'MS Sans Serif';
    SpeedButton1.Font.Style := [fsBold];
    (*SpeedButton1.Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333333333333333333333C3333333333333337F3333333333333C0C3333
        333333333777F33333333333C0F0C3333333333377377F333333333C0FFF0C33
        3333333777F377F3333333CCC0FFF0C333333373377F377F33333CCCCC0FFF0C
        333337333377F377F3334CCCCCC0FFF0C3337F3333377F377F33C4CCCCCC0FFF
        0C3377F333F377F377F33C4CC0CCC0FFF0C3377F3733F77F377333C4CCC0CC0F
        0C333377F337F3777733333C4C00CCC0333333377F773337F3333333C4CCCCCC
        3333333377F333F7333333333C4CCCC333333333377F37733333333333C4C333
        3333333333777333333333333333333333333333333333333333}*)
    SpeedButton1.NumGlyphs := 2;
    SpeedButton1.ParentFont := False;
    SpeedButton1.OnClick := SpeedButton1Click;

    SpeedButton2 := TSpeedButton.Create(Self);
    SpeedButton2.Parent := Self;
    SpeedButton2.Left := 272;
    SpeedButton2.Top := 63;
    SpeedButton2.Width := 97;
    SpeedButton2.Height := 30;
    SpeedButton2.GroupIndex := 1;
    SpeedButton2.Caption := '&'#1055#1086#1076#1088#1086#1073#1085#1086;
    SpeedButton2.Flat := True;
    //SpeedButton2.Font.Charset := DEFAULT_CHARSET;
    SpeedButton2.Font.Color := clBlack;
    SpeedButton2.Font.Height := -11;
    SpeedButton2.Font.Name := 'MS Sans Serif';
    SpeedButton2.Font.Style := [fsBold];
    (*SpeedButton2.Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333333333333333333333FFFFF3333333333CCCCC33
        33333FFFF77777FFFFFFCCCCCC808CCCCCC377777737F777777F008888070888
        8003773FFF7773FFF77F0F0770F7F0770F037F777737F777737F70FFFFF7FFFF
        F07373F3FFF7F3FFF37F70F000F7F000F07337F77737F777373330FFFFF7FFFF
        F03337FF3FF7F3FF37F3370F00F7F00F0733373F7737F77337F3370FFFF7FFFF
        0733337F33373F337333330FFF030FFF03333373FF7373FF7333333000333000
        3333333777333777333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}*)
    SpeedButton2.NumGlyphs := 2;
    SpeedButton2.ParentFont := False;
    SpeedButton2.OnClick := BitBtn2Click;

    BitBtn1 := TBitBtn.Create(Self);
    BitBtn1.Parent := Self;
    BitBtn1.Left := 1;
    BitBtn1.Top := 63;
    BitBtn1.Width := 90;
    BitBtn1.Height := 30;
    BitBtn1.Caption := '&'#1054#1050;
    BitBtn1.TabOrder := 0;
    BitBtn1.Kind := bkOK;
    //BitBtn1.Style := bsNew;

    Panel1 := TPanel.Create(Self);
    Panel1.Parent := Self;
    Panel1.Left := 0;
    Panel1.Top := 6;
    Panel1.Width := 369;
    Panel1.Height := 50;
    Panel1.BevelOuter := bvLowered;
    Panel1.TabOrder := 1;

      Memo := TMemo.Create(Panel1);
      Memo.Parent := Panel1;
      Memo.Left := 1;
      Memo.Top := 1;
      Memo.Width := 367;
      Memo.Height := 48;
      Memo.TabStop := False;
      Memo.Align := alClient;
      Memo.Alignment := taCenter;
      Memo.BorderStyle := bsNone;
      Memo.Color := clBtnFace;
      //Memo.Font.Charset := DEFAULT_CHARSET;
      Memo.Font.Color := clMaroon;
      Memo.Font.Height := -11;
      Memo.Font.Name := 'MS Sans Serif';
      Memo.Font.Style := [fsBold];
      Memo.ParentFont := False;
      Memo.ReadOnly := True;
      Memo.TabOrder := 0;
  {$ENDIF FPC}
end;

procedure TErrorForm.FormShow(Sender: TObject);
begin
  Memo.Text := MessageStr;
end;

procedure TErrorForm.SpeedButton1Click(Sender: TObject);
begin
  Memo.Text := MessageStr;
end;

initialization
(*
{$IFDEF FPC}
  {$I fError.lrs}
{$ENDIF}
*)
end.
