{**
@Abstract(Список)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.09.2007)
@LastMod(27.04.2012)
@Version(0.5)

Prototype: java.lang.List

0.0.5 - 08.07.2011 - Prof1983
[*] Rename List.pas -> AListIntf.pas
}
unit AListIntf;

interface

uses
  ACollection;

type
  IAList = interface(IACollection)
    function GetElementByIndex(Index: Integer): TObject;

    procedure Insert(Index: Integer; Element: TObject);
    procedure Remove(Element: TObject);
    procedure RemoveByIndex(Index: Integer);

    property ElementByIndex[Index: Integer]: TObject read GetElementByIndex;
  end;
  IList = IAList;

implementation

end.
