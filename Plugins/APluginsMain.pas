{**
@Abstract APlugins
@Author Prof1983 <prof1983@ya.ru>
@Created 24.01.2012
@LastMod 24.04.2013
}
unit APluginsMain;

interface

uses
  SysUtils,
  ABase,
  ALibraries,
  APluginsBase,
  ARuntimeBase,
  ARuntimeMain,
  ASettings,
  ASystem;

// --- APlugins ---

function APlugins_AddPluginA(FileName: AStr): AError; stdcall;

function APlugins_AddPluginP(const FileName: APascalString): AError; stdcall;

function APlugins_Clear(): AError; stdcall;

function APlugins_Delete(Index: AInteger): AError; stdcall;

function APlugins_Fin(): AError; stdcall;

function APlugins_FinAll(): AError; stdcall;

function APlugins_Find2A(Path, Exclusion: AStr): AError; stdcall;

function APlugins_Find2P(const Path, Exclusion: APascalString): AError; stdcall;

function APlugins_FindA(Path: AStr): AError; stdcall;

function APlugins_FindP(const Path: APascalString): AError; stdcall;

function APlugins_GetCount(): AInteger; stdcall;

function APlugins_Init(): AError; stdcall;

function APlugins_Prepare(Value: AVersion): AError; stdcall;

function APlugins_SetOnCheckPlugin(CheckPluginProc: TCheckPluginProc): AError; stdcall;

// --- Plugins ---

function Plugins_Init(): AError;
function Plugins_Done(): AError;

// Проверяет и добавляет плагин.
function Plugins_AddPlugin(const FileName: APascalString): ABoolean; stdcall;

function Plugins_Clear: ABoolean; stdcall;

function Plugins_Count: AInteger; stdcall;

function Plugins_Delete(Index: Integer): ABoolean; stdcall;

function Plugins_DoneAll(): AError; stdcall; deprecated {$ifdef ADeprText}'Use APlugins_FinAll()'{$endif};

procedure Plugins_Find(const Path: APascalString); {stdcall;}

// Exclusion - имя исключаемой для поиска директории
procedure Plugins_Find2(const Path, Exclusion: APascalString);

procedure Plugins_SetOnCheckPlugin(CheckPluginProc: TCheckPluginProc); stdcall;

var
  PluginsVersionValue1: AVersion;
  PluginsVersionValue2: AVersion;
  PluginsVersionMask: AVersion;

const
  PluginsVersionValue1Def = $00060000;
  PluginsVersionValue2Def = $00060000;
  PluginsVersionMaskDef = $FFFF0000;

implementation

type
  APlugin_Boot05_Proc = function(GetProcByName: ARuntime_GetProcByName_Proc): AError; stdcall;
  APluginInitProc = function(): AError; stdcall;
  APluginFinProc = function(): AError; stdcall;
  APluginVersionProc = function(): AError; stdcall;

type
  APlugin_Type = record
    Lib: ALibrary;
    InitProc: APluginInitProc;
    FinProc: APluginFinProc;
  end;

var
  FOnCheckPlugin: TCheckPluginProc;
  FPlugins: array of APlugin_Type;

function _Plugin_Fin(Index: Integer): Integer; forward;
procedure _Plugin_Free(Index: Integer); forward;
function _Plugin_Init(Index: Integer): Integer; forward;

{ Private }

function CheckPlugin(Lib: ALibrary): ABoolean;
begin
  if Assigned(FOnCheckPlugin) then
    Result := FOnCheckPlugin(Lib)
  else
    Result := True;
end;

function FindPluginByName(const Name: APascalString): AInteger;
var
  I: Integer;
begin
  for I := 0 to High(FPlugins) do
  begin
    if (ALibraries.Library_GetName(FPlugins[I].Lib) = Name) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

procedure InitPluginFromConfig(Config: AConfig; const ConfigParamName: string);
var
  PluginName: APascalString;
  PluginIndex: Integer;
begin
  PluginName := ASettings.Config_ReadStringDefP(Config, 'Boot', ConfigParamName, '');
  if (PluginName <> '') then
  begin
    PluginIndex := FindPluginByName(PluginName);
    if (PluginIndex >= 0) then
      _Plugin_Init(PluginIndex);
  end;
end;

function _Plugin_Fin(Index: Integer): Integer;
begin
  try
    Result := FPlugins[Index].FinProc();
  except
    //System0.ShowMessage('Error Plugin_Done '+Library_GetName(FPlugins[Index].Lib));
    Result := -1;
  end;
end;

procedure _Plugin_Free(Index: Integer);
begin
  ALibraries.Library_Close(FPlugins[Index].Lib);
end;

function _Plugin_Init(Index: Integer): Integer;
begin
  try
    Result := FPlugins[Index].InitProc;
  except
    Result := -1;
  end;
end;

{ Events }

function DoAfterRun(Obj, Data: AInteger): AError; stdcall;
begin
  try
    Result := APlugins_FinAll();
  except
    Result := -1;
  end;
end;

procedure DoAfterRun02(Obj, Data: AInteger); stdcall;
begin
  DoAfterRun(Obj, Data);
end;

function DoCheckPlugin(Lib: ALibrary): ABoolean; stdcall;
var
  PluginBootProc: APlugin_Boot05_Proc;
begin
  if not(ALibrary_GetSymbolP(Lib, 'Plugin_Boot', @PluginBootProc)) then
  begin
    Result := False;
    Exit;
  end;
  try
    Result := (PluginBootProc(Addr(ARuntime_GetProcByName)) >= 0);
  except
    Result := False;
  end;
end;

// --- APlugins ---

function APlugins_AddPluginA(FileName: AStr): AError;
begin
  Result := APlugins_AddPluginP(FileName);
end;

function APlugins_AddPluginP(const FileName: APascalString): AError;
var
  I: Integer;
  Lib: ALibrary;
  PluginInitProc: APluginInitProc;
  PluginFinProc: APluginFinProc;
  PluginVersionProc: APluginVersionProc;
  Version: AInteger;
begin
  try
    Lib := ALibrary_OpenP(FileName, 0);
    if (Lib = 0) then
    begin
      Result := -1;
      Exit;
    end;
    if not(ALibrary_GetSymbolP(Lib, 'Plugin_Init', @PluginInitProc)) then
    begin
      ALibrary_Close(Lib);
      Result := -1;
      Exit;
    end;
    if not(ALibrary_GetSymbolP(Lib, 'Plugin_Fin', @PluginFinProc)) then
    begin
      ALibrary_Close(Lib);
      Result := -1;
      Exit;
    end;
    if not(ALibrary_GetSymbolP(Lib, 'Plugin_Version', @PluginVersionProc)) then
    begin
      ALibrary_Close(Lib);
      Result := -1;
      Exit;
    end;

    // Проверяем версию плагина
    if Assigned(PluginVersionProc) then
    begin
      try
        Version := PluginVersionProc;
      except
        ALibrary_Close(Lib);
        Result := -1;
        Exit;
      end;
      if (Version and PluginsVersionMask <> PluginsVersionValue1 and PluginsVersionMask)
      and (Version and PluginsVersionMask <> PluginsVersionValue2 and PluginsVersionMask) then
      begin
        ALibrary_Close(Lib);
        Result := -1;
        Exit;
      end;
    end;

    if not(CheckPlugin(Lib)) then
    begin
      ALibrary_Close(Lib);
      Result := -1;
      Exit;
    end;

    I := Length(FPlugins);
    SetLength(FPlugins, I + 1);
    FPlugins[I].Lib := Lib;
    FPlugins[I].InitProc := PluginInitProc;
    FPlugins[I].FinProc := PluginFinProc;
    Result := 0;
  except
    Result := -1;
  end;
end;

function APlugins_Clear(): AError;
var
  I: Integer;
begin
  try
    for I := 0 to High(FPlugins) do
    try
      _Plugin_Fin(I);
      _Plugin_Free(I);
    except
    end;
    SetLength(FPlugins, 0);
    Result := 0;
  except
    Result := -1;
  end;
end;

function APlugins_Delete(Index: AInteger): AError;
var
  I: Integer;
begin
  try
    if (Index < 0) or (Index >= Length(FPlugins)) then
    begin
      Result := -1;
      Exit;
    end;
    _Plugin_Fin(Index);
    _Plugin_Free(Index);
    for I := Index to High(FPlugins) - 1 do
    begin
      FPlugins[I] := FPlugins[I + 1];
    end;
    SetLength(FPlugins, High(FPlugins));
    Result := 0;
  except
    Result := -1;
  end;
end;

function APlugins_Fin(): AError;
begin
  try
    Result := Plugins_Done();
  except
    Result := -1;
  end;
end;

function APlugins_FinAll(): AError;
var
  I: AInt;
begin
  for I := 0 to High(FPlugins) do
  try
    _Plugin_Fin(I);
  except
  end;
  Result := 0;
end;

function APlugins_Find2A(Path, Exclusion: AStr): AError;
begin
  Result := APlugins_Find2P(AnsiString(Path), AnsiString(Exclusion));
end;

function APlugins_Find2P(const Path, Exclusion: APascalString): AError;

  procedure PFind(const Path: APascalString);
  var
    SearchRec: TSearchRec;
  begin
    if (FindFirst(Path + '*.dll', faAnyFile and (not(faDirectory)), SearchRec) <> 0) then Exit;
    Plugins_AddPlugin(Path + SearchRec.Name);
    while (FindNext(SearchRec) = 0) do
      Plugins_AddPlugin(Path + SearchRec.Name);
    SysUtils.FindClose(SearchRec);
  end;

var
  SearchRec: TSearchRec;
begin
  try
    if (FindFirst(Path + '*', faDirectory, SearchRec) <> 0) then
    begin
      Result := 1;
      Exit;
    end;
    if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
      PFind(Path+SearchRec.Name+'\');
    while (FindNext(SearchRec) = 0) do
    begin
      if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and (SearchRec.Name <> Exclusion) then
        PFind(Path+SearchRec.Name+'\');
    end;
    SysUtils.FindClose(SearchRec);
    Result := 0;
  except
    Result := -1;
  end;
end;

function APlugins_FindA(Path: AStr): AError;
begin
  Result := APlugins_FindP(Path);
end;

function APlugins_FindP(const Path: APascalString): AError;
begin
  Result := APlugins_Find2P(Path, '');
end;

function APlugins_GetCount(): AInteger;
begin
  try
    Result := Length(FPlugins);
  except
    Result := 0;
  end;
end;

function APlugins_Init(): AError;
begin
  Result := Plugins_Init();
end;

function APlugins_Prepare(Value: AVersion): AError;
begin
  PluginsVersionValue1 := Value;
  PluginsVersionValue2 := 0;
  Result := 0;
end;

function APlugins_SetOnCheckPlugin(CheckPluginProc: TCheckPluginProc): AError;
begin
  Plugins_SetOnCheckPlugin(CheckPluginProc);
  Result := 0;
end;

{ Plugins }

function Plugins_AddPlugin(const FileName: APascalString): Boolean;
begin
  Result := (APlugins_AddPluginP(FileName) >= 0);
end;

function Plugins_Clear: Boolean;
begin
  Result := (APlugins_Clear() >= 0);
end;

function Plugins_Count: Integer;
begin
  Result := APlugins_GetCount();
end;

function Plugins_Delete(Index: Integer): Boolean;
begin
  Result := (APlugins_Delete(Index) >= 0);
end;

function Plugins_Done(): AError;
begin
  Plugins_Clear();
  Result := 0;
end;

function Plugins_DoneAll(): AError; stdcall;
begin
  Result := APlugins_FinAll();
end;

procedure Plugins_Find(const Path: APascalString);
begin
  APlugins_FindP(Path);
end;

procedure Plugins_Find2(const Path, Exclusion: APascalString);
begin
  APlugins_Find2P(Path, Exclusion);
end;

function Plugins_Init(): AError;
var
  I: Integer;
  Config: AConfig;
begin
  {
  ARuntime.Modules_InitByUid(ASystem_Uid);
  }

  if (ASystem.Init() < 0) then
  begin
    Result := -2;
    Exit;
  end;

  ASettings.Init();

  {$IFDEF A02}
  ASystem.OnAfterRun_Connect(DoAfterRun02);
  {$ELSE}
  ASystem.OnAfterRun_Connect(DoAfterRun);
  {$ENDIF A02}

  Config := ASystem.GetConfig;
  InitPluginFromConfig(Config, 'InitPlugin0');
  InitPluginFromConfig(Config, 'InitPlugin1');
  InitPluginFromConfig(Config, 'InitPlugin2');
  InitPluginFromConfig(Config, 'InitPlugin3');
  InitPluginFromConfig(Config, 'InitPlugin4');
  InitPluginFromConfig(Config, 'InitPlugin5');
  InitPluginFromConfig(Config, 'InitPlugin6');
  InitPluginFromConfig(Config, 'InitPlugin7');

  for I := 0 to High(FPlugins) do
    _Plugin_Init(I);
  Result := 0;
end;

procedure Plugins_SetOnCheckPlugin(CheckPluginProc: TCheckPluginProc);
begin
  FOnCheckPlugin := CheckPluginProc;
end;

initialization
  PluginsVersionMask := AVersion(PluginsVersionMaskDef);
  PluginsVersionValue1 := PluginsVersionValue1Def;
  PluginsVersionValue2 := PluginsVersionValue2Def;
  Plugins_SetOnCheckPlugin(DoCheckPlugin);
end.
 