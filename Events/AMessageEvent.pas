{**
@Abstract ProfMessageEvent
@Author Prof1983 <prof1983@ya.ru>
@Created 22.04.2007
@LastMod 09.08.2012
}
unit AMessageEvent;

interface

uses
  AEventObj, ATypes;

type
  TProfMessageEvent = class(TAEvent)
  private
    FListeners: array of TProcMessageStr;
  protected
    function GetCount(): Integer; override;
  public
    function Connect(Proc: TProcMessageStr): WordBool;
    function Disconnect(Proc: TProcMessageStr): WordBool;
    function Run(const Msg: WideString): Integer; safecall;
  end;

implementation

{ TProfMessageEvent }

function TProfMessageEvent.Connect(Proc: TProcMessageStr): WordBool;
var
  I: Integer;
begin
  I := Length(FListeners);
  SetLength(FListeners, I + 1);
  FListeners[I] := Proc;
  Result := True;
end;

function TProfMessageEvent.Disconnect(Proc: TProcMessageStr): WordBool;
var
  I: Integer;
begin
  for I := 0 to High(FListeners) do
    if Addr(FListeners[I]) = Addr(Proc) then
    begin
      FListeners[I] := FListeners[High(FListeners)];
      SetLength(FListeners, High(FListeners));
      Result := True;
      Exit;
    end;
  Result := False;
end;

function TProfMessageEvent.GetCount(): Integer;
begin
  Result := Length(FListeners);
end;

function TProfMessageEvent.Run(const Msg: WideString): Integer;
var
  I: Integer;
begin
  for I := 0 to High(FListeners) do
  try
    FListeners[I](Msg);
  except
  end;
end;

end.
