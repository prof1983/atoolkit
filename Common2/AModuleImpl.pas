{**
@Abstract(Module implementation)
@Author(Prof1983 prof1983@ya.ru)
@Created(05.09.2007)
@LastMod(25.05.2012)
@Version(0.5)
}
unit AModuleImpl;

interface

uses
  AAbstractModuleInformation, ABase, AMessageIntf, AModuleIntf, AModuleInformationIntf;

type
  TAbstractModule = class(TInterfacedObject, IProfModule)
  protected
    FInformation: TAbstractModuleInformation;
    FLocalID: Integer;
    FLocalName: WideString;
  protected // IModule
    function GetInformation(): IModuleInformation; virtual;
    function GetLocalID(): Integer; virtual;
    function GetLocalName(): WideString; virtual;
  public // IModule
    function Initialize(): AError; virtual;
    function Finalize(): AError; virtual;
    function Start(): Integer; virtual;
    function Stop(): Integer; virtual;
    function Pause(): Integer; virtual;
    procedure ProcessMessage(Msg: IMessage); virtual;
      // Обработать сообщение
    function PushMessage(Msg: ISimpleMessage): Integer; virtual;
  public
    constructor Create();
    constructor Create2(Info: TAbstractModuleInformation);
  public
      //** Информация о модуле
    property Information: TAbstractModuleInformation read FInformation;
      //** Локальный идентификатор
    property LocalID: Integer read FLocalID;
      //** Локальное имя
    property LocalName: WideString read FLocalName write FLocalName;
  end;

type
  TAbstractComponent = TAbstractModule; // deprecated

implementation

{ TAbstractModule }

constructor TAbstractModule.Create();
{var
  Runtime: TRuntime;}
begin
  inherited Create();

  {Runtime := TRuntime.GetInstance();
  if Assigned(Runtime) then
  begin
    FLocalID := Runtime.RegisterModule(Self);
  end;}
end;

constructor TAbstractModule.Create2(Info: TAbstractModuleInformation);
begin
  Create();
  Self.FInformation := Info;
end;

function TAbstractModule.Finalize(): AError;
begin
  Result := 0;
end;

function TAbstractModule.GetInformation(): IModuleInformation;
begin
  Result := FInformation;
end;

function TAbstractModule.GetLocalID(): Integer;
begin
  Result := FLocalID;
end;

function TAbstractModule.GetLocalName(): WideString;
begin
  Result := FLocalName;
end;

function TAbstractModule.Initialize(): AError;
begin
  Result := 0;
end;

function TAbstractModule.Pause(): Integer;
begin
  Result := 0;
end;

procedure TAbstractModule.ProcessMessage(Msg: IMessage);
begin
end;

function TAbstractModule.PushMessage(Msg: ISimpleMessage): Integer;
begin
  Result := -1;
end;

function TAbstractModule.Start(): Integer;
begin
  Result := 0;
end;

function TAbstractModule.Stop(): Integer;
begin
  Result := 0;
end;

end.
