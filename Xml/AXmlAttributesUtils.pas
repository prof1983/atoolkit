{**
@Abstract(AXmlAttributes functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(29.06.2012)
@LastMod(12.07.2012)
@Version(0.5)
}
unit AXmlAttributesUtils;

interface

uses
  SysUtils,
  ABase, ATypes;

{**
  Возвращает значение атрибута
  AUpperCase - различать большие и маленькие символы?
}
function GetAttribute(var Attributes: TAttributes; const Name: WideString;
    UpperCase: Boolean = False): WideString; deprecated; // Use AXmlAttribures_GetAttribute()

{**
  Установить значение атрибута. Если атрибута нет - создает.
}
function SetAttribute(var Attributes: TAttributes;
    const Name, Value: WideString): AError; deprecated; // Use AXmlAttributes_SetAttribute()

// --- AXmlAttribures ---

function AXmlAttribures_GetAttribute(Attributes: TAttributes;
    const Name: APascalString; UpperCase: ABoolean): APascalString;
function AXmlAttributes_SetAttribute(var Attributes: TAttributes;
    const Name, Value: APascalString): AError;

implementation

function GetAttribute(var Attributes: TAttributes; const Name: WideString;
    UpperCase: Boolean = False): WideString;
var
  I: Integer;
begin
  Result := '';
  if UpperCase then
  begin
    for I := 0 to High(Attributes) do
    begin
      if (Attributes[I].Name = Name) then
      begin
        Result := Attributes[I].Value;
        Exit;
      end;
    end;
  end
  else
  begin
    for I := 0 to High(Attributes) do
    begin
      if AnsiUpperCase(Attributes[I].Name) = AnsiUpperCase(Name) then
      begin
        Result := Attributes[I].Value;
        Exit;
      end;
    end;
  end;
end;

function SetAttribute(var Attributes: TAttributes; const Name, Value: WideString): AError;
var
  I: Integer;
begin
  if (Name = '') then
  begin
    Result := -2;
    Exit;
  end;
  // Поиск атрибута
  for I := 0 to High(Attributes) do
  begin
    if (Attributes[I].Name = Name) then
    begin
      Attributes[I].Value := Value;
      Exit;
    end;
  end;
  // Создание атрибута
  I := Length(Attributes);
  SetLength(Attributes, I + 1);
  Attributes[I].Name := Name;
  Attributes[I].Value := Value;
  Result := 0;
end;

// --- AXmlAttribures ---

function AXmlAttribures_GetAttribute(Attributes: TAttributes; const Name: APascalString;
    UpperCase: ABoolean): APascalString;
begin
  Result := GetAttribute(Attributes, Name, UpperCase);
end;

function AXmlAttributes_SetAttribute(var Attributes: TAttributes;
    const Name, Value: APascalString): AError;
begin
  Result := SetAttribute(Attributes, Name, Value);
end;

end.
