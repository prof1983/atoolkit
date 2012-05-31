{**
@Abstract(Объект с логированием и конфигурациями и функциями передачи ACL сообщений)
@Author(Prof1983 prof1983@ya.ru)
@Created(13.04.2004)
@LastMod(26.04.2012)
@Version(0.5)
}
unit AObjectEx;

interface

uses
  AIntfEx, AObjectImpl, ATypesEx;

type // Объект с логированием и конфигурациями и функциями передачи ACL сообщений
  TProfObjectEx = class(TProfObject, IProfObjectEx)
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
  TProfObjectEx3 = TProfObjectEx;

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
