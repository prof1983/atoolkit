{**
@Abstract(Сущность)
@Author(Prof1983 prof1983@ya.ru)
@Created(10.04.2007)
@LastMod(20.06.2012)
@Version(0.5)
}
unit AEntityImpl;

interface

uses
  ABase, AEntityIntf, ATypes;

type //** Сущность
  TANamedEntity = class(TInterfacedObject, IAEntity, IANamedEntity)
  protected
      //** Тип сущности
    FEntityType: TProfEntityType;
      //** Идентификатор
    FId: TAId;
      //** Префикс лог-сообщений
    FLogPrefix: WideString;
      //** Имя
    FName: WideString;
      //** CallBack функция функция. Срабатывает при поступлении лог-сообщения.
    FOnAddToLog: TAddToLogProc;
  public
      {** Возвращает идентификатор сущности }
    function GetEntityId(): TAId;
      //** Возвращает тип сущности
    function GetEntityType(): TProfEntityType;
      //** Возвращает идентификатор сущности
    function GetId(): TAId;
      //** Возвращает имя
    function GetName(): WideString;
      {** Задает тип сущности }
    procedure SetEntityType(Value: TAId);
      //** Задать имя
    procedure SetName(const Value: WideString);
  public
      //** Добавить лог-сообщение
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AMsg: WideString): Integer; virtual;
  public
    {** Идентификатор сущности
        Только для чтения.
        Идентификатор залается при создании сущности и не меняется.
        Аналоги:
          org.framerd.OID.OID }
    property EntityId: AId read GetEntityId;
    {** Тип сущности.
        Номера от 0 до 1023 заререзвированы.
        Аналоги:
          aterm.ATermAppl.AFun
          org.framerd.FDType.TypeName }
    property EntityType: TProfEntityType read GetEntityType;
      //** Идентификатор
    property Id: TAId read GetId;
      //** Префикс лог-сообщений
    property LogPrefix: WideString read FLogPrefix write FLogPrefix;
      //** Имя
    property Name: WideString read FName write FName;
      //** CallBack функция функция. Срабатывает при поступлении лог-сообщения.
    property OnAddToLog: TAddToLogProc read FOnAddToLog write FOnAddToLog;
  end;

  //TProfEntity = TANamedEntity;

implementation

{ TProfEntity }

function TANamedEntity.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AMsg: WideString): Integer;
begin
  Result := 0;
  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(AGroup, AType, AMsg);
  except
  end;
end;

function TANamedEntity.GetEntityId(): TAId;
begin
  Result := FId;
end;

function TANamedEntity.GetEntityType(): TProfEntityType;
begin
  Result := FEntityType;
end;

function TANamedEntity.GetId(): TAId;
begin
  Result := FId;
end;

function TANamedEntity.GetName(): WideString;
begin
  Result := FName;
end;

procedure TANamedEntity.SetEntityType(Value: TAId);
begin
  FEntityType := Value;
end;

procedure TANamedEntity.SetName(const Value: WideString);
begin
  FName := Value;
end;

end.
