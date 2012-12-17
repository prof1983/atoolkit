{**
@Abstract AConfig functions
@Author Prof1983 <prof1983@ya.ru>
@Created 09.07.2012
@LastMod 17.12.2012
}
unit AConfigUtils;

interface

uses
  ABase, AXmlNodeUtils;

function AConfig_Free(Config: AConfig): AError;

function AConfig_GetChildNodeByName(Config: AConfig; const Name: APascalString): AConfig;

function AConfig_ReadBool(Config: AConfig; const Name: APascalString;
    out Value: ABoolean): AError;

function AConfig_ReadInt(Config: AConfig; const Name: APascalString;
    out Value: AInt): AError;

function AConfig_ReadInt32(Config: AConfig; const Name: APascalString;
    out Value: AInt32): AError;

function AConfig_ReadInt32Def(Config: AConfig; const Name: APascalString;
    DefValue: AInt32): AInt32;

function AConfig_ReadString(Config: AConfig; const Name: APascalString;
    out Value: APascalString): AError;

function AConfig_WriteBool(Config: AConfig; const Name: APascalString;
    Value: ABool): AError;

function AConfig_WriteInt(Config: AConfig; const Name: APascalString;
    Value: AInt): AError;

function AConfig_WriteInt32(Config: AConfig; const Name: APascalString;
    Value: AInt32): AError;

function AConfig_WriteString(Config: AConfig; const Name,
    Value: APascalString): AError;

implementation

function AConfig_Free(Config: AConfig): AError;
begin
  Result := AXmlNode_Free(Config);
end;

function AConfig_GetChildNodeByName(Config: AConfig; const Name: APascalString): AConfig;
begin
  Result := AXmlNode_GetChildNodeByName(Config, Name);
end;

function AConfig_ReadBool(Config: AConfig; const Name: APascalString;
    out Value: ABoolean): AError;
begin
  Result := AXmlNode_ReadBool(Config, Name, Value);
end;

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

function AConfig_WriteBool(Config: AConfig; const Name: APascalString;
    Value: ABool): AError;
begin
  Result := AXmlNode_WriteBool(Config, Name, Value);
end;

function AConfig_WriteInt(Config: AConfig; const Name: APascalString;
    Value: AInt): AError;
begin
  Result := AXmlNode_WriteInt(Config, Name, Value);
end;

function AConfig_WriteInt32(Config: AConfig; const Name: APascalString;
    Value: AInt32): AError;
begin
  Result := AXmlNode_WriteInt32(Config, Name, Value);
end;

function AConfig_WriteString(Config: AConfig; const Name,
    Value: APascalString): AError;
begin
  Result := AXmlNode_WriteString(Config, Name, Value);
end;

end.
