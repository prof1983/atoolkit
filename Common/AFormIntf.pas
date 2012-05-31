{**
@Abstract(AForm interface)
@Author(Prof1983 prof1983@ya.ru)
@Created(12.03.2012)
@LastMod(26.06.2012)
@Version(0.5)
}
unit AFormIntf;

interface

uses
  ANodeIntf, ATypes;

type //** Интерфейс для любой формы
  IProfForm = interface
    //** Добавление лог-сообщений
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
    //** Загрузить конфигурации
    function ConfigureLoad(AConfig: IProfNode): WordBool; safecall;
    //** Сохранить конфигурации
    function ConfigureSave(AConfig: IProfNode): WordBool; safecall;
    //** Срабатывает при создании объекта
    //procedure DoCreate(); safecall;
    //** Срабатывает при уничтожении объекта
    //procedure DoDestroy(); safecall;
    //** Срабатывает при добавлении сообщения ???
    //function DoMessage(const AMsg: WideString): Integer; safecall;
    //** Финализировать
    function Finalize(): TProfError;
    //** Инициализировать
    function Initialize(): TProfError;

    function GetConfig(): IProfNode; safecall;
    //function GetLog(): ILogNode; safecall;
    procedure SetConfig(const Value: IProfNode); safecall;
    //procedure SetLog(const Value: ILogNode); safecall;

    property Config: IProfNode read GetConfig write SetConfig;
    //property Log: ILogNode read GetLog write SetLog;
  end;

  IProfForm2 = interface(IProfForm)
    //** Срабатывает, когда нужно выполнить внешнюю команду. см. TProfMessage
    function DoCommand(const AMsg: WideString): Integer; safecall;
    //** Срабатывает при добавлении сообщения
    function DoMessage(const AMsg: WideString): Integer; safecall;
  end;

implementation

end.
