{**
@Author Prof1983 <prof1983@ya.ru>
@Created 23.05.2005
@LastMod 18.12.2012
}
unit ALogProgramObj;

interface

uses
  ABase,
  ALogDocumentObj,
  ATypes;

type //** @abstract(Работа с Log. Передает сообщения классу TProgram)
  TALogProgramObject = class(TALogDocumentObject)
  public
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: APascalString): AInt; override;
  public
    constructor Create();
    procedure Show(); virtual;
  end;

  //TLogProgram = TALogProgramObject;

implementation

uses
  AProgramObj;

{ TALogProgramObject }

function TALogProgramObject.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: APascalString): AInt;
var
  FProgram: TAProgramObject;
begin
  inherited AddToLog(LogGroup, LogType, StrMsg);
  try
    FProgram := TAProgramObject.GetInstance();
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

constructor TALogProgramObject.Create();
begin
  inherited Create();
  FLogType := lProgram;
end;

procedure TALogProgramObject.Show();
//var
  //FProgram: TAProgramObject;
begin
  {
  try
    FProgram := TAProgramObject.GetInstance();
    if Assigned(FProgram) and (FProgram is TProgramLog) then
      TProgramLog(FProgram).LogDocuments.Show();
  except
  end;
  }
end;

end.
