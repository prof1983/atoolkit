{**
@Abstract APlugins
@Author Prof1983 <prof1983@ya.ru>
@Created 10.04.2009
@LastMod 19.07.2012
}
unit APlugins;

interface

uses
  ABase, APluginsMain;

function Init(): AError; stdcall;
function Done(): AError; stdcall;

// Проверяет и добавляет плагин.
function AddPlugin(const FileName: APascalString): ABoolean; stdcall;

function Clear(): ABoolean; stdcall;

function Delete(Index: Integer): ABoolean; stdcall;

procedure Find02(const Path: APascalString); stdcall;

// Exclusion - имя исключаемой для поиска директории
function Find2WS(const Path, Exclusion: AWideString): AError; stdcall;

// Use Find() or FindWS()
function FindP(const Path: APascalString): AError; stdcall; deprecated;

function FindWS(const Path: AWideString): AError; stdcall;

function GetCount(): AInteger; stdcall;

procedure Prepare(Value: AVersion);

implementation

{ Module }

function Done(): AError; stdcall;
begin
  try
    Result := Plugins_Done();
  except
    Result := -1;
  end;
end;

function AddPlugin(const FileName: APascalString): ABoolean; stdcall;
begin
  try
    Result := Plugins_AddPlugin(FileName);
  except
    Result := False;
  end;
end;

function Clear(): ABoolean; stdcall;
begin
  try
    Result := Plugins_Clear();
  except
    Result := False;
  end;
end;

function Delete(Index: Integer): ABoolean; stdcall;
begin
  try
    Result := Plugins_Delete(Index);
  except
    Result := False;
  end;
end;

procedure Find02(const Path: APascalString); stdcall;
begin
  try
    Plugins_Find(Path);
  except
  end;
end;

function Find2WS(const Path, Exclusion: AWideString): AError; stdcall;
begin
  try
    Plugins_Find2(Path, Exclusion);
    Result := 0;
  except
    Result := -1;
  end;
end;

function FindP(const Path: APascalString): AError; stdcall;
begin
  try
    Plugins_Find(Path);
    Result := 0;
  except
    Result := -1;
  end;
end;

function FindWS(const Path: AWideString): AError; stdcall;
begin
  try
    Plugins_Find(Path);
    Result := 0;
  except
    Result := -1;
  end;
end;

function GetCount(): AInteger; stdcall;
begin
  try
    Result := Plugins_Count();
  except
    Result := -1;
  end;
end;

function Init(): AError; stdcall;
begin
  Result := Plugins_Init();
end;

procedure Prepare(Value: AVersion);
begin
  PluginsVersionValue := Value;
end;

end.
