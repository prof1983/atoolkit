{**
@Abstract(Implementation of interfaces ILogNode and IProfLogNode)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.08.2005)
@LastMod(03.07.2012)
@Version(0.5)
}
unit ALogNodeImpl;

interface

uses
  SysUtils,
  ABase, ALogDocumentIntf, ALogGlobals, ALogNodeIntf, AMessageConst, ATypes;

type //** Нод логирования - элемент дерева логирования
  TALogNode = class(TInterfacedObject, IALogNode2)
  protected
      //** Дата создания
    FDTCreate: TDateTime;
      //** Identifier
    FId: Integer;
      //** Сообщение
    FMsg: WideString;
    FOnAddToLog: TAddToLogProc;
      //** Параметры в виде XML
    FParams: WideString;
      //** Тип сообщения
    FType: TLogTypeMessage;
      //** Группа сообщения
    FGroup: TLogGroupMessage;
  protected
      //** Документ логирования к которому принадлежит этот нод
    FLogDoc: ALogDocument2;
      //** Родительский нод логирования к которому принадлежит этот нод
    FParent: IALogNode2{Integer};
      //** Статус нода
    FStatus: TLogNodeStatus;
  protected
    //function Get_Document(): ILogDocument2{IProfLogNode};
    function Get_GroupEnum(): EnumGroupMessage;
    function Get_Id(): Integer;
    //function Get_LogDocument(): ILogDocument2(IProfLogNode);
    function Get_LogType(): EnumTypeMessage;
    function Get_Parent(): Integer;
    function Get_StatusEnum(): StatusNodeEnum;
    function Get_StrMsg(): WideString;
    procedure Set_GroupEnum(Value: EnumGroupMessage);
    procedure Set_Id(Value: Integer);
    //procedure Set_LogDocument(const Value: ILogDocument2{IProfLogNode});
    procedure Set_LogType(Value: EnumTypeMessage);
    procedure Set_Parent(Value: Integer);
    procedure Set_StatusEnum(Value: StatusNodeEnum);
    procedure Set_StrMsg(const Value: WideString);
  protected
    procedure SetStatus(Value: TLogNodeStatus);
  public
      {** Добавить сообщение
          @returns(Возвращает номер добавленого сообщения или 0) }
    function AddMsg(const AMsg: WideString): Integer; virtual;
      {** Добавить строку
          @returns(Возвращает номер добавленой строки или 0) }
    function AddStr(const AStr: WideString): Integer; virtual;
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: WideString): AInteger; virtual;
    function AddToLog2(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: string; Params: array of const): Boolean; virtual;
    procedure Hide(); virtual;
    function Prefix(): string;
    procedure Show(); virtual;
  public
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; virtual; deprecated; // Use AddToLog()
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; virtual; deprecated; // Use AddToLog()
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer; virtual; deprecated; // Use AddToLog()
  public
    constructor Create(ALogDoc: IALogNode2; ALogPrefix: string; AID: Integer);
    constructor Create2(LogDoc: ALogDocument2; Parent: Integer; LogPrefix: string; Id: Integer);
  public
    property Id: Integer read FId write FId;
    property Msg: WideString read FMsg write FMsg;
    property OnAddToLog: TAddToLogProc read FOnAddToLog write FOnAddToLog;
    property Params: WideString read FParams write FParams;
    property Group: TLogGroupMessage read FGroup write FGroup;
    property Status: TLogNodeStatus read FStatus write SetStatus;
    property Typ: TLogTypeMessage read FType write FType;
  end;

  //TALogNode2 = TALogNode;
  //TLogNode = TALogNode;

implementation

uses
  ALogDocumentImpl;

{ TALogNode }

function TALogNode.AddMsg(const AMsg: WideString): Integer;
var
  LogDoc: TALogDocument;
begin
  if Assigned(TObject(FLogDoc)) then
  begin
    LogDoc := TObject(FLogDoc) as TALogDocument;
    LogDoc.AddMsg(AMsg);
  end;
  Result := 0;
  if Assigned(FParent) then
    FParent.AddMsg(AMsg);
end;

function TALogNode.AddStr(const AStr: WideString): Integer;
var
  LogDoc: TALogDocument;
begin
  if Assigned(TObject(FLogDoc)) then
  begin
    LogDoc := TObject(FLogDoc) as TALogDocument;
    LogDoc.AddStr(AStr);
  end;
  Result := 0;
  if Assigned(FParent) then
    FParent.AddStr(AStr);
end;

function TALogNode.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: WideString): AInteger;
var
  LogDoc: TALogDocument;
begin
  Result := -1;

  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(LogGroup, LogType, StrMsg);
  except
  end;

  if Assigned(TObject(FLogDoc)) then
  try
    LogDoc := TObject(FLogDoc) as TALogDocument;
    Result := LogDoc.AddToLog(LogGroup, LogType, StrMsg)
  except
  end;

  if Assigned(FParent) then
  try
    Result := FParent.AddToLog(LogGroup, LogType, StrMsg);
  except
  end;
end;

function TALogNode.AddToLog2(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: string; Params: array of const): Boolean;
begin
  Result := (AddToLog(LogGroup, LogType, Format(StrMsg, Params)) > 0);
end;

constructor TALogNode.Create(ALogDoc: IALogNode2; ALogPrefix: string; AID: Integer);
begin
  inherited Create();
  FDTCreate := Now;
  FID := AID;
  FLogDoc := 0;
  FParent := ALogDoc;
  FMsg := ALogPrefix;
  FStatus := lsNone;
end;

constructor TALogNode.Create2(LogDoc: ALogDocument2; Parent: Integer; LogPrefix: string; Id: Integer);
begin
  inherited Create();
  FDTCreate := Now;
  FId := Id;
  FLogDoc := LogDoc;
  FParent := nil;
  FMsg := LogPrefix;
  FStatus := lsNone;
end;

{function TALogNode.Get_Document(): ILogDocument2;
var
  LogDoc: TALogDocument;
begin
  if not(Assigned(TObject(FLogDoc))) then
  begin
    Result := nil;
    Exit;
  end;

  LogDoc := TObject(FLogDoc) as TALogDocument;
  Result := TObject(LogDoc) as ILogDocument;
end;}
{function TALogNode.Get_Document(): IProfLogNode;
begin
  Result := FParent;
end;}

function TALogNode.Get_GroupEnum(): EnumGroupMessage;
begin
  Result := OLE_GROUP_MESSAGE[FGroup];
end;

function TALogNode.Get_Id(): Integer;
begin
  Result := FId;
end;

{function TALogNode.Get_LogDocument(): ILogDocument2;
begin
  Result := Get_Document();
end;}
{function TALogNode.Get_LogDocument(): IProfLogNode;
begin
  Result := FParent;
end;}

function TALogNode.Get_LogType(): EnumTypeMessage;
begin
  Result := OLE_TYPE_MESSAGE[FType];
end;

function TALogNode.Get_Parent(): Integer;
begin
  //Result := FParent;
  Result := 0;
end;

function TALogNode.Get_StatusEnum(): StatusNodeEnum;
begin
  Result := OLE_NODE_STATUS[FStatus];
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
  if (FMsg <> '') then
    Result := FMsg + ': '
  else
    Result := '';
end;

procedure TALogNode.SetStatus(Value: TLogNodeStatus);
begin
  FStatus := Value;
end;

procedure TALogNode.Set_GroupEnum(Value: EnumGroupMessage);
var
  Group: TLogGroupMessage;
begin
  for Group := Low(TLogGroupMessage) to High(TLogGroupMessage) do
  begin
    if OLE_GROUP_MESSAGE[Group] = Value then
      FGroup := Group;
  end;
end;

procedure TALogNode.Set_Id(Value: Integer);
begin
  FId := Value;
end;

{procedure TALogNode.Set_LogDocument(const Value: ILogDocument2);
begin
  //FLogDoc := Value;
end;}
{procedure TALogNode.Set_LogDocument(const Value: IProfLogNode);
begin
  FParent := Value;
end;}

procedure TALogNode.Set_LogType(Value: EnumTypeMessage);
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

procedure TALogNode.Set_Parent(Value: Integer);
begin
  //FParent := Value;
end;

procedure TALogNode.Set_StatusEnum(Value: StatusNodeEnum);
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

procedure TALogNode.Set_StrMsg(const Value: WideString);
begin
  FMsg := Value;
end;

procedure TALogNode.Show();
begin
end;

function TALogNode.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := AddToLog(AGroup, AType, Format(lcNewNode, [Self.ID, Format(AStrMsg, AParams)]));
end;

function TALogNode.ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  Result := AddToLog(AGroup, AType, AStrMsg);
end;

function TALogNode.ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  Result := AddToLog(IntToLogGroupMessage(AGroup), IntToLogTypeMessage(AType), AStrMsg);
end;

end.