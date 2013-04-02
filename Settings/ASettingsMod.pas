{**
@Author Prof1983 <prof1983@ya.ru>
@Created 06.03.2008
@LastMod 02.04.2013
}
unit ASettingsMod;

interface

uses
  ABase,
  ARuntimeMain,
  ARuntimeBase,
  ASettingsBase,
  ASettingsIni,
  ASettingsMain,
  ASettingsReg;

// --- ASettingsMod ---

function ASettingsMod_Boot(): AError; stdcall;

function ASettingsMod_Fin(): AError; stdcall;

function ASettingsMod_GetProc(ProcName: AStr): Pointer; stdcall;

function ASettingsMod_Init(): AError; stdcall;

implementation

const
  ASettings_Version = $00070500;

const
  Module: AModule_Type = (
    Version: ASettings_Version;
    Uid: ASettings_Uid;
    Name: ASettings_Name;
    Description: nil;
    Init: ASettingsMod_Init;
    Fin: ASettingsMod_Fin;
    GetProc: ASettingsMod_GetProc;
    Procs: nil;
    );

var
  FInitialized: Boolean;

// --- ASettingsMod ---

function ASettingsMod_Boot(): AError;
begin
  Result := ARuntime_RegisterModule(Module);
end;

function ASettingsMod_Fin(): AError;
begin
  Result := 0;
end;

function ASettingsMod_GetProc(ProcName: AStr): Pointer;
begin
  if (ProcName = 'ASettings_Close') then
    Result := Addr(ASettings_Close)
  else if (ProcName = 'ASettings_DeleteKey') then
    Result := Addr(ASettings_DeleteKey)
  else if (ProcName = 'ASettings_DeleteKeyA') then
    Result := Addr(ASettings_DeleteKeyA)
  else if (ProcName = 'ASettings_DeleteSection') then
    Result := Addr(ASettings_DeleteSection)
  else if (ProcName = 'ASettings_DeleteSectionA') then
    Result := Addr(ASettings_DeleteSectionA)
  else if (ProcName = 'ASettings_Fin') then
    Result := Addr(ASettings_Fin)
  else if (ProcName = 'ASettings_Init') then
    Result := Addr(ASettings_Init)
  {$ifdef ASettings_Old}
  else if (ProcName = 'ASettings_NewIniConfig') then
    Result := Addr(ASettings_NewIniConfig)
  else if (ProcName = 'ASettings_NewIniConfigA') then
    Result := Addr(ASettings_NewIniConfigA)
  else if (ProcName = 'ASettings_NewRegConfig') then
    Result := Addr(ASettings_NewRegConfig)
  else if (ProcName = 'ASettings_NewRegConfigA') then
    Result := Addr(ASettings_NewRegConfigA)
  {$endif}
  else if (ProcName = 'ASettings_NewIniSettings') then
    Result := Addr(ASettings_NewIniSettings)
  else if (ProcName = 'ASettings_NewIniSettingsA') then
    Result := Addr(ASettings_NewIniSettingsA)
  else if (ProcName = 'ASettings_NewRegSettings') then
    Result := Addr(ASettings_NewRegSettings)
  else if (ProcName = 'ASettings_NewRegSettingsA') then
    Result := Addr(ASettings_NewRegSettingsA)
  else if (ProcName = 'ASettings_ReadBoolDef') then
    Result := Addr(ASettings_ReadBoolDef)
  else if (ProcName = 'ASettings_ReadBoolDefA') then
    Result := Addr(ASettings_ReadBoolDefA)
  else if (ProcName = 'ASettings_ReadDateTimeDef') then
    Result := Addr(ASettings_ReadDateTimeDef)
  else if (ProcName = 'ASettings_ReadDateTimeDefA') then
    Result := Addr(ASettings_ReadDateTimeDefA)
  else if (ProcName = 'ASettings_ReadFloatDef') then
    Result := Addr(ASettings_ReadFloatDef)
  else if (ProcName = 'ASettings_ReadFloatDefA') then
    Result := Addr(ASettings_ReadFloatDefA)
  else if (ProcName = 'ASettings_ReadIntDef') then
    Result := Addr(ASettings_ReadIntDef)
  else if (ProcName = 'ASettings_ReadIntDefA') then
    Result := Addr(ASettings_ReadIntDefA)
  else if (ProcName = 'ASettings_ReadSection') then
    Result := Addr(ASettings_ReadSection)
  else if (ProcName = 'ASettings_ReadSectionA') then
    Result := Addr(ASettings_ReadSectionA)
  else if (ProcName = 'ASettings_ReadString') then
    Result := Addr(ASettings_ReadString)
  else if (ProcName = 'ASettings_ReadStringA') then
    Result := Addr(ASettings_ReadStringA)
  else if (ProcName = 'ASettings_ReadStringDef') then
    Result := Addr(ASettings_ReadStringDef)
  else if (ProcName = 'ASettings_ReadStringDefA') then
    Result := Addr(ASettings_ReadStringDefA)
  else if (ProcName = 'ASettings_WriteBool') then
    Result := Addr(ASettings_WriteBool)
  else if (ProcName = 'ASettings_WriteBoolA') then
    Result := Addr(ASettings_WriteBoolA)
  else if (ProcName = 'ASettings_WriteDateTime') then
    Result := Addr(ASettings_WriteDateTime)
  else if (ProcName = 'ASettings_WriteDateTimeA') then
    Result := Addr(ASettings_WriteDateTimeA)
  else if (ProcName = 'ASettings_WriteFloat') then
    Result := Addr(ASettings_WriteFloat)
  else if (ProcName = 'ASettings_WriteFloatA') then
    Result := Addr(ASettings_WriteFloatA)
  else if (ProcName = 'ASettings_WriteInt') then
    Result := Addr(ASettings_WriteInt)
  else if (ProcName = 'ASettings_WriteIntA') then
    Result := Addr(ASettings_WriteIntA)
  else if (ProcName = 'ASettings_WriteString') then
    Result := Addr(ASettings_WriteString)
  else if (ProcName = 'ASettings_WriteStringA') then
    Result := Addr(ASettings_WriteStringA)
  else
    Result := nil;
end;

function ASettingsMod_Init(): AError;
begin
  if FInitialized then
  begin
    Result := 0;
    Exit;
  end;

  FInitialized := True;
  Result := 0;
end;

end.
