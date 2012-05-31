{**
@Abstract(Класс-потомок для форм с логированием и конфигурациями)
@Author(Prof1983 prof1983@ya.ru)
@Created(06.10.2005)
@LastMod(26.04.2012)
@Version(0.5)
}
unit AFormImpl;

interface

uses
  Classes, Forms, SysUtils,
  AFormIntf, ALogNodeIntf, ANodeUtils, ANodeIntf, ATypes, AXmlUtils,
  AObjectIntf, ATypesEx;

type //** Класс-потомок для форм с логированием и конфигурациями
  TProfForm = class(TForm, IProfForm)
  protected
    FConfig: IProfNode;
    FIsInitialized: WordBool;
    FLog: IProfLogNode;
    //FLogPrefix: WideString; // TODO: Удалить
    //** CallBack функция. Срабатывает при добавлении лог-сообщения.
    FOnAddToLog: TProcAddToLog;
    //** CallBack функция. Срабатывает при добавлении сообщения.
    FOnMessage: TProcMessage;
    function GetConfig(): IProfNode; safecall;
    procedure SetConfig(const Value: IProfNode); safecall;
  protected
      //** Срабатывает при добавлении сообщения
    function DoAddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; virtual; safecall;
      //** Срабатывает после создания
    procedure DoCreated(); virtual; safecall;
      //** Срабатывает при уничтожении
    procedure DoDestroy(); override;
      //** Срабатывает при финализации
    function DoFinalize(): WordBool; virtual; safecall;
      //** Срабатывает при инициализации
    function DoInitialize(): WordBool; virtual; safecall;
      //** Срабатывает при добавлении сообщения
    function DoMessage(const AMsg: WideString): Integer; virtual; safecall;
  public
      //** Добавляет сообщение
    function AddMessage(const AMsg: WideString): Integer; virtual;
      //** Добавляет сообщение
    function AddMessageSafe(const Msg: WideString): Integer; virtual; safecall;
      //** Добавляет лог-сообщение
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AMsg: WideString): Integer; virtual;
      //** Добавляет лог-сообщение
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; virtual;
      //** Добавляет лог-сообщение
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; virtual;
      //** Добавляет сообщение
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer; virtual;
  public
      //** Загрузить конфигурации
    function ConfigureLoad(AConfig: IProfNode = nil): WordBool; virtual; safecall;
      //** Созранить конфигурации
    function ConfigureSave(AConfig: IProfNode = nil): WordBool; virtual; safecall;
      //** Финализирует
    function Finalize(): TProfError; virtual;
      //** Освобождает
    procedure Free(); virtual;
      //** Инициализирует
    function Initialize(): TProfError; virtual;
  public
      //** Конфигурации в виде XML
    property Config: IProfNode read FConfig write FConfig;
      //** Инициализорован
    property Initialized: WordBool read FIsInitialized;
      //** Объект для записи лог-сообщений
    property Log: IProfLogNode read FLog write FLog;
      //** CallBack функция. Срабатывает при добавлении лог-сообщения.
    property OnAddToLog: TProcAddToLog read FOnAddToLog write FOnAddToLog;
      //** CallBack функция. Срабатывает при добавлении сообщения.
    property OnMessage: TProcMessage read FOnMessage write FOnMessage;
  end;

type //** @abstract(Класс-потомок для форм с логированием и конфигурациями)
  TProfForm3 = class(TForm, IProfObject)
  protected
    FConfig: IProfNode;
    FIsInitialized: WordBool;
    FLog: IProfLogNode;
      //** CallBack функция. Срабатывает при добавлении лог-сообщения.
    FOnAddToLog: TProcAddToLog;
      //** CallBack функция. Срабатывает при добавлении сообщения.
    FOnSendMessage: TProcMessage;
    FOnSendMessageX: TProcMessageX;
  protected
    function GetConfigNode(): IProfNode; safecall;
    function GetEntityType(): TProfEntityType; safecall;
    function GetID(): Int64; safecall;
    function GetLogNode(): IProfLogNode; safecall;
    function GetName(): WideString; safecall;
    procedure SetConfigNode(Value: IProfNode); safecall;
    procedure SetLogNode(Value: IProfLogNode); safecall;
    procedure SetName(const Value: WideString); safecall;
  protected
    //** Срабатывает после создания
    procedure DoCreated(); virtual; safecall;
    //** Срабатывает при уничтожении
    procedure DoDestroy(); override;
    //** Срабатывает при финализации
    function DoFinalize(): TProfError; virtual; safecall;
    //** Срабатывает после финализации
    function DoFinalized(): TProfError; virtual; safecall;
    //** Срабатывает при инициализации
    function DoInitialize(): TProfError; virtual; safecall;
    //** Срабатывает после инициализации
    function DoInitialized(): TProfError; virtual; safecall;
    //** Передать сообщение
    function SendMessage(const AMsg: WideString): Integer; virtual; safecall;
    //** Передать сообщение
    function SendMessageX(Msg: IProfNode): Integer; virtual; safecall;
  public
    //** Добавить сообщение
    function AddMessage(const AMsg: WideString): Integer; virtual; safecall;
    function AddMessageX(AMsg: IProfNode): Integer; virtual; safecall;
      { Добавляет лог-сообщение
        @returns(Возвращает номер добавленого лог-сообщения или 0) }
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; virtual;
  public
    //** Конфигурации в виде XML
    property Config: IProfNode read FConfig write FConfig;
    //** Загрузить конфигурации
    function ConfigureLoad(AConfig: IProfNode = nil): TProfError; virtual; safecall;
    //** Созранить конфигурации
    function ConfigureSave(AConfig: IProfNode = nil): TProfError; virtual; safecall;
    //** Финализирует
    function Finalize(): TProfError; virtual; //safecall;
    //** Освобождает
    procedure Free(); virtual;
    //** Инициализирует
    function Initialize(): TProfError; virtual; //safecall;
    //** Инициализорован
    property IsInitialized: WordBool read FIsInitialized;
    //** Объект для записи лог-сообщений
    property Log: IProfLogNode read FLog write FLog;
    //** CallBack функция. Срабатывает при добавлении лог-сообщения.
    property OnAddToLog: TProcAddToLog read FOnAddToLog write FOnAddToLog;
    //** CallBack функция. Срабатывает при добавлении сообщения.
    property OnSendMessage: TProcMessage read FOnSendMessage write FOnSendMessage;
    property OnSendMessageX: TProcMessageX read FOnSendMessageX write FOnSendMessageX;
  end;

resourcestring // Сообщения ----------------------------------------------------
  stCreateOk = 'Объект создан';

const
  //** @abstract(Состояние окна)
  WINDOW_STATE: array[TWindowState] of string = ('Normal', 'Minimized', 'Maximized');

implementation

const
  configCaption = 'Caption';
  configLeft = 'Left';
  configTop = 'Top';
  configWidth = 'Width';
  configHeight = 'Height';
  configVisible = 'Visible';
  configWindowState = 'WindowState';

{ TProfForm }

function TProfForm.AddMessage(const AMsg: WideString): Integer;
begin
  Result := DoMessage(AMsg);
end;

function TProfForm.AddMessageSafe(const Msg: WideString): Integer;
begin
  Result := AddMessage(Msg);
end;

function TProfForm.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AMsg: WideString): Integer;
begin
  Result := DoAddToLog(AGroup, AType, AMsg);
end;

function TProfForm.ConfigureLoad(AConfig: IProfNode): WordBool;
var
  I: Integer;
  S: WideString;
  tmpWindowState: TWindowState;
  tmpConfig: IProfNode;
begin
  if Assigned(AConfig) then
    tmpConfig := AConfig
  else
    tmpConfig := FConfig;

  Result := Assigned(tmpConfig);
  if not(Result) then Exit;

  tmpWindowState := TWindowState(Node_ReadInt32Def(tmpConfig, 'WindowState', Integer(wsNormal)));

  WindowState := wsNormal;

  {
  begin
    if tmpConfig.ReadInt32(configLeft, I) then Left := I;
    if tmpConfig.ReadInt32(configTop, I) then Top := I;
    if tmpConfig.ReadInt32(configWidth, I) then Width := I;
    if tmpConfig.ReadInt32(configHeight, I) then Height := I;
  end;
  }
  if WindowState <> tmpWindowState then
    WindowState := tmpWindowState;

  // Заголовок окна
  {
  if tmpConfig.ReadString('Caption', S) then Caption := S;
  }
end;

function TProfForm.ConfigureSave(AConfig: IProfNode): WordBool;
var
  tmpConfig: IProfNode;
begin
  if Assigned(AConfig) then
    tmpConfig := AConfig
  else
    tmpConfig := AConfig;

  Result := Assigned(tmpConfig);
  if not(Result) then Exit;
  {
  if WindowState <> wsMaximized then
  begin
    tmpConfig.WriteInt32(configLeft, Left);
    tmpConfig.WriteInt32(configTop, Top);
    tmpConfig.WriteInt32(configWidth, Width);
    tmpConfig.WriteInt32(configHeight, Height);
  end;
  tmpConfig.WriteInt32('WindowState', Integer(WindowState));
  tmpConfig.WriteString('Caption', Caption); // Заголовок окна
  tmpConfig.WriteBool('Visible', Self.Visible);
  }
end;

function TProfForm.DoAddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  Result := 0;

  if Assigned(FLog) then
  try
    Result := FLog.AddToLog(AGroup, AType, AStrMsg);
  except
  end;

  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(AGroup, AType, AStrMsg);
  except
  end;
end;

procedure TProfForm.DoCreated();
begin
  //Self.AfterConstruction
end;

procedure TProfForm.DoDestroy();
begin
  DoFinalize();
  inherited DoDestroy();
end;

function TProfForm.DoFinalize(): WordBool;
begin
  FConfig := nil;
  //FConfigDocument := nil;
  FLog := nil;
  Result := True;
end;

function TProfForm.DoInitialize(): WordBool;
begin
  Result := True;
end;

function TProfForm.DoMessage(const AMsg: WideString): Integer;
begin
  Result := 0;
  if Assigned(FOnMessage) then
  try
    Result := FOnMessage(AMsg);
  except
  end;
end;

function TProfForm.Finalize(): TProfError;
begin
  Result := 0;
end;

procedure TProfForm.Free();
begin
  inherited Free;
end;

function TProfForm.GetConfig(): IProfNode;
begin
  Result := FConfig;
end;

function TProfForm.Initialize(): TProfError;
begin
  if DoInitialize() then
    Result := 0
  else
    Result := -2;
end;

procedure TProfForm.SetConfig(const Value: IProfNode);
begin
  FConfig := Value;
end;

function TProfForm.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := DoAddToLog(AGroup, AType, Format(AStrMsg, AParams));
end;

function TProfForm.ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  Result := DoAddToLog(AGroup, AType, AStrMsg);
end;

function TProfForm.ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  //Result := DoAddToLog(GroupMessageFromInt(AGroup), TypeMessageFromInt(AType), AStrMsg);
end;

{ TProfForm3 }

function TProfForm3.AddMessage(const AMsg: WideString): Integer;
begin
  Result := 0;
end;

function TProfForm3.AddMessageX(AMsg: IProfNode): Integer;
begin
  Result := 0;
end;

function TProfForm3.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  Result := 0;

  if Assigned(FLog) then
  try
    Result := FLog.AddToLog(AGroup, AType, AStrMsg);
  except
  end;

  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(AGroup, AType, AStrMsg);
  except
  end;
end;

function TProfForm3.ConfigureLoad(AConfig: IProfNode): TProfError;
var
  //I: Integer;
  //S: WideString;
  //tmpWindowState: TWindowState;
  tmpConfig: IProfNode;
begin
  if Assigned(AConfig) then
    tmpConfig := AConfig
  else
    tmpConfig := FConfig;

  if not(Assigned(tmpConfig)) then
  begin
    Result := -1;
    Exit;
  end;

//  tmpWindowState := TWindowState(tmpConfig.ReadInt32Def(configWindowState, Integer(wsNormal)));

  WindowState := wsNormal;

//  begin
//    if tmpConfig.ReadInt32(configLeft, I) then Left := I;
//    if tmpConfig.ReadInt32(configTop, I) then Top := I;
//    if tmpConfig.ReadInt32(configWidth, I) then Width := I;
//    if tmpConfig.ReadInt32(configHeight, I) then Height := I;
//  end;
//  if WindowState <> tmpWindowState then
//    WindowState := tmpWindowState;
//
//  // Заголовок окна
//  if tmpConfig.ReadString(configCaption, S) then Caption := S;
end;

function TProfForm3.ConfigureSave(AConfig: IProfNode): TProfError;
var
  tmpConfig: IProfNode;
begin
  if Assigned(AConfig) then
    tmpConfig := AConfig
  else
    tmpConfig := AConfig;

  if not(Assigned(tmpConfig)) then
  begin
    Result := -1;
    Exit;
  end;
//  if WindowState <> wsMaximized then
//  begin
//    tmpConfig.WriteInt32(configLeft, Left);
//    tmpConfig.WriteInt32(configTop, Top);
//    tmpConfig.WriteInt32(configWidth, Width);
//    tmpConfig.WriteInt32(configHeight, Height);
//  end;
//  tmpConfig.WriteInt32(configWindowState, Integer(WindowState));
//  tmpConfig.WriteString(configCaption, Caption); // Заголовок окна
//  tmpConfig.WriteBool(configVisible, Self.Visible);
end;

procedure TProfForm3.DoCreated();
begin
  //Self.AfterConstruction
end;

procedure TProfForm3.DoDestroy();
begin
  DoFinalize();
  inherited DoDestroy();
end;

function TProfForm3.DoFinalize(): TProfError;
begin
  FIsInitialized := False;
  FConfig := nil;
  FLog := nil;
  Result := 0;
end;

function TProfForm3.DoFinalized(): TProfError;
begin
  Result := 0;
end;

function TProfForm3.DoInitialize(): TProfError;
begin
  Result := 0;
  FIsInitialized := True;
end;

function TProfForm3.DoInitialized(): TProfError;
begin
  Result := 0;
end;

function TProfForm3.Finalize(): TProfError;
begin
  Result := DoFinalize();
  if Result >= 0 then
    Result := DoFinalized();
end;

procedure TProfForm3.Free();
begin
  inherited Free;
end;

function TProfForm3.GetConfigNode(): IProfNode;
begin
  Result := FConfig;
end;

function TProfForm3.GetEntityType(): TProfEntityType;
begin
  Result := 0;
end;

function TProfForm3.GetID(): Int64;
begin
  Result := 0;
end;

function TProfForm3.GetLogNode(): IProfLogNode;
begin
  Result := FLog;
end;

function TProfForm3.GetName(): WideString;
begin
  Result := Name;
end;

function TProfForm3.Initialize(): TProfError;
begin
  Result := DoInitialize();
  if Result >= 0 then
    Result := DoInitialized();
end;

function TProfForm3.SendMessage(const AMsg: WideString): Integer;
begin
  Result := 0;
  if Assigned(FOnSendMessage) then
  try
    Result := FOnSendMessage(AMsg);
  except
  end;
end;

function TProfForm3.SendMessageX(Msg: IProfNode): Integer;
begin
  Result := 0;
  if Assigned(FOnSendMessageX) then
  try
    Result := FOnSendMessageX(Msg);
  except
  end;
end;

procedure TProfForm3.SetConfigNode(Value: IProfNode);
begin
  FConfig := Value;
end;

procedure TProfForm3.SetLogNode(Value: IProfLogNode);
begin
  FLog := Value;
end;

procedure TProfForm3.SetName(const Value: WideString);
begin
  Name := Value;
end;

end.
