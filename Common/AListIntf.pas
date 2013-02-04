{**
@Author Prof1983 <prof1983@ya.ru>
@Created 17.09.2007
@LastMod 04.02.2013

Prototype: java.lang.List
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

implementation

end.
