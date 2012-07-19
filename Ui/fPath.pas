{
Author:  Prof1983 <prof1983@yandex.ru>
Created: 03.06.2008
LastMod: 03.05.2011
Version: 0.3.0
}
unit fPath;

interface

uses
  Classes, Controls, FileCtrl, Forms, Graphics, Messages, StdCtrls, SysUtils; //Variants;

type
  TPathForm = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
  end;

implementation

{$R *.dfm}

{ TPathForm }

procedure TPathForm.Button3Click(Sender: TObject);
var
  Dir: string;
begin
  if FileCtrl.SelectDirectory('Выбор папки проекта', Edit1.Text, Dir) then
    Edit1.Text := Dir;
end;

end.
