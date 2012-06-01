{**
@Abstract(Работа с Log. Классы для записи собщений программы в БД или файл или отображения в окне Log)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.08.2005)
@LastMod(02.05.2012)
@Version(0.5)

TLogNode - нод логирования - элемент дерева логирования
Delphi 5, 7, 2005
}
unit ALogGlobals2006;

interface

uses
  ComObj, SysUtils,
  ALogDocumentIntf, ALogNodeIntf, AMessageConst, ATypes;

{type // Статус нода логирования
  TLogNodeStatus = ATypes.TLogNodeStatus;
  //TLogNodeStatusSet = ProfTypes.TLogNodeStatusSet;}

{type // Тип логирования
  TLogType = ATypes.TLogType;
  TLogTypeSet = ATypes.TLogTypeSet;}

const
  int_lDocuments = 1;   // TLogDocuments - записывает сразу в несколько мест
  int_lFile      = 2;   // Записывать в файл
  int_lWindow    = 4;   // Показывать в окне
  int_lLogSystem = 8;   // Подключаться к сервису логирования AR_LogSystem
  int_lProgram   = 16;  // Выводить в лог программы (класс TProgram)
  int_lUnknown   = 32;  // Uncnown

type // Конфигурации документа логирования -------------------------------------
  TConfigLogDocument = class
  end;

type
  TLogDocument = class;
  TLogNode = class;

  TLogNode = class({TProfObject}TInterfacedObject, ILogNode2)
  private
    FDTCreate: TDateTime;     // Дата создания
    FId: Integer;             // Id
    FMsg: WideString;         // Сообщение
    FParams: WideString;      // Параметры в виде XML
    FType: TLogTypeMessage;   // Тип сообщения
    FGroup: TLogGroupMessage; // Группа сообщения
  private
    FLogDoc: TLogDocument;    // Документ логирования к которому принадлежит этот нод
    //FNodes: array of Integer; // Дочерние ноды
    FParent: Integer;         // Родительский нод
    FStatus: TLogNodeStatus;  // Статус нода
  protected // ILogNode2
    procedure SetStatus(Value: TLogNodeStatus);
    function Get_Document(): ILogDocument2;
    function Get_GroupEnum(): EnumGroupMessage;
    function Get_Id(): Integer;
    function Get_LogDocument(): ILogDocument2;
    function Get_LogType(): EnumTypeMessage;
    function Get_Parent(): Integer;
    function Get_StatusEnum(): StatusNodeEnum{EnumStatusNode};
    function Get_StrMsg(): WideString;
    procedure Set_GroupEnum(Value: EnumGroupMessage);
    procedure Set_Id(Value: Integer);
    procedure Set_LogDocument(const Value: ILogDocument2);
    procedure Set_LogType(Value: EnumTypeMessage);
    procedure Set_Parent(Value: Integer);
    procedure Set_StatusEnum(Value: StatusNodeEnum{EnumStatusNode});
    procedure Set_StrMsg(const Value: WideString);
  public // ILogNode2
    procedure AddMsg(const AMsg: WideString); safecall;
    procedure AddStr(const AStr: WideString); safecall;
    procedure Hide(); virtual; safecall;
    procedure Show(); virtual; safecall;
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; virtual; safecall;
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer; virtual; safecall;
  public
    property Id: Integer read Get_Id write Set_Id;
    property Msg: WideString read FMsg write FMsg;
    property Params: WideString read FParams write FParams;
    //property Group: TLogGroupMessage read FGroup write FGroup;
    property Typ: TLogTypeMessage read FType write FType;
  public
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean; virtual;
    constructor Create(ALogDoc: TLogDocument; AParent: Integer; ALogPrefix: string; AId: Integer);
    procedure Free(); virtual;
    function Prefix(): string;
    property Status: TLogNodeStatus read FStatus write SetStatus;
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer; virtual;
  end;

  TLogDocument = class(TLogNode, ILogDocument2)
  private
    FAddToLog: TAddToLog;
    FConfig: TConfigLogDocument;
    FLogType: TLogType;
    FOnCommand: TProfMessage;
  protected
    procedure SetOnCommand(Value: TProfMessage); virtual;
  public
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean; override;
      //** Загрузить конфигурации
    function ConfigureLoad(): WordBool; virtual;
      //** Сохранить конфигурации
    function ConfigureSave(): WordBool; virtual;
    constructor Create(ALogType: TLogType; AName: WideString = ''; AParent: TLogDocument = nil);
      //** Должен финализировать
    function Finalize(): TProfError; virtual;
    function GetNodeById(Id: Integer): TLogNode; virtual;
      //** Должен инициализировать
    function Initialize(): TProfError; virtual;
      //** Тип лог-документа
    function NewNode(AType: TLogTypeMessage; const APrefix: WideString; AParent: Integer = 0; AId: Integer = 0): TLogNode; virtual;
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer; override;
  published
    property Config: TConfigLogDocument read FConfig write FConfig;
    property LogType: TLogType read FLogType;
    property OnAddToLog: TAddToLog read FAddToLog write FAddToLog;
    property OnCommand: TProfMessage read FOnCommand write SetOnCommand;
  end;

type // Документ записи/обображения Log
  TLogDocumentA = class(TLogDocument)
  private
    FNodes: array of TLogNode;
  public
    function GetNodeById(Id: Integer): TLogNode; override;
    function NewNode(AType: TLogTypeMessage; const AMsg: WideString; AParent: Integer = 0; AId: Integer = 0): TLogNode; override;
    function AddNode(ANode: TLogNode): Boolean;
    function GetFreeId(): Integer;
  end;

const // -----------------------------------------------------------------------
  OLE_MESSAGE_GROUP: array[TLogGroupMessage] of EnumGroupMessage = (
      elgNone, elgNetwork, elgSetup, elgGeneral, elgDataBase, elgKey, elgEquipment, elgAlgorithm, elgSystem, elgUser, elgAgent
    );
  OLE_MESSAGE_TYPE: array[TLogTypeMessage] of EnumTypeMessage = (eltNone, eltError, eltWarning, eltInformation);
  OLE_NODE_STATUS: array[TLogNodeStatus] of StatusNodeEnum = (elsNone, elsOk, elsCancel, elsError, elsWarning, elsInformation);
  INT_LOG_TYPE: array[TLogType] of Integer = (
      int_lDocuments, int_lFile, int_lWindow, int_lLogSystem, int_lProgram, int_lTreeView, int_lUnknown
    );

function IntToLogTypeSet(Value: Integer): TLogTypeSet;

implementation

// -----------------------------------------------------------------------------
function IntToLogTypeSet(Value: Integer): TLogTypeSet;
var
  tmp: TLogType;
begin
  Result := [];
  for tmp := Low(TLogType) to High(TLogType) do
    if (INT_LOG_TYPE[tmp] and Value = INT_LOG_TYPE[tmp]) then
      Result := Result + [tmp];
end;

{ TLogDocument }

function TLogDocument.AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
begin
  if Assigned(FAddToLog) then
    Result := FAddToLog(AGroup, AType, AStrMsg, AParams)
  else
    Result := False;
end;

function TLogDocument.ConfigureLoad(): WordBool;
begin
  Result := Assigned(FConfig);
end;

function TLogDocument.ConfigureSave(): WordBool;
begin
  Result := Assigned(FConfig);
end;

constructor TLogDocument.Create(ALogType: TLogType; AName: WideString = ''; AParent: TLogDocument = nil);
begin
  inherited Create(AParent, 0, AName, 0);
end;

function TLogDocument.Finalize(): TProfError;
begin
  Result := 0;
end;

function TLogDocument.GetNodeById(Id: Integer): TLogNode;
begin
  Result := nil;
end;

function TLogDocument.Initialize(): TProfError;
begin
  Result := 0;
end;

function TLogDocument.NewNode(AType: TLogTypeMessage; const APrefix: WideString; AParent: Integer = 0; AId: Integer = 0): TLogNode;
begin
  Result := nil;
end;

procedure TLogDocument.SetOnCommand(Value: TProfMessage);
begin
  FOnCommand := Value;
end;

function TLogDocument.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := -1;
end;

{ TLogDocumentA }

function TLogDocumentA.AddNode(ANode: TLogNode): Boolean;
var
  I: Integer;
begin
  I := Length(FNodes);
  SetLength(FNodes, I + 1);
  FNodes[I] := ANode;
  Result := True;
end;

function TLogDocumentA.GetFreeId: Integer;
begin
  Result := Length(FNodes) + 1;
end;

function TLogDocumentA.GetNodeById(Id: Integer): TLogNode;
var
  I: Integer;
begin
  for I := 0 to High(FNodes) do if FNodes[I].Id = Id then
  begin
    Result := FNodes[I];
    Exit;
  end;
  Result := nil;
end;

function TLogDocumentA.NewNode(AType: TLogTypeMessage; const AMsg: WideString; AParent: Integer = 0; AId: Integer = 0): TLogNode;
var
  S: string;
begin
  DateTimeToString(S, 'dd.mm.yyyy hh:mm:ss', Now);
  S := S + ' ' + AMsg;
  if AId = 0 then AId := GetFreeId;
  Result := TLogNode.Create(Self, AParent, S, AId);
  AddNode(Result);
end;

{ TLogNode }

procedure TLogNode.AddMsg(const AMsg: WideString);
begin
  if Assigned(FLogDoc) then
    FLogDoc.AddMsg(AMsg);
end;

procedure TLogNode.AddStr(const AStr: WideString);
begin
  if Assigned(FLogDoc) then
    FLogDoc.AddStr(AStr);
end;

function TLogNode.AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
begin
  Result := (ToLog(AGroup, AType, AStrMsg, AParams) > 0);
end;

constructor TLogNode.Create(ALogDoc: TLogDocument; AParent: Integer; ALogPrefix: string; AId: Integer);
begin
  inherited Create();
  FDTCreate := Now;
  FId := AId;
  FLogDoc := ALogDoc;
  FParent := AParent;
  FMsg := ALogPrefix;
  FStatus := lsNone;
end;

procedure TLogNode.Free();
begin
  inherited Free;
end;

function TLogNode.Get_Document(): ILogDocument2;
begin
  Result := FLogDoc;
end;

function TLogNode.Get_GroupEnum(): EnumGroupMessage;
begin
  Result := OLE_MESSAGE_GROUP[FGroup];
end;

function TLogNode.Get_Id(): Integer;
begin
  Result := FId;
end;

function TLogNode.Get_LogDocument(): ILogDocument2;
begin
  Result := FLogDoc;
end;

function TLogNode.Get_LogType(): EnumTypeMessage;
begin
  Result := OLE_MESSAGE_TYPE[FType];
end;

function TLogNode.Get_Parent(): Integer;
begin
  Result := FParent;
end;

function TLogNode.Get_StatusEnum: StatusNodeEnum;
begin
  Result := OLE_NODE_STATUS[FStatus];
end;

{function TLogNode.Get_StatusEnum: EnumStatusNode;
begin
end;}

function TLogNode.Get_StrMsg: WideString;
begin
  Result := FMsg;
end;

procedure TLogNode.Hide;
begin
end;

function TLogNode.Prefix(): string;
begin
  if FMsg <> '' then Result := FMsg + ': ' else Result := '';
end;

procedure TLogNode.SetStatus(Value: TLogNodeStatus);
begin
  FStatus := Value;
end;

procedure TLogNode.Set_GroupEnum(Value: EnumGroupMessage);
var
  Group: TLogGroupMessage;
begin
  for Group := Low(TLogGroupMessage) to High(TLogGroupMessage) do
    if OLE_MESSAGE_GROUP[Group] = Value then
      FGroup := Group;
end;

procedure TLogNode.Set_Id(Value: Integer);
begin
  FId := Value;
end;

procedure TLogNode.Set_LogDocument(const Value: ILogDocument2);
begin
  FLogDoc := TLogDocument(Value);
end;

procedure TLogNode.Set_LogType(Value: EnumTypeMessage);
var
  Typ: TLogTypeMessage;
begin
  for Typ := Low(TLogTypeMessage) to High(TLogTypeMessage) do
    if OLE_MESSAGE_TYPE[Typ] = Value then begin
      FType := Typ;
      Exit;
    end;
end;

procedure TLogNode.Set_Parent(Value: Integer);
begin
  FParent := Value;
end;

procedure TLogNode.Set_StatusEnum(Value: StatusNodeEnum);
var
  Status: TLogNodeStatus;
begin
  for Status := Low(TLogNodeStatus) to High(TLogNodeStatus) do
    if OLE_NODE_STATUS[Status] = Value then begin
      FStatus := Status;
      Exit;
    end;
end;

{procedure TLogNode.Set_StatusEnum(Value: EnumStatusNode);
begin
end;}

procedure TLogNode.Set_StrMsg(const Value: WideString);
begin
  FMsg := Value;
end;

procedure TLogNode.Show;
begin
end;

function TLogNode.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
begin
  try
    if Assigned(FLogDoc) then
      Result := FLogDoc.ToLog(AGroup, AType, lcNewNode, [Self.Id, Format(AStrMsg, AParams)])
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function TLogNode.ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  try
    if Assigned(FLogDoc) then
      Result := FLogDoc.ToLogA(AGroup, AType, AStrMsg)
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function TLogNode.ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer;
begin
  try
    if Assigned(FLogDoc) then
      Result := FLogDoc.ToLogE(AGroup, AType, AStrMsg)
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

end.
