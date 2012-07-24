{**
@Abstract Events
@Author Prof1983 <prof1983@ya.ru>
@Created 20.10.2005
@LastMod 24.07.2012
}
unit AEventObj;

interface

uses
  ABase;

type
  {** Event listener }
  TEventProcA = function(Sender: TObject; AParams: WideString): WordBool of object;

  {** Simple event listener }
  TEventProcSimple = procedure() of object;

  TAEvent = class
  protected
    FListeners: array of record
      Proc: ACallbackProc;
      ProcA: TEventProcA;
      ProcSimple: TEventProcSimple;
      Weight: AInteger;
    end;
    FName: WideString;
    FObj: Integer;
  protected
    FDescription: WideString;
    FParamsShema: WideString;
  protected
    procedure Delete(Index: Integer);
  public
    function GetCount(): AInt;
    function GetName: WideString;
  public
    function Clear(): AError;
    function Connect(CallBack: ACallbackProc; Weight: Integer): Integer;
    function ConnectA(ProcA: TEventProcA): WordBool; deprecated; // Use ACallbackProc
    function ConnectSimple(Proc: TEventProcSimple): WordBool;
    function Disconnect(CallBack: ACallbackProc): Integer;
    function DisconnectA(ProcA: TEventProcA): WordBool; deprecated; // Use ACallbackProc
    function DisconnectSimple(Proc: TEventProcSimple): WordBool;
    function Invoke(Data: AInteger): AInteger;
    procedure Run(); overload; deprecated;
    function Run(Sender: TObject; AParams: WideString): WordBool; overload; deprecated; // Use ACallbackProc
  public
    constructor Create(Obj: Integer; const Name: WideString);
    //constructor Create(AName: WideString = ''); - Old
  public
    property Count: Integer read GetCount;
    property Description: WideString read FDescription write FDescription;
    property Name: WideString read FName write FName;
    property ParamsShema: WideString read FParamsShema write FParamsShema;
  end;

  //TEventShablon = TAEvent;
  //TEvent = TAEvent;
  //TProfEvent = TAEvent;
  //TEventSimple = TAEvent;

implementation

{ TAEvent }

function TAEvent.Clear(): AError;
begin
  SetLength(FListeners, 0);
  Result := 0;
end;

function TAEvent.Connect(CallBack: ACallbackProc; Weight: Integer): Integer;
var
  I: Integer;
  Index: Integer;
begin
  if not(Assigned(CallBack)) then
  begin
    Result := 0;
    Exit;
  end;

  if (Weight < High(AInteger)) then
  begin
    for Index := 0 to High(FListeners) do
    begin
      if (FListeners[Index].Weight > Weight) then
      begin
        // Insert Listener into Index
        SetLength(FListeners, Length(FListeners) + 1);
        for I := High(FListeners) - 1 downto Index do
          FListeners[I + 1] := FListeners[I];
        FListeners[Index].Proc := CallBack;
        FListeners[Index].ProcA := nil;
        FListeners[Index].Weight := Weight;
        Result := Index;
        Exit;
      end;
    end;
  end;

  // Add Listener
  I := Length(FListeners);
  SetLength(FListeners, I + 1);
  FListeners[I].Proc := CallBack;
  FListeners[I].Weight := Weight;
  Result := I;
end;

function TAEvent.ConnectA(ProcA: TEventProcA): WordBool;
var
  I: Integer;
begin
  I := Length(FListeners);
  SetLength(FListeners, I + 1);
  FListeners[I].Proc := nil;
  FListeners[I].ProcA := ProcA;
  FListeners[I].Weight := High(AInteger);
  Result := True;
end;

function TAEvent.ConnectSimple(Proc: TEventProcSimple): WordBool;
var
  I: Integer;
begin
  I := Length(FListeners);
  SetLength(FListeners, I + 1);
  FListeners[I].Proc := nil;
  FListeners[I].ProcA := nil;
  FListeners[I].ProcSimple := Proc;
  FListeners[I].Weight := High(AInteger);
  Result := True;
end;

constructor TAEvent.Create(Obj: Integer; const Name: WideString);
begin
  inherited Create;
  FObj := Obj;
  FName := Name;
end;

procedure TAEvent.Delete(Index: Integer);
var
  I: Integer;
begin
  for I := Index to High(FListeners) - 1 do
    FListeners[I] := FListeners[I + 1];
  SetLength(FListeners, High(FListeners));
end;

function TAEvent.Disconnect(CallBack: ACallbackProc): Integer;
var
  I: Integer;
begin
  for I := 0 to High(FListeners) do
  begin
    if (Addr(FListeners[I].Proc) = Addr(CallBack)) then
    begin
      Delete(I);
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function TAEvent.DisconnectA(ProcA: TEventProcA): WordBool;
var
  I: Integer;
begin
  for I := 0 to High(FListeners) do
  begin
    if (Addr(FListeners[I].ProcA) = Addr(ProcA)) then
    begin
      Delete(I);
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

function TAEvent.DisconnectSimple(Proc: TEventProcSimple): WordBool;
var
  I: Integer;
begin
  for I := 0 to High(FListeners) do
  begin
    if (Addr(FListeners[I].ProcSimple) = Addr(Proc)) then
    begin
      Delete(I);
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

function TAEvent.GetCount(): AInt;
begin
  Result := Length(FListeners);
end;

function TAEvent.GetName: WideString;
begin
  Result := FName;
end;

function TAEvent.Invoke(Data: AInteger): AInteger;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to High(FListeners) do
  try
    if Assigned(FListeners[I].Proc) then
      FListeners[I].Proc(FObj, Data);
    Inc(Result);
  except
  end;
end;

procedure TAEvent.Run();
var
  I: Integer;
begin
  for I := 0 to High(FListeners) do
  try
    if Assigned(FListeners[I].ProcSimple) then
      FListeners[I].ProcSimple();
  except
  end;
end;

function TAEvent.Run(Sender: TObject; AParams: WideString): WordBool;
var
  I: Integer;
begin
  for I := 0 to High(FListeners) do
  try
    if Assigned(FListeners[I].ProcA) then
      FListeners[I].ProcA(Sender, AParams);
  except
  end;
  Result := True;
end;

end.
