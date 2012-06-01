{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(25.05.2012)
@LastMod(25.05.2012)
@Version(0.5)
}
unit AReaderIntf;

interface

type
  //** @abstract(Интерфейс чтения значений)
  IProfReader = interface
    function ReadBool(const Name: WideString; var Value: WordBool): WordBool; safecall;
    function ReadBoolDef(const Name: WideString; DefValue: WordBool): WordBool; safecall;
    function ReadDateTime(const Name: WideString; var Value: TDateTime): WordBool; safecall;
    function ReadDateTimeDef(const Name: WideString; DefValue: TDateTime): TDateTime; safecall;
    function ReadFloat64(const Name: WideString; var Value: Double): WordBool; safecall;
    function ReadFloat64Def(const Name: WideString; DefValue: Double): Double; safecall;
    function ReadInt32(const Name: WideString; var Value: Integer): WordBool; safecall;
    function ReadInt32Def(const Name: WideString; DefValue: Integer): Integer; safecall;
    function ReadInt64(const Name: WideString; var Value: Int64): WordBool; safecall;
    function ReadInt64Def(const Name: WideString; DefValue: Int64): Int64; safecall;
    function ReadString(const Name: WideString; var Value: WideString): WordBool; safecall;
    function ReadStringDef(const Name: WideString; const DefValue: WideString): WideString; safecall;
  end;

  //** @abstract(Интерфейс чтения значений с вложеными ветками)
  IProfReader2 = interface(IProfReader)
    function GetReaderByName(const Name: WideString): IProfReader2; safecall;

    property ReaderByName[const Name: WideString]: IProfReader2 read GetReaderByName;
  end;

implementation

end.
