{**
@Abstract(Подпроцесс)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.08.2007)
@LastMod(05.05.2012)
@Version(0.5)
}
unit AProcessIntf2007;

interface

type //** Подпроцесс
  IProcess = interface
    function GetPriority(): Integer;
    function GetState(): Integer;
    procedure SetPriority(Value: Integer);

    procedure Initialize();
    procedure Finalize();
    procedure Start();
    procedure Stop();
    procedure Pause();

    // Приоритет
    property Priority: Integer read GetPriority write SetPriority;
    // Состояние процесса 
    property State: Integer read GetState;
  end;

implementation

end.
