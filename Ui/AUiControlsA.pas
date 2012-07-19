{**
@Abstract Дополнительные фукнкции AUiControls
@Author Prof1983 <prof1983@ya.ru>
@Created 25.10.2011
@LastMod 19.07.2012
}
unit AUiControlsA;

interface

uses
  ComCtrls,
  ABase, AUiBase, AUiCalendar, AUiData, AUiEvents;

function UI_Control_SetOnChange(Control: AControl; OnChange: ACallbackProc): AError;
function UI_Control_SetOnChange02(Control: AControl; OnChange: ACallbackProc02): AError;
function UI_Control_SetOnChange03(Control: AControl; OnChange: ACallbackProc03): AError;
function UI_Control_SetOnChangeEx02(Control: AControl; OnChange: ACallbackProc02; Obj: AInteger): AError;
function UI_Control_SetOnChangeEx03(Control: AControl; OnChange: ACallbackProc03; Obj: AInteger): AError;

implementation

function UI_Control_SetOnChange(Control: AControl; OnChange: ACallbackProc): AError;
begin
  {$IFDEF A01}
    Result := UI_Control_SetOnChange02(Control, OnChange);
  {$ELSE}
    {$IFDEF A02}
    Result := UI_Control_SetOnChange02(Control, OnChange);
    {$ELSE}
    Result := UI_Control_SetOnChange03(Control, OnChange);
    {$ENDIF A02}
  {$ENDIF A01}
end;

function UI_Control_SetOnChange02(Control: AControl; OnChange: ACallbackProc02): AError;
var
  I: Integer;
begin
  if (Control = 0) then
  begin
    Result := -1;
    Exit;
  end;

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
end;

function UI_Control_SetOnChange03(Control: AControl; OnChange: ACallbackProc03): AError;
var
  I: Integer;
begin
  if (Control = 0) then
  begin
    Result := -1;
    Exit;
  end;

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
end;

function UI_Control_SetOnChangeEx02(Control: AControl; OnChange: ACallbackProc02; Obj: AInteger): AError;
var
  I: Integer;
begin
  if (Control = 0) then
  begin
    Result := -1;
    Exit;
  end;

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
end;

function UI_Control_SetOnChangeEx03(Control: AControl; OnChange: ACallbackProc03; Obj: AInteger): AError;
var
  I: Integer;
begin
  if (Control = 0) then
  begin
    Result := -1;
    Exit;
  end;

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
end;

end.
 