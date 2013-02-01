{**
@Abstract AUi window setting functions
@Author Prof1983 <prof1983@ya.ru>
@Created 10.08.2012
@LastMod 30.01.2013
}
unit AUiWindowSettings;

{define AStdCall}

interface

uses
  Forms,
  ABase,
  AStringMain,
  AUiForm,
  AUiBase;

// --- AUiWindow ---

function AUiWindow_LoadConfig(Window: AWindow; Config: AConfig): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWindow_LoadConfig2(Window: AWindow; Config: AConfig; const ConfigKey: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWindow_LoadConfig2P(Window: AWindow; Config: AConfig; const ConfigKey: APascalString): AError;

function AUiWindow_LoadConfig3P(Window: AWindow; Config: AConfig; const ConfigKey: APascalString; DefWindowState: AInteger): AError;

function AUiWindow_SaveConfig(Window: AWindow; Config: AConfig): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWindow_SaveConfig2(Window: AWindow; Config: AConfig; const ConfigKey: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWindow_SaveConfig2P(Window: AWindow; Config: AConfig; const ConfigKey: APascalString): AError;

implementation

// --- AUiWindow ---

function AUiWindow_LoadConfig(Window: AWindow; Config: AConfig): AError;
begin
  if (Window = 0) then
  begin
    Result := -4;
    Exit;
  end;
  try
    if not(TObject(Window) is TForm) then
    begin
      Result := -5;
      Exit;
    end;
    Result := AUiForm.Form_LoadConfig(TForm(Window), Config);
  except
    Result := -1;
  end;
end;

function AUiWindow_LoadConfig2(Window: AWindow; Config: AConfig; const ConfigKey: AString_Type): AError;
begin
  if (Window = 0) then
  begin
    Result := -4;
    Exit;
  end;
  try
    if not(TObject(Window) is TForm) then
    begin
      Result := -5;
      Exit;
    end;
    Result := Form_LoadConfig2(TForm(Window), Config, AString_ToPascalString(ConfigKey));
  except
    Result := -1;
  end;
end;

function AUiWindow_LoadConfig2P(Window: AWindow; Config: AConfig; const ConfigKey: APascalString): AError;
begin
  if (Window = 0) then
  begin
    Result := -4;
    Exit;
  end;
  try
    if not(TObject(Window) is TForm) then
    begin
      Result := -5;
      Exit;
    end;
    Result := Form_LoadConfig2(TForm(Window), Config, ConfigKey);
  except
    Result := -1;
  end;
end;

function AUiWindow_LoadConfig3P(Window: AWindow; Config: AConfig; const ConfigKey: APascalString; DefWindowState: AInteger): AError;
begin
  if (Window = 0) then
  begin
    Result := -4;
    Exit;
  end;
  try
    if not(TObject(Window) is TForm) then
    begin
      Result := -5;
      Exit;
    end;
    Result := Form_LoadConfig4(TForm(Window), Config, ConfigKey, DefWindowState);
  except
    Result := -1;
  end;
end;

function AUiWindow_SaveConfig(Window: AWindow; Config: AConfig): AError;
begin
  if (Window = 0) then
  begin
    Result := -4;
    Exit;
  end;
  try
    if not(TObject(Window) is TForm) then
    begin
      Result := -5;
      Exit;
    end;
    Result := AUiForm.Form_SaveConfig(TForm(Window), Config);
  except
    Result := -1;
  end;
end;

function AUiWindow_SaveConfig2(Window: AWindow; Config: AConfig; const ConfigKey: AString_Type): AError;
begin
  if (Window = 0) then
  begin
    Result := -4;
    Exit;
  end;
  try
    if not(TObject(Window) is TForm) then
    begin
      Result := -5;
      Exit;
    end;
    Result := AUiWindow_SaveConfig2P(Window, Config, AString_ToPascalString(ConfigKey));
  except
    Result := -1;
  end;
end;

function AUiWindow_SaveConfig2P(Window: AWindow; Config: AConfig; const ConfigKey: APascalString): AError;
begin
  if (Window = 0) then
  begin
    Result := -4;
    Exit;
  end;
  try
    if not(TObject(Window) is TForm) then
    begin
      Result := -5;
      Exit;
    end;
    Result := AUiForm.Form_SaveConfig2(TForm(Window), Config, ConfigKey);
  except
    Result := -1;
  end;
end;

end.
