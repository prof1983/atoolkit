{**
@Abstract(Объект с логированием и конфигурациями)
@Author(Prof1983 <prof1983@ya.ru>)
@Created(22.12.2005)
@LastMod(13.07.2012)

Uses
  @link ABase
  @link AEntityImpl
  @link ALogGlobals
  @link ALogNodeUtils
  @link ANodeIntf
  @link AObjectIntf
  @link ATypes
}
unit AObjectImpl;

interface

uses
  SysUtils, XmlIntf,
  ABase, AEntityImpl, ALogGlobals, ALogNodeUtils, ANodeIntf, AObjectIntf, ATypes;

type //** Объект с логированием и конфигурациями
  TProfObject = class(TANamedEntity, IProfObject)
  protected
      //** Конфигурации
    FConfig: AXmlNode{IProfNode};
    //FConfig2: IXmlNode;
      //** Инициализирован
    FInitialized: WordBool;
      //** Ветка логирования
    FLog: ALogNode{IALogNode2};
      //** Префикс лог-сообщений
    //FLogPrefix: WideString;
      //** Функция добавления в log
    //FOnAddToLog: TProfAddToLog;
      //** CallBack функция. Срабатывает при поступлении сообщения.
    FOnSendMessage: TProcMessageStr;
    //FOnSendMessageX: TProcMessageX;
  protected
    function GetConfigNode(): AConfigNode; safecall;
    function GetLogNode(): ALogNode; safecall;
    procedure SetConfigNode(Value: AConfigNode); virtual; safecall;
    procedure SetInitialized(Value: WordBool);
    procedure SetLogNode(Value: ALogNode); virtual; safecall;
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
      //** Выполнить или передать дочерним объектам
    function AddMessage(const AMsg: WideString): Integer; virtual;
      //** Загрузить конфигурации
    function ConfigureLoad(AConfig: IProfNode): TProfError; safecall;
      //** Сохранить конфигурации
    function ConfigureSave(AConfig: IProfNode): TProfError; safecall;
      //** Финализирует
    function Finalize(): TProfError; virtual;
      //** Инициализирует
    function Initialize(): TProfError; virtual;
      //** Передает сообщение
    function SendMessage(const AMsg: WideString): Integer; virtual; safecall;
  public // Переопределение функций TInterfacedObject
      //** Срабатывает после создания
    procedure AfterConstruction(); override;
      //** Срабатывает до уничтожения объекта
    procedure BeforeDestruction(); override;
  public
      //** Выполнить или передать дочерним объектам
    function AddMessageStr(const AMsg: WideString): Integer; virtual;
      //** Выполнить или передать дочерним объектам
    function AddMessageX(AMsg: IProfNode): Integer; virtual; safecall;
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: WideString): AInt; virtual;
    function AddToLog2(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: string; Params: array of const): ABoolean; virtual;
    function AssignedConfig(): Boolean;
    function CheckInitialized(): Boolean; virtual;
    function SendMessageX(Msg: AXmlNode): AInt; virtual;
    function SendMessageX1(Msg: IProfNode): AInt; virtual;
    function ToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: WideString; Params: array of const): AInteger; virtual;
    function ToLogA(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: WideString): AInteger; virtual;
    function ToLogE(LogGroup: EnumGroupMessage; LogType: EnumTypeMessage;
        const StrMsg: WideString): AInteger; virtual; safecall;
  public
    constructor Create(); virtual;
    destructor Destroy(); override;
    procedure Free(); virtual;
  public
      //** Конфигурации объекта
    property Config: AConfigNode read GetConfigNode write SetConfigNode;
      //** Конфигурации объекта
    //property ConfigNode: IProfNode read GetConfigNode write SetConfigNode;
      //** Инициализорован
    property Initialized: WordBool read FInitialized write SetInitialized;
      //** Ветка логирования
    property Log: ALogNode read GetLogNode write SetLogNode;
      //** Ветка логирования
    //property LogNode: IALogNode2 read GetLogNode write SetLogNode;
      //** Префикс лог-сообщений
    //property LogPrefix: WideString read FLogPrefix write FLogPrefix;
      //** CallBack функция функция. Срабатывает при поступлении лог-сообщения.
    property OnAddToLog: TAddToLogProc read FOnAddToLog write FOnAddToLog;
      //** CallBack функция передачи сообщения
    property OnSendMessage: TProcMessageStr read FOnSendMessage write FOnSendMessage;
    //property OnSendMessageX: TProcMessageX read FOnSendMessageX write FOnSendMessageX;
  end;

type //** Объект с логированием и конфигурациями
  TProfObject2 = class(TProfObject, IProfObject2)
  protected
    function GetConfig2(): IXmlNode; safecall;
    function GetLog(): ALogNode; safecall;
    procedure SetConfig2(const Value: IXmlNode); virtual; safecall;
    procedure SetLog(const Value: ALogNode); virtual; safecall;
  protected
    //** Срабатывает, когда нужно выполнить внешнюю команду. см. TProcMessageStr
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
  public // IProfObject
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
    function AssignedConfig(): Boolean;
    function CheckInitialized(): Boolean; virtual;
  public
    property Config2: IXmlNode read GetConfig2 write SetConfig2;
    property Log: ALogNode read GetLog write SetLog;
  end;

const // Сообщения
  stAlreadyFinalize   = 'Уже финализировано';
  stAlreadyInitialize = 'Уже инициализировано';
  stNotAssignedConfig = 'Конфигурации не заданы';
  stNotInitialized    = 'Не инициализировано';

implementation

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

function TProfObject.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: WideString): AInt;
begin
  Result := -1;
  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(LogGroup, LogType, StrMsg);
  except
  end;

  if (FLog <> 0) then
    Result := ALogNode_AddToLog(FLog, LogGroup, LogType, StrMsg);
end;

function TProfObject.AddToLog2(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: string; Params: array of const): ABoolean;
begin
  Result := (AddToLog(LogGroup, LogType, Format(StrMsg, Params)) > 0);
end;

procedure TProfObject.AfterConstruction();
begin
  inherited AfterConstruction();
  DoCreated();
end;

function TProfObject.AssignedConfig(): Boolean;
begin
  if (FConfig = 0) then
  begin
    AddToLog(lgGeneral, ltError, stNotAssignedConfig);
    Result := False;
    Exit;
  end;
  Result := True;
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
  FConfig := 0;
  DoCreate();
  //DoCreated();
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
  if not(FInitialized) then
  begin
    AddToLog(lgGeneral, ltInformation, stAlreadyFinalize);
    Result := 1;
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

function TProfObject.GetConfigNode(): AConfigNode;
begin
  Result := FConfig;
end;

function TProfObject.GetLogNode(): ALogNode;
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

function TProfObject.SendMessage(const AMsg: WideString): Integer;
begin
  Result := 0;
  if Assigned(FOnSendMessage) then
  try
    Result := FOnSendMessage(AMsg);
  except
  end;
end;

function TProfObject.SendMessageX(Msg: AXmlNode): AInt;
begin
  Result := 0;
end;

function TProfObject.SendMessageX1(Msg: IProfNode): AInt;
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

procedure TProfObject.SetConfigNode(Value: AXmlNode{IProfNode});
begin
  FConfig := Value;
end;

procedure TProfObject.SetInitialized(Value: WordBool);
begin
  if FInitialized = Value then Exit;
  if Value then
    Initialize()
  else
    Finalize();
end;

procedure TProfObject.SetLogNode(Value: ALogNode);
begin
  FLog := Value;
end;

function TProfObject.ToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: WideString; Params: array of const): AInteger;
begin
  Result := AddToLog(LogGroup, LogType, Format(StrMsg, Params));
end;

function TProfObject.ToLogA(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: WideString): AInteger;
begin
  Result := AddToLog(LogGroup, LogType, StrMsg);
end;

function TProfObject.ToLogE(LogGroup: EnumGroupMessage; LogType: EnumTypeMessage;
    const StrMsg: WideString): AInteger;
begin
  Result := AddToLog(ALogGlobals.IntToLogGroupMessage(LogGroup),
      ALogGlobals.IntToLogTypeMessage(LogType), StrMsg);
end;

{ TProfObject2 }

function TProfObject2.AddMessage(const Msg: WideString): Integer;
begin
  Result := 0;
end;

procedure TProfObject2.AfterConstruction();
begin
  inherited AfterConstruction();
  DoCreated();
end;

function TProfObject2.AssignedConfig(): Boolean;
begin
  Result := (FConfig <> 0);
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

function TProfObject2.GetConfig2(): IXmlNode;
begin
  Result := nil{FConfig};
end;

function TProfObject2.GetLog(): ALogNode;
begin
  Result := FLog;
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

procedure TProfObject2.SetConfig2(const Value: IXmlNode);
begin
  //FConfig := Value;
end;

procedure TProfObject2.SetLog(const Value: ALogNode);
begin
  FLog := Value;
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

end.
