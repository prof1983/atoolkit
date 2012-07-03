{**
@Abstract(Класс, объединяющий вывод логов сразу в несколько мест)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.01.2006)
@LastMod(03.07.2012)
@Version(0.5)
}
unit ALogDocuments;

// TODO Rename to ALogDocumentsImpl.pas

interface

uses
  SysUtils, XmlIntf,
  ALogDocumentImpl, ALogDocumentIntf, ALogNodeImpl, ALogNodeIntf, ATypes;

type //** Класс для записи Log сразу в несколько мест
  TLogDocuments = class(TALogDocument, ILogDocuments)
  private
    FDocuments: array of ILogDocument;
  protected
    procedure SetOnCommand(Value: TProcMessageStr); override;
  public
    function AddLogDocument(ADocument: ILogDocument): Integer;
    function AddMsg(const AMsg: WideString): Integer; override;
    function AddStr(const AStr: WideString): Integer; override;
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; override;
    constructor Create();
    function NewNode(AType: TLogTypeMessage; const AMsg: WideString; AParent: Integer = 0; AId: Integer = 0): TALogNode{IProfLogNode}; override;
    procedure Show(); override;
  end;

  {** Класс для записи Log сразу в несколько мест }
  TLogDocuments2007 = class(TALogDocument, ILogDocuments2)
  private
    FDocuments: array of ILogDocument2;
  protected
    procedure SetOnCommand(Value: TProcMessageStr); override;
  public
    function AddLogDocument(ADocument: ILogDocument2): Integer;
    function AddMsg(const AMsg: WideString): Integer; override;
    function AddStr(const AStr: WideString): Integer; override;
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Boolean; override;
    constructor Create();
    function NewNode(LogType: TLogTypeMessage; const Msg: WideString;
        Parent: Integer = 0; Id: Integer = 0): TALogNode; override;
    procedure Show(); override;
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; override;
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override;
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer; override;
  end;

type //** Класс для записи Log сразу в несколько мест
  TProfLogDocuments3 = class(TProfLogDocument3, IProfLogDocuments)
  private
    FDocuments: array of IProfLogDocument;
  protected
    function GetDocumentByID(ID: Int64): IProfLogDocument; safecall;
    function GetDocumentByIndex(Index: Integer): IProfLogDocument; safecall;
    function GetDocumentCount(): Integer; safecall;
    procedure SetOnCommand(Value: TProcMessageStr); override;
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

function TLogDocuments.NewNode(AType: TLogTypeMessage; const AMsg: WideString; AParent: Integer = 0; AId: Integer = 0): TALogNode{IProfLogNode};
var
  I: Integer;
begin
  Result := inherited NewNode(AType, AMsg, AParent, AId);
  for I := 0 to High(FDocuments) do
    TLogDocument(FDocuments[I]).NewNode(AType, AMsg, AParent, Result.Id);
end;

procedure TLogDocuments.SetOnCommand(Value: TProcMessageStr);
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

procedure TProfLogDocuments3.SetOnCommand(Value: TProcMessageStr);
{var
  I: Integer;}
begin
  {inherited SetOnCommand(Value);
  for I := 0 to High(FDocuments) do
    TLogDocument(FDocuments[I]).OnCommand := Value;}
end;

{ TLogDocuments2007 }

function TLogDocuments2007.AddLogDocument(ADocument: ILogDocument2): Integer;
begin
  Result := Length(FDocuments);
  SetLength(FDocuments, Result + 1);
  FDocuments[Result] := ADocument;
end;

function TLogDocuments2007.AddMsg(const AMsg: WideString): Integer;
var
  i: Integer;
begin
  inherited;
  for i := 0 to High(FDocuments) do
    FDocuments[i].AddMsg(AMsg);
  Result := 0;
end;

function TLogDocuments2007.AddStr(const AStr: WideString): Integer;
var
  i: Integer;
begin
  inherited;
  for i := 0 to High(FDocuments) do
    FDocuments[i].AddStr(AStr);
  Result := 0;
end;

function TLogDocuments2007.AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: string; AParams: array of const): Boolean;
begin
  Result := (ToLog(AGroup, AType, AStrMsg, AParams) >= 0);
end;

constructor TLogDocuments2007.Create();
begin
  inherited Create(lDocuments);
end;

function TLogDocuments2007.NewNode(LogType: TLogTypeMessage; const Msg: WideString;
    Parent: Integer = 0; Id: Integer = 0): TALogNode;
var
  I: Integer;
begin
  Result := inherited NewNode(LogType, Msg, Parent, Id);
  for I := 0 to High(FDocuments) do
    TLogDocument(FDocuments[I]).NewNode(LogType, Msg, Parent, Result.Id);
end;

procedure TLogDocuments2007.SetOnCommand(Value: TProcMessageStr);
{var
  I: Integer;}
begin
  inherited SetOnCommand(Value);
  {for I := 0 to High(FDocuments) do
    TLogDocument(FDocuments[I]).OnCommand := Value;}
end;

procedure TLogDocuments2007.Show();
var
  I: Integer;
begin
  for I := 0 to High(FDocuments) do FDocuments[I].Show;
end;

function TLogDocuments2007.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
var
  I: Integer;
  R: Integer;
  S: WideString;
begin
  Result := inherited ToLog(AGroup, AType, AStrMsg, AParams);
  try
    S := Format(AStrMsg, AParams);
  except
    S := AStrMsg;
  end;
  for I := 0 to High(FDocuments) do
  begin
    R := FDocuments[I].ToLogA(AGroup, AType, S);
    if R >= 0 then
      Result := R;
  end;
end;

function TLogDocuments2007.ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString): Integer;
var
  I: Integer;
  R: Integer;
begin
  Result := inherited ToLogA(AGroup, AType, AStrMsg);
  for I := 0 to High(FDocuments) do
  begin
    R := FDocuments[I].ToLogA(AGroup, AType, AStrMsg);
    if R >= 0 then
      Result := R;
  end;
end;

function TLogDocuments2007.ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
    const AStrMsg: WideString): Integer;
var
  I: Integer;
  R: Integer;
begin
  Result := inherited ToLogE(AGroup, AType, AStrMsg);
  for I := 0 to High(FDocuments) do
  begin
    R := FDocuments[I].ToLogE(AGroup, AType, AStrMsg);
    if R >= 0 then
      Result := R;
  end;
end;

end.
