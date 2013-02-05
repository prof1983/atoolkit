{**
@Author Prof1983 <prof1983@ya.ru>
@Created 23.06.2007
@LastMod 24.04.2012
}
unit ALogJournal;

interface

type
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
