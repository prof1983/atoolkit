{**
@Abstract(Работа с XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.10.2005)
@LastMod(28.06.2012)
@Version(0.5)
}
unit AXml20060314;

{DEFINE XML2}

interface

// TODO: AXmlIntf1 -> XmlIntf.pas

uses
  Classes, ComObj, SysUtils,
  {$IFDEF XML2}
  MSXmlDom, Variants, XmlDoc, XmlDom, XmlIntf,
  {$ENDIF}
  ATypes, AXml2007, AXmlDocumentIntf;

{$IFDEF XML2}
type // ------------------------------------------------------------------------
  //TProfXmlNode2 = class;

  TProfXmlDocument2 = class(TInterfacedObject, IProfXmlDocument2006, IXmlDocument)
  private
    FAddToLog: TAddToLog;
    FDocument: TXmlDocument;
    FDocumentElement: AProfXmlNode2;
  public // IProfDocument
    procedure CloseDocument(); safecall;
    function GetIsOpened(): WordBool; safecall;
    function OpenDocument(): TProfError; safecall;
  public // IProfXmlDocument
    function GetDocumentElement(): AProfXmlNode2;
    function GetFileName(): WideString;
    function LoadFromFile(const FileName: WideString): WordBool;
    function SaveToFile(const AFileName: WideString): WordBool;
    procedure SetFileName(const Value: WideString);
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
    function LoadFromString(const Value: WideString): WordBool;
    property OnAddToLog: TAddToLog read FAddToLog write FAddToLog;
    function SaveToString(var Value: WideString): Boolean;
  public
    constructor Create(const AFileName: WideString = ''; AAddToLog: TAddToLog = nil);
    procedure Free();
  public
    property Document: TXmlDocument read FDocument implements IXMLDocument;
    property DocumentElement: AProfXmlNode2 read GetDocumentElement;
  end;

  TProfXmlNode2 = class(TInterfacedObject, IXmlNode)
  private
    FNode: IXmlNode;
    function GetAsString: WideString;
    function GetCollection: IXmlNodeCollection;
    function GetNodeName: WideString;
    function GetNodeValue: OleVariant;
    function Get_Xml: WideString;
    procedure SetNodeName(const Value: WideString);
    procedure SetNodeValue(Value: OleVariant);
    procedure Set_Xml(const Value: WideString);
    function Get_Attribute(Name: WideString): WideString;
    procedure Set_Attribute(Name, Value: WideString);
  public
    function AddFromXml(Xml: TProfXmlNode2): TError;
    constructor Create(ANode: IXmlNode);
    function GetCountNodes: Integer;
    function GetNode(Index: Integer): TProfXmlNode2;
    function GetNodeByName(const AName: WideString): TProfXmlNode2;
    function GetXmlB: WideString;
    function LoadFromXml(Xml: TProfXmlNode2): WordBool;
    function NewNode(const ANodeName: WideString): TProfXmlNode2;
    function ReadBool(const AName: WideString; var Value: WordBool): WordBool; virtual;
    function ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool; virtual;
    function ReadInt32(const AName: WideString; var Value: Int32): WordBool; virtual;
    function ReadInt64(const AName: WideString; var Value: Int64): WordBool; virtual;
    function ReadInteger(const AName: WideString; var Value: Integer): WordBool; virtual;
    function ReadString(const AName: WideString; var Value: WideString): WordBool; virtual;
    function ReadUInt64(const AName: WideString; var Value: UInt64): WordBool; virtual;
    function SaveToString(var Value: WideString): Boolean;
    function SetXml(const Value: WideString): WordBool; virtual;
    function SetXmlA(const Value: WideString): WordBool; virtual;
    function WriteBool(const AName: WideString; Value: Boolean): WordBool; virtual;
    function WriteInt32(const AName: WideString; Value: Int32): WordBool; virtual;
    function WriteInt64(const AName: WideString; Value: Int64): WordBool; virtual;
    function WriteInteger(const AName: WideString; Value: Integer): WordBool; virtual;
    function WriteString(const AName, Value: WideString): WordBool; virtual;
    function WriteUInt64(const AName: WideString; Value: UInt64): WordBool; virtual;
  public
    property AsString: WideString read GetAsString;
    property Collection: IXmlNodeCollection read GetCollection;
    property Node: IXmlNode read FNode implements IXmlNode;
    property NodeName: WideString read GetNodeName write SetNodeName;
    property NodeValue: OleVariant read GetNodeValue write SetNodeValue;
    property Xml: WideString read Get_Xml write Set_Xml;
  end;
{$ENDIF}

//type // Используемые классы для работы с XML -----------------------------------
  //TProfXmlDocument = AXml2007.TProfXmlDocument1;
  //TProfXmlNode = AXml2007.TProfXmlNode1_2006;

const // Сообщения -------------------------------------------------------------
  err_SaveToFile = 'Ошибка при сохранении файла "%s" "%s"';
  err_Load1      = 'Не найден закрывающий тег "?>" Line=%d';
  err_Load2      = 'Не задан элемент Line=%d';
  err_ReadNodes_1 = 'Не найдена закрывающая символ ">"';

implementation

// --- Functions Forward ---

function _strDeleteSpace(var S: String; Options: TDeleteSpaceOptionsSet): Boolean; forward;

// --- Functions ---

function strDeleteSpace(SIn: String; Options: TDeleteSpaceOptionsSet): String;
begin
  Result := ''; if (Length(SIn) = 0) then Exit;
  Result := SIn;
  _strDeleteSpace(Result, Options);
end;

function _strDeleteSpace(var S: String; Options: TDeleteSpaceOptionsSet): Boolean;
// Удаление префиксных, постфиксных, повторяющихся пробелов и префиксных и поствиксных #13#10
var
  B: Boolean;
  I: LongWord;
begin
  repeat
  B := False;

  Result := True;
  if (Length(S) = 0) then Exit;
  // Удаление префиксных пробелов
  if (dsFirst in Options) then while (S[1] = ' ') do begin
    Delete(S, 1, 1);
    if Length(S) = 0 then Exit;
    B := True;
  end;
  // Удаление постфиксных пробелов
  if (dsLast in Options) then while (S[Length(S)] = ' ') do begin
    Delete(S, Length(S), 1);
    if Length(S) = 0 then Exit;
    B := True
  end;
  // Удаление повторяющихся промежуточных пробелов
  if (dsRep in Options) then repeat
    I := Pos(S, '  ');
    if I = 0 then Break;
    Delete(S, I, 1);
  until False;

  // Удаление префиксных #13#10
  if (Length(S) >= 2) and (S[1]=#13) and (S[2]=#10) then begin
    Delete(S, 1, 2);
    B := True;
  end;
  // Удаление постфиксных #13#10
  if (Length(S) >= 2) and (S[Length(S)-1]=#13) and (S[Length(S)]=#10) then begin
    Delete(S, Length(S)-1, 2);
    B := True;
  end;

  // Повтор удаления
  until (B = False);
end;

function StrHtmlFromStr(Value: String): String;
// Переводит строку со спец символими в строку Html формата со спецсимволами
var
  I: Int32;
begin
  Result := '';
  for I := 1 to Length(Value) do case Value[I] of
    '<': Result := Result + '&lt;';
    '>': Result := Result + '&gt;';
  else
    Result := Result + Value[I];
  end;
end;

function StrHtmlToStr(Value: WideString): WideString;
// Переводит строку Html формата с тегами в простую строку с символами
// Обратная процедура StrHtmlFromStr
var
  Igt: Int32;
  Ilt: Int32;
begin
  Result := '';
  repeat
    Igt := Pos(WideString('&gt;'), Value);
    Ilt := Pos(WideString('&lt;'), Value);
    if (Igt > 0) and (Ilt > 0) and (Igt < Ilt) then begin
      Result := Result + Copy(Value, 1, Igt - 1) + '>';
      Delete(Value, 1, Igt + 3);
    end else if (Igt > 0) and (Ilt > 0) and (Ilt < Igt) then begin
      Result := Result + Copy(Value, 1, Ilt - 1) + '<';
      Delete(Value, 1, Ilt + 3);
    end else if (Igt > 0) then begin
      Result := Result + Copy(Value, 1, Igt - 1) + '>';
      Delete(Value, 1, Igt + 3);
    end else if (Ilt > 0) then begin
      Result := Result + Copy(Value, 1, Ilt - 1) + '<';
      Delete(Value, 1, Ilt + 3);
    end else Result := Result + Value;
  until (Igt = 0) and (Ilt = 0);
end;

{ TProfXmlDocument2 }

{$IFDEF XML2}
function TProfXmlDocument2.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
begin
  if Assigned(FAddToLog) then
    Result := FAddToLog(AGroup, AType, AStrMsg, AParams)
  else
    Result := False;
end;

procedure TProfXmlDocument2.CloseDocument();
begin
end;

constructor TProfXmlDocument2.Create(const AFileName: WideString = ''; AAddToLog: TAddToLog = nil);
begin
  inherited Create;
  OnAddToLog := AAddToLog;
  try
    // Открываем документ
    FDocument := TXmlDocument.Create(AFileName); //(nil);
    if AFileName = '' then FDocument.Active := True;
  except
    on E: Exception do begin
    // Произошла ошибка при открытиии файла
    AddToLog(lgGeneral, ltError, 'Произошла ошибка при открытиии файла конфигураций "%s"', [AFileName]);
    // Создаем документ
    AddToLog(lgGeneral, ltInformation, 'Создаем документ', []);
    //if not(Assigned(XmlDocument)) then
      FDocument := TXMLDocument(TXmlDocument.Create(nil));
    // Активируем документ
    AddToLog(lgGeneral, ltInformation, 'Активируем документ', []);
    FDocument.Active := True;
    // Задаем кодировку
    AddToLog(lgGeneral, ltInformation, 'Задаем кодировку "Windows-1251"', []);
    FDocument.Encoding := 'Windows-1251';
    // Задаем версию
    AddToLog(lgGeneral, ltInformation, 'Задаем версию "1.0"', []);
    FDocument.Version := '1.0';
    // Задаем отступы
    AddToLog(lgGeneral, ltInformation, 'Задаем отступы <2 пробела>', []);
    FDocument.NodeIndentStr := '  ';
    // Создаем главный элемент документа
    AddToLog(lgGeneral, ltInformation, 'Создаем главный элемент документа "Config"', []);
    //XmlDocument.CreateElement('Config', 'B111');
    FDocument.AddChild('Config').NodeValue := '';
    // Создаем дочерние элементы
    AddToLog(lgGeneral, ltInformation, 'Создаем дочерние элементы', []);
    // ...
    // Сохраняем документ
    AddToLog(lgGeneral, ltInformation, 'Сохраняем документ', []);
    FDocument.FileName := AFileName;
    FDocument.SaveToFile('');
    end;
  end;

  // DocumentElement
  try
    FDocumentElement := TProfXmlNode2.Create(FDocument.DocumentElement);
  except
  end;
end;

procedure TProfXmlDocument2.Free;
begin
  try
  if FDocument.FileName <> '' then FDocument.SaveToFile('');
  except
  end;
  inherited Free;
end;

function TProfXmlDocument2.GetDocumentElement(): AProfXmlNode2;
begin
  Result := AProfXmlNode2(FDocumentElement);
end;

function TProfXmlDocument2.GetFileName(): WideString;
begin
  Result := '';
end;

function TProfXmlDocument2.GetIsOpened(): WordBool;
begin
  Result := False;
end;

function TProfXmlDocument2.LoadFromFile(const FileName: WideString): WordBool;
begin
  Result := False;
end;

function TProfXmlDocument2.LoadFromString(const Value: WideString): WordBool;
begin
  FDocument.LoadFromXml(Value);
  Result := True;
end;

function TProfXmlDocument2.OpenDocument(): TProfError;
begin
  Result := -1;
end;

function TProfXmlDocument2.SaveToFile(const AFileName: WideString): WordBool;
begin
  try
    FDocument.SaveToFile(AFileName);
    Result := True;
  except
    on E: Exception do begin
      AddToLog(lgGeneral, ltError, err_SaveToFile, [AFileName, E.Message]);
      Result := False;
    end;
  end;
end;

function TProfXmlDocument2.SaveToString(var Value: WideString): Boolean;
begin
  try
    Value := FDocument.XML.Text;
    Result := True;
  except
    Result := False;
  end;
end;

procedure TProfXmlDocument2.SetFileName(const Value: WideString);
begin
end;

{ TProfXmlNode2 }

function TProfXmlNode2.AddFromXml(Xml: TProfXmlNode2): TError;
begin
  if Self.LoadFromXml(Xml) then
    Result := 0
  else
    Result := -1;
end;

constructor TProfXmlNode2.Create(ANode: IXmlNode);
begin
  inherited Create;
  FNode := ANode; //TXmlNode.Create(CreateDOMNode(
end;

function TProfXmlNode2.GetAsString: WideString;
begin
  if Assigned(FNode) and ((VarType(FNode.NodeValue) = varOleStr) or (VarType(FNode.NodeValue) = varStrArg) or (VarType(FNode.NodeValue) = varString)) then
    Result := FNode.NodeValue
  else
    Result := '';
end;

function TProfXmlNode2.GetCollection: IXmlNodeCollection;
begin
  if Assigned(FNode) then Result := FNode.Collection else Result := nil;
end;

function TProfXmlNode2.GetCountNodes: Integer;
begin
  if Assigned(FNode) then
    Result := FNode.Collection.Count
  else
    Result := 0;
end;

function TProfXmlNode2.GetNode(Index: Integer): TProfXmlNode2;
var
  Node: IXmlNode;
begin
  Node := FNode.Collection.Nodes[Index];
  if Assigned(Node) then
    Result := TProfXmlNode2.Create(Node)
  else
    Result := nil;
end;

function TProfXmlNode2.GetNodeByName(const AName: WideString): TProfXmlNode2;
var
  Node: IXmlNode;
begin
  // Поиск XML нода
  Node := FNode.ChildNodes.FindNode(AName);
  // Если нету - создание XML нода
  if not(Assigned(Node)) then begin
    Node := FNode.AddChild(AName);
    //Result.NodeValue := '';
  end;
  // Создание Config нода
  Result := TProfXmlNode2.Create(Node);
end;

function TProfXmlNode2.GetNodeName: WideString;
begin
  if Assigned(FNode) then Result := FNode.NodeName else Result := '';
end;

function TProfXmlNode2.GetNodeValue: OleVariant;
begin
  if Assigned(FNode) then Result := FNode.NodeValue;
end;

function TProfXmlNode2.GetXmlB: WideString;
begin
  Result := '';
  // ...
end;

function TProfXmlNode2.Get_Attribute(Name: WideString): WideString;
begin
  Result := FNode.GetAttribute(Name);
end;

function TProfXmlNode2.Get_Xml: WideString;
begin
  if Assigned(FNode) then
    Result := FNode.XML
  else
    Result := '';
end;

function TProfXmlNode2.LoadFromXml(Xml: TProfXmlNode2): WordBool;
begin
  Result := False;
  // ...
end;

function TProfXmlNode2.NewNode(const ANodeName: WideString): TProfXmlNode2;
begin
  Result := nil;
  // ...
end;

function TProfXmlNode2.ReadBool(const AName: WideString; var Value: WordBool): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(FNode);
  if not(Result) then Exit;
  Node := FNode.ChildNodes.FindNode(AName);
  Result := Assigned(Node);
  if not(Result) then Exit;
  Result := (VarType(Node.NodeValue) = varBoolean);
  if not(Result) then Exit;
  Value := Node.NodeValue;
end;

function TProfXmlNode2.ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool;
var
  S: WideString;
begin
  Result := ReadString(AName, S);
  if not(Result) then Exit;
  try
    Value := StrToDateTime(S);
    Result := True;
  except
    Result := False;
  end;
end;

function TProfXmlNode2.ReadInt32(const AName: WideString; var Value: Int32): WordBool;
begin
  Result := ReadInteger(AName, Value);
end;

function TProfXmlNode2.ReadInt64(const AName: WideString; var Value: Int64): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if Result then Value := tmpValue;
end;

function TProfXmlNode2.ReadInteger(const AName: WideString; var Value: Integer): WordBool;
var
  Code: Integer;
  Node: IXmlNode;
begin
  Result := Assigned(FNode);
  if not(Result) then Exit;
  try
    Node := FNode.ChildNodes.FindNode(AName);
    Result := Assigned(Node);
    if not(Result) then Exit;
    if (VarType(Node.NodeValue) = varInteger) then begin
      Value := Node.NodeValue;
    end else if (VarType(Node.NodeValue) = varString) or (VarType(Node.NodeValue) = varOleStr) then begin
      Val(Node.NodeValue, Value, Code);
      Result := (Code = 0);
    end else Result := False;
  except
    Result := False;
  end;
end;

function TProfXmlNode2.ReadString(const AName: WideString; var Value: WideString): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(FNode);
  if not(Result) then Exit;
  Node := FNode.ChildNodes.FindNode(AName);
  Result := Assigned(Node);
  if not(Result) then Exit;
  if (VarType(Node.NodeValue) = varString) or (VarType(Node.NodeValue) = varOleStr) then begin
    Value := Node.NodeValue;
    Result := True;
  end else Result := False;
end;

function TProfXmlNode2.ReadUInt64(const AName: WideString; var Value: UInt64): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if not(Result) then Exit;
  Value := tmpValue;
end;

function TProfXmlNode2.SaveToString(var Value: WideString): Boolean;
begin
  Result := False;
  // ...
end;

procedure TProfXmlNode2.SetNodeName(const Value: WideString);
begin
  //FNode.NodeName := Value;
end;

procedure TProfXmlNode2.SetNodeValue(Value: OleVariant);
begin
  try
  if Assigned(FNode) then FNode.NodeValue := Value;
  except
  end;
end;

function TProfXmlNode2.SetXml(const Value: WideString): WordBool;
begin
  //if Assigned(FNode) then
  //  FNode.Xml := Value;
  Result := False;
end;

function TProfXmlNode2.SetXmlA(const Value: WideString): WordBool;
begin
  Result := False;
  // ...
end;

procedure TProfXmlNode2.Set_Attribute(Name, Value: WideString);
begin
  FNode.SetAttribute(Name, Value);
end;

procedure TProfXmlNode2.Set_Xml(const Value: WideString);
begin
  SetXml(Value);
end;

function TProfXmlNode2.WriteBool(const AName: WideString; Value: Boolean): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(FNode);
  if not(Assigned(FNode)) then Exit;
  Node := FNode.ChildNodes.FindNode(AName);
  if Assigned(Node) then
    Node.NodeValue := Value
  else
    FNode.AddChild(AName).NodeValue := Value;
  Result := True;
end;

function TProfXmlNode2.WriteInt32(const AName: WideString; Value: Int32): WordBool;
begin
  Result := WriteInteger(AName, Value);
end;

function TProfXmlNode2.WriteInt64(const AName: WideString; Value: Int64): WordBool;
begin
  Result := WriteInt32(AName, Value);
end;

function TProfXmlNode2.WriteInteger(const AName: WideString; Value: Integer): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(FNode);
  if not(Result) then Exit;
  try
    Node := FNode.ChildNodes.FindNode(AName);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      FNode.AddChild(AName).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function TProfXmlNode2.WriteString(const AName, Value: WideString): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(FNode);
  if not(Result) then Exit;
  Node := FNode.ChildNodes.FindNode(AName);
  if Assigned(Node) then
    Node.NodeValue := Value
  else
    FNode.AddChild(AName).NodeValue := Value;
  Result := True;
end;

function TProfXmlNode2.WriteUInt64(const AName: WideString; Value: UInt64): WordBool;
begin
  Result := WriteInteger(AName, Value);
end;
{$ENDIF}

end.
