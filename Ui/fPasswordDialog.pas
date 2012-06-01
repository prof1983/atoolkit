{**
@Abstract(Диалог ввода пароля, а также года и квартала)
@Author(Prof1983 prof1983@ya.ru)
@Created(19.03.2008)
@LastMod(29.06.2011)
@Version(0.5)
}
unit fPasswordDialog;

interface

uses
  {$IFDEF FPC}LResources,{$ELSE}WinProcs, WinTypes,{$ENDIF}
  Buttons, Classes, Controls, Forms, Graphics, StdCtrls, SysUtils,
  ABase;

type
  TDialogForm1 = class(TForm)
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    lblValue1: TLabel;
    edtValue1: TEdit;
    lblValue2: TLabel;
    edtValue2: TEdit;
  end;

function InputBox1(const Caption, Label1: string; var Value1: string): Boolean;
function InputBox2(const Caption, Label1, Label2: string; var Value1, Value2: APascalString): Boolean;
function InputBox2Int(const Caption, Label1, Label2: string; var Value1, Value2: Integer): Boolean;

implementation

{$IFNDEF FPC}
  {$R *.DFM}
{$ENDIF}

function InputBox1(const Caption, Label1: string; var Value1: string): Boolean;
var
  Dialog: TDialogForm1;
begin
  Dialog := TDialogForm1.Create(nil);
  try
    Dialog.Caption := Caption;
    Dialog.lblValue2.Caption := Label1;
    Dialog.lblValue1.Visible := False;
    Dialog.edtValue1.Text := Value1;
    Dialog.edtValue2.Visible := False;
    //FDialog1.Enabled := True;
    Result := (Dialog.ShowModal = mrOk);
    if Result then
    begin
      Value1 := Dialog.edtValue1.Text;
      //Value2 := Dialog.edtValue2.Text;
    end;
  finally
    Dialog.Free;
  end;
end;

function InputBox2(const Caption, Label1, Label2: string; var Value1, Value2: APascalString): Boolean;
var
  Dialog: TDialogForm1;
begin
  Dialog := TDialogForm1.Create(nil);
  try
    Dialog.Caption := Caption;
    Dialog.lblValue2.Caption := Label1;
    Dialog.lblValue1.Caption := Label2;
    Dialog.edtValue1.Text := Value1;
    Dialog.edtValue2.Text := Value2;

    if (Dialog.edtValue1.Text <> '') then
      Dialog.ActiveControl := Dialog.edtValue1;

    //FDialog1.Enabled := True;
    Result := (Dialog.ShowModal = mrOk);
    if Result then
    begin
      Value1 := Dialog.edtValue1.Text;
      Value2 := Dialog.edtValue2.Text;
    end;
  finally
    Dialog.Free;
  end;
end;

function InputBox2Int(const Caption, Label1, Label2: string; var Value1, Value2: Integer): Boolean;
var
  sValue1: APascalString;
  sValue2: APascalString;
begin
  sValue1 := IntToStr(Value1);
  sValue2 := IntToStr(Value2);
  Result := InputBox2(Caption, Label1, Label2, sValue1, sValue2);
  if Result then
    Result := TryStrToInt(sValue1, Value1) and TryStrToInt(sValue2, Value2);
end;

initialization
{$IFDEF FPC}
  {$I fPasswordDialog.lrs}
{$ENDIF}
end.
