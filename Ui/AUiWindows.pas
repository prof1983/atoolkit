{**
@Abstract User Interface window functions
@Author Prof1983 <prof1983@ya.ru>
@Created 11.08.2011
@LastMod 21.11.2012
}
unit AUiWindows;

{$define AStdCall}

interface

uses
  Controls, Forms,
  ABase, AUiControls, AUiBase, AUiData;

// --- AUiWindow ---

function AUiWindow_Add(Window: AWindow): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWindow_Free(Window: AWindow): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWindow_FreeAndNil(var Window: AWindow): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWindow_GetMenu(Window: AWindow): AMenu; {$ifdef AStdCall}stdcall;{$endif}

function AUiWindow_New(): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiWindow_SetBorderStyle(Window: AWindow; BorderStyle: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWindow_SetFormStyle(Window: AWindow; FormStyle: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWindow_SetPosition(Window: AWindow; Position: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWindow_SetState(Window: AWindow; State: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWindow_ShowModal(Window: AWindow): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

// --- UI_Window ---

procedure UI_Window_Free(Window: AWindow); {$ifdef AStdCall}stdcall;{$endif} deprecated; // Use AUiWindow_Free()

procedure UI_Window_FreeAndNil(var Window: AWindow); {$ifdef AStdCall}stdcall;{$endif}

{** Возвращает главное меню указанного окна }
function UI_Window_GetMenu(Window: AWindow): AMenu; {$ifdef AStdCall}stdcall;{$endif} deprecated; // Use AUiWindow_GetMenu()

function UI_Window_New(): AControl; {$ifdef AStdCall}stdcall;{$endif} deprecated; // Use AUiWindow_New()

{** Задает стить окантовки окна }
procedure UI_Window_SetBorderStyle(Window: AWindow; BorderStyle: AInteger); {$ifdef AStdCall}stdcall;{$endif} deprecated; // Use AUiWindow_SetBorderStyle()

{** Задает стиль окна }
procedure UI_Window_SetFormStyle(Window: AWindow; FormStyle: AInteger); {$ifdef AStdCall}stdcall;{$endif} deprecated; // Use AUiWindow_SetFormStyle()

{** Задает позицию окна }
procedure UI_Window_SetPosition(Window: AWindow; Position: AInteger); {$ifdef AStdCall}stdcall;{$endif} deprecated; // Use AUiWindow_SetPosition()

procedure UI_Window_SetState(Window: AWindow; State: AInteger); {$ifdef AStdCall}stdcall;{$endif}

function UI_Window_ShowModal(Window: AWindow): ABoolean; {$ifdef AStdCall}stdcall;{$endif} deprecated; // Use AUiWindow_ShowModal()

implementation

// --- AUiWindow ---

function AUiWindow_Add(Window: AWindow): AError;
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

function AUiWindow_Free(Window: AWindow): AError;
begin
  try
    AUiControl_Free(Window);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiWindow_FreeAndNil(var Window: AWindow): AError;
begin
  try
    AUiWindow_Free(Window);
    Window := 0;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiWindow_GetMenu(Window: AWindow): AMenu;
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

function AUiWindow_New(): AControl;
begin
  try
    Result := AddObject(TForm.Create(nil));
  except
    Result := 0;
  end;
end;

function AUiWindow_SetBorderStyle(Window: AWindow; BorderStyle: AInt): AError;
begin
  try
    TForm(Window).BorderStyle := TBorderStyle(BorderStyle);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiWindow_SetFormStyle(Window: AWindow; FormStyle: AInt): AError;
begin
  try
    TForm(Window).FormStyle := TFormStyle(FormStyle);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiWindow_SetPosition(Window: AWindow; Position: AInt): AError;
begin
  try
    TForm(Window).Position := TPosition(poScreenCenter);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiWindow_SetState(Window: AWindow; State: AInt): AError;
begin
  try
    (TObject(Window) as TForm).WindowState := TWindowState(State);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiWindow_ShowModal(Window: AWindow): ABoolean;
begin
  try
    Result := (TForm(Window).ShowModal = mrOk);
  except
    Result := False;
  end;
end;

// --- UI_Window ---

procedure UI_Window_Free(Window: AWindow);
begin
  AUiWindow_Free(Window);
end;

procedure UI_Window_FreeAndNil(var Window: AWindow);
begin
  AUiWindow_FreeAndNil(Window);
end;

function UI_Window_GetMenu(Window: AWindow): AMenu;
begin
  Result := AUiWindow_GetMenu(Window);
end;

function UI_Window_New(): AControl;
begin
  Result := AUiWindow_New();
end;

procedure UI_Window_SetBorderStyle(Window: AWindow; BorderStyle: AInteger);
begin
  AUiWindow_SetBorderStyle(Window, BorderStyle);
end;

procedure UI_Window_SetFormStyle(Window: AWindow; FormStyle: AInteger);
begin
  AUiWindow_SetFormStyle(Window, FormStyle);
end;

procedure UI_Window_SetPosition(Window: AWindow; Position: AInteger);
begin
  AUiWindow_SetPosition(Window, Position);
end;

procedure UI_Window_SetState(Window: AWindow; State: AInteger);
begin
  AUiWindow_SetState(Window, State);
end;

function UI_Window_ShowModal(Window: AWindow): ABoolean;
begin
  Result := AUiWindow_ShowModal(Window);
end;

end.
