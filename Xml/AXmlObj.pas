{**
@Abstract(Xml)
@Author(Prof1983 <prof1983@ya.ru>)
@Created(03.05.2012)
@LastMod(20.07.2012)
}
unit AXmlObj;

interface

uses
  SysUtils,
  ABase, ABaseUtils3, AStreamObj, ATypes, AXmlDocumentUtils, AXmlNodeUtils;

type
  TParam = class
  private
    FName: String;
    FValue: String;
  public
    function GetName: String;
    function GetValue: String;
    function SetName(Value: String): TError;
    function SetValue(Value: String): TError;
  end;

type // Recover 03.05.2012 from AConfigObject2.TConfigFileText
  TProfXml = class
  private
    FParams: array of TParam;
    FXmlDocument: AXmlDocument;
    FXmlNode: AXmlNode;
  public
    function Finalize(): TError; virtual;
    function Initialize(): TError; virtual;
  public
    function AddParam(Param: TParam): Int32;
    function Clear(): TError;
    function Load(const FileName: String): TError;
    function LoadFromXml(Xml: TProfXml): TError;
    function NewParam(Name, Value: String): Int32;
    function Save(FileName: String): TError;
  public
    function GetCountParams(): UInt32;
    function GetParam(Index: UInt32): TParam;
    function GetParamByName(Name: String): TParam;
    function GetParamValueByName(const Name: String): String;
    function GetParamValueByName_(Name: String; var Value: String): Boolean; virtual; deprecated; // Use ReadParamValueByName()
    function GetParamValueByNameAsBoolean(const Name: String): Boolean;
    function GetParamValueByNameAsBoolean_(Name: String; var Value: Boolean): Boolean; virtual; deprecated; // Use ReadParamValueByNameAsBoolean()
    function GetParamValueByNameAsInt32(const Name: String): Int32;
    function GetParamValueByNameAsInt32_(Name: String; var Value: Int32): Boolean; virtual; deprecated; // Use ReadParamValueByNameAsInt32()
    function GetParamValueByNameAsUInt08(const Name: APascalString; var Value: UInt08): Boolean; virtual; deprecated; // Use ReadParamValueByNameAsUInt08()
    function GetParamValueByNameAsUInt64(const Name: String): UInt64;
    function GetParamValueByNameAsUInt64_(Name: String; var Value: UInt64): Boolean; virtual; deprecated; // Use ReadParamValueByNameAsUInt64()
  public
    function ReadBool(Section, Name: String; var Value: Boolean): TError; virtual;
    function ReadInt32(const Section, Name: APascalString; var Value: AInt32): ABoolean; virtual;
    function ReadInt64(const Section, Name: APascalString; var Value: AInt64): ABoolean; virtual;
    function ReadStr(Name: String; var Value: String): Boolean; deprecated; // Use ReadString()
    function ReadString(Section, Name: String; var Value: String): Boolean; virtual;
    function ReadUInt08(Name: String; var Value: UInt08): Boolean; virtual;
    function ReadUInt64(Section, Name: String; var Value: UInt64): Boolean; virtual;
    function ReadParamValueByName(const Name: String; var Value: String): Boolean;
    function ReadParamValueByNameAsBoolean(const Name: String; var Value: Boolean): Boolean;
    function ReadParamValueByNameAsDateTime(const Name: APascalString; var Value: TDateTime): Boolean;
    function ReadParamValueByNameAsInt32(const Name: String; var Value: Int32): Boolean;
    function ReadParamValueByNameAsInt64(const Name: APascalString; var Value: Int64): Boolean;
    function ReadParamValueByNameAsUInt08(const Name: String; var Value: UInt08): Boolean;
    function ReadParamValueByNameAsUInt64(const Name: String; var Value: UInt64): Boolean;
    function SetParamValueByName(Name, Value: String): TError; virtual;
    function SetParamValueByNameAsBoolean(Name: String; Value: Boolean): TError; virtual;
    function SetParamValueByNameAsInt32(Name: String; Value: Int32): TError; virtual;
    function SetParamValueByNameAsUInt08(const Name: APascalString; Value: UInt08): TError; virtual;
    function SetParamValueByNameAsUInt64(const Name: APascalString; Value: UInt64): TError; virtual;
    function WriteBool(Section, Name: String; Value: Boolean): TError; virtual;
    function WriteFloat64(Name: String; Value: Float64): TError; virtual;
    function WriteInt32(Section, Name: String; Value: Int32): TError; virtual;
    function WriteStr(Name, Value: String): TError; deprecated; // Use WriteString()
    function WriteString(Section, Name, Value: String): TError; virtual;
    function WriteUInt32(Name: String; Value: UInt32): TError; virtual;
    function WriteUInt64(Section, Name: String; Value: UInt64): Boolean; virtual;
  public
    constructor Create1(XmlNode: AXmlNode);
    constructor Create2(XmlDocument: AXmlDocument);
    procedure Free();
  end;

implementation

{ TParam }

function TParam.GetName(): String;
begin
  Result := FName;
end;

function TParam.GetValue(): String;
begin
  Result := FValue;
end;

function TParam.SetName(Value: String): TError;
begin
  FName := Value;
  Result := 0;
end;

function TParam.SetValue(Value: String): TError;
begin
  FValue := Value;
  Result := 0;
end;

{ TProfXml }

function TProfXml.AddParam(Param: TParam): Int32;
begin
  Result := Length(FParams);
  SetLength(FParams, Result + 1);
  FParams[Result] := Param;
end;

function TProfXml.Clear(): TError;
var
  I: Int32;
begin
  for I := 0 to High(FParams) do
    FParams[I].Free();
  SetLength(FParams, 0);
  Result := 0;
end;

constructor TProfXml.Create1(XmlNode: AXmlNode);
begin
  inherited Create();
  FXmlNode := XmlNode;
end;

constructor TProfXml.Create2(XmlDocument: AXmlDocument);
begin
  inherited Create();
  FXmlDocument := XmlDocument;
  FXmlNode := AXmlDocument_GetDocumentElement(FXmlDocument);
end;

function TProfXml.Finalize(): TError;
begin
  Result := 0;
end;

procedure TProfXml.Free();
begin
  Clear();
  AXmlNode_Free(FXmlNode);
  FXmlNode := 0;
  inherited Free();
end;

function TProfXml.GetCountParams(): UInt32;
begin
  Result := Length(FParams);
end;

function TProfXml.GetParam(Index: UInt32): TParam;
begin
  if Index >= UInt32(Length(FParams)) then
    Result := nil
  else
    Result := FParams[Index];
end;

function TProfXml.GetParamByName(Name: String): TParam;
var
  I: Int32;
begin
  for I := 0 to High(FParams) do
  begin
    if (FParams[I].GetName = Name) then
    begin
      Result := FParams[I];
      Exit;
    end;
  end;
  Result := nil;
end;

function TProfXml.GetParamValueByName(const Name: String): String;
begin
  ReadParamValueByName(Name, Result);
end;

function TProfXml.GetParamValueByName_(Name: String; var Value: String): Boolean;
begin
  Result := ReadParamValueByName(Name, Value);
end;

function TProfXml.GetParamValueByNameAsBoolean(const Name: String): Boolean;
begin
  ReadParamValueByNameAsBoolean(Name, Result);
end;

function TProfXml.GetParamValueByNameAsBoolean_(Name: String; var Value: Boolean): Boolean;
begin
  Result := ReadParamValueByNameAsBoolean(Name, Value);
end;

function TProfXml.GetParamValueByNameAsInt32(const Name: String): Int32;
begin
  ReadParamValueByNameAsInt32(Name, Result);
end;

function TProfXml.GetParamValueByNameAsInt32_(Name: String; var Value: Int32): Boolean;
begin
  Result := ReadParamValueByNameAsInt32(Name, Value);
end;

function TProfXml.GetParamValueByNameAsUInt08(const Name: APascalString; var Value: UInt08): Boolean;
begin
  Result := Self.ReadParamValueByNameAsUInt08(Name, Value);
end;

function TProfXml.GetParamValueByNameAsUInt64(const Name: String): UInt64;
begin
  ReadParamValueByNameAsUInt64(Name, Result);
end;

function TProfXml.GetParamValueByNameAsUInt64_(Name: String; var Value: UInt64): Boolean;
begin
  Result := Self.ReadParamValueByNameAsUInt64(Name, Value);
end;

function TProfXml.Initialize(): TError;
begin
  Result := 0;
end;

function TProfXml.Load(const FileName: String): TError;
var
  F: TProfFileText;
  Name: String;
  Value: String;
begin
  if (FXmlNode <> 0) then
    Result := -1 //AXmlDocument_LoadFromFile(FXmlDocument, FileName)
  else
  begin
    F := TProfFileText.Create();
    try
      Result := F.Open(FileName);
      if (Result <> 0) then
      begin
        F.Free();
        Exit;
      end;
      while not(F.Eof) do
      begin
        F.ReadLn(Name);
        Name := Copy(Name, 2, Length(Name) - 2);
        F.ReadLn(Value);
        NewParam(Name, Value);
      end;
    finally
      F.Free();
    end;
  end;
end;

function TProfXml.LoadFromXml(Xml: TProfXml): TError;
begin
  Result := -1;
end;

function TProfXml.NewParam(Name, Value: String): Int32;
var
  Param: TParam;
begin
  Param := TParam.Create;
  Param.SetName(Name);
  Param.SetValue(Value);
  Result := AddParam(Param);
end;

function TProfXml.ReadBool(Section, Name: String; var Value: Boolean): TError;
begin
  Result := -1;
end;

function TProfXml.ReadInt32(const Section, Name: APascalString; var Value: AInt32): ABoolean;
begin
  Result := False;
end;

function TProfXml.ReadInt64(const Section, Name: APascalString; var Value: AInt64): ABoolean;
begin
  Result := False;
end;

function TProfXml.ReadParamValueByName(const Name: String; var Value: String): Boolean;
var
  Param: TParam;
begin
  Param := GetParamByName(Name);
  Result := Assigned(Param);
  if not(Result) then Exit;
  Value := Param.GetValue;
end;

function TProfXml.ReadParamValueByNameAsBoolean(const Name: String; var Value: Boolean): Boolean;
var
  S: String;
begin
  Result := ReadParamValueByName(Name, S);
  if not(Result) then Exit;
  Value := (S = 'True');
end;

function TProfXml.ReadParamValueByNameAsDateTime(const Name: APascalString; var Value: TDateTime): Boolean;
var
  S: String;
begin
  if not(ReadParamValueByName(Name, S)) then
  begin
    Result := False;
    Exit;
  end;
  Value := StrToDateTime(S);
end;

function TProfXml.ReadParamValueByNameAsInt32(const Name: String; var Value: Int32): Boolean;
var
  S: String;
begin
  Result := ReadParamValueByName(Name, S);
  if not(Result) then Exit;
  Value := cStrToInt32(S);
end;

function TProfXml.ReadParamValueByNameAsInt64(const Name: APascalString; var Value: Int64): Boolean;
var
  S: String;
begin
  Result := ReadParamValueByName(Name, S);
  if not(Result) then Exit;
  Value := StrToInt(S);
end;

function TProfXml.ReadParamValueByNameAsUInt08(const Name: String; var Value: UInt08): Boolean;
var
  S: String;
begin
  Result := ReadParamValueByName(Name, S);
  if not(Result) then Exit;
  Value := cStrToInt32(S);
end;

function TProfXml.ReadParamValueByNameAsUInt64(const Name: String; var Value: UInt64): Boolean;
var
  S: String;
begin
  Result := ReadParamValueByName(Name, S);
  if not(Result) then Exit;
  Value := cStrToInt32(S);
end;

function TProfXml.ReadStr(Name: String; var Value: String): Boolean;
begin
  Result := ReadString('', Name, Value);
end;

function TProfXml.ReadString(Section, Name: String; var Value: String): Boolean;
begin
  Result := ReadParamValueByName(Name, Value);
end;

function TProfXml.ReadUInt08(Name: String; var Value: UInt08): Boolean;
var
  S: String;
begin
  Result := ReadStr(Name, S);
  if not(Result) then Exit;
  Result := (_StrToUInt08(S, Value) = 0);
end;

function TProfXml.ReadUInt64(Section, Name: String; var Value: UInt64): Boolean;
begin
  Result := False;
end;

function TProfXml.Save(FileName: String): TError;
var
  F: TProfFileText;
  I: Int32;
begin
  F := TProfFileText.Create();
  Result := F.OpenCreate(FileName);
  if Result <> 0 then Exit;
  for I := 0 to High(FParams) do begin
    F.WriteLn('[' + FParams[I].GetName + ']');
    F.WriteLn(FParams[I].GetValue);
  end;
  F.Free;
end;

function TProfXml.SetParamValueByName(Name, Value: String): TError;
var
  Param: TParam;
begin
  Param := GetParamByName(Name);
  if not(Assigned(Param)) then begin
    NewParam(Name, Value);
  end else
    Param.SetValue(Value);
  Result := 0;
end;

function TProfXml.SetParamValueByNameAsBoolean(Name: String; Value: Boolean): TError;
var
  S: String;
begin
  if Value then S := 'True' else S := 'False';
  Result := SetParamValueByName(Name, S);
end;

function TProfXml.SetParamValueByNameAsInt32(Name: String; Value: Int32): TError;
begin
  Result := SetParamValueByName(Name, cInt32ToStr(Value));
end;

function TProfXml.SetParamValueByNameAsUInt08(const Name: APascalString; Value: UInt08): TError;
begin
  Result := SetParamValueByName(Name, cInt32ToStr(Value));
end;

function TProfXml.SetParamValueByNameAsUInt64(const Name: APascalString; Value: UInt64): TError;
begin
  Result := SetParamValueByName(Name, cInt64ToStr(Value));
end;

function TProfXml.WriteBool(Section, Name: String; Value: Boolean): TError;
var
  S: String;
begin
  if Value then S := 'True' else S := 'False';
  Result := SetParamValueByName(Name, S);
end;

function TProfXml.WriteFloat64(Name: String; Value: Float64): TError;
begin
  Result := SetParamValueByName(Name, cFloat64ToStr(Value));
end;

function TProfXml.WriteInt32(Section, Name: String; Value: Int32): TError;
begin
  Result := SetParamValueByName(Name, cInt32ToStr(Value));
end;

function TProfXml.WriteStr(Name, Value: String): TError;
begin
  Result := WriteString('', Name, Value);
end;

function TProfXml.WriteString(Section, Name, Value: String): TError;
begin
  Result := SetParamValueByName(Name, Value);
end;

function TProfXml.WriteUInt32(Name: String; Value: UInt32): TError;
begin
  Result := SetParamValueByName(Name, cUInt32ToStr(Value));
end;

function TProfXml.WriteUInt64(Section, Name: String; Value: UInt64): Boolean;
begin
  Result := False;
end;

end.
 