{**
@Abstract ARuntime base consts and types
@Author Prof1983 <prof1983@ya.ru>
@Created 14.12.2011
@LastMod 05.02.2013
}
unit ARuntimeBase;

interface

uses
  ABase;

// --- Types ---

type
  AModuleFinProc = function(): AError; stdcall;
  AModuleInitProc = function(): AError; stdcall;
  AModuleGetProc = function(ProcName: AStr): Pointer; stdcall;

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
    Name: AStr;
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

  ARuntime_GetProcByName_Proc = function(ModuleName, ProcName: AStr): Pointer; stdcall;

implementation

end.
 