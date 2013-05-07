{
Author Prof1983 <prof1983@ya.ru>
Created 27.05.2011
}
unit AEventsMod;

interface

uses
  ABase,
  AEvents,
  AEventsProcs,
  ARuntime,
  ARuntimeBase;

// --- Events Module ---

function Events_Boot(): AInt;

procedure Events_Done02(); stdcall;

function Events_Done03(): AInt; stdcall;

function Events_Done04(): AError; stdcall;

function Events_Init02(): AInt; stdcall;

function Events_Init03(): AInt; stdcall;

function Events_Init04(): AError; stdcall;


const
  EventsProcs: AEventsProcs_Type = (
    Event_Clear: AEvents.Event_Clear;                           // 00
    Event_Connect: AEvents.Event_Connect;                       // 01
    Event_Disconnect: AEvents.Event_Disconnect;                 // 02
    Event_Free: AEvents.Event_Free;                             // 03
    Event_GetListenersCount: AEvents.Event_GetListenersCount;   // 04
    Event_GetName: AEvents.Event_GetName;                       // 05
    Event_Invoke: AEvents.Event_Invoke;                         // 06
    Event_New: AEvents.Event_New;                               // 07
    Event_NewA: AEvents.Event_NewA;                             // 08
    Event_NewP: AEvents.Event_NewP;                             // 09
    Event_NewW: AEvents.Event_NewW;                             // 10
    Event_GetNameA: AEvents.Event_GetNameA;                     // 11
    Event_GetNameP: AEvents.Event_GetNameP;                     // 12
    Event_GetNameW: AEvents.Event_GetNameW;                     // 13
    Init: Events_Init04;                                        // 14
    Done: Events_Done04;                                        // 15

    Event_NewWS: AEvents.Event_NewWS;                           // 16
    Reserved17: 0;
    Reserved18: 0;
    Reserved19: 0;
    Reserved20: 0;
    Reserved21: 0;
    Reserved22: 0;
    Reserved23: 0;

    Reserved24: 0;
    Reserved25: 0;
    Reserved26: 0;
    Reserved27: 0;
    Reserved28: 0;
    Reserved29: 0;
    Reserved30: 0;
    Reserved31: 0;
    );

implementation

uses
  AEvents0;

const
  {$ifdef A02}
  AEvents_Version02 = $00020800;
  {$else}
  AEvents_Version = $00040100;
  {$endif}

const
  {$ifdef A02}
  EventsModule: AModule02_Type = (
    Version: AEvents_Version02;
    Init: Events_Init02;
    Done: Events_Done02;
    Name: AEvents_Name02;
    Procs: nil;
    Reserved1: 0;
    Reserved2: 0;
    Reserved3: 0;
    );
  {$else}
  EventsModule: AModule03_Type = (
    Version: AEvents_Version;
    Uid: AEvents_Uid;
    Name: AEvents_Name;
    Description: nil;
    Init: Events_Init03;
    Done: Events_Done03;
    Reserved06: 0;
    Procs: nil;
    );
  {$endif}

// --- Events Module ---

function Events_Boot(): AInt;
begin
  {$ifdef A02}
  if (ARuntime.Modules_FindByNameWS(AEvents_Name02) >= 0) then
  begin
    Result := -3;
    Exit;
  end;
  {$else}
  if (ARuntime.Modules_FindByUid(AEvents_Uid) >= 0) then
  begin
    Result := -2;
    Exit;
  end;

  if (ARuntime.Modules_FindByName(AEvents_Name) >= 0) then
  begin
    Result := -3;
    Exit;
  end;
  {$endif}

  {$ifdef A02}
  Result := ARuntime.Module_Register02(EventsModule);
  {$else}
  Result := ARuntime.Module_Register(EventsModule);
  {$endif}
end;

procedure Events_Done02();
begin
  Events_Done04();
end;

function Events_Done03(): AInt;
begin
  Result := Events_Done04();
end;

function Events_Done04(): AError;
begin
  Result := 0;
end;

function Events_Init02(): AInt;
begin
  Result := 0;
end;

function Events_Init03(): AInt;
begin
  Result := Events_Init04();
end;

function Events_Init04(): AError;
begin
  Result := 0;
end;

initialization
  Set_EventsProcs(EventsProcs);
end.
