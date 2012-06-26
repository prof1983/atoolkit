{**
@Abstract(Реализация интерфейсов ILogNode и IProfLogNode)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.08.2005)
@LastMod(13.06.2012)
@Version(0.5)
}
unit ALogNodeImpl;

interface

uses
  SysUtils,
  ALogDocumentIntf, ALogGlobals, ALogNodeIntf, ANodeImpl, AMessageConst, AObjectImpl, ATypes;

type //** Нод логирования - элемент дерева логирования
  TALogNode = class(TProfNode, IProfLogNode)
  protected
      //** Дата создания
    FDTCreate: TDateTime;
      //** ID
    //FID: Integer; -> TProfEntity
      //** Сообщение
    FMsg: WideString;
      //** Параметры в виде XML
    FParams: WideString;
      //** Тип сообщения
    FType: TLogTypeMessage;
      //** Группа сообщения
    FGroup: TLogGroupMessage;
  protected
      //** Родительский нод логирования к которому принадлежит этот нод
    FParent: IProfLogNode;
      //** Документ логирования к которому принадлежит этот нод
    //FLogDoc: ILogDocument;
      //** Родительский нод
    //FParent: Integer;
      //** Статус нода
    FStatus: TLogNodeStatus;
  protected
    procedure SetStatus(Value: TLogNodeStatus);
    function Get_Document(): IProfLogNode; safecall;
    function Get_LogDocument(): IProfLogNode; safecall;
    function Get_Parent(): Integer; safecall;
    function Get_StrMsg(): WideString; safecall;
    procedure Set_LogDocument(const Value: IProfLogNode); safecall;
    procedure Set_Parent(Value: Integer); safecall;
    procedure Set_StrMsg(const Value: WideString); safecall;
  public
      {** Добавить сообщение
          @returns(Возвращает номер добавленого сообщения или 0) }
    function AddMsg(const AMsg: WideString): Integer; virtual; safecall;
      {** Добавить строку
          @returns(Возвращает номер добавленой строки или 0) }
    function AddStr(const AStr: WideString): Integer; virtual; safecall;
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; override;
    procedure Hide(); virtual; safecall;
    function Prefix(): string;
    procedure Show(); virtual; safecall;
  public
    constructor Create(ALogDoc: IProfLogNode; ALogPrefix: string; AID: Integer);
  public
    property Msg: WideString read FMsg write FMsg;
    property Params: WideString read FParams write FParams;
    property Group: TLogGroupMessage read FGroup write FGroup;
    property Status: TLogNodeStatus read FStatus write SetStatus;
    property Typ: TLogTypeMessage read FType write FType;
  end;

  TALogNode2 = class(TInterfacedObject{TProfObject2}, ILogNode2)
  protected
      {** Дата создания }
    FDTCreate: TDateTime;
      {** Identifier }
    FId: Integer;
      {** Сообщение }
    FMsg: WideString;
      {** Параметры в виде XML }
    FParams: WideString;
      {** Тип сообщения }
    FType: TLogTypeMessage;
      {** Группа сообщения }
    FGroup: TLogGroupMessage;
  protected
      {** Документ логирования к которому принадлежит этот нод }
    FLogDoc: ALogDocument2;
      // Дочерние ноды
    //FNodes: array of Integer;
      {** Родительский нод }
    FParent: Integer;
      {** Статус нода }
    FStatus: TLogNodeStatus;
  protected
    procedure SetStatus(Value: TLogNodeStatus);
    function Get_Document(): ILogDocument2;
    function Get_GroupEnum(): EnumGroupMessage;
    function Get_Id(): Integer;
    function Get_LogDocument(): ILogDocument2;
    function Get_LogType(): EnumTypeMessage;
    function Get_Parent(): Integer;
    function Get_StatusEnum(): StatusNodeEnum;
    function Get_StrMsg(): WideString;
    procedure Set_GroupEnum(Value: EnumGroupMessage);
    procedure Set_Id(Value: Integer);
    procedure Set_LogDocument(const Value: ILogDocument2);
    procedure Set_LogType(Value: EnumTypeMessage);
    procedure Set_Parent(Value: Integer);
    procedure Set_StatusEnum(Value: StatusNodeEnum);
    procedure Set_StrMsg(const Value: WideString);
  public
    procedure AddStr(const AStr: WideString); virtual;
    procedure AddMsg(const AMsg: WideString); virtual;
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: WideString): Integer; virtual;
    function AddToLog2(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: string; Params: array of const): Boolean; virtual;
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; virtual;
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; virtual;
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer; virtual;
  public
    constructor Create(LogDoc: ALogDocument2; Parent: Integer; LogPrefix: string; Id: Integer);
    procedure Hide(); virtual;
    procedure Show(); virtual;
    function Prefix(): string;
  public
    property Id: Integer read Get_Id write Set_Id;
    property Msg: WideString read FMsg write FMsg;
    property Params: WideString read FParams write FParams;
    property Group: TLogGroupMessage read FGroup write FGroup;
    property Status: TLogNodeStatus read FStatus write SetStatus;
    property Typ: TLogTypeMessage read FType write FType;
  end;

  //TALogNode2006 = TALogNode2;
  //TALogNode3 = TALogNode;
  //TLogNode = TALogNode;
  //TProfLogNode3 = TALogNode3;

implementation

uses
  ALogDocumentImpl;

{ TLogNode }

function TALogNode.AddMsg(const AMsg: WideString): Integer;
begin
  if Assigned(FParent) then
    FParent.AddMsg(AMsg);
end;

function TALogNode.AddStr(const AStr: WideString): Integer;
begin
  if Assigned(FParent) then
    FParent.AddStr(AStr);
end;

function TALogNode.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  Result := -1;
  if Assigned(FParent) then
  try
    Result := FParent.AddToLog(AGroup, AType, AStrMsg);
  except
  end;
end;

constructor TALogNode.Create(ALogDoc: IProfLogNode; ALogPrefix: string; AID: Integer);
begin
  inherited Create();
  FDTCreate := Now;
  FID := AID;
  FParent := ALogDoc;
  FMsg := ALogPrefix;
  FStatus := lsNone;
end;

function TALogNode.Get_Document(): IProfLogNode;
begin
  Result := FParent;
end;

function TALogNode.Get_LogDocument(): IProfLogNode;
begin
  Result := FParent;
end;

function TALogNode.Get_Parent(): Integer;
begin
  Result := 0;
end;

function TALogNode.Get_StrMsg(): WideString;
begin
  Result := FMsg;
end;

procedure TALogNode.Hide();
begin
end;

function TALogNode.Prefix(): string;
begin
  if FMsg <> '' then Result := FMsg + ': ' else Result := '';
end;

procedure TALogNode.SetStatus(Value: TLogNodeStatus);
begin
  FStatus := Value;
end;

procedure TALogNode.Set_LogDocument(const Value: IProfLogNode);
begin
  FParent := Value;
end;

procedure TALogNode.Set_Parent(Value: Integer);
begin
end;

procedure TALogNode.Set_StrMsg(const Value: WideString);
begin
  FMsg := Value;
end;

procedure TALogNode.Show();
begin
end;

{ TLogNode2 }

procedure TALogNode2.AddMsg(const AMsg: WideString);
var
  LogDoc: TALogDocument2;
begin
  if Assigned(TObject(LogDoc)) then
  begin
    LogDoc := TObject(FLogDoc) as TALogDocument2;
    LogDoc.AddMsg(AMsg);
  end;
end;

procedure TALogNode2.AddStr(const AStr: WideString);
var
  LogDoc: TALogDocument2;
begin
  if Assigned(TObject(FLogDoc)) then
  begin
    LogDoc := TALogDocument2(FLogDoc);
    LogDoc.AddStr(AStr);
  end;
end;

function TALogNode2.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: WideString): Integer;
begin
  Result := ToLogA(LogGroup, LogType, StrMsg);
end;

function TALogNode2.AddToLog2(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: string; Params: array of const): Boolean;
begin
  Result := (ToLog(LogGroup, LogType, StrMsg, Params) > 0);
end;

constructor TALogNode2.Create(LogDoc: ALogDocument2; Parent: Integer; LogPrefix: string; Id: Integer);
begin
  inherited Create();
  FDTCreate := Now;
  FId := Id;
  FLogDoc := LogDoc;
  FParent := Parent;
  FMsg := LogPrefix;
  FStatus := lsNone;
end;

function TALogNode2.Get_Document(): ILogDocument2;
var
  LogDoc: TALogDocument2;
begin
  if not(Assigned(TObject(FLogDoc))) then
  begin
    Result := nil;
    Exit;
  end;

  LogDoc := TALogDocument2(FLogDoc);
  Result := ILogDocument2(LogDoc);
end;

function TALogNode2.Get_GroupEnum(): EnumGroupMessage;
begin
  Result := OLE_GROUP_MESSAGE[FGroup];
end;

function TALogNode2.Get_Id(): Integer;
begin
  Result := FId;
end;

function TALogNode2.Get_LogDocument(): ILogDocument2;
begin
  Result := Get_Document();
end;

function TALogNode2.Get_LogType(): EnumTypeMessage;
begin
  Result := OLE_TYPE_MESSAGE[FType];
end;

function TALogNode2.Get_Parent(): Integer;
begin
  Result := FParent;
end;

function TALogNode2.Get_StatusEnum: StatusNodeEnum;
begin
  Result := OLE_NODE_STATUS[FStatus];
end;

function TALogNode2.Get_StrMsg: WideString;
begin
  Result := FMsg;
end;

procedure TALogNode2.Hide();
begin
end;

function TALogNode2.Prefix(): string;
begin
  if (FMsg <> '') then
    Result := FMsg + ': '
  else
    Result := '';
end;

procedure TALogNode2.SetStatus(Value: TLogNodeStatus);
begin
  FStatus := Value;
end;

procedure TALogNode2.Set_GroupEnum(Value: EnumGroupMessage);
var
  Group: TLogGroupMessage;
begin
  for Group := Low(TLogGroupMessage) to High(TLogGroupMessage) do
  begin
    if OLE_GROUP_MESSAGE[Group] = Value then
      FGroup := Group;
  end;
end;

procedure TALogNode2.Set_Id(Value: Integer);
begin
  FId := Value;
end;

procedure TALogNode2.Set_LogDocument(const Value: ILogDocument2);
begin
  //FLogDoc := Value;
end;

procedure TALogNode2.Set_LogType(Value: EnumTypeMessage);
var
  Typ: TLogTypeMessage;
begin
  for Typ := Low(TLogTypeMessage) to High(TLogTypeMessage) do
  begin
    if OLE_MESSAGE_TYPE[Typ] = Value then
    begin
      FType := Typ;
      Exit;
    end;
  end;
end;

procedure TALogNode2.Set_Parent(Value: Integer);
begin
  FParent := Value;
end;

procedure TALogNode2.Set_StatusEnum(Value: StatusNodeEnum);
var
  Status: TLogNodeStatus;
begin
  for Status := Low(TLogNodeStatus) to High(TLogNodeStatus) do
  begin
    if OLE_NODE_STATUS[Status] = Value then
    begin
      FStatus := Status;
      Exit;
    end;
  end;
end;

procedure TALogNode2.Set_StrMsg(const Value: WideString);
begin
  FMsg := Value;
end;

procedure TALogNode2.Show();
begin
end;

function TALogNode2.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := ToLogA(AGroup, AType, Format(lcNewNode, [Self.ID, Format(AStrMsg, AParams)]));
end;

function TALogNode2.ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString): Integer;
var
  LogDoc: TALogDocument2;
begin
  if not(Assigned(TObject(FLogDoc))) then
  begin
    Result := -2;
    Exit;
  end;

  try
    LogDoc := TALogDocument2(FLogDoc);
    Result := LogDoc.ToLogA(AGroup, AType, AStrMsg)
  except
    Result := -1;
  end;
end;

function TALogNode2.ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
    const AStrMsg: WideString): Integer;
var
  LogDoc: TALogDocument2;
begin
  if not(Assigned(TObject(LogDoc))) then
  begin
    Result := -2;
    Exit;
  end;

  try
    LogDoc := TALogDocument2(FLogDoc);
    Result := LogDoc.ToLogE(AGroup, AType, AStrMsg);
  except
    Result := -1;
  end;
end;

end.