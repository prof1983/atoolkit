{**
@Abstract(Объект с логированием и конфигурациями)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.12.2005)
@LastMod(30.05.2012)
@Version(0.5)
}
unit AObjectImpl;

interface

uses
  SysUtils, XmlIntf,
  AEntityImpl, ALogGlobals, ALogNodeIntf, ANodeIntf, AObjectIntf, ATypes;

type //** @abstract(Базовый класс для объект с логированием и конфигурациями)
  TProfBaseObject3 = class(TProfEntity, IProfObject)
  private
    FConfig: IProfNode;
    FLog: IProfLogNode;
  private
    function GetConfigNode(): IProfNode; safecall;
    function GetLogNode(): IProfLogNode; safecall;
    procedure SetConfigNode(Value: IProfNode); safecall;
    procedure SetLogNode(Value: IProfLogNode); safecall;
  protected
      //** Префикс лог-сообщений
    FLogPrefix: WideString;
  protected
      //** Срабатывает при добавлении лог-сообщения
    //function DoAddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AMsg: WideString): Integer; virtual; safecall;
  public
      //** Добавить (выполнить) сообщение
    function AddMessage(const Msg: Widestring): Integer; safecall;
      //** Загрузить конфигурации
    function ConfigureLoad(AConfig: IProfNode): TProfError; safecall;
      //** Сохранить конфигурации
    function ConfigureSave(AConfig: IProfNode): TProfError; safecall;
      //** Финализировать
    function Finalize(): TProfError;
      //** Инициализировать
    function Initialize(): TProfError;
      //** Передать сообщение
    function SendMessage(const Msg: WideString): Integer; safecall;
  public
    property ConfigNode: IProfNode read GetConfigNode write SetConfigNode;
    property LogNode: IProfLogNode read GetLogNode write SetLogNode;
      //** Префикс лог-сообщений
    property LogPrefix: WideString read FLogPrefix write FLogPrefix;
      //** CallBack функция функция. Срабатывает при поступлении лог-сообщения.
    property OnAddToLog: TProcAddToLog read FOnAddToLog write FOnAddToLog;
  end;

type //** Объект с логированием и конфигурациями
  TProfObject = class(TProfEntity, IProfObject)
  protected
      //** Конфигурации
    FConfig: IProfNode;
      //** Инициализирован
    FInitialized: WordBool;
      //** Ветка логирования
    FLog: IProfLogNode;
      //** CallBack функция. Срабатывает при поступлении сообщения.
    FOnSendMessage: TProcMessageSafe;
    //FOnSendMessageX: TProcMessageX;
  protected
    function GetConfigNode(): IProfNode; safecall;
    function GetLogNode(): IProfLogNode; safecall;
    procedure SetConfigNode(Value: IProfNode); virtual; safecall;
    procedure SetInitialized(Value: WordBool);
    procedure SetLogNode(Value: IProfLogNode); virtual; safecall;
  protected
      //** Срабатывает при создании объекта
    procedure DoCreate(); virtual; safecall;
      //** Срабатывает после создания объекта
    procedure DoCreated(); virtual; safecall;
      //** Срабатывает при уничтожении объекта
    procedure DoDestroy(); virtual; safecall;
      //** Срабатывает при финализации
    function DoFinalize(): TProfError; virtual; safecall;
      //** Срабатывает после успешной финализации
    function DoFinalized(): TProfError; virtual; safecall;
      //** Срабатывает при инициализации
    function DoInitialize(): TProfError; virtual; safecall;
      //** Срабатывает после успешнрй инициализации
    function DoInitialized(): TProfError; virtual; safecall;
  public // IProfObject
      //** Передать сообщение
    function SendMessage(const AMsg: WideString): Integer; virtual; safecall;
      //** Выполнить или передать дочерним объектам
    function AddMessage(const AMsg: WideString): Integer; virtual; safecall;
      //** Загрузить конфигурации
    function ConfigureLoad(AConfig: IProfNode): TProfError; safecall;
      //** Сохранить конфигурации
    function ConfigureSave(AConfig: IProfNode): TProfError; safecall;
    //** Финализировать
    function Finalize(): TProfError; virtual;
    //** Инициализировать
    function Initialize(): TProfError; virtual;
  public // Переопределение функций TInterfacedObject
      //** Срабатывает после создания
    procedure AfterConstruction(); override;
      //** Срабатывает до уничтожения объекта
    procedure BeforeDestruction(); override;
  public
      //** Выполнить или передать дочерним объектам
    function AddMessageStr(const AMsg: WideString): Integer; virtual;
    function AddMessageX(AMsg: IProfNode): Integer; virtual; safecall;
    function AssignedConfig(): Boolean;
    function CheckInitialized(): Boolean; virtual;
    constructor Create(); virtual;
    destructor Destroy(); override;
    procedure Free(); virtual;
    function SendMessageX(const AMsg: IProfNode): Integer; virtual; safecall;
  public
      //** Конфигурации объекта
    property Config: IProfNode read GetConfigNode write SetConfigNode;
      //** Инициализорован
    property Initialized: WordBool read FInitialized write SetInitialized;
      //** Ветка догирования
    property Log: IProfLogNode read GetLogNode write SetLogNode;
      //** CallBack функция передачи сообщения
    property OnSendMessage: TProcMessageSafe read FOnSendMessage write FOnSendMessage;
    //property OnSendMessageX: TProcMessageX read FOnSendMessageX write FOnSendMessageX;
  end;

type //** Объект с логированием и конфигурациями
  TProfObject2 = class(TProfObject, IProfObject2)
  protected
    FConfig: IXmlNode;
    FLog: ILogNode2;
    //** Функция добавления в log
    FOnAddToLog: TProfAddToLog;
    procedure SetInitialized(Value: WordBool);
  protected
    function GetConfig(): IXmlNode; safecall;
    function GetLog(): ILogNode2; safecall;
    procedure SetConfig(const Value: IXmlNode); virtual; safecall;
    procedure SetLog(const Value: ILogNode2); virtual; safecall;
  protected
    //** Срабатывает, когда нужно выполнить внешнюю команду. см. TProfMessage
    function DoCommand(const AMsg: WideString): WordBool; virtual; safecall;
    //** Срабатывает при финализации
    function DoFinalize(): WordBool; virtual; safecall;
    //** Срабатывает после успешной финализации
    function DoFinalized(): WordBool; virtual; safecall;
    //** Срабатывает при инициализации
    function DoInitialize(): WordBool; virtual; safecall;
    //** Срабатывает после успешнрй инициализации
    function DoInitialized(): WordBool; virtual; safecall;
    //** Срабатывает при начале запуска
    function DoStart(): WordBool; virtual; safecall;
    //** Срабатывает после удачного запуска
    function DoStarted(): WordBool; virtual; safecall;
    //** Срабатывает при начале процедуры остановки
    function DoStop(AIsShutDown: WordBool): WordBool; virtual; safecall;
    //** Срабатывает при завершении процедуры остановки
    function DoStoped(AIsShutDown: WordBool): WordBool; virtual; safecall;
  public // IProfEntity
    function GetEntityType(): TProfEntityType; safecall;
    function GetId(): Int64; safecall;
    function GetName(): WideString; safecall;
    procedure SetName(const Value: WideString); safecall;
  public // IProfObject
    function GetConfigNode(): IProfNode; safecall;
    function GetLogNode(): IProfLogNode; safecall;
    procedure SetConfigNode(Value: IProfNode); safecall;
    procedure SetLogNode(Value: IProfLogNode); safecall;
  public // IProfObject
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; virtual;
      //** Добавить (выполнить) сообщение
    function AddMessage(const Msg: WideString): Integer; safecall;
      //** Передать сообщение
    function SendMessage(const Msg: WideString): Integer; safecall;
  public
    function ConfigureLoad(): WordBool; virtual;
    function ConfigureSave(): WordBool; virtual;
    //** Загрузить конфигурации
    function ConfigureLoad2(AConfig: IXmlNode = nil): WordBool; virtual; safecall;
    //** Сохранить конфигурации
    function ConfigureSave2(AConfig: IXmlNode = nil): WordBool; virtual; safecall;
    //** Финализировать
    function Finalize(): TProfError; virtual;
    //** Инициализировать
    function Initialize(): TProfError; virtual;
    function Start(): WordBool; virtual; safecall;
    function Stop(): WordBool; virtual; safecall;
  public // Переопределение функций TInterfacedObject
    procedure AfterConstruction(); override;
    procedure BeforeDestruction(); override;
  public
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Boolean; virtual;
    function AssignedConfig(): Boolean;
    function CheckInitialized(): Boolean; virtual;
    constructor Create(); virtual;
    destructor Destroy(); override;
    procedure Free(); virtual;
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; virtual;
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; virtual; safecall;
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer; virtual; safecall;
  public
    property Config: IXmlNode read GetConfig write SetConfig;
    property Initialized: WordBool read FInitialized write SetInitialized;
    property Name: WideString read FName write FName;
    property Log: ILogNode2 read GetLog write SetLog;
    property OnAddToLog: TProfAddToLog read FOnAddToLog write FOnAddToLog;
  end;

  //TProfObject3 = TProfObject;

const // Сообщения
  stAlreadyFinalize   = 'Уже финализировано';
  stAlreadyInitialize = 'Уже инициализировано';
  stNotAssignedConfig = 'Конфигурации не заданы';
  stNotInitialized    = 'Не инициализировано';

implementation

{ TProfBaseObject3 }

function TProfBaseObject3.AddMessage(const Msg: Widestring): Integer;
begin
  Result := 0;
  // ...
end;

function TProfBaseObject3.ConfigureLoad(AConfig: IProfNode): TProfError;
begin
  Result := 0;
  // ...
end;

function TProfBaseObject3.ConfigureSave(AConfig: IProfNode): TProfError;
begin
  Result := 0;
  // ...
end;

function TProfBaseObject3.Finalize(): TProfError;
begin
  Result := 0;
  // ...
end;

function TProfBaseObject3.GetConfigNode(): IProfNode;
begin
  Result := FConfig;
end;

function TProfBaseObject3.GetLogNode(): IProfLogNode;
begin
  Result := FLog;
end;

function TProfBaseObject3.Initialize(): TProfError;
begin
  Result := 0;
  // ...
end;

function TProfBaseObject3.SendMessage(const Msg: WideString): Integer;
begin
  Result := 0;
  // ...
end;

procedure TProfBaseObject3.SetConfigNode(Value: IProfNode);
begin
  FConfig := Value;
end;

procedure TProfBaseObject3.SetLogNode(Value: IProfLogNode);
begin
  FLog := Value;
end;

{ TProfObject }

function TProfObject.AddMessage(const AMsg: WideString): Integer;
begin
  Result := 0;
end;

function TProfObject.AddMessageStr(const AMsg: WideString): Integer;
begin
  Result := 0;
end;

function TProfObject.AddMessageX(AMsg: IProfNode): Integer;
begin
  Result := 0;
end;

procedure TProfObject.AfterConstruction();
begin
  inherited AfterConstruction();
  DoCreated();
end;

function TProfObject.AssignedConfig(): Boolean;
begin
  Result := Assigned(FConfig);
  if not(Result) then
    AddToLog(lgGeneral, ltError, stNotAssignedConfig);
end;

procedure TProfObject.BeforeDestruction();
begin
  DoDestroy();
  inherited BeforeDestruction();
end;

function TProfObject.CheckInitialized(): Boolean;
begin
  Result := FInitialized;
  if not(Result) then
    AddToLog(lgGeneral, ltWarning, stNotInitialized);
end;

function TProfObject.ConfigureLoad(AConfig: IProfNode): TProfError;
begin
  Result := 0;
end;

function TProfObject.ConfigureSave(AConfig: IProfNode): TProfError;
begin
  Result := 0;
end;

constructor TProfObject.Create();
begin
  inherited Create();
  FConfig := nil;
  DoCreate();
end;

destructor TProfObject.Destroy();
begin
  if FInitialized then Finalize();
  inherited Destroy();
end;

procedure TProfObject.DoCreate();
begin
end;

procedure TProfObject.DoCreated();
begin
end;

procedure TProfObject.DoDestroy();
begin
end;

function TProfObject.DoFinalize(): TProfError;
begin
  Result := 0;
end;

function TProfObject.DoFinalized(): TProfError;
begin
  Result := 0;
end;

function TProfObject.DoInitialize(): TProfError;
begin
  Result := 0;
end;

function TProfObject.DoInitialized(): TProfError;
begin
  Result := 0;
end;

function TProfObject.Finalize(): TProfError;
begin
  Result := 1;
  if not(FInitialized) then
  begin
    AddToLog(lgGeneral, ltInformation, stAlreadyFinalize);
    Exit;
  end;

  Result := DoFinalize();
  if (Result >= 0) then
    Result := DoFinalized();

  FInitialized := False;
end;

procedure TProfObject.Free();
begin
end;

function TProfObject.GetConfigNode(): IProfNode;
begin
  Result := FConfig;
end;

function TProfObject.GetLogNode(): IProfLogNode;
begin
  Result := FLog;
end;

function TProfObject.Initialize(): TProfError;
begin
  if FInitialized then
  begin
    AddToLog(lgGeneral, ltInformation, stAlreadyInitialize);
    Result := 0;
    Exit;
  end;
  Result := DoInitialize();
  if (Result >= 0) then
    Result := DoInitialized();

  //Start();

  FInitialized := True;
end;

procedure TProfObject.SetInitialized(Value: WordBool);
begin
  if FInitialized = Value then Exit;
  if Value then
    Initialize()
  else
    Finalize();
end;

function TProfObject.SendMessage(const AMsg: WideString): Integer;
begin
  Result := 0;
  if Assigned(FOnSendMessage) then
  try
    Result := FOnSendMessage(AMsg);
  except
  end;
end;

function TProfObject.SendMessageX(const AMsg: IProfNode): Integer;
begin
  Result := 0;
  {
  if Assigned(FOnSendMessageX) then
  try
    Result := FOnSendMessageX(AMsg);
  except
  end;
  }
end;

procedure TProfObject.SetConfigNode(Value: IProfNode);
begin
  FConfig := Value;
end;

procedure TProfObject.SetLogNode(Value: IProfLogNode);
begin
  FLog := Value;
end;

{ TProfObject2 }

function TProfObject2.AddMessage(const Msg: WideString): Integer;
begin
  Result := 0;
end;

function TProfObject2.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  Result := ToLog(AGroup, AType, AStrMsg, []);
end;

function TProfObject2.AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: string; AParams: array of const): Boolean;
begin
  Result := (ToLog(AGroup, AType, AStrMsg, AParams) > 0);
end;

procedure TProfObject2.AfterConstruction();
begin
  inherited AfterConstruction();
  DoCreated();
end;

function TProfObject2.AssignedConfig(): Boolean;
begin
  Result := Assigned(FConfig);
  if not(Result) then
    AddToLog(lgGeneral, ltError, stNotAssignedConfig);
end;

procedure TProfObject2.BeforeDestruction();
begin
  DoDestroy();
  inherited BeforeDestruction();
end;

function TProfObject2.CheckInitialized(): Boolean;
begin
  Result := FInitialized;
  if not(Result) then
    AddToLog(lgGeneral, ltWarning, stNotInitialized);
end;

function TProfObject2.ConfigureLoad(): WordBool;
begin
  Result := True;
end;

function TProfObject2.ConfigureLoad2(AConfig: IXmlNode): WordBool;
begin
  Result := AssignedConfig or Assigned(AConfig);
end;

function TProfObject2.ConfigureSave(): WordBool;
begin
  Result := True;
end;

function TProfObject2.ConfigureSave2(AConfig: IXmlNode): WordBool;
begin
  Result := AssignedConfig or Assigned(AConfig);
end;

constructor TProfObject2.Create({AConfig: IXmlNode = nil; ALog: ILogNode2 = nil});
begin
  inherited Create();
  FConfig := nil;
  FLog := nil;
  //FConfig := AConfig;
  //FLog := ALog;
  DoCreate();
  //DoCreated();
end;

destructor TProfObject2.Destroy();
begin
  if FInitialized then Finalize();
  inherited Destroy();
end;

function TProfObject2.DoCommand(const AMsg: WideString): WordBool;
begin
  Result := False;
end;

function TProfObject2.DoFinalize(): WordBool;
begin
  Result := True;
end;

function TProfObject2.DoFinalized(): WordBool;
begin
  Result := True;
end;

function TProfObject2.DoInitialize(): WordBool;
begin
  Result := True;
end;

function TProfObject2.DoInitialized(): WordBool;
begin
  Result := True;
end;

function TProfObject2.DoStart(): WordBool;
begin
  Result := True;
end;

function TProfObject2.DoStarted(): WordBool;
begin
  Result := True;
end;

function TProfObject2.DoStop(AIsShutDown: WordBool): WordBool;
begin
  Result := True;
end;

function TProfObject2.DoStoped(AIsShutDown: WordBool): WordBool;
begin
  Result := True;
end;

function TProfObject2.Finalize(): TProfError;
begin
  {IFDEF NEW}
  {Stop();
  Result := -1;
  if not(FInitialized) then
  begin
    AddToLog(lgGeneral, ltInformation, stAlreadyFinalize);
    Exit;
  end;

  Result := DoFinalize();
  if Result then
    Result := DoFinalized();}
  {ELSE}
  Result := -1;
  if not(FInitialized) then
  begin
    AddToLog(lgGeneral, ltInformation, stAlreadyFinalize);
    Exit;
  end;
  Result := 0;
  if not(DoStop(False)) then
    Result := -2;
  if not(DoStoped(False)) then
    Result := -3;
  {ENDIF}

  FInitialized := False;
end;

procedure TProfObject2.Free();
begin
  //inherited Free();
end;

function TProfObject2.GetConfig(): IXmlNode;
begin
  Result := FConfig;
end;

function TProfObject2.GetConfigNode(): IProfNode;
begin
  Result := nil;
end;

function TProfObject2.GetEntityType(): TProfEntityType;
begin
  Result := 0;
end;

function TProfObject2.GetId(): Int64;
begin
  Result := 0;
end;

function TProfObject2.GetLog(): ILogNode2;
begin
  Result := FLog;
end;

function TProfObject2.GetLogNode(): IProfLogNode;
begin
  Result := nil;
end;

function TProfObject2.GetName(): WideString;
begin
  Result := '';
end;

function TProfObject2.Initialize(): TProfError;
begin
  if FInitialized then
  begin
    AddToLog(lgGeneral, ltInformation, stAlreadyInitialize);
    Result := 0;
    Exit;
  end;
  {IFDEF NEW}
  {Result := DoInitialize();
  if Result then
    Result := DoInitialized();}
  {ELSE}
  Result := 0;
  if not(DoStart()) then
    Result := -2;
  if not(DoStarted()) then
    Result := -3;
  {ENDIF}

  //Start();

  FInitialized := True;
end;

function TProfObject2.SendMessage(const Msg: WideString): Integer;
begin
  Result := 0;
end;

procedure TProfObject2.SetConfig(const Value: IXmlNode);
begin
  FConfig := Value;
end;

procedure TProfObject2.SetConfigNode(Value: IProfNode);
begin
end;

procedure TProfObject2.SetInitialized(Value: WordBool);
begin
  if FInitialized = Value then Exit;
  if Value then
    Initialize()
  else
    Finalize();
end;

procedure TProfObject2.SetLog(const Value: ILogNode2);
begin
  FLog := Value;
end;

procedure TProfObject2.SetLogNode(Value: IProfLogNode);
begin
end;

procedure TProfObject2.SetName(const Value: WideString);
begin
end;

function TProfObject2.Start(): WordBool;
begin
  Result := DoStart();
  if Result then
    Result := DoStarted();
end;

function TProfObject2.Stop(): WordBool;
begin
  Result := DoStop(False);
  if Result then
    Result := DoStoped(False);
end;

function TProfObject2.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
begin
  //Result := ToLogA(OLE_GROUP_MESSAGE[AGroup], OLE_TYPE_MESSAGE[AType], Format(AStrMsg, AParams));
  Result := ToLogA(AGroup, AType, Format(AStrMsg, AParams));

  if (Result < 0) and Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(AGroup, AType, AStrMsg, AParams);
  except
  end;
end;

function TProfObject2.ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  Result := -1;
  if Assigned(FLog) then
  try
    Result := FLog.ToLogA(AGroup, AType, AStrMsg);
  except
  end;
end;

function TProfObject2.ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  Result := -1;
  if Assigned(FLog) then
  try
    Result := FLog.ToLogA(ALogGlobals.IntToLogGroupMessage(AGroup), ALogGlobals.IntToLogTypeMessage(AType), AStrMsg);
  except
  end;
end;

end.
