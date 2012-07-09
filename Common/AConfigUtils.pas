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

function AConfig_ReadInt32(Config: AConfig; const Name: APascalString; out Value: AInt32): AError;

implementation

function AConfig_ReadInt32(Config: AConfig; const Name: APascalString; out Value: AInt32): AError;
begin
  Result := AXmlNode_ReadInt32(Config, Name, Value);
end;

end.
