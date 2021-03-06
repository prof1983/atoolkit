{**
@Abstract �������
@Author Prof1983 <prof1983@ya.ru>
@Created 20.10.2005
@LastMod 05.02.2013
}
unit AEvents;

interface

uses
  ABase,
  AStringMain;

function Fin(): AError; stdcall;
function Init(): AError; stdcall;

function Event_New(Obj: Integer; const Name: AString_Type): AEvent; stdcall;
function Event_NewA(Obj: Integer; {const} Name: PAnsiChar): AEvent; stdcall;
function Event_NewP(Obj: Integer; const Name: APascalString): AEvent; stdcall;
function Event_NewS(Obj: Integer; {const} Name: AString): AEvent; stdcall;
function Event_NewW(Obj: Integer; {const} Name: PWideChar): AEvent; stdcall;
function Event_NewWS(Obj: Integer; const Name: AWideString): AEvent; stdcall;

function Event_Free(Event: AEvent): AError; stdcall;
function Event_Clear(Event: AEvent): AError; stdcall;
function Event_GetListenersCount(Event: AEvent): AInteger; stdcall;

function Event_GetName(Event: AEvent; out Value: AString_Type): AInteger; stdcall;
// MaxLen = SizeOf - 1
function Event_GetNameA(Event: AEvent; {out} Value: PAnsiChar; MaxLen: AInteger): AInteger; stdcall;
function Event_GetNameP(Event: AEvent): APascalString; stdcall;
function Event_GetNameS(Event: AEvent; Value: AString): AInteger; stdcall;
// MaxLen = (SizeOf div 2) - 1
function Event_GetNameW(Event: AEvent; {out} Value: PWideChar; MaxLen: AInteger): AInteger; stdcall;

//** ������������ � �������.
function Event_Connect(Event: AEvent; Callback: ACallbackProc; Weight: AInteger = High(AInteger)): AInteger; stdcall;

//** ����������� �� �������.
function Event_Disconnect(Event: AEvent; Callback: ACallbackProc): AInteger; stdcall;

//** �������� �������. ���������� ���-�� ������� ����������� ������� (>0) ��� ������ (<0).
function Event_Invoke(Event: AEvent; Data: Integer): AInteger; stdcall;

implementation

uses
  AEventsMain, AEventObj;

{ Public }

function Fin(): AError;
begin
  Result := 0;
end;

{ Event }

function Event_Clear(Event: AEvent): AError;
begin
  Result := AEvent_Clear(Event);
end;

function Event_Connect(Event: AEvent; Callback: ACallbackProc; Weight: AInt): AInt;
begin
  Result := AEvent_Connect(Event, Callback, Weight);
end;

function Event_Disconnect(Event: AEvent; Callback: ACallbackProc): AInt;
begin
  Result := AEvent_Disconnect(Event, Callback);
end;

function Event_Free(Event: AEvent): AError; stdcall;
begin
  Result := AEvent_Free(Event);
end;

function Event_GetListenersCount(Event: AEvent): AInt;
begin
  Result := AEvent_GetListenersCount(Event);
end;

function Event_GetName(Event: AEvent; out Value: AString_Type): AInt;
begin
  Result := AEvent_GetName(Event, Value);
end;

function Event_GetNameA(Event: AEvent; Value: PAnsiChar; MaxLen: AInt): AInt;
begin
  Result := AEvent_GetNameA(Event, Value, MaxLen);
end;

function Event_GetNameP(Event: AEvent): APascalString;
begin
  Result := AEvent_GetNameP(Event);
end;

function Event_GetNameS(Event: AEvent; Value: AString): AInt;
begin
  Result := AEvent_GetName(Event, Value^);
end;

function Event_GetNameW(Event: AEvent; Value: PWideChar; MaxLen: AInt): AInt;
begin
  try
    Result := _Event_GetNameW(Event, Value, MaxLen);
  except
    Result := -1;
  end;
end;

function Event_Invoke(Event: AEvent; Data: AInt): AInt;
begin
  Result := AEvent_Invoke(Event, Data);
end;

function Event_New(Obj: AInt; const Name: AString_Type): AEvent;
begin
  Result := AEvent_New(Obj, Name);
end;

function Event_NewA(Obj: AInt; Name: PAnsiChar): AEvent;
begin
  Result := AEvent_NewA(Obj, Name);
end;

function Event_NewP(Obj: AInt; const Name: APascalString): AEvent;
begin
  Result := AEvent_NewP(Obj, Name);
end;

function Event_NewS(Obj: AInt; Name: AString): AEvent;
begin
  try
    Result := _Event_NewS(Obj, Name);
  except
    Result := 0;
  end;
end;

function Event_NewW(Obj: AInt; Name: PWideChar): AEvent;
begin
  try
    Result := _Event_NewW(Obj, Name);
  except
    Result := 0;
  end;
end;

function Event_NewWS(Obj: AInt; const Name: AWideString): AEvent;
begin
  Result := AEvent_NewP(Obj, Name);
end;

function Init(): AError; stdcall;
begin
  Result := AEvents_Init();
end;

end.
