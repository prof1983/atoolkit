{**
@Abstract ASystem config
@Author Prof1983 <prof1983@ya.ru>
@Created 29.05.2011
@LastMod 16.11.2012
}
unit ASystemConfig;

{$I Defines.inc}

{$IFNDEF NoRuntimeConfig}
  {$DEFINE USE_CONFIG}
{$ENDIF NoRuntimeConfig}

interface

uses
  ABase, ASystemData, ASystemUtils;

function System_InitConfig: AInteger;
function System_DoneConfig: AInteger;

implementation

{$IFDEF USE_CONFIG}
uses
  ASettingsIni, ASettingsMain;
{$ENDIF}

{$IFDEF USE_CONFIG}
function System_DoneConfig: AInteger;
begin
  if (FConfig <> 0) then
    ASettings_Close(FConfig);
  Result := 0;
end;
{$ENDIF USE_CONFIG}

{$IFDEF USE_CONFIG}
function System_InitConfig: AInteger;
var
  S: APascalString;
begin
  FConfig := ASettings_IniConfig_NewP(FConfigPath+FProgramName+'.ini');

  S := ASettings_ReadStringDefP(FConfig, 'App', 'DataPath', '');
  if (S <> '') then
    FDataPath := NormalizePath(S);
  Result := 0;
end;
{$ENDIF USE_CONFIG}

end.
 