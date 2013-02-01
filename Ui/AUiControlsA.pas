{**
@Abstract AUi controls functions
@Author Prof1983 <prof1983@ya.ru>
@Created 25.10.2011
@LastMod 30.01.2013
}
unit AUiControlsA;

{define AStdCall}

interface

uses
  ComCtrls,
  ABase, AUiBase, AUiCalendarObj, AUiData, AUiEventsObj;

// --- AUiControl ---

function AUiControl_SetOnChange(Control: AControl; OnChange: ACallbackProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetOnChangeEx(Control: AControl; OnChange: ACallbackProc; Obj: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

// --- AUiControl ---

function AUiControl_SetOnChange(Control: AControl; OnChange: ACallbackProc): AError;
var
  I: Integer;
begin
  if (Control = 0) then
  begin
    Result := -1;
    Exit;
  end;

  try
    if (TObject(Control) is TCalendar) then
    begin
      I := FindCalendar(Control);
      if (I >= 0) then
      begin
        FCalendars[I].OnChange := OnChange;
        FCalendars[I].OnChangeObj := 0;
      end;
    end
    else if (TObject(Control) is TPageControl) then
    begin
      I := FindPageControl(Control);
      if (I >= 0) then
      begin
        TPageControl(FPageControls[I].PageControl).OnChange := UI_.PageControlChange;
        FPageControls[I].OnChange := OnChange;
      end;
    end;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiControl_SetOnChangeEx(Control: AControl; OnChange: ACallbackProc; Obj: AInteger): AError;
var
  I: Integer;
begin
  if (Control = 0) then
  begin
    Result := -1;
    Exit;
  end;

  try
    if (TObject(Control) is TCalendar) then
    begin
      I := FindCalendar(Control);
      if (I >= 0) then
      begin
        FCalendars[I].OnChange := OnChange;
        FCalendars[I].OnChangeObj := Obj;
      end;
    end;
    Result := 0;
  except
    Result := -1;
  end;
end;

end.
 