{**
@Abstract(Работа с Log. Передает сообщения классу TProgram)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.05.2005)
@LastMod(05.07.2012)
@Version(0.5)
}
unit ALogProgram;

interface

uses
  ALogDocumentImpl, ATypes;

type //** @abstract(Работа с Log. Передает сообщения классу TProgram)
  TLogProgram = class(TALogDocument)
  public
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Boolean; override;
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; override;
  public
    constructor Create();
    procedure Show(); override;
  end;

implementation

uses
  AProgramLog2007, AProgramImpl;

{ TLogProgram }

function TLogProgram.AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: string; AParams: array of const): Boolean;
var
  FProgram: TProfProgram;
begin
  Result := False;
  try
    FProgram := TProfProgram.GetInstance();
    if Assigned(FProgram) then
      Result := FProgram.AddToLog2(AGroup, AType, AStrMsg, AParams);
  except
  end;
end;

constructor TLogProgram.Create();
begin
  inherited Create(lProgram);
end;

procedure TLogProgram.Show();
var
  FProgram: TProfProgram;
begin
  try
    FProgram := TProfProgram.GetInstance();
    if Assigned(FProgram) and (FProgram is TProgramLog) then
      TProgramLog(FProgram).LogDocuments.Show();
  except
  end;
  inherited Show();
end;

function TLogProgram.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString; AParams: array of const): Integer;
var
  FProgram: TProfProgram;
begin
  Result := -1;
  try
    FProgram := TProfProgram.GetInstance();
    if Assigned(FProgram) then
      Result := FProgram.ToLog(AGroup, AType, AStrMsg, AParams);
  except
  end;
end;

end.
