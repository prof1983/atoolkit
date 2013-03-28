{**
@Abstract User Interface window functions
@Author Prof1983 <prof1983@ya.ru>
@Created 11.08.2011
@LastMod 28.03.2013
}
unit AUiWindows;

{define AStdCall}

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

function AUiWindow_SetActiveControl(Window: AWindow; Control: AControl): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWindow_SetBorderStyle(Window: AWindow; BorderStyle: AUiBorderStyle): AError; {$ifdef AStdCall}stdcall;{$endif} deprecated {$ifdef ADeprText}'Use AUiControl_SetBorderStyle()'{$endif};

function AUiWindow_SetFormStyle(Window: AWindow; FormStyle: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWindow_SetPosition(Window: AWindow; Position: AUiWindowPosition): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWindow_SetState(Window: AWindow; State: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWindow_ShowModal(Window: AWindow): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUiWindow_ShowModal2(Window: AWindow): AInt; {$ifdef AStdCall}stdcall;{$endif}

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

function AUiWindow_SetActiveControl(Window: AWindow; Control: AControl): AError;
begin
  try
    TForm(Window).ActiveControl := TWinControl(Control);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiWindow_SetBorderStyle(Window: AWindow; BorderStyle: AUiBorderStyle): AError;
begin
  Result := AUiControl_SetBorderStyle(Window, BorderStyle);
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

function AUiWindow_SetPosition(Window: AWindow; Position: AUiWindowPosition): AError;
var
  P: TPosition;
begin
  try
    case Position of
      AUiWindowPosition_Designed: P := poDesigned;
      AUiWindowPosition_Default: P := poDefault;
      AUiWindowPosition_DefaultPosOnly: P := poDefaultPosOnly;
      AUiWindowPosition_DefaultSizeOnly: P := poDefaultSizeOnly;
      AUiWindowPosition_ScreenCenter: P := poScreenCenter;
      AUiWindowPosition_DesktopCenter: P := poDesktopCenter;
      AUiWindowPosition_MainFormCenter: P := poMainFormCenter;
      AUiWindowPosition_OwnerFormCenter: P := poOwnerFormCenter;
    else
      P := poMainFormCenter;
    end;
    TForm(Window).Position := P;
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

function AUiWindow_ShowModal(Window: AWindow): ABool;
begin
  try
    Result := (TForm(Window).ShowModal = mrOk);
  except
    Result := False;
  end;
end;

function AUiWindow_ShowModal2(Window: AWindow): AInt;
begin
  try
    Result := TForm(Window).ShowModal();
  except
    Result := 0;
  end;
end;

end.
