{**
@Abstract Объект с логированием и конфигурациями и функциями передачи ACL сообщений
@Author Prof1983 <prof1983@ya.ru>
@Created 13.04.2004
@LastMod 13.11.2012
}
unit AObjectEx;

interface

uses
  AIntfEx, AObjectImpl;

type // Объект с логированием и конфигурациями и функциями передачи ACL сообщений
  TProfObjectEx = class(TAObject, IProfObjectEx)
  private
    //** CallBack функция. Срабатывает при поступлении сообщения.
//    FOnSendMessageA: TProcMessageA;
  protected
    //** Передать сообщение
    function SendMessageA(Msg: IProfMessage): Integer; safecall;
  public
    //** Добавить (выполнить) сообщение
    function AddMessageA(Msg: IProfMessage): Integer; safecall;
  public
    //** CallBack функция. Срабатывает при поступлении сообщения.
//    property OnSendMessageA: TProcMessageA read FOnSendMessageA write FOnSendMessageA;
  end;

implementation

{ TProfObjectEx }

function TProfObjectEx.AddMessageA(Msg: IProfMessage): Integer;
begin
  Result := 0;
  // ...
end;

function TProfObjectEx.SendMessageA(Msg: IProfMessage): Integer;
begin
  Result := 0;
{  if Assigned(FOnSendMessageA) then
  try
    FOnSendMessageA(Msg);
  except
  end;
}
end;

end.
