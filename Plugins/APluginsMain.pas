{**
@Abstract APlugins
@Author Prof1983 <prof1983@ya.ru>
@Created 24.01.2012
@LastMod 31.01.2013
}
unit APluginsMain;

{define AStdCall}

interface

uses
  SysUtils,
  ABase,
  ALibraries,
  ARuntimeBase,
  ARuntimeMain,
  ASettingsMain,
  ASystemEvents,
  ASystemMain;

type
  TCheckPluginProc = function(Lib: ALibrary): ABoolean; stdcall;

// --- APlugins ---

function APlugins_AddPluginA(FileName: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function APlugins_AddPluginP(const FileName: APascalString): AError;

function APlugins_Clear(): AError; {$ifdef AStdCall}stdcall;{$endif}

function APlugins_Delete(Index: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

function APlugins_Fin(): AError; {$ifdef AStdCall}stdcall;{$endif}

function APlugins_FinAll(): AError; {$ifdef AStdCall}stdcall;{$endif}

function APlugins_Find2P(const Path, Exclusion: APascalString): AError;

function APlugins_FindA(Path: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function APlugins_FindP(const Path: APascalString): AError;

function APlugins_GetCount(): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function APlugins_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

function APlugins_Prepare(Value: AVersion): AError; {$ifdef AStdCall}stdcall;{$endif}

function APlugins_SetOnCheckPlugin(CheckPluginProc: TCheckPluginProc): AError; {$ifdef AStdCall}stdcall;{$endif}

// --- Plugins ---

var
  PluginsVersionValue: AVersion;
  PluginsVersionMask: AVersion;

const
  PluginsVersionValueDef = $00070000;
  PluginsVersionMaskDef = $FFFF0000;

implementation

type
  APluginBootProc = function(GetProcByName: ARuntime_GetProcByName_Proc): AError; stdcall;
  APluginInitProc = AProc;
  APluginFinProc = AProc;
  APluginVersionProc = AProc;

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

function _CheckPlugin(Lib: ALibrary): ABoolean;
begin
  if Assigned(FOnCheckPlugin) then
    Result := FOnCheckPlugin(Lib)
  else
    Result := True;
end;

function _FindPluginByName(const Name: APascalString): AInteger;
var
  I: Integer;
begin
  for I := 0 to High(FPlugins) do
  begin
    if (ALibrary_GetNameP(FPlugins[I].Lib) = Name) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

procedure _InitPluginFromConfig(Config: AConfig; const ConfigParamName: string);
var
  PluginName: APascalString;
  PluginIndex: Integer;
begin
  PluginName := ASettings_ReadStringDefP(Config, 'Boot', ConfigParamName, '');
  if (PluginName <> '') then
  begin
    PluginIndex := _FindPluginByName(PluginName);
    if (PluginIndex >= 0) then
      _Plugin_Init(PluginIndex);
  end;
end;

function _Plugin_Fin(Index: Integer): Integer;
begin
  try
    Result := FPlugins[Index].FinProc;
  except
    //ASystem_ShowMessageP('Error Plugin_Fin '+ALibrary_GetNameP(FPlugins[Index].Lib));
    Result := -1;
  end;
end;

procedure _Plugin_Free(Index: Integer);
begin
  ALibrary_Close(FPlugins[Index].Lib);
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

function DoCheckPlugin(Lib: ALibrary): ABoolean; stdcall;
var
  PluginBootProc: APluginBootProc;
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
  PluginFinProc: APluginFinProc;
  PluginInitProc: APluginInitProc;
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
      if (Version and PluginsVersionMask <> PluginsVersionValue and PluginsVersionMask) then
      begin
        ALibrary_Close(Lib);
        Result := -1;
        Exit;
      end;
    end;

    if not(_CheckPlugin(Lib)) then
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
  Result := APlugins_Clear();
end;

function APlugins_FinAll(): AError;
var
  I: Integer;
begin
  for I := 0 to High(FPlugins) do
  try
    _Plugin_Fin(I);
  except
  end;
  Result := 0;
end;

function APlugins_Find2P(const Path, Exclusion: APascalString): AError;

  procedure PFind(const Path: APascalString);
  var
    SearchRec: TSearchRec;
  begin
    if (FindFirst(Path + '*.dll', faAnyFile and (not(faDirectory)), SearchRec) <> 0) then Exit;
    APlugins_AddPluginP(Path + SearchRec.Name);
    while (FindNext(SearchRec) = 0) do
      APlugins_AddPluginP(Path + SearchRec.Name);
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
var
  I: Integer;
  Config: AConfig;
begin
  if (ASystem_Init() < 0) then
  begin
    Result := -2;
    Exit;
  end;

  ASettings_Init();

  ASystem_OnAfterRun_Connect(DoAfterRun);

  Config := ASystem_GetConfig();
  _InitPluginFromConfig(Config, 'InitPlugin0');
  _InitPluginFromConfig(Config, 'InitPlugin1');
  _InitPluginFromConfig(Config, 'InitPlugin2');
  _InitPluginFromConfig(Config, 'InitPlugin3');
  _InitPluginFromConfig(Config, 'InitPlugin4');
  _InitPluginFromConfig(Config, 'InitPlugin5');
  _InitPluginFromConfig(Config, 'InitPlugin6');
  _InitPluginFromConfig(Config, 'InitPlugin7');

  for I := 0 to High(FPlugins) do
    _Plugin_Init(I);
  Result := 0;
end;

function APlugins_Prepare(Value: AVersion): AError;
begin
  PluginsVersionValue := Value;
  Result := 0;
end;

function APlugins_SetOnCheckPlugin(CheckPluginProc: TCheckPluginProc): AError;
begin
  FOnCheckPlugin := CheckPluginProc;
  Result := 0;
end;

initialization
  PluginsVersionMask := AVersion(PluginsVersionMaskDef);
  PluginsVersionValue := PluginsVersionValueDef;
  APlugins_SetOnCheckPlugin(DoCheckPlugin);
end.
 