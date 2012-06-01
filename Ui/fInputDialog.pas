{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(25.02.2009)
@LastMod(29.06.2011)
@Version(0.5)
}
unit fInputDialog;

interface

uses
  {$IFDEF FPC}LResources,{$ENDIF}
  Buttons, Classes, Controls, ExtCtrls, Messages, Forms, Graphics, StdCtrls, SysUtils,
  ABase;

type
  TInputForm = class(TForm)
    Edit1: TEdit;
    Panel1: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    Memo: TMemo;
  private
    function GetValue: string;
    procedure SetValue(const Value: string);
  protected
    procedure DoCreate; override;
  public
    property Value: string read GetValue write SetValue;
  end;

function InputBox(const Caption, Text: APascalString; var Value: APascalString): Boolean;

implementation

{$IFNDEF FPC}
  {$R *.DFM}
{$ENDIF}

{ Public procs }

function InputBox(const Caption, Text: APascalString; var Value: APascalString): Boolean;
var
  InputForm: TInputForm;
begin
  InputForm := TInputForm.Create(nil);
  try
    InputForm.Caption := Caption;
    InputForm.Value := Value;
    Result := (InputForm.ShowModal = mrOk);
    if Result then
      Value := InputForm.Value;
  finally
    InputForm.Free;
  end;
end;

{ TInputForm }

procedure TInputForm.DoCreate;
begin
  inherited;
  {$IFDEF FPC}
  Self.Left := 252;
  Self.Top := 176;
  Self.BorderStyle := bsToolWindow;
  Self.ClientHeight := 138;
  Self.ClientWidth := 277;
  Self.Color := clBtnFace;
  //Self.Font.Charset := DEFAULT_CHARSET;
  Self.Font.Color := clWindowText;
  Self.Font.Height := -11;
  Self.Font.Name := 'MS Sans Serif';
  Self.Font.Style := [];
  //Self.OldCreateOrder := True;
  Self.PixelsPerInch := 96;
  //Self.TextHeight := 13;

    Edit1 := TEdit.Create(Self);
    Edit1.Parent := Self;
    Edit1.Left := 12;
    Edit1.Top := 66;
    Edit1.Width := 249;
    Edit1.Height := 24;
    Edit1.CharCase := ecUpperCase;
    //Edit1.Font.Charset := DEFAULT_CHARSET;
    Edit1.Font.Color := clWindowText;
    Edit1.Font.Height := -13;
    Edit1.Font.Name := 'MS Sans Serif';
    Edit1.Font.Style := [];
    Edit1.ParentFont := False;
    Edit1.TabOrder := 0;

    Panel1 := TPanel.Create(Self);
    Panel1.Parent := Self;
    Panel1.Left := 0;
    Panel1.Top := 105;
    Panel1.Width := 277;
    Panel1.Height := 33;
    Panel1.Align := alBottom;
    Panel1.TabOrder := 1;

      btnOk := TBitBtn.Create(Self);
      btnOk.Parent := Panel1;
      btnOk.Left := 40;
      btnOk.Top := 4;
      btnOk.Width := 75;
      btnOk.Height := 25;
      btnOk.TabOrder := 0;
      btnOk.Kind := bkOK;

      btnCancel := TBitBtn.Create(Self);
      btnCancel.Parent := Panel1;
      btnCancel.Left := 152;
      btnCancel.Top := 4;
      btnCancel.Width := 75;
      btnCancel.Height := 25;
      btnCancel.Caption := #1054#1090#1084#1077#1085#1072;
      btnCancel.TabOrder := 1;
      btnCancel.Kind := bkCancel;

  Memo := TMemo.Create(Self);
  Memo.Parent := Self;
  Memo.Left := 0;
  Memo.Top := 0;
  Memo.Width := 277;
  Memo.Height := 49;
  Memo.Align := alTop;
  Memo.BorderStyle := bsNone;
  Memo.Color := clBtnFace;
  Memo.ReadOnly := True;
  Memo.TabOrder := 2;
  {$ENDIF FPC}
end;

function TInputForm.GetValue: string;
begin
  Result := Edit1.Text;
end;

procedure TInputForm.SetValue(const Value: string);
begin
  Edit1.Text := Value;
end;

initialization
(*
{$IFDEF FPC}
  {$I fInputDialog.lrs}
{$ENDIF}
*)
end.
