{**
@Abstract(Модуль)
@Author(Prof1983 prof1983@ya.ru)
@Created(28.08.2007)
@LastMod(04.07.2011)
@Version(0.5)

-Модуль может иметь неограниченное число точек расширения (ExtensionPoint).
-Модуль может зависеть от других модулей (Dependences).
-Зависимости определяются в информации о модуле (Information).

20.06.2011 - Prof1983
[*] Сменил версию на 0.0.3
25.03.2008 - Prof1983
[+] TAAbstractModule
0.0.1.12
[*] Initialize
[+] DoInitialize, DoFinalize, IAModule
}
unit AModule;

interface

uses
  ABase;

type
  TACommand = Integer;
  TAMessageID = Integer;
  TAModuleID = Integer;

type
  PAMessageRec = ^TAMessageRec;
  // @abstract(Струкрура для передачи сообщения внутри ядра и для компонент)
  TAMessageRec = packed record // 32 bytes
    //** @abstract(Идентификатор сообщения)
    MessageID: TAMessageID;
    //** @abstract(Идентификатор модуля источника сообщения)
    SenderModuleID: TAModuleID; // Param3
    //** @abstract(Идентификатор модуля назначения сообщения)
    ReceiverModuleID: TAModuleID;
    //** @abstract(Команда)
    Command: TACommand;
    //** @abstract(Произвольный параметр 0)
    Param0: Integer;
    //** @abstract(Произвольный параметр 1)
    Param1: Integer;
    //** @abstract(Произвольный параметр 2)
    Param2: Integer;
    {**
      @abstract(Данные)
      Размер данных располагается в первых 4х байтах по указаному адресу.
    }
    Data: Pointer;
  end;

type
  {**
    @abstract(Процедура вызова команд и передачи сообщений для компонент)
    Компонент - это модуль, который функционирует в отдельном подпроцессе и сообщения передаются
    через очередь сообщений.
    Для компонент передается много параметров, кроме этого сообщение хранится в очереди сообщений.
    Поэтому передавать параматры удобнее как ссылку на структуру TAssistantMessageRec.
  }
  TAComponentRunMessageProc = function(Msg: PAMessageRec): Integer; stdcall;
  {**
    @abstract(Процедура вызова команд у модуля)
    Используется для вызова команд в ядре из assistant.exe
  }
  TAModuleRunMessageProc = function(Command: TACommand; Param0, Param1, Param2: Integer; Data: Pointer): Integer; stdcall;
  {**
    @abstract(Процедура ядра для вызова команд из модулей и передача сообщений внутри ядра)
    Используется для передача сообщений между модулями,
    а также для вызова команд и передача сообщений из компонент.
    (При вызове команд между модулями ядра не указывается Sender и не назначается ModuleID.)
    При вызове для передачи компоненте сообщение ставится в очередь и для сообщения
    определяется Sender (по ThreadID или ThreadHandle) и назначается MessageID.
    При вызове для передачи компоненте процедура возвращяет присвоеный идентификатор сообщения,
    в остальных случаях возвращяет результат выполнения команды TAssistantResult.
  }
  TACoreRunMessageProc2 = function(ReceiverModuleID: TAModuleID; Command: TACommand;
      Param0, Param1, Param2: Integer; Data: Pointer): Integer; stdcall;

type
  IAModule = interface
    //** @abstract(Возвращяет идентификатор модуля)
    function GetModuleID(): TAModuleID; safecall;
    //** @abstract(Возвращяет имя модуля)
    function GetModuleName(): WideString; safecall;

    //** @abstract(Финализирует модуль)
    function Finalize(): Integer; safecall;
    //** @abstract(Инициализирует модуль)
    function Initialize(AModuleID: TAModuleID; ASendMessage: TACoreRunMessageProc2): Integer; safecall;
    {**
      @abstract(Обрабатывает сообщение)
      Для модулей, которые работают в отдельном подпроцессе эта функция не используется.
    }
    function RunMessage(Command: TACommand; P0, P1, P2: Integer; Data: Pointer): Integer; safecall;
    //** @abstract(Обрабатывает сообщение)
    function RunMessageC(Msg: PAMessageRec): Integer; safecall;

    {**
      @abstract(Идентификатор модуля)
      Идентификатор модуля назначается ядром при регистрации модуля
      (передается модулю при инициализации).
    }
    property ModuleID: TAModuleID read GetModuleID;
    {**
      @abstract(Имя модуля)
      Имя модуля заложено в модуле при его создании.
    }
    property ModuleName: WideString read GetModuleName;
  end;

type
  //** @abstract(Абстрактный модуль)
  TAAbstractModule = class(TInterfacedObject, IAModule)
  protected
    //** @abstract(Возвращяет идентификатор модуля)
    function GetModuleID(): TAModuleID; virtual; safecall; abstract;
    //** @abstract(Возвращяет имя модуля)
    function GetModuleName(): WideString; virtual; safecall; abstract;
  public
    //** @abstract(Финализировать модуль)
    function Finalize(): Integer; virtual; safecall; abstract;
    //** @abstract(Инициализировать модуль)
    function Initialize(AModuleID: TAModuleID; ASendMessage: TACoreRunMessageProc2): Integer; virtual; safecall; abstract;
    //** @abstract(Обрабатывает сообщение)
    function RunMessage(Command: TACommand; P0, P1, P2: Integer; Data: Pointer): Integer; virtual; safecall; abstract;
    //** @abstract(Обрабатывает сообщение)
    function RunMessageC(Msg: PAMessageRec): Integer; virtual; safecall; abstract;
  public
    //** @abstract(Идентификатор модуля)
    property ModuleID: TAModuleID read GetModuleID;
    //** @abstract(Имя модуля)
    property ModuleName: WideString read GetModuleName;
  end;

type
  //** @abstract(Базовый класс реализации модуля)
  TAModule = class(TAAbstractModule)
  protected
    //** @abstract(Идентификатор модуля. Присваивается ядром при регистрации.)
    FModuleID: TAModuleID;
    //** Имя модуля
    FModuleName: WideString;
    //** @abstract(Процедура передачи сообщения ядру для обработки)
    FSendMessage: TACoreRunMessageProc2;
    function DoInitialize(): Integer; virtual;
    function DoFinalize(): Integer; virtual;
    function GetModuleID(): Integer; override; safecall;
    function GetModuleName(): WideString; override; safecall;
  public
    //** @abstract(Финализировать модуль)
    function Finalize(): Integer; override; safecall;
    //** @abstract(Инициализировать модуль)
    function Initialize(AModuleID: TAModuleID; ASendMessage: TACoreRunMessageProc2): Integer; override; safecall;
    //** @abstract(Обрабатывает сообщение)
    function RunMessage(Command: TACommand; P0, P1, P2: Integer; Data: Pointer): Integer; override; safecall;
    //** @abstract(Обрабатывает сообщение)
    function RunMessageC(Msg: PAMessageRec): Integer; override; safecall;
  public
    //** @abstract(Идентификатор модуля)
    property ModuleID: TAModuleID read FModuleID;
    //** @abstract(Имя модуля)
    property ModuleName: WideString read FModuleName write FModuleName;
  end;

implementation

{ TAModule }

function TAModule.DoFinalize(): Integer;
begin
  Result := 0;
end;

function TAModule.DoInitialize(): Integer;
begin
  Result := 0;
end;

function TAModule.Finalize(): Integer;
begin
  Result := DoFinalize();
end;

function TAModule.GetModuleID(): TAModuleID;
begin
  Result := FModuleID;
end;

function TAModule.GetModuleName(): WideString;
begin
  Result := FModuleName;
end;

function TAModule.Initialize(AModuleID: TAModuleID; ASendMessage: TACoreRunMessageProc2): Integer;
begin
  FModuleID := AModuleID;
  FSendMessage := ASendMessage;
  Result := DoInitialize();
end;

function TAModule.RunMessage(Command: TACommand; P0, P1, P2: Integer; Data: Pointer): Integer;
begin
  Result := -1;
end;

function TAModule.RunMessageC(Msg: PAMessageRec): Integer;
begin
  Result := -1;
end;

end.
