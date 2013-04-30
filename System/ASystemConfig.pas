{**
@Abstract ASystem config
@Author Prof1983 <prof1983@ya.ru>
@Created 29.05.2011
}
unit ASystemConfig;

{$I Defines.inc}

{$IFNDEF NoRuntimeConfig}
  {$DEFINE USE_CONFIG}
{$ENDIF NoRuntimeConfig}

interface

uses
  ABase,
  ASystemData,
  ASystemUtils,
  AUtilsMain;

function System_InitConfig: AInteger;
function System_DoneConfig: AInteger;

implementation

{$IFDEF USE_CONFIG}
uses
  ASettings;
{$ENDIF}

{$IFDEF USE_CONFIG}
function System_DoneConfig: AInteger;
begin
  if (FConfig <> 0) then
    ASettings.Config_Close(FConfig);
  Result := 0;
end;
{$ENDIF USE_CONFIG}

{$IFDEF USE_CONFIG}
function System_InitConfig: AInteger;
var
  S: APascalString;
begin
  if Utils_FileExists(FExePath+FProgramName+'.ini') then
    S := FExePath+FProgramName+'.ini'
  else
    S := FConfigPath+FProgramName+'.ini';
  FConfig := ASettings.IniConfig_NewP(S);

  S := ASettings.Config_ReadStringDefP(FConfig, 'App', 'DataPath', '');
  if (S <> '') then
    FDataPath := NormalizePath(S);
  Result := 0;
end;
{$ENDIF USE_CONFIG}

end.
 