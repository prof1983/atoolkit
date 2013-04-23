{**
@Abstract AUiSettings
@Author Prof1983 <prof1983@ya.ru>
@Created 13.03.2009
@LastMod 23.04.2013
}
unit AUiSettingsMod;

interface

uses
  ABase,
  ARuntimeBase,
  ARuntimeMain,
  AUiBoot,
  AUiSettingsBase,
  AUiSettingsMain,
  AStringsBoot;

// --- AUiSettingsMod ---

function AUiSettingsMod_Boot(): AError; stdcall;

function AUiSettingsMod_Fin(): AError; stdcall;

function AUiSettingsMod_GetProc(ProcName: AStr): Pointer; stdcall;

function AUiSettingsMod_Init(): AError; stdcall;

implementation

{$IFDEF FPC}
  {$I AUiSettingsConsts.en.inc}
{$ELSE}
  {$I AUiSettingsConsts.ru.inc}
{$ENDIF}

const
  AUiSettings_Version = $00060200;

const
  Module: AModule_Type = (
    Version: AUiSettings_Version;
    Uid: AUiSettings_Uid;
    Name: AUiSettings_Name;
    Description: nil;
    Init: AUiSettingsMod_Init;
    Fin: AUiSettingsMod_Fin;
    GetProc: AUiSettingsMod_GetProc;
    Procs: nil;
    );

// --- AUiSettingsMod ---

function AUiSettingsMod_Boot(): AError;
begin
  // Check dublicate module
  if (ARuntime_FindModuleByName(AUiSettings_Name) >= 0) then
  begin
    Result := -10;
    Exit;
  end;

  ARuntime_AddModule(Module);
  Result := 0;
end;

// --- AUiSettings_Mod ---

function AUiSettingsMod_Fin(): AError;
begin
  Result := AUiSettings_Fin();
  ARuntime_DeleteModuleByUid(AUiSettings_Uid);
end;

function AUiSettingsMod_GetProc(ProcName: AStr): Pointer;
begin
  if (ProcName = 'AUiSettings_Fin') then
    Result := Addr(AUiSettings_Fin)
  else if (ProcName = 'AUiSettings_GetMainSettingsWin') then
    Result := Addr(AUiSettings_GetMainSettingsWin)
  else if (ProcName = 'AUiSettings_Init') then
    Result := Addr(AUiSettings_Init)
  else if (ProcName = 'AUiSettings_NewItem') then
    Result := Addr(AUiSettings_NewItem)
  else if (ProcName = 'AUiSettings_NewSettingsWin') then
    Result := Addr(AUiSettings_NewSettingsWin)
  else if (ProcName = 'AUiSettings_ShowSettingsWin') then
    Result := Addr(AUiSettings_ShowSettingsWin)
  else if (ProcName = 'AUiSettingsItem_GetPage') then
    Result := Addr(AUiSettingsItem_GetPage)
  else
    Result := nil;
end;

function AUiSettingsMod_Init(): AError;
begin
  if (AUi_Boot() < 0) then
  begin
    Result := -2;
    Exit;
  end;
  if (AStrings_Boot() < 0) then
  begin
    Result := -3;
    Exit;
  end;
  Result := AUiSettings_Init();
end;

end.
