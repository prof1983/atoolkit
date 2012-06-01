{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(25.05.2012)
@LastMod(25.05.2012)
@Version(0.5)
}
unit AWriterIntf;

interface

type //** @abstract(Интерфейс записи значений)
  IProfWriter = interface
    function WriteBool(const Name: WideString; Value: WordBool): WordBool; safecall;
    function WriteDateTime(const Name: WideString; Value: TDateTime): WordBool; safecall;
    function WriteFloat64(const Name: WideString; Value: Double): WordBool; safecall;
    function WriteInt32(const Name: WideString; Value: Integer): WordBool; safecall;
    function WriteInt64(const Name: WideString; Value: Int64): WordBool; safecall;
    function WriteString(const Name, Value: WideString): WordBool; safecall;
  end;

type //** @abstract(Интерфейс записи значений с вложеными ветками)
  IProfWriter2 = interface(IProfWriter)
    function GetWriterByName(const Name: WideString): IProfWriter2; safecall;

    property WriterByName[const Name: WideString]: IProfWriter2 read GetWriterByName;
  end;

implementation

end.
