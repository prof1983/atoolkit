{**
@Author Prof1983 <prof1983@ya.ru>
@Created 16.03.2008
@LastMod 04.07.2011
}
unit AModuleClient;

interface

uses
  ABase, AConsts, AModule;

type
  TAModuleClient = class(TAModule)
  protected
    FRunMessage: TAModuleRunMessageProc;
    FRunMessageC: TAComponentRunMessageProc;
    function DoFinalize(): Integer; override;
    function DoInitialize(): Integer; override;
  public
    function RunMessage(Command: TACommand; P0, P1, P2: Integer; Data: Pointer): Integer; override; safecall;
    function RunMessageC(Msg: PAMessageRec): Integer; override; safecall;
  public
    property RunMessageProc: TAModuleRunMessageProc read FRunMessage write FRunMessage;
    property RunMessageCProc: TAComponentRunMessageProc read FRunMessageC write FRunMessageC;
  end;

implementation

{ TAModuleClient }

function TAModuleClient.DoFinalize(): Integer;
begin
  Result := RunMessage(cmdModuleFinalize, 0, 0, 0, nil);
end;

function TAModuleClient.DoInitialize(): Integer;
begin
  Result := RunMessage(cmdModuleInitialize, FModuleID, Integer(Addr(FSendMessage)), 0, nil);
end;

function TAModuleClient.RunMessage(Command: TACommand; P0, P1, P2: Integer; Data: Pointer): Integer;
begin
  Result := FRunMessage(Command, P0, P1, P2, Data);
end;

function TAModuleClient.RunMessageC(Msg: PAMessageRec): Integer;
begin
  Result := FRunMessageC(Msg);
end;

end.
