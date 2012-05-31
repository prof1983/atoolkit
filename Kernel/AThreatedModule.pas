{**
@Abstract(Модуль, функционирующий в своем подпроцессе)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.03.2008)
@LastMod(05.07.2011)
@Version(0.5)

Этот класс используется для подключения потокового модуля в общий Runtime.
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
    //** @abstract(Возвращяет идентификатор модуля)
    function GetModuleID(): TAModuleID; override; safecall;
    //** @abstract(Возвращяет имя модуля)
    function GetModuleName(): WideString; override; safecall;
  public
    constructor Create(Module: TAModule);
    destructor Destroy(); override;
    //** @abstract(Финализировать модуль)
    function Finalize(): Integer; override; safecall;
    //** @abstract(Инициализировать модуль)
    function Initialize(AModuleID: TAModuleID; ASendMessage: TACoreRunMessageProc2): Integer; override; safecall;
    //** @abstract(Добавляет сообщение для обработки в порядке очереди)
    function RunMessage(Command: TACommand; P0, P1, P2: Integer; Data: Pointer): Integer; override; safecall;
    //** @abstract(Обрабатывает сообщение)
    function RunMessageC(Msg: PAMessageRec): Integer; override; safecall;
    //** @abstract(Обрабатывает сообщение вне очереди)
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
  // Если подпроцесс в работе, то завершаем работу с ожиданием
  if (FModuleThread.State <> psTerminated) then
  begin
    FModuleThread.Terminate();
    // Подождем завершения
    i := 0;
    repeat
      Sleep(10);
      if (FModuleThread.State = psTerminated) then
        Break;
    until (i < 10);
    // Принудительно останавливаем подпроцесс
    FModuleThread.Suspend();
  end;
  FModuleThread.Free();
  FModuleThread := nil;
  inherited;
end;

function TAThreatedModule.Finalize(): Integer;
begin
  //Self.RunMessageNow(cmdModuleFinalize, 0, 0, 0, nil);
  // Останавливаем выполнение подпроцесса
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
  // Назначаем идентификатор модуля и CallBack функцию
  FModuleThread.ModuleID := AModuleID;
  FModuleThread.SendMessage := ASendMessage;
  // Запускаем выполнение подпроцесса
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
 