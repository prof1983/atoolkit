﻿{**
@Abstract Объект с логированием и конфигурациями
@Author Prof1983 <prof1983@ya.ru>
@Created 22.12.2005
@LastMod 18.12.2012

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
  //ALogNodeImpl, ALogNodeIntf,
  //AXmlNodeIntf;

type //** Объект с логированием и конфигурациями
  TAObject = class(TANamedEntity, IProfObject)
  protected
      //** Конфигурации
    FConfig: AXmlNode;
      //** Инициализирован
    FInitialized: WordBool;
      //** Ветка логирования
    FLog: ALogNode;
      //** CallBack функция. Срабатывает при поступлении сообщения.
    FOnSendMessage: TProcMessageStr;
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
    function DoFinalize(): AError; virtual; safecall;
      //** Срабатывает после успешной финализации
    function DoFinalized(): AError; virtual; safecall;
      //** Срабатывает при инициализации
    function DoInitialize(): AError; virtual; safecall;
      //** Срабатывает после успешнрй инициализации
    function DoInitialized(): AError; virtual; safecall;
  public // IProfObject
      //** Выполнить или передать дочерним объектам
    function AddMessage(const AMsg: WideString): Integer; virtual;
      //** Загрузить конфигурации
    function ConfigureLoad(AConfig: IProfNode): AError; safecall;
      //** Сохранить конфигурации
    function ConfigureSave(AConfig: IProfNode): AError; safecall;
      //** Финализирует
    function Finalize(): AError; virtual;
      //** Инициализирует
    function Initialize(): AError; virtual;
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
        const StrMsg: WideString): AInt; override;
    function AddToLog2(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: string; Params: array of const): ABoolean; virtual; deprecated; // Use AddToLog()
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
      //** Инициализорован
    property Initialized: WordBool read FInitialized write SetInitialized;
      //** Ветка логирования
    property Log: ALogNode read GetLogNode write SetLogNode;
      //** CallBack функция функция. Срабатывает при поступлении лог-сообщения.
    property OnAddToLog: TAddToLogProc read FOnAddToLog write FOnAddToLog;
      //** CallBack функция передачи сообщения
    property OnSendMessage: TProcMessageStr read FOnSendMessage write FOnSendMessage;
  end;

type //** Объект с логированием и конфигурациями
  TProfObject2 = class(TAObject, IProfObject2)
  protected
    function GetConfig2(): IXmlNode; safecall;
    function GetLog(): ALogNode; safecall;
    procedure SetConfig2(const Value: IXmlNode); virtual; safecall;
    procedure SetLog(const Value: ALogNode); virtual; safecall;
  protected
    //** Срабатывает, когда нужно выполнить внешнюю команду. см. TProcMessageStr
    function DoCommand(const AMsg: WideString): WordBool; virtual; safecall;
    //** Срабатывает при начале запуска
    function DoStart(): WordBool; virtual; safecall;
    //** Срабатывает после удачного запуска
    function DoStarted(): WordBool; virtual; safecall;
    //** Срабатывает при начале процедуры остановки
    function DoStop(AIsShutDown: WordBool): WordBool; virtual; safecall;
    //** Срабатывает при завершении процедуры остановки
    function DoStoped(AIsShutDown: WordBool): WordBool; virtual; safecall;
  public
    function ConfigureLoad(): WordBool; virtual;
    function ConfigureSave(): WordBool; virtual;
    //** Загрузить конфигурации
    function ConfigureLoad2(AConfig: IXmlNode = nil): WordBool; virtual; safecall;
    //** Сохранить конфигурации
    function ConfigureSave2(AConfig: IXmlNode = nil): WordBool; virtual; safecall;
    //** Финализировать
    function Finalize(): AError; override;
    //** Инициализировать
    function Initialize(): AError; override;
    function Start(): WordBool; virtual; safecall;
    function Stop(): WordBool; virtual; safecall;
  public // Переопределение функций TInterfacedObject
    procedure AfterConstruction(); override;
    procedure BeforeDestruction(); override;
  public
    function AssignedConfig(): Boolean;
  public
    property Config2: IXmlNode read GetConfig2 write SetConfig2;
    property Log: ALogNode read GetLog write SetLog;
  end;

type //** Объект с логированием и конфигурациями
  TAObject2006 = class(TInterfacedObject, IProfObject2006)
  protected
    FConfig: AProfXmlNode2;
    FInitialized: Boolean;
    FLog: IALogNode2;
    procedure SetInitialized(Value: Boolean);
  protected // IProfObject2006
    function Get_Config(): AProfXmlNode2; safecall;
    function Get_Log(): IALogNode2; safecall;
    procedure Set_Config(const Value: AProfXmlNode2); safecall;
    procedure Set_Log(const Value: IALogNode2); virtual; safecall;
  public // IProfObject2006
    function ConfigureLoad(): WordBool; virtual; safecall;
    function ConfigureSave(): WordBool; virtual; safecall;
    function Finalize(): WordBool; virtual; safecall;
    function Initialize(): WordBool; virtual; safecall;
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean; virtual;
    function AddToLog2(AMsg: WideString): TALogNode; virtual;
    function AssignedConfig(): Boolean;
    function CheckInitialized(): Boolean; virtual;
  public
    constructor Create(AConfig: AProfXmlNode2 = 0; ALog: TALogNode = nil);
    procedure Free(); virtual;
  public
    property Initialized: Boolean read FInitialized write SetInitialized;
  end;

const // Сообщения
  stAlreadyFinalize   = 'Уже финализировано';
  stAlreadyInitialize = 'Уже инициализировано';
  stNotAssignedConfig = 'Конфигурации не заданы';
  stNotInitialized    = 'Не инициализировано';

implementation

{ TAObject }

function TAObject.AddMessage(const AMsg: WideString): Integer;
begin
  Result := 0;
end;

function TAObject.AddMessageStr(const AMsg: WideString): Integer;
begin
  Result := 0;
end;

function TAObject.AddMessageX(AMsg: IProfNode): Integer;
begin
  Result := 0;
end;

function TAObject.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: WideString): AInt;
begin
  Result := inherited AddToLog(LogGroup, LogType, StrMsg);
  if (FLog <> 0) then
    Result := ALogNode_AddToLogP(FLog, LogGroup, LogType, StrMsg);
end;

function TAObject.AddToLog2(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: string; Params: array of const): ABoolean;
begin
  Result := (AddToLog(LogGroup, LogType, Format(StrMsg, Params)) > 0);
end;

procedure TAObject.AfterConstruction();
begin
  inherited AfterConstruction();
  DoCreated();
end;

function TAObject.AssignedConfig(): Boolean;
begin
  if (FConfig = 0) then
  begin
    AddToLog(lgGeneral, ltError, stNotAssignedConfig);
    Result := False;
    Exit;
  end;
  Result := True;
end;

procedure TAObject.BeforeDestruction();
begin
  DoDestroy();
  inherited BeforeDestruction();
end;

function TAObject.CheckInitialized(): Boolean;
begin
  Result := FInitialized;
  if not(Result) then
    AddToLog(lgGeneral, ltWarning, stNotInitialized);
end;

function TAObject.ConfigureLoad(AConfig: IProfNode): AError;
begin
  Result := 0;
end;

function TAObject.ConfigureSave(AConfig: IProfNode): AError;
begin
  Result := 0;
end;

constructor TAObject.Create();
begin
  inherited Create();
  FConfig := 0;
  DoCreate();
  //DoCreated();
end;

destructor TAObject.Destroy();
begin
  if FInitialized then Finalize();
  inherited Destroy();
end;

procedure TAObject.DoCreate();
begin
end;

procedure TAObject.DoCreated();
begin
end;

procedure TAObject.DoDestroy();
begin
end;

function TAObject.DoFinalize(): AError;
begin
  Result := 0;
end;

function TAObject.DoFinalized(): AError;
begin
  Result := 0;
end;

function TAObject.DoInitialize(): AError;
begin
  Result := 0;
end;

function TAObject.DoInitialized(): AError;
begin
  Result := 0;
end;

function TAObject.Finalize(): AError;
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

procedure TAObject.Free();
begin
end;

function TAObject.GetConfigNode(): AConfigNode;
begin
  Result := FConfig;
end;

function TAObject.GetLogNode(): ALogNode;
begin
  Result := FLog;
end;

function TAObject.Initialize(): AError;
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

  FInitialized := True;
end;

function TAObject.SendMessage(const AMsg: WideString): Integer;
begin
  Result := 0;
  if Assigned(FOnSendMessage) then
  try
    Result := FOnSendMessage(AMsg);
  except
  end;
end;

function TAObject.SendMessageX(Msg: AXmlNode): AInt;
begin
  Result := 0;
end;

function TAObject.SendMessageX1(Msg: IProfNode): AInt;
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

procedure TAObject.SetConfigNode(Value: AXmlNode{IProfNode});
begin
  FConfig := Value;
end;

procedure TAObject.SetInitialized(Value: WordBool);
begin
  if FInitialized = Value then Exit;
  if Value then
    Initialize()
  else
    Finalize();
end;

procedure TAObject.SetLogNode(Value: ALogNode);
begin
  FLog := Value;
end;

function TAObject.ToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: WideString; Params: array of const): AInteger;
begin
  Result := AddToLog(LogGroup, LogType, Format(StrMsg, Params));
end;

function TAObject.ToLogA(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: WideString): AInteger;
begin
  Result := AddToLog(LogGroup, LogType, StrMsg);
end;

function TAObject.ToLogE(LogGroup: EnumGroupMessage; LogType: EnumTypeMessage;
    const StrMsg: WideString): AInteger;
begin
  Result := AddToLog(ALogGlobals.IntToLogGroupMessage(LogGroup),
      ALogGlobals.IntToLogTypeMessage(LogType), StrMsg);
end;

{ TAObject2006 }

function TAObject2006.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
begin
  if Assigned(FLog) then
    Result := (FLog.ToLogA(AGroup, AType, Format(AStrMsg, AParams)) >= 0)
  else
    Result := False;
end;

function TAObject2006.AddToLog2(AMsg: WideString): TALogNode;
begin
  if Assigned(FLog) then
  begin
    FLog.AddToLog(lgGeneral, ltInformation, AMsg);
    Result := nil;
  end
  else
    Result := nil;
end;

function TAObject2006.AssignedConfig: Boolean;
begin
  if (FConfig = 0) then
  begin
    AddToLog(lgGeneral, ltError, stNotAssignedConfig, []);
    Result := False;
    Exit;
  end;
  Result := True;
end;

function TAObject2006.CheckInitialized: Boolean;
begin
  Result := FInitialized;
  if not(Result) then
    AddToLog(lgGeneral, ltWarning, stNotInitialized, []);
end;

function TAObject2006.ConfigureLoad: WordBool;
begin
  Result := AssignedConfig;
end;

function TAObject2006.ConfigureSave: WordBool;
begin
  Result := AssignedConfig;
end;

constructor TAObject2006.Create(AConfig: AProfXmlNode2 = 0; ALog: TALogNode = nil);
begin
  inherited Create;
  FConfig := AConfig;
  FLog := ALog;
end;

function TAObject2006.Finalize: WordBool;
begin
  Result := False;
  if not(FInitialized) then begin
    AddToLog(lgGeneral, ltInformation, stAlreadyFinalize, []);
    Exit;
  end;
  Result := True;
  FInitialized := False;
end;

procedure TAObject2006.Free;
begin
  if FInitialized then
    Finalize;
  inherited Free;
end;

function TAObject2006.Get_Config(): AProfXmlNode2;
begin
  Result := FConfig;
end;

function TAObject2006.Get_Log(): IALogNode2;
begin
  Result := FLog;
end;

function TAObject2006.Initialize(): WordBool;
begin
  if FInitialized then begin
    AddToLog(lgGeneral, ltInformation, stAlreadyInitialize, []);
    Result := True;
    Exit;
  end;
  Result := True;
  FInitialized := True;
end;

procedure TAObject2006.SetInitialized(Value: Boolean);
begin
  if Value then
    Initialize
  else
    Finalize;
end;

procedure TAObject2006.Set_Config(const Value: AProfXmlNode2);
begin
  FConfig := Value;
end;

procedure TAObject2006.Set_Log(const Value: IALogNode2);
begin
  FLog := Value;
end;

{ TProfObject2 }

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

function TProfObject2.Finalize(): AError;
begin
  Result := inherited Finalize();

  if not(DoStop(False)) then
    Result := -2;
  if not(DoStoped(False)) then
    Result := -3;
end;

function TProfObject2.GetConfig2(): IXmlNode;
begin
  Result := nil{FConfig};
end;

function TProfObject2.GetLog(): ALogNode;
begin
  Result := FLog;
end;

function TProfObject2.Initialize(): AError;
begin
  Result := inherited Initialize();

  if not(DoStart()) then
    Result := -2;
  if not(DoStarted()) then
    Result := -3;
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
