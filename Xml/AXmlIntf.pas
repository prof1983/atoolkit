{**
@Abstract(Интерфейсы работы с XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.02.2007)
@LastMod(25.05.2012)
@Version(0.5)
}
unit AXmlIntf;

interface

{uses
  uProfIntf;}

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

type
  IProfXmlNodeA = interface;

  //** @abstract(Интерфейс работы с XML документом)
  IProfXmlDocumentA = interface
    function GetDocumentElement(): IProfXmlNodeA; safecall;
    function GetFileName(): WideString; safecall;
    procedure SetFileName(const Value: WideString); safecall;

    procedure Close(); safecall;
    function LoadFromFile(const FileName: WideString): WordBool; safecall;
    function SaveToFile(const FileName: WideString): WordBool; safecall;
    function Open(): Integer; safecall;

    property DocumentElement: IProfXmlNodeA read GetDocumentElement;
    property FileName: WideString read GetFileName write SetFileName;
  end;

  //** @abstract(Интерфейс работы с нодами XML)
  IProfXmlNodeA = interface
    function GetAsBool(): WordBool; safecall;
    function GetAsDateTime(): TDateTime; safecall;
    function GetAsFloat32(): Float32; safecall;
    function GetAsFloat64(): Float64; safecall;
    function GetAsInt32(): Integer; safecall;
    function GetAsInt64(): Integer; safecall;
    function GetAsString(): WideString; safecall;

    function GetValueAsBool(var Value: WordBool): WordBool; safecall;
    function GetValueAsDateTime(var Value: TDateTime): WordBool; safecall;
    function GetValueAsInt32(var Value: Integer): WordBool; safecall;
    function GetValueAsInt64(var AValue: Int64): WordBool; safecall;
    //function GetValueAsInteger(var AValue: Integer): WordBool; safecall;
    function GetValueAsString(var Value: WideString): WordBool; safecall;
    function GetValueAsUInt08(var Value: Byte): WordBool; safecall;
    //function GetValueAsUInt64(var Value: UInt64): WordBool; safecall;

    procedure SetAsString(const Value: WideString); safecall;

    function SetValueAsBool(Value: WordBool): WordBool; safecall;
    function SetValueAsFloat64(Value: Float64): WordBool; safecall;
    function SetValueAsInt32(AValue: Integer): WordBool; safecall;
    function SetValueAsString(const AValue: WideString): WordBool; safecall;
    function SetValueAsUInt08(AValue: Byte): WordBool; safecall;
    //function SetValueAsUInt64(AValue: UInt64): WordBool; safecall;

    function ReadBool(const AName: WideString; var Value: WordBool): WordBool; safecall;
    function ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool; safecall;
    function ReadFloat64(const AName: WideString; var Value: Float64): WordBool; safecall;
    function ReadInt08(const AName: WideString; var Value: Int08): WordBool; safecall;
    function ReadInt16(const AName: WideString; var Value: Int16): WordBool; safecall;
    function ReadInt32(const AName: WideString; var Value: Int32): WordBool; safecall;
    function ReadInt64(const AName: WideString; var AValue: Int64): WordBool; safecall;
    //function ReadInteger(const AName: WideString; var AValue: Integer): WordBool; safecall;
    function ReadString(const AName: WideString; var Value: WideString): WordBool; safecall;
    function ReadUInt08(const AName: WideString; var Value: UInt08): WordBool; safecall;
    function ReadUInt16(const AName: WideString; var Value: UInt16): WordBool; safecall;
    function ReadUInt32(const AName: WideString; var Value: UInt32): WordBool; safecall;
    //function ReadUInt64(const AName: WideString; var Value: UInt64): WordBool; safecall;

    function WriteBool(const AName: WideString; Value: WordBool): WordBool; safecall;
    function WriteDateTime(const AName: WideString; AValue: TDateTime): WordBool; safecall;
    function WriteFloat64(const AName: WideString; Value: Float64): WordBool; safecall;
    function WriteInt32(const AName: WideString; Value: Int32): WordBool; safecall;
    function WriteInt64(const AName: WideString; Value: Int64): WordBool; safecall;
    //function WriteInteger(const AName: WideString; Value: Integer): WordBool; safecall;
    function WriteString(const AName, Value: WideString): WordBool; safecall;
    //function WriteUInt08(const AName: WideString; AValue: UInt08): WordBool; safecall;
    //function WriteUInt64(const AName: WideString; AValue: UInt64): WordBool; safecall;
    function WriteXml(const AName, Value: WideString): WordBool; safecall;

    function GetNodeByName(const AName: WideString): IProfXmlNodeA; safecall;

    property AsString: WideString read GetAsString write SetAsString;
  end;

{type
  IProfXmlReader = IProfReader;
  IProfXmlWriter = IProfWriter;}

type
  IProfXmlNodeB = interface;

  //** @abstract(Интерфейс работы с XML документом)
  IProfXmlDocumentB = interface
    function GetDocumentElement(): IProfXmlNodeB; safecall;
    function GetFileName(): WideString; safecall;
    procedure SetFileName(const Value: WideString); safecall;

    procedure Close(); safecall;
    function Open(): WordBool; safecall;

    property DocumentElement: IProfXmlNodeB read GetDocumentElement;
    property FileName: WideString read GetFileName write SetFileName;
  end;

  //** @abstract(Интерфейс работы с нодами XML)
  IProfXmlNodeB = interface
    function GetAsBool(): WordBool; safecall;
    function GetAsDateTime(): TDateTime; safecall;
    function GetAsFloat32(): Float32; safecall;
    function GetAsFloat64(): Float64; safecall;
    function GetAsInt32(): Integer; safecall;
    function GetAsInt64(): Integer; safecall;
    function GetAsString(): WideString; safecall;

    function GetValueAsBool(var Value: WordBool): WordBool; safecall;
    function GetValueAsDateTime(var Value: TDateTime): WordBool; safecall;
    function GetValueAsInt32(var Value: Integer): WordBool; safecall;
    function GetValueAsInt64(var AValue: Int64): WordBool; safecall;
    function GetValueAsInteger(var AValue: Integer): WordBool; safecall;
    function GetValueAsString(var Value: WideString): WordBool; safecall;
    function GetValueAsUInt08(var Value: Byte): WordBool; safecall;
    //function GetValueAsUInt64(var Value: UInt64): WordBool; safecall;

    procedure SetAsString(const Value: WideString); safecall;

    function SetValueAsBool(Value: WordBool): WordBool; safecall;
    function SetValueAsFloat64(Value: Float64): WordBool; safecall;
    function SetValueAsInt32(AValue: Integer): WordBool; safecall;
    function SetValueAsString(const AValue: WideString): WordBool; safecall;
    function SetValueAsUInt08(AValue: Byte): WordBool; safecall;
    //function SetValueAsUInt64(AValue: UInt64): WordBool; safecall;

//    function WriteXml(const AName, Value: WideString): WordBool; safecall;

    function GetNodeByName(const AName: WideString): IProfXmlNodeA; safecall;

    property AsString: WideString read GetAsString write SetAsString;
  end;

type
  //** @abstract(Интерфейс работы с аьрибутами XML)
  IProfXmlAttributes = interface
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
  end;

implementation

end.
