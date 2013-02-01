{**
@Abstract AEvents
@Author Prof1983 <prof1983@ya.ru>
@Created 19.11.2011
@LastMod 30.01.2013
}
unit AEventsMain;

{define AStdCall}

interface

uses
  ABase,
  AEventObj,
  AStringMain;

// --- AEvents ---

function AEvents_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

// --- AEvent ---

function AEvent_Clear(Event: AEvent): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Присоединяет к событию }
function AEvent_Connect(Event: AEvent; Callback: ACallbackProc; Weight: AInt = High(AInt)): AInt; {$ifdef AStdCall}stdcall;{$endif}

{** Отсоединяет от события }
function AEvent_Disconnect(Event: AEvent; Callback: ACallbackProc): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AEvent_Free(Event: AEvent): AError; {$ifdef AStdCall}stdcall;{$endif}

function AEvent_GetListenersCount(Event: AEvent): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AEvent_GetName(Event: AEvent; out Value: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

// MaxLen = SizeOf - 1
function AEvent_GetNameA(Event: AEvent; {out} Value: PAnsiChar; MaxLen: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AEvent_GetNameP(Event: AEvent): APascalString;

{** Вызывает событие. Возврящает кол-во успешно выполненных вызовов (>0) или ошибку (<0). }
function AEvent_Invoke(Event: AEvent; Data: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AEvent_New(Obj: AInt; const Name: AString_Type): AEvent; {$ifdef AStdCall}stdcall;{$endif}

function AEvent_NewA(Obj: AInt; Name: PAnsiChar): AEvent; {$ifdef AStdCall}stdcall;{$endif}

function AEvent_NewP(Obj: AInt; const Name: APascalString): AEvent;

// ---

procedure _Event_Clear(Event: AEvent);
function _Event_Connect(Event: AEvent; Callback: ACallbackProc; Weight: AInteger): AInteger;
function _Event_Disconnect(Event: AEvent; Callback: ACallbackProc): AInteger;
procedure _Event_Free(Event: AEvent);
function _Event_GetListenersCount(Event: AEvent): AInteger;
function _Event_GetName(Event: AEvent; out Value: AString_Type): AInteger;
function _Event_GetNameA(Event: AEvent; Value: PAnsiChar; MaxLen: AInteger): AInteger;
function _Event_GetNameW(Event: AEvent; Value: PWideChar; MaxLen: AInteger): AInteger;
function _Event_Invoke(Event: AEvent; Data: Integer): AInteger;
function _Event_New(Obj: Integer; const Name: AString_Type): AEvent;
function _Event_NewA(Obj: Integer; {const} Name: PAnsiChar): AEvent;
function _Event_NewP(Obj: Integer; const Name: APascalString): AEvent;
function _Event_NewS(Obj: Integer; {const} Name: AString): AEvent;
function _Event_NewW(Obj: Integer; {const} Name: PWideChar): AEvent;

implementation

(*
type
  AEventListener = ^AEventListenerType;
  AEventListenerType = packed record {2x4}
    Proc: ACallbackProc;
    Weight: AInteger;
  end;
*)

{
type
  PEvent = ^AEventType;
  AEventType = packed record // 4x4
    Listeners: AArray;
    Name: AStringA;
    Obj: AInteger;
    Reserved03: AInteger;
  end;
}

{
var
  FEvents: array of TAEvent;
  //FEvents: array of AEventType;
}

{ Private }

procedure _Event_Clear(Event: AEvent);
begin
  AEvent_Clear(Event);
end;

function _Event_Connect(Event: AEvent; Callback: ACallbackProc; Weight: AInteger): AInteger;
begin
  Result := AEvent_Connect(Event, Callback, Weight);
end;

function _Event_Disconnect(Event: AEvent; Callback: ACallbackProc): AInteger;
begin
  Result := AEvent_Disconnect(Event, Callback);
end;

procedure _Event_Free(Event: AEvent);
begin
  AEvent_Free(Event);
end;

function _Event_GetListenersCount(Event: AEvent): AInteger;
begin
  Result := AEvent_GetListenersCount(Event);
end;

function _Event_GetName(Event: AEvent; out Value: AString_Type): AInteger;
begin
  Result := AEvent_GetName(Event, Value);
end;

function _Event_GetNameA(Event: AEvent; Value: PAnsiChar; MaxLen: AInteger): AInteger;
begin
  Result := AEvent_GetNameA(Event, Value, MaxLen);
end;

function _Event_GetNameW(Event: AEvent; Value: PWideChar; MaxLen: AInteger): AInteger;
var
  S: WideString;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  S := TAEvent(Event).GetName;
  if (Length(S) > MaxLen) then
    Move(S, Value, (Length(S)+1)*2)
  else
    Move(S, Value, (MaxLen+1)*2);
  Result := Length(S);
end;

function _Event_Invoke(Event: AEvent; Data: Integer): AInteger;
begin
  Result := AEvent_Invoke(Event, Data);
end;

function _Event_New(Obj: Integer; const Name: AString_Type): AEvent;
begin
  Result := AEvent_New(Obj, Name);
end;

function _Event_NewA(Obj: Integer; {const} Name: PAnsiChar): AEvent;
begin
  Result := AEvent_NewA(Obj, Name);
end;

function _Event_NewP(Obj: Integer; const Name: APascalString): AEvent;
begin
  Result := AEvent_NewP(Obj, Name);
end;

function _Event_NewS(Obj: Integer; {const} Name: AString): AEvent;
var
  Event: TAEvent;
begin
  Event := TAEvent.Create(Obj, '');
  Result := AEvent(Event);
end;

function _Event_NewW(Obj: Integer; {const} Name: PWideChar): AEvent;
var
  Event: TAEvent;
begin
  Event := TAEvent.Create(Obj, Name);
  Result := AEvent(Event);
end;

// --- AEvents ---

function AEvents_Init(): AError;
begin
  Result := 0;
end;

// --- AEvent ---

function AEvent_Clear(Event: AEvent): AError;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    TAEvent(Event).Clear();
    Result := 0;
  except
    Result := -1;
  end;
end;

function AEvent_Connect(Event: AEvent; Callback: ACallbackProc; Weight: AInt): AInt;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    Result := TAEvent(Event).Connect(Callback, Weight);
  except
    Result := -1;
  end;
end;

function AEvent_Disconnect(Event: AEvent; Callback: ACallbackProc): AInt;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    Result := TAEvent(Event).Disconnect(Callback);
  except
    Result := -1;
  end;
end;

function AEvent_Free(Event: AEvent): AError;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    TAEvent(Event).Free();
    Result := 0;
  except
    Result := -1;
  end;
end;

function AEvent_GetListenersCount(Event: AEvent): AInt;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    Result := TAEvent(Event).GetCount();
  except
    Result := -1;
  end;
end;

function AEvent_GetName(Event: AEvent; out Value: AString_Type): AInt;
var
  S: APascalString;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    S := TAEvent(Event).GetName;
    Result := AString_AssignP(Value, S);
  except
    Result := -1;
  end;
end;

function AEvent_GetNameA(Event: AEvent; Value: PAnsiChar; MaxLen: AInt): AInt;
var
  S: AnsiString;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    S := TAEvent(Event).GetName;
    // StrLCopy
    if (Length(S) > MaxLen) then
      Move(S, Value, Length(S)+1)
    else
      Move(S, Value, MaxLen+1);
    Result := Length(S);
  except
    Result := -1;
  end;
end;

function AEvent_GetNameP(Event: AEvent): APascalString;
begin
  if (Event = 0) then
  begin
    Result := '';
    Exit;
  end;
  try
    Result := TAEvent(Event).GetName();
  except
    Result := '';
  end;
end;

function AEvent_Invoke(Event: AEvent; Data: AInt): AInt;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    Result := TAEvent(Event).Invoke(Data);
  except
    Result := -1;
  end;
end;

function AEvent_New(Obj: AInt; const Name: AString_Type): AEvent;
var
  Event: TAEvent;
begin
  try
    Event := TAEvent.Create(Obj, AString_ToPascalString(Name));
    Result := AEvent(Event);
  except
    Result := 0;
  end;
end;

function AEvent_NewA(Obj: AInt; Name: PAnsiChar): AEvent;
var
  Event: TAEvent;
  Len: Integer;
begin
  try
    Len := 0;
    while (Name[Len] <> #0) do
      Inc(Len);
    Event := TAEvent.Create(Obj, AnsiString(Name));
    Result := AEvent(Event);
  except
    Result := 0;
  end;
end;

function AEvent_NewP(Obj: AInt; const Name: APascalString): AEvent;
var
  Event: TAEvent;
begin
  try
    Event := TAEvent.Create(Obj, Name);
    Result := AEvent(Event);
  except
    Result := 0;
  end;
end;

end.
