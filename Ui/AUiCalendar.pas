{**
@Abstract AUi calendar
@Author Prof1983 <prof1983@ya.ru>
@Created 06.09.2012
@LastMod 19.02.2013
}
unit AUiCalendar;

{define AStdCall}

interface

uses
  Controls,
  ABase, AUiBase, AUiCalendarObj;

// --- AUiCalendar ---

function AUiCalendar_GetDate(Calendar: AControl): TDateTime; {$ifdef AStdCall}stdcall;{$endif}

function AUiCalendar_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiCalendar_SetMonth(Calendar: AControl; Value: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

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

function AUiCalendar_SetMonth(Calendar: AControl; Value: AInt): AError;
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

end.
