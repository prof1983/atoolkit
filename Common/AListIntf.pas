{**
@Abstract(Список)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.09.2007)
@LastMod(27.06.2012)
@Version(0.5)

Prototype: java.lang.List

0.0.5 - 08.07.2011 - Prof1983
[*] Rename List.pas -> AListIntf.pas
}
unit AListIntf;

interface

uses
  ABase, ACollectionIntf;

type
  IAList = interface(IACollection)
    function GetElementByIndex(Index: Integer): AId;

    procedure Insert(Index: Integer; Element: TObject);
    procedure RemoveByIndex(Index: Integer);

    property ElementByIndex[Index: Integer]: AId read GetElementByIndex;
  end;
  //IList = IAList;

implementation

end.
