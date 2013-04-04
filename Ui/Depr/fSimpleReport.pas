{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(27.08.2008)
@LastMod(03.05.2011)
@Version(0.5)
}
unit fSimpleReport;

interface

uses
  Classes, Dialogs, Controls, Forms, Graphics, Messages, StdCtrls, SysUtils, Variants, Windows;

type
  TSimpleReportForm = class(TForm)
    Memo: TMemo;
  public
    procedure AddLine(const Text: string);
  end;

implementation

{$R *.dfm}

{ TSimpleReportForm }

procedure TSimpleReportForm.AddLine(const Text: string);
begin
  Memo.Lines.Add(Text);
  Application.ProcessMessages();
end;

end.
