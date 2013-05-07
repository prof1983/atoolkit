{**
@Author Prof1983 <prof1983@ya.ru>
@Created 31.05.2011
}
unit ACollectionsMod;

interface

uses
  ABase,
  ACollections,
  ACollectionsBase,
  ACollectionsProcs,
  ARuntime,
  ARuntimeBase;

// --- Collections Module ---

function Collections_Boot(): AInt; stdcall;

procedure Collections_Done02(); stdcall;

function Collections_Done03(): AInt; stdcall;

function Collections_Done04(): AError; stdcall;

function Collections_Init02(): AInt; stdcall;

function Collections_Init03(): AInt; stdcall;

function Collections_Init04(): AError; stdcall;

const
  CollectionsProcs: ACollectionsProcs_Type = (
    StringList_Add: ACollections.StringList_Add;                // 00
    StringList_AddP: ACollections.StringList_AddP;              // 01
    StringList_Clear: ACollections.StringList_Clear;            // 02
    StringList_Count: ACollections.StringList_Count;            // 03
    StringList_Delete: ACollections.StringList_Delete;          // 04
    StringList_Insert: ACollections.StringList_Insert;          // 05
    StringList_InsertP: ACollections.StringList_InsertP;        // 06
    StringList_New: ACollections.StringList_New;                // 07
    StringList_RemoveAt: ACollections.StringList_RemoveAt;      // 08
    Init: Collections_Init04;                                   // 09
    Done: Collections_Done04;                                   // 10
    StringList_AddA: ACollections.StringList_AddA;              // 11
    Reserved12: 0;
    Reserved13: 0;
    Reserved14: 0;
    Reserved15: 0;
    Reserved16: 0;
    Reserved17: 0;
    Reserved18: 0;
    Reserved19: 0;
    Reserved20: 0;
    Reserved21: 0;
    Reserved22: 0;
    Reserved23: 0;
    Reserved24: 0;
    Reserved25: 0;
    Reserved26: 0;
    Reserved27: 0;
    Reserved28: 0;
    Reserved29: 0;
    Reserved30: 0;
    Reserved31: 0;
    );

implementation

uses
  ACollections0;

const
  {$ifdef A02}
  ACollections_Version = $00020800;
  {$else}
  ACollections_Version = $00040100;
  {$endif}

const
  {$ifdef A02}
  CollectionsModule: AModule02_Type = (
    Version: ACollections_Version;
    Init: Collections_Init02;
    Done: Collections_Done02;
    Name: ACollections_Name02;
    Procs: Addr(CollectionsProcs);
    Reserved1: 0;
    Reserved2: 0;
    Reserved3: 0;
    );
  {$else}
  CollectionsModule: AModule03_Type = (
    Version: ACollections_Version;      // Module version ($AABBCCDD). AA=00h, BB=03h.
    Uid: ACollections_Uid;              // Module unique identificator $YYMMDDxx YY - Year, MM - Month, DD - Day
    Name: ACollections_Name03;          // Module unuque name
    Description: nil;                   // Module information and description
    Init: Collections_Init03;           // Init proc
    Done: Collections_Done03;           // Done proc
    Reserved06: 0;
    Procs: Addr(CollectionsProcs);
    );
  {$endif}

// --- Collections Module ---

function Collections_Boot(): AInt;
begin
  {$ifdef A02}
  Result := ARuntime.Module_Register02(CollectionsModule);
  {$else}
  Result := ARuntime.Module_Register(CollectionsModule);
  {$endif}
end;

procedure Collections_Done02();
begin
end;

function Collections_Done03(): AInt;
begin
  Result := Collections_Done04();
end;

function Collections_Done04(): AError;
begin
  Result := 0;
end;

function Collections_Init02(): AInt;
begin
  Result := Collections_Init04();
end;

function Collections_Init03(): AInt;
begin
  Result := Collections_Init04();
end;

function Collections_Init04(): AError;
begin
  {$ifndef A02}
  if (ARuntime.Modules_FindByUid(ACollections_Uid) > 0) then
  begin
    Result := -2;
    Exit;
  end;

  if (ARuntime.Modules_FindByName(ACollections_Name03) > 0) then
  begin
    Result := -3;
    Exit;
  end;
  {$endif}

  Result := ACollections.Init();
end;

initialization
  Collections_SetProcs(CollectionsProcs);
end.
 