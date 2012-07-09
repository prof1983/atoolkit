{**
@Abstract(AConfig functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.07.2012)
@LastMod(09.07.2012)
@Version(0.5)
}
unit AConfigUtils;

interface

uses
  ABase, AXmlNodeUtils;

function AConfig_ReadInt(Config: AConfig; const Name: APascalString;
    out Value: AInt): AError;

function AConfig_ReadInt32(Config: AConfig; const Name: APascalString;
    out Value: AInt32): AError;

function AConfig_ReadInt32Def(Config: AConfig; const Name: APascalString;
    DefValue: AInt32): AInt32;

function AConfig_ReadString(Config: AConfig; const Name: APascalString;
    out Value: APascalString): AError;

implementation

function AConfig_ReadInt(Config: AConfig; const Name: APascalString;
    out Value: AInt): AError;
begin
  Result := AXmlNode_ReadInt(Config, Name, Value);
end;

function AConfig_ReadInt32(Config: AConfig; const Name: APascalString;
    out Value: AInt32): AError;
begin
  Result := AXmlNode_ReadInt32(Config, Name, Value);
end;

function AConfig_ReadInt32Def(Config: AConfig; const Name: APascalString;
    DefValue: AInt32): AInt32;
begin
  Result := AXmlNode_ReadInt32Def(Config, Name, DefValue);
end;

function AConfig_ReadString(Config: AConfig; const Name: APascalString;
    out Value: APascalString): AError;
begin
  Result := AXmlNode_ReadString(Config, Name, Value);
end;

end.
