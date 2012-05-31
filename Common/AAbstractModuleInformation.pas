{**
@Abstract(Абстрактная реализация интерфейса IModuleInformation)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.08.2007)
@LastMod(05.05.2012)
@Version(0.5)
}
unit AAbstractModuleInformation;

interface

uses
  AModuleInformationIntf;

type
  TAbstractModuleInformation = class(TInterfacedObject, IModuleInformation)
  private
    FID: WideString;
    FName: WideString;
    FDescription: WideString;
    FAuthor: WideString;
    FCopyright: WideString;
    FVersion: Integer;
    FVersionString: WideString;
    FOtherInformation: WideString;
  protected
    function GetID(): WideString; virtual;
    function GetName(): WideString; virtual;
    function GetDescription(): WideString; virtual;
    function GetAuthor(): WideString; virtual;
    function GetCopyright(): WideString; virtual;
    function GetVersion(): Integer; virtual;
    function GetVersionString(): WideString; virtual;
    function GetOtherInformation(): WideString; virtual;
  public
    property ID: WideString read FID write FID;
    property Name: WideString read FName write FName;
    property Description: WideString read FDescription write FDescription;
    property Author: WideString read FAuthor write FAuthor;
    property Copyright: WideString read FCopyright write FCopyright;
    property Version: Integer read FVersion write FVersion;
    property VersionString: WideString read FVersionString write FVersionString;
    property OtherInformation: WideString read FOtherInformation write FOtherInformation;
  end;

implementation

{ TAbstractModuleInformation }

function TAbstractModuleInformation.GetAuthor(): WideString;
begin
  Result := FAuthor;
end;

function TAbstractModuleInformation.GetCopyright(): WideString;
begin
  Result := FCopyright;
end;

function TAbstractModuleInformation.GetDescription(): WideString;
begin
  Result := FDescription;
end;

function TAbstractModuleInformation.GetID(): WideString;
begin
  Result := FID;
end;

function TAbstractModuleInformation.GetName(): WideString;
begin
  Result := FName;
end;

function TAbstractModuleInformation.GetOtherInformation(): WideString;
begin
  Result := FOtherInformation;
end;

function TAbstractModuleInformation.GetVersion(): Integer;
begin
  Result := FVersion;
end;

function TAbstractModuleInformation.GetVersionString(): WideString;
begin
  Result := FVersionString;
end;

end.
