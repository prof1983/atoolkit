{**
@Abstract Общие интерфейсы для всех проектов
@Author Prof1983 <prof1983@ya.ru>
@Created 25.02.2007
@LastMod 23.11.2012
}
unit AProcessIntf;

interface

uses
  ABase, AObjectIntf;

type //** Интерфейс для любого процесса
  IProfProcess = interface(IProfObject)
    function Pause(): AError; safecall;
    //** Начать выполнение процесса
    function Start(): AError; safecall;
    //** Остановить выполнение процесса
    function Stop(AIsShutDown: WordBool): AError; safecall;
  end;

type //** Интерфейс для любого процесса
  IProfProcess20070401 = interface(IProfObject)
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

    //** Начать выполнение процесса
    function Start(): WordBool; safecall;
    //** Остановить выполнение процесса
    function Stop(): WordBool; safecall;
  end;

implementation

end.
