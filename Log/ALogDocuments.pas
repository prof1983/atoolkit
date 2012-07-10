{**
@Abstract(Класс, объединяющий вывод логов сразу в несколько мест)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.01.2006)
@LastMod(10.07.2012)
@Version(0.5)
}
unit ALogDocuments;

// TODO Rename to ALogDocumentsImpl.pas

interface

uses
  SysUtils, XmlIntf,
  ALogDocumentImpl, ALogDocumentIntf, ALogNodeImpl, ALogNodeIntf, ATypes;

type //** Класс для записи Log сразу в несколько мест
  TALogDocuments = class(TALogDocument, IALogDocuments)
  protected
    FDocuments: array of TALogDocument;
  public
    procedure SetOnCommand(Value: TProcMessageStr); override;
  public // IALogDocuments
    function GetDocumentById(Id: Int64): ALogDocument;
    function GetDocumentByIndex(Index: Integer): ALogDocument;
    function GetDocumentCount(): Integer;
  public // IALogDocument
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override;
  public // IALogDocuments
    function Add(Document: ALogDocument): Integer;
    function Delete(Index: Integer): Integer;
    function Insert(Index: Integer; Document: ALogDocument): Integer;
  public
    function AddLogDocument(Document: TALogDocument): Integer;
    function AddMsg(const AMsg: WideString): Integer; override;
    function AddStr(const AStr: WideString): Integer; override;
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Boolean; override;
    function ConfigureLoad(): WordBool; override;
    function ConfigureSave(): WordBool; override;
    function NewNode(LogType: TLogTypeMessage; const Msg: WideString;
        Parent: Integer = 0; Id: Integer = 0): TALogNode; override;
    procedure Show(); override;
  public
    constructor Create();
  public
    property DocumentById[Id: Int64]: ALogDocument read GetDocumentById;
    property DocumentByIndex[Index: Integer]: ALogDocument read GetDocumentByIndex;
    property DocumentCount: Integer read GetDocumentCount;
  end;

  //TLogDocuments = TALogDocuments;

implementation

{ TALogDocuments }

function TALogDocuments.Add(Document: ALogDocument): Integer;
begin
  if TObject(Document) is TALogDocument then
    Result := AddLogDocument(TALogDocument(Document))
  else
    Result := -1;
end;

function TALogDocuments.AddLogDocument(Document: TALogDocument): Integer;
begin
  Result := Length(FDocuments);
  SetLength(FDocuments, Result + 1);
  FDocuments[Result] := Document;
end;

function TALogDocuments.AddMsg(const AMsg: WideString): Integer;
var
  i: Integer;
begin
  Result := inherited AddMsg(AMsg);
  for i := 0 to High(FDocuments) do
    FDocuments[i].AddMsg(AMsg);
end;

function TALogDocuments.AddStr(const AStr: WideString): Integer;
var
  i: Integer;
begin
  Result := inherited AddStr(AStr);
  for i := 0 to High(FDocuments) do
    FDocuments[i].AddStr(AStr);
end;

function TALogDocuments.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString): Integer;
var
  I: Integer;
  R: Integer;
begin
  Result := inherited AddToLog(AGroup, AType, AStrMsg);
  for I := 0 to High(FDocuments) do
  begin
    R := FDocuments[I].AddToLog(AGroup, AType, AStrMsg);
    if R >= 0 then
      Result := R;
  end;
end;

function TALogDocuments.AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: string; AParams: array of const): Boolean;
var
  S: WideString;
begin
  try
    S := Format(AStrMsg, AParams);
  except
    S := AStrMsg;
  end;
  Result := (AddToLog(AGroup, AType, S) >= 0);
end;

function TALogDocuments.ConfigureLoad(): WordBool;
var
  i: Integer;
begin
  Result := inherited ConfigureLoad();
  for i := 0 to High(FDocuments) do FDocuments[i].ConfigureLoad();
end;

function TALogDocuments.ConfigureSave(): WordBool;
var
  I: Integer;
begin
  Result := inherited ConfigureSave();
  for I := 0 to High(FDocuments) do FDocuments[I].ConfigureSave();
end;

constructor TALogDocuments.Create();
begin
  inherited Create(lDocuments);
end;

function TALogDocuments.Delete(Index: Integer): Integer;
begin
  Result := -1;
end;

function TALogDocuments.GetDocumentById(Id: Int64): ALogDocument;
begin
  Result := 0;
end;

function TALogDocuments.GetDocumentCount(): Integer;
begin
  Result := 0;
end;

function TALogDocuments.GetDocumentByIndex(Index: Integer): ALogDocument;
begin
  Result := 0;
end;

function TALogDocuments.Insert(Index: Integer; Document: ALogDocument): Integer;
begin
  Result := -1;
end;

function TALogDocuments.NewNode(LogType: TLogTypeMessage; const Msg: WideString;
    Parent, Id: Integer): TALogNode;
var
  I: Integer;
begin
  Result := inherited NewNode(LogType, Msg, Parent, Id);
  for I := 0 to High(FDocuments) do
    FDocuments[I].NewNode(LogType, Msg, Parent, Result.Id);
end;

procedure TALogDocuments.SetOnCommand(Value: TProcMessageStr);
var
  I: Integer;
begin
  inherited SetOnCommand(Value);
  for I := 0 to High(FDocuments) do
    FDocuments[I].OnCommand := Value;
end;

procedure TALogDocuments.Show();
var
  I: Integer;
begin
  for I := 0 to High(FDocuments) do
    FDocuments[I].Show();
end;

end.
