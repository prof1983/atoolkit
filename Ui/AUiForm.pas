{**
@Abstract AUi form config functions
@Author Prof1983 <prof1983@ya.ru>
@Created 20.01.2010
@LastMod 17.12.2012
}
unit AUiForm;

interface

uses
  Forms, ABase, ASettingsMain;

function Form_LoadConfig(Form: TForm; Config: AConfig): AError;
function Form_LoadConfig2(Form: TForm; Config: AConfig; const ConfigKey: APascalString): AError;
function Form_LoadConfig3(Form: TForm; Config: AConfig; const ConfigKey: APascalString; DefWindowState: TWindowState): AError;
function Form_LoadConfig4(Form: TForm; Config: AConfig; const ConfigKey: APascalString; DefWindowState: AInteger): AError;
function Form_SaveConfig(Form: TForm; Config: AConfig): AError;
function Form_SaveConfig2(Form: TForm; Config: AConfig; const ConfigKey: APascalString): AError;

implementation

const
  SCaption = 'Caption';
  SLeft = 'Left';
  STop = 'Top';
  SWidth = 'Width';
  SHeight = 'Height';
  SVisible = 'Visible';
  SWindowState = 'WindowState';

const
  INT_WINDOW_STATE: array[TWindowState] of Integer = (0, 1, 2);

// --- Private ---

function _IntToWindowState(Value: AInteger): TWindowState;
var
  WindowState: TWindowState;
begin
  for WindowState := Low(WindowState) to High(WindowState) do
  begin
    if (INT_WINDOW_STATE[WindowState] = Value) then
    begin
      Result := WindowState;
      Exit;
    end;
  end;
  Result := wsNormal;
end;

// --- Form ---

function Form_LoadConfig(Form: TForm; Config: AConfig): AError;
begin
  Result := Form_LoadConfig2(Form, Config, Form.Name);
end;

function Form_LoadConfig2(Form: TForm; Config: AConfig; const ConfigKey: APascalString): AError;
begin
  Result := Form_LoadConfig3(Form, Config, ConfigKey, Form.WindowState);
end;

function Form_LoadConfig3(Form: TForm; Config: AConfig; const ConfigKey: APascalString; DefWindowState: TWindowState): AError;
begin
  Result := Form_LoadConfig4(Form, Config, ConfigKey, INT_WINDOW_STATE[DefWindowState]);
end;

function Form_LoadConfig4(Form: TForm; Config: AConfig; const ConfigKey: APascalString; DefWindowState: AInteger): AError;
{var
  I: Integer;
  S: APascalString;
  tmpWindowState: TWindowState;}
begin
  if (Config = 0) then
  begin
    Result := -2;
    Exit;
  end;

  try
    {
    tmpWindowState := IntToWindowState(AConfig_ReadInt32Def(Config, SWindowState, DefWindowState));
    Form.WindowState := wsNormal;

    if (AConfig_ReadInt32(Config, SLeft, I) >= 0) then
      Form.Left := I;
    if (AConfig_ReadInt32(Config, STop, I) >= 0) then
      Form.Top := I;
    if (AConfig_ReadInt32(Config, SWidth, I) >= 0) then
      Form.Width := I;
    if (AConfig_ReadInt32(Config, SHeight, I) >= 0) then
      Form.Height := I;

    if (Form.WindowState <> tmpWindowState) then
      Form.WindowState := tmpWindowState;

    if (AConfig_ReadString(Config, SCaption, S) >= 0) then
      Form.Caption := S;
    }

    Form.WindowState := wsNormal;
    Form.Left := ASettings_ReadIntegerDefP(Config, ConfigKey, SLeft, Form.Left);
    Form.Top := ASettings_ReadIntegerDefP(Config, ConfigKey, STop, Form.Top);
    Form.Width := ASettings_ReadIntegerDefP(Config, ConfigKey, SWidth, Form.Width);
    Form.Height := ASettings_ReadIntegerDefP(Config, ConfigKey, SHeight, Form.Height);
    Form.WindowState := _IntToWindowState(ASettings_ReadIntegerDefP(Config, ConfigKey, SWindowState, DefWindowState));
    Form.Caption := ASettings_ReadStringDefP(Config, ConfigKey, SCaption, Form.Caption);
    Result := 0;
  except
    Result := -2;
  end;
end;

function Form_SaveConfig(Form: TForm; Config: AConfig): AError;
begin
  Result := Form_SaveConfig2(Form, Config, Form.Name);
end;

function Form_SaveConfig2(Form: TForm; Config: AConfig; const ConfigKey: APascalString): AError;
begin
  if (Config = 0) then
  begin
    Result := -2;
    Exit;
  end;

  try
    {
    if (Form.WindowState <> wsMaximized) then
    begin
      AConfig_WriteInt32(Config, SLeft, Form.Left);
      AConfig_WriteInt32(Config, STop, Form.Top);
      AConfig_WriteInt32(Config, SWidth, Form.Width);
      AConfig_WriteInt32(Config, SHeight, Form.Height);
    end;
    AConfig_WriteInt32(Config, SWindowState, Integer(Form.WindowState));
    AConfig_WriteString(Config, SCaption, Form.Caption);
    AConfig_WriteBool(Config, SVisible, Form.Visible);
    }

    if (Form.WindowState <> wsMaximized) then
    begin
      ASettings_WriteIntegerP(Config, ConfigKey, SLeft, Form.Left);
      ASettings_WriteIntegerP(Config, ConfigKey, STop, Form.Top);
      ASettings_WriteIntegerP(Config, ConfigKey, SWidth, Form.Width);
      ASettings_WriteIntegerP(Config, ConfigKey, SHeight, Form.Height);
    end;
    ASettings_WriteIntegerP(Config, ConfigKey, SWindowState, Integer(Form.WindowState));
    ASettings_WriteStringP(Config, ConfigKey, SCaption, Form.Caption);
    ASettings_WriteBoolP(Config, ConfigKey, SVisible, Form.Visible);
    Result := 0;
  except
    Result := -1;
  end;
end;

end.
 
