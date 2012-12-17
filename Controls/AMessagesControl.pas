{**
@Abstract Контрол для ввода и вывода сообщений
@Author Prof1983 <prof1983@ya.ru>
@Created 28.10.2006
@LastMod 17.12.2012
}
unit AMessagesControl;

interface

uses
  AControlImpl;

type
  TMessageAddEvent = function(const AMessage: WideString; AID: Integer): Integer of object;

type //** @abstract(Контрол для ввода и вывода сообщений)
  TMessagesControl = class(TAControl)
  private
    FOnMessageAdd: TMessageAddEvent;
  protected
    function DoMessageAdd(const AMessage: WideString; AID: Integer): Integer; virtual;
  public
    property OnMessageAdd: TMessageAddEvent read FOnMessageAdd write FOnMessageAdd;
  end;

implementation

{ TMessagesControl }

function TMessagesControl.DoMessageAdd(const AMessage: WideString; AID: Integer): Integer;
begin
  Result := -1;
  if Assigned(FOnMessageAdd) then
    Result := FOnMessageAdd(AMessage, AID);
end;

end.
