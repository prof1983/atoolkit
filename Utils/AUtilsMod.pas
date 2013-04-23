{**
@Author Prof1983 <prof1983@ya.ru>
@Created 30.09.2009
@LastMod 23.04.2013
}
unit AUtilsMod;

interface

uses
  ABase,
  ABaseUtils,
  ARuntimeBase,
  ARuntimeMain,
  AStringUtils,
  AUtilsBase,
  AUtilsMain;

// --- AUtilsMod ---

function AUtilsMod_Boot(): AError; stdcall;

function AUtilsMod_Fin(): AError; stdcall;

function AUtilsMod_GetProc(ProcName: AStr): Pointer; stdcall;

function AUtilsMod_Init(): AError; stdcall;

function AUtilsMod_Register(): AError; stdcall;

implementation

const
  AUtils_Version = $00060200;

const
  Module: AModule_Type = (
    Version: AUtils_Version;
    Uid: AUtils_Uid;
    Name: AUtils_Name;
    Description: nil;
    Init: AUtilsMod_Init;
    Fin: AUtilsMod_Fin;
    GetProc: AUtilsMod_GetProc;
    Procs: nil;
    );

// --- AUtilsMod ---

function AUtilsMod_Boot(): AError;
begin
  Result := AUtilsMod_Register();
end;

function AUtilsMod_Fin(): AError;
begin
  Result := AUtils_Fin();
end;

function AUtilsMod_GetProc(ProcName: AStr): Pointer;
begin
  if (ProcName = 'AUtils_ChangeFileExt') then
    Result := Addr(AUtils_ChangeFileExt)
  else if (ProcName = 'AUtils_DateToStr') then
    Result := Addr(AUtils_DateToStr)
  else if (ProcName = 'AUtils_DeleteFile') then
    Result := Addr(AUtils_DeleteFile)
  else if (ProcName = 'AUtils_DirectoryExists') then
    Result := Addr(AUtils_DirectoryExists)
  else if (ProcName = 'AUtils_ExpandFileName') then
    Result := Addr(AUtils_ExpandFileName)
  else if (ProcName = 'AUtils_ExtractFileExt') then
    Result := Addr(AUtils_ExtractFileExt)
  else if (ProcName = 'AUtils_ExtractFileName') then
    Result := Addr(AUtils_ExtractFileName)
  else if (ProcName = 'AUtils_ExtractFilePath') then
    Result := Addr(AUtils_ExtractFilePath)
  else if (ProcName = 'AUtils_FileExists') then
    Result := Addr(AUtils_FileExists)
  else if (ProcName = 'AUtils_Fin') then
    Result := Addr(AUtils_Fin)
  else if (ProcName = 'AUtils_FloatToStr') then
    Result := Addr(AUtils_FloatToStr)
  else if (ProcName = 'AUtils_FloatToStr2') then
    Result := Addr(AUtils_FloatToStr2)
  else if (ProcName = 'AUtils_ForceDirectories') then
    Result := Addr(AUtils_ForceDirectories)
  else if (ProcName = 'AUtils_ForceDirectoriesA') then
    Result := Addr(AUtils_ForceDirectoriesA)
  else if (ProcName = 'AUtils_FormatFloat') then
    Result := Addr(AUtils_FormatFloat)
  else if (ProcName = 'AUtils_FormatInt') then
    Result := Addr(AUtils_FormatInt)
  else if (ProcName = 'AUtils_FormatStr') then
    Result := Addr(AUtils_FormatStr)
  else if (ProcName = 'AUtils_FormatStrAnsi') then
    Result := Addr(AUtils_FormatStrAnsi)
  else if (ProcName = 'AUtils_FormatStrStr') then
    Result := Addr(AUtils_FormatStrStr)
  else if (ProcName = 'AUtils_FormatStrStrA') then
    Result := Addr(AUtils_FormatStrStrA)
  else if (ProcName = 'AUtils_GetNowDateTime') then
    Result := Addr(AUtils_GetNowDateTime)
  else if (ProcName = 'AUtils_Init') then
    Result := Addr(AUtils_Init)
  else if (ProcName = 'AUtils_IntToStr') then
    Result := Addr(AUtils_IntToStr)
  else if (ProcName = 'AUtils_NormalizeFloat') then
    Result := Addr(AUtils_NormalizeFloat)
  else if (ProcName = 'AUtils_NormalizeStr') then
    Result := Addr(AUtils_NormalizeStr)
  else if (ProcName = 'AUtils_NormalizeStrSpace') then
    Result := Addr(AUtils_NormalizeStrSpace)
  else if (ProcName = 'AUtils_Power') then
    Result := Addr(AUtils_Power)
  else if (ProcName = 'AUtils_ReplaceComma') then
    Result := Addr(AUtils_ReplaceComma)
  else if (ProcName = 'AUtils_Round2') then
    Result := Addr(AUtils_Round2)
  else if (ProcName = 'AUtils_Sleep') then
    Result := Addr(AUtils_Sleep)
  else if (ProcName = 'AUtils_StrToDate') then
    Result := Addr(AUtils_StrToDate)
  else if (ProcName = 'AUtils_StrToFloat') then
    Result := Addr(AUtils_StrToFloat)
  else if (ProcName = 'AUtils_StrToFloatDef') then
    Result := Addr(AUtils_StrToFloatDef)
  else if (ProcName = 'AUtils_StrToInt') then
    Result := Addr(AUtils_StrToInt)
  else if (ProcName = 'AUtils_StrToIntDef') then
    Result := Addr(AUtils_StrToIntDef)
  else if (ProcName = 'AUtils_Trim') then
    Result := Addr(AUtils_Trim)
  else if (ProcName = 'AUtils_TryStrToDate') then
    Result := Addr(AUtils_TryStrToDate)
  else if (ProcName = 'AUtils_TryStrToFloat32') then
    Result := Addr(AUtils_TryStrToFloat32)
  else if (ProcName = 'AUtils_TryStrToFloat64') then
    Result := Addr(AUtils_TryStrToFloat64)
  else if (ProcName = 'AUtils_TryStrToInt') then
    Result := Addr(AUtils_TryStrToInt)
  else if (ProcName = 'AString_ToLower') then
    Result := Addr(AString_ToLower)
  else if (ProcName = 'AString_ToUpper') then
    Result := Addr(AString_ToUpper)
  else
    Result := nil;
end;

function AUtilsMod_Init(): AError;
begin
  Result := AUtils_Init();
end;

function AUtilsMod_Register(): AError;
begin
  Result := ARuntime_RegisterModule(Module);
end;

end.

