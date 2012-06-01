{**
@Abstract(Шаблон для создания формы логирования в не визуальном режиме)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.07.2006)
@LastMod(03.05.2012)
@Version(0.5)
}
unit ALogShablon;

interface

uses
  ATypes,
  fShablon;

type //** @abstract(Шаблон для создания формы логирования)
  TfmLogShablon = class(TfmShablon)
  protected
    function GetOnCommand(): TProcMessage; virtual;
    function GetProgress(Index: Integer): Integer; virtual;
    function GetProgressCount(): Integer; virtual;
    procedure SetOnCommand(Value: TProcMessage); virtual;
    procedure SetProgress(Index, Value: Integer); virtual;
  public
    property OnCommand: TProcMessage read GetOnCommand write SetOnCommand;
    property Progress[Index: Integer]: Integer read GetProgress write SetProgress;
    property ProgressCount: Integer read GetProgressCount;
  end;

implementation

{ TfmLogShablon }

function TfmLogShablon.GetOnCommand(): TProcMessage;
begin
  Result := nil;
end;

function TfmLogShablon.GetProgress(Index: Integer): Integer;
begin
  Result := 0;
end;

function TfmLogShablon.GetProgressCount(): Integer;
begin
  Result := 0;
end;

procedure TfmLogShablon.SetOnCommand(Value: TProcMessage);
begin
end;

procedure TfmLogShablon.SetProgress(Index, Value: Integer);
begin
end;

end.
