{**
@Abstract(Центральная часть (микроядро) программы)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.08.2007)
@LastMod(05.05.2012)
@Version(0.5)

Prototype: Jade.Runtime
}
unit ARuntimeObj;

interface

uses
  SysUtils,
  AModuleIntf, AModules;

type
  TARuntimeObject = class //(TInterfacedObject, IProfModule)
  private
    //FInformation: TAbstractModuleInformation;
    FModules: TRuntimeModules;
  public
    constructor Create();
    class function GetInstance(): TARuntimeObject;
  public
      // Регистрирует модуль. Возвращает локальный идентификатор.
    function RegisterModule(Module: IProfModule): Integer;
    procedure RunExitCommand();
  public // IModule
    function Initialize(): Integer; virtual;
    function Finalize(): Integer; virtual;
    function Start(): Integer; virtual;
    function Stop(): Integer; virtual;
    function Pause(): Integer; virtual;
  public
    property Modules: TRuntimeModules read FModules;
  end;

  //TRuntime = TARuntimeObject;

implementation

var
  RuntimeInstance: TARuntimeObject;

{ TRuntime }

constructor TARuntimeObject.Create();
begin
  if Assigned(RuntimeInstance) then
    raise Exception.Create('ARuntime не может быть создан дважды');

  inherited Create();
  RuntimeInstance := Self;

  {FInformation := TAbstractModuleInformation.Create();
  FInformation.ID := 'mas.platform.core.runtime';
  FInformation.Name := 'Runtime module';
  FInformation.Description := 'Среда выполнения программы AIAssistant';
  FInformation.Author := '';
  FInformation.Copyright := '';
  FInformation.Version := 3;
  FInformation.VersionString := '0.0.0.3';}

  FModules := TRuntimeModules.Create();
  //FModules.AddModule(Self);
end;

function TARuntimeObject.Finalize(): Integer;
begin
  Result := 0;
  //for i := 0 to High(FVariables) do
  //  FVariables[i].Free();
  //SetLength(FVariables, 0);
end;

class function TARuntimeObject.GetInstance(): TARuntimeObject;
begin
  Result := RuntimeInstance;
end;

function TARuntimeObject.Initialize(): Integer;
begin
  Result := 0;
  {if not(Assigned(FRuntimeCommandTurn)) then
    FRuntimeCommandTurn := TAssistantRuntimeCommandTurn.Create();
  if not(Assigned(FRuntimeThread)) then
    FRuntimeThread := TAssistantRuntimeThread.Create(True);}
end;

function TARuntimeObject.Pause(): Integer;
begin
  Result := 0;
end;

function TARuntimeObject.RegisterModule(Module: IProfModule): Integer;
begin
  FModules.AddModule(Module);
end;

procedure TARuntimeObject.RunExitCommand();
begin
  //FRuntimeCommandTurn.PushCommand(ExitCommand, nil);
  Halt(0);
end;

function TARuntimeObject.Start(): Integer;
begin
  Result := 0;
  {if Assigned(FRuntimeThread) then
  try
    FRuntimeThread.Resume();
  except
  end;}
end;

function TARuntimeObject.Stop(): Integer;
begin
  Result := 0;
  {if Assigned(FRuntimeThread) then
  try
    FRuntimeThread.Suspend();
  except
  end;}
end;

end.
 