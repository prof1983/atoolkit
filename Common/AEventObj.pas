{**
@Abstract Events
@Author Prof1983 <prof1983@ya.ru>
@Created 20.10.2005
@LastMod 09.08.2012
}
unit AEventObj;

{DEFINE ADepr}

interface

uses
  ABase;

type
  {** Event listener }
  {$IFDEF ADepr}
  TEventProcA = function(Sender: TObject; AParams: WideString): WordBool of object;
  {$ENDIF}

  {** Simple event listener }
  TEventProcSimple = procedure() of object;

  TAEvent = class
  protected
    FListeners: array of record
      Proc: ACallbackProc;
      {$IFDEF ADepr}
      ProcA: TEventProcA;
      {$ENDIF}
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
    function GetCount(): AInt; virtual;
    function GetName: WideString;
  public
    function Clear(): AError;
    function Connect(CallBack: ACallbackProc; Weight: Integer): Integer;
    {$IFDEF ADepr}
    function ConnectA(ProcA: TEventProcA): WordBool; deprecated; // Use ACallbackProc
    {$ENDIF}
    function ConnectSimple(Proc: TEventProcSimple): WordBool;
    function Disconnect(CallBack: ACallbackProc): Integer;
    {$IFDEF ADepr}
    function DisconnectA(ProcA: TEventProcA): WordBool; deprecated; // Use ACallbackProc
    {$ENDIF}
    function DisconnectSimple(Proc: TEventProcSimple): WordBool;
    function Invoke(Data: AInteger): AInteger;
    {$IFDEF ADepr}
    procedure Run(); overload; deprecated;
    function Run(Sender: TObject; AParams: WideString): WordBool; overload; deprecated; // Use ACallbackProc
    {$ENDIF}
  public
    constructor Create(Obj: Integer = 0; const Name: WideString = '');
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
        {$IFDEF ADepr}
        FListeners[Index].ProcA := nil;
        {$ENDIF}
        FListeners[Index].ProcSimple := nil;
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

{$IFDEF ADepr}
function TAEvent.ConnectA(ProcA: TEventProcA): WordBool;
var
  I: Integer;
begin
  I := Length(FListeners);
  SetLength(FListeners, I + 1);
  FListeners[I].Proc := nil;
  FListeners[I].ProcA := ProcA;
  FListeners[I].ProcSimple := nil;
  FListeners[I].Weight := High(AInteger);
  Result := True;
end;
{$ENDIF}

function TAEvent.ConnectSimple(Proc: TEventProcSimple): WordBool;
var
  I: Integer;
begin
  I := Length(FListeners);
  SetLength(FListeners, I + 1);
  FListeners[I].Proc := nil;
  {$IFDEF ADepr}
  FListeners[I].ProcA := nil;
  {$ENDIF}
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

{$IFDEF ADepr}
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
{$ENDIF}

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

{$IFDEF ADepr}
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
{$ENDIF}

{$IFDEF ADepr}
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
{$ENDIF}

end.
