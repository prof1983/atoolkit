{**
@Abstract ACollections
@Author Prof1983 <prof1983@ya.ru>
@Created 31.05.2011
@LastMod 17.04.2013

Prototype:
CS: System.Collection.ICollection
CS: System.Collection.IList
CS: System.Collection.IEnumerable
CS: System.Collection.IEnumerator
CS: System.Collection.IComparer

CS: ArrayList
CS: Hashtable
CS: Queue
CS: SortedList
CS: Stack
}
unit ACollectionsMod;

interface

uses
  ABase,
  ACollections,
  ACollectionsBase,
  ARuntimeBase,
  ARuntimeMain,
  AStringLists;

// --- ACollectionsMod ---

function ACollectionsMod_Boot(): AError; stdcall;

function ACollectionsMod_Fin(): AError; stdcall;

function ACollectionMod_GetProc(ProcName: AStr): Pointer; stdcall;

function ACollectionsMod_Init(): AError; stdcall;

implementation

const
  ACollections_Version = $00060100;

const
  CollectionsModule: AModule_Type = (
    Version: ACollections_Version;      // Module version ($AABBCCDD). AA=00h, BB=03h.
    Uid: ACollections_Uid;              // Module unique identificator $YYMMDDxx YY - Year, MM - Month, DD - Day
    Name: ACollections_Name;            // Module unuque name
    Description: nil;                   // Module information and description
    Init: ACollectionsMod_Init;         // Initialize proc
    Fin: ACollectionsMod_Fin;           // Finalize proc
    GetProc: ACollectionMod_GetProc;    // Get proc address
    Procs: nil;
    );

// --- ACollectionsMod ---

function ACollectionsMod_Boot(): AError;
begin
  Result := ARuntime_RegisterModule(CollectionsModule);
end;

function ACollectionsMod_Fin(): AError;
begin
  Result := ACollections.Fin();
end;

function ACollectionMod_GetProc(ProcName: AStr): Pointer;
begin
  if (ProcName = 'ACollections_Fin') then
    Result := Addr(ACollections.Fin)
  else if (ProcName = 'ACollections_Init') then
    Result := Addr(ACollections.Init)
  else if (ProcName = 'AStringList_Add') then
    Result := Addr(AStringList_Add)
  else if (ProcName = 'AStringList_AddA') then
    Result := Addr(AStringList_AddA)
  else if (ProcName = 'AStringList_Clear') then
    Result := Addr(AStringList_Clear)
  else if (ProcName = 'AStringList_Delete') then
    Result := Addr(AStringList_Delete)
  else if (ProcName = 'AStringList_GetCount') then
    Result := Addr(AStringList_GetCount)
  else if (ProcName = 'AStringList_Free') then
    Result := Addr(AStringList_Free)
  else if (ProcName = 'AStringList_Insert') then
    Result := Addr(AStringList_Insert)
  else if (ProcName = 'AStringList_New') then
    Result := Addr(AStringList_New)
  else
    Result := nil;
end;

function ACollectionsMod_Init(): AError;
begin
  if (ARuntime_FindModuleByUid(ACollections_Uid) > 0) then
  begin
    Result := -2;
    Exit;
  end;

  if (ARuntime_FindModuleByName(ACollections_Name) > 0) then
  begin
    Result := -3;
    Exit;
  end;

  Result := ACollections.Init();
end;

end.
 