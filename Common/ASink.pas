{**
@Abstract(Циркулярный стек объектов. Имеет точку вставки объекта и точку взятия)
@Author(Prof1983 prof1983@ya.ru)
@Created(27.10.2006)
@LastMod(23.12.2011)
@Version(0.5)
}
unit ASink;

// Queue - очередь
// Stack - стек

interface

uses
  Contnrs;

type
  ISink = interface
    function Count(): Integer;
    function Push(AObject: TObject): Boolean;
    function Pop(): TObject;
    function Peek(): TObject;
  end;

type
  TSink = class
  private
    FQueue: TObjectQueue;
  public
    constructor Create();
  public
    function Count(): Integer;
    function Push(AObject: TObject): Boolean;
    function Pop(): TObject;
    function Peek(): TObject;
  end;

(*
type
  TStackList = class(TList)
  private
    // Было хотябы одно добавление
    FIsAdd: Boolean;
    // Index следующей точки вставки нового объекта
    FNextItem: Integer;
    // Index следующей выполняемого сообщения
    FNextRun: Integer;
    //FOnAddItem: TNotifyEvent;
    //FOnRunItem: TNotifyEvent;
  protected
    procedure DoAddItem(AItem: TObject); virtual;
    function GetCountItem(): Integer;
    function GetNextFreeItem(): TObject;
    function GetNextRunItem(): TObject;
  public
    procedure Clear();
    property CountItem: Integer read GetCountItem;
    constructor Create(AStackSize: Integer; AItemClass: TClass);
    // Возвращает следующий свободный элемент для заполнения и увеличивает счетчик
    property NextFreeItem: TObject read GetNextFreeItem;
    // Возвращает следующий свободный элемент для выполнения и увеличивает счетчик
    property NextRunItem: TObject read GetNextRunItem;
    //property OnAddItem: TNotifyEvent read FOnAddItem write FOnAddItem;
    //property OnRunItem: TNotifyEvent read FOnRunItem write FOnRunItem;
  end;

type
  TStackListA = class(TStackList)
  private
    FNextIdent: Integer;  // Счетчик номеров команд
    function GetNextFreeObject(): TStackObject;
    function GetNextIdent(): Integer;
    function GetNextRunObject(): TStackObject;
  protected
    procedure DoAddItem(AItem: TObject); override;
  public
    constructor Create(AStackSize: Integer; AItemClass: TStackObjectClass);
    property NextFreeObject: TStackObject read GetNextFreeObject;
    // Возвращает следующий идентификатор
    property NextIdent: Integer read GetNextIdent;
    property NextRunObject: TStackObject read GetNextRunObject;
  end;
*)

implementation

(*

{ TStackList }

procedure TStackList.Clear;
begin
  FNextRun := 0;
  FNextItem := 0;
  FIsAdd := False;
end;

constructor TStackList.Create(AStackSize: Integer; AItemClass: TClass);
var
  i: Integer;
begin
  inherited Create();
  FNextRun := 0;
  FNextItem := 0;
  FIsAdd := False;
  // Создаем стек
  Self.SetCount(AStackSize);
  for i := 0 to AStackSize - 1 do
    Items[i] := AItemClass.Create();
end;

procedure TStackList.DoAddItem(AItem: TObject);
begin
//  if Assigned(FOnAddItem) then
//    FOnAddItem(AItem);
end;

function TStackList.GetCountItem(): Integer;
begin
  if FNextItem >= FNextRun then
    Result := (FNextItem - FNextRun)
  else
    Result := (Count - FNextRun - 1) + FNextItem;
end;

function TStackList.GetNextFreeItem(): TObject;
begin
  Result := nil;
  // Если буфер полный, то выход
  if ((FNextItem > 0) and (FNextItem = FNextRun-1)) or ((FNextItem = 0) and (FNextRun = Count-1) and FIsAdd) then Exit;

  Result := TObject(Self.Get(FNextItem));
  Inc(FNextItem);
  if FNextItem >= Count then
    FNextItem := 0;

  DoAddItem(Result);

  FIsAdd := True;
end;

function TStackList.GetNextRunItem(): TObject;
begin
  Result := nil;
  // Если буфер пустой, то выход
  if (FNextRun = FNextItem) then Exit;

  Result := TObject(Self.Get(FNextRun));
  Inc(FNextRun);
  if FNextRun >= Count then
    FNextRun := 0;

  if Assigned(FOnRunItem) then
    FOnRunItem(Result);
end;

{ TStackListA }

constructor TStackListA.Create(AStackSize: Integer; AItemClass: TStackObjectClass);
begin
  inherited Create(AStackSize, AItemClass);
  FNextIdent := 1;
end;

procedure TStackListA.DoAddItem(AItem: TObject);
begin
  TStackObject(AItem).FIdent := NextIdent;
  inherited DoAddItem(AItem);
end;

function TStackListA.GetNextFreeObject(): TStackObject;
begin
  Result := TStackObject(GetNextFreeItem());
end;

function TStackListA.GetNextIdent(): Integer;
begin
  Result := FNextIdent;
  Inc(FNextIdent);
  if FNextIdent = High(FNextIdent) then
    FNextIdent := 1;
end;

function TStackListA.GetNextRunObject(): TStackObject;
begin
  Result := TStackObject(GetNextRunItem());
end;

*)

{ TSink }

function TSink.Count(): Integer;
begin
  Result := FQueue.Count();
end;

constructor TSink.Create();
begin
  inherited Create();
  FQueue := TObjectQueue.Create();
end;

function TSink.Peek(): TObject;
begin
  Result := FQueue.Peek();
end;

function TSink.Pop(): TObject;
begin
  Result := FQueue.Pop();
end;

function TSink.Push(AObject: TObject): Boolean;
begin
  Result := Assigned(FQueue.Push(AObject));
end;

end.
