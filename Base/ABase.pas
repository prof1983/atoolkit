{**
@Abstract(Base types and consts (Базовые типы и константы))
@Author(Prof1983 prof1983@ya.ru)
@Created(06.03.2008)
@LastMod(16.05.2012)
@Version(0.5)

0.3.2
[*] Восстановил использование AWideString (01.09.2011)
}
unit ABase;

{$I A.inc}

{DEFINE A02}

interface

type // Простые типы
  AFloat32 = Single;
  AFloat64 = Double;
  AInt32 = LongInt;
  AInt64 = Int64;
  AUInt16 = Word;
  AUInt32 = LongWord;
  AWideChar = WideChar;

type // Простые типы
  ABoolean = Boolean;
  AChar = Char; // Или UTF-32 (UCS4Char)
  AInteger = Integer;
  ASize = LongWord;

type
  AFloat = AFloat32;
  AInt = AInt32;
  AUInt = AUInt32;

type // Версия. Имеет формат $AABBCCDD = AA.BB.CC.DD
  AVersion = type Integer;
const // Маска для проверки соответсвия версий модулей
  AVersionMask = $FFFF0000;

type
  { Возвращаемое значение функций. Значения:
    <0 - ошибка при выполнении,
    0 - выполнение прошло успешно
    >0 - выполнение прошло успешно, но есть замечания или информация }
  AError = type Integer;

// --- Array ---

type
  //AArray = ^AArray_Type;
  AArray_Type = packed record {4x4}
    Data: Pointer;
    Len: AInteger;
    AllocateLen: AInteger;
    Reserved03: AInteger;
  end;

// --- String ---

type
  AWideString = WideString;
  APascalString = {$IFDEF DELPHI_2010_UP}string{$ELSE}WideString{$ENDIF};

type
  AString_Type = packed record  // (4x4 = 16 bytes)
    Str: WideString;
    Reserved01: AInteger;
    Reserved02: AInteger;
    Reserved03: AInteger;
    { Вероятно будет реализовано в V04
    Str: PChar;                // Нультерминальная строка (UTF-8). Массив байтов, заканчивающийся нулем. Аналог GString Points to the string's current \0-terminated value (gchar).
    Len: AInteger;             // Длина строки (кол-во символов). Аналог GString Current length (gsize)
    AllocSize: ASize;          // Размер выделенной памяти в байтах. Аналог GString allocated_len (gsize).
    Code: AInteger;            // Кодировка символов: 0-Нультерминальная строка UTF-8; (1-Нультерминальная строка Ansi)
    }
  end;

type
  {$IFDEF A01}
  AString = AWideString;
  {$ELSE}
  AString  = ^AString_Type;
  {$ENDIF}

{
type
  // (для Win32 и Linux)
  AData   = Pointer;
  // (для CLR и Java)
  //AData   = TObject;
}

// --- ---

type
  AProc01 = procedure; stdcall;
  AProc02 = AProc01;
  AProc03 = function(): AInteger; stdcall;
  ACallbackProc01 = procedure(Obj, Data: AInteger); stdcall;
  ACallbackProc02 = ACallbackProc01;
  ACallbackProc03 = function(Obj, Data: AInteger): AError; stdcall;

type
  {$IFDEF A01}
    AProc = AProc01;
    ACallbackProc = ACallbackProc01;
  {$ELSE}
    {$IFDEF A02}
    AProc = AProc02;
    ANotifyProc = procedure(Sender: AInteger); stdcall;
    ACallbackProc = ACallbackProc02;
    {$ELSE}
    AProc = AProc03;
    ACallbackProc = ACallbackProc03;
    {$ENDIF}
  {$ENDIF}

type
  AConfig = type AInteger;
  AEvent = type AInteger;       // = AEvent_Type^ - Указатель на структуру AEvent_Type
  AColor = type AInteger;
  {$IFDEF A02}
  //AStrings = type AInteger;     // Заменил на ACollectionsBase.AStringList
  {$ENDIF A02}

type
  ALibrary = type AInteger;
  ALibraryFlags = type AInteger;

implementation

end.
