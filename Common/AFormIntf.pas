{**
@Abstract AForm interface
@Author Prof1983 <prof1983@ya.ru>
@Created 12.03.2012
@LastMod 12.11.2012
}
unit AFormIntf;

interface

uses
  ABase, ANodeIntf, ATypes;

type //** Интерфейс для любой формы
  IProfForm = interface
    //** Добавление лог-сообщений
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: WideString): AInt;
    //** Загрузить конфигурации
    function ConfigureLoad(Config: AConfig{IProfNode}): AError;
    //** Сохранить конфигурации
    function ConfigureSave(Config: AConfig{IProfNode}): AError;
    //** Финализировать
    function Finalize(): AError;
    //** Инициализировать
    function Initialize(): AError;

    function GetConfig(): AConfig{IProfNode}; {safecall;}
    procedure SetConfig(const Value: AConfig{IProfNode}); {safecall;}

    //property Config: AConfig{IProfNode} read GetConfig write SetConfig;
  end;

  IProfForm2 = interface(IProfForm)
    //** Срабатывает, когда нужно выполнить внешнюю команду. см. TProcMessageStr
    function DoCommand(const AMsg: WideString): Integer; safecall;
    //** Срабатывает при добавлении сообщения
    function DoMessage(const AMsg: WideString): Integer; safecall;
  end;

implementation

end.
