{**
@Abstract(Узел)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.08.2007)
@LastMod(27.04.2012)
@Version(0.5)
}
unit ANode1;

interface

uses
  ACollection, AArrayList;

type
  TItemType = Integer;
const
  NoneItemType      = 0; // Нет
  UnknownItemType   = 1; // Не известно
  AttributeItemType = 2; // атрибут
  TextItemType      = 3; // строка текста
  CommentItemType   = 4; // комментарий <!--- --->
  NodeItemType      = 5; // узел

type
  IItem = interface
    function GetNodeType(): TItemType;

    property NodeType: TItemType read GetNodeType;
  end;

type
  INode = interface(IItem)
    function GetChilds(): IACollection2;
    function GetNodeName(): WideString;
    procedure SetNodeName(Name: WideString);

    property Childs: IACollection2 read GetChilds;
    property NodeName: WideString read GetNodeName write SetNodeName;
  end;

type
  ITextNode = interface(IItem)
    function GetValue(): WideString;
    procedure SetValue(Value: WideString);

    property Value: WideString read GetValue write SetValue;
  end;

type
  TItem = class(TInterfacedObject, IItem)
  private
    FNodeType: TItemType;
  protected
    function GetNodeType(): TItemType;
  public
    constructor Create(NodeType: TItemType);
  public
    property NodeType: TItemType read FNodeType;
  end;

type
  TAttributeItem = class(TItem)
  private
    FName: WideString;
    FValue: WideString;
  public
    constructor Create(Name, Value: WideString);
  public
    property Name: WideString read FName write FName;
    property Value: WideString read FValue write FValue;
  end;

type
  TNodeItem = class(TItem, INode)
  private
    FChilds: TArrayList;
    FNodeName: WideString;
  protected
    function GetChilds(): IACollection2;
    function GetNodeName(): WideString;
    procedure SetNodeName(Name: WideString);
  public
    constructor Create(NodeName: WideString);
  public
    property Childs: TArrayList read FChilds;
    property NodeName: WideString read FNodeName write FNodeName;
  end;

type
  TTextItem = class(TItem)
  private
    FValue: WideString;
  protected
    function GetValue(): WideString;
    procedure SetValue(Value: WideString);
  public
    constructor Create(Value: WideString);
  public
    property Value: WideString read FValue write FValue;
  end;

implementation

{ TAttributeItem }

constructor TAttributeItem.Create(Name, Value: WideString);
begin
  inherited Create(AttributeItemType);
  FName := Name;
  FValue := Value;
end;

{ TItem }

constructor TItem.Create(NodeType: TItemType);
begin
  inherited Create();
  FNodeType := NodeType;
end;

function TItem.GetNodeType(): TItemType;
begin
  Result := FNodeType;
end;

{ TNodeItem }

constructor TNodeItem.Create(NodeName: WideString);
begin
  inherited Create(NodeItemType);
  FNodeName := NodeName;
  FChilds := TArrayList.Create();
end;

function TNodeItem.GetChilds(): IACollection2;
begin
  Result := FChilds;
end;

function TNodeItem.GetNodeName(): WideString;
begin
  Result := FNodeName;
end;

procedure TNodeItem.SetNodeName(Name: WideString);
begin
  FNodeName := Name;
end;

{ TTextItem }

constructor TTextItem.Create(Value: WideString);
begin
  inherited Create(TextItemType);
  FValue := Value;
end;

function TTextItem.GetValue(): WideString;
begin
  Result := FValue;
end;

procedure TTextItem.SetValue(Value: WideString);
begin
  FValue := Value;
end;

end.
