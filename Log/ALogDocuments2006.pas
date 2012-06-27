{**
@Abstract(Класс, объединяющий вывод логов сразу в несколько мест)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.01.2006)
@LastMod(27.06.2012)
@Version(0.5)
}
unit ALogDocuments2006;

interface

uses
  {unConfig2006,} ALogGlobals2006, ATypes;

type //** Класс для записи Log сразу в несколько мест
  TLogDocuments = class(TLogDocumentA)
  private
    FDocuments: array of TLogDocument;
  protected
    procedure SetOnCommand(Value: TProcMessageStr); override;
  public
    function AddLogDocument(ADocument: TLogDocument): Integer;
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean; override;
    constructor Create();
    function ConfigureLoad(): WordBool; override;
    function ConfigureSave(): WordBool; override;
    function NewNode(AType: TLogTypeMessage; const AMsg: WideString; AParent: Integer = 0; AId: Integer = 0): TLogNode; override;
    procedure Show(); override;
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer; override;
  end;

implementation

{ TLogDocuments }

function TLogDocuments.AddLogDocument(ADocument: TLogDocument): Integer;
begin
  Result := Length(FDocuments);
  SetLength(FDocuments, Result + 1);
  FDocuments[Result] := ADocument;
end;

function TLogDocuments.AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
begin
  Result := (ToLog(AGroup, AType, AStrMsg, AParams) >= 0);
end;

function TLogDocuments.ConfigureLoad(): WordBool;
var
  i: Integer;
begin
  Result := inherited ConfigureLoad();
  for i := 0 to High(FDocuments) do FDocuments[i].ConfigureLoad();
end;

function TLogDocuments.ConfigureSave(): WordBool;
var
  I: Integer;
begin
  Result := inherited ConfigureSave();
  for I := 0 to High(FDocuments) do FDocuments[I].ConfigureSave();
end;

constructor TLogDocuments.Create();
begin
  inherited Create(lDocuments);
end;

function TLogDocuments.NewNode(AType: TLogTypeMessage; const AMsg: WideString; AParent: Integer = 0; AId: Integer = 0): TLogNode;
var
  I: Integer;
begin
  Result := inherited NewNode(AType, AMsg, AParent, AId);
  for I := 0 to High(FDocuments) do
    FDocuments[I].NewNode(AType, AMsg, AParent, Result.Id);
end;

procedure TLogDocuments.SetOnCommand(Value: TProcMessageStr);
var
  I: Integer;
begin
  inherited SetOnCommand(Value);
  for I := 0 to High(FDocuments) do
    FDocuments[I].OnCommand := Value;
end;

procedure TLogDocuments.Show();
var
  I: Integer;
begin
  for I := 0 to High(FDocuments) do
    FDocuments[I].Show;
end;

function TLogDocuments.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
var
  I: Integer;
  R: Integer;
begin
  Result := inherited ToLog(AGroup, AType, AStrMsg, AParams);
  for I := 0 to High(FDocuments) do
  begin
    R := FDocuments[I].ToLog(AGroup, AType, AStrMsg, AParams);
    if R >= 0 then
      Result := R;
  end;
end;

end.
