{**
@Abstract(Событие. Параметры имеют вид XML A - дочерние ноды, следующие друг за другом)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.10.2005)
@LastMod(22.05.2012)
@Version(0.5)
}
unit AEventObj;

interface

uses
  ABase;

type //** Процедура - слушатель события
  TEventProcA = function(
    Sender: TObject;      // Объект, который вызвал событие
    AParams: WideString   // Параметры в виде XML
    ): WordBool of object; // Процедура должна возвращает True, если не произошло ошибок

type //** Простая процедура - слушатель события
  TEventProcSimple = procedure() of object;

type
  TAEvent = class
  private
    FListeners: array of record
      Proc: ACallbackProc;
      Weight: AInteger;
    end;
    FName: WideString;
    FObj: Integer;
    procedure Delete(Index: Integer);
  public
    function GetCount: AInteger;
    function GetName: WideString;
  public
    procedure Clear;
    function Connect(CallBack: ACallbackProc; Weight: Integer): Integer;
    function Disconnect(CallBack: ACallbackProc): Integer;
    // Вызывает событие. Возврящает кол-во успешно выполненных вызовов (>0) или ошибку (<0).
    function Invoke(Data: AInteger): AInteger;
  public
    constructor Create(Obj: Integer; const Name: WideString);
  end;

type
  TEventShablon = class
  private
    FDescription: WideString;
    FName: WideString;
    FParamsShema: WideString;
  protected
    function GetCount(): Integer; virtual;
  public
    // Подписаться на получение события
    //function Connect(Proc: Pointer): WordBool;
    property Count: Integer read GetCount;
    constructor Create(AName: WideString = '');
    property Description: WideString read FDescription write FDescription;
    // Отписаться от события
    //function Disconnect(Proc: Pointer): WordBool;
    property Name: WideString read FName write FName;
    //** Описание полей данных для передачи параметров. Имеет вид XML Shema
    property ParamsShema: WideString read FParamsShema write FParamsShema;
    //function Run(<параметры>): WordBool;
  end;

type
  //** @abstract(Класс - событие)
  TEvent = class(TEventShablon)
  private
    FListeners: array of TEventProcA;
  protected
    function GetCount(): Integer; override;
  public
    //** Подписаться на получение события
    function Connect(Proc: TEventProcA): WordBool;
    //** Отписаться от события
    function Disconnect(Proc: TEventProcA): WordBool;
    //** Выполнить при возникновении события
    function Run(Sender: TObject; AParams: WideString): WordBool;
  end;
  TProfEvent = TEvent;

type
  TEventSimple = class(TEventShablon)
  private
    FListeners: array of TEventProcSimple;
  protected
    function GetCount(): Integer; override;
  public
    //** Подписаться на получение события
    function Connect(Proc: TEventProcSimple): WordBool;
    //** Отписаться от события
    function Disconnect(Proc: TEventProcSimple): WordBool;
    //** Выполнить при возникновении события
    procedure Run();
  end;

implementation

{ TAEvent }

procedure TAEvent.Clear;
begin
  SetLength(FListeners, 0);
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
    if (Addr(FListeners[I]) = Addr(CallBack)) then
    begin
      Delete(I);
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function TAEvent.GetCount: AInteger;
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
    FListeners[I].Proc(FObj, Data);
    Inc(Result);
  except
  end;
end;

{ TEvent }

function TEvent.Connect(Proc: TEventProcA): WordBool;
var
  I: Integer;
begin
  I := Length(FListeners);
  SetLength(FListeners, I + 1);
  FListeners[I] := Proc;
  Result := True;
end;

function TEvent.Disconnect(Proc: TEventProcA): WordBool;
var
  I: Integer;
begin
  for I := 0 to High(FListeners) do
    if Addr(FListeners[I]) = Addr(Proc) then
    begin
      FListeners[I] := FListeners[High(FListeners)];
      SetLength(FListeners, High(FListeners));
      Result := True;
      Exit;
    end;
  Result := False;
end;

function TEvent.GetCount(): Integer;
begin
  Result := Length(FListeners);
end;

function TEvent.Run(Sender: TObject; AParams: WideString): WordBool;
var
  I: Integer;
begin
  for I := 0 to High(FListeners) do
  try
    FListeners[I](Sender, AParams);
  except
  end;
  Result := True;
end;

{ TEventShablon }

constructor TEventShablon.Create(AName: WideString = '');
begin
  inherited Create();
  FName := AName;
end;

function TEventShablon.GetCount(): Integer;
begin
  Result := 0;
end;

{ TEventSimple }

function TEventSimple.Connect(Proc: TEventProcSimple): WordBool;
var
  I: Integer;
begin
  I := Length(FListeners);
  SetLength(FListeners, I + 1);
  FListeners[I] := Proc;
  Result := True;
end;

function TEventSimple.Disconnect(Proc: TEventProcSimple): WordBool;
var
  I: Integer;
begin
  for I := 0 to High(FListeners) do
    if Addr(FListeners[I]) = Addr(Proc) then
    begin
      FListeners[I] := FListeners[High(FListeners)];
      SetLength(FListeners, High(FListeners));
      Result := True;
      Exit;
    end;
  Result := False;
end;

function TEventSimple.GetCount(): Integer;
begin
  Result := Length(FListeners);
end;

procedure TEventSimple.Run();
var
  I: Integer;
begin
  for I := 0 to High(FListeners) do
  try
    FListeners[I]();
  except
  end;
end;

end.
