{**
@Abstract Server socket
@Author Prof1983 <prof1983@ya.ru>
@Created 30.10.2005
@LastMod 13.11.2012
}
unit ANetServerSocket;

TODO: AObjectImpl2006 -> AObjectImpl

interface

uses
  ScktComp,
  ABase, AConfigUtils, AObjectImpl2006;

type
  TClient = record
    CustomWinSocket: TCustomWinSocket;
    Error: Integer;
  end;

  TProfServerSocket = class(TAObject2006)
  private
    FClients: array of TClient;
    FPort: Integer;
    FServerSocket: TServerSocket;
    procedure DeleteSocket(Socket: TCustomWinSocket);
    procedure ServClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure SerClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure DoError(Client: TClient);
  public
    function ConfigureLoad: WordBool; override;
    function Initialize: WordBool; override;
  public
    constructor Create(APort: Integer);
    procedure Free(); override;
  public
    property Port: Integer read FPort write FPort;
  end;

implementation

{ TProfServerSocket }

function TProfServerSocket.ConfigureLoad: WordBool;
var
  I: AInt32;
  {S: String;}
begin
  Result := inherited ConfigureLoad;
  if not(Result) then Exit;
  if Assigned(FServerSocket) then
  begin
    AConfig_ReadInt32(FConfig, 'Port', I);
    FServerSocket.Port := I;
  end;
end;

constructor TProfServerSocket.Create(APort: Integer);
begin
  inherited Create();
  FPort := APort;
  FServerSocket := TServerSocket.Create(nil);
  FServerSocket.Port := FPort;
  FServerSocket.OnClientConnect := ServClientConnect;
  {FServerSocket.OnClientWrite := ServClientWrite;}
  FServerSocket.Active := True;
end;

procedure TProfServerSocket.DeleteSocket(Socket: TCustomWinSocket);
var
  I: Integer;
  I2: Integer;
begin
  {Удаление клиента}
  for I := 0 to High(FClients) do
    if FClients[I].CustomWinSocket = Socket then
    begin
      for I2 := I to High(FClients) - 1 do FClients[I2] := FClients[I2 - 1];
      SetLength(FClients, High(FClients));
    end;
  {RefreshA;}
end;

procedure TProfServerSocket.Free;
begin
  {Послать всем сообщения об отбое}
  {...}
  SetLength(FClients, 0);
  inherited Free;
end;

function TProfServerSocket.Initialize: WordBool;
begin
  Result := inherited Initialize;
  try
  if not(Result) then Exit;
  if not(Assigned(FServerSocket)) then begin
    FServerSocket := TServerSocket.Create(nil);
    FServerSocket.Port := FPort;
    FServerSocket.OnClientConnect := ServClientConnect;
    {FServerSocket.OnClientWrite := ServClientWrite;}
  end;
  FServerSocket.Active := True;
  Result := FServerSocket.Active;
  except
    Result := False;
  end;
end;

procedure TProfServerSocket.ServClientConnect(Sender: TObject; Socket: TCustomWinSocket);
var
  I: Integer;
begin
  {Связь с клиентом}
  I := Length(FClients);
  SetLength(FClients, I + 1);
  FClients[I].CustomWinSocket := Socket;
  {Refresh(Socket);}
end;

procedure TProfServerSocket.SerClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  DeleteSocket(Socket);
end;

procedure TProfServerSocket.ServClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
var
  I: Integer;
begin
  for I := 0 to High(FClients) do
    if FClients[I].CustomWinSocket = Socket then
    begin
      if FClients[I].Error < 10 then
      begin
        Inc(FClients[I].Error);
        Exit;
      end else begin
        {Если ошибка 2 раз то удаление}
        {DeleteSocket(Socket);}
        {Если ошибка 10 раз подрят, то вызываем событие}
        DoError(FClients[I]);
      end;
    end;
end;

procedure TProfServerSocket.ServClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
{var
  Buf: TBlock;
  I: Integer;}
begin
  (*Socket.ReceiveBuf(Buf, SizeOf(Buf));
  if Buf.Ident <> 0 then Exit;
  case Buf.Com of
    0:begin {Возвращение имени}
      for I := 0 to High(A) do
        {if A[I].CustomWinSocket.RemoteAddress = Buf.AddressFrom then}
        if A[I].CustomWinSocket = Socket then
        begin
          A[I].Name := Buf.S;
          RefreshA;
          Break;
        end;
    end;
    1:begin {Отослать сообщение}
      {Memo1.Lines.Add(Buf.S);}
      if Buf.AddressOut = 'All' then
      begin
        for I := 0 to High(A) do
          A[I].CustomWinSocket.SendBuf(Buf, SizeOf(Buf));
      end
      else
      begin
        for I := 0 to High(A) do
          if A[I].CustomWinSocket.RemoteAddress = Buf.AddressOut then
          begin
            A[I].CustomWinSocket.SendBuf(Buf, SizeOf(Buf));
            Break;
          end;
      end;
    end;
    2:begin {Запрос на возвращение списка имен}
      if Buf.S = '0' then
      begin
        Buf.AddressFrom := ServerSocket1.Socket.LocalAddress;
        Buf.S := IntToStr(Length(A)) + ' ' + IntToStr(3);
        Socket.SendBuf(Buf, SizeOf(Buf));
        for I := 0 to High(A) do
        begin
          Buf.S := A[I].Name;
          Socket.SendBuf(Buf, SizeOf(Buf));
          Buf.S := A[I].CustomWinSocket.RemoteAddress;
          Socket.SendBuf(Buf, SizeOf(Buf));
          Buf.S := IntToStr(A[I].Color);
          Socket.SendBuf(Buf, SizeOf(Buf));
        end;
      end
      else
      begin
        Buf.AddressFrom := ServerSocket1.Socket.LocalAddress;
        Buf.S := IntToStr(Length(A));
        Socket.SendBuf(Buf, SizeOf(Buf));
        for I := 0 to High(A) do
        begin
          Buf.S := A[I].Name;
          Socket.SendBuf(Buf, SizeOf(Buf));
          Buf.S := A[I].CustomWinSocket.RemoteAddress;
          Socket.SendBuf(Buf, SizeOf(Buf));
        end;
      end;
    end;
    3:begin {Сообщение об изменении}
      Refresh(Socket);
      RefreshA;
    end;
    4:begin {Возвращение цвета}
      for I := 0 to High(A) do
        if A[I].CustomWinSocket.RemoteAddress = Buf.AddressFrom then
        begin
          A[I].Color := StrToInt(Buf.S);
          RefreshA;
          Break;
        end;
    end;
  end;*)
end;

procedure TProfServerSocket.DoError(Client: TClient);
{Вызывается, если ошибка прозошла 10 раз подрят}
begin

end;

end.
