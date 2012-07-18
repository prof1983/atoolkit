{**
@Abstract(Предок для всех объектов требующих логирования)
@Author(Prof1983 <prof1983@ya.ru>)
@Created(05.02.2005)
@LastMod(18.07.2012)

Компонент для вывода лог информаци
Отладка приложений.
Для вывода информации о выполнении модуля/процедуры
}
unit ALogObj;

interface

uses
  SysUtils,
  ABase, ATypes;

type
  TProcedure = procedure of object;

type
  TLog = class
  private
    FProc: TProcedure;
    FText: String;
  public
      {** Return new log node identifier
          @return(log node identifier) }
    function Add(const Msg: APascalString): AInt; virtual;
  public
    constructor Create(Proc: TProcedure);
  public
    property S: String read FText;
  end;

type //** Предок для всех объектов требующих логирования
  TLoggerObject = class
  protected
    FOnAddToLog: TAddToLogProc;
    FOnAddToLog1: TProfAddToLog;
  public
    function AddToLog(MsgGroup: TLogGroupMessage; MsgType: TLogTypeMessage;
        const StrMsg: WideString): AInt; virtual;
    function AddToLog1(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Boolean; virtual;
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Integer; virtual;
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; virtual;
  public
    property OnAddToLog: TAddToLogProc read FOnAddToLog write FOnAddToLog;
    property OnAddToLog1: TProfAddToLog read FOnAddToLog1 write FOnAddToLog1;
  end;

type
  TProfClass = class(TObject, IInterface)
  private
    FLog: TLog;
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    constructor Create(Log: TLog);
    constructor Create1;
    constructor Create2(Log: TLog);
  public
    property Log: TLog read FLog;
  end;

implementation

{ TLog }

function TLog.Add(const Msg: APascalString): AInt;
begin
  if not(Assigned(FProc)) then
  begin
    Result := -2;
    Exit;
  end;
  FText := Msg;
  FProc();
  Result := 0;
end;

constructor TLog.Create(Proc: TProcedure);
begin
  inherited Create;
  FProc := Proc;
end;

{ TLoggerObject }

function TLoggerObject.AddToLog(MsgGroup: TLogGroupMessage; MsgType: TLogTypeMessage;
    const StrMsg: WideString): AInt;
begin
  Result := 0;
  if Assigned(FOnAddToLog) then
  begin
    try
      FOnAddToLog(MsgGroup, MsgType, StrMsg);
    except
    end;
  end;
  if Assigned(FOnAddToLog1) then
  begin
    try
      FOnAddToLog1(MsgGroup, MsgType, StrMsg, []);
    except
    end;
  end;
end;

function TLoggerObject.AddToLog1(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: string; AParams: array of const): Boolean;
begin
  Result := (AddToLog(AGroup, AType, Format(AStrMsg, AParams)) >= 0);
end;

function TLoggerObject.AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: string; AParams: array of const): Integer;
begin
  Result := AddToLog(AGroup, AType, Format(AStrMsg, AParams));
end;

function TLoggerObject.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := AddToLog(AGroup, AType, Format(AStrMsg, AParams));
end;

{ TProfClass }

constructor TProfClass.Create(Log: TLog);
begin
  inherited Create;
  FLog := Log;
end;

constructor TProfClass.Create1;
begin
  inherited Create;
  FLog := nil;
end;

constructor TProfClass.Create2(Log: TLog);
begin
  inherited Create;
  FLog := Log;
end;

function TProfClass.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := S_OK else Result := E_NOINTERFACE;
end;

function TProfClass._AddRef: Integer; stdcall;
begin
  Result := -1   // -1 indicates no reference counting is taking place
end;

function TProfClass._Release: Integer; stdcall;
begin
  Result := -1   // -1 indicates no reference counting is taking place
end;

end.

