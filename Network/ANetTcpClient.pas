{**
@Abstract(Оболочка для TCP/IP соединения (Client))
@Author(Prof1983 prof1983@ya.ru)
@Created(23.10.2005)
@LastMod(26.04.2012)
@Version(0.5)
}
unit ANetTcpClient;

interface

uses
  Classes, Sockets, XmlIntf,
  ALogGlobals2007, ATypes;

type
  TProfTcpClient = class(TTcpClient)
  private
    FConfig: IXmlNode;
    FInitialized: Boolean;
    FLog: TLogNode;
  protected
    procedure DoConnect(Sender: TObject); //virtual;
    procedure DoDisconnect(Sender: TObject); //virtual;
    procedure DoCreateHandle(Sender: TObject); //virtual;
    procedure DoDestroyHandle(Sender: TObject); //virtual;
    procedure DoReceive(Sender: TObject; Buf: PAnsiChar; var DataLen: Integer);
    procedure DoSend(Sender: TObject; Buf: PAnsiChar; var DataLen: Integer);
    procedure DoError(Sender: TObject; SocketError: Integer);
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
    //property Client: TTcpClient read FClient;
    property Config: IXmlNode read FConfig write FConfig;
    function ConfigureLoad: Boolean; virtual;
    function ConfigureSave: Boolean; virtual;
    constructor Create(AConfig: IXmlNode = nil; ALog: TLogNode = nil; AOwner: TComponent = nil);
    function Finalize: Boolean; virtual;
    procedure Free; virtual;
    function Initialize: Boolean; virtual;
    property Log: TLogNode read FLog write FLog;
    function SendString(Value: WideString): Boolean; virtual;
    function ReseiveString(var Value: WideString): Boolean; virtual;
  end;

const // Сообщения
  info_Connected     = 'TProfTcpClient: Event_Connected';
  info_Connecting    = 'TProfTcpClient: Попытка соединения с сервером. Параметры: Host="%s" Port=%s';
  info_CreateHandle  = 'TProfTcpClient: Event_CreateHandle';
  info_DestroyHandle = 'TProfTcpClient: Event_DestroyHandle';
  info_Disconnected  = 'TProfTcpClient: Event_Disconnected';
  info_Error         = 'TProfTcpClient: Event_Error. Произошла ошибка %d';
  info_NotConnected  = 'TProfTcpClient: Не соединено';
  info_Receive       = 'TProfTcpClient: Пришли данные. DataLen=%d Str=%s';
  info_Send          = 'TProfTcpClient: Посланы данные. DataLen=%d Str=%s';
  info_SendOk        = 'Сообщение передано StrLen=%d Str=%s';
  info_SendError     = 'Сообщение не передано StrLen=%d Str=%s';

implementation

{TProfTcpClient}

function TProfTcpClient.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
begin
  if Assigned(FLog) then
    Result := FLog.AddToLog2(AGroup, AType, AStrMsg, AParams)
  else
    Result := False;
end;

function TProfTcpClient.ConfigureLoad: Boolean;
begin
  Result := Assigned(FConfig);
end;

function TProfTcpClient.ConfigureSave: Boolean;
begin
  Result := Assigned(FConfig);
end;

constructor TProfTcpClient.Create(AConfig: IXmlNode = nil; ALog: TLogNode = nil; AOwner: TComponent = nil);
begin
  inherited Create(AOwner);
  FConfig := AConfig;
  FLog := ALog;
  //FClient := TTcpClient.Create(nil);
  {Установки по умолчанию}
  RemoteHost := 'localhost';
  RemotePort := '1234';
  OnCreateHandle := DoCreateHandle;
  OnDestroyHandle := DoDestroyHandle;
  OnConnect := DoConnect;
  OnDisconnect := DoDisconnect;
  OnReceive := DoReceive;
  OnSend := DoSend;
  OnError := DoError;
end;

procedure TProfTcpClient.DoConnect(Sender: TObject);
begin
  AddToLog(lgNetwork, ltInformation, info_Connected, []);
end;

procedure TProfTcpClient.DoCreateHandle(Sender: TObject);
begin
  AddToLog(lgNetwork, ltInformation, info_CreateHandle, []);
end;

procedure TProfTcpClient.DoDestroyHandle(Sender: TObject);
begin
  AddToLog(lgNetwork, ltInformation, info_DestroyHandle, []);
end;

procedure TProfTcpClient.DoDisconnect(Sender: TObject);
begin
  AddToLog(lgNetwork, ltInformation, info_Disconnected, []);
end;

procedure TProfTcpClient.DoError(Sender: TObject; SocketError: Integer);
begin
  AddToLog(lgNetwork, ltInformation, info_Error, [SocketError]);
end;

procedure TProfTcpClient.DoReceive(Sender: TObject; Buf: PAnsiChar; var DataLen: Integer);
begin
  AddToLog(lgNetwork, ltInformation, info_Receive, [DataLen, AnsiString(Buf)]);
end;

procedure TProfTcpClient.DoSend(Sender: TObject; Buf: PAnsiChar; var DataLen: Integer);
begin
  AddToLog(lgNetwork, ltInformation, info_Send, [DataLen, AnsiString(Buf)]);
end;

function TProfTcpClient.Finalize: Boolean;
begin
  Result := FInitialized;
  FInitialized := False;
  Disconnect;
end;

procedure TProfTcpClient.Free;
begin
  //FClient.Free;
  inherited Free;
end;

function TProfTcpClient.Initialize: Boolean;
begin
  Result := not(FInitialized);
  FInitialized := True;
  AddToLog(lgNetwork, ltInformation, info_Connecting, [RemoteHost, RemotePort]);
  Result := Connect;
  if Result then
    AddToLog(lgNetwork, ltInformation, info_Connected, [])
  else
    AddToLog(lgNetwork, ltInformation, info_NotConnected, []);
end;

function TProfTcpClient.ReseiveString(var Value: WideString): Boolean;
var
  L: UInt32;
  Buf: WideString;
{var
  L: UInt32;
  P: PChar;}
begin
  ReceiveBuf(L, SizeOf(L));
  SetLength(Buf, L + 1);
  ReceiveBuf(Buf, (L + 1) * 2);
  {L := StrLen(P) + 1;
  Result := (ReceiveBuf(P, L) = L);}
end;

function TProfTcpClient.SendString(Value: WideString): Boolean;
var
  L: UInt32;
  Buf: WideString;
  {P: PChar;}
begin
  try
    {Посылка строки. Первые 4 байта - колличество передаваемых символов.
    На каждый символ отводится 2 байта (16 бит).
    Последние 2 байта завершающие = #00#00}
    L := Length(Value);
    Result := (SendBuf(L, SizeOf(L)) = SizeOf(L));
    Buf := Value;
    L := (Length(Value) + 1) * 2;
    Result := (SendBuf(Buf, L) = L);
  except
    Result := False;
  end;

  if Result then
    AddToLog(lgNetwork, ltInformation, info_SendOk, [L, Value])
  else
    AddToLog(lgNetwork, ltError, info_SendError, [L, Value]);

  {L := StrLen(Value) + 1;
  Result := (SendBuf(P, L) = L);}
end;

end.

{
0.0.0.4 - 03.02.2006 - Globals
0.0.0.3 - 08.01.2006
0.0.0.2 - 04.01.2006
0.0.0.1 - 23.10.2005
}