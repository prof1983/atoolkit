{**
@Abstract User Interface window functions
@Author Prof1983 <prof1983@ya.ru>
@Created 11.08.2011
@LastMod 19.07.2012
}
unit AUIWindows;

interface

uses
  Controls, Forms, 
  ABase, AUiBase, AUiData;

//** Возвращает главное меню указанного окна.
function UI_Window_GetMenu(Window: AWindow): AMenu;

function UI_Window_New(): AControl;

//** Задает стиль окантовки окна.
procedure UI_Window_SetBorderStyle(Window: AWindow; BorderStyle: AInteger);

//** Задает стиль окна.
procedure UI_Window_SetFormStyle(Window: AWindow; FormStyle: AInteger);

//** Задает позицию окна.
procedure UI_Window_SetPosition(Window: AWindow; Position: AInteger);

procedure UI_Window_SetState(Window: AWindow; State: AInteger);

function UI_Window_ShowModal(Window: AWindow): ABoolean;

implementation

{ Public }

function UI_Window_GetMenu(Window: AWindow): AMenu;
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

procedure UI_Window_SetBorderStyle(Window: AWindow; BorderStyle: AInteger);
begin
  TForm(Window).BorderStyle := TBorderStyle(BorderStyle);
end;

procedure UI_Window_SetFormStyle(Window: AWindow; FormStyle: AInteger);
begin
  TForm(Window).FormStyle := TFormStyle(FormStyle);
end;

procedure UI_Window_SetPosition(Window: AWindow; Position: AInteger);
begin
  TForm(Window).Position := TPosition(poScreenCenter);
end;

procedure UI_Window_SetState(Window: AWindow; State: AInteger);
begin
  (TObject(Window) as TForm).WindowState := TWindowState(State); //IntToWindowState(State);
end;

function UI_Window_ShowModal(Window: AWindow): ABoolean;
begin
  Result := (TForm(Window).ShowModal = mrOk);
end;

end.
 