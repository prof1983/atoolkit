{**
@Abstract ALogNode object
@Author Prof1983 <prof1983@ya.ru>
@Created 16.08.2005
@LastMod 27.11.2012
}
unit ALogNodeObj;

interface

uses
  SysUtils,
  ABase, ALogGlobals, AMessageConst, ATypes;

type
  ALogNode_Type = record
    {** Created date }
    Create: TDateTime;
    {** Identifier }
    Id: Integer;
    {** Message }
    Msg: WideString;
    OnAddToLog: TAddToLogProc;
    {** Параметры в виде XML }
    Params: WideString;
    {** Тип сообщения }
    Typ: TLogTypeMessage;
    {** Группа сообщения }
    Group: TLogGroupMessage;
    {** Документ логирования к которому принадлежит этот нод }
    LogDoc: ALogDocument;
    {** Родительский нод логирования к которому принадлежит этот нод }
    Parent: ALogNode;
    {** Статус нода }
    Status: TLogNodeStatus;
  end;

  //** Нод логирования - элемент дерева логирования
  TALogNodeObject = class
  protected
    FLogNode: ALogNode_Type;
  public
    function GetGroup(): TLogGroupMessage;
    function GetId(): Integer;
    function GetLogType(): TLogTypeMessage;
    function GetOnAddToLog(): TAddToLogProc;
    function GetParent(): ALogNode;
    function GetStatus(): TLogNodeStatus;
    function GetStrMsg(): WideString;
    procedure SetGroup(Value: TLogGroupMessage);
    procedure SetId(Value: Integer);
    procedure SetLogType(Value: TLogTypeMessage);
    procedure SetOnAddToLog(Value: TAddToLogProc);
    procedure SetParent(Value: ALogNode);
    procedure SetStatus(Value: TLogNodeStatus);
    procedure SetStrMsg(const Value: WideString);
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
    function Prefix(): string;
  public
    constructor Create(LogDoc: ALogDocument; Parent: AInt; LogPrefix: APascalString; Id: AInt);
  public
    property Id: Integer read GetId write SetId;
    property Msg: WideString read GetStrMsg write SetStrMsg;
    //property OnAddToLog: TAddToLogProc read FOnAddToLog write FOnAddToLog;
    //property Params: WideString read FParams write FParams;
    property Group: TLogGroupMessage read GetGroup write SetGroup;
    property Status: TLogNodeStatus read GetStatus write SetStatus;
    property Typ: TLogTypeMessage read GetLogType write SetLogType;
  end;

implementation

uses
  ALogDocumentObj;

{ TALogNodeObject }

function TALogNodeObject.AddMsg(const AMsg: WideString): Integer;
var
  LogDoc: TALogDocumentObject;
begin
  if Assigned(TObject(FLogNode.LogDoc)) then
  begin
    LogDoc := TObject(FLogNode.LogDoc) as TALogDocumentObject;
    LogDoc.AddMsg(AMsg);
  end;
  Result := 0;
  if (FLogNode.Parent <> 0) then
    TALogNodeObject(FLogNode.Parent).AddMsg(AMsg);
end;

function TALogNodeObject.AddStr(const AStr: WideString): Integer;
var
  LogDoc: TALogDocumentObject;
begin
  if Assigned(TObject(FLogNode.LogDoc)) then
  begin
    LogDoc := TObject(FLogNode.LogDoc) as TALogDocumentObject;
    LogDoc.AddStr(AStr);
  end;
  Result := 0;
  if (FLogNode.Parent <> 0) then
    TALogNodeObject(FLogNode.Parent).AddStr(AStr);
end;

function TALogNodeObject.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: WideString): AInteger;
var
  LogDoc: TALogDocumentObject;
begin
  Result := -1;

  if Assigned(FLogNode.OnAddToLog) then
  try
    Result := FLogNode.OnAddToLog(LogGroup, LogType, StrMsg);
  except
  end;

  if Assigned(TObject(FLogNode.LogDoc)) then
  try
    LogDoc := TObject(FLogNode.LogDoc) as TALogDocumentObject;
    Result := LogDoc.AddToLog(LogGroup, LogType, StrMsg)
  except
  end;

  if (FLogNode.Parent <> 0) then
  try
    Result := TALogNodeObject(FLogNode.Parent).AddToLog(LogGroup, LogType, StrMsg);
  except
  end;
end;

function TALogNodeObject.AddToLog2(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: string; Params: array of const): Boolean;
var
  S: WideString;
begin
  try
    S := Format(StrMsg, Params);
  except
    S := StrMsg;
  end;
  Result := (AddToLog(LogGroup, LogType, S) > 0);
end;

constructor TALogNodeObject.Create(LogDoc: ALogDocument; Parent: AInt; LogPrefix: APascalString; Id: AInt);
begin
  inherited Create();
  FLogNode.Create := Now;
  FLogNode.Id := Id;
  FLogNode.LogDoc := LogDoc;
  FLogNode.Parent := 0;
  FLogNode.Msg := LogPrefix;
  FLogNode.Status := lsNone;
end;

function TALogNodeObject.GetSelf(): ALogNode;
begin
  Result := ALogNode(Self);
end;

function TALogNodeObject.GetGroup(): TLogGroupMessage;
begin
  Result := FLogNode.Group;
end;

function TALogNodeObject.GetId(): Integer;
begin
  Result := FLogNode.Id;
end;

function TALogNodeObject.GetLogType(): TLogTypeMessage;
begin
  Result := FLogNode.Typ;
end;

function TALogNodeObject.GetOnAddToLog(): TAddToLogProc;
begin
  Result := FLogNode.OnAddToLog;
end;

function TALogNodeObject.GetParent(): ALogNode;
begin
  Result := FLogNode.Parent;
end;

function TALogNodeObject.GetStatus(): TLogNodeStatus;
begin
  Result := FLogNode.Status;
end;

function TALogNodeObject.GetStrMsg(): WideString;
begin
  Result := FLogNode.Msg;
end;

function TALogNodeObject.Prefix(): string;
begin
  if (FLogNode.Msg <> '') then
    Result := FLogNode.Msg + ': '
  else
    Result := '';
end;

procedure TALogNodeObject.SetGroup(Value: TLogGroupMessage);
begin
  FLogNode.Group := Group;
end;

procedure TALogNodeObject.SetId(Value: Integer);
begin
  FLogNode.Id := Value;
end;

procedure TALogNodeObject.SetLogType(Value: TLogTypeMessage);
begin
  FLogNode.Typ := Typ;
end;

procedure TALogNodeObject.SetOnAddToLog(Value: TAddToLogProc);
begin
  FLogNode.OnAddToLog := Value;
end;

procedure TALogNodeObject.SetParent(Value: ALogNode);
begin
  FLogNode.Parent := Value;
end;

procedure TALogNodeObject.SetStatus(Value: TLogNodeStatus);
begin
  FLogNode.Status := Value;
end;

procedure TALogNodeObject.SetStrMsg(const Value: WideString);
begin
  FLogNode.Msg := Value;
end;

end.