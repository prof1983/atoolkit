{**
@Author Prof1983 <prof1983@ya.ru>
@Created 25.03.2008
@LastMod 05.02.2013
}
unit AThreatedModule;

interface

uses
  Windows,
  ABase, AConsts, AModule, AModuleThread, AKernelRuntime;

type
  TAThreatedModule = class(TAAbstractModule)
  private
    FModuleThread: TAModuleThread;
  protected
    function GetModuleID(): TAModuleID; override; safecall;
    function GetModuleName(): WideString; override; safecall;
  public
    constructor Create(Module: TAModule);
    destructor Destroy(); override;
    function Finalize(): Integer; override; safecall;
    function Initialize(AModuleID: TAModuleID; ASendMessage: TACoreRunMessageProc2): Integer; override; safecall;
    {** Adds the message to be processed in the order of the }
    function RunMessage(Command: TACommand; P0, P1, P2: Integer; Data: Pointer): Integer; override; safecall;
    {** Process the message }
    function RunMessageC(Msg: PAMessageRec): Integer; override; safecall;
    {** Process the message out of turn }
    function RunMessageNow(Command: TACommand; P0, P1, P2: Integer; Data: Pointer): Integer;
  end;

implementation

uses
  AKernel;

{ TAThreatedModule }

constructor TAThreatedModule.Create(Module: TAModule);
begin
  inherited Create();
  FModuleThread := TAModuleThread.Create(Module);
end;

destructor TAThreatedModule.Destroy();
var
  i: Integer;
begin
  // If the subprocess in the work, then finish with the expectation of
  if (FModuleThread.State <> psTerminated) then
  begin
    FModuleThread.Terminate();
    // Wait
    i := 0;
    repeat
      Sleep(10);
      if (FModuleThread.State = psTerminated) then
        Break;
    until (i < 10);
    // Stop process
    FModuleThread.Suspend();
  end;
  FModuleThread.Free();
  FModuleThread := nil;
  inherited;
end;

function TAThreatedModule.Finalize(): Integer;
begin
  FModuleThread.Terminate();
end;

function TAThreatedModule.GetModuleID(): TAModuleID;
begin
  Result := FModuleThread.Module.ModuleID;
end;

function TAThreatedModule.GetModuleName(): WideString;
begin
  Result := FModuleThread.Module.ModuleName;
end;

function TAThreatedModule.Initialize(AModuleID: TAModuleID; ASendMessage: TACoreRunMessageProc2): Integer;
begin
  FModuleThread.ModuleID := AModuleID;
  FModuleThread.SendMessage := ASendMessage;
  FModuleThread.Resume();
  Result := Kernel.NextMessageID;
  FModuleThread.InitializePlugin(Result);
end;

function TAThreatedModule.RunMessage(Command: TACommand; P0, P1, P2: Integer; Data: Pointer): Integer;
begin
  Result := FModuleThread.PushMessage(Kernel.NextMessageID, Command, P0, P1, P2, Data);
end;

function TAThreatedModule.RunMessageC(Msg: PAMessageRec): Integer;
begin
  Result := FModuleThread.PushMessageC(Msg);
end;

function TAThreatedModule.RunMessageNow(Command: TACommand; P0, P1, P2: Integer; Data: Pointer): Integer;
begin
  Result := FModuleThread.PushMessage(Kernel.NextMessageID, Command, P0, P1, P2, Data, True);
end;

end.
 