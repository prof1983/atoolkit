{**
@Abstract Класс работы с XML нодами
@Author Prof1983 <prof1983@ya.ru>
@Created 07.03.2007
@LastMod 23.11.2012
}
unit AXmlNodeIntf;

interface

uses
  XmlIntf,
  ABase, ANodeIntf;

type //** @abstract(Интерфейс работы с нодами XML)
  IProfXmlNode = ANodeIntf.IProfNode;

  IProfXmlNode1 = interface
    function Attributes_Count: Integer;
    // Вернуть значение атрибута
    function Get_Attribute(const Name: WideString): WideString;
    function Get_Attribute_Name(Index: Integer): WideString;
    function Get_Attribute_Value(Index: Integer): WideString;
    // Возвращает коллекцию вложеных нодов
    function Get_Collection(): AXmlNodeCollection;
    function Get_NodeName(): WideString;
    function Get_NodeValue(): WideString;
    // Вернуть в виде строки со всеми нодами
    function Get_Xml(): WideString;
    // Установить/Создать атрибут
    procedure Set_Attribute(const Name, Value: WideString);
    procedure Set_NodeName(const Value: WideString);
    procedure Set_NodeValue(const Value: WideString);
    // Прочитать из строки со всеми нодами
    procedure Set_Xml(const Value: WideString);

    // Атрибуты
    property Attributes[const Name: WideString]: WideString read Get_Attribute write Set_Attribute;
    property Attribute_Name[Index: Integer]: WideString read Get_Attribute_Name;
    property Attribute_Value[Index: Integer]: WideString read Get_Attribute_Value;
    // Коллекция вложеных нодов
    property Collection: AXmlNodeCollection read Get_Collection;
    property NodeName: WideString read Get_NodeName write Set_NodeName;
    property NodeValue: WideString read Get_NodeValue write Set_NodeValue;
    // В виде строки со всеми нодами
    property Xml: WideString read Get_Xml write Set_Xml;
  end;

  IProfXmlNode2 = interface
    function GetXmlB(): WideString;
    // Возврвщает вложеные ноды в виде "<node1>..</node1>...<noden>..</noden>"
    procedure SetXmlB(const Value: WideString); safecall;

    function GetAsString(): WideString;

    function GetValueAsBool(var Value: WordBool): WordBool; safecall;
    function GetValueAsDateTime(var Value: TDateTime): WordBool; safecall;
    function GetValueAsInt32(var Value: Int32): WordBool; safecall;
    function GetValueAsInt64(var AValue: Int64): WordBool; safecall;
    function GetValueAsInteger(var AValue: Integer): WordBool; safecall;
    function GetValueAsString(var Value: WideString): WordBool; safecall;
    function GetValueAsUInt08(var Value: AUInt08): WordBool; safecall;
    function GetValueAsUInt64(var Value: UInt64): WordBool; safecall;

    procedure SetAsString(const Value: WideString);

    function SetValueAsBool(Value: WordBool): WordBool; safecall;
    function SetValueAsFloat64(Value: AFloat64): WordBool; safecall;
    function SetValueAsInt32(AValue: Int32): WordBool; safecall;
    function SetValueAsString(const AValue: WideString): WordBool; safecall;
    function SetValueAsUInt08(AValue: AUInt08): WordBool; safecall;
    function SetValueAsUInt64(AValue: UInt64): WordBool; safecall;

    function ReadBool(const AName: WideString; var Value: WordBool): WordBool; safecall;
    function ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool; safecall;
    function ReadFloat64(const AName: WideString; var Value: AFloat64): WordBool; safecall;
    function ReadInt08(const AName: WideString; var Value: AInt08): WordBool; safecall;
    function ReadInt16(const AName: WideString; var Value: Int16): WordBool; safecall;
    function ReadInt32(const AName: WideString; var Value: Int32): WordBool; safecall;
    function ReadInt64(const AName: WideString; var AValue: Int64): WordBool; safecall;
    function ReadInteger(const AName: WideString; var AValue: Integer): WordBool; safecall;
    function ReadString(const AName: WideString; var Value: WideString): WordBool; safecall;
    function ReadUInt08(const AName: WideString; var Value: AUInt08): WordBool; safecall;
    function ReadUInt16(const AName: WideString; var Value: UInt16): WordBool; safecall;
    function ReadUInt32(const AName: WideString; var Value: UInt32): WordBool; safecall;
    function ReadUInt64(const AName: WideString; var Value: AUInt64): WordBool; safecall;
    //function ReadWideString(const AName: WideString; var Value: WideString): WordBool; safecall; - Use ReadString()

    function WriteBool(const AName: WideString; Value: WordBool): WordBool; safecall;
    function WriteDateTime(const AName: WideString; AValue: TDateTime): WordBool; safecall;
    function WriteFloat64(const AName: WideString; Value: AFloat64): WordBool; safecall;
    function WriteInt32(const AName: WideString; Value: Int32): WordBool; safecall;
    function WriteInt64(const AName: WideString; Value: Int64): WordBool; safecall;
    function WriteInteger(const AName: WideString; Value: Integer): WordBool; safecall;
    function WriteString(const AName, Value: WideString): WordBool; safecall;
    function WriteUInt08(const AName: WideString; AValue: AUInt08): WordBool; safecall;
    function WriteUInt64(const AName: WideString; AValue: UInt64): WordBool; safecall;
    function WriteXml(const AName, Value: WideString): WordBool; safecall;

    function GetNodeByName(const AName: WideString): IXmlNode; safecall;

    property AsString: WideString read GetAsString write SetAsString;

    property XmlB: WideString read GetXmlB write SetXmlB;
  end;

  //IProfXmlNode2006 = IProfXmlNode1+IProfXmlNode2;

  {**
    Интерфейс работы с нодами XML.
    Не рекомендуется использовать.
  }
  IProfXmlNodeA = interface
    function GetAsBool(): WordBool; safecall;
    function GetAsDateTime(): TDateTime; safecall;
    function GetAsFloat32(): AFloat32; safecall;
    function GetAsFloat64(): AFloat64; safecall;
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
    function SetValueAsFloat64(Value: AFloat64): WordBool; safecall;
    function SetValueAsInt32(AValue: Integer): WordBool; safecall;
    function SetValueAsString(const AValue: WideString): WordBool; safecall;
    function SetValueAsUInt08(AValue: Byte): WordBool; safecall;
    //function SetValueAsUInt64(AValue: UInt64): WordBool; safecall;

    function ReadBool(const AName: WideString; var Value: WordBool): WordBool; safecall;
    function ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool; safecall;
    function ReadFloat64(const AName: WideString; var Value: AFloat64): WordBool; safecall;
    function ReadInt08(const AName: WideString; var Value: AInt08): WordBool; safecall;
    function ReadInt16(const AName: WideString; var Value: Int16): WordBool; safecall;
    function ReadInt32(const AName: WideString; var Value: Int32): WordBool; safecall;
    function ReadInt64(const AName: WideString; var AValue: Int64): WordBool; safecall;
    //function ReadInteger(const AName: WideString; var AValue: Integer): WordBool; safecall;
    function ReadString(const AName: WideString; var Value: WideString): WordBool; safecall;
    function ReadUInt08(const AName: WideString; var Value: AUInt08): WordBool; safecall;
    function ReadUInt16(const AName: WideString; var Value: UInt16): WordBool; safecall;
    function ReadUInt32(const AName: WideString; var Value: UInt32): WordBool; safecall;
    //function ReadUInt64(const AName: WideString; var Value: UInt64): WordBool; safecall;

    function WriteBool(const AName: WideString; Value: WordBool): WordBool; safecall;
    function WriteDateTime(const AName: WideString; AValue: TDateTime): WordBool; safecall;
    function WriteFloat64(const AName: WideString; Value: AFloat64): WordBool; safecall;
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

implementation

end.
