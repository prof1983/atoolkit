{**
@Author Prof1983 <prof1983@ya.ru>
@Created 29.01.2013
@LastMod 01.02.2013
}
unit AUiCalendarDialog;

{define AStdCall}

interface

uses
  ComCtrls,
  Controls,
  ExtCtrls,
  ABase,
  ABaseTypes,
  AUiBase,
  AUiControls,
  AUiDialogs,
  AUiWindows;

function AUi_ExecuteCalendarDialog(var Date: TDateTime; CenterX, CenterY: AInt): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

implementation

type
  AUiCalendarDialog_Type = record
    Window: AWindow;
    MonthCalendar: AControl;
    RadioGroup: TRadioGroup;
  end;

// --- Private ---

function _InitCalendarWin(Calendar: AUiCalendarDialog_Type; Date: TDateTime): TMonthCalendar;
var
  MonthCalendar: TMonthCalendar;
begin
  AUiControl_SetClientSize(Calendar.Window, 194, 341);
  AUiControl_SetTextP(Calendar.Window, 'Calendar');

  MonthCalendar := TMonthCalendar.Create(nil);
  MonthCalendar.Parent := TWinControl(Calendar.Window);
  MonthCalendar.Left := 0;
  MonthCalendar.Top := 0;
  MonthCalendar.Width := 191;
  MonthCalendar.Height := 154;
  MonthCalendar.Date := Date;
  MonthCalendar.TabOrder := 0;

  Calendar.MonthCalendar := AControl(MonthCalendar);
  Result := MonthCalendar;
end;

function _SetCenterCalendarWin(Calendar: AUiCalendarDialog_Type; CenterX, CenterY: AInt): AError;
var
  Left: AInt;
  Top: AInt;
  Width: AInt;
  Height: AInt;
begin
  Height := AUiControl_GetHeight(Calendar.Window);
  Width := AUiControl_GetWidth(Calendar.Window);

  Left := CenterX - Width div 2;
  if (Left < 0) then
    Left := 0;
  Top := CenterY - Height div 2;
  if (Top < 0) then
    Top := 0;

  AUiControl_SetPosition(Calendar.Window, Left, Top);
  Result := 0;
end;

function _ShowCalendarWin(var Date: TDateTime; CenterX, CenterY: AInt): ABoolean;
var
  Calendar: AUiCalendarDialog_Type;
  Dialog: ADialog;
  MonthCalendar: TMonthCalendar;
begin
  Dialog := AUiDialog_New(AMessageBoxFlags_OkCancel);
  Calendar.Window := AUiDialog_GetWindow(Dialog);

  MonthCalendar := _InitCalendarWin(Calendar, Date);
  _SetCenterCalendarWin(Calendar, CenterX, CenterY);

  Result := AUiWindow_ShowModal(Calendar.Window);
  if (Result) then
    Date := MonthCalendar.Date;

  AUiDialog_Free(Dialog);
end;

function _ShowCalendarWin2(CalendarLeft, CalendarTop: Integer; var CalendarDate: TDateTime; var RGItemIndex: Integer): Boolean;
var
  Calendar: AUiCalendarDialog_Type;
  Dialog: ADialog;
  MonthCalendar: TMonthCalendar;
begin
  Dialog := AUiDialog_New(AMessageBoxFlags_OkCancel);
  Calendar.Window := AUiDialog_GetWindow(Dialog);
  MonthCalendar := _InitCalendarWin(Calendar, CalendarDate);
  AUiControl_SetPosition(Calendar.Window, CalendarLeft, CalendarTop);

  Calendar.RadioGroup := TRadioGroup.Create(nil);
  Calendar.RadioGroup.Parent := TWinControl(Calendar.Window);
  Calendar.RadioGroup.Left := 208;
  Calendar.RadioGroup.Top := 40;
  Calendar.RadioGroup.Width := 121;
  Calendar.RadioGroup.Height := 105;
  Calendar.RadioGroup.Caption := 'Начало работы';
  Calendar.RadioGroup.Items.Add('До этой даты');
  Calendar.RadioGroup.Items.Add('После этой даты');
  Calendar.RadioGroup.TabOrder := 3;

  Result := AUiWindow_ShowModal(Calendar.Window);
  if (Result) then
  begin
    RGItemIndex := Calendar.RadioGroup.ItemIndex;
    CalendarDate := MonthCalendar.Date;
  end;

  AUiDialog_Free(Dialog);
end;

// --- AUi ---

function AUi_ExecuteCalendarDialog(var Date: TDateTime; CenterX, CenterY: AInt): ABoolean;
begin
  try
    {$IFDEF FPC}
    Result := False;
    {$ELSE}
    Result := _ShowCalendarWin(Date, CenterX, CenterY);
    {$ENDIF}
  except
    Result := False;
  end;
end;

end.
