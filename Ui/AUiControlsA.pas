{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(25.10.2011)
@LastMod(25.10.2011)
@Version(0.5)
}
unit AUiControlsA;

interface

uses
  ComCtrls,
  ABase, AUiBase, AUiCalendar, AUiData, AUiEvents;

function UI_Control_SetOnChange02(Control: AControl; OnChange: ACallbackProc02): AError; stdcall;
function UI_Control_SetOnChange03(Control: AControl; OnChange: ACallbackProc03): AError; stdcall;
function UI_Control_SetOnChangeEx02(Control: AControl; OnChange: ACallbackProc02; Obj: AInteger): AError; stdcall;
function UI_Control_SetOnChangeEx03(Control: AControl; OnChange: ACallbackProc03; Obj: AInteger): AError; stdcall;

implementation

function UI_Control_SetOnChange02(Control: AControl; OnChange: ACallbackProc02): AError; stdcall;
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

function UI_Control_SetOnChange03(Control: AControl; OnChange: ACallbackProc03): AError; stdcall;
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

function UI_Control_SetOnChangeEx02(Control: AControl; OnChange: ACallbackProc02; Obj: AInteger): AError; stdcall;
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

function UI_Control_SetOnChangeEx03(Control: AControl; OnChange: ACallbackProc03; Obj: AInteger): AError; stdcall;
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
 