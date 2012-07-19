{**
@Abstract Событие
@Author Prof1983 <prof1983@ya.ru>
@Created 20.10.2005
@LastMod 19.07.2012
}
unit AEvents;

interface

uses
  ABase, AStrings;

function Init(): AError; stdcall;
function Done(): AError; stdcall;

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

//** Присоединяет к событию.
function Event_Connect(Event: AEvent; Callback: ACallbackProc; Weight: AInteger = High(AInteger)): AInteger; stdcall;

//** Отсоединяет от события.
function Event_Disconnect(Event: AEvent; Callback: ACallbackProc): AInteger; stdcall;

//** Вызывает событие. Возврящает кол-во успешно выполненных вызовов (>0) или ошибку (<0).
function Event_Invoke(Event: AEvent; Data: Integer): AInteger; stdcall;

implementation

uses
  AEventsMain, AEventObj;

{ Public }

function Done(): AError; stdcall;
begin
  Result := 0;
end;

{ Event }

function Event_Clear(Event: AEvent): AError; stdcall;
begin
  try
    _Event_Clear(Event);
    Result := 0;
  except
    Result := -1;
  end;
end;

function Event_Connect(Event: AEvent; Callback: ACallbackProc; Weight: AInteger): AInteger; stdcall;
begin
  try
    Result := _Event_Connect(Event, Callback, Weight);
  except
    Result := -1;
  end;
end;

function Event_Disconnect(Event: AEvent; Callback: ACallbackProc): AInteger; stdcall;
begin
  try
    Result := _Event_Disconnect(Event, Callback);
  except
    Result := -1;
  end;
end;

function Event_Free(Event: AEvent): AError; stdcall;
begin
  try
    _Event_Free(Event);
    Result := 0;
  except
    Result := -1;
  end;
end;

function Event_GetListenersCount(Event: AEvent): AInteger; stdcall;
begin
  try
    Result := _Event_GetListenersCount(Event);
  except
    Result := -1;
  end;
end;

function Event_GetName(Event: AEvent; out Value: AString_Type): AInteger; stdcall;
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
    Result := AStrings.String_AssignP(Value, S);
  except
    Result := -1;
  end;
end;

function Event_GetNameA(Event: AEvent; Value: PAnsiChar; MaxLen: AInteger): AInteger; stdcall;
begin
  try
    Result := _Event_GetNameA(Event, Value, MaxLen);
  except
    Result := -1;
  end;
end;

function Event_GetNameP(Event: AEvent): APascalString; stdcall;
begin
  if (Event = 0) then
  begin
    Result := '';
    Exit;
  end;
  try
    Result := TAEvent(Event).GetName;
  except
    Result := '';
  end;
end;

function Event_GetNameS(Event: AEvent; Value: AString): AInteger; stdcall;
begin
  Result := Event_GetName(Event, Value^);
end;

function Event_GetNameW(Event: AEvent; Value: PWideChar; MaxLen: AInteger): AInteger; stdcall;
begin
  try
    Result := _Event_GetNameW(Event, Value, MaxLen);
  except
    Result := -1;
  end;
end;

function Event_Invoke(Event: AEvent; Data: Integer): AInteger; stdcall;
begin
  try
    Result := _Event_Invoke(Event, Data);
  except
    Result := -1;
  end;
end;

function Event_New(Obj: Integer; const Name: AString_Type): AEvent; stdcall;
begin
  try
    Result := _Event_New(Obj, Name);
  except
    Result := 0;
  end;
end;

function Event_NewA(Obj: Integer; {const} Name: PAnsiChar): AEvent; stdcall;
begin
  try
    Result := _Event_NewA(Obj, Name);
  except
    Result := 0;
  end;
end;

function Event_NewP(Obj: Integer; const Name: APascalString): AEvent; stdcall;
begin
  try
    Result := _Event_NewP(Obj, Name);
  except
    Result := 0;
  end;
end;

function Event_NewS(Obj: Integer; {const} Name: AString): AEvent; stdcall;
begin
  try
    Result := _Event_NewS(Obj, Name);
  except
    Result := 0;
  end;
end;

function Event_NewW(Obj: Integer; {const} Name: PWideChar): AEvent; stdcall;
begin
  try
    Result := _Event_NewW(Obj, Name);
  except
    Result := 0;
  end;
end;

function Event_NewWS(Obj: Integer; const Name: AWideString): AEvent; stdcall;
begin
  try
    Result := _Event_NewP(Obj, Name);
  except
    Result := 0;
  end;
end;

function Init(): AError; stdcall;
begin
  Result := 0;
end;

end.
