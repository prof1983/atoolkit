{**
@Abstract(ARuntime base consts and types)
@Author(Prof1983 prof1983@ya.ru)
@Created(14.12.2011)
@LastMod(09.04.2012)
@Version(0.5)
}
unit ARuntimeBase;

interface

uses
  ABase;

// --- Types ---

type
  AModuleInitProc02 = function(): AInteger; stdcall;
  AModuleDoneProc02 = procedure(); stdcall;
type
  AModuleInitProc03 = function(): AInteger; stdcall;
  AModuleDoneProc03 = function(): AInteger; stdcall;

type // Module description
  AModuleDescription = Pointer;

type
  { Уникальный идентификатор модуля.
    Записывается в формате $YYMMDDxx, где YY - год, MM-месяц, DD-день, xx-порядковый номер }
  AModuleUid = type AInteger;

type
  AModule02 = ^AModule02_Type;
  AModule02_Type = packed record
    Version: AVersion;
    Init: AModuleInitProc02;
    Done: AModuleDoneProc02;
    Name: AWideString;
    Procs: Pointer;
    Reserved1: AInteger;
    Reserved2: AInteger;
    Reserved3: AInteger;
  end;

type // Module (8x4)
  AModule03 = ^AModule03_Type;
  AModule03_Type = packed record
    Version: AVersion;         // Module version ($AABBCCDD). AA=00h, BB=03h.
    Uid: AModuleUid;           // Module unique identificator $YYMMDDxx YY - Year, MM - Month, DD - Day
    Name: PChar;               // Module unuque name
    Description: AModuleDescription; // Module information and description
    Init: AProc03;             // Init proc
    Done: AProc03;             // Done proc
    Reserved06: AInteger;      // Reserved (Delete: AModuleDeleteProc)
    Procs: Pointer;            // Module proc list
  end;

{$IFDEF A02}

type
  AModuleData = AModule02;
  AModuleDataType = AModule02_Type;
  AModuleDataRec = AModule02_Type;
  AModule = AModule02;
  AModule_Type = AModule02_Type;

{$ELSE} // A02

type
  AModule = AModule03;
  AModule_Type = AModule03_Type;

{$ENDIF A02}

implementation

end.
 