{**
@Abstract AUi controls functions
@Author Prof1983 <prof1983@ya.ru>
@Created 25.10.2011
@LastMod 22.08.2012
}
unit AUiControlsA;

interface

uses
  ComCtrls,
  ABase, AUiBase, AUiCalendar, AUiData, AUiEventsObj;

// --- AUiControl ---

function AUiControl_SetOnChange(Control: AControl; OnChange: ACallbackProc): AError;

function AUiControl_SetOnChange02(Control: AControl; OnChange: ACallbackProc02): AError;

function AUiControl_SetOnChange03(Control: AControl; OnChange: ACallbackProc03): AError;

function AUiControl_SetOnChangeEx02(Control: AControl; OnChange: ACallbackProc02; Obj: AInteger): AError;

function AUiControl_SetOnChangeEx03(Control: AControl; OnChange: ACallbackProc03; Obj: AInteger): AError;

// ---  UI_Control ---

function UI_Control_SetOnChange(Control: AControl; OnChange: ACallbackProc): AError;
function UI_Control_SetOnChange02(Control: AControl; OnChange: ACallbackProc02): AError;
function UI_Control_SetOnChange03(Control: AControl; OnChange: ACallbackProc03): AError;
function UI_Control_SetOnChangeEx02(Control: AControl; OnChange: ACallbackProc02; Obj: AInteger): AError;
function UI_Control_SetOnChangeEx03(Control: AControl; OnChange: ACallbackProc03; Obj: AInteger): AError;

implementation

// --- AUiControl ---

function AUiControl_SetOnChange(Control: AControl; OnChange: ACallbackProc): AError;
begin
  {$IFDEF A01}
    Result := AUiControl_SetOnChange02(Control, OnChange);
  {$ELSE}
    {$IFDEF A02}
    Result := AUiControl_SetOnChange02(Control, OnChange);
    {$ELSE}
    Result := AUiControl_SetOnChange03(Control, OnChange);
    {$ENDIF A02}
  {$ENDIF A01}
end;

function AUiControl_SetOnChange02(Control: AControl; OnChange: ACallbackProc02): AError;
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
        FCalendars[I].OnChange02 := OnChange;
        FCalendars[I].OnChangeObj := 0;
      end;
    end
    else if (TObject(Control) is TPageControl) then
    begin
      I := FindPageControl(Control);
      if (I >= 0) then
      begin
        TPageControl(FPageControls[I].PageControl).OnChange := UI_.PageControlChange;
        FPageControls[I].OnChange02 := OnChange;
      end;
    end;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiControl_SetOnChange03(Control: AControl; OnChange: ACallbackProc03): AError;
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
        FCalendars[I].OnChange03 := OnChange;
        FCalendars[I].OnChangeObj := 0;
      end;
    end
    else if (TObject(Control) is TPageControl) then
    begin
      I := FindPageControl(Control);
      if (I >= 0) then
      begin
        TPageControl(FPageControls[I].PageControl).OnChange := UI_.PageControlChange;
        FPageControls[I].OnChange03 := OnChange;
      end;
    end;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiControl_SetOnChangeEx02(Control: AControl; OnChange: ACallbackProc02; Obj: AInteger): AError;
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
        FCalendars[I].OnChange02 := OnChange;
        FCalendars[I].OnChangeObj := Obj;
      end;
    end;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiControl_SetOnChangeEx03(Control: AControl; OnChange: ACallbackProc03; Obj: AInteger): AError;
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
        FCalendars[I].OnChange03 := OnChange;
        FCalendars[I].OnChangeObj := Obj;
      end;
    end;
    Result := 0;
  except
    Result := -1;
  end;
end;

// --- UI_Control ---

function UI_Control_SetOnChange(Control: AControl; OnChange: ACallbackProc): AError;
begin
  Result := AUiControl_SetOnChange(Control, OnChange);
end;

function UI_Control_SetOnChange02(Control: AControl; OnChange: ACallbackProc02): AError;
begin
  Result := AUiControl_SetOnChange02(Control, OnChange);
end;

function UI_Control_SetOnChange03(Control: AControl; OnChange: ACallbackProc03): AError;
begin
  Result := AUiControl_SetOnChange03(Control, OnChange);
end;

procedure UI_Control_SetOnChange2(Control: AControl; OnChange: ACallbackProc02; Obj: AInteger);
begin
  AUiControl_SetOnChangeEx02(Control, OnChange, Obj);
end;

function UI_Control_SetOnChangeEx02(Control: AControl; OnChange: ACallbackProc02; Obj: AInteger): AError;
begin
  Result := AUiControl_SetOnChangeEx02(Control, OnChange, Obj);
end;

function UI_Control_SetOnChangeEx03(Control: AControl; OnChange: ACallbackProc03; Obj: AInteger): AError;
begin
  Result := AUiControl_SetOnChangeEx03(Control, OnChange, Obj);
end;

end.
 