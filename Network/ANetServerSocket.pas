{**
@Abstract Server socket
@Author Prof1983 <prof1983@ya.ru>
@Created 30.10.2005
@LastMod 05.02.2013
}
unit ANetServerSocket;

interface

uses
  ScktComp,
  ABase,
  AConfigUtils;

type
  TClient = record
    CustomWinSocket: TCustomWinSocket;
    Error: Integer;
  end;

  TProfServerSocket = class(TInterfacedObject)
  private
    FClients: array of TClient;
    FConfig: AProfXmlNode2;
    FInitialized: Boolean;
    FPort: Integer;
    FServerSocket: TServerSocket;
  private
    procedure DeleteSocket(Socket: TCustomWinSocket);
    procedure ServClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure SerClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure DoError(Client: TClient);
  public
    function ConfigureLoad(): WordBool; virtual;
    function Finalize(): WordBool; virtual;
    function Initialize(): WordBool; virtual;
  public
    constructor Create(APort: Integer);
    procedure Free(); virtual;
  public
    property Port: Integer read FPort write FPort;
  end;

implementation

{ TProfServerSocket }

function TProfServerSocket.ConfigureLoad: WordBool;
var
  I: AInt32;
begin
  if (FConfig = 0) then
  begin
    Result := False;
    Exit;
  end;
  if Assigned(FServerSocket) then
  begin
    AConfig_ReadInt32(FConfig, 'Port', I);
    FServerSocket.Port := I;
  end;
  Result := True;
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
  for I := 0 to High(FClients) do
    if FClients[I].CustomWinSocket = Socket then
    begin
      for I2 := I to High(FClients) - 1 do FClients[I2] := FClients[I2 - 1];
      SetLength(FClients, High(FClients));
    end;
  {RefreshA;}
end;

function TProfServerSocket.Finalize(): WordBool;
begin
  Result := True;
end;

procedure TProfServerSocket.Free;
begin
  if FInitialized then
    Finalize();

  {Send all messages on the rebound}
  {...}
  SetLength(FClients, 0);
  inherited Free;
end;

function TProfServerSocket.Initialize: WordBool;
begin
  if FInitialized then
  begin
    Result := True;
    Exit;
  end;
  FInitialized := True;

  try
    if not(Assigned(FServerSocket)) then
    begin
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
        {If the error is 2 times the destruction of}
        {DeleteSocket(Socket);}
        {If the error 10 times erosion, the call event}
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
    0:begin {Returning the name of the}
      for I := 0 to High(A) do
        {if A[I].CustomWinSocket.RemoteAddress = Buf.AddressFrom then}
        if A[I].CustomWinSocket = Socket then
        begin
          A[I].Name := Buf.S;
          RefreshA;
          Break;
        end;
    end;
    1:begin {Send a message}
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
    2:begin {The request for the return of the list of names}
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
    3:begin {Notice of changes in}
      Refresh(Socket);
      RefreshA;
    end;
    4:begin {Return color}
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
{Invoked when an error прозошла 10 times erosion}
begin

end;

end.
