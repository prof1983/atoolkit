{**
@Abstract Реализация основной функциональности для главного объекта с логами
@Author Prof1983 <prof1983@ya.ru>
@Created 23.05.2006
@LastMod 04.02.2013
}
unit AProgramLog2007;

interface

uses
  ALogDocuments, ALogDocumentsAll, AProgramImpl, ATypes;

type
  TProgramLog = class(TAProgram)
  private
    FLogFilePath: WideString;
    FLogTypeSet: TLogTypeSet;
  protected
    function DoStart(): WordBool; override;
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
  Result := inherited DoStart();
  FLogDocuments := TLogDocumentsAll.Create(nil, FLogTypeSet, FLogFilePath, ProgramID, ProgramName);
  if IsDebug then
    FLogDocuments.Show();
end;

end.
 