{**
@Abstract ASettings
@Author Prof1983 <prof1983@ya.ru>
@Created 04.05.2008
@LastMod 24.12.2012
}
unit ARegistrySettings;

interface

uses
  Classes, Registry, Windows,
  ABase,
  ABaseTypes,
  ACollections,
  ACollectionsBase,
  AUtils,
  AAbstractSettings;

type
  TARegistrySettings = class(TAbstractSettings)
  private
    FPrefix: APascalString;
    FRegistry: TRegistry;
  public
    function DeleteKey(const Section, Name: APascalString): ABoolean; override;
    function DeleteSection(const Section: APascalString): ABoolean; override;
    //function GetNodeByName(Name: string): TANode; //override;
    function NodeExists(Name: APascalString): ABoolean; //override;
    function ReadBool(const Section, Name: APascalString; DefValue: ABoolean): ABoolean; override;
    function ReadInteger(const Section, Name: APascalString; DefValue: Integer): Integer; override;
    function ReadSection(const Section: APascalString; Strings: AStringList): ABoolean; override;
    function ReadString(const Section, Name, DefValue: APascalString; out Value: APascalString): AInteger; override;
    function WriteBool(const Section, Name: APascalString; Value: ABoolean): ABoolean; override;
    function WriteInteger(const Section, Name: APascalString; Value: AInteger): ABoolean; override;
    function WriteString(const Section, Name, Value: APascalString): ABoolean; override;
  public
    constructor Create;
    destructor Destroy; override;
  public
    property Prefix: APascalString read FPrefix write FPrefix;
    property Registry: TRegistry read FRegistry;
  end;

implementation

{ TARegistrySettings }

constructor TARegistrySettings.Create;
begin
  inherited;
  FRegistry := TRegistry.Create;
  FRegistry.RootKey := HKEY_CURRENT_USER;
end;

function TARegistrySettings.DeleteKey(const Section, Name: APascalString): ABoolean;
begin
  Result := FRegistry.OpenKey(Prefix+Section, False);
  if Result then
  try
    FRegistry.DeleteValue(Name);
  finally
    FRegistry.CloseKey;
  end;
end;

function TARegistrySettings.DeleteSection(const Section: APascalString): ABoolean;
begin
  FRegistry.DeleteKey(Prefix+Section);
  Result := True;
end;

destructor TARegistrySettings.Destroy;
begin
  FRegistry.Free;
  FRegistry := nil;
  inherited;
end;

function TARegistrySettings.NodeExists(Name: APascalString): Boolean;
begin
  Result := FRegistry.KeyExists(Prefix+Name);
end;

function TARegistrySettings.ReadBool(const Section, Name: APascalString; DefValue: ABoolean): ABoolean;
begin
  Result := DefValue;
  if FRegistry.OpenKey(Prefix+Section, False) then
  begin
    if FRegistry.ValueExists(Name) then
    try
      Result := FRegistry.ReadBool(Name);
    except
    end;
    FRegistry.CloseKey;
  end;
end;

function TARegistrySettings.ReadInteger(const Section, Name: APascalString; DefValue: AInteger): AInteger;
begin
  Result := DefValue;
  if FRegistry.OpenKey(Prefix+Section, False) then
  begin
    if FRegistry.ValueExists(Name) then
    try
      Result := FRegistry.ReadInteger(Name);
    except
    end;
    FRegistry.CloseKey;
  end;
end;

function TARegistrySettings.ReadSection(const Section: APascalString; Strings: AStringList): ABoolean;
var
  S: {AStringList}TStringList;
  I: Integer;
begin
  Result := False;
  if FRegistry.OpenKey(Prefix+Section, False) then
  begin
    try
      {S := StringList_New();}S := TStringList.Create;
      FRegistry.GetValueNames({TStrings(S)}S);
      ACollections.StringList_Clear(Strings);
      for I := 0 to {StringList_Count(S)}S.Count - 1 do
        ACollections.StringList_AddP(Strings, S.Strings[I]+'='+FRegistry.ReadString(S.Strings[I]));
      {StringList_Free(S);}S.Free;
      Result := True;
    except
    end;
    FRegistry.CloseKey;
  end;
end;

function TARegistrySettings.ReadString(const Section, Name, DefValue: APascalString; out Value: APascalString): AInteger;
begin
  Value := DefValue;
  if FRegistry.OpenKey(Prefix+Section, False) then
  begin
    if FRegistry.ValueExists(Name) then
    try
      Value := FRegistry.ReadString(Name);
    except
    end;
    FRegistry.CloseKey;
  end;
  Result := 0;
end;

function TARegistrySettings.WriteBool(const Section, Name: APascalString; Value: ABoolean): ABoolean;
begin
  Result := False;
  if FRegistry.OpenKey(Prefix+Section, True) then
  try
    try
      FRegistry.WriteBool(Name, Value);
      Result := True;
    finally
      FRegistry.CloseKey;
    end;
  except
  end;
end;

function TARegistrySettings.WriteInteger(const Section, Name: APascalString; Value: AInteger): ABoolean;
begin
  Result := False;
  if FRegistry.OpenKey(Prefix+Section, True) then
  try
    try
      FRegistry.WriteInteger(Name, Value);
      Result := True;
    finally
      FRegistry.CloseKey;
    end;
  except
  end;
end;

function TARegistrySettings.WriteString(const Section, Name, Value: APascalString): ABoolean;
begin
  Result := False;
  if FRegistry.OpenKey(Prefix+Section, True) then
  try
    try
      FRegistry.WriteString(Name, Value);
      Result := True;
    finally
      FRegistry.CloseKey;
    end;
  except
  end;
end;

end.

