{**
@Abstract Класс, объединяющий вывод логов сразу в несколько мест
@Author Prof1983 <prof1983@ya.ru>
@Created 26.01.2006
@LastMod 18.12.2012
}
unit ALogDocumentListObj;

interface

uses
  ABase,
  ALogDocumentObj,
  ALogNodeUtils,
  ATypes;

type //** Класс для записи Log сразу в несколько мест
  TALogDocumentListObject = class(TALogDocumentObject)
  protected
    FDocuments: array of TALogDocumentObject;
  public
    procedure SetOnCommand(Value: TProcMessageStr); override;
  public
    function GetDocumentById(Id: Int64): ALogDocument;
    function GetDocumentByIndex(Index: Integer): ALogDocument;
    function GetDocumentCount(): Integer;
  public
    function Add(Document: ALogDocument): Integer;
    function AddLogDocument(Document: TALogDocumentObject): Integer;
    function AddMsg(const AMsg: WideString): Integer; override;
    function AddStr(const AStr: WideString): Integer; override;
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: APascalString): AInt; override;
    function Delete(Index: Integer): Integer;
    function Insert(Index: Integer; Document: ALogDocument): Integer;
    function NewNode(LogType: TLogTypeMessage; const Msg: WideString;
        Parent: AInt = 0; Id: AInt = 0): ALogNode; override;
  public
    constructor Create();
  public
    property DocumentById[Id: Int64]: ALogDocument read GetDocumentById;
    property DocumentByIndex[Index: Integer]: ALogDocument read GetDocumentByIndex;
    property DocumentCount: Integer read GetDocumentCount;
  end;

  //TALogDocuments = TALogDocumentListObject;

implementation

{ TALogDocuments }

function TALogDocumentListObject.Add(Document: ALogDocument): Integer;
begin
  if (TObject(Document) is TALogDocumentObject) then
    Result := AddLogDocument(TALogDocumentObject(Document))
  else
    Result := -1;
end;

function TALogDocumentListObject.AddLogDocument(Document: TALogDocumentObject): Integer;
begin
  Result := Length(FDocuments);
  SetLength(FDocuments, Result + 1);
  FDocuments[Result] := Document;
end;

function TALogDocumentListObject.AddMsg(const AMsg: WideString): Integer;
var
  i: Integer;
begin
  Result := inherited AddMsg(AMsg);
  for i := 0 to High(FDocuments) do
    FDocuments[i].AddMsg(AMsg);
end;

function TALogDocumentListObject.AddStr(const AStr: WideString): Integer;
var
  i: Integer;
begin
  Result := inherited AddStr(AStr);
  for i := 0 to High(FDocuments) do
    FDocuments[i].AddStr(AStr);
end;

function TALogDocumentListObject.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: APascalString): AInt;
var
  I: Integer;
  R: Integer;
begin
  Result := inherited AddToLog(LogGroup, LogType, StrMsg);
  for I := 0 to High(FDocuments) do
  begin
    R := FDocuments[I].AddToLog(LogGroup, LogType, StrMsg);
    if R >= 0 then
      Result := R;
  end;
end;

constructor TALogDocumentListObject.Create();
begin
  inherited Create();
  FLogType := lDocuments;
end;

function TALogDocumentListObject.Delete(Index: Integer): Integer;
begin
  Result := -1;
end;

function TALogDocumentListObject.GetDocumentById(Id: Int64): ALogDocument;
begin
  Result := 0;
end;

function TALogDocumentListObject.GetDocumentCount(): Integer;
begin
  Result := 0;
end;

function TALogDocumentListObject.GetDocumentByIndex(Index: Integer): ALogDocument;
begin
  Result := 0;
end;

function TALogDocumentListObject.Insert(Index: Integer; Document: ALogDocument): Integer;
begin
  Result := -1;
end;

function TALogDocumentListObject.NewNode(LogType: TLogTypeMessage; const Msg: WideString;
    Parent, Id: AInt): ALogNode;
var
  I: Integer;
  NodeId: AInt;
begin
  Result := inherited NewNode(LogType, Msg, Parent, Id);
  NodeId := ALogNode_GetId(Result);
  for I := 0 to High(FDocuments) do
    FDocuments[I].NewNode(LogType, Msg, Parent, NodeId);
end;

procedure TALogDocumentListObject.SetOnCommand(Value: TProcMessageStr);
var
  I: Integer;
begin
  inherited SetOnCommand(Value);
  for I := 0 to High(FDocuments) do
    FDocuments[I].SetOnCommand(Value);
end;

end.
