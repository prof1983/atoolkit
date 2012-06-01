{**
@Abstract(Реализация интерфейсов ILogNode и IProfLogNode)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.08.2005)
@LastMod(26.04.2012)
@Version(0.5)
}
unit ALogNodeImpl;

interface

uses
  SysUtils,
  ALogDocumentIntf, ALogGlobals, ALogNodeIntf, ANodeImpl, AMessageConst, AObjectImpl, ATypes;

type //** Нод логирования - элемент дерева логирования
  TALogNode = class(TProfNode, IProfLogNode)
  private
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
  private
      //** Родительский нод логирования к которому принадлежит этот нод
    FParent: IProfLogNode;
      //** Документ логирования к которому принадлежит этот нод
    //FLogDoc: ILogDocument;
      //** Родительский нод
    //FParent: Integer;
      //** Статус нода
    FStatus: TLogNodeStatus;
  protected
    //function Get_Collection: IProfXmlNodeCollection; safecall;
    procedure SetStatus(Value: TLogNodeStatus);
    {$IFNDEF CLR} //{$IFNDEF VER170}
    function Get_Document(): IProfLogNode; safecall;
    //function Get_GroupEnum(): EnumGroupMessage; safecall;
    //function GetID(): Integer; safecall;
    function Get_LogDocument(): IProfLogNode; safecall;
    //function Get_LogType(): EnumTypeMessage; safecall;
    function Get_Parent(): Integer; safecall;
    //function Get_StatusEnum(): StatusNodeEnum; safecall;
    function Get_StrMsg(): WideString; safecall;
    //procedure Set_GroupEnum(Value: EnumGroupMessage); safecall;
    //procedure SetID(Value: Integer); safecall;
    procedure Set_LogDocument(const Value: IProfLogNode); safecall;
    //procedure Set_LogType(Value: EnumTypeMessage); safecall;
    procedure Set_Parent(Value: Integer); safecall;
    //procedure Set_StatusEnum(Value: StatusNodeEnum); safecall;
    procedure Set_StrMsg(const Value: WideString); safecall;
    {$ELSE}
    function Get_Document(): ILogDocument;
    function Get_GroupEnum(): EnumGroupMessage;
    function Get_ID(): Integer;
    function Get_LogDocument(): ILogDocument;
    function Get_LogType(): EnumTypeMessage;
    function Get_Parent(): Integer;
    function Get_StatusEnum(): EnumStatusNode;
    function Get_StrMsg(): WideString;
    procedure Set_GroupEnum(Value: EnumGroupMessage);
    procedure Set_ID(Value: Integer);
    procedure Set_LogDocument(const Value: ILogDocument);
    procedure Set_LogType(Value: EnumTypeMessage);
    procedure Set_Parent(Value: Integer);
    procedure Set_StatusEnum(Value: EnumStatusNode);
    procedure Set_StrMsg(const Value: WideString);
    {$ENDIF}
  public
    function AddMsg(const AMsg: WideString): Integer; virtual; safecall;
    function AddStr(const AStr: WideString): Integer; virtual; safecall;
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; override;
  public
    constructor Create(ALogDoc: IProfLogNode; ALogPrefix: string; AID: Integer);
    destructor Destroy(); override;
    procedure Hide(); virtual; safecall;
    procedure Show(); virtual; safecall;
    function Prefix(): string;
  public
    property Status: TLogNodeStatus read FStatus write SetStatus;
  public
    //property ID: Integer read GetID write SetID; -> TProfEntity
    property Msg: WideString read FMsg write FMsg;
    property Params: WideString read FParams write FParams;
    property Group: TLogGroupMessage read FGroup write FGroup;
    property Typ: TLogTypeMessage read FType write FType;
  end;

type
  TALogNode2 = class(TProfObject2, ILogNode2)
  private
    //** Дата создания
    FDTCreate: TDateTime;
    //** ID
    FID: Integer;
    //** Сообщение
    FMsg: WideString;
    //** Параметры в виде XML
    FParams: WideString;
    //** Тип сообщения
    FType: TLogTypeMessage;
    //** Группа сообщения
    FGroup: TLogGroupMessage;
  private
    //** Документ логирования к которому принадлежит этот нод
    FLogDoc: ILogDocument2;
    //FNodes: array of Integer; // Дочерние ноды
    //** Родительский нод
    FParent: Integer;
    //** Статус нода
    FStatus: TLogNodeStatus;
  protected
    //function Get_Collection: IProfXmlNodeCollection; safecall;
    procedure SetStatus(Value: TLogNodeStatus);
    function Get_Document(): ILogDocument2;
    function Get_GroupEnum(): EnumGroupMessage;
    function Get_ID(): Integer;
    function Get_LogDocument(): ILogDocument2;
    function Get_LogType(): EnumTypeMessage;
    function Get_Parent(): Integer;
    function Get_StatusEnum(): StatusNodeEnum;
    function Get_StrMsg(): WideString;
    procedure Set_GroupEnum(Value: EnumGroupMessage);
    procedure Set_ID(Value: Integer);
    procedure Set_LogDocument(const Value: ILogDocument2);
    procedure Set_LogType(Value: EnumTypeMessage);
    procedure Set_Parent(Value: Integer);
    procedure Set_StatusEnum(Value: StatusNodeEnum);
    procedure Set_StrMsg(const Value: WideString);
  public
    property ID: Integer read Get_ID write Set_ID;
    property Msg: WideString read FMsg write FMsg;
    property Params: WideString read FParams write FParams;
    property Group: TLogGroupMessage read FGroup write FGroup;
    property Typ: TLogTypeMessage read FType write FType;
  public
    procedure AddStr(const AStr: WideString); virtual; safecall;
    procedure AddMsg(const AMsg: WideString); virtual; safecall;
    {function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override; safecall;
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Boolean; override; //virtual;}
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; override; //virtual;
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override; {$IFNDEF CLR}safecall;{$ENDIF}
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer; override; {$IFNDEF CLR}safecall;{$ENDIF}
  public
    constructor Create(ALogDoc: ILogDocument2; AParent: Integer; ALogPrefix: string; AID: Integer);
    destructor Destroy(); override;
    procedure Free(); override;
    procedure Hide(); virtual; safecall;
    procedure Show(); virtual; safecall;
    function Prefix(): string;
    property Status: TLogNodeStatus read FStatus write SetStatus;
  end;

type // Нод логирования - элемент дерева логирования
  TALogNode3 = class(TProfNode, IProfLogNode)
  private
      // Дата создания
    //FDTCreate: TDateTime;
      // Id
    //FID: Integer;
      // Сообщение
    FMsg: WideString;
      // Параметры в виде XML
    FParams: WideString;
      // Тип сообщения
    FType: TLogTypeMessage;
      // Группа сообщения
    FGroup: TLogGroupMessage;
  private
      // Родительский нод логирования к которому принадлежит этот нод
    FParent: IProfLogNode;
      // Документ логирования к которому принадлежит этот нод
    //FLogDoc: ILogDocument;
    //FNodes: array of Integer; // Дочерние ноды
      // Родительский нод
    //FParent: Integer;
      // Статус нода
    FStatus: TLogNodeStatus;
  protected
    //function Get_Collection: IProfXmlNodeCollection; safecall;
    procedure SetStatus(Value: TLogNodeStatus);
    {$IFNDEF CLR} //{$IFNDEF VER170}
    //function Get_LogType(): EnumTypeMessage; safecall;
    function Get_Parent(): Integer; safecall;
    //function Get_StatusEnum(): StatusNodeEnum; safecall;
    function Get_StrMsg(): WideString; safecall;
    //procedure Set_GroupEnum(Value: EnumGroupMessage); safecall;
    //procedure Set_LogType(Value: EnumTypeMessage); safecall;
    procedure Set_Parent(Value: Integer); safecall;
    //procedure Set_StatusEnum(Value: StatusNodeEnum); safecall;
    procedure Set_StrMsg(const Value: WideString); safecall;
    {$ELSE}
    function Get_LogType(): EnumTypeMessage;
    function Get_Parent(): Integer;
    function Get_StatusEnum(): EnumStatusNode;
    function Get_StrMsg(): WideString;
    procedure Set_GroupEnum(Value: EnumGroupMessage);
    procedure Set_LogType(Value: EnumTypeMessage);
    procedure Set_Parent(Value: Integer);
    procedure Set_StatusEnum(Value: EnumStatusNode);
    procedure Set_StrMsg(const Value: WideString);
    {$ENDIF}
  public
      { Добавить сообщение
        @returns(Возвращает номер добавленого сообщения или 0) }
    function AddMsg(const AMsg: WideString): Integer; virtual; safecall;
      { Добавить строку
        @returns(Возвращает номер добавленой строки или 0) }
    function AddStr(const AStr: WideString): Integer; virtual; safecall;
    //function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; override; safecall;
  public
    //constructor Create(ALogDoc: ILogDocument; AParent: Integer; ALogPrefix: string; AID: Integer);
    //destructor Destroy(); override;
    //procedure Free(); override;
    procedure Hide(); virtual; safecall;
    procedure Show(); virtual; safecall;
    function Prefix(): string;
  public
    property Status: TLogNodeStatus read FStatus write SetStatus;
  public
    property Msg: WideString read FMsg write FMsg;
    property Params: WideString read FParams write FParams;
    property Group: TLogGroupMessage read FGroup write FGroup;
    property Typ: TLogTypeMessage read FType write FType;
  end;

type
  TLogNode = TALogNode;
  TProfLogNode3 = TALogNode3;

implementation

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

destructor TALogNode.Destroy();
begin
  inherited Destroy();
end;

{function TLogNode.GetID(): Integer;
begin
  Result := FId;
end;}

function TALogNode.Get_Document(): IProfLogNode;
begin
  Result := FParent;
end;

{function TLogNode.Get_GroupEnum(): EnumGroupMessage;
begin
  Result := OLE_GROUP_MESSAGE[FGroup];
end;}

function TALogNode.Get_LogDocument(): IProfLogNode;
begin
  Result := FParent;
end;

{function TLogNode.Get_LogType(): EnumTypeMessage;
begin
  Result := OLE_TYPE_MESSAGE[FType];
end;}

function TALogNode.Get_Parent(): Integer;
begin
  Result := 0;
end;

{function TLogNode.Get_StatusEnum: StatusNodeEnum;
begin
  Result := OLE_NODE_STATUS[FStatus];
end;}

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

{procedure TLogNode.SetID(Value: Integer);
begin
  FId := Value;
end;}

procedure TALogNode.SetStatus(Value: TLogNodeStatus);
begin
  FStatus := Value;
end;

{procedure TLogNode.Set_GroupEnum(Value: EnumGroupMessage);
var
  Group: TLogGroupMessage;
begin
  for Group := Low(TLogGroupMessage) to High(TLogGroupMessage) do
    if OLE_GROUP_MESSAGE[Group] = Value then
      FGroup := Group;
end;}

procedure TALogNode.Set_LogDocument(const Value: IProfLogNode);
begin
  FParent := Value;
end;

{procedure TLogNode.Set_LogType(Value: EnumTypeMessage);
var
  Typ: TLogTypeMessage;
begin
  for Typ := Low(TLogTypeMessage) to High(TLogTypeMessage) do
    if OLE_TYPE_MESSAGE[Typ] = Value then begin
      FType := Typ;
      Exit;
    end;
end;}

procedure TALogNode.Set_Parent(Value: Integer);
begin
end;

{procedure TLogNode.Set_StatusEnum(Value: StatusNodeEnum);
var
  Status: TLogNodeStatus;
begin
  for Status := Low(TLogNodeStatus) to High(TLogNodeStatus) do
    if OLE_NODE_STATUS[Status] = Value then begin
      FStatus := Status;
      Exit;
    end;
end;}

procedure TALogNode.Set_StrMsg(const Value: WideString);
begin
  FMsg := Value;
end;

procedure TALogNode.Show();
begin
end;

{ TLogNode2 }

procedure TALogNode2.AddMsg(const AMsg: WideString);
begin
  if Assigned(FLogDoc) then
    FLogDoc.AddMsg(AMsg);
end;

procedure TALogNode2.AddStr(const AStr: WideString);
begin
  if Assigned(FLogDoc) then
    FLogDoc.AddStr(AStr);
end;

constructor TALogNode2.Create(ALogDoc: ILogDocument2; AParent: Integer; ALogPrefix: string; AID: Integer);
begin
  inherited Create();
  FDTCreate := Now;
  FID := AID;
  FLogDoc := ALogDoc;
  FParent := AParent;
  FMsg := ALogPrefix;
  FStatus := lsNone;
end;

destructor TALogNode2.Destroy();
begin
  inherited Destroy();
end;

procedure TALogNode2.Free();
begin
  inherited Free;
end;

function TALogNode2.Get_Document(): ILogDocument2;
begin
  Result := FLogDoc;
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
  Result := FLogDoc;
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
  if FMsg <> '' then Result := FMsg + ': ' else Result := '';
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
    if OLE_GROUP_MESSAGE[Group] = Value then
      FGroup := Group;
end;

procedure TALogNode2.Set_Id(Value: Integer);
begin
  FId := Value;
end;

procedure TALogNode2.Set_LogDocument(const Value: ILogDocument2);
begin
  FLogDoc := Value;
end;

procedure TALogNode2.Set_LogType(Value: EnumTypeMessage);
var
  Typ: TLogTypeMessage;
begin
  for Typ := Low(TLogTypeMessage) to High(TLogTypeMessage) do
    if OLE_TYPE_MESSAGE[Typ] = Value then begin
      FType := Typ;
      Exit;
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
    if OLE_NODE_STATUS[Status] = Value then begin
      FStatus := Status;
      Exit;
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
  {Result := ToLogA(OLE_GROUP_MESSAGE[AGroup], OLE_TYPE_MESSAGE[AType],
    Format(lcNewNode, [Self.ID, Format(AStrMsg, AParams)]));}
end;

function TALogNode2.ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString): Integer;
{function TLogNode.ToLogA(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
    const AStrMsg: WideString): Integer;}
begin
  Result := -1;
  if Assigned(FLogDoc) then
  try
    Result := FLogDoc.ToLogA(AGroup, AType, AStrMsg);
  except
  end;
end;

function TALogNode2.ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  Result := -1;
  if Assigned(FLogDoc) then
  try
    Result := FLogDoc.ToLogE(AGroup, AType, AStrMsg);
  except
  end;
end;

{ TProfLogNode3 }

function TALogNode3.AddMsg(const AMsg: WideString): Integer;
begin
  if Assigned(FParent) then
    FParent.AddMsg(AMsg);
end;

function TALogNode3.AddStr(const AStr: WideString): Integer;
begin
  if Assigned(FParent) then
    FParent.AddStr(AStr);
end;

{function TLogNode.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  Result := -1;
  if Assigned(FLogDoc) then
  try
    Result := FLogDoc.AddToLog(AGroup, AType, AStrMsg);
  except
  end;
end;}

{constructor TLogNode.Create(ALogDoc: ILogDocument; AParent: Integer; ALogPrefix: string; AID: Integer);
begin
  inherited Create();
  FDTCreate := Now;
  FID := AID;
  FLogDoc := ALogDoc;
  FParent := AParent;
  FMsg := ALogPrefix;
  FStatus := lsNone;
end;}

{destructor TLogNode.Destroy();
begin
  inherited Destroy();
end;}

{procedure TLogNode.Free();
begin
  inherited Free;
end;}

function TALogNode3.Get_Parent(): Integer;
begin
  Result := 0;
end;

function TALogNode3.Get_StrMsg(): WideString;
begin
  Result := FMsg;
end;

procedure TALogNode3.Hide();
begin
end;

function TALogNode3.Prefix(): string;
begin
  if FMsg <> '' then Result := FMsg + ': ' else Result := '';
end;

procedure TALogNode3.SetStatus(Value: TLogNodeStatus);
begin
  FStatus := Value;
end;

{procedure TLogNode.Set_LogType(Value: EnumTypeMessage);
var
  Typ: TLogTypeMessage;
begin
  for Typ := Low(TLogTypeMessage) to High(TLogTypeMessage) do
    if OLE_TYPE_MESSAGE[Typ] = Value then begin
      FType := Typ;
      Exit;
    end;
end;}

procedure TALogNode3.Set_Parent(Value: Integer);
begin
end;

{procedure TLogNode.Set_StatusEnum(Value: StatusNodeEnum);
var
  Status: TLogNodeStatus;
begin
  for Status := Low(TLogNodeStatus) to High(TLogNodeStatus) do
    if OLE_NODE_STATUS[Status] = Value then begin
      FStatus := Status;
      Exit;
    end;
end;}

procedure TALogNode3.Set_StrMsg(const Value: WideString);
begin
  FMsg := Value;
end;

procedure TALogNode3.Show();
begin
end;

end.
