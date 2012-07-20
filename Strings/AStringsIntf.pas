{**
@abstract AStrings interface
@author Prof1983 <prof1983@ya.ru>
@created 20.07.2012
@lastmod 20.07.2012
}
unit AStringsIntf;

interface

uses
  ACollectionsBase;

type
  IAStrings = interface
    function GetCount(): Integer;
    function GetName(Index: Integer): WideString;
    function GetString(Index: Integer): WideString;
    function GetStrings(): AStringList;
    function GetValue(const Name: WideString): WideString;

    function Add(S: WideString): Integer;
    procedure Clear();

    property Count: Integer read GetCount;
    property Names[Index: Integer]: WideString read GetName;
    property Strings[Index: Integer]: WideString read GetString;
    property Values[const Name: WideString]: WideString read GetValue;
  end;

implementation

end.
