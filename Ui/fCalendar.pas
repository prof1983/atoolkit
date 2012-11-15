{**
@Abstract AUi calendar form
@Author Prof1983 <prof1983@ya.ru>
@Created 25.08.2008
@LastMod 15.11.2012
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

function ShowCalendarWin2(CalendarLeft, CalendarTop: Integer; var CalendarDate: TDateTime; var RGItemIndex: Integer): Boolean;

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

function ShowCalendarWin2(CalendarLeft, CalendarTop: Integer; var CalendarDate: TDateTime; var RGItemIndex: Integer): Boolean;
var
  Form: TCalendarForm;
begin
  Form := TCalendarForm.Create(nil);
  try
    Form.Left := CalendarLeft;
    Form.Top := CalendarTop;
    Form.RG.ItemIndex := RGItemIndex;
    Form.MonthCalendar1.Date := CalendarDate;
    Result := (Form.ShowModal() = mrOk);
    if Result then
    begin
      RGItemIndex := Form.RG.ItemIndex;
      CalendarDate := Form.MonthCalendar1.Date;
    end;
  finally
    Form.Free();
  end;
end;

end.
