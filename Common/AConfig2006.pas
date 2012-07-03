{**
@Abstract(Конфигурации в виде XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.01.2006)
@LastMod(03.07.2012)
@Version(0.5)
}
unit AConfig2006;

// TODO: Use unConfig.pas

interface

uses
  AConfig2007, ATypes;

function LoadObjectFromConfig(AConfig: TConfigNode1; AObject: TObject; AAddToLog: TAddToLog): WordBool;
function SaveObjectToConfig(AConfig: TConfigNode1; AObject: TObject; AAddToLog: TAddToLog): WordBool;

implementation

function LoadObjectFromConfig(AConfig: TConfigNode1; AObject: TObject; AAddToLog: TAddToLog): WordBool;
begin
  Result := AConfig2007.LoadObjectFromConfig2006(AConfig, AObject, AAddToLog);
end;

function SaveObjectToConfig(AConfig: TConfigNode1; AObject: TObject; AAddToLog: TAddToLog): WordBool;
begin
  Result := AConfig2007.SaveObjectToConfig2006(AConfig, AObject, AAddToLog);
end;

end.
