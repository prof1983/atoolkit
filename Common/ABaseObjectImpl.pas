{**
@Abstract(Базовый тип для объект с логированием)
@Author(Prof1982 prof1983@ya.ru)
@Created(22.12.2005)
@LastMod(27.03.2012)
@Version(0.5)
}
unit ABaseObjectImpl;

interface

uses
  ATypes;

type
  TProfBaseObject = class(TInterfacedObject, IUnknown)
  protected
      //** Префикс лог-сообщений
    FLogPrefix: WideString;
      //** CallBack функция функция. Срабатывает при поступлении лог-сообщения.
    FOnAddToLog: TProcAddToLog;
  protected
      //** Срабатывает при добавлении лог-сообщения
    function DoAddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AMsg: WideString): Integer; virtual; safecall;
  public
      //** Добавить лог-сообщение
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AMsg: WideString): Integer; virtual; safecall;
  public
      //** Префикс лог-сообщений
    property LogPrefix: WideString read FLogPrefix write FLogPrefix;
      //** CallBack функция функция. Срабатывает при поступлении лог-сообщения.
    property OnAddToLog: TProcAddToLog read FOnAddToLog write FOnAddToLog;
  end;

implementation

{ TProfBaseObject }

function TProfBaseObject.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AMsg: WideString): Integer;
begin
  Result := DoAddToLog(AGroup, AType, FLogPrefix + AMsg);
end;

function TProfBaseObject.DoAddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AMsg: WideString): Integer;
begin
  Result := 0;
  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(AGroup, AType, AMsg);
  except
  end;
end;

end.
