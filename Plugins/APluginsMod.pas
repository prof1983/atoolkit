{**
@Author Prof1983 <prof1983@ya.ru>
@Created 10.04.2009
}
unit APluginsMod;

interface

uses
  {$ifdef A02}
  ASystem0,
  ASystemProcs,
  {$endif}
  ABase,
  ALibraries,
  APlugins,
  APluginsMain,
  APluginsProcs,
  ARuntime0,
  ARuntimeBase,
  ARuntimeProcs,
  ASystemBase;

// --- Plugins Module ---

function Plugins_Boot(): AInt;

procedure Plugins_Done02(); stdcall;

function Plugins_Done03(): AInt; stdcall;

function Plugins_Done04(): AError; stdcall;

{$ifdef A02}
procedure Plugins_Find(const Path: AWideString); stdcall;
{$endif}

function Plugins_GetProc(ProcName: AStr): Pointer; stdcall;

function Plugins_Init02(): AInt; stdcall;

function Plugins_Init03(): AInt; stdcall;

function Plugins_Init04(): AError; stdcall;

const
  PluginsProcs: APluginsProcs_Type = (
    AddPlugin: APlugins.AddPlugin;                              // 00
    Clear: APlugins.Clear;                                      // 01
    Count: APlugins.GetCount;                                   // 02
    Delete: APlugins.Delete;                                    // 03
    Find: APlugins.Find02;                                      // 04
    Init: Plugins_Init04;                                       // 05
    Done: Plugins_Done04;                                       // 06
    Reserved07: 0;
    {$ifndef A02}
    Reserved08: 0;
    Reserved09: 0;
    Reserved10: 0;
    Reserved11: 0;
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
    {$endif}
    );

implementation

uses
  SysUtils, APlugins0;

const
  {$ifdef A02}
  APlugins_Version = $00020800;
  {$else}
  {$ifdef A03}
  APlugins_Version = $00030600;
  {$else}
  APlugins_Version = $00040100;
  {$endif}
  {$endif}

const
  {$ifdef A02}
  Module: AModule02_Type = (
    Version: APlugins_Version;
    Init: Plugins_Init02;
    Done: Plugins_Done02;
    Name: APlugins_Name02;
    Procs: nil;
    Reserved1: 0;
    Reserved2: 0;
    Reserved3: 0;
    );
  {$else}
  {$ifdef A03}
  PluginsModule: AModule03_Type = (
    Version: APlugins_Version;
    Uid: APlugins_Uid;
    Name: APlugins_Name03;
    Description: nil;
    Init: Plugins_Init03;
    Done: Plugins_Done03;
    Reserved06: 0;
    Procs: Addr(PluginsProcs);
    );
  {$else}
  PluginsModule: AModule04_Type = (
    Version: APlugins_Version;
    Uid: APlugins_Uid;
    Name: APlugins_Name;
    Description: nil;
    Init: Plugins_Init04;
    Done: Plugins_Done04;
    GetProc: Plugins_GetProc;
    Procs: Addr(PluginsProcs);
    );
  {$endif}
  {$endif}

{$ifndef A02}
const
  PluginsVersionValue = APlugins_Version;
  PluginsVersionMask = $FFFF0000;
{$endif}

type
  {$ifdef A02}
  TPluginBootProc = function(const Runtime: ASystemProcs_Type): Integer; stdcall;
  {$else}
  APluginBootProc = function(const Runtime: ARuntimeProcs_Type): Integer; stdcall;
  {$endif}

{ Events }

{$ifdef A02}
function DoCheckPlugin(Module: ALibrary): ABool; stdcall;
var
  PluginBootProc: TPluginBootProc;
begin
  if not(Library_GetSymbol(Module, 'Plugin_Boot', @PluginBootProc)) then
  begin
    Result := False;
    Exit;
  end;
  try
    // Для V02 передаем ASystem. Для V03 передаем ARuntime
    Result := (PluginBootProc(ASystem) >= 0);
  except
    Result := False;
  end;
end;
{$else}
function DoCheckPlugin(Lib: ALibrary): ABool; stdcall;
var
  PluginBootProc: APluginBootProc;
begin
  if not(Library_GetSymbol(Lib, 'Plugin_Boot', @PluginBootProc)) then
  begin
    Result := False;
    Exit;
  end;
  try
    Result := (PluginBootProc(ARuntime) >= 0);
  except
    Result := False;
  end;
end;
{$endif}

// --- Plugins Module ---

function Plugins_Boot(): AInt;
begin
  {$ifdef A02}

  if (ARuntime.Modules_FindByNameWS(APlugins_Name02) > 0) then
  begin
    Result := -1;
    Exit;
  end;

  APluginsMain.Plugins_SetOnCheckPlugin(DoCheckPlugin);
  Result := ARuntime.Module_Register02(Module);

  {$else}

  if not(Assigned(ARuntime.Modules_FindByName)) then
  begin
    Result := -1;
    Exit;
  end;

  if (ARuntime.Modules_FindByName(APlugins_Name03) > 0) then
  begin
    Result := -1;
    Exit;
  end;

  if (ARuntime.Modules_FindByUid(APlugins_Uid) > 0) then
  begin
    Result := -1;
    Exit;
  end;

  Plugins_SetOnCheckPlugin(DoCheckPlugin);
  Result := A_Runtime_Module_Register(PluginsModule);

  {$endif}
end;

procedure Plugins_Done02();
begin
  Plugins_Done04();
end;

function Plugins_Done03(): AInt;
begin
  Result := Plugins_Done04();
end;

function Plugins_Done04(): AError;
begin
  Result := Plugins_Done();
end;

{$ifdef A02}
procedure Plugins_Find(const Path: AWideString);
var
  TmpPluginsVersionValue1: AUInt;
  TmpPluginsVersionValue2: AUInt;
  TmpPluginsVersionMask: AUInt;
begin
  TmpPluginsVersionValue1 := PluginsVersionValue1;
  TmpPluginsVersionValue2 := PluginsVersionValue2;
  TmpPluginsVersionMask := PluginsVersionMask;

  PluginsVersionValue1 := $00020000;
  PluginsVersionValue2 := $FFFFFFFF;
  PluginsVersionMask := $FFFF0000;

  APlugins.FindWS(Path);

  PluginsVersionValue1 := TmpPluginsVersionValue1;
  PluginsVersionValue2 := TmpPluginsVersionValue2;
  PluginsVersionMask := TmpPluginsVersionMask;
end;
{$endif}

function Plugins_GetProc(ProcName: AStr): Pointer;
begin
  Result := nil;
end;

function Plugins_Init02(): AInt;
begin
  Result := Plugins_Init();
end;

function Plugins_Init03(): AInt;
begin
  Result := Plugins_Init04();
end;

function Plugins_Init04(): AError;
begin
  {$ifndef A02}
  ARuntime.Modules_InitByUid(ASystem_Uid);
  {$endif}
  Result := Plugins_Init();
end;

initialization
  Plugins_SetProcs(PluginsProcs);
end.
