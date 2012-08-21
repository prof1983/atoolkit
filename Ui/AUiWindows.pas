{**
@Abstract User Interface window functions
@Author Prof1983 <prof1983@ya.ru>
@Created 11.08.2011
@LastMod 21.08.2012
}
unit AUiWindows;

interface

uses
  Controls, Forms,
  ABase, AUiBase, AUiData;

// --- AUiWindow ---

function AUi_Window_Add(Window: AWindow): AError;

function AUi_Window_Free(Window: AWindow): AError;

function AUi_Window_FreeAndNil(var Window: AWindow): AError;

function AUi_Window_GetMenu(Window: AWindow): AMenu;

function AUi_Window_New(): AControl;

function AUi_Window_SetBorderStyle(Window: AWindow; BorderStyle: AInt): AError;

function AUi_Window_SetFormStyle(Window: AWindow; FormStyle: AInt): AError;

function AUi_Window_SetPosition(Window: AWindow; Position: AInt): AError;

function AUi_Window_SetState(Window: AWindow; State: AInt): AError;

function AUi_Window_ShowModal(Window: AWindow): ABoolean;

// --- UI_Window ---

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

// --- AUi_Window ---

function AUi_Window_Add(Window: AWindow): AError;
begin
  try
    if (Window = 0) then
    begin
      Result := -1;
      Exit;
    end;

    if not(TObject(Window) is TForm) then
    begin
      Result := -2;
      Exit;
    end;

    if (FindObject(TObject(Window)) >= 0) then
    begin
      Result := -3;
      Exit;
    end;

    Result := AddObject(TObject(Window));

    if Assigned(TForm(Window).Menu) then
    begin
      AddObject(TForm(Window).Menu);
    end;
  except
    Result := -99;
  end;
end;

function AUi_Window_Free(Window: AWindow): AError;
begin
  try
    AUi_Control_Free(Window);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUi_Window_FreeAndNil(var Window: AWindow): AError;
begin
  try
    AUi_Window_Free(Window);
    Window := 0;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUi_Window_GetMenu(Window: AWindow): AMenu;
var
  O: TObject;
begin
  try
    O := AUiData.GetObject(Window);
    if Assigned(O) and (O is TForm) then
    begin
      Result := AMenu(TForm(O).Menu);
    end
    else
      Result := 0;
  except
    Result := 0;
  end;
end;

function AUi_Window_New(): AControl;
begin
  try
    Result := AddObject(TForm.Create(nil));
  except
    Result := 0;
  end;
end;

function AUi_Window_SetBorderStyle(Window: AWindow; BorderStyle: AInt): AError;
begin
  try
    TForm(Window).BorderStyle := TBorderStyle(BorderStyle);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUi_Window_SetFormStyle(Window: AWindow; FormStyle: AInt): AError;
begin
  try
    TForm(Window).FormStyle := TFormStyle(FormStyle);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUi_Window_SetPosition(Window: AWindow; Position: AInt): AError;
begin
  try
    TForm(Window).Position := TPosition(poScreenCenter);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUi_Window_SetState(Window: AWindow; State: AInt): AError;
begin
  try
    (TObject(Window) as TForm).WindowState := TWindowState(State);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUi_Window_ShowModal(Window: AWindow): ABoolean;
begin
  try
    Result := (TForm(Window).ShowModal = mrOk);
  except
    Result := False;
  end;
end;

// --- UI_Window ---

function UI_Window_GetMenu(Window: AWindow): AMenu;
begin
  Result := AUi_Window_GetMenu(Window);
end;

function UI_Window_New(): AControl;
begin
  Result := AUi_Window_New();
end;

procedure UI_Window_SetBorderStyle(Window: AWindow; BorderStyle: AInteger);
begin
  AUi_Window_SetBorderStyle(Window, BorderStyle);
end;

procedure UI_Window_SetFormStyle(Window: AWindow; FormStyle: AInteger);
begin
  AUi_Window_SetFormStyle(Window, FormStyle);
end;

procedure UI_Window_SetPosition(Window: AWindow; Position: AInteger);
begin
  AUi_Window_SetPosition(Window, Position);
end;

procedure UI_Window_SetState(Window: AWindow; State: AInteger);
begin
  AUi_Window_SetState(Window, State);
end;

function UI_Window_ShowModal(Window: AWindow): ABoolean;
begin
  Result := AUi_Window_ShowModal(Window);
end;

end.
 