{**
@Abstract Reading and writing settings from INI file
@Author Prof1983 <prof1983@ya.ru>
@Created 24.03.2008
@LastMod 18.12.2012
}
unit AIniSettings;

interface

uses
  Classes, IniFiles, SysUtils,
  AAbstractSettings,
  ABase,
  ABaseTypes,
  AStringLists;

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
  Values: AStringList;
  I: Integer;
  C: AInteger;
begin
  if not(Assigned(FIniFile)) then
  begin
    Result := False;
    Exit;
  end;
  AStringList_Clear(Strings);
  Values := AStringList_New();
  try
    FIniFile.ReadSectionValues(Section, TStrings(Values));
    C := AStringList_GetCount(Values);
    for I := 0 to C - 1 do
      AStringList_AddP(Strings, AStringList_GetStringP(Values, I));
  finally
    AStringList_Free(Values);
  end;
  Result := True;
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
