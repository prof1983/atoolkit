{**
@Abstract(Общие интерфейсы для всех проектов с расширеными функциями)
@Author(Prof1983 prof1983@ya.ru)
@Created(13.04.2007)
@LastMod(27.06.2012)
@Version(0.5)
}
unit AIntfEx;

interface

uses
  ABase, AObjectIntf, AProcessIntf;

type
  IProfMessage = AMessage; //IAclMessage;

type
  IProfObjectEx = interface(IProfObject)
      //** Добавить (выполнить) сообщение
    function AddMessageA(Msg: IProfMessage): Integer; safecall;
      //** Передать сообщение
    function SendMessageA(Msg: IProfMessage): Integer; safecall;
  end;

type
  IProfFormEx = interface(IProfObject)
      //** Добавить (выполнить) сообщение
    function AddMessageA(Msg: IProfMessage): Integer; safecall;
      //** Передать сообщение
    function SendMessageA(Msg: IProfMessage): Integer; safecall;
  end;

type
  IProfProcessEx = interface(IProfProcess)
      //** Добавить (выполнить) сообщение
    function AddMessageA(Msg: IProfMessage): Integer; safecall;
      //** Передать сообщение
    function SendMessageA(Msg: IProfMessage): Integer; safecall;
  end;

implementation

end.
