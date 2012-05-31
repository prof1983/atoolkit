{**
@Abstract(Информация о модуле)
@Author(Prof1983 prof1983@ya.ru)
@Created(28.08.2007)
@LastMod(19.03.2012)
@Version(0.5)
}
unit AModuleInformationIntf;

interface

type
  IModuleInformation = interface
    // Protected methods

    function GetID(): WideString;
    function GetName(): WideString;
    function GetDescription(): WideString;
    function GetAuthor(): WideString;
    function GetCopyright(): WideString;
    function GetVersion(): Integer;
    function GetVersionString(): WideString;
    function GetOtherInformation(): WideString;

    // Public properties

    property ID: WideString read GetID;
    property Name: WideString read GetName;
    property Description: WideString read GetDescription;
    property Author: WideString read GetAuthor;
    property Copyright: WideString read GetCopyright;
    property Version: Integer read GetVersion;
    property VersionString: WideString read GetVersionString;
    property OtherInformation: WideString read GetOtherInformation;
  end;

implementation

end.
