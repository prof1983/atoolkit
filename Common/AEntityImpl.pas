{**
@Abstract(Сущность)
@Author(Prof1983 prof1983@ya.ru)
@Created(10.04.2007)
@LastMod(13.06.2012)
@Version(0.5)
}
unit AEntityImpl;

interface

uses
  ABase, AEntityIntf, ATypes;

type //** Сущность
  TProfEntity = class(TInterfacedObject, IProfEntity)
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
  protected
      //** Возвращает тип сущности
    function GetEntityType(): TProfEntityType; safecall;
      //** Возвращает идентификатор сущности
    function GetId(): TAId; safecall;
      //** Возвращает имя
    function GetName(): WideString; safecall;
      //** Задать имя
    procedure SetName(const Value: WideString); safecall;
  public
      //** Добавить лог-сообщение
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AMsg: WideString): Integer; virtual;
  public
      //** Тип сущности
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

  //TProfEntity3 = TProfEntity;

implementation

{ TProfEntity }

function TProfEntity.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AMsg: WideString): Integer;
begin
  Result := 0;
  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(AGroup, AType, AMsg);
  except
  end;
end;

function TProfEntity.GetEntityType(): TProfEntityType;
begin
  Result := FEntityType;
end;

function TProfEntity.GetId(): TAId;
begin
  Result := FId;
end;

function TProfEntity.GetName(): WideString;
begin
  Result := FName;
end;

procedure TProfEntity.SetName(const Value: WideString);
begin
  FName := Value;
end;

end.
