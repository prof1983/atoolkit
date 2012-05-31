{**
@Abstract(Центральная часть (микроядро) выполнения программы)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.08.2007)
@LastMod(05.05.2012)
@Version(0.5)

Prototype: Jade.Runtime
}
unit AKernel2007;

interface

uses
  SysUtils,
  AAbstractModuleInformation, ABase, AMessageIntf, AMessageSink, AModuleInformationIntf,
  AModuleIntf, AModules, ANode1, AProcessImpl2007, ARuntimeObj;

type
  TAKernel = class
  private
    // Следующий свободный локальный идентификатор
    FNextLocalId: Integer;
    FRuntime: TARuntimeObject;
    //FRuntimeCommandTurn: TRuntimeCommandTurn;
    //FRuntimeThread: TAssistantRuntimeThread;
    //FVariables: array of TAssistantRuntimeVariable;
  public
    constructor Create();
    class function GetInstance(): TAKernel;
    function GetLocalId(): Integer;
    function GetLocalName(): WideString;
    function GetModules(): TRuntimeModules;
  public
    procedure ProcessCommand(Sender, Receiver, Command: Integer; Params: INode);
    procedure ProcessMessage(Msg: IMessage);
      // Регистрирует модуль. Возвращает локальный идентификатор.
    function RegisterModule(Module: IProfModule): Integer;
    procedure RunExitCommand();
  public // IModule
    function Initialize(): Integer; virtual;
    function Finalize(): Integer; virtual;
    function Start(): Integer; virtual;
    function Stop(): Integer; virtual;
    function Pause(): Integer; virtual;
      // Обработать сообщение
    function PushMessage(Msg: ISimpleMessage): Integer;
  public
    property Modules: TRuntimeModules read GetModules;
  end;

function AKernel_Init(): AError;

implementation

var
  KernelInstance: TAKernel;

{ Public }

function AKernel_Init(): AError;
begin
  TAKernel.Create();
  Result := 0;
end;

{ TAKernel }

constructor TAKernel.Create();
begin
  if Assigned(KernelInstance) then
    raise Exception.Create('AKernel не может быть создан дважды');

  inherited Create();
  KernelInstance := Self;

  FRuntime := TARuntimeObject.Create();
  FNextLocalId := 1;
end;

function TAKernel.Finalize(): Integer;
begin
  Result := FRuntime.Finalize();
end;

class function TAKernel.GetInstance(): TAKernel;
begin
  if not(Assigned(KernelInstance)) then
    KernelInstance := TAKernel.Create();
  Result := KernelInstance;
end;

function TAKernel.GetLocalId(): Integer;
begin
  Result := FNextLocalId;
end;

function TAKernel.GetLocalName(): WideString;
begin
  Result := '';
end;

function TAKernel.GetModules(): TRuntimeModules;
begin
  Result := FRuntime.Modules;
end;

function TAKernel.Initialize(): Integer;
begin
  Result := FRuntime.Initialize();
end;

function TAKernel.Pause(): Integer;
begin
  Result := 0;
end;

procedure TAKernel.ProcessCommand(Sender, Receiver, Command: Integer; Params: INode);
begin
  // TODO: TAssistantRuntime.ProcessCommand
  // ...
end;

procedure TAKernel.ProcessMessage(Msg: IMessage);
begin
  // ...
end;

function TAKernel.PushMessage(Msg: ISimpleMessage): Integer;
begin
  Result := -1;
end;

function TAKernel.RegisterModule(Module: IProfModule): Integer;
begin
  Result := FNextLocalId;
  Inc(FNextLocalId);
  FRuntime.RegisterModule(Module);
end;

procedure TAKernel.RunExitCommand();
begin
  //FRuntimeCommandTurn.PushCommand(ExitCommand, nil);
  Halt(0);
end;

function TAKernel.Start(): Integer;
begin
  Result := 0;
  {if Assigned(FRuntimeThread) then
  try
    FRuntimeThread.Resume();
  except
  end;}
end;

function TAKernel.Stop(): Integer;
begin
  Result := 0;
  {if Assigned(FRuntimeThread) then
  try
    FRuntimeThread.Suspend();
  except
  end;}
end;

end.
