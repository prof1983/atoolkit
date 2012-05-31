{**
@Abstract(Базовый интерфейс потока ввода/вывода)
@Author(Prof1983 prof1983@ya.ru)
@Created(18.04.2004)
@LastMod(25.04.2012)
@Version(0.5)
}
unit AStreamIntf;

interface

uses
  ATypes;

type //** Интерфейс потока
  IProfStream = interface
    function ReadInt08(var Value: Int08): TProfError;
    function ReadInt16(var Value: Int16): TProfError;
    function ReadInt32(var Value: Int32): TProfError;
    function ReadInt64(var Value: Int64): TProfError;
    function ReadUInt08(var Value: UInt08): TProfError;
    function ReadUInt16(var Value: UInt16): TProfError;
    function ReadUInt32(var Value: UInt32): TProfError;
    function ReadUInt64(var Value: UInt64): TProfError;
    function WriteInt08(Value: Int08): TProfError;
    function WriteInt16(Value: Int16): TProfError;
    function WriteInt32(Value: Int32): TProfError;
    function WriteInt64(Value: Int64): TProfError;
    function WriteUInt08(Value: UInt08): TProfError;
    function WriteUInt16(Value: UInt16): TProfError;
    function WriteUInt32(Value: UInt32): TProfError;
    function WriteUInt64(Value: UInt64): TProfError;
  end;

implementation

end.
