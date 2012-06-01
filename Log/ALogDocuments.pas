{**
@Abstract(Класс, объединяющий вывод логов сразу в несколько мест)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.01.2006)
@LastMod(26.04.2012)
@Version(0.5)
}
unit ALogDocuments;

interface

uses
  SysUtils, XmlIntf,
  ALogDocumentImpl, ALogDocumentIntf, ALogNodeIntf, ATypes;

type //** Класс для записи Log сразу в несколько мест
  TLogDocuments = class(TLogDocumentA, ILogDocuments)
  private
    FDocuments: array of ILogDocument;
  protected
    procedure SetOnCommand(Value: TProcMessage); override;
  public
    function AddLogDocument(ADocument: ILogDocument): Integer; safecall;
    function AddMsg(const AMsg: WideString): Integer; override; safecall;
    function AddStr(const AStr: WideString): Integer; override; safecall;
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; override;
    constructor Create();
    function NewNode(AType: TLogTypeMessage; const AMsg: WideString; AParent: Integer = 0; AId: Integer = 0): IProfLogNode; override;
    procedure Show(); override; safecall;
  end;

type //** Класс для записи Log сразу в несколько мест
  TProfLogDocuments3 = class(TProfLogDocument3, IProfLogDocuments)
  private
    FDocuments: array of IProfLogDocument;
  protected
    function GetDocumentByID(ID: Int64): IProfLogDocument; safecall;
    function GetDocumentByIndex(Index: Integer): IProfLogDocument; safecall;
    function GetDocumentCount(): Integer; safecall;
    procedure SetOnCommand(Value: TProcMessage); override;
  public
    function Add(Document: IProfLogDocument): Integer; safecall;
    function Delete(Index: Integer): Integer; safecall;
    function Insert(Index: Integer; Document: IProfLogDocument): Integer; safecall;
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override;
  public
    property DocumentByID[ID: Int64]: IProfLogDocument read GetDocumentByID;
    property DocumentByIndex[Index: Integer]: IProfLogDocument read GetDocumentByIndex;
    property DocumentCount: Integer read GetDocumentCount;
  end;

implementation

{ TLogDocuments }

function TLogDocuments.AddLogDocument(ADocument: ILogDocument): Integer;
begin
  Result := Length(FDocuments);
  SetLength(FDocuments, Result + 1);
  FDocuments[Result] := ADocument;
end;

function TLogDocuments.AddMsg(const AMsg: WideString): Integer;
var
  i: Integer;
begin
  Result := inherited AddMsg(AMsg);
  for i := 0 to High(FDocuments) do
    FDocuments[i].AddMsg(AMsg);
end;

function TLogDocuments.AddStr(const AStr: WideString): Integer;
var
  i: Integer;
begin
  Result := inherited AddStr(AStr);
  for i := 0 to High(FDocuments) do
    FDocuments[i].AddStr(AStr);
end;

function TLogDocuments.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
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

constructor TLogDocuments.Create();
begin
  inherited Create(lDocuments);
end;

function TLogDocuments.NewNode(AType: TLogTypeMessage; const AMsg: WideString; AParent: Integer = 0; AId: Integer = 0): IProfLogNode;
var
  I: Integer;
begin
  Result := inherited NewNode(AType, AMsg, AParent, AId);
  for I := 0 to High(FDocuments) do
    TLogDocument(FDocuments[I]).NewNode(AType, AMsg, AParent, Result.Id);
end;

procedure TLogDocuments.SetOnCommand(Value: TProcMessage);
var
  I: Integer;
begin
  inherited SetOnCommand(Value);
  for I := 0 to High(FDocuments) do
    TLogDocument(FDocuments[I]).OnCommand := Value;
end;

procedure TLogDocuments.Show();
var
  I: Integer;
begin
  for I := 0 to High(FDocuments) do FDocuments[I].Show;
end;

{ TProfLogDocuments3 }

function TProfLogDocuments3.Add(Document: IProfLogDocument): Integer;
begin
  Result := 0;
  // ...
end;

function TProfLogDocuments3.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
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

function TProfLogDocuments3.GetDocumentByID(ID: Int64): IProfLogDocument;
begin

end;

function TProfLogDocuments3.GetDocumentCount: Integer;
begin

end;

function TProfLogDocuments3.GetDocumentByIndex(Index: Integer): IProfLogDocument;
begin

end;

function TProfLogDocuments3.Delete(Index: Integer): Integer;
begin

end;

function TProfLogDocuments3.Insert(Index: Integer;
  Document: IProfLogDocument): Integer;
begin

end;

procedure TProfLogDocuments3.SetOnCommand(Value: TProcMessage);
{var
  I: Integer;}
begin
  {inherited SetOnCommand(Value);
  for I := 0 to High(FDocuments) do
    TLogDocument(FDocuments[I]).OnCommand := Value;}
end;

end.
