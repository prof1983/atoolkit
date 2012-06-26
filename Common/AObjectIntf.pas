{**
@Abstract(Общие интерфейсы для всех проектов)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.02.2007)
@LastMod(26.06.2012)
@Version(0.5)
}
unit AObjectIntf;

interface

uses
  XmlIntf,
  AEntityIntf, ALogNodeIntf, ANodeIntf, ATypes, AXmlNodeIntf;

type //** Интерфейс для любого объекта
  IProfObject = interface(IANamedEntity)
    function GetConfigNode(): IProfNode; safecall;
    function GetLogNode(): IProfLogNode; safecall;
    procedure SetConfigNode(Value: IProfNode); safecall;
    procedure SetLogNode(Value: IProfLogNode); safecall;

      //** Добавить (выполнить) сообщение
    function AddMessage(const Msg: WideString): Integer; safecall;
      //** Загрузить конфигурации
    function ConfigureLoad(AConfig: IProfNode): TProfError; safecall;
      //** Сохранить конфигурации
    function ConfigureSave(AConfig: IProfNode): TProfError; safecall;
      //** Финализировать
    function Finalize(): TProfError;
      //** Инициализировать
    function Initialize(): TProfError;
      //** Передать сообщение
    function SendMessage(const Msg: WideString): Integer; safecall;

    property ConfigNode: IProfNode read GetConfigNode write SetConfigNode;
    property LogNode: IProfLogNode read GetLogNode write SetLogNode;
  end;

{type //** @abstract(Интерфейс для любого объекта)
  IProfObject20070401 = interface
    function GetConfig(): IProfNode; safecall;
    //function GetLog(): ILogNode; safecall;
    procedure SetConfig(const Value: IProfNode); safecall;
    //procedure SetLog(const Value: ILogNode); safecall;

    //** Срабатывает, когда нужно выполнить внешнюю команду. см. TProfMessage
    //function DoCommand(const AMsg: WideString): Integer; safecall;
    //** Срабатывает при создании объекта
    procedure DoCreate(); safecall;
    //** Срабатывает после создании объекта
    procedure DoCreated(); safecall;
    //** Срабатывает при уничтожении объекта
    procedure DoDestroy(); safecall;
    //** Срабатывает при финализации
    function DoFinalize(): WordBool; safecall;
    //** Срабатывает после финализации
    function DoFinalized(): WordBool; safecall;
    //** Срабатывает при инициализации
    function DoInitialize(): WordBool; safecall;
    //** Срабатывает после инициализации
    function DoInitialized(): WordBool; safecall;
    //** Срабатывает при добавлении сообщения
    function DoMessage(const AMsg: WideString): Integer; safecall;

    //** Добавление лог-сообщений
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; safecall;
    //** Загрузить конфигурации
    function ConfigureLoad(AConfig: IProfNode): WordBool; safecall;
    //** Сохранить конфигурации
    function ConfigureSave(AConfig: IProfNode): WordBool; safecall;

    //** Финализировать
    function Finalize(): WordBool; safecall;
    //** Инициализировать
    function Initialize(): WordBool; safecall;

    property Config: IProfNode read GetConfig write SetConfig;
    //property Log: ILogNode read GetLog write SetLog;
  end;
  IProfObject2007 = IProfObject20070401;}

  IProfObject2 = interface
      //** Загрузить конфигурации
    function ConfigureLoad2(AConfig: IXmlNode): WordBool; safecall;
      //** Сохранить конфигурации
    function ConfigureSave2(AConfig: IXmlNode): WordBool; safecall;
      //** Срабатывает, когда нужно выполнить внешнюю команду. см. TProfMessage
    function DoCommand(const AMsg: WideString): WordBool; safecall;
      //** Срабатывает при создании объекта
    procedure DoCreate(); safecall;
      //** Срабатывает при уничтожении объекта
    procedure DoDestroy(); safecall;
      //** Срабатывает при начале запуска
    function DoStart(): WordBool; safecall;
      //** Срабатывает после удачного запуска
    function DoStarted(): WordBool; safecall;
      //** Срабатывает при начале процедуры остановки
    function DoStop(AIsShutDown: WordBool): WordBool; safecall;
      //** Срабатывает при завершении процедуры остановки
    function DoStoped(AIsShutDown: WordBool): WordBool; safecall;
      //** Финализировать
    function Finalize(): TProfError;
      //** Инициализировать
    function Initialize(): TProfError;
      //** Функция логирования
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; safecall;
      //** Функция логирования
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer; safecall;

    function GetConfig(): IXmlNode; safecall;
    function GetLog(): ILogNode2; safecall;
    procedure SetConfig(const Value: IXmlNode); safecall;
    procedure SetLog(const Value: ILogNode2); safecall;

    property Config: IXmlNode read GetConfig write SetConfig;
    property Log: ILogNode2 read GetLog write SetLog;
  end;

    // LastMod(16.03.2006)
  IProfObject2006 = interface
    function ConfigureLoad(): WordBool; safecall;
    function ConfigureSave(): WordBool; safecall;
    function Finalize(): WordBool; safecall;
    function Initialize(): WordBool; safecall;
    function Get_Config(): IProfXmlNode2006; safecall;
    function Get_Log(): ILogNode2; safecall;
    procedure Set_Config(const Value: IProfXmlNode2006); safecall;
    procedure Set_Log(const Value: ILogNode2); safecall;

    property Config: IProfXmlNode2006 read Get_Config write Set_Config;
    property Log: ILogNode2 read Get_Log write Set_Log;
  end;

  IProfObjectA = IProfObject2;
  IProfBaseObject = IProfObject;

implementation

end.
