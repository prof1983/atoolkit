{**
@Abstract(XML документ. Класс реализует интерфейсы IProfXmlDocumentA и IProfXmlNodeA)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.02.2007)
@LastMod(25.05.2012)
@Version(0.5)
}
unit AXmlDocumentB;

interface

uses
  SysUtils, Variants, XmlDoc, XmlDom, XmlIntf,
  AXmlIntf;

type
  //** @abstract(XML документ. Класс реализует интерфейсы IProfXmlDocumentA и IProfXmlNodeA)
  TProfXmlDocumentB = class(TInterfacedObject, IProfXmlDocumentA, IProfXmlNodeA)
  private
    FDocument: IXmlDocument;
    FDocumentElementName: WideString;
    FFileName: WideString;
    function GetDocumentElementName(): WideString;
  protected
    function GetDocumentElement(): IProfXmlNodeA; safecall;
    function GetFileName(): WideString; safecall;
    procedure SetFileName(const Value: WideString); safecall;
  protected
    function GetAsBool(): WordBool; safecall;
    function GetAsDateTime(): TDateTime; safecall;
    function GetAsFloat32(): Float32; safecall;
    function GetAsFloat64(): Float64; safecall;
    function GetAsInt32(): Integer; safecall;
    function GetAsInt64(): Integer; safecall;
    function GetAsString(): WideString; safecall;
  protected
    function GetNodeByName(const AName: WideString): IProfXmlNodeA; safecall;
  protected
    function GetValueAsBool(var Value: WordBool): WordBool; safecall;
    function GetValueAsDateTime(var Value: TDateTime): WordBool; safecall;
    function GetValueAsInt32(var Value: Integer): WordBool; safecall;
    function GetValueAsInt64(var AValue: Int64): WordBool; safecall;
    function GetValueAsString(var Value: WideString): WordBool; safecall;
    function GetValueAsUInt08(var Value: Byte): WordBool; safecall;
    //function GetValueAsUInt64(var Value: UInt64): WordBool; safecall;
  protected
    procedure SetAsString(const Value: WideString); safecall;
  protected
    function SetValueAsBool(Value: WordBool): WordBool; safecall;
    function SetValueAsFloat64(Value: Float64): WordBool; safecall;
    function SetValueAsInt32(AValue: Integer): WordBool; safecall;
    function SetValueAsString(const AValue: WideString): WordBool; safecall;
    function SetValueAsUInt08(AValue: Byte): WordBool; safecall;
    //function SetValueAsUInt64(AValue: UInt64): WordBool; safecall;
  public
    class function GetValueAsStringA(ANode: IXmlNode; var Value: WideString): WordBool;
  public
    function ReadBool(const AName: WideString; var Value: WordBool): WordBool; safecall;
    function ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool; safecall;
    function ReadFloat64(const AName: WideString; var Value: Float64): WordBool; safecall;
    function ReadInt08(const AName: WideString; var Value: Int08): WordBool; safecall;
    function ReadInt16(const AName: WideString; var Value: Int16): WordBool; safecall;
    function ReadInt32(const AName: WideString; var Value: Int32): WordBool; safecall;
    function ReadInt64(const AName: WideString; var AValue: Int64): WordBool; safecall;
    function ReadString(const AName: WideString; var Value: WideString): WordBool; safecall;
    function ReadUInt08(const AName: WideString; var Value: UInt08): WordBool; safecall;
    function ReadUInt16(const AName: WideString; var Value: UInt16): WordBool; safecall;
    function ReadUInt32(const AName: WideString; var Value: UInt32): WordBool; safecall;
    //function ReadUInt64(const AName: WideString; var Value: UInt64): WordBool; safecall;
  public
    function WriteBool(const AName: WideString; Value: WordBool): WordBool; safecall;
    function WriteDateTime(const AName: WideString; AValue: TDateTime): WordBool; safecall;
    function WriteFloat64(const AName: WideString; Value: Float64): WordBool; safecall;
    function WriteInt32(const AName: WideString; Value: Int32): WordBool; safecall;
    function WriteInt64(const AName: WideString; Value: Int64): WordBool; safecall;
    function WriteString(const AName, Value: WideString): WordBool; safecall;
    function WriteUInt08(const AName: WideString; AValue: UInt08): WordBool; safecall;
    //function WriteUInt64(const AName: WideString; AValue: UInt64): WordBool; safecall;
    function WriteXml(const AName, Value: WideString): WordBool; safecall;
  public
    procedure Close(); safecall;
    function LoadFromFile(const FileName: WideString): WordBool; virtual; safecall;
    function Open(): Integer; safecall;
    function SaveToFile(const FileName: WideString): WordBool; virtual; safecall;
  public
    constructor Create();
  public
    property AsString: WideString read GetAsString write SetAsString;
  public
    property DocumentElement: IProfXmlNodeA read GetDocumentElement;
    {** Имя главного нода. Должно задаваться до открытия XML файла и
      используется при создании XML документа. При открытии существующего файла
      не используется. }
    property DocumentElementName: WideString read GetDocumentElementName write FDocumentElementName;
    property FileName: WideString read GetFileName write SetFileName;
  end;

implementation

// TProfXmlDocumentA -----------------------------------------------------------
// -----------------------------------------------------------------------------
procedure TProfXmlDocumentB.Close();
begin
  // ...
end;

// -----------------------------------------------------------------------------
constructor TProfXmlDocumentB.Create();
begin
  inherited Create();
  FDocumentElementName := 'Config';
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.GetAsBool(): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.GetAsDateTime(): TDateTime;
begin
  Result := 0;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.GetAsFloat32(): Float32;
begin
  Result := 0;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.GetAsFloat64(): Float64;
begin
  Result := 0;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.GetAsInt32(): Integer;
begin
  Result := 0;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.GetAsInt64(): Integer;
begin
  Result := 0;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.GetAsString(): WideString;
begin
  Result := '';
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.GetDocumentElement(): IProfXmlNodeA;
begin
  Result := nil;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.GetDocumentElementName(): WideString;
begin
  Result := FDocumentElementName;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.GetFileName(): WideString;
begin
  Result := FFileName;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.GetNodeByName(const AName: WideString): IProfXmlNodeA;
begin
  Result := nil;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.GetValueAsBool(var Value: WordBool): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.GetValueAsDateTime(var Value: TDateTime): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.GetValueAsInt32(var Value: Integer): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.GetValueAsInt64(var AValue: Int64): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.GetValueAsString(var Value: WideString): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
class function TProfXmlDocumentB.GetValueAsStringA(ANode: IXmlNode; var Value: WideString): WordBool;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    if (VarType(ANode.NodeValue) = varString) or (VarType(ANode.NodeValue) = varOleStr) then
    begin
      Value := ANode.NodeValue;
      Result := True;
    end
    else
      Result := False;
  except
    Result := False;
  end;
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.GetValueAsUInt08(var Value: Byte): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.LoadFromFile(const FileName: WideString): WordBool;
begin
  Close();
  FFileName := FileName;
  Result := (Open() = 0);
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.Open(): Integer;

  procedure CreateA();
  begin
    // Создаем документ
    //AddToLog(lgGeneral, ltInformation, 'Создаем документ', []);
    FDocument.FileName := '';
    // Активируем документ
    //AddToLog(lgGeneral, ltInformation, 'Активируем документ', []);
    FDocument.Active := True;
    // Задаем кодировку
    //AddToLog(lgGeneral, ltInformation, 'Задаем кодировку "Windows-1251"', []);
    FDocument.Encoding := 'Windows-1251';
    // Задаем версию
    //AddToLog(lgGeneral, ltInformation, 'Задаем версию "1.0"', []);
    FDocument.Version := '1.0';
    // Задаем отступы
    //AddToLog(lgGeneral, ltInformation, 'Задаем отступы <2 пробела>', []);
    FDocument.NodeIndentStr := '  ';
    // Создаем главный элемент документа
    //AddToLog(lgGeneral, ltInformation, 'Создаем главный элемент документа "Config"', []);
    //if FDefElementName = '' then FDefElementName := 'Config';
    if FDocumentElementName <> '' then
    begin
      FDocument.AddChild(FDocumentElementName);
      // Создаем дочерние элементы
      //AddToLog(lgGeneral, ltInformation, 'Создаем дочерние элементы', []);
      // ...
    end;
  end;

begin
  Result := 0;

  // Проверка сущестрования директории
//  if FDefFileName <> '' then
//    ForceDirectories(ExtractFilePath(FDefFileName));

  if not(Assigned(FDocument)) then
    FDocument := TXmlDocument.Create(nil);

  FDocument.ParseOptions := [poPreserveWhiteSpace];

  if FFileName = '' then
  begin
    CreateA();
    Result := 1;
  end
  else
  try
    FDocument.LoadFromFile(FFileName);
  except
    on E: Exception do
    begin
      // Произошла ошибка при открытиии файла
      //AddToLog(lgGeneral, ltError, 'Произошла ошибка при открытиии файла конфигураций "%s"', [FDefFileName]);

      CreateA();
      Result := 1;

      // Сохраняем документ
      //AddToLog(lgGeneral, ltInformation, 'Сохраняем документ', []);
      FDocument.FileName := FFileName;
      FDocument.SaveToFile('');
    end;
  end;
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.ReadBool(const AName: WideString; var Value: WordBool): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.ReadFloat64(const AName: WideString; var Value: Float64): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.ReadInt08(const AName: WideString; var Value: Int08): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.ReadInt16(const AName: WideString; var Value: Int16): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.ReadInt32(const AName: WideString; var Value: Int32): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.ReadInt64(const AName: WideString; var AValue: Int64): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.ReadString(const AName: WideString; var Value: WideString): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(FDocument.DocumentElement);
  if not(Result) then Exit;
  Node := FDocument.DocumentElement.ChildNodes.FindNode(AName);
  Result := Assigned(Node);
  if not(Result) then Exit;
  Result := GetValueAsStringA(Node, Value);
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.ReadUInt08(const AName: WideString; var Value: UInt08): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.ReadUInt16(const AName: WideString; var Value: UInt16): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.ReadUInt32(const AName: WideString; var Value: UInt32): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.SaveToFile(const FileName: WideString): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
procedure TProfXmlDocumentB.SetAsString(const Value: WideString);
begin
  // ...
end;

// -----------------------------------------------------------------------------
procedure TProfXmlDocumentB.SetFileName(const Value: WideString);
begin
  FFileName := Value;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.SetValueAsBool(Value: WordBool): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.SetValueAsFloat64(Value: Float64): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.SetValueAsInt32(AValue: Integer): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.SetValueAsString(const AValue: WideString): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.SetValueAsUInt08(AValue: Byte): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.WriteBool(const AName: WideString; Value: WordBool): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.WriteDateTime(const AName: WideString; AValue: TDateTime): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.WriteFloat64(const AName: WideString; Value: Float64): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.WriteInt32(const AName: WideString; Value: Int32): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.WriteInt64(const AName: WideString; Value: Int64): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
{function TProfXmlDocumentB.WriteInteger(const AName: WideString; Value: Integer): WordBool;
begin

end;}

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.WriteString(const AName, Value: WideString): WordBool;
begin
//  //Result := False;
//  Result := ReadStringA(FController, AName, Value);
//  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.WriteUInt08(const AName: WideString; AValue: UInt08): WordBool;
begin
  Result := False;
  // ...
end;

// -----------------------------------------------------------------------------
function TProfXmlDocumentB.WriteXml(const AName, Value: WideString): WordBool;
begin
  Result := False;
  // ...
end;

end.
