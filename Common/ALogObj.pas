{**
@Abstract(Предок для всех объектов требующих логирования)
@Author(Prof1983 prof1983@ya.ru)
@Created(05.02.2005)
@LastMod(02.05.2012)
@Version(0.5)

Компонент для вывода лог информаци
Отладка приложений.
Для вывода информации о выполнении модуля/процедуры
}
unit ALogObj;

interface

uses
  ATypes;

type
  TProcedure = procedure of object;

type
  TLog = class
  private
    FProc: TProcedure;
    FS: String;
  public
    procedure Add(S: String);
    constructor Create(Proc: TProcedure);
    property S: String read FS;
  end;

type //** Предок для всех объектов требующих логирования
  TLoggerObject = class
  protected
    FAddToLog: TProfAddToLog;
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Boolean; virtual;
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Integer; virtual;
    property OnAddToLog: TProfAddToLog read FAddToLog write FAddToLog;
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; virtual;
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
    property Log: TLog read FLog;
  end;

implementation

{ TLog }

procedure TLog.Add(S: String);
begin
  FS := S;
  FProc;
end;

constructor TLog.Create(Proc: TProcedure);
begin
  inherited Create;
  FProc := Proc;
end;

{ TLoggerObject }

function TLoggerObject.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: string; AParams: array of const): Boolean;
begin
  Result := False;
  if Assigned(OnAddToLog) then
  begin
    try
      OnAddToLog(AGroup, AType, AStrMsg, AParams);
      Result := True;
    except
      Result := False;
    end;
  end;
end;

function TLoggerObject.AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: string; AParams: array of const): Integer;
begin
  Result := -1;
  if Assigned(OnAddToLog) then
  begin
    try
      OnAddToLog(AGroup, AType, AStrMsg, AParams);
      Result := 0;
    except
      Result := -1;
    end;
  end;
end;

function TLoggerObject.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := -1;
  if Assigned(OnAddToLog) then
    try
      Result := OnAddToLog(AGroup, AType, AStrMsg, AParams);
    except
    end;
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

