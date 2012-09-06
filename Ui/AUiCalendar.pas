{**
@Abstract AUi calendar
@Author Prof1983 <prof1983@ya.ru>
@Created 06.09.2012
@LastMod 06.09.2012
}
unit AUiCalendar;

interface

uses
  Controls,
  ABase, AUiBase, AUiCalendarObj;

// --- AUiCalendar ---

function AUiCalendar_GetDate(Calendar: AControl): TDateTime; stdcall;

function AUiCalendar_New(Parent: AControl): AControl; stdcall;

function AUiCalendar_SetMonth(Calendar: AControl; Value: AInteger): AError; stdcall;

// --- UI_Calendar ---

function UI_Calendar_GetDate(Calendar: AControl): TDateTime; stdcall; deprecated; // Use AUiCalendar_GetDate()

function UI_Calendar_New(Parent: AControl): AControl; stdcall; deprecated; // Use AUiCalendar_New();

procedure UI_Calendar_SetMonth(Calendar: AControl; Value: AInteger); stdcall; deprecated; // Use AUiCalendar_SetMonth()

implementation

// --- AUiCalendar ---

function AUiCalendar_GetDate(Calendar: AControl): TDateTime;
begin
  try
    {$IFDEF FPC}
    Result := TCalendar(Calendar).DateTime;
    {$ELSE}
    Result := TCalendar(Calendar).CalendarDate;
    {$ENDIF}
  except
    Result := -1;
  end;
end;

function AUiCalendar_New(Parent: AControl): AControl;
var
  Calendar: TCalendar;
begin
  try
    Calendar := TCalendar.Create(TWinControl(Parent));
    Calendar.Parent := TWinControl(Parent);
    {$IFNDEF FPC}
    Calendar.StartOfWeek := 0;
    {$ENDIF}
    Result := AControl(Calendar);
  except
    Result := 0;
  end;
end;

function AUiCalendar_SetMonth(Calendar: AControl; Value: AInteger): AError;
begin
  try
    {$IFNDEF FPC}
    TCalendar(Calendar).Month := Value;
    {$ENDIF}
    Result := 0;
  except
    Result := -1;
  end;
end;

// --- UI_Calendar ---

function UI_Calendar_GetDate(Calendar: AControl): TDateTime;
begin
  Result := AUiCalendar_GetDate(Calendar);
end;

function UI_Calendar_New(Parent: AControl): AControl;
begin
  Result := AUiCalendar_New(Parent);
end;

procedure UI_Calendar_SetMonth(Calendar: AControl; Value: AInteger);
begin
  AUiCalendar_SetMonth(Calendar, Value);
end;

end.
