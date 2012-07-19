{**
@Abstract APlugins
@Author Prof1983 <prof1983@ya.ru>
@Created 24.01.2012
@LastMod 19.07.2012
}
unit APluginsMain;

interface

uses
  SysUtils,
  ABase, ALibraries, ASettings, ASystem;

type
  TCheckPluginProc = function(Lib: ALibrary): ABoolean; stdcall;

function Plugins_Init(): AError;
function Plugins_Done(): AError;

// Проверяет и добавляет плагин.
function Plugins_AddPlugin(const FileName: APascalString): ABoolean; stdcall;

function Plugins_Clear: ABoolean; stdcall;

function Plugins_Count: AInteger; stdcall;

function Plugins_Delete(Index: Integer): ABoolean; stdcall;

function Plugins_DoneAll(): AError; stdcall;

procedure Plugins_Find(const Path: APascalString); {stdcall;}

// Exclusion - имя исключаемой для поиска директории
procedure Plugins_Find2(const Path, Exclusion: APascalString);

procedure Plugins_SetOnCheckPlugin(CheckPluginProc: TCheckPluginProc); stdcall;

var
  PluginsVersionValue: AVersion;
  PluginsVersionMask: AVersion;

const
  PluginsVersionValueDef = $00030500;
  PluginsVersionMaskDef = $FFFF0000;

implementation

type
  //APluginBootProc = function(Runtime: ARuntimeProcs): Integer; stdcall;
  APluginInitProc = function(): AInteger; stdcall;
  APluginDoneProc = function(): AInteger; stdcall;
  APluginVersionProc = function(): AInteger; stdcall;

type
  APlugin_Type = record
    Lib: ALibrary;
    InitProc: APluginInitProc;
    DoneProc: APluginDoneProc;
  end;

var
  FOnCheckPlugin: TCheckPluginProc;
  FPlugins: array of APlugin_Type;

{ Events }

{function DoCheckPlugin(Lib: ALibrary): ABoolean; stdcall;
var
  PluginBootProc: APluginBootProc;
begin
  if not(ASystem.Library_GetSymbolW(Lib, 'Plugin_Boot', @PluginBootProc)) then
  begin
    Result := False;
    Exit;
  end;
  try
    Result := (PluginBootProc(Addr(ARuntime)) >= 0);
  except
    Result := False;
  end;
end;}

{ Plugin }

function Plugin_Done(Index: Integer): Integer;
begin
  try
    Result := FPlugins[Index].DoneProc;
  except
    //System0.ShowMessage('Error Plugin_Done '+Library_GetName(FPlugins[Index].Lib));
    Result := -1;
  end;
end;

procedure Plugin_Free(Index: Integer);
begin
  ALibraries.Library_Close(FPlugins[Index].Lib);
end;

function Plugin_Init(Index: Integer): Integer;
begin
  try
    Result := FPlugins[Index].InitProc;
  except
    Result := -1;
  end;
end;

{ Private }

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
      Plugin_Init(PluginIndex);
  end;
end;

// -------------------------------------------------------------------------------------------------

function CheckPlugin(Lib: ALibrary): ABoolean;
begin
  if Assigned(FOnCheckPlugin) then
    Result := FOnCheckPlugin(Lib)
  else
    Result := True;
end;

{ Events }

function DoAfterRun(Obj, Data: AInteger): AError; stdcall;
begin
  try
    Result := Plugins_DoneAll();
  except
    Result := -1;
  end;
end;

procedure DoAfterRun02(Obj, Data: AInteger); stdcall;
begin
  DoAfterRun(Obj, Data);
end;

{ Plugins }

function Plugins_AddPlugin(const FileName: APascalString): Boolean;
var
  I: Integer;
  Lib: ALibrary;
  PluginInitProc: APluginInitProc;
  PluginDoneProc: APluginDoneProc;
  PluginVersionProc: APluginVersionProc;
  Version: AInteger;
begin
  try
    Lib := ASystem.Library_OpenP(FileName, 0);
    if (Lib = 0) then
    begin
      Result := False;
      Exit;
    end;
    if not(ASystem.Library_GetSymbolP(Lib, 'Plugin_Init', @PluginInitProc)) then
    begin
      ASystem.Library_Close(Lib);
      Result := False;
      Exit;
    end;
    if not(ASystem.Library_GetSymbolP(Lib, 'Plugin_Done', @PluginDoneProc)) then
    begin
      ASystem.Library_Close(Lib);
      Result := False;
      Exit;
    end;
    if not(ASystem.Library_GetSymbolP(Lib, 'Plugin_Version', @PluginVersionProc)) then
    begin
      ASystem.Library_Close(Lib);
      Result := False;
      Exit;
    end;

    // Проверяем версию плагина
    if Assigned(PluginVersionProc) then
    begin
      try
        Version := PluginVersionProc;
      except
        ASystem.Library_Close(Lib);
        Result := False;
        Exit;
      end;
      if (Version and PluginsVersionMask <> PluginsVersionValue and PluginsVersionMask) then
      begin
        ASystem.Library_Close(Lib);
        Result := False;
        Exit;
      end;
    end;

    if not(CheckPlugin(Lib)) then
    begin
      ASystem.Library_Close(Lib);
      Result := False;
      Exit;
    end;

    I := Length(FPlugins);
    SetLength(FPlugins, I + 1);
    FPlugins[I].Lib := Lib;
    FPlugins[I].InitProc := PluginInitProc;
    FPlugins[I].DoneProc := PluginDoneProc;
    Result := True;
  except
    Result := False;
  end;
end;

function Plugins_Clear: Boolean;
var
  I: Integer;
begin
  for I := 0 to High(FPlugins) do
  try
    Plugin_Done(I);
    Plugin_Free(I);
  except
  end;
  SetLength(FPlugins, 0);
  Result := True;
end;

function Plugins_Count: Integer;
begin
  Result := Length(FPlugins);
end;

function Plugins_Delete(Index: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if (Index < 0) or (Index >= Length(FPlugins)) then Exit;
  Plugin_Done(Index);
  Plugin_Free(Index);
  for I := Index to High(FPlugins) - 1 do
  begin
    FPlugins[I] := FPlugins[I + 1];
  end;
  SetLength(FPlugins, High(FPlugins));
  Result := True;
end;

function Plugins_Done(): AError; 
begin
  Plugins_Clear();
  Result := 0;
end;

function Plugins_DoneAll(): AError; stdcall;
var
  I: Integer;
begin
  for I := 0 to High(FPlugins) do
  try
    Plugin_Done(I);
  except
  end;
  Result := 0;
end;

procedure Plugins_Find(const Path: APascalString);
begin
  Plugins_Find2(Path, '');
end;

procedure Plugins_Find2(const Path, Exclusion: APascalString);

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
  if (FindFirst(Path + '*', faDirectory, SearchRec) <> 0) then Exit;
  if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
    PFind(Path+SearchRec.Name+'\');
  while (FindNext(SearchRec) = 0) do
  begin
    if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and (SearchRec.Name <> Exclusion) then
      PFind(Path+SearchRec.Name+'\');
  end;
  SysUtils.FindClose(SearchRec);
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
    Plugin_Init(I);
  Result := 0;
end;

procedure Plugins_SetOnCheckPlugin(CheckPluginProc: TCheckPluginProc);
begin
  FOnCheckPlugin := CheckPluginProc;
end;

initialization
  PluginsVersionMask := PluginsVersionMaskDef;
  PluginsVersionValue := PluginsVersionValueDef;
  //Plugins_SetOnCheckPlugin(DoCheckPlugin);
end.
 