{**
@Abstract(Интерфейсы работы с XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.02.2007)
@LastMod(02.07.2012)
@Version(0.5)
}
unit AXmlIntf;

interface

type
  Char08  = Char;
  Char16  = WideChar;
  SByte = ShortInt;
  Float32  = Single;
  Float64  = Double;
  Int08 = SByte;
  Int16 = SmallInt;
  Int32 = LongInt;
  //Int64 = Int64;
  UInt08 = Byte;
  UInt16 = Word;
  UInt32 = LongWord;
  IntPtr = Int32;
  UIntPtr = UInt32;

{type
  IProfXmlReader = IProfReader;
  IProfXmlWriter = IProfWriter;}

  //** @abstract(Интерфейс работы с аьрибутами XML)
  (*IProfXmlAttributes = interface
//    {function Attributes_Count(): Integer; safecall;
//    // Вернуть значение атрибута
//    function Get_Attribute(const Name: WideString): WideString; safecall;
//    function Get_Attribute_Name(Index: Integer): WideString; safecall;
//    function Get_Attribute_Value(Index: Integer): WideString; safecall;}
//    // Возвращает коллекцию вложеных нодов
//    //function Get_Collection(): IProfXmlNodeCollection; safecall;
//    {function Get_NodeName(): WideString; safecall;
//    function Get_NodeValue(): WideString; safecall;
//    // Вернуть в виде строки со всеми нодами
//    function Get_Xml(): WideString; safecall;}
//    function GetXmlB(): WideString; safecall;
//    // Установить/Создать атрибут
//    {procedure Set_Attribute(const Name, Value: WideString); safecall;
//    procedure Set_NodeName(const Value: WideString); safecall;
//    procedure Set_NodeValue(const Value: WideString); safecall;
//    // Прочитать из строки со всеми нодами
//    procedure Set_Xml(const Value: WideString); safecall;}
//    // Возврвщает вложеные ноды в виде "<node1>..</node1>...<noden>..</noden>"
//    procedure SetXmlB(const Value: WideString); safecall;
//    {// Атрибуты
//    property Attributes[const Name: WideString]: WideString read Get_Attribute write Set_Attribute;
//    property Attribute_Name[Index: Integer]: WideString read Get_Attribute_Name;
//    property Attribute_Value[Index: Integer]: WideString read Get_Attribute_Value;}
//    // Коллекция вложеных нодов
//    //property Collection: IProfXmlNodeCollection read Get_Collection;
//    {property NodeName: WideString read Get_NodeName write Set_NodeName;
//    property NodeValue: WideString read Get_NodeValue write Set_NodeValue;
//    // В виде строки со всеми нодами
//    property Xml: WideString read Get_Xml write Set_Xml;}
//    property XmlB: WideString read GetXmlB write SetXmlB;
  end;*)

implementation

end.
