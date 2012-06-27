{**
@Abstract(Класс, объединяющий вывод логов сразу в несколько мест)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.01.2006)
@LastMod(27.06.2012)
@Version(0.5)
}
unit ALogDocuments2007;

interface

uses
  SysUtils, XmlIntf,
  ALogDocumentImpl, ALogDocumentIntf, ALogNodeImpl, ATypes;

type //** @abstract(Класс для записи Log сразу в несколько мест)
  TLogDocuments = class(TLogDocumentA1, ILogDocuments2)
  private
    FDocuments: array of ILogDocument2;
  protected
    procedure SetOnCommand(Value: TProcMessageStr); override;
  public
    function AddLogDocument(ADocument: ILogDocument2): Integer;
    procedure AddMsg(const AMsg: WideString); override;
    procedure AddStr(const AStr: WideString); override;
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Boolean; override;
    constructor Create();
    function NewNode(AType: TLogTypeMessage; const AMsg: WideString; AParent: Integer = 0; AId: Integer = 0): TALogNode2; override;
    procedure Show(); override;
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; override;
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override;
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer; override;
  end;

implementation

{ TLogDocuments }

function TLogDocuments.AddLogDocument(ADocument: ILogDocument2): Integer;
begin
  Result := Length(FDocuments);
  SetLength(FDocuments, Result + 1);
  FDocuments[Result] := ADocument;
end;

procedure TLogDocuments.AddMsg(const AMsg: WideString);
var
  i: Integer;
begin
  inherited;
  for i := 0 to High(FDocuments) do
    FDocuments[i].AddMsg(AMsg);
end;

procedure TLogDocuments.AddStr(const AStr: WideString);
var
  i: Integer;
begin
  inherited;
  for i := 0 to High(FDocuments) do
    FDocuments[i].AddStr(AStr);
end;

function TLogDocuments.AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: string; AParams: array of const): Boolean;
begin
  Result := (ToLog(AGroup, AType, AStrMsg, AParams) >= 0);
end;

constructor TLogDocuments.Create();
begin
  inherited Create(lDocuments);
end;

function TLogDocuments.NewNode(AType: TLogTypeMessage; const AMsg: WideString; AParent: Integer = 0; AId: Integer = 0): TALogNode2;
var
  I: Integer;
begin
  Result := inherited NewNode(AType, AMsg, AParent, AId);
  for I := 0 to High(FDocuments) do
    TLogDocument(FDocuments[I]).NewNode(AType, AMsg, AParent, Result.Id);
end;

procedure TLogDocuments.SetOnCommand(Value: TProcMessageStr);
{var
  I: Integer;}
begin
  inherited SetOnCommand(Value);
  {for I := 0 to High(FDocuments) do
    TLogDocument(FDocuments[I]).OnCommand := Value;}
end;

procedure TLogDocuments.Show();
var
  I: Integer;
begin
  for I := 0 to High(FDocuments) do FDocuments[I].Show;
end;

function TLogDocuments.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
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

function TLogDocuments.ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
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

function TLogDocuments.ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
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
