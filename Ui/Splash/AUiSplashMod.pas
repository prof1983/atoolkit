{**
@Abstract AUiSplash
@Author Prof1983 <prof1983@ya.ru>
@Created 08.12.2009
@LastMod 17.04.2013
}
unit AUiSplashMod;

interface

uses
  ABase,
  ARuntimeBase,
  ARuntimeMain,
  ASettingsBase,
  AUiBase,
  AUiSplashBase,
  AUiSplashMain,
  AUtilsBase;

// --- AUiSplashMod ---

function AUiSplashMod_Boot(): AError; stdcall;

function AUiSplashMod_Fin(): AError; stdcall;

function AUiSplashMod_GetProc(ProcName: AStr): Pointer; stdcall;

function AUiSplashMod_Init(): AError; stdcall;

implementation

const
  AUiSplash_Version = $00060100;

const
  UiSplashModule: AModule_Type = (
    Version: AUiSplash_Version;
    Uid: AUiSplash_Uid;
    Name: AUiSplash_Name;
    Description: nil;
    Init: AUiSplashMod_Init;
    Fin: AUiSplashMod_Fin;
    GetProc: AUiSplashMod_GetProc;
    Procs: nil;
    );

// --- AUiSplashMod ---

function AUiSplashMod_Boot(): AError;
begin
  Result := ARuntime_AddModule(UiSplashModule);
end;

function AUiSplashMod_Fin(): AError;
begin
  Result := AUiSplash_Fin();
  ARuntime_DeleteModuleByUid(AUiSplash_Uid);
end;

function AUiSplashMod_GetProc(ProcName: AStr): Pointer;
begin
  if (ProcName = 'AUiSplash_Fin') then
    Result := Addr(AUiSplash_Fin)
  else if (ProcName = 'AUiSplash_Hide') then
    Result := Addr(AUiSplash_Hide)
  else if (ProcName = 'AUiSplash_Init') then
    Result := Addr(AUiSplash_Init)
  else if (ProcName = 'AUiSplash_Sleep') then
    Result := Addr(AUiSplash_Sleep)
  else if (ProcName = 'AUiSplash_StepIt') then
    Result := Addr(AUiSplash_StepIt)
  else
    Result := nil;
end;

function AUiSplashMod_Init(): AError;
begin
  // --- Init request modules ---

  if (ARuntime_InitModuleByUid(AUi_Uid) < 0) then
  begin
    Result := -6;
    Exit;
  end;

  if (ARuntime_InitModuleByUid(AUtils_Uid) < 0) then
  begin
    Result := -7;
    Exit;
  end;

  // --- Init recomended modules ---

  ARuntime_InitModuleByUid(ASettings_Uid);

  // --- Run ---

  Result := AUiSplash_Init();
end;

end.

