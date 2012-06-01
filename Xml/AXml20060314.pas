{**
@Abstract(Работа с XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.10.2005)
@LastMod(18.05.2012)
@Version(0.5)
}
unit AXml20060314;

{$DEFINE XML1}
{IFDEF VER150}
  {$DEFINE XML2}
{ENDIF}

interface

// TODO: AXmlIntf1 -> XmlIntf.pas

uses
  Classes, ComObj, SysUtils,
  {$IFDEF XML2}
  MSXmlDom, Variants, XmlDoc, XmlDom, XmlIntf,
  {$ENDIF}
  ATypes, AXmlIntf1;

type // ------------------------------------------------------------------------
  Int32 = Integer;
  Float32 = Real;
  Float64 = Double;
  UInt08 = Byte;
  //UInt64 = Int64;

type // Опции удаления пробелов в функции strDeleteStace -----------------------
  TDeleteSpaceOptions = (
    dsFirst,  // Первые
    dsLast,   // Последние
    dsRep     // Повторяющиеся
    );
  TDeleteSpaceOptionsSet = set of TDeleteSpaceOptions;

{$IFDEF XML1}
type // ------------------------------------------------------------------------
  TProfXmlNode1 = class;

  // Коллекция нодов
  TProfXmlCollection = class(TInterfacedObject, IProfXmlCollection)
  private
    FNodes: array of TProfXmlNode1;
    FOwner: TProfXmlNode1;
    function GetNode(Index: Integer): TProfXmlNode1;
    function GetNodeByName(Name: WideString): TProfXmlNode1;
    procedure AddNode(ANode: TProfXmlNode1);
  protected
    function Get_Node(Index: Integer): IProfXmlNode;
  public
    procedure Clear;
    constructor Create(AOwner: TProfXmlNode1);
    function FindNode(Name: WideString): TProfXmlNode1;
    procedure Free;
    property Nodes[Index: Integer]: TProfXmlNode1 read GetNode;
    property NodesByName[Name: WideString]: TProfXmlNode1 read GetNodeByName;
    function Count: Integer;
    function NewNode(const AName: WideString): TProfXmlNode1;
    function AddChild(const AName: WideString): TProfXmlNode1;
  end;

  // XML документ
  TProfXmlDocument1 = class(TInterfacedObject, IProfXmlDocument) //{$IFDEF Xml_ActiveX}(TAutoObject){$ENDIF}
  private
    FDocumentElement: TProfXmlNode1;
    FEncoding: WideString;   // Набор символов = 'Windows-1251'
    FFileName: WideString;   // Имя файла
    FOnAddToLog: TAddToLog;
    FStandAlone: WideString; // Указывает на внешнее описание = ''
    FVersion: WideString;    // Версия XML = '1.0'
  protected
    function DoDocumentTag(Node: TProfXmlNode1): Boolean; virtual;
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
    constructor Create(const AFileName: WideString = ''; AAddToLog: TAddToLog = nil);
    property DocumentElement: TProfXmlNode1 read FDocumentElement write FDocumentElement;
    property Encoding: WideString read FEncoding write FEncoding;
    procedure Free; virtual;
    function LoadFromFile(const AFileName: WideString = ''): WordBool;
    function LoadFromString(Value: WideString): Boolean;
    property OnAddToLog: TAddToLog read FOnAddToLog write FOnAddToLog;
    function SaveToFile(const AFileName: WideString = ''): WordBool;
    function SaveToString(var S: WideString): WordBool;
    property StandAlone: WideString read FStandAlone write FStandAlone;
    property Version: WideString read FVersion write FVersion;
  end;

  // XML элемент
  TProfXmlNode1 = class(TInterfacedObject, IProfXmlNode) //(TAutoObject, IXmlNode) //{$IFDEF Xml_ActiveX}(TAutoObject, IXmlNode){$ENDIF}
  private
    FAttributes: array of record
      Name: WideString;
      Value: WideString;
    end;
    FCollection: TProfXmlCollection;
    FDocument: TProfXmlDocument1;
    FName: WideString;
    FValue: WideString;
    procedure GetNameAndAttributes(Value: WideString);
    function ReadNodes(var Value: WideString; CloseTag: WideString): Boolean;
  protected
    function _GetValueAsBool: WordBool;
    function _GetValueAsString: WideString;
    procedure _SetValueAsString(Value: WideString);
    function Get_Attribute(Name: WideString): WideString;
    function Get_Attribute_Name(Index: Integer): WideString;
    function Get_Attribute_Value(Index: Integer): WideString;
    function Get_Collection: IProfXmlCollection;
    function Get_NodeName: WideString;
    function Get_NodeValue: WideString;
    function Get_Xml: WideString;
    procedure Set_Attribute(Name, Value: WideString);
    procedure Set_NodeName(Value: WideString);
    procedure Set_NodeValue(Value: WideString);
    procedure Set_Xml(const Value: WideString);
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
    function Attributes_Count: Integer;
    procedure Clear;
    //property Collection: TProfXmlCollection read FCollection;
    constructor Create(ADocument: TProfXmlDocument1 = nil);
    property Document: TProfXmlDocument1 read FDocument;
    property OwnerDocument: TProfXmlDocument1 read FDocument;
    function FindNode(Name: WideString): TProfXmlNode1;
    procedure Free; virtual;
    function GetAttribute(const AName: WideString; AUpperCase: Boolean = False): WideString;
    function GetCountNodes: Integer;
    function GetName: WideString;
    function GetNode(Index: Integer): TProfXmlNode1;
    function GetNodeByName(Name: WideString): TProfXmlNode1;
    function GetValueAsBool(var Value: WordBool): Boolean;
    function GetValueAsDateTime(var Value: TDateTime): Boolean;
    function GetValueAsInt32(var Value: Int32): Boolean;
    function GetValueAsInt64(var AValue: Int64): Boolean;
    function GetValueAsInteger(var AValue: Integer): Boolean;
    function GetValueAsString(var Value: WideString): Boolean;
    function GetValueAsUInt08(var Value: UInt08): Boolean;
    function GetValueAsUInt64(var Value: UInt64): Boolean;
    function GetXml: WideString;
    function GetXmlA(Prefix: WideString): WideString;
    function GetXmlB: WideString;
    function Load: Boolean; virtual;
    function LoadFromXml(AXml: TProfXmlNode1): Boolean;
    function NewNode(const AName: WideString): TProfXmlNode1;
    function NodeExist(AName: WideString): Boolean;
    property NodeName: WideString read Get_NodeName write Set_NodeName;
    //property NodeValue: WideString read Get_NodeValue write Set_NodeValue;
    function ReadBool(const AName: WideString; var Value: WordBool): WordBool; virtual;
    function ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool; virtual;
    function ReadFloat64(const AName: WideString; var Value: Float64): WordBool; virtual;
    function ReadInt32(const AName: WideString; var Value: Int32): WordBool; virtual;
    function ReadInt64(const AName: WideString; AValue: Int64): WordBool; virtual;
    function ReadInteger(const AName: WideString; var AValue: Integer): WordBool; virtual;
    function ReadString(const AName: WideString; var Value: WideString): WordBool; virtual;
    function ReadUInt08(const AName: WideString; var Value: UInt08): WordBool; virtual;
    function ReadUInt64(const AName: WideString; var Value: UInt64): WordBool; virtual;
    function ReadWideString(const AName: WideString; var Value: WideString): WordBool; virtual;
    procedure SetName(Value: WideString);
    function SetValueAsBool(Value: Boolean): Boolean;
    function SetValueAsFloat64(Value: Float64): Boolean;
    function SetValueAsInt32(AValue: Int32): Boolean;
    function SetValueAsString(AValue: WideString): Boolean;
    function SetValueAsUInt08(AValue: UInt08): Boolean;
    function SetValueAsUInt64(AValue: UInt64): Boolean;
    function SetXml(Value: WideString): Boolean;
    function ToStrings(AStrings: TStrings; Prefix: String = ''): Boolean;
    function WriteBool(const AName: WideString; Value: WordBool): WordBool; virtual;
    function WriteFloat64(const AName: WideString; Value: Float64): WordBool; virtual;
    function WriteInt32(const AName: WideString; Value: Int32): WordBool; virtual;
    function WriteInt64(const AName: WideString; Value: Int64): WordBool; virtual;
    function WriteInteger(const AName: WideString; Value: Integer): WordBool; virtual;
    function WriteString(const AName, Value: WideString): WordBool; virtual;
    function WriteUInt08(const AName: WideString; AValue: UInt08): WordBool; virtual;
    function WriteUInt64(const AName: WideString; AValue: UInt64): WordBool; virtual;
    function WriteXml(const AName, Value: WideString): WordBool;
    function SetXmlA(var Value: WideString; CloseTag: WideString = ''): WordBool;
    property Xml: WideString read Get_Xml write Set_Xml;
  private
    procedure _SetValueAsBool(Value: WordBool);
  public
    property Attributes[Name: WideString]: WideString read Get_Attribute write Set_Attribute;
    property Attribute_Name[Index: Integer]: WideString read Get_Attribute_Name;
    property Attribute_Value[Index: Integer]: WideString read Get_Attribute_Value;
    property AsBoolean: WordBool read _GetValueAsBool write _SetValueAsBool;
    property AsString: WideString read _GetValueAsString write _SetValueAsString;
  end;
{$ENDIF}

{$IFDEF XML2}
type // ------------------------------------------------------------------------
  TProfXmlNode2 = class;

  TProfXmlDocument2 = class(TInterfacedObject, IProfXmlDocument, IXMLDocument)
  private
    FAddToLog: TAddToLog;
    FDocument: TXmlDocument;
    FDocumentElement: TProfXmlNode2;
    function GetDocumentElement: TProfXmlNode2;
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
    constructor Create(const AFileName: WideString = ''; AAddToLog: TAddToLog = nil);
    property Document: TXmlDocument read FDocument implements IXMLDocument;
    property DocumentElement: TProfXmlNode2 read GetDocumentElement;
    procedure Free;
    function LoadFromString(const Value: WideString): WordBool;
    property OnAddToLog: TAddToLog read FAddToLog write FAddToLog;
    function SaveToFile(const AFileName: WideString): WordBool;
    function SaveToString(var Value: WideString): Boolean;
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

type // Используемые классы для работы с XML -----------------------------------
  TProfXmlDocument = TProfXmlDocument1;
  TProfXmlNode     = TProfXmlNode1;

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

{ TProfXmlCollection }

function TProfXmlCollection.AddChild(const AName: WideString): TProfXmlNode1;
begin
  Result := NewNode(AName);
end;

procedure TProfXmlCollection.AddNode(ANode: TProfXmlNode1);
var
  I: Int32;
begin
  I := Length(FNodes);
  SetLength(FNodes, I + 1);
  FNodes[I] := ANode;
  FNodes[I].FDocument := FOwner.Document;
end;

procedure TProfXmlCollection.Clear;
var
  I: Integer;
begin
  for I := 0 to High(FNodes) do FNodes[I].Free;
  SetLength(FNodes, 0);
end;

function TProfXmlCollection.Count: Integer;
begin
  Result := Length(FNodes)
end;

constructor TProfXmlCollection.Create(AOwner: TProfXmlNode1);
begin
  inherited Create;
  FOwner := AOwner;
end;

function TProfXmlCollection.FindNode(Name: WideString): TProfXmlNode1;
var
  I: Int32;
begin
  for I := 0 to High(FNodes) do if FNodes[I].GetName = Name then begin
    Result := FNodes[I];
    Exit;
  end;
  Result := nil;
end;

procedure TProfXmlCollection.Free;
begin
  Clear;
  inherited Free;
end;

function TProfXmlCollection.GetNode(Index: Integer): TProfXmlNode;
begin
  Result := nil;
  if (Index < 0) or (Index > Length(FNodes)) then Exit;
  Result := FNodes[Index];
end;

function TProfXmlCollection.GetNodeByName(Name: WideString): TProfXmlNode1;
begin
  Result := FindNode(Name);
  if Assigned(Result) then Exit;
  Result := TProfXmlNode1.Create(FOwner.Document);
  Result.SetName(Name);
  AddNode(Result);
end;

function TProfXmlCollection.Get_Node(Index: Integer): IProfXmlNode;
begin
  Result := GetNode(Index);
end;

function TProfXmlCollection.NewNode(const AName: WideString): TProfXmlNode1;
begin
  Result := TProfXmlNode1.Create(FOwner.Document);
  Result.FName := AName;
  AddNode(Result);
end;

{ TProfXmlDocument1 }

{$IFDEF XML1}
function TProfXmlDocument1.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
begin
  if Assigned(FOnAddToLog) then
    Result := FOnAddToLog(AGroup, AType, AStrMsg, AParams)
  else
    Result := False;
end;

constructor TProfXmlDocument1.Create(const AFileName: WideString = ''; AAddToLog: TAddToLog = nil);
begin
  inherited Create;
  FOnAddToLog := AAddToLog;
  FEncoding := 'Windows-1251';
  FStandAlone := '';
  FVersion := '1.0';
  FFileName := AFileName;

  FDocumentElement := TProfXmlNode1.Create(Self);
  FDocumentElement.SetName('Config');

  // Если указано имя файла - загружаем
  if FFileName <> '' then LoadFromFile(FFileName);
end;

function TProfXmlDocument1.DoDocumentTag(Node: TProfXmlNode1): Boolean;
// Чтение тега <?...?>
begin
  Result := False;
end;

procedure TProfXmlDocument1.Free;
begin
  //FreeAndNil(FDocumentElement);
  FDocumentElement.Free; FDocumentElement := nil;
  inherited Free;
end;

function TProfXmlDocument1.LoadFromFile(const AFileName: WideString = ''): WordBool;
var
  F: TextFile;
  S: String;
  Str: String;
  FileName: WideString;
begin
  Result := False;

  if AFileName = '' then
    FileName := FFileName
  else
    FileName := AFileName;

  // if not(FileExists(FileName)) then Exit;
  AssignFile(F, FileName);
  {$I-}Reset(F);{$I+}
  Result := (IOResult = 0);
  if not(Result) then begin
    {$I-}CloseFile(F);{$I+}
    Exit;
  end;
  // Перевод файла в одну строку
  Str := '';
  while not(Eof(F)) do begin
    ReadLn(F, S);
    S := StrDeleteSpace(S, [dsFirst, dsLast, dsRep]);
    Str := Str + S;
  end;
  {$I-}CloseFile(F);{$I+}
  Result := LoadFromString(Str);
end;

function TProfXmlDocument1.LoadFromString(Value: WideString): Boolean;
var
  I: Integer;
  IEnd: Integer;
  S: String;
  Line: Integer;
  Node: TProfXmlNode1;
begin
  Result := False;
  Line := 0;
  // Чтение <?...?> тегов
  repeat
    Inc(Line);
    I := Pos(WideString('<?'), Value);
    if I > 0 then
    begin
      IEnd := Pos(WideString('?>'), Value);
      if IEnd = 0 then
      begin
        AddToLog(lgGeneral, ltError, err_Load1, [Line]);
        Exit;
      end;
      S := Copy(Value, 3, IEnd - 3);
      Delete(Value, 1, IEnd+1);
      //
      I := Pos('<', Value);
      if I = 0 then begin
        AddToLog(lgGeneral, ltError, err_Load2, [Line]);
      end;
      // #13#10
      IEnd := Pos(WideString(#13#10), Value);
      if IEnd < I then Inc(Line);
      Value := Copy(Value, I, Length(Value));
      //S := strDeleteSpace(S);

      Node := TProfXmlNode1.Create;
      Node.SetXml('<' + S + '/>');
      if AnsiUpperCase(Node.NodeName) = 'XML' then begin
        FEncoding := Node.GetAttribute('encoding', False);
        FVersion := Node.GetAttribute('version', False)
      end else DoDocumentTag(Node);
      Node.Free;
      //Node := nil;
    end;
  until I = 0;
  // Чтение DocumentElement
  Result := FDocumentElement.SetXml(Value);
end;

function TProfXmlDocument1.SaveToFile(const AFileName: WideString = ''): WordBool;
var
  F: TextFile;
  FileName: WideString;
  S: WideString;
begin
  SaveToString(S);

  if AFileName = '' then
    FileName := FFileName
  else
    FileName := AFileName;

  AssignFile(F, FileName);
  {$I-}
  Rewrite(F);
  WriteLn(F, String(S));
  CloseFile(F);
  {$I+}
  Result := (IOResult = 0);
end;

function TProfXmlDocument1.SaveToString(var S: WideString): WordBool;
begin
  // Сохранение тегов <?...?>
  if FVersion <> '' then begin
    if FEncoding = '' then
      S := '<? xml version="' + FVersion + '" ?>'+#13#10
    else
      S := '<? xml version="' + FVersion + '" encoding="' + FEncoding + '" ?>'+#13#10;
  end else S := '';
  S := S + FDocumentElement.GetXmlA('');
  Result := True;
end;

{ TProfXmlNode1 }

function TProfXmlNode1.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
begin
  if Assigned(FDocument) then
    Result := FDocument.AddToLog(AGroup, AType, AStrMsg, AParams)
  else
    Result := False;
end;

function TProfXmlNode1.Attributes_Count: Integer;
begin
  Result := Length(FAttributes);
end;

procedure TProfXmlNode1.Clear;
begin
  SetLength(FAttributes, 0);
  FCollection.Clear;
end;

constructor TProfXmlNode1.Create(ADocument: TProfXmlDocument1 = nil);
begin
  inherited Create;
  FCollection := TProfXmlCollection.Create(Self);
  FDocument := ADocument;
  FName := '';
  FValue := '';
end;

function TProfXmlNode1.FindNode(Name: WideString): TProfXmlNode1;
begin
  Result := FCollection.FindNode(Name);
end;

procedure TProfXmlNode1.Free;
begin
  Clear;
  FCollection.Free; FCollection := nil;
  inherited Free;
end;

function TProfXmlNode1.GetAttribute(const AName: WideString; AUpperCase: Boolean = False): WideString;
// Возвращает значение атрибута
// AUpperCase - различать большие и маленькие символы?
var
  I: Integer;
begin
  if AUpperCase then begin
    for I := 0 to High(FAttributes) do if FAttributes[I].Name = AName then begin
      Result := FAttributes[I].Value;
      Exit;
    end;
  end else begin
    for I := 0 to High(FAttributes) do if AnsiUpperCase(FAttributes[I].Name) = AnsiUpperCase(AName) then begin
      Result := FAttributes[I].Value;
      Exit;
    end;
  end;
end;

function TProfXmlNode1.GetCountNodes: Int32;
begin
  Result := FCollection.Count;
end;

function TProfXmlNode1.GetName: WideString;
begin
  Result := FName;
end;

procedure TProfXmlNode1.GetNameAndAttributes(Value: WideString);
// Выделить имя и атрибуты их строки "tag attr1="value1" attr2="value2""
var
  I: Integer;
  AName: WideString;
  AValue: WideString;
begin
  I := Pos(' ', Value);
  // Выделение имени
  if I = 0 then begin
    FName := Value;
    Exit;
  end else begin
    FName := Copy(Value, 1, I - 1);
    Value := Copy(Value, I + 1, Length(Value));
  end;
  // Выделение атрибутов
  repeat
    // Выделение имени атрибута
    I := Pos('=', Value);
    if I = 0 then Exit;
    AName := Copy(Value, 1, I - 1);
    Value := Copy(Value, I + 1, Length(Value));
    // Выделение значения
    if Length(Value) > 0 then begin
      if Value[1] = '"' then begin // Если есть открывающая кавычка
        Value := Copy(Value, 2, Length(Value));
        I := Pos('"', Value); // Закрывающая кавычка
        AValue := Copy(Value, 1, I - 1);
        Value := Copy(Value, I + 1, Length(Value));
        Value := strDeleteSpace(Value, [dsFirst, dsLast, dsRep]);
      end else begin // Если нет открывающей кавычки
        I := Pos(' ', Value);
        AValue := Copy(Value, 1, I - 1);
        Value := Copy(Value, I + 1, Length(Value));
        Value := strDeleteSpace(Value, [dsFirst, dsLast, dsRep]);
      end;
    end else AValue := ''; // Пустое значение
    // Создание атрибута
    Attributes[AName] := AValue;
  until Length(Value) = 0;
end;

function TProfXmlNode1.GetNode(Index: Int32): TProfXmlNode1;
begin
  Result := FCollection.Nodes[Index];
end;

function TProfXmlNode1.GetNodeByName(Name: WideString): TProfXmlNode1;
begin
  Result := FCollection.NodesByName[Name];
end;

function TProfXmlNode1.GetValueAsBool(var Value: WordBool): Boolean;
begin
  Value := (FValue = 'True');
  Result := True;
end;

function TProfXmlNode1.GetValueAsDateTime(var Value: TDateTime): Boolean;
begin
  try
    Value := StrToDateTime(FValue);
    Result := True;
  except
    Result := False;
  end;
end;

function TProfXmlNode1.GetValueAsInt32(var Value: Int32): Boolean;
var
  Code: Integer;
begin
  Val(FValue, Value, Code);
  Result := (Code = 0);
end;

function TProfXmlNode1.GetValueAsInt64(var AValue: Int64): Boolean;
var
  Code: Integer;
begin
  Val(FValue, AValue, Code);
  Result := (Code = 0);
end;

function TProfXmlNode1.GetValueAsInteger(var AValue: Integer): Boolean;
var
  Code: Integer;
begin
  Val(FValue, AValue, Code);
  Result := (Code = 0);
end;

function TProfXmlNode1.GetValueAsString(var Value: WideString): Boolean;
begin
  Value := FValue;
  Result := True;
end;

function TProfXmlNode1.GetValueAsUInt08(var Value: UInt08): Boolean;
var
  Code: Integer;
begin
  Val(FValue, Value, Code);
  Result := (Code = 0);
end;

function TProfXmlNode1.GetValueAsUInt64(var Value: UInt64): Boolean;
var
  Code: Integer;
begin
  Val(FValue, Value, Code);
  Result := (Code = 0);
end;

function TProfXmlNode1.GetXml: WideString;
// Возвращает в виде одной строки без отступов и знаков переноса
var
  I: Int32;
  Attr: WideString;
begin
  // Атрибуты
  Attr := '';
  for I := 0 to High(FAttributes) do
    Attr := Attr + ' ' + FAttributes[I].Name+'="'+FAttributes[I].Value+'"';

  if GetCountNodes > 0 then begin
    Result := '<'+FName+Attr+'>';
    Result := Result + GetXmlB;
    Result := Result + '</'+FName+'>';
  end else begin
    if FName <> '' then begin
      if FValue = '' then
        Result := '<'+FName+Attr+' />'
      else
        Result := '<'+FName+Attr+'>'+StrHtmlFromStr(FValue)+'</'+FName+'>';
    end;
  end;
end;

function TProfXmlNode1.GetXmlA(Prefix: WideString): WideString;
// Возвращает в виде одной строки с отступами и знаками переноса
var
  I: Int32;
  Attr: WideString;
begin
  // Атрибуты
  Attr := '';
  for I := 0 to High(FAttributes) do
    Attr := Attr + ' ' + FAttributes[I].Name+'="'+FAttributes[I].Value+'"';

  if GetCountNodes > 0 then begin
    Result := Prefix + '<'+FName+Attr+'>' + #13#10;
    for I := 0 to FCollection.Count - 1 do begin
      Result := Result + FCollection.Nodes[I].GetXmlA(Prefix + '  ');
    end;
    Result := Result + Prefix + '</'+FName+'>'+#13#10;
  end else begin
    if FName <> '' then Result := Prefix + '<'+FName+Attr+'>'+StrHtmlFromStr(FValue)+'</'+FName+'>'+#13#10;
  end;
end;

function TProfXmlNode1.GetXmlB: WideString;
// Возвращает все дочерние ноды
var
  I: Int32;
begin
  Result := '';
  for I := 0 to FCollection.Count - 1 do begin
    Result := Result + FCollection.Nodes[I].GetXml;
  end;
end;

function TProfXmlNode1.Get_Attribute(Name: WideString): WideString;
begin
  Result := GetAttribute(Name);
end;

function TProfXmlNode1.Get_Attribute_Name(Index: Integer): WideString;
begin
  if (Index >= 0) and (Index < Length(FAttributes)) then
    Result := FAttributes[Index].Name
  else
    Result := '';
end;

function TProfXmlNode1.Get_Attribute_Value(Index: Integer): WideString;
begin
  if (Index >= 0) and (Index < Length(FAttributes)) then
    Result := FAttributes[Index].Value
  else
    Result := '';
end;

function TProfXmlNode1.Get_Collection: IProfXmlCollection;
begin
  Result := FCollection;
end;

function TProfXmlNode1.Get_NodeName: WideString;
begin
  Result := FName;
end;

function TProfXmlNode1.Get_NodeValue: WideString;
begin
  Result := FValue;
end;

function TProfXmlNode1.Get_Xml: WideString;
begin
  Result := GetXml;
end;

function TProfXmlNode1.Load: Boolean;
begin
  Result := False;
end;

function TProfXmlNode1.LoadFromXml(AXml: TProfXmlNode1): Boolean;
var
  ANode: TProfXmlNode1;
  I: Int32;
begin
  Result := False;
  if not(Assigned(AXml)) then Exit;
  FValue := AXml.FValue;
  for I := 0 to AXml.GetCountNodes do begin
    ANode := AXml.GetNode(I);
    GetNodeByName(ANode.GetName).LoadFromXml(ANode);
  end;
  Result := True;
end;

function TProfXmlNode1.NewNode(const AName: WideString): TProfXmlNode1;
begin
  Result := FCollection.NewNode(AName);
end;

function TProfXmlNode1.NodeExist(AName: WideString): Boolean;
begin
  Result := Assigned(FindNode(AName));
end;

function TProfXmlNode1.ReadBool(const AName: WideString; var Value: WordBool): WordBool;
var
  Node: TProfXmlNode1;
begin
  Result := False;
  Node := FindNode(AName);
  if not(Assigned(Node)) then Exit;
  Result := Node.GetValueAsBool(Value);
end;

function TProfXmlNode1.ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool;
var
  Node: TProfXmlNode1;
begin
  Result := False;
  Node := FindNode(AName);
  if not(Assigned(Node)) then Exit;
  Result := Node.GetValueAsDateTime(Value);
end;

function TProfXmlNode1.ReadFloat64(const AName: WideString; var Value: Float64): WordBool;
var
  Code: Cardinal;
  S: WideString;
begin
  Result := ReadString(AName, S);
  if not(Result) then Exit;
  Val(S, Value, Code);
  Result := (Code = 0);
end;

function TProfXmlNode1.ReadInt32(const AName: WideString; var Value: Int32): WordBool;
var
  Node: TProfXmlNode1;
begin
  Result := False;
  Node := FindNode(AName);
  if not(Assigned(Node)) then Exit;
  Result := Node.GetValueAsInt32(Value);
end;

function TProfXmlNode1.ReadInt64(const AName: WideString; AValue: Int64): WordBool;
begin
  Result := NodeExist(AName);
  if not(Result) then Exit;
  Result := FindNode(AName).GetValueAsInt64(AValue);
end;

function TProfXmlNode1.ReadInteger(const AName: WideString; var AValue: Integer): WordBool;
begin
  Result := NodeExist(AName);
  if not(Result) then Exit;
  Result := FindNode(AName).GetValueAsInteger(AValue);
end;

function TProfXmlNode1.ReadNodes(var Value: WideString; CloseTag: WideString): Boolean;
// Чтение вложеных элементов до закрывающего тега
// Value - строка
// CloseTag - закрывающий тег (без </ >)
var
  I: Integer;
  I2: Integer;
  N: TProfXmlNode;
  Tag: WideString;
begin
  Result := False;
  //FValue := '';
  repeat
    I := Pos('<', Value);
    // Запись значения
    if (I = 0) then begin
      FValue := FValue + Value;
    end else begin
      FValue := FValue + Copy(Value, 1, I - 1);
    end;
    if I = 0 then begin
      Result := True;
      Exit;
    end;
    FValue := Copy(Value, 1, I - 1);
    // Очистка от предшествующих символов
    Value := Copy(Value, I + 1, Length(Value));
    I := Pos('>', Value);
    if I = 0 then begin
      AddToLog(lgGeneral, ltError, err_ReadNodes_1, []);
      Result := False;
      Exit;
    end;
    I2 := Pos(WideString('/>'), Value);
    if (I2 > 0) and (I2 < I) then
    begin // "< ... />"
      Tag := Copy(Value, 1, I - 1);
      Delete(Value, 1, I + 1);
      N := NewNode('');
      N.GetNameAndAttributes(Tag);
    end
    else
    begin                      // "< > ... </ >"
      Tag := Copy(Value, 1, I - 1);
      Delete(Value, 1, I);

      if Tag = '/'+CloseTag then begin
        Result := True;
        Exit;
      end;

      N := NewNode('');
      N.GetNameAndAttributes(Tag);
      N.SetXmlA(Value, N.NodeName);
    end;
  until False;
end;

function TProfXmlNode1.ReadString(const AName: WideString; var Value: WideString): WordBool;
begin
  if NodeExist(AName) then Result := FindNode(AName).GetValueAsString(Value) else Result := False;
end;

function TProfXmlNode1.ReadUInt08(const AName: WideString; var Value: UInt08): WordBool;
var
  Node: TProfXmlNode1;
begin
  Result := False;
  Node := FindNode(AName);
  if not(Assigned(Node)) then Exit;
  Result := Node.GetValueAsUInt08(Value);
end;

function TProfXmlNode1.ReadUInt64(const AName: WideString; var Value: UInt64): WordBool;
var
  Node: TProfXmlNode1;
begin
  Result := False;
  Node := FindNode(AName);
  if not(Assigned(Node)) then Exit;
  Result := Node.GetValueAsUInt64(Value);
end;

function TProfXmlNode1.ReadWideString(const AName: WideString; var Value: WideString): WordBool;
var
  Node: TProfXmlNode1;
begin
  Result := False;
  Node := FindNode(AName);
  if not(Assigned(Node)) then Exit;
  Result := Node.GetValueAsString(Value);
end;

procedure TProfXmlNode1.SetName(Value: WideString);
begin
  FName := Value;
end;

function TProfXmlNode1.SetValueAsBool(Value: Boolean): Boolean;
begin
  {$IFDEF VER150}
  FValue := BoolToStr(Value, True);
  {$ELSE}
  if Value then FValue := 'True' else FValue := 'False';
  {$ENDIF}
  Result := True;
end;

function TProfXmlNode1.SetValueAsFloat64(Value: Float64): Boolean;
begin
  FValue := FloatToStr(Value);
  Result := True;
end;

function TProfXmlNode1.SetValueAsInt32(AValue: Int32): Boolean;
begin
  FValue := IntToStr(AValue);
  Result := True;
end;

function TProfXmlNode1.SetValueAsString(AValue: WideString): Boolean;
begin
  FValue := AValue;
  Result := True;
end;

function TProfXmlNode1.SetValueAsUInt08(AValue: UInt08): Boolean;
begin
  FValue := IntToStr(AValue);
  Result := True;
end;

function TProfXmlNode1.SetValueAsUInt64(AValue: UInt64): Boolean;
begin
  FValue := IntToStr(AValue);
  Result := True;
end;

function TProfXmlNode1.SetXml(Value: WideString): Boolean;
// Создает новую дочернюю структуру, разбирая строку
// Value - элемент
var
  I: Integer;
  I2: Integer;
  Tag: String;
begin
  Result := False;
  FValue := '';
  //repeat
    I := Pos('<', Value);
    // Запись значения
    if (I = 0) then begin
      FValue := FValue + Value;
    end else begin
      FValue := FValue + Copy(Value, 1, I - 1);
    end;
    FValue := StrHtmlToStr(FValue);  // Преобразование символов
    if I = 0 then begin
      Result := True;
      Exit;
    end;
    FValue := Copy(Value, 1, I - 1);
    Delete(Value, 1, I);
    I := Pos('>', Value);
    I2 := Pos(WideString('/>'), Value);
    if (I = 0) then begin
      AddToLog(lgGeneral, ltError, 'Не найден закрывающий символ ">"', []);
      Exit;
    end;
    if I2 <> I - 1 then I2 := 0; // I2 должен отставать от I на 1 символ
    if I2 = 0 then begin
      Tag := Copy(Value, 1, I - 1);
    end else begin
      Tag := Copy(Value, 1, I2 - 1);
    end;
    Delete(Value, 1, I); // Удаление начала описания нода
    // ..........

    GetNameAndAttributes(Tag); // Выделить имя и атрибуты их строки "tag attr1="value1" attr2="value2""
    Value := strDeleteSpace(Value, [dsFirst, dsLast]);
    Result := ReadNodes(Value, FName); // Читать ноды из строки до закрывающего тега
  //until False;
end;

function TProfXmlNode1.SetXmlA(var Value: WideString; CloseTag: WideString = ''): WordBool;
// Создает новую дочернюю структуру, разбирая строку
// Value - дочерние элементы
begin
  Result := ReadNodes(Value, CloseTag);
end;

procedure TProfXmlNode1.Set_Attribute(Name, Value: WideString);
var
  I: Integer;
begin
  if Name = '' then Exit;
  // Поиск атрибута
  for I := 0 to High(FAttributes) do if FAttributes[I].Name = Name then begin
    FAttributes[I].Value := Value;
    Exit;
  end;
  // Создание атрибута
  I := Length(FAttributes);
  SetLength(FAttributes, I + 1);
  FAttributes[I].Name := Name;
  FAttributes[I].Value := Value;
end;

procedure TProfXmlNode1.Set_NodeName(Value: WideString);
begin
  FName := Value;
end;

procedure TProfXmlNode1.Set_NodeValue(Value: WideString);
begin
  FValue := Value;
end;

procedure TProfXmlNode1.Set_Xml(const Value: WideString);
begin
  SetXml(Value);
end;

function TProfXmlNode1.ToStrings(AStrings: TStrings; Prefix: String = ''): Boolean;
var
  I: Int32;
begin
  Result := False;
  if not(Assigned(AStrings)) then Exit;
  if GetCountNodes > 0 then begin
    AStrings.Add(Prefix + '<'+FName+'>');
    for I := 0 to FCollection.Count - 1 do begin
      FCollection.Nodes[I].ToStrings(AStrings, Prefix + '  ');
    end;
    AStrings.Add(Prefix + '</'+FName+'>');
  end else begin
    if FValue = '' then
      AStrings.Add(Prefix + '<'+FName+'/>')
    else
      AStrings.Add(Prefix + '<'+FName+'>'+FValue+'</'+FName+'>');
  end;
  Result := True;
end;

function TProfXmlNode1.WriteBool(const AName: WideString; Value: WordBool): WordBool;
begin
  Result := GetNodeByName(AName).SetValueAsBool(Value);
end;

function TProfXmlNode1.WriteFloat64(const AName: WideString; Value: Float64): WordBool;
begin
  Result := GetNodeByName(AName).SetValueAsFloat64(Value);
end;

function TProfXmlNode1.WriteInt32(const AName: WideString; Value: Int32): WordBool;
begin
  Result := GetNodeByName(AName).SetValueAsInt32(Value);
end;

function TProfXmlNode1.WriteInt64(const AName: WideString; Value: Int64): WordBool;
begin
  Result := WriteInt32(AName, Value);
end;

function TProfXmlNode1.WriteInteger(const AName: WideString; Value: Integer): WordBool;
begin
  Result := WriteInt32(AName, Value);
end;

function TProfXmlNode1.WriteString(const AName, Value: WideString): WordBool;
begin
  Result := GetNodeByName(AName).SetValueAsString(Value);
end;

function TProfXmlNode1.WriteUInt08(const AName: WideString; AValue: UInt08): WordBool;
begin
  Result := GetNodeByName(AName).SetValueAsUInt08(AValue);
end;

function TProfXmlNode1.WriteUInt64(const AName: WideString; AValue: UInt64): WordBool;
begin
  Result := GetNodeByName(AName).SetValueAsUInt64(AValue);
end;

function TProfXmlNode1.WriteXml(const AName, Value: WideString): WordBool;
begin
  Result := GetNodeByName(AName).SetXml(Value);
end;

function TProfXmlNode1._GetValueAsBool: WordBool;
begin
  Result := False;
  GetValueAsBool(Result);
end;

function TProfXmlNode1._GetValueAsString: WideString;
begin
  Result := '';
  GetValueAsString(Result);
end;

procedure TProfXmlNode1._SetValueAsBool(Value: WordBool);
begin
  SetValueAsBool(Value);
end;

procedure TProfXmlNode1._SetValueAsString(Value: WideString);
begin
  SetValueAsString(Value);
end;
{$ENDIF}

{ TProfXmlDocument2 }

{$IFDEF XML2}
function TProfXmlDocument2.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
begin
  if Assigned(FAddToLog) then
    Result := FAddToLog(AGroup, AType, AStrMsg, AParams)
  else
    Result := False;
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

function TProfXmlDocument2.GetDocumentElement: TProfXmlNode2;
begin
  Result := FDocumentElement;
end;

function TProfXmlDocument2.LoadFromString(const Value: WideString): WordBool;
begin
  FDocument.LoadFromXml(Value);
  Result := True;
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
