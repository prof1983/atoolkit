{**
@Abstract(Общие интерфейсы для всех проектов)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.02.2007)
@LastMod(02.07.2012)
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

  IProfObject2 = interface
      //** Загрузить конфигурации
    function ConfigureLoad2(AConfig: IXmlNode): WordBool; safecall;
      //** Сохранить конфигурации
    function ConfigureSave2(AConfig: IXmlNode): WordBool; safecall;
      //** Срабатывает, когда нужно выполнить внешнюю команду. см. TProcMessageStr
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
    function Get_Config(): AProfXmlNode2{IProfXmlNode2006}; safecall;
    function Get_Log(): ILogNode2; safecall;
    procedure Set_Config(const Value: AProfXmlNode2{IProfXmlNode2006}); safecall;
    procedure Set_Log(const Value: ILogNode2); safecall;

    property Config: AProfXmlNode2{IProfXmlNode2006} read Get_Config write Set_Config;
    property Log: ILogNode2 read Get_Log write Set_Log;
  end;

  IProfObjectA = IProfObject2;
  IProfBaseObject = IProfObject;

implementation

end.
