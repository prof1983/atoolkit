{**
@Abstract AEvents
@Author Prof1983 <prof1983@ya.ru>
@Created 27.05.2011
@LastMod 04.04.2013
}
unit AEventsMod;

interface

uses
  ABase,
  AEventsBase,
  AEventsMain,
  ARuntimeBase,
  ARuntimeMain;

// --- AEventsMod ---

function AEventsMod_Boot(): AError; stdcall;

function AEventsMod_Fin(): AError; stdcall;

function AEventsMod_GetProc(ProcName: AStr): Pointer; stdcall;

function AEventsMod_Init(): AError; stdcall;

implementation

const
  AEvents_Version = $00070500;

const
  EventsModule: AModule_Type = (
    Version: AEvents_Version;
    Uid: AEvents_Uid;
    Name: AEvents_Name;
    Description: nil;
    Init: AEventsMod_Init;
    Fin: AEventsMod_Fin;
    GetProc: AEventsMod_GetProc;
    Procs: nil;
    );

// --- AEventsMod ---

function AEventsMod_Boot(): AError;
begin
  Result := ARuntime_RegisterModule(EventsModule);
end;

function AEventsMod_Fin(): AError;
begin
  Result := AEvents_Fin();
end;

function AEventsMod_GetProc(ProcName: AStr): Pointer;
begin
  if (ProcName = 'AEvent_Clear') then
    Result := Addr(AEvent_Clear)
  else if (ProcName = 'AEvent_Connect') then
    Result := Addr(AEvent_Connect)
  else if (ProcName = 'AEvent_Disconnect') then
    Result := Addr(AEvent_Disconnect)
  else if (ProcName = 'AEvent_Free') then
    Result := Addr(AEvent_Free)
  else if (ProcName = 'AEvent_GetListenersCount') then
    Result := Addr(AEvent_GetListenersCount)
  else if (ProcName = 'AEvent_GetName') then
    Result := Addr(AEvent_GetName)
  else if (ProcName = 'AEvent_GetNameA') then
    Result := Addr(AEvent_GetNameA)
  else if (ProcName = 'AEvent_Invoke') then
    Result := Addr(AEvent_Invoke)
  else if (ProcName = 'AEvent_New') then
    Result := Addr(AEvent_New)
  else if (ProcName = 'AEvent_NewA') then
    Result := Addr(AEvent_NewA)
  else if (ProcName = 'AEvents_Fin') then
    Result := Addr(AEvents_Fin)
  else if (ProcName = 'AEvents_Init') then
    Result := Addr(AEvents_Init)
  else
    Result := nil;
end;

function AEventsMod_Init(): AError;
begin
  Result := AEvents_Init();
end;

end.
