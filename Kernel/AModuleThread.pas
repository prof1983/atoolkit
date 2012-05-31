{**
@Abstract(Подпроцесс для модуля)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.03.2008)
@LastMod(04.07.2011)
@Version(0.5)

Для каждого плугина создается свой подпроцесс.
Сообщения передаются через очередь сообщений.
}
unit AModuleThread;

{
Для каждого плугина создаем подпроцесс.

psNone
  - Exit
  - Intialize
    - psInitializing
      - psInitializeError
        - Exit
      - psInitialized
        - Finalize
          - psFinalizeError
            - Exit
          - psFinalized
            - Initialize
            - Exit
        - Start
          - psStarting
            - psStartError
              - Finalize
            - psStarted
              - Stop
                - psStoping
                  - psStopError
                    - Finalize
                  - psStoped
                    - Start
                    - Finalize
              - Pause
                - psPausing
                  - psPauseError
                    - Stop
                  - psPaused
                    - Start
                    - Stop
}

interface

// TODO: Реализовать CallBack функцию для плугина

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
  private // Для внеочередного сообщения
    //FNowMessageBusy: Boolean;
    FNowMessageResult: Integer;
    FNowMessageRun: Boolean;
  private
    FModule: TAAbstractModule;
    FState: TPluginState;
    FMessageQueue: TQueue;
    FModuleID: TAModuleID;
    {**
      @abstract(True, если очередь сообщения занята)
      Обращение к FMessageQueue разрешается только когда FMessageQueueBysy = False.
    }
    FMessageQueueBusy: Boolean;
    FNowMessage: TAMessageRec;
    FSendMessage: TACoreRunMessageProc2;
    function GetIsTerminated(): Boolean;
    //** @abstract()
    function GetNextMessage(): PAMessageRec;
    function RunMessage(msg: PAMessageRec): Integer;
  protected
    procedure Execute(); override;
  public
    constructor Create(Module: TAAbstractModule);
    destructor Destroy(); override;
    //** @abstract(Финализировать плугин)
    function FinalizePlugin(MessageID: TAMessageID): Integer;
    //** @abstract(Инициализировать плугин)
    function InitializePlugin(MessageID: TAMessageID): Integer;
    //** @abstract(Начать/продолжить выполнение внутреннего подпроцесса в модуле (если он есть))
    function StartPlugin(MessageID: Integer): Integer;
    //** @abstract(Завершить выполнение внутреннего подпроцесса в модуле (если он есть))
    function StopPlugin(MessageID: Integer): Integer;
    //** @abstract(Приостановить выполнение внутреннего подпроцесса в модуле (если он есть))
    function PausePlugin(MessageID: TAMessageID): Integer;
    {**
      @abstract(Поместить сообщение в стек)
      IsNow - True, если требуется выполнить немедленно. В этом случае сообщение
          помещается как внеочередное и функция ожидает выполнения некоторое время.
          Если выполнение обработки сообщения не завершено(или не начато) за определенное время, то
          возвращяется ошибка, иначе возвращяется результат обработки сообщения.
    }
    function PushMessage(MessageID: TAMessageID; Command: TACommand; Param0, Param1, Param2: Integer;
      Data: Pointer; IsNow: Boolean = False): Integer;
    //** @abstract(Поместить сообщение в стек)
    function PushMessageC(MessageRec: PAMessageRec): Integer;
  public
    {**
      @abstract(CallBack функция обработки сообщения ядром)
      Должна задаваться до инициализации модуля. Передается модулю как параметр при инициализации.
      Вызывается модулем.
    }
    property SendMessage: TACoreRunMessageProc2 read FSendMessage write FSendMessage;
    {**
      @abstract(True, если идет завершение подпроцесса)
      После завершения подпроцесса State = psTerminated.
    }
    property IsTerminated: Boolean read GetIsTerminated;
    //** @abstract(Идентификатор модуля. Используется только при инициализации)
    property ModuleID: TAModuleID read FModuleID write FModuleID;
    //** @abstract(Структура, полученая при загрузке плугина)
    property Module: TAAbstractModule read FModule; //write SetModule;
    //** @abstract(Текущее состояние модуля)
    property State: TPluginState read FState;
  end;

implementation

const
  // Максимальное количество попыток обратится к очереди сообщений
  ChechBusyMaxCount = 10;
  // Время ожидания освобождения очереди сообщений
  CheckBusySleep = 1;

{ TAssistantModuleThread }

constructor TAModuleThread.Create(Module: TAAbstractModule);
begin
  inherited Create(True);
  FModule := Module;
  // Делаем приоритет подпроцесса чуть ниже, чем приоритет основной программы (ядра)
  Self.Priority := tpLower;
  // Создаем очередь сообщений
  FMessageQueue := TQueue.Create();
  // Разрешаем обращения к очереди сообщений
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
  //msg1: TAMessageRec;
begin
  //msg1.Command := cmdInitialize();
  //FModule.RunMessage(cmdinitialize, 0, 0, 0, nil);
  repeat
    if FMessageQueueBusy then
      Continue;

    // Если есть внеочередное сообщение, то обрабатываем сначала его
    if FNowMessageRun then
    begin
      FNowMessageResult := RunMessage(PAMessageRec(Addr(FNowMessage)));
      FNowMessageRun := False;
    end;

    // Получаем очередное сообщение
    msg := GetNextMessage();

    if Assigned(msg) then
    begin
      // Обработаем сообщение
      RunMessage(msg);

      // Удаляем отработаное сообщение
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
  // Запрещаем обращения к очереди сообщений
  FMessageQueueBusy := True;

  // Получаем очередное сообщение
  if FMessageQueue.Count > 0 then
    Result := FMessageQueue.Pop()
  else
    Result := nil;

  // Разрешаем обращения к очереди сообщений
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
    // Если в данный момент выполняется внеочередная функция, то выходим
    if FNowMessageRun then
    begin
      Result := rFalse;
      Exit;
    end;
    // Блокируем FNowMessage
    //FIsNowMessageBusy := True;
    // Формируем сообщение
    FNowMessage.MessageID := MessageID;
    FNowMessage.SenderModuleID := midCore;
    FNowMessage.ReceiverModuleID := FModule.ModuleID; // Фактически не используется
    FNowMessage.Command := Command;
    FNowMessage.Param0 := Param0;
    FNowMessage.Param1 := Param1;
    FNowMessage.Param2 := Param2;
    FNowMessage.Data := Data;
    // Разблокируем FNowMessage
    //FIsNowMessageBusy := False;
    // Указываем обработать внеочередное сообщение
    FNowMessageRun := True;
    // Немного подождем, пока сообщение обработается
    i := 0;
    repeat
      Sleep(10);
      // Если сообщение обработано, то возврящаем результат и выходим
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
    msg.ReceiverModuleID := FModule.ModuleID; // Фактически не используется
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
    // Если в данный момент мы можем обратится к очереди сообщений,
    // то добавляем сообщение в очередь, иначе маленько ждем и пробуем снова,
    // но не более ChechBusyCount раз.
    if (FMessageQueueBusy = False) then
    begin
      // Запрещаем другим обращения к очереди сообщений
      FMessageQueueBusy := True;
      // Копируем сообщение полностью (включая и данные)
      GetMem(msg, SizeOf(TAMessageRec));
      Move(MessageRec^, msg^, SizeOf(TAMessageRec));
      if Assigned(msg^.Data) then
        Move(MessageRec^.Data^, msg^.Data^, Integer(msg^.Data^));
      // Добавляем сообщение в очередь
      FMessageQueue.Push(msg);
      // Разрешаем другим обращения к очереди сообщений
      FMessageQueueBusy := False;
      // Сообщение добавлено -> выходим
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
          // TODO: Завершение процесса только для модуля GUI
          //Self.Terminate();
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
