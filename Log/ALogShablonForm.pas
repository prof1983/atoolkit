{**
@Author Prof1983 <prof1983@ya.ru>
@Created 25.07.2006
@LastMod 18.12.2012
}
unit ALogShablonForm;

interface

uses
  ATypes,
  fShablon;

type
  TfmLogShablon = class(TfmShablon)
  protected
    function GetOnCommand(): TProcMessageStr; virtual;
    function GetProgress(Index: Integer): Integer; virtual;
    function GetProgressCount(): Integer; virtual;
    procedure SetOnCommand(Value: TProcMessageStr); virtual;
    procedure SetProgress(Index, Value: Integer); virtual;
  public
    property OnCommand: TProcMessageStr read GetOnCommand write SetOnCommand;
    property Progress[Index: Integer]: Integer read GetProgress write SetProgress;
    property ProgressCount: Integer read GetProgressCount;
  end;

implementation

{ TfmLogShablon }

function TfmLogShablon.GetOnCommand(): TProcMessageStr;
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

procedure TfmLogShablon.SetOnCommand(Value: TProcMessageStr);
begin
end;

procedure TfmLogShablon.SetProgress(Index, Value: Integer);
begin
end;

end.
