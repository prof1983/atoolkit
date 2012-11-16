{**
@Abstract AUi window setting functions
@Author Prof1983 <prof1983@ya.ru>
@Created 10.08.2012
@LastMod 13.08.2012
}
unit AUiWindowSettings;

interface

uses
  Forms,
  ABase, ASettings, AStrings, AUiForm, AUiBase;

// --- AUiWindow ---

function AUiWindow_LoadConfig(Window: AWindow; Config: AConfig): AError; stdcall;

function AUiWindow_LoadConfig2P(Window: AWindow; Config: AConfig; const ConfigKey: APascalString): AError; stdcall;

function AUiWindow_LoadConfig3P(Window: AWindow; Config: AConfig; const ConfigKey: APascalString; DefWindowState: AInteger): AError; stdcall;

function AUiWindow_SaveConfig(Window: AWindow; Config: AConfig): AError; stdcall;

function AUiWindow_SaveConfig2P(Window: AWindow; Config: AConfig; const ConfigKey: APascalString): AError; stdcall;

// --- AUi_Window ---

function AUi_Window_LoadConfig2(Window: AWindow; Config: AConfig; const ConfigKey: AString_Type): ABoolean; stdcall;

function AUi_Window_LoadConfig2P(Window: AWindow; Config: AConfig; const ConfigKey: APascalString): ABoolean; stdcall;

function AUi_Window_SaveConfig(Window: AWindow; Config: AConfig): ABoolean; stdcall;

function AUi_Window_SaveConfig2(Window: AWindow; Config: AConfig; const ConfigKey: AString_Type): ABoolean; stdcall;

// --- UI_Window ---

function UI_Window_LoadConfig(Window: AWindow; Config: AConfig): ABoolean; stdcall; deprecated; // Use AUi_Window_LoadConfig()

function UI_Window_LoadConfig2(Window: AWindow; Config: AConfig; const ConfigKey: APascalString): ABoolean; stdcall; deprecated; // Use AUi_Window_LoadConfig2P()

function UI_Window_SaveConfig(Window: AWindow; Config: AConfig): ABoolean; stdcall; deprecated; // Use AUi_Window_SaveConfig()

function UI_Window_SaveConfig2(Window: AWindow; Config: AConfig; const ConfigKey: APascalString): ABoolean; stdcall;

implementation

// --- AUiWindow ---

function AUiWindow_LoadConfig(Window: AWindow; Config: AConfig): AError;
begin
  try
    if AUiForm.Form_LoadConfig(TForm(Window), Config) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function AUiWindow_LoadConfig2P(Window: AWindow; Config: AConfig; const ConfigKey: APascalString): AError;
begin
  try
    if Form_LoadConfig2(TForm(Window), Config, ConfigKey) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function AUiWindow_LoadConfig3P(Window: AWindow; Config: AConfig; const ConfigKey: APascalString; DefWindowState: AInteger): AError;
begin
  try
    if Form_LoadConfig4(TForm(Window), Config, ConfigKey, DefWindowState) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function AUiWindow_SaveConfig(Window: AWindow; Config: AConfig): AError;
begin
  try
    if AUiForm.Form_SaveConfig(TForm(Window), Config) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function AUiWindow_SaveConfig2P(Window: AWindow; Config: AConfig; const ConfigKey: APascalString): AError;
begin
  try
    if AUiForm.Form_SaveConfig2(TForm(Window), Config, ConfigKey) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

// --- AUi_Window ---

function AUi_Window_LoadConfig2(Window: AWindow; Config: AConfig; const ConfigKey: AString_Type): ABoolean;
begin
  try
    if not(TObject(Window) is TForm) then
    begin
      Result := False;
      Exit;
    end;
    Result := Form_LoadConfig2(TForm(Window), Config, AStrings.String_ToWideString(ConfigKey));
  except
    Result := False;
  end;
end;

function AUi_Window_LoadConfig2P(Window: AWindow; Config: AConfig; const ConfigKey: APascalString): ABoolean;
begin
  try
    Result := Form_LoadConfig2(TForm(Window), Config, ConfigKey);
  except
    Result := False;
  end;
end;

function AUi_Window_SaveConfig(Window: AWindow; Config: AConfig): ABoolean;
begin
  try
    if not(TObject(Window) is TForm) then
    begin
      Result := False;
      Exit;
    end;
    Result := AUIForm.Form_SaveConfig(TForm(Window), Config);
  except
    Result := False;
  end;
end;

function AUi_Window_SaveConfig2(Window: AWindow; Config: AConfig; const ConfigKey: AString_Type): ABoolean;
begin
  try
    Result := UI_Window_SaveConfig2(Window, Config, AStrings.String_ToWideString(ConfigKey));
  except
    Result := False;
  end;
end;

// --- UI_Window ---

function UI_Window_LoadConfig(Window: AWindow; Config: AConfig): ABoolean;
begin
  Result := (AUiWindow_LoadConfig(Window, Config) = 0);
end;

function UI_Window_LoadConfig2(Window: AWindow; Config: AConfig; const ConfigKey: APascalString): ABoolean;
begin
  Result := AUi_Window_LoadConfig2P(Window, Config, ConfigKey);
end;

function UI_Window_SaveConfig(Window: AWindow; Config: AConfig): ABoolean;
begin
  Result := AUIForm.Form_SaveConfig(TForm(Window), Config);
end;

function UI_Window_SaveConfig2(Window: AWindow; Config: AConfig; const ConfigKey: APascalString): ABoolean;
begin
  Result := Form_SaveConfig2(TForm(Window), Config, ConfigKey);
end;

end.
