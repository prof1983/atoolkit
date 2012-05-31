{**
@Abstract(Общие интерфейсы для всех проектов)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.02.2007)
@LastMod(24.04.2012)
@Version(0.5)
}
unit AAttributeIntf;

interface

uses
  AEntityIntf, ATypes;

type //** Интерфейс для атрибута
  IProfAttribute = interface(IProfNamedEntity)
    //function GetName(): WideString; safecall;
    function GetValue(): OleVariant; safecall;
    //procedure SetName(const Value: WideString); safecall;
    procedure SetValue(Value: OleVariant); safecall;

    //** Имя атрибута
    //property Name: WideString read GetName write SetName;
    //** Значение атрибута
    property Value: OleVariant read GetValue write SetValue;
  end;

implementation

end.
