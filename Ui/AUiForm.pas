{**
@Abstract AUi form config functions
@Author Prof1983 <prof1983@ya.ru>
@Created 20.01.2010
@LastMod 10.08.2012
}
unit AUiForm;

interface

uses
  Forms, ABase; {ASettings;}

function Form_LoadConfig(Form: TForm; Config: AConfig): ABoolean;
function Form_LoadConfig2(Form: TForm; Config: AConfig; const ConfigKey: APascalString): ABoolean;
function Form_LoadConfig3(Form: TForm; Config: AConfig; const ConfigKey: APascalString; DefWindowState: TWindowState): ABoolean;
function Form_LoadConfig4(Form: TForm; Config: AConfig; const ConfigKey: APascalString; DefWindowState: AInteger): ABoolean;
function Form_SaveConfig(Form: TForm; Config: AConfig): ABoolean;
function Form_SaveConfig2(Form: TForm; Config: AConfig; const ConfigKey: APascalString): ABoolean;

implementation

const
  SLeft = 'Left';
  STop = 'Top';
  SWidth = 'Width';
  SHeight = 'Height';
  SWindowState = 'WindowState';

const
  INT_WINDOW_STATE: array[TWindowState] of Integer = (0, 1, 2);

function Form_LoadConfig(Form: TForm; Config: AConfig): ABoolean;
begin
  Result := Form_LoadConfig2(Form, Config, Form.Name);
end;

function Form_LoadConfig2(Form: TForm; Config: AConfig; const ConfigKey: APascalString): ABoolean;
begin
  Result := Form_LoadConfig3(Form, Config, ConfigKey, Form.WindowState);
end;

function Form_LoadConfig3(Form: TForm; Config: AConfig; const ConfigKey: APascalString; DefWindowState: TWindowState): ABoolean;
begin
  Result := Form_LoadConfig4(Form, Config, ConfigKey, INT_WINDOW_STATE[DefWindowState]);
end;

function Form_LoadConfig4(Form: TForm; Config: AConfig; const ConfigKey: APascalString; DefWindowState: AInteger): ABoolean;

  function IntToWindowState(Value: AInteger): TWindowState;
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

begin
  try
    Form.WindowState := wsNormal;
    Form.Left := ASettings.Config_ReadIntegerDefP(Config, ConfigKey, SLeft, Form.Left);
    Form.Top := ASettings.Config_ReadIntegerDefP(Config, ConfigKey, STop, Form.Top);
    Form.Width := ASettings.Config_ReadIntegerDefP(Config, ConfigKey, SWidth, Form.Width);
    Form.Height := ASettings.Config_ReadIntegerDefP(Config, ConfigKey, SHeight, Form.Height);
    //Form.WindowState := TWindowState(ASettings.Config_ReadIntegerDefP(Config, ConfigKey, SWindowState, Integer(DefWindowState)));
    Form.WindowState := IntToWindowState(ASettings.Config_ReadIntegerDefP(Config, ConfigKey, SWindowState, DefWindowState));
    Result := True;
  except
    Result := False;
  end;
end;

function Form_SaveConfig(Form: TForm; Config: AConfig): ABoolean;
begin
  Result := Form_SaveConfig2(Form, Config, Form.Name);
end;

function Form_SaveConfig2(Form: TForm; Config: AConfig; const ConfigKey: APascalString): ABoolean;
begin
  try
    if (Config <> 0) and (Form.WindowState <> wsMaximized) then
    begin
      ASettings.Config_WriteIntegerP(Config, ConfigKey, SLeft, Form.Left);
      ASettings.Config_WriteIntegerP(Config, ConfigKey, STop, Form.Top);
      ASettings.Config_WriteIntegerP(Config, ConfigKey, SWidth, Form.Width);
      ASettings.Config_WriteIntegerP(Config, ConfigKey, SHeight, Form.Height);
    end;
    ASettings.Config_WriteIntegerP(Config, ConfigKey, SWindowState, Integer(Form.WindowState));
    Result := True;
  except
    Result := False;
  end;
end;

end.
 
