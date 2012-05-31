{**
@Abstract(Центральная часть (микроядро) выполнения программы)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.08.2007)
@LastMod(05.07.2011)
@Version(0.5)

Prototype: jade.Runtime

Runtime предназначен для передачи сообщений между модулями.
-У runtime модуля есть конвеер входящих сообщений.

0.0.1.12 Prof1983
[*] TRuntime -> TARuntime
}
unit AKernelRuntime;

interface

uses
  Windows,
  ABase, AModule;

type
  TARuntime = class
  private
    //** Разрешить завершение работы программы
    FIsExit: Boolean;
    // Зарегистрированные модули
    FModules: array of TAAbstractModule;
    // Следующий идентификатор сообщения
    FNextMessageID: Integer;
    // Следующий свободный идентификатор модуля
    FNextModuleID: Integer;
    function GetNextMessageID(): Integer;
    function GetNextModuleID(): Integer;
  protected
    function GetModuleByID(ID: Integer): TAAbstractModule;
    function GetModuleByIndex(Index: Integer): TAAbstractModule;
    function GetModuleCount(): Integer;
  public
    procedure Clear();
    constructor Create();
    //** Регистрирует модуль. Возвращает локальный идентификатор.
    function RegisterModule(Module: TAAbstractModule): Integer;
    procedure RunExitCommand();
    function UnRegisterModule(Module: TAAbstractModule): Boolean;
  public
    {**
      @abstract(Обрабытывает сообщение)
      Выполняет заданое действие или пересылает сообщение указаному модулю
    }
    function RunMessage(Command: TACommand; P0, P1, P2: Integer; Data: Pointer; ReceiverModuleID: TAModuleID): Integer;
    function RunMessageC(Msg: PAMessageRec): Integer;
  public
    //** @abstract(Разрешить завершение работы программы)
    property IsExit: Boolean read FIsExit write FIsExit;
    property ModuleByID[ID: Integer]: TAAbstractModule read GetModuleByID;
    property ModuleByIndex[Index: Integer]: TAAbstractModule read GetModuleByIndex;
    property ModuleCount: Integer read GetModuleCount;
  end;

var
  Runtime: TARuntime;

procedure InitializeRuntime();
function RuntimeRunMessage(ReceiverModuleID: TAModuleID; Command: TACommand;
    P0, P1, P2: Integer; Data: Pointer): Integer; stdcall;
function RuntimeRunMessageC(Msg: PAMessageRec): Integer; stdcall;

implementation

const
  AUserModuleID_Low = 1024;
  AMessageID_Low   = 1;
  errCoreModuleIDIsFill = 'Зарегистрированых модулей слишком много';
  //stTitle = APlatformName;

{ Functions }

procedure InitializeRuntime();
begin
  if not(Assigned(Runtime)) then
    TARuntime.Create();
end;

function RuntimeRunMessage(ReceiverModuleID: TAModuleID; Command: TACommand;
    P0, P1, P2: Integer; Data: Pointer): Integer;
begin
  Result := Runtime.RunMessage(Command, P0, P1, P2, Data, ReceiverModuleID);
end;

function RuntimeRunMessageC(Msg: PAMessageRec): Integer;
begin
  Result := Runtime.RunMessageC(Msg);
end;

{ TARuntime }

procedure TARuntime.Clear();
begin
  SetLength(FModules, 0);
  FNextMessageID := AMessageID_Low;
  FNextModuleID := AUserModuleID_Low;
end;

constructor TARuntime.Create();
begin
  inherited Create();
  //if Assigned(Runtime) then
  //  raise Exception.Create('Runtime не может быть создан дважды');

  Runtime := Self;
  FNextMessageID := AMessageID_Low;
  FNextModuleID := AUserModuleID_Low;
  FIsExit := False;
end;

function TARuntime.GetModuleByID(ID: Integer): TAAbstractModule;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to High(FModules) do
  begin
    if (Assigned(FModules[i])) and (FModules[i].ModuleID = ID) then
    begin
      Result := FModules[i];
      Exit;
    end;
  end;
end;

function TARuntime.GetModuleByIndex(Index: Integer): TAAbstractModule;
begin
  if (Index >= 0) and (Index < Length(FModules)) then
    Result := FModules[Index]
  else
    Result := nil;
end;

function TARuntime.GetModuleCount(): Integer;
begin
  Result := Length(FModules);
end;

function TARuntime.GetNextMessageID(): Integer;
begin
  Result := FNextMessageID;
  if (FNextMessageID = High(FNextMessageID)) then
    FNextMessageID := 1
  else
    Inc(FNextMessageID);
end;

function TARuntime.GetNextModuleID(): Integer;

  function IsFreeID(ModuleID: TAModuleID): Boolean;
  var
    j: Integer;
  begin
    Result := True;
    for j := 0 to High(FModules) do
      if (FModules[j].ModuleID = ModuleID) then
      begin
        Result := False;
        Exit;
      end;
  end;

  function SearchFreeID(FromID, ToID: Integer): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i := FromID to ToID do
      if IsFreeID(i) then
      begin
        Result := True;
        FNextModuleID := i;
        Exit;
      end;
  end;

begin
  Result := FNextModuleID;
  if (FNextModuleID = High(FNextModuleID)) then
  begin
    // Поиск свободного идентификатора модуля
    if not(SearchFreeID(AUserModuleID_Low, High(FNextModuleID))) then
    begin
      MessageBox(0, PChar(errCoreModuleIDIsFill), nil{PChar(stTitle)}, MB_OK or MB_ICONSTOP or MB_TASKMODAL);
      Result := -1;
      Exit;
    end;
  end
  else
    if not(SearchFreeID(FNextModuleID + 1, High(FNextModuleID))) then
      if not(SearchFreeID(AUserModuleID_Low, FNextModuleID - 1)) then
      begin
        MessageBox(0, PChar(errCoreModuleIDIsFill), nil{PChar(stTitle)}, MB_OK or MB_ICONSTOP or MB_TASKMODAL);
        Result := -1;
        Exit;
      end;
end;

function TARuntime.RegisterModule(Module: TAAbstractModule): Integer;
var
  i: Integer;
begin
  Result := GetNextModuleID();
  i := Length(FModules);
  SetLength(FModules, i + 1);
  FModules[i] := Module;
end;

procedure TARuntime.RunExitCommand();
var
  i: Integer;
begin
  if FIsExit then
  begin
    // Финализация всех модулей
    for i := 0 to High(FModules) do
    begin
      FModules[i].Finalize();
    end;

    //FRuntimeCommandTurn.PushCommand(ExitCommand, nil);
    //Halt(0);
    //Application.MainForm.Close();
  end;
end;

function TARuntime.RunMessage(Command: TACommand; P0, P1, P2: Integer; Data: Pointer;
    ReceiverModuleID: TAModuleID): Integer;
var
  module: TAAbstractModule;
begin
  module := ModuleByID[ReceiverModuleID];
  if Assigned(module) then
    Result := module.RunMessage(Command, P0, P1, P2, Data)
  else
    Result := 0;
end;

function TARuntime.RunMessageC(Msg: PAMessageRec): Integer;
var
  //hThread: Integer;
  module: TAAbstractModule;
begin
  module := ModuleByID[Msg^.ReceiverModuleID];
  if not(Assigned(module)) then
  begin
    Result := 100;
    Exit;
  end;

  // Перенаправляет сообщение указаному модулю с назначением идентификатора сообщения (MessageID) и
  // указанием отправителя (SenderID)
  Msg^.MessageID := GetNextMessageID();
  //hThread := Windows.GetCurrentThread();
  Msg^.SenderModuleID := 0; // ...
  Result := module.RunMessageC(Msg);
  // TODO: Сделать перенаправление сообщения необходимому модулю
end;

function TARuntime.UnRegisterModule(Module: TAAbstractModule): Boolean;
var
  i: Integer;
begin
  for i := 0 to High(FModules) do
    if (FModules[i] = Module) then
    begin
      FModules[i] := FModules[High(FModules)];
      SetLength(FModules, High(FModules));
      Result := True;
      Exit;
    end;
  Result := False;
end;

end.
