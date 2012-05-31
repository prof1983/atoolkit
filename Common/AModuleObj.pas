{**
@Abstract(Модуль)
@Author(Prof1983 prof1983@ya.ru)
@Created(28.08.2007)
@LastMod(30.05.2012)
@Version(0.5)

-Модуль может иметь неограниченное число точек расширения (ExtensionPoint).
Модуль может зависеть от других модулей (Dependences).
Зависимости определяются в информации о модуле (Information).

26.04.2012: ProfModule.pas -> ArModuleObj.pas
}
unit AModuleObj;

// TODO: Rename ArModuleObj -> AiModuleObj

interface

uses
  AMessageIntf, AModuleInformationIntf, AModuleIntf;

type //** Псевдоабстрактный класс модуля
  TProfModule = class //(TInterfacedObject, IProfModule)
  protected
//    FExtensionPoints: TExtensionPointList;
    FLocalID: Integer;
    FLocalName: WideString;
  protected
    function GetInformation(): IModuleInformation; virtual;
    function GetLocalID(): Integer; virtual;
    function GetLocalName(): WideString; virtual;
  public
    constructor Create();
    function Initialize(): Integer; virtual;
    function Finalize(): Integer; virtual;
    function Start(): Integer; virtual;
    function Stop(): Integer; virtual;
    function Pause(): Integer; virtual;
    function PushMessage(Msg: ISimpleMessage): Integer; virtual;
  public
    // Точки расширения
//    property ExtensionPoints: TExtensionPointList read FExtensionPoints;
    // Информация о модуле
    property Information: IModuleInformation read GetInformation;
    // Локальный идентификатор
    property LocalID: Integer read FLocalID;
    // Локальное имя
    property LocalName: WideString read FLocalName write FLocalName;
  end;

type
  TArModuleObject = TProfModule;
  TArModule = TArModuleObject;

implementation

uses
  {$IFDEF MailAgent}MasRuntime{$ELSE}ArRuntime{$ENDIF}; // Для MainAgent - MasRuntime, для остальных ArRuntime

{$IFNDEF MailAgent}
type
  TRuntime = TArRuntime;
{$ENDIF}

{ TModule }

constructor TProfModule.Create();
var
  Runtime: TRuntime;
begin
  inherited Create();
  //FExtensionPoints := TExtensionPointList.Create();

  // Регистрируемся в Runtime и получаем локальный идентификатор-число
  Runtime := TRuntime.GetInstance();
  if Assigned(Runtime) then
  begin
    FLocalId := Runtime.RegisterModule2(Self.LocalName);
  end;
end;

function TProfModule.Finalize(): Integer;
begin
  Result := 0;
end;

function TProfModule.GetInformation(): IModuleInformation;
begin
  Result := nil;
end;

function TProfModule.GetLocalID(): Integer;
begin
  Result := FLocalID;
end;

function TProfModule.GetLocalName(): WideString;
begin
  Result := FLocalName;
end;

function TProfModule.Initialize(): Integer;
begin
  Result := 0;
end;

function TProfModule.Pause(): Integer;
begin
  Result := 0;
end;

function TProfModule.PushMessage(Msg: ISimpleMessage): Integer;
begin
  Result := -1;
end;

function TProfModule.Start(): Integer;
begin
  Result := 0;
end;

function TProfModule.Stop(): Integer;
begin
  Result := 0;
end;

end.
