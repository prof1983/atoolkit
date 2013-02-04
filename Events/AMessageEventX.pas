{**
@Abstract ProfMessageEventX
@Author Prof1983 <prof1983@ya.ru>
@Created 22.04.2007
@LastMod 09.08.2012
}
unit AMessageEventX;

interface

uses
  AEventObj, ANodeIntf, ATypes;

type
  TProfMessageEventX = class(TAEvent)
  private
    FListeners: array of TProcMessageX;
  protected
    function GetCount(): Integer; override;
  public
    //** Подписаться на получение события
    function Connect(Proc: TProcMessageX): WordBool;
    //** Отписаться от события
    function Disconnect(Proc: TProcMessageX): WordBool;
    //** Выполнить при возникновении события
    function Run(Msg: IProfNode): Integer; safecall;
  end;

implementation

{ TProfMessageEventX }

function TProfMessageEventX.Connect(Proc: TProcMessageX): WordBool;
var
  I: Integer;
begin
  I := Length(FListeners);
  SetLength(FListeners, I + 1);
  FListeners[I] := Proc;
  Result := True;
end;

function TProfMessageEventX.Disconnect(Proc: TProcMessageX): WordBool;
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

function TProfMessageEventX.GetCount(): Integer;
begin
  Result := Length(FListeners);
end;

function TProfMessageEventX.Run(Msg: IProfNode): Integer;
var
  I: Integer;
begin
  //if Msg.ChildNodes.NodeByIndex[0].Name = '' then

  {for I := 0 to High(FListeners) do
  try
    FListeners[I](Msg);
  except
  end;}
end;

end.
