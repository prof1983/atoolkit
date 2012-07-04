{**
@Abstract(Сообщения для передачи команд между модулями и внутри программы)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.11.2005)
@LastMod(04.07.2012)
@Version(0.5)
}
unit AMessagesObj;

interface

uses
  AMessageObj, ATypes;

type //** Конвеер сообщений
  TAMessages = class
  private
    FMessages: array of TProfMessage3;
      //** Счетчик номеров команд
    FNextIdent: Integer;
      //** Index следующей точки вставки нового сообщения
    FNextMsg: Integer;
      //** Index следующей выполняемого сообщения
    FNextRun: Integer;
  public
    function GetCount(): Integer;
  public
      //** Добавить команду в список. Поставить команду в очередь выполнения.
    function AddComand(AConnectionId: UInt64; AIdent: Int32; AOwner: UInt64;
        AComId: UInt64; const AComName, AParams: WideString): Boolean;
      //** Добавить сообщение. Поставить сообщение в очередь сообщений.
    function AddMsg(AConnectionID: UInt64; AMsg: WideString): Boolean;
    constructor Create(StekSize: Integer = 512);
      //** Найти ответ
    function FindMsgAnswer(AConnectionId: UInt64; AIdent: Integer; AComId: UInt64; AComName: WideString; var AMsg: TProfMessage3): Boolean;
      //** Получить сообщение
    function GetMessage(Index: Integer): TProfMessage3;
      //** Получить сообщение
    function GetMessageRec(Index: Integer; var AMsg: TProfMessageRec): Boolean;
      //** Вернуть следующее значение счетчика сообщений
    function GetNextIdent(): Integer;
      {**
      Возвращает следующее сообщение для разбора и выполнения
      True - сообщение есть. False - сообщения нет. }
    function GetNextMessageRec(var AMsg: TProfMessageRec): Boolean;
  public
      //** Колличество сообщений
    property Count: Integer read GetCount;
      //** Сообщения
    property Messages[Index: Integer]: TProfMessage3 read GetMessage;
      //** Следующее значение счетчика сообщений
    property NextIdent: Integer read GetNextIdent;
      //** Следующее сообщение для обработки
    property NextRun: Integer read FNextRun;
  end;

implementation

{ TAMessages }

function TAMessages.AddComand(AConnectionId: UInt64; AIdent: Int32; AOwner: UInt64;
    AComId: UInt64; const AComName, AParams: WideString): Boolean;
begin
  Result := False;
  //FCritical.Leave;
  // Если буфер полный, то выход
  if (FNextMsg = FNextRun) and (FMessages[FNextMsg].FMessage.MsgType <> mtNone) then
  begin
    //FCritical.Release;
    Exit;
  end;
  // Если Ident не задан
  //if AIdent = 0 then AIdent := GetNextIdent;
  FMessages[FNextMsg].FMessage.ConnectionId := AConnectionId;
  FMessages[FNextMsg].FMessage.Ident := AIdent; {FNextIdent;}
  FMessages[FNextMsg].FMessage.Msg := '';
  FMessages[FNextMsg].FMessage.MsgId := AComId;
  FMessages[FNextMsg].FMessage.MsgName := AComName;
  FMessages[FNextMsg].FMessage.MsgType := mtComand;
  FMessages[FNextMsg].FMessage.OwnerId := AOwner;
  FMessages[FNextMsg].FMessage.Params := AParams;
  //Result := FMessages[FNextMsg].Ident;
  // Передвижка на следующее место вставки команды
  if (FNextMsg >= High(FMessages)) then
    FNextMsg := 0
  else
    Inc(FNextMsg);
  Result := True;
  //FCritical.Release;
end;

function TAMessages.AddMsg(AConnectionID: UInt64; AMsg: WideString): Boolean;
begin
  Result := False;
  // Если буфер полный, то выход
  if (FNextMsg = FNextRun) and (FMessages[FNextMsg].FMessage.MsgType <> mtNone) then Exit;
  //FMessages[FNextMsg].ConnectionId := AConnectionId;
  FMessages[FNextMsg].FMessage.Msg := AMsg;
  FMessages[FNextMsg].FMessage.MsgType := mtUncnown;
  Result := True;
end;

constructor TAMessages.Create(StekSize: Integer);
begin
  inherited Create;
  SetLength(FMessages, StekSize);
  FNextIdent := 1; // Счетчик номеров команд
  FNextMsg := 0;
end;

function TAMessages.FindMsgAnswer(AConnectionId: UInt64; AIdent: Integer; AComId: UInt64; AComName: WideString; var AMsg: TProfMessage3): Boolean;
// Найти ответ

  function Check(Index: Integer): Boolean;
  begin
    if (FMessages[Index].FMessage.MsgType = mtAnswer)
    //and (FMessages[Index].ConnectionId = AConnectionId)
    and (FMessages[Index].FMessage.MsgName = AComName) then Result := True else Result := False;
  end;

var
  I: Int32;
begin
  Result := False;
  if FNextMsg > FNextRun then
  begin
    for I := FNextRun to FNextMsg - 1 do if Check(I) then
    begin
      AMsg := FMessages[I];
      Result := True;
      Exit;
    end;
  end
  else
  begin
    for I := 0 to FNextMsg - 1 do if Check(I) then
    begin
      AMsg := FMessages[I];
      Result := True;
      Exit;
    end;
    for I := FNextRun to High(FMessages) do if Check(I) then
    begin
      AMsg := FMessages[I];
      Result := True;
      Exit;
    end;
  end;
end;

function TAMessages.GetCount(): Integer;
begin
  Result := Length(FMessages);
end;

function TAMessages.GetMessage(Index: Integer): TProfMessage3;
begin
  if (Index < 0) or (Index >= Length(FMessages)) then
  begin
    Result := nil;
    Exit;
  end;
  Result := FMessages[Index];
end;

function TAMessages.GetMessageRec(Index: Integer; var AMsg: TProfMessageRec): Boolean;
// Получить сообщение
{var
  Msg: TProfXmlNode;}

  {procedure Read();
  begin
    if not(Msg.ReadInt32(cMsgNodeIdent, AMsg.Ident)) then AMsg.Ident := 0;
    if not(Msg.ReadUInt64(cMsgNodeId, AMsg.MsgId)) then AMsg.MsgId := 0;
    if not(Msg.ReadUInt64(cMsgNodeOwner, AMsg.OwnerId)) then AMsg.OwnerId := 0;
    if not(Msg.ReadString(cMsgNodeName, AMsg.MsgName)) then AMsg.MsgName := '';
    AMsg.Params := TProfXmlNode.Create(nil);
    AMsg.Params.LoadFromXml(Msg.GetNodeByName('Params'));
  end;}

begin
  AMsg := FMessages[Index].FMessage;
  Result := True;
  (*
  // Разбор команды если не разбрана
  if (AMsg.FMessage.MsgType = mtUncnown) then
  begin
    {Msg := TProfXmlNode.Create(nil);
    Msg.SetXml(AMsg.Msg);
    AMsg.MsgType := AIStrToMsgType(Msg.NodeName);
    Result := True;
    case AMsg.MsgType of
      mtComand: Read();
      mtEvent: Read();
      mtAnswer: Read();
    else
      Result := False;
    end;
    Msg.Free;}
  end;
  *)
end;

function TAMessages.GetNextIdent(): Int32;
begin
  Result := FNextIdent;
  if FNextIdent >= High(Int32) then FNextIdent := 1 else Inc(FNextIdent);
end;

{function TAMessages.GetNextMessage(): TProfMessage3;
begin
  Result := False;
  Result := FMessages[FNextRun];
  if not(Assigned(Result)) or (Result.FMessage.MsgType = mtNone) then Exit;
  // Затирание команды
  Result.FMessage.MsgType := mtNone;
  // Переход на следующую команду
  if (FNextRun >= High(FMessages)) then
    FNextRun := 0
  else
    Inc(FNextRun);
  Result := True;
end;}

function TAMessages.GetNextMessageRec(var AMsg: TProfMessageRec): Boolean;
var
  tmpMsg: TProfMessage3;
begin
  Result := False;
  tmpMsg := FMessages[FNextRun];
  if not(Assigned(tmpMsg)) or (tmpMsg.FMessage.MsgType = mtNone) then Exit;
  Result := GetMessageRec(FNextRun, AMsg);
  if not(Result) then Exit;
  // Затирание команды
  tmpMsg.FMessage.MsgType := mtNone;
  // Переход на следующую команду
  if (FNextRun >= High(FMessages)) then
    FNextRun := 0
  else
    Inc(FNextRun);
  Result := True;
end;

end.
