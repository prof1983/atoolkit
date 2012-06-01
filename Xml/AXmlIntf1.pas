{**
@Abstract(Интерфейсы XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.10.2005)
@LastMod(25.04.2012)
@Version(0.5)
}
unit AXmlIntf1;

interface

uses
  Windows, ActiveX, Classes,
  {$IFDEF VER170}Variants,{$ENDIF}
  {$IFNDEF VER170}StdVCL,{$ENDIF}
  Graphics;
  
type
  IProfXmlCollection = interface;
  IProfXmlDocument = interface;
  IProfXmlNode = interface;

  IProfXmlCollection = interface
    ['{6FB37F9F-079B-4EE8-A0BC-0FDCF6245E67}']
    function Count: Integer;
    function Get_Node(Index: Integer): IProfXmlNode;
    property Nodes[Index: Integer]: IProfXmlNode read Get_Node;
  end;

  IProfXmlDocument = interface
    ['{F4BBD4C5-FEEE-4B77-950A-1366DC23C51F}']
  end;

  IProfXmlNode = interface
    ['{A14E6506-EB99-492C-B18B-C71C858FE94A}']
    function Attributes_Count: Integer;
    // Вернуть значение атрибута
    function Get_Attribute(Name: WideString): WideString;
    function Get_Attribute_Name(Index: Integer): WideString;
    function Get_Attribute_Value(Index: Integer): WideString;
    // Возвращает коллекцию вложеных нодов
    function Get_Collection: IProfXmlCollection;
    function Get_NodeName: WideString;
    function Get_NodeValue: WideString;
    // Вернуть в виде строки со всеми нодами
    function Get_Xml: WideString;
    // Установить/Создать атрибут
    procedure Set_Attribute(Name, Value: WideString);
    procedure Set_NodeName(Value: WideString);
    procedure Set_NodeValue(Value: WideString);
    // Прочитать из строки со всеми нодами
    procedure Set_Xml(const Value: WideString);

    // Атрибуты
    property Attributes[Name: WideString]: WideString read Get_Attribute write Set_Attribute;
    property Attribute_Name[Index: Integer]: WideString read Get_Attribute_Name;
    property Attribute_Value[Index: Integer]: WideString read Get_Attribute_Value;
    // Коллекция вложеных нодов
    property Collection: IProfXmlCollection read Get_Collection;
    property NodeName: WideString read Get_NodeName write Set_NodeName;
    property NodeValue: WideString read Get_NodeValue write Set_NodeValue;
    // В виде строки со всеми нодами
    property Xml: WideString read Get_Xml write Set_Xml;
  end;


implementation

end.
