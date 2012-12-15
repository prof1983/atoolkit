{**
@Abstract Базовый интерфейс потока ввода/вывода
@Author Prof1983 <prof1983@ya.ru>
@Created 18.04.2004
@LastMod 15.12.2012
}
unit AStreamIntf;

interface

uses
  ABase;

type //** Интерфейс потока
  IProfStream = interface
    function ReadInt08(var Value: AInt08): AError;
    function ReadInt16(var Value: AInt16): AError;
    function ReadInt32(var Value: AInt32): AError;
    function ReadInt64(var Value: AInt64): AError;
    function ReadUInt08(var Value: AUInt08): AError;
    function ReadUInt16(var Value: AUInt16): AError;
    function ReadUInt32(var Value: AUInt32): AError;
    function ReadUInt64(var Value: AUInt64): AError;
    function WriteInt08(Value: AInt08): AError;
    function WriteInt16(Value: AInt16): AError;
    function WriteInt32(Value: AInt32): AError;
    function WriteInt64(Value: AInt64): AError;
    function WriteUInt08(Value: AUInt08): AError;
    function WriteUInt16(Value: AUInt16): AError;
    function WriteUInt32(Value: AUInt32): AError;
    function WriteUInt64(Value: AUInt64): AError;
  end;

implementation

end.
