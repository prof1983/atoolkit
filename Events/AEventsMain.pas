{**
@Abstract AEvents
@Author Prof1983 <prof1983@ya.ru>
@Created 19.11.2011
}
unit AEventsMain;

interface

uses
  ABase, AEventObj, AStrings;

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

{ Private }

procedure _Event_Clear(Event: AEvent);
begin
  if (Event = 0) then
    Exit;
  TAEvent(Event).Clear;
end;

function _Event_Connect(Event: AEvent; Callback: ACallbackProc; Weight: AInteger): AInteger;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  Result := TAEvent(Event).Connect(Callback, Weight);
end;

function _Event_Disconnect(Event: AEvent; Callback: ACallbackProc): AInteger;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  Result := TAEvent(Event).Disconnect(Callback);
end;

procedure _Event_Free(Event: AEvent);
begin
  if (Event = 0) then
    Exit;
  TAEvent(Event).Free;
end;

function _Event_GetListenersCount(Event: AEvent): AInteger;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  Result := TAEvent(Event).GetCount;
end;

function _Event_GetName(Event: AEvent; out Value: AString_Type): AInteger;
var
  S: APascalString;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  S := TAEvent(Event).GetName;
  Result := AStrings.String_AssignP(Value, S);
end;

function _Event_GetNameA(Event: AEvent; Value: PAnsiChar; MaxLen: AInteger): AInteger;
var
  S: AnsiString;
begin
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  S := TAEvent(Event).GetName;
  // StrLCopy
  if (Length(S) > MaxLen) then
    Move(S, Value, Length(S)+1)
  else
    Move(S, Value, MaxLen+1);
  Result := Length(S);
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
  if (Event = 0) then
  begin
    Result := -2;
    Exit;
  end;
  Result := TAEvent(Event).Invoke(Data);
end;

function _Event_New(Obj: Integer; const Name: AString_Type): AEvent;
var
  Event: TAEvent;
begin
  Event := TAEvent.Create(Obj, AStrings.String_ToPascalString(Name));
  Result := AEvent(Event);
end;

function _Event_NewA(Obj: Integer; {const} Name: PAnsiChar): AEvent;
var
  Event: TAEvent;
begin
  Event := TAEvent.Create(Obj, AnsiString(Name));
  Result := AEvent(Event);
end;

function _Event_NewP(Obj: Integer; const Name: APascalString): AEvent;
var
  Event: TAEvent;
begin
  Event := TAEvent.Create(Obj, Name);
  Result := AEvent(Event);
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

end.
