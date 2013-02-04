{**
@Abstract AEvents
@Author Prof1983 <prof1983@ya.ru>
@Created 19.11.2011
@LastMod 04.02.2013
}
unit AEventsMain;

{define AStdCall}

interface

uses
  ABase,
  AStringMain;

type
  {** Simple event listener }
  TEventProcSimple = procedure() of object;

  AEventListener = record
    Proc: ACallbackProc;
    ProcSimple: TEventProcSimple;
    Weight: AInt;
  end;

  AEvent_Type = record
    Id: AInt;
    Name: APascalString;
    Description: APascalString;
    ParamsShema: APascalString;
    Obj: AInt;
    Listeners: array of AEventListener;
  end;

// --- AEvents ---

function AEvents_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

// --- AEvent ---

function AEvent_Clear(Event: AEvent): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Присоединяет к событию }
function AEvent_Connect(Event: AEvent; Callback: ACallbackProc; Weight: AInt = High(AInt)): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AEvent_ConnectSimple(Event: AEvent; Proc: TEventProcSimple): AError;

{** Отсоединяет от события }
function AEvent_Disconnect(Event: AEvent; Callback: ACallbackProc): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AEvent_DisconnectSimple(Event: AEvent; Proc: TEventProcSimple): AError; 

function AEvent_Free(Event: AEvent): AError; {$ifdef AStdCall}stdcall;{$endif}

function AEvent_GetListenersCount(Event: AEvent): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AEvent_GetName(Event: AEvent; out Value: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

// MaxLen = SizeOf - 1
function AEvent_GetNameA(Event: AEvent; {out} Value: PAnsiChar; MaxLen: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AEvent_GetNameP(Event: AEvent): APascalString;

function AEvent_GetNameW(Event: AEvent; Value: PWideChar; MaxLen: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

{** Вызывает событие. Возврящает кол-во успешно выполненных вызовов (>0) или ошибку (<0). }
function AEvent_Invoke(Event: AEvent; Data: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AEvent_New(Obj: AInt; const Name: AString_Type): AEvent; {$ifdef AStdCall}stdcall;{$endif}

function AEvent_NewA(Obj: AInt; Name: PAnsiChar): AEvent; {$ifdef AStdCall}stdcall;{$endif}

function AEvent_NewP(Obj: AInt; const Name: APascalString): AEvent;

function AEvent_NewS(Obj: AInt; Name: AString): AEvent; {$ifdef AStdCall}stdcall;{$endif}

implementation

var
  FEvents: array of AEvent_Type;

// --- Private ---

function _Connect(EventIndex: AInt; CallBack: ACallbackProc; Weight: AInt): AInt;
var
  I: Integer;
  ListenerIndex: Integer;
begin
  if not(Assigned(CallBack)) then
  begin
    Result := 0;
    Exit;
  end;

  if (Weight < High(AInteger)) then
  begin
    for ListenerIndex := 0 to High(FEvents[EventIndex].Listeners) do
    begin
      if (FEvents[EventIndex].Listeners[ListenerIndex].Weight > Weight) then
      begin
        // Insert Listener into Index
        SetLength(FEvents[EventIndex].Listeners, Length(FEvents[EventIndex].Listeners) + 1);
        for I := High(FEvents[EventIndex].Listeners) - 1 downto ListenerIndex do
          FEvents[EventIndex].Listeners[I + 1] := FEvents[EventIndex].Listeners[I];
        FEvents[EventIndex].Listeners[ListenerIndex].Proc := CallBack;
        FEvents[EventIndex].Listeners[ListenerIndex].ProcSimple := nil;
        FEvents[EventIndex].Listeners[ListenerIndex].Weight := Weight;
        Result := ListenerIndex;
        Exit;
      end;
    end;
  end;

  // Add Listener
  I := Length(FEvents[EventIndex].Listeners);
  SetLength(FEvents[EventIndex].Listeners, I + 1);
  FEvents[EventIndex].Listeners[I].Proc := CallBack;
  FEvents[EventIndex].Listeners[I].Weight := Weight;
  Result := I;
end;

procedure _Delete(EventIndex, ListenerIndex: AInt);
var
  I: Integer;
begin
  for I := ListenerIndex to High(FEvents[EventIndex].Listeners) - 1 do
    FEvents[EventIndex].Listeners[I] := FEvents[EventIndex].Listeners[I + 1];
  SetLength(FEvents[EventIndex].Listeners, High(FEvents[EventIndex].Listeners));
end;

function _Disconnect(Index: AInt; CallBack: ACallbackProc): AInt;
var
  I: Integer;
begin
  for I := 0 to High(FEvents[Index].Listeners) do
  begin
    if (Addr(FEvents[Index].Listeners[I].Proc) = Addr(CallBack)) then
    begin
      _Delete(Index, I);
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function _Find(Event: AEvent): AInt;
var
  I: AInt;
begin
  for I := 0 to High(FEvents) do
  begin
    if (FEvents[I].Id = Event) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function _Invoke(Index, Data: AInt): AInt;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to High(FEvents[Index].Listeners) do
  try
    if Assigned(FEvents[Index].Listeners[I].Proc) then
      FEvents[Index].Listeners[I].Proc(FEvents[Index].Obj, Data);
    Inc(Result);
  except
  end;
end;

// --- AEvents ---

function AEvents_Init(): AError;
begin
  Result := 0;
end;

// --- AEvent ---

function AEvent_Clear(Event: AEvent): AError;
var
  I: AInt;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    I := _Find(Event);
    if (I < 0) then
    begin
      Result := -3;
      Exit;
    end;
    SetLength(FEvents[I].Listeners, 0);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AEvent_Connect(Event: AEvent; Callback: ACallbackProc; Weight: AInt): AInt;
var
  I: AInt;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    I := _Find(Event);
    if (I < 0) then
    begin
      Result := -3;
      Exit;
    end;
    Result := _Connect(I, Callback, Weight);
  except
    Result := -1;
  end;
end;

function AEvent_ConnectSimple(Event: AEvent; Proc: TEventProcSimple): AError;
var
  I: Integer;
  Index: AInt;
begin
  try
    Index := _Find(Event);
    if (Index < 0) then
    begin
      Result := -2;
      Exit;
    end;

    I := Length(FEvents[Index].Listeners);
    SetLength(FEvents[Index].Listeners, I + 1);
    FEvents[Index].Listeners[I].Proc := nil;
    FEvents[Index].Listeners[I].ProcSimple := Proc;
    FEvents[Index].Listeners[I].Weight := High(AInt);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AEvent_Disconnect(Event: AEvent; Callback: ACallbackProc): AInt;
var
  I: AInt;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    I := _Find(Event);
    if (I < 0) then
    begin
      Result := -3;
      Exit;
    end;
    Result := _Disconnect(I, Callback);
  except
    Result := -1;
  end;
end;

function AEvent_DisconnectSimple(Event: AEvent; Proc: TEventProcSimple): AError;
var
  I: Integer;
  EventIndex: AInt;
begin
  try
    EventIndex := _Find(Event);
    if (EventIndex < 0) then
    begin
      Result := -2;
      Exit;
    end;

    for I := 0 to High(FEvents[EventIndex].Listeners) do
    begin
      if (Addr(FEvents[EventIndex].Listeners[I].ProcSimple) = Addr(Proc)) then
      begin
        _Delete(EventIndex, I);
        Result := 0;
        Exit;
      end;
    end;
    Result := -3;
  except
    Result := -1;
  end;
end;

function AEvent_Free(Event: AEvent): AError;
var
  I: AInt;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    I := _Find(Event);
    if (I < 0) then
    begin
      Result := -3;
      Exit;
    end;
    FEvents[I].Id := 0;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AEvent_GetListenersCount(Event: AEvent): AInt;
var
  I: AInt;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    I := _Find(Event);
    if (I < 0) then
    begin
      Result := -3;
      Exit;
    end;
    Result := Length(FEvents[I].Listeners);
  except
    Result := -1;
  end;
end;

function AEvent_GetName(Event: AEvent; out Value: AString_Type): AInt;
var
  S: APascalString;
begin
  try
    S := AEvent_GetNameP(Event);
    Result := AString_AssignP(Value, S);
  except
    Result := -1;
  end;
end;

function AEvent_GetNameA(Event: AEvent; Value: PAnsiChar; MaxLen: AInt): AInt;
var
  S: AnsiString;
begin
  try
    S := AEvent_GetNameP(Event);
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
var
  I: AInt;
begin
  if (Event = 0) then
  begin
    Result := '';
    Exit;
  end;
  try
    I := _Find(Event);
    if (I < 0) then
    begin
      Result := '';
      Exit;
    end;
    Result := FEvents[I].Name;
  except
    Result := '';
  end;
end;

function AEvent_GetNameW(Event: AEvent; Value: PWideChar; MaxLen: AInt): AInt;
var
  S: WideString;
begin
  S := AEvent_GetNameP(Event);
  if (Length(S) > MaxLen) then
    Move(S, Value, (Length(S)+1)*2)
  else
    Move(S, Value, (MaxLen+1)*2);
  Result := Length(S);
end;

function AEvent_Invoke(Event: AEvent; Data: AInt): AInt;
var
  I: AInt;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    I := _Find(Event);
    if (I < 0) then
    begin
      Result := -3;
      Exit;
    end;
    Result := _Invoke(I, Data);
  except
    Result := -1;
  end;
end;

function AEvent_New(Obj: AInt; const Name: AString_Type): AEvent;
begin
  Result := AEvent_NewP(Obj, AString_ToPascalString(Name));
end;

function AEvent_NewA(Obj: AInt; Name: PAnsiChar): AEvent;
begin
  Result := AEvent_NewP(Obj, AnsiString(Name));
end;

function AEvent_NewP(Obj: AInt; const Name: APascalString): AEvent;
var
  I: AInt;
begin
  try
    I := Length(FEvents);
    SetLength(FEvents, I + 1);
    FEvents[I].Id := I + 1;
    FEvents[I].Name := Name;
    FEvents[I].Description := '';
    FEvents[I].ParamsShema := '';
    FEvents[I].Obj := Obj;
    SetLength(FEvents[I].Listeners, 0);
    Result := FEvents[I].Id;
  except
    Result := 0;
  end;
end;

function AEvent_NewS(Obj: AInt; Name: AString): AEvent;
begin
  Result := AEvent_NewP(Obj, '');
end;

end.
