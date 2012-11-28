{**
@Abstract AXmlAttributes functions
@Author Prof1983 <prof1983@ya.ru>
@Created 29.06.2012
@LastMod 28.11.2012
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

function AXmlAttributes_GetAttributeP(const Attributes: TAttributes;
    const Name: APascalString; UpperCase: ABoolean): APascalString;

function AXmlAttributes_SetAttributeP(var Attributes: TAttributes;
    const Name, Value: APascalString): AError;

// --- Deprecated ---

function AXmlAttribures_GetAttribute(const Attributes: TAttributes;
    const Name: APascalString; UpperCase: ABoolean): APascalString; deprecated; // Use AXmlAttributes_GetAttributeP()

function AXmlAttributes_SetAttribute(var Attributes: TAttributes;
    const Name, Value: APascalString): AError; deprecated; // Use AXmlAttributes_SetAttributeP()

implementation

function GetAttribute(var Attributes: TAttributes; const Name: WideString;
    UpperCase: Boolean = False): WideString;
begin
  Result := AXmlAttributes_GetAttributeP(Attributes, Name, UpperCase);
end;

function SetAttribute(var Attributes: TAttributes; const Name, Value: WideString): AError;
begin
  Result := AXmlAttributes_SetAttributeP(Attributes, Name, Value);
end;

// --- AXmlAttribures ---

function AXmlAttribures_GetAttribute(const Attributes: TAttributes;
    const Name: APascalString; UpperCase: ABoolean): APascalString;
begin
  Result := AXmlAttributes_GetAttributeP(Attributes, Name, UpperCase);
end;

function AXmlAttributes_GetAttributeP(const Attributes: TAttributes; const Name: APascalString;
    UpperCase: ABoolean): APascalString;
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

function AXmlAttributes_SetAttribute(var Attributes: TAttributes;
    const Name, Value: APascalString): AError;
begin
  Result := AXmlAttributes_SetAttributeP(Attributes, Name, Value);
end;

function AXmlAttributes_SetAttributeP(var Attributes: TAttributes;
    const Name, Value: APascalString): AError;
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
      Result := 1;
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

end.
