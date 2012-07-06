{**
@Abstract(Работа с Log. Передает сообщения классу TProgram)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.05.2005)
@LastMod(06.07.2012)
@Version(0.5)
}
unit ALogProgram;

interface

uses
  ABase, ALogDocumentImpl, ATypes;

type //** @abstract(Работа с Log. Передает сообщения классу TProgram)
  TLogProgram = class(TALogDocument)
  public
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: WideString): AInt; override;
  public
    constructor Create();
    procedure Show(); override;
  end;

implementation

uses
  AProgramLog2007, AProgramImpl;

{ TLogProgram }

function TLogProgram.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: WideString): AInt;
var
  FProgram: TProfProgram;
begin
  inherited AddToLog(LogGroup, LogType, StrMsg);
  try
    FProgram := TProfProgram.GetInstance();
    if not(Assigned(FProgram)) then
    begin
      Result := -2;
      Exit;
    end;
    Result := FProgram.AddToLog(LogGroup, LogType, StrMsg);
  except
    Result := -1;
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

end.
