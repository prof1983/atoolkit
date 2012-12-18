{**
@Abstract Оболочка для TCP/IP соединения (Client)
@Author Prof1983 <prof1983@ya.ru>
@Created 23.10.2005
@LastMod 18.12.2012
}
unit ANetTcpClient;

interface

uses
  Classes, Sockets, SysUtils, XmlIntf,
  ABase,
  ALogNodeUtils,
  ATypes;

type
  TProfTcpClient = class(TTcpClient)
  private
    FConfig: IXmlNode;
    FInitialized: Boolean;
    FLog: ALogNode;
  protected
    procedure DoConnect(Sender: TObject); //virtual;
    procedure DoDisconnect(Sender: TObject); //virtual;
    procedure DoCreateHandle(Sender: TObject); //virtual;
    procedure DoDestroyHandle(Sender: TObject); //virtual;
    procedure DoReceive(Sender: TObject; Buf: PAnsiChar; var DataLen: Integer);
    procedure DoSend(Sender: TObject; Buf: PAnsiChar; var DataLen: Integer);
    procedure DoError(Sender: TObject; SocketError: Integer);
  public
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: APascalString): AInt;
    function ConfigureLoad: Boolean; virtual;
    function ConfigureSave: Boolean; virtual;
    function Finalize: Boolean; virtual;
    function Initialize: Boolean; virtual;
    function SendString(Value: WideString): Boolean; virtual;
    function ReseiveString(var Value: WideString): Boolean; virtual;
  public
    constructor Create(Owner: TComponent = nil);
    procedure Free(); virtual;
  public
    property Config: IXmlNode read FConfig write FConfig;
    property Log: ALogNode read FLog write FLog;
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

function TProfTcpClient.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: APascalString): AInt;
begin
  if (FLog = 0) then
  begin
    Result := -1;
    Exit;
  end;
  Result := ALogNode_AddToLogP(FLog, LogGroup, LogType, StrMsg);
end;

function TProfTcpClient.ConfigureLoad: Boolean;
begin
  Result := Assigned(FConfig);
end;

function TProfTcpClient.ConfigureSave: Boolean;
begin
  Result := Assigned(FConfig);
end;

constructor TProfTcpClient.Create(Owner: TComponent);
begin
  inherited Create(Owner);
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
  AddToLog(lgNetwork, ltInformation, info_Connected);
end;

procedure TProfTcpClient.DoCreateHandle(Sender: TObject);
begin
  AddToLog(lgNetwork, ltInformation, info_CreateHandle);
end;

procedure TProfTcpClient.DoDestroyHandle(Sender: TObject);
begin
  AddToLog(lgNetwork, ltInformation, info_DestroyHandle);
end;

procedure TProfTcpClient.DoDisconnect(Sender: TObject);
begin
  AddToLog(lgNetwork, ltInformation, info_Disconnected);
end;

procedure TProfTcpClient.DoError(Sender: TObject; SocketError: Integer);
begin
  AddToLog(lgNetwork, ltInformation, Format(info_Error, [SocketError]));
end;

procedure TProfTcpClient.DoReceive(Sender: TObject; Buf: PAnsiChar; var DataLen: Integer);
begin
  AddToLog(lgNetwork, ltInformation, Format(info_Receive, [DataLen, AnsiString(Buf)]));
end;

procedure TProfTcpClient.DoSend(Sender: TObject; Buf: PAnsiChar; var DataLen: Integer);
begin
  AddToLog(lgNetwork, ltInformation, Format(info_Send, [DataLen, AnsiString(Buf)]));
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
  AddToLog(lgNetwork, ltInformation, Format(info_Connecting, [RemoteHost, RemotePort]));
  Result := Connect;
  if Result then
    AddToLog(lgNetwork, ltInformation, info_Connected)
  else
    AddToLog(lgNetwork, ltInformation, info_NotConnected);
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
    AddToLog(lgNetwork, ltInformation, Format(info_SendOk, [L, Value]))
  else
    AddToLog(lgNetwork, ltError, Format(info_SendError, [L, Value]));

  {L := StrLen(Value) + 1;
  Result := (SendBuf(P, L) = L);}
end;

end.
