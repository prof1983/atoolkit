{**
@Abstract
@Author Prof1983 <prof1983@ya.ru>
@Created 04.08.2008
@LastMod 15.11.2012
}
unit fDateFilter;

interface

uses
  Buttons, Classes, Controls, ComCtrls, ExtCtrls, Forms, Graphics, Messages, StdCtrls, SysUtils;

type
  TFilterForm = class(TForm)
    InfoMemo: TMemo;
    RadioGroup1: TRadioGroup;
    OkButton: TBitBtn;
    CancelButton: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    procedure RadioGroup1Click(Sender: TObject);
  end;

implementation

{$R *.dfm}

{ TFilterForm }

procedure TFilterForm.RadioGroup1Click(Sender: TObject);
begin
  if (RadioGroup1.ItemIndex = 3) then
  begin
    DateTimePicker1.Enabled := True;
    DateTimePicker2.Enabled := True;
  end
  else
  begin
    DateTimePicker1.Enabled := False;
    DateTimePicker2.Enabled := False;
  end
end;

end.
