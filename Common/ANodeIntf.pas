{**
@Abstract(Общие интерфейсы для всех проектов)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.02.2007)
@LastMod(21.06.2012)
@Version(0.5)

История версий
0.0.2.0 - 03.06.2007 - Сделал IProfNodes наследником от IProfCollection
}
unit ANodeIntf;

interface

uses
  AAttributesIntf, AEntityIntf;

type
  IProfNodes = interface;

  IProfNode = interface(IANamedEntity)
    function GetAttributes(): IProfAttributes; safecall;
    function GetChildNodes(): IProfNodes; safecall;

    property Attributes: IProfAttributes read GetAttributes;
    property ChildNodes: IProfNodes read GetChildNodes;
  end;

  IProfNodes = interface
    function GetNodeById(Id: Int64): IProfNode; safecall;
    function GetNodeByIndex(Index: Integer): IProfNode; safecall;
    function GetNodeByName(const Name: WideString): IProfNode; safecall;
    function GetNodeCount(): Integer; safecall;

    function Add(Node: IProfNode): Integer; safecall;
    function Delete(Index: Integer): Integer; safecall;
    function Insert(Index: Integer; Node: IProfNode): Integer; safecall;
    function New(const Name: WideString): IProfNode; safecall;

    property Count: Integer read GetNodeCount;
    property NodeById[Id: Int64]: IProfNode read GetNodeById;
    property NodeByIndex[Index: Integer]: IProfNode read GetNodeByIndex;
    property NodeByName[const Name: WideString]: IProfNode read GetNodeByName;
    property NodeCount: Integer read GetNodeCount;
  end;

type
  {** @abstract(Интерфейс чтения и записи значений, работа с вложеными нодами, работа с атрибутами)
    Используется для любых элементов любого документа.
    Если какие-либо методы или свойства не могут быть использованы в том или ином
    документе, то они должны быть реализованы в любом случае и возвращать
    результат-ошибку и вызывать Exception или ничего не делать.
  }
  IProfNode20070401 = interface
    function GetAsString(): WideString; safecall;

    //** Возвращает объект работы с атрибутами
    function GetAttributes(): IProfAttributes; safecall;
    //** Получить вложеный нод по индексу
    function GetNodeByIndex(AIndex: Integer): IProfNode; safecall;
    //** Получить вложеный нод по имени
    function GetNodeByName(const Name: WideString): IProfNode; safecall;
    //** Возвращает колличество вложеных нодов
    function GetNodeCount(): Integer; safecall;
    //** Получить имя нода
    function GetNodeName(): WideString; safecall;
    function GetXmlString(): WideString; safecall;
    procedure SetXmlString(const Value: WideString); safecall;

    function ReadBool(const Name: WideString; var Value: WordBool): WordBool; safecall;
    function ReadBoolDef(const Name: WideString; DefValue: WordBool): WordBool; safecall;
    function ReadDateTime(const Name: WideString; var Value: TDateTime): WordBool; safecall;
    function ReadDateTimeDef(const Name: WideString; DefValue: TDateTime): TDateTime; safecall;
    function ReadFloat64(const Name: WideString; var Value: Double): WordBool; safecall;
    function ReadFloat64Def(const Name: WideString; DefValue: Double): Double; safecall;
    function ReadInt32(const Name: WideString; var Value: Integer): WordBool; safecall;
    function ReadInt32Def(const Name: WideString; DefValue: Integer): Integer; safecall;
    function ReadInt64(const Name: WideString; var Value: Int64): WordBool; safecall;
    function ReadInt64Def(const Name: WideString; DefValue: Int64): Int64; safecall;
    function ReadString(const Name: WideString; var Value: WideString): WordBool; safecall;
    function ReadStringDef(const Name: WideString; const DefValue: WideString): WideString; safecall;
    function WriteBool(const Name: WideString; Value: WordBool): WordBool; safecall;
    function WriteDateTime(const Name: WideString; Value: TDateTime): WordBool; safecall;
    function WriteFloat64(const Name: WideString; Value: Double): WordBool; safecall;
    function WriteInt32(const Name: WideString; Value: Integer): WordBool; safecall;
    function WriteInt64(const Name: WideString; Value: Int64): WordBool; safecall;
    function WriteString(const Name, Value: WideString): WordBool; safecall;

    //** Значение нода в виде строки
    property AsString: WideString read GetAsString;

    //** Атрибуты
    property Attributes: IProfAttributes read GetAttributes;
    //** Вложеные ноды по индексу
    property NodeByIndex[AIndex: Integer]: IProfNode read GetNodeByIndex;
    //** Вложеные ноды по имени
    property NodeByName[const Name: WideString]: IProfNode read GetNodeByName;
    //** Колличество вложеных нодов
    property NodeCount: Integer read GetNodeCount;
    //** Имя нода
    property NodeName: WideString read GetNodeName;
    {** В ввиде одной строки XML со всеми свожеными нодами
      Пример: <node1 atr1="atrValue1">Value1<node2 atr2="atrValue2">Value2</node2></node1>
    }
    property Xml: WideString read GetXmlString write SetXmlString;
  end;

// -----------------------------------------------------------------------------

//type
  //IProfLogNode = IProfNode; -> ProfLogNodeIntf.IProfLogNode
  //IProfLogNodes = IProfNodes; -> ProfLogNodeIntf.IProfLogNodes

implementation

end.
