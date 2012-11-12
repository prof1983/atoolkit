{**
@Abstract Класс-потомок для форм с логированием и конфигурациями
@Author Prof1983 <prof1983@ya.ru>
@Created 06.10.2005
@LastMod 12.11.2012
}
unit AFormImpl;

//TODO: Separate AFormImpl and AFormImplEx

interface

uses
  ABase, AFormIntf, AFormObj, ANodeIntf, ATypes;
  {Classes, Forms, SysUtils,
  AFormIntf, ALogNodeImpl, ANodeUtils, AXmlUtils,
  AObjectIntf;}

type //** Класс-потомок для форм с логированием и конфигурациями
  TProfFormI = class(TInterfacedObject, IProfForm)
  protected
    FForm: TAFormObject;
  public
    //** Добавление лог-сообщений
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: WideString): AInt;
    //** Загрузить конфигурации
    function ConfigureLoad(Config: AConfig{IProfNode}): AError;
    //** Сохранить конфигурации
    function ConfigureSave(Config: AConfig{IProfNode}): AError;
    //** Финализировать
    function Finalize(): AError;
    //** Инициализировать
    function Initialize(): AError;
  public
    function GetConfig(): AConfig{IProfNode};
    procedure SetConfig(const Value: AConfig{IProfNode});
  end;

  TProfForm = TAFormObject;

(*
type //** Класс-потомок для форм с логированием и конфигурациями
  TProfForm = class(TForm, IProfForm)
  protected
    FConfig: IProfNode;
    FIsInitialized: WordBool;
    FLog: TALogNode;
    //FLogPrefix: WideString; // TODO: Удалить
      {** CallBack функция. Срабатывает при добавлении лог-сообщения. }
    FOnAddToLog: TAddToLogProc;
      {** CallBack функция. Срабатывает при добавлении сообщения. }
    FOnMessage: TProcMessageStr;
      {** CallBack функция. Срабатывает при добавлении сообщения. }
    //FOnMessageX: TProcMessageX;
    function GetConfig(): IProfNode; safecall;
    procedure SetConfig(const Value: IProfNode); safecall;
  protected
      //** Срабатывает при добавлении сообщения
    function DoAddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; virtual; safecall;
      //** Срабатывает после создания
    procedure DoCreated(); virtual;
      //** Срабатывает при уничтожении
    procedure DoDestroy(); override;
      //** Срабатывает при финализации
    function DoFinalize(): AError; virtual;
      //** Срабатывает при инициализации
    function DoInitialize(): AError; virtual;
      //** Срабатывает при добавлении сообщения
    function DoMessage(const AMsg: WideString): Integer; virtual;
  public
      //** Добавляет сообщение
    function AddMessage(const AMsg: WideString): Integer; virtual;
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
    function ConfigureLoad(AConfig: IProfNode = nil): AError; virtual;
      //** Созранить конфигурации
    function ConfigureSave(AConfig: IProfNode = nil): AError; virtual;
      //** Финализирует
    function Finalize(): TProfError; virtual;
      //** Инициализирует
    function Initialize(): TProfError; virtual;
  public
      //** Конфигурации в виде XML
    property Config: IProfNode read FConfig write FConfig;
      //** Инициализорован
    property Initialized: WordBool read FIsInitialized;
      //** Объект для записи лог-сообщений
    property Log: TALogNode read FLog write FLog;
      //** CallBack функция. Срабатывает при добавлении лог-сообщения.
    property OnAddToLog: TAddToLogProc read FOnAddToLog write FOnAddToLog;
      //** CallBack функция. Срабатывает при добавлении сообщения.
    property OnMessage: TProcMessageStr read FOnMessage write FOnMessage;
  end;

resourcestring // Сообщения ----------------------------------------------------
  stCreateOk = 'Объект создан';

const
  //** @abstract(Состояние окна)
  WINDOW_STATE: array[TWindowState] of string = ('Normal', 'Minimized', 'Maximized');
*)

implementation

(*
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

function TProfForm.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AMsg: WideString): Integer;
begin
  Result := DoAddToLog(AGroup, AType, AMsg);
end;

function TProfForm.ConfigureLoad(AConfig: IProfNode): AError;
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

  if not(Assigned(tmpConfig)) then
  begin
    Result := -2;
    Exit;
  end;

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
  Result := 0;
end;

function TProfForm.ConfigureSave(AConfig: IProfNode): AError;
var
  tmpConfig: IProfNode;
begin
  if Assigned(AConfig) then
    tmpConfig := AConfig
  else
    tmpConfig := AConfig;

  if not(Assigned(tmpConfig)) then
  begin
    Result := -2;
    Exit;
  end;
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
  Result := 0;
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

function TProfForm.DoFinalize(): AError;
begin
  FIsInitialized := False;
  FConfig := nil;
  //FConfigDocument := nil;
  FLog := nil;
  Result := 0;
end;

function TProfForm.DoInitialize(): AError;
begin
  FIsInitialized := True;
  Result := 0;
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
  Result := DoFinalize();
end;

function TProfForm.GetConfig(): IProfNode;
begin
  Result := FConfig;
end;

function TProfForm.Initialize(): TProfError;
begin
  Result := DoInitialize();
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
*)

{ TProfFormI }

function TProfFormI.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
  const StrMsg: WideString): AInt;
begin
  Result := FForm.AddToLog(LogGroup, LogType, StrMsg);
end;

function TProfFormI.ConfigureLoad(Config: AConfig{IProfNode}): AError;
begin
  Result := FForm.ConfigureLoad2(Config);
end;

function TProfFormI.ConfigureSave(Config: AConfig{IProfNode}): AError;
begin
  Result := FForm.ConfigureSave2(Config);
end;

function TProfFormI.Finalize(): AError;
begin
  Result := FForm.Finalize();
end;

function TProfFormI.GetConfig(): AConfig{IProfNode};
begin
  Result := FForm.GetConfig();
end;

function TProfFormI.Initialize(): AError;
begin
  Result := FForm.Initialize();
end;

procedure TProfFormI.SetConfig(const Value: AConfig{IProfNode});
begin
  FForm.SetConfig(Value);
end;

end.
