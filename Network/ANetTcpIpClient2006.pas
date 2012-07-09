{**
@Abstract(Надстройка над модулем ATcpIpClient)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.12.2005)
@LastMod(09.07.2012)
@Version(0.5)
}
unit ANetTcpIpClient2006;

interface

uses
  SysUtils,
  AConfig2007, ALogNodeImpl, ANetTcpIpClient, ANetTcpIpGlobals, ATypes;

type
  TProfTcpIpClient = class(TTcpIpClient)
  private
    FConfig: TConfigNode1;
    FLog: TALogNode;
    F_ServerPort: LongWord;
    F_ServerHost: String;
  protected
    function GetServerHost: String; override;
    function GetServerPort: LongWord; override;
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: String; AParams: array of const): Boolean;
    property Config: TConfigNode1 read FConfig write FConfig;
    function ConfigureLoad: Boolean;
    function ConfigureSave: Boolean;
    constructor Create(AConfig: TConfigNode1 = nil; ALog: TALogNode = nil);
    function Finalize: Boolean;
    procedure Free;
    function Initialize: Boolean;
    property Log: TALogNode read FLog write FLog;
    function SendMessage(AMsg: String): Boolean;
    property _ServerHost: String read F_ServerHost write F_ServerHost;
    property _ServerPort: LongWord read F_ServerPort write F_ServerPort;
  end;

implementation

{ TProfTcpIpClient }

function TProfTcpIpClient.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
begin
  if Assigned(FLog) then
    Result := FLog.AddToLog2(AGroup, AType, AStrMsg, AParams)
  else
    Result := False;
end;

function TProfTcpIpClient.ConfigureLoad: Boolean;
var
  I: Int32;
  S: WideString;
begin
  Result := Assigned(FConfig);
  if not(Result) then Exit;
  {Self.TimerInterval
  Self.WaitIOTimeout
  Self.MaxMsgLength
  Self.Version
  Self.TimeOut}
  if Config.ReadString('ClientName', S) then ClientName := S;
  if Config.ReadInt32('ClientID', I) then ClientID := I;
  if Config.ReadString('ServerHost', S) then F_ServerHost := S;
  if Config.ReadInt32('ServerPort', I) then F_ServerPort := I;
  {Self.ServerHost
  Self.ServerPort
  Self.ClientIP}
end;

function TProfTcpIpClient.ConfigureSave: Boolean;
begin
  Result := Assigned(FConfig);
  if not(Result) then Exit;
  Config.WriteString('ClientName', ClientName);
  Config.WriteInt32('ClientID', ClientID);
  Config.WriteString('ServerHost', ServerHost);
  Config.WriteInt32('ServerPort', ServerPort);
end;

constructor TProfTcpIpClient.Create(AConfig: TConfigNode1 = nil; ALog: TALogNode = nil);
begin
  inherited Create;
  OnAddToLog := AddToLog;
  FConfig := AConfig;
  FLog := ALog;
end;

function TProfTcpIpClient.Finalize: Boolean;
begin
  Disconnect;
  Result := True;
end;

procedure TProfTcpIpClient.Free;
begin
  Finalize;
  inherited Free;
end;

function TProfTcpIpClient.GetServerHost: String;
begin
  Result := F_ServerHost;
end;

function TProfTcpIpClient.GetServerPort: LongWord;
begin
  Result := F_ServerPort;
end;

function TProfTcpIpClient.Initialize: Boolean;
begin
  Result := Connect;
end;

function TProfTcpIpClient.SendMessage(AMsg: String): Boolean;
var
  Request: TCSRequest;
begin
  Request := TCSRequest.Create;
  Request.Method := mrtPost;
  Request.Command := AMsg;
  Result := Self.SendRequest(Request);
  FreeAndNil(Request);
end;

end.

