{**
@Abstract Events
@Author Prof1983 <prof1983@ya.ru>
@Created 20.10.2005
@LastMod 04.02.2013
}
unit AEventObj;

// TODO: Use AEventsMain.pas

interface

uses
  ABase,
  AEventsMain;

type
  TAEvent = class
  protected
    FEvent: AEvent;
  public
    function GetCount(): AInt; virtual;
    function GetName: WideString;
  public
    function Clear(): AError;
    function Connect(CallBack: ACallbackProc; Weight: Integer): Integer;
    function ConnectSimple(Proc: TEventProcSimple): WordBool;
    function Disconnect(CallBack: ACallbackProc): Integer;
    function DisconnectSimple(Proc: TEventProcSimple): WordBool;
    function Invoke(Data: AInteger): AInteger;
  public
    constructor Create(Obj: Integer = 0; const Name: WideString = '');
  public
    property Count: Integer read GetCount;
    property Description: WideString read FDescription write FDescription;
    property Name: WideString read FName write FName;
    property ParamsShema: WideString read FParamsShema write FParamsShema;
  end;

implementation

{ TAEvent }

function TAEvent.Clear(): AError;
begin
  Result := AEvent_Clear(FEvent);
end;

function TAEvent.Connect(CallBack: ACallbackProc; Weight: Integer): Integer;
begin
  Result := AEvent_Connect(FEvent, Callback, Weight);
end;

function TAEvent.ConnectSimple(Proc: TEventProcSimple): WordBool;
begin
  Result := (AEvent_ConnectSimple(FEvent, Proc) >= 0);
end;

constructor TAEvent.Create(Obj: Integer; const Name: WideString);
begin
  inherited Create;
  FEvent := AEvent_NewP(Obj, Name);
end;

function TAEvent.Disconnect(CallBack: ACallbackProc): Integer;
begin
  Result := AEvent_Disconnect(FEvent, Callback);
end;

function TAEvent.DisconnectSimple(Proc: TEventProcSimple): WordBool;
begin
  Result := (AEvent_DisconnectSimple(FEvent, Proc) >= 0);
end;

function TAEvent.GetCount(): AInt;
begin
  Result := AEvent_GetListenersCount(FEvent);
end;

function TAEvent.GetName: WideString;
begin
  Result := AEvent_GetNameP(FEvent);
end;

function TAEvent.Invoke(Data: AInteger): AInteger;
begin
  Result := AEvent_Invoke(FEvent, Data);
end;

end.
