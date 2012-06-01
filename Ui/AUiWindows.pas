{**
@Abstract(User Interface window functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.08.2011)
@LastMod(21.09.2011)
@Version(0.5)
}
unit AUiWindows;

interface

uses
  Controls, Forms, ABase, AUiBase, AUiData;

// Возвращает главное меню указанного окна
function UI_Window_GetMenu(Window: AWindow): AMenu; stdcall;

function UI_Window_New(): AControl;

procedure UI_Window_SetState(Window: AWindow; State: AInteger);

function UI_Window_ShowModal(Window: AWindow): ABoolean; stdcall;

implementation

{ Public }

function UI_Window_GetMenu(Window: AWindow): AMenu; stdcall;
var
  O: TObject;
begin
  O := AUIData.GetObject(Window);
  if Assigned(O) and (O is TForm) then
  begin
    Result := Integer(TForm(O).Menu);
  end
  else
    Result := 0;
end;

function UI_Window_New(): AControl;
begin
  Result := AddObject(TForm.Create(nil));
end;

procedure UI_Window_SetState(Window: AWindow; State: AInteger);
begin
  (TObject(Window) as TForm).WindowState := TWindowState(State); //IntToWindowState(State);
end;

function UI_Window_ShowModal(Window: AWindow): ABoolean; stdcall;
begin
  Result := (TForm(Window).ShowModal = mrOk);
end;

end.
 