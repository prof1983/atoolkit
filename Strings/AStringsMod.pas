{**
@Abstract AStringsModule
@Author Prof1983 <prof1983@ya.ru>
@Created 03.06.2011
@LastMod 04.04.2013
}
unit AStringsMod;

interface

uses
  ABase,
  ARuntimeBase,
  ARuntimeMain,
  AStringLists,
  AStringMain,
  AStringUtils,
  AStringsBase,
  AStringsMain;

// --- AStringsMod ---

function AStringsMod_Boot(): AError; stdcall;

function AStringsMod_Fin(): AError; stdcall;

function AStringsMod_GetProc(ProcName: AStr): Pointer; stdcall;

function AStringsMod_Init(): AError; stdcall;

implementation

const
  AStrings_Version = $00070500;

const
  Module: AModule_Type = (
    Version: AStrings_Version;
    Uid: AStrings_Uid;
    Name: AStrings_Name;
    Description: nil;
    Init: AStringsMod_Init;
    Fin: AStringsMod_Fin;
    GetProc: AStringsMod_GetProc;
    Procs: nil;
    );

// --- AStringsMod ---

function AStringsMod_Boot(): AError;
begin
  Result := ARuntime_RegisterModule(Module);
end;

function AStringsMod_Fin(): AError;
begin
  Result := 0;
end;

function AStringsMod_GetProc(ProcName: AStr): Pointer;
begin
  if (ProcName = 'AStringList_Add') then
    Result := Addr(AStringList_Add)
  else if (ProcName = 'AStringList_AddA') then
    Result := Addr(AStringList_AddA)
  else if (ProcName = 'AStringList_Clear') then
    Result := Addr(AStringList_Clear)
  else if (ProcName = 'AStringList_Delete') then
    Result := Addr(AStringList_Delete)
  else if (ProcName = 'AStringList_GetCount') then
    Result := Addr(AStringList_GetCount)
  else if (ProcName = 'AStringList_GetTextLength') then
    Result := Addr(AStringList_GetTextLength)
  else if (ProcName = 'AStringList_Free') then
    Result := Addr(AStringList_Free)
  else if (ProcName = 'AStringList_Insert') then
    Result := Addr(AStringList_Insert)
  else if (ProcName = 'AStringList_New') then
    Result := Addr(AStringList_New)

  else if (ProcName = 'AStrings_Fin') then
    Result := Addr(AStrings_Fin)
  else if (ProcName = 'AStrings_Init') then
    Result := Addr(AStrings_Init)

  else if (ProcName = 'AString_Assign') then
    Result := Addr(AString_Assign)
  else if (ProcName = 'AString_AssignA') then
    Result := Addr(AString_AssignA)
  else if (ProcName = 'AString_Clear') then
    Result := Addr(AString_Clear)
  else if (ProcName = 'AString_Copy') then
    Result := Addr(AString_Copy)
  else if (ProcName = 'AString_CopyA') then
    Result := Addr(AString_CopyA)
  else if (ProcName = 'AString_GetChar') then
    Result := Addr(AString_GetChar)
  else if (ProcName = 'AString_GetLength') then
    Result := Addr(AString_GetLength)
  else if (ProcName = 'AString_Set') then
    Result := Addr(AString_Set)
  else if (ProcName = 'AString_SetA') then
    Result := Addr(AString_SetA)
  else if (ProcName = 'AString_ToLower') then
    Result := Addr(AString_ToLower)
  else if (ProcName = 'AString_ToUpper') then
    Result := Addr(AString_ToUpper)

  else
    Result := nil
end;

function AStringsMod_Init(): AError;
begin
  Result := 0;
end;

end.
