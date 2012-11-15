{**
@Abstract AUi login form
@Author Prof1983 <prof1983@ya.ru>
@Created 04.02.2008
@LastMod 15.11.2012
}
unit fLogin;

interface

uses
  {$IFDEF FPC}LResources,{$ENDIF}
  Buttons, Classes, Controls, ExtCtrls, Forms, Graphics, Messages, StdCtrls, SysUtils;

type
  TLoginForm = class(TForm)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtUserName: TEdit;
    edtPassword: TEdit;
    pnlButtons: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    cbSavePassword: TCheckBox;
    procedure FormShow(Sender: TObject);
  private
    function GetUserName: string;
    function GetUserPassword: string;
    procedure SetUserName(const Value: string);
  public
    property UserName: string read GetUserName write SetUserName;
    property UserPassword: string read GetUserPassword;
  end;

implementation

{$IFNDEF FPC}
  {$R *.DFM}
{$ENDIF}

{ Functions }

{function ShowLoginWin(var UserName, Password: string): Boolean;
var
  LoginForm: TLoginForm;
begin
  LoginForm := TLoginForm.Create(nil);
  try
    LoginForm.Edit1.Text := UserName;
    Result := (LoginForm.ShowModal = mrOk);
    if Result then
    begin
      UserName := LoginForm.Edit1.Text;
      Password := LoginForm.Edit2.Text;
    end;
  finally
    LoginForm.Free;
  end;
end;}

{ TLoginForm }

function TLoginForm.GetUserName: string;
begin
  Result := edtUserName.Text;
end;

function TLoginForm.GetUserPassword: string;
begin
  Result := edtPassword.Text;
end;

procedure TLoginForm.FormShow(Sender: TObject);
begin
  if (edtUserName.Text <> '') then
    Self.ActiveControl := edtPassword;
end;

procedure TLoginForm.SetUserName(const Value: string);
begin
  edtUserName.Text := Value;
end;

initialization
{$IFDEF FPC}
  {$I fLogin.lrs}
{$ENDIF}
end.
