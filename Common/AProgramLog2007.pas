{**
@Abstract(Реализация основной функциональности для главного объекта с логами)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.05.2006)
@LastMod(05.07.2012)
@Version(0.5)
}
unit AProgramLog2007;

interface

uses
  ALogDocuments2007, ALogDocumentsAll, AProgramImpl, ATypes;

type
  TProgramLog = class(TProfProgram)
  private
    FLogFilePath: WideString;
    FLogTypeSet: TLogTypeSet;
  protected
    function DoStart(): WordBool; override;
    function DoStoped(AIsShutDown: WordBool): WordBool; override;
  public
    constructor Create(); override;
  published
      //** Путь к файлу логирования .txt
    property LogFilePath: WideString read FLogFilePath write FLogFilePath;
      //** Устанавливаем в какие места выводить Log
    property LogTypeSet: TLogTypeSet read FLogTypeSet write FLogTypeSet;
  end;

implementation

{ TProgramLog }

constructor TProgramLog.Create();
begin
  inherited Create();
  FLogTypeSet := [lWindow, lLogSystem, lFile];
end;

function TProgramLog.DoStart(): WordBool;
begin
  Result := inherited DoStart();       {AConfig.DocumentElement.GetNodeByName('Logs')}
  FLogDocuments := TLogDocumentsAll.Create(nil, FLogTypeSet, FLogFilePath, ProgramID, ProgramName);
  //TLogDocuments(FLogDocuments).OnCommand := DoCommand;
  if IsDebug then
    FLogDocuments.Show();
end;

function TProgramLog.DoStoped(AIsShutDown: WordBool): WordBool;
begin
  {if Assigned(FLogDocuments) then
  try
    FLogDocuments.Finalize();
    FLogDocuments.Free();
  finally
    FLogDocuments := nil;
  end;}
  Result := inherited DoStoped(AIsShutDown);
end;

end.
 