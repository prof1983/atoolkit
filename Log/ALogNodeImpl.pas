{**
@Abstract Implementation of interfaces IALogNode
@Author Prof1983 <prof1983@ya.ru>
@Created 16.08.2005
@LastMod 28.11.2012
}
unit ALogNodeImpl;

{$ifdef NoLogImpl}
  {$message Error 'Do not use this file'}
{$endif}

interface

uses
  SysUtils,
  ABase, ALogGlobals, ALogNodeIntf, ALogNodeObj, AMessageConst, ATypes;

type //** Нод логирования - элемент дерева логирования
  TALogNode = class(TInterfacedObject, IALogNode2)
  protected
    FLogNode: TALogNodeObject;
    {
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
    FLogDoc: ALogDocument;
      //** Родительский нод логирования к которому принадлежит этот нод
    FParent: IALogNode2;
      //** Статус нода
    FStatus: TLogNodeStatus;
    }
  protected
    function Get_GroupEnum(): EnumGroupMessage;
    function Get_Id(): Integer;
    function Get_LogType(): EnumTypeMessage;
    function Get_Parent(): Integer;
    function Get_StatusEnum(): StatusNodeEnum;
    function Get_StrMsg(): WideString;
    procedure Set_GroupEnum(Value: EnumGroupMessage);
    procedure Set_Id(Value: Integer);
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
    function GetSelf(): ALogNode;
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
    constructor Create2(LogDoc: ALogDocument; Parent: Integer; LogPrefix: string; Id: Integer);
  public
    property Id: Integer read Get_Id write Set_Id;
    property LogNode: TALogNodeObject read FLogNode;
    property Msg: WideString read Get_StrMsg write Set_StrMsg;
    {
    property OnAddToLog: TAddToLogProc read GetOnAddToLog write SetOnAddToLog;
    property Params: WideString read GetParams write SetParams;
    property Group: TLogGroupMessage read GetGroup write SetGroup;
    property Status: TLogNodeStatus read GetStatus write SetStatus;
    property Typ: TLogTypeMessage read GetType write SetType;
    }
  end;

implementation

uses
  ALogDocumentImpl;

{ TALogNode }

function TALogNode.AddMsg(const AMsg: WideString): Integer;
begin
  Result := FLogNode.AddMsg(AMsg);
end;

function TALogNode.AddStr(const AStr: WideString): Integer;
begin
  Result := FLogNode.AddStr(AStr);
end;

function TALogNode.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: WideString): AInteger;
begin
  Result := FLogNode.AddToLog(LogGroup, LogType, StrMsg);
end;

function TALogNode.AddToLog2(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: string; Params: array of const): Boolean;
begin
  Result := FLogNode.AddToLog2(LogGroup, LogType, StrMsg, Params);
end;

constructor TALogNode.Create(ALogDoc: IALogNode2; ALogPrefix: string; AID: Integer);
begin
  inherited Create();
  FLogNode := TALogNodeObject.Create(0, 0, ALogPrefix, AID);
end;

constructor TALogNode.Create2(LogDoc: ALogDocument; Parent: Integer; LogPrefix: string; Id: Integer);
begin
  inherited Create();
  FLogNode := TALogNodeObject.Create(LogDoc, Parent, LogPrefix, Id);
end;

function TALogNode.GetSelf(): ALogNode;
begin
  Result := ALogNode(Self);
end;

function TALogNode.Get_GroupEnum(): EnumGroupMessage;
begin
  Result := OLE_GROUP_MESSAGE[FLogNode.GetGroup()];
end;

function TALogNode.Get_Id(): Integer;
begin
  Result := FLogNode.GetId();
end;

function TALogNode.Get_LogType(): EnumTypeMessage;
begin
  Result := OLE_TYPE_MESSAGE[FLogNode.GetLogType()];
end;

function TALogNode.Get_Parent(): Integer;
begin
  Result := FLogNode.GetParent();
end;

function TALogNode.Get_StatusEnum(): StatusNodeEnum;
begin
  Result := OLE_NODE_STATUS[FLogNode.GetStatus()];
end;

function TALogNode.Get_StrMsg(): WideString;
begin
  Result := FLogNode.GetStrMsg();
end;

procedure TALogNode.Hide();
begin
end;

function TALogNode.Prefix(): string;
begin
  Result := FLogNode.Prefix();
end;

procedure TALogNode.SetStatus(Value: TLogNodeStatus);
begin
  FLogNode.SetStatus(Value);
end;

procedure TALogNode.Set_GroupEnum(Value: EnumGroupMessage);
var
  Group: TLogGroupMessage;
begin
  for Group := Low(TLogGroupMessage) to High(TLogGroupMessage) do
  begin
    if (OLE_GROUP_MESSAGE[Group] = Value) then
    begin
      FLogNode.SetGroup(Group);
      Exit;
    end;
  end;
end;

procedure TALogNode.Set_Id(Value: Integer);
begin
  FLogNode.SetId(Value);
end;

procedure TALogNode.Set_LogType(Value: EnumTypeMessage);
var
  Typ: TLogTypeMessage;
begin
  for Typ := Low(TLogTypeMessage) to High(TLogTypeMessage) do
  begin
    if OLE_MESSAGE_TYPE[Typ] = Value then
    begin
      FLogNode.SetLogType(Typ);
      Exit;
    end;
  end;
end;

procedure TALogNode.Set_Parent(Value: Integer);
begin
  FLogNode.SetParent(Value);
end;

procedure TALogNode.Set_StatusEnum(Value: StatusNodeEnum);
var
  Status: TLogNodeStatus;
begin
  for Status := Low(TLogNodeStatus) to High(TLogNodeStatus) do
  begin
    if OLE_NODE_STATUS[Status] = Value then
    begin
      FLogNode.SetStatus(Status);
      Exit;
    end;
  end;
end;

procedure TALogNode.Set_StrMsg(const Value: WideString);
begin
  FLogNode.SetStrMsg(Value);
end;

procedure TALogNode.Show();
begin
end;

function TALogNode.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := FLogNode.AddToLog(AGroup, AType, Format(lcNewNode, [Self.ID, Format(AStrMsg, AParams)]));
end;

function TALogNode.ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  Result := FLogNode.AddToLog(AGroup, AType, AStrMsg);
end;

function TALogNode.ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  Result := FLogNode.AddToLog(IntToLogGroupMessage(AGroup), IntToLogTypeMessage(AType), AStrMsg);
end;

end.