{**
@Abstract(Глобальные расширеные типы для всех проектов)
@Author(Prof1983 prof1983@ya.ru)
@Created(13.04.2007)
@LastMod(26.04.2012)
@Version(0.5)
}
unit ATypesEx;

interface

uses
  AIntfEx, ANodeIntf;

type
  {**
    @abstract(Тип callback функции для посылки ACL сообщения или команды)
    Подробнее: http://prof-ar.narod.ru/development/acl/
  }
  TProcMessageA = function(Msg: IProfMessage): Integer of object; safecall;
  TProcMessageX = function(AMsg: IProfNode): Integer of object; safecall;

implementation

end.
