{**
@Author Prof1983 <prof1983@ya.ru>
@Created 04.03.2008
@LastMod 05.02.2013
}
unit AModuleThread;

interface

uses
  Classes, Contnrs, Windows,
  ABase, AConsts, AMessages, AModule;

type
  TPluginState = (
    psNone,
    psInitializing,
    psInitialized,
    psInitializeError,
    psFinalizing,
    psFinalized,
    psFinalizeError,
    psStarting,
    psStarted,
    psStartError,
    psStoping,
    psStoped,
    psStopError,
    psPausing,
    psPaused,
    psPauseError,
    psTerminated
    );

type
  TAModuleThread = class(TThread)
  private // For the posts of the extraordinary
    FNowMessageResult: Integer;
    FNowMessageRun: Boolean;
  private
    FModule: TAAbstractModule;
    FState: TPluginState;
    FMessageQueue: TQueue;
    FModuleID: TAModuleID;
    {** All posts busy }
    FMessageQueueBusy: Boolean;
    FNowMessage: TAMessageRec;
    FSendMessage: TACoreRunMessageProc2;
    function GetIsTerminated(): Boolean;
    function GetNextMessage(): PAMessageRec;
    function RunMessage(msg: PAMessageRec): Integer;
  protected
    procedure Execute(); override;
  public
    constructor Create(Module: TAAbstractModule);
    destructor Destroy(); override;
    function FinalizePlugin(MessageID: TAMessageID): Integer;
    function InitializePlugin(MessageID: TAMessageID): Integer;
    {** Start/continue execution of internal subprocess module (if it is) }
    function StartPlugin(MessageID: Integer): Integer;
    {** The completion of the internal sub-module (if it is) }
    function StopPlugin(MessageID: Integer): Integer;
    {** Suspend the execution of internal subprocess module (if it is) }
    function PausePlugin(MessageID: TAMessageID): Integer;
    {** Puts a message in the stack
        @param IsNow - you want to immediately.
            In this case, the message is placed as the extraordinary and function pending for some time.
            If the message processing is not completed(or not yet started) for a certain period of time,
            the возвращяется error, otherwise возвращяется the result of processing the message. }
    function PushMessage(MessageID: TAMessageID; Command: TACommand; Param0, Param1, Param2: Integer;
      Data: Pointer; IsNow: Boolean = False): Integer;
    {** Puts a message in the stack }
    function PushMessageC(MessageRec: PAMessageRec): Integer;
  public
    {** The CallBack function of processing of the messages the kernel
        Should be set to initialize the module.
        Passed to the module as a parameter in the initialization. }
    property SendMessage: TACoreRunMessageProc2 read FSendMessage write FSendMessage;
    {** Is the completion of a subprocess
        After the completion of the subprocess State = psTerminated. }
    property IsTerminated: Boolean read GetIsTerminated;
    {** The ID of the module. Is used only when initializing }
    property ModuleID: TAModuleID read FModuleID write FModuleID;
    {** Structure, returned at plugin boot }
    property Module: TAAbstractModule read FModule;
    {** The current state of the module }
    property State: TPluginState read FState;
  end;

implementation

const
  // The maximum number of attempts to return to a message queue
  ChechBusyMaxCount = 10;
  // Waiting time to a message queue
  CheckBusySleep = 1;

{ TAModuleThread }

constructor TAModuleThread.Create(Module: TAAbstractModule);
begin
  inherited Create(True);
  FModule := Module;
  Self.Priority := tpLower;
  FMessageQueue := TQueue.Create();
  // Allow access to a message queue
  FMessageQueueBusy := False;
  FState := psNone;
end;

destructor TAModuleThread.Destroy();
begin
  FModule.Free();
  FModule := nil;
  inherited;
end;

procedure TAModuleThread.Execute();
var
  msg: PAMessageRec;
  data: Pointer;
  dataSize: Integer;
begin
  repeat
    if FMessageQueueBusy then
      Continue;

    // If there is a special message, then process it first
    if FNowMessageRun then
    begin
      FNowMessageResult := RunMessage(PAMessageRec(Addr(FNowMessage)));
      FNowMessageRun := False;
    end;

    msg := GetNextMessage();

    if Assigned(msg) then
    begin
      RunMessage(msg);

      // Remove the spent message
      data := Pointer(msg^.Data);
      if Assigned(data) then
      begin
        dataSize := Integer(data^);
        FreeMem(data, dataSize);
      end;
      FreeMem(msg, SizeOf(TAMessageRec));
    end
    else
      Sleep(10);
  until Self.Terminated;
  FModule.RunMessage(cmdModuleFinalize, 0, 0, 0, nil);

  FState := psTerminated;
end;

function TAModuleThread.FinalizePlugin(MessageID: TAMessageID): Integer;
begin
  Result := PushMessage(MessageID, cmdModuleFinalize, 0, 0, 0, nil);
end;

function TAModuleThread.GetIsTerminated(): Boolean;
begin
  Result := Self.Terminated;
end;

function TAModuleThread.GetNextMessage(): PAMessageRec;
begin
  // Prohibit recourse to a message queue
  FMessageQueueBusy := True;

  // Get another message
  if FMessageQueue.Count > 0 then
    Result := FMessageQueue.Pop()
  else
    Result := nil;

  // Allow access to a message queue
  FMessageQueueBusy := False;
end;

function TAModuleThread.InitializePlugin(MessageID: TAMessageID): Integer;
begin
  Result := PushMessage(MessageID, cmdModuleInitialize, FModuleID, Integer(Addr(SendMessageA)), 0, nil);
end;

function TAModuleThread.PausePlugin(MessageID: TAMessageID): Integer;
begin
  Result := PushMessage(MessageID, cmdModulePause, 0, 0, 0, nil);
end;

function TAModuleThread.PushMessage(MessageID: TAMessageID; Command: TACommand;
  Param0, Param1, Param2: Integer; Data: Pointer; IsNow: Boolean): Integer;
var
  msg: TAMessageRec;
  i: Integer;
begin
  Result := 0;
  if IsNow then
  begin
    // If you are currently an extraordinary function, then go
    if FNowMessageRun then
    begin
      Result := rFalse;
      Exit;
    end;
    FNowMessage.MessageID := MessageID;
    FNowMessage.SenderModuleID := midCore;
    FNowMessage.ReceiverModuleID := FModule.ModuleID; // No used
    FNowMessage.Command := Command;
    FNowMessage.Param0 := Param0;
    FNowMessage.Param1 := Param1;
    FNowMessage.Param2 := Param2;
    FNowMessage.Data := Data;
    // Specify the process extraordinary message
    FNowMessageRun := True;
    // Wait a little bit until the message processing
    i := 0;
    repeat
      Sleep(10);
      // If a message is processed, the возврящаем result and go
      if not(FNowMessageRun) then
      begin
        Result := FNowMessageResult;
        Exit;
      end;
      Inc(i);
    until (i < 10);
  end
  else
  begin
    msg.MessageID := MessageID;
    msg.SenderModuleID := midCore;
    msg.ReceiverModuleID := FModule.ModuleID; // No used
    msg.Command := Command;
    msg.Param0 := Param0;
    msg.Param1 := Param1;
    msg.Param2 := Param2;
    msg.Data := Data;

    Result := PushMessageC(@msg);
  end;
end;

function TAModuleThread.PushMessageC(MessageRec: PAMessageRec): Integer;
var
  i: Integer;
  msg: PAMessageRec;
begin
  Result := -1;
  for i := 0 to ChechBusyMaxCount do
  begin
    // At this point, if we may turn to a message queue, then add the message to the queue,
    // or else a little forward and trying again, but not more than ChechBusyCount time.
    if (FMessageQueueBusy = False) then
    begin
      // Prohibit other treatment to a message queue
      FMessageQueueBusy := True;
      // Copy the entire message (including the data)
      GetMem(msg, SizeOf(TAMessageRec));
      Move(MessageRec^, msg^, SizeOf(TAMessageRec));
      if Assigned(msg^.Data) then
        Move(MessageRec^.Data^, msg^.Data^, Integer(msg^.Data^));
      // Add a message in queue
      FMessageQueue.Push(msg);
      // Allow others access to a message queue
      FMessageQueueBusy := False;
      Result := 0;
      Exit;
    end
    else
      Sleep(CheckBusySleep);
  end;
end;

function TAModuleThread.RunMessage(msg: PAMessageRec): Integer;
begin
  Result := 0;
  case msg^.Command of
    cmdModuleInitialize:
      begin
        if (FState = psNone) or (FState = psFinalized) or (FState = psInitializeError) then
        try
          FState := psInitializing;
          Result := FModule.RunMessageC(msg);
          FState := psInitialized;
        except
          FState := psInitializeError;
          MessageBox(0, PChar(errInitializePlugin), PChar(stTitle), MB_OK or MB_ICONSTOP or MB_TASKMODAL);
        end;
      end;
    cmdModuleFinalize:
      begin
        if (FState = psInitialized) or (FState = psFinalizeError)
         or (FState = psStartError) or (FState = psPauseError)
         or (FState = psStoped) or (FState = psStopError) then
        try
          FState := psFinalizing;
          Result := FModule.RunMessageC(msg);
          FState := psFinalized;
        except
          FState := psFinalizeError;
          MessageBox(0, PChar(errFinalizePlugin), PChar(stTitle), MB_OK or MB_ICONSTOP or MB_TASKMODAL);
        end;
      end;
    cmdModuleStart:
      begin
        if (FState = psInitialized) or (FState = psStoped)
         or (FState = psStartError) or (FState = psPaused) then
        try
          FState := psStarted;

          FState := psStarted;
          Result := FModule.RunMessageC(msg);
          FState := psStarted;
        except
          FState := psStartError;
          MessageBox(0, PChar(errStartPlugin), PChar(stTitle), MB_OK or MB_ICONSTOP or MB_TASKMODAL);
        end;
      end;
    cmdModuleStop:
      begin
        if (FState = psStarted) or (FState = psStopError) or (FState = psPaused) then
        try
          FState := psStoping;
          Result := FModule.RunMessageC(msg);
          FState := psStoped;
        except
          FState := psStopError;
          MessageBox(0, PChar(errStopPlugin), PChar(stTitle), MB_OK or MB_ICONSTOP or MB_TASKMODAL);
        end;
      end;
    cmdModulePause:
      begin
        if (FState = psStarted) or (FState = psPauseError) then
        try
          FState := psPausing;
          Result := FModule.RunMessageC(msg);
          FState := psPaused;
        except
          FState := psPauseError;
          MessageBox(0, PChar(errPausePlugin), PChar(stTitle), MB_OK or MB_ICONSTOP or MB_TASKMODAL);
        end;
      end;
  else
    Result := FModule.RunMessageC(msg);
  end;
end;

function TAModuleThread.StartPlugin(MessageID: Integer): Integer;
begin
  Result := PushMessage(MessageID, cmdModuleStart, 0, 0, 0, nil);
end;

function TAModuleThread.StopPlugin(MessageID: Integer): Integer;
begin
  Result := PushMessage(MessageID, cmdModuleStop, 0, 0, 0, nil);
end;

end.
