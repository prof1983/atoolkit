{**
@Abstract Reading and writing settings from INI file
@Author Prof1983 <prof1983@ya.ru>
@Created 24.03.2008
@LastMod 24.07.2012
Version: 0.3
}
unit AIniSettings;

interface

uses
  Classes, IniFiles, SysUtils,
  ABase, ACollections, ACollectionsBase, AUtils,
  AAbstractSettings;

type
  TIniSettings = class(TAbstractSettings)
  private
    FIniFile: TIniFile;
  public
    procedure Close; override;
    function DeleteKey(const Section, Name: APascalString): ABoolean; override;
    function DeleteSection(const Section: APascalString): ABoolean; override;
    procedure OpenIniFile(const FileName: APascalString);
    function ReadSection(const Section: APascalString; Strings: AStringList): ABoolean; override;
    function ReadString(const Section, Name, DefValue: APascalString; out Value: APascalString): AInteger; override;
    function WriteString(const Section, Name, Value: APascalString): ABoolean; override;
  end;

implementation

{ TIniSettings }

procedure TIniSettings.Close;
begin
  if Assigned(FIniFile) then
  try
    FIniFile.Free;
  finally
    FIniFile := nil;
  end;
end;

function TIniSettings.DeleteKey(const Section, Name: APascalString): ABoolean;
begin
  Result := False;
  if Assigned(FIniFile) then
  try
    FIniFile.DeleteKey(Section, Name);
    Result := True;
  except
  end;
end;

function TIniSettings.DeleteSection(const Section: APascalString): ABoolean;
begin
  Result := False;
  if Assigned(FIniFile) then
  try
    FIniFile.EraseSection(Section);
    Result := True;
  except
  end;
end;

procedure TIniSettings.OpenIniFile(const FileName: APascalString);
begin
  Close;
  try
    FIniFile := TIniFile.Create(FileName);
  except
    FIniFile := nil;
  end;
end;

function TIniSettings.ReadSection(const Section: APascalString; Strings: AStringList): ABoolean;
var
  Values: TStringList;
  I: Integer;
begin
  if not(Assigned(FIniFile)) then
  begin
    Result := False;
    Exit;
  end;
  ACollections.StringList_Clear(Strings);
  Values := TStringList.Create;
  try
    FIniFile.ReadSectionValues(Section, Values);
    for I := 0 to Values.Count - 1 do
      ACollections.StringList_AddP(Strings, Values.Strings[I]); //TStrings(Strings).Add(Values.Strings[I]);
  finally
    Values.Free;
  end;
  Result := True;
  {Result := Assigned(FIniFile);
  if Result then
  begin
    Values := TStringList.Create;
    try
      FIniFile.ReadSectionValues(Section, Values);
      for I := 0 to Values.Count - 1 do
        TStrings(Strings).Add(Values.Strings[I]);
    finally
      Values.Free;
    end;
  end;}
end;

function TIniSettings.ReadString(const Section, Name, DefValue: APascalString; out Value: APascalString): AInteger;
begin
  if Assigned(FIniFile) then
    Value := FIniFile.ReadString(Section, Name, DefValue)
  else
    Value := DefValue;
  Result := Length(Value);
end;

function TIniSettings.WriteString(const Section, Name, Value: APascalString): ABoolean;
begin
  Result := Assigned(FIniFile);
  if Result then
    FIniFile.WriteString(Section, Name, Value);
end;

end.
