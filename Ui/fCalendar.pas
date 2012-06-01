{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(25.08.2008)
@LastMod(03.05.2011)
@Version(0.5)
}
unit fCalendar;

interface

uses
  Buttons, Classes, ComCtrls, Controls, ExtCtrls, Forms, Graphics, Grids, Messages,
  StdCtrls, SysUtils, Types, Variants;

type
  TCalendarForm = class(TForm)
    MonthCalendar1: TMonthCalendar;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    RG: TRadioGroup;
  end;

function ShowCalendarWin(var Date: TDateTime; CenterX, CenterY: Integer): Boolean;

implementation

{$R *.dfm}

function ShowCalendarWin(var Date: TDateTime; CenterX, CenterY: Integer): Boolean;
var
  Form: TCalendarForm;
begin
  Form := TCalendarForm.Create(nil);
  try
    Form.MonthCalendar1.Date := Date;
    Form.Left := CenterX - Form.Width div 2;
    if (Form.Left < 0) then Form.Left := 0;
    Form.Top := CenterY - Form.Height div 2;
    if (Form.Top < 0) then Form.Top := 0;
    Form.Width := 205;
    Result := (Form.ShowModal = mrOk);
    if Result then
      Date := Form.MonthCalendar1.Date;
  finally
    Form.Free;
  end;
end;

end.
