{**
@Abstract ARuntime base consts and types
@Author Prof1983 <prof1983@ya.ru>
@Created 14.12.2011
@LastMod 01.08.2012
}
unit ARuntimeBase;

{$IFDEF A02}{$DEFINE ADepr}{$ENDIF}
{$IFDEF A03}{$DEFINE ADepr}{$ENDIF}
{$IFDEF A04}{$DEFINE ADepr}{$ENDIF}

interface

uses
  ABase;

// --- Types ---

type
  AModuleFinProc = function(): AError; stdcall;
  AModuleInitProc = function(): AError; stdcall;
  AModuleGetProc = function(ProcName: AStr): Pointer; stdcall;

  {$IFDEF ADepr}
  AModuleInitProc02 = function(): AInteger; stdcall;
  AModuleDoneProc02 = procedure(); stdcall;
  {$ENDIF}

  {$IFDEF ADepr}
  AModuleInitProc03 = function(): AInteger; stdcall;
  AModuleDoneProc03 = function(): AInteger; stdcall;
  {$ENDIF}

  {** Module description }
  AModuleDescription = Pointer;

  {** The unique identifier of the module
      Format: $YYMMDDxx, YY - Year, MM - Month, DD - Day, xx - Number }
  AModuleUid = type AInt32;

type
  {** Module }
  AModule = ^AModule_Type;
  AModule_Type = packed record
    {** Module version ($AABBCCDD) }
    Version: AVersion;
    {** Module unique identificator $YYMMDDxx YY - Year, MM - Month, DD - Day }
    Uid: AModuleUid;
    {** Module unuque name }
    Name: PAnsiChar;
    {** Module information and description }
    Description: AModuleDescription;
    {** Initialize proc }
    Init: AModuleInitProc;
    {** Finalize proc }
    Fin: AModuleFinProc;
    {** Get proc address }
    GetProc: AModuleGetProc;
    {** Module proc list }
    Procs: Pointer;
  end;

  {$IFDEF ADepr}
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
  {$ENDIF}

  {$IFDEF ADepr}
  AModule03 = ^AModule03_Type;
  AModule03_Type = packed record
    {** Module version ($AABBCCDD) }
    Version: AVersion;
    {** Module unique identificator $YYMMDDxx YY - Year, MM - Month, DD - Day }
    Uid: AModuleUid;
    {** Module unuque name }
    Name: PAnsiChar;
    {** Module information and description }
    Description: AModuleDescription;
    {** Initialize proc }
    Init: AProc;
    {** Finalize proc }
    Done: AProc;
    {** Reserved }
    Reserved06: AInteger;
    {** Module proc list }
    Procs: Pointer;
  end;
  {$ENDIF}

implementation

end.
 