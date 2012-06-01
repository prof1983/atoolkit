{**
@Abstract(Интерфейс для создания лог-журналов)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.06.2007)
@LastMod(24.04.2012)
@Version(0.5)

История версий
0.0.0.5 - 06.07.2007 - AILogJournal -> LogJournal
0.0.0.4 - 05.07.2007
0.0.0.3 - 04.07.2007
0.0.0.2 - 23.06.2007
}
unit ALogJournal;

interface

type //** Класс для создания лог-журналов
  TLogJournal = class
    function AddToLog(Msg: WideString): Integer; virtual;
  end;

implementation

{ TLogJournal }

function TLogJournal.AddToLog(Msg: WideString): Integer;
begin
  Result := 0;
end;

end.
