{**
@Author Prof1983 <prof1983@ya.ru>
@Created 25.04.2006
@LastMod 04.05.2012
}
unit ANetTcpIpClient;

// TODO: string -> AnsiString

interface

uses
  Windows, SysUtils, Classes, WinSock, ActiveX,
  AConsts2, ANetTcpIpGlobals, AUtils1, ATypes;

type
  TTCPIPClient = class;
  TCSRequest = class;
  TCSResponse = class;

  TrqtState = (rqtWait, rqtHead, rqtBody, rqtAll);
  TCSResponse = class(TObject)
  private
    FCurState: TrqtState;
    FErrorCode: integer;
    FErrorStr: string;
    FHeadParams: TStringList;
    FBodyParams: TStringList;
    FBodyBynaryData: TMemoryStream;
    procedure Clear();
    function GetHeadParams(Index: string): string;
    function GetBodyParamsValue(Index: string): string;
    function GetBodyParamsName(Index: integer): string;
    function GetBodyParamsCount: integer;
  public
    constructor Create();
    destructor Destroy(); override;
  public
    property ErrorCode: integer read FErrorCode write FErrorCode;               // Код ошибки
    property ErrorStr: string read FErrorStr write FErrorStr;                   // Описание кода ошибки
  public
    property HeadParams[Index: string]: string read GetHeadParams;              // Параметры заголовка
    property BodyParamsCount: integer read GetBodyParamsCount;                  // Количество параметров
    property BodyParamsName[Index: integer]: string read GetBodyParamsName;     // Наименования параметров
    property BodyParamsValue[Index: string]: string read GetBodyParamsValue;    // Параметры запроса
    property BodyBynaryData: TMemoryStream read FBodyBynaryData;                // Данные запроса
  end;

  TCSRequest = class(TObject)
  private
    FMethod: TMethodRequest;
    FCommand: string;
    FHeadParams: TStringList;
    FBodyParams: TStringList;
    FBodyBynaryData: TMemoryStream;
    function GetHeadParams(Index: string): string;
    procedure SetHeadParams(Index: string; Value: string);
    function GetBodyParamsValue(Index: string): string;
    procedure SetBodyParamsValue(Index: string; Value: string);
    function GetBodyParamsName(Index: integer): string;
    function GetBodyParamsCount: integer;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure Clear();
  public
    property Method: TMethodRequest read FMethod write FMethod;                 // Тип метода запроса
    property Command: string read FCommand write FCommand;                      // Команда запроса
  public
                                                                                // Параметры заголовка
    property HeadParams[Index: string]: string read GetHeadParams write SetHeadParams;
    property BodyParamsCount: integer read GetBodyParamsCount;                  // Количество параметров
    property BodyParamsName[Index: integer]: string read GetBodyParamsName;     // Наименования параметров
                                                                                // Параметры запроса
    property BodyParamsValue[Index: string]: string read GetBodyParamsValue write SetBodyParamsValue;
    property BodyBynaryData: TMemoryStream read FBodyBynaryData;                // Данные запроса
  end;

  TTcpIpClient = class(TObject)
  private
    FCheckReconnectThHandle: THandle;
    FRequest: TCSRequest;
    FResponse: TCSResponse;
    FWaitResponse: TCSResponse;    
    FWaitMsgCommand: string;
    FWaitIOTimeout: LongWord;
    FTimeOut: LongWord;
    FMainThHandle: integer;
    FMainThIndex: LongWord;
    FInBuffer: string;
    FCurBufPos: integer;
    FCSSocket: TRTLCriticalSection;
    FCSMessage: TRTLCriticalSection;
    FCSAddToLog: TRTLCriticalSection;
    FVerData: TWSAData;
    FActive: boolean;
    FMessageEvent: THandle;
    FStopEvent: THandle;
    FSockEvents: THandle;
    FTimeEvent: THandle;
    FSocket: TSocket;
    FMaxMsgLength: integer;
    FClientIP: string;
    FClientHost: string;
    FClientPort: LongWord;
    FClientName: string;
    FClientID: LongWord;
    FServerName: string;
    FServerID: LongWord;
    FServerPort: LongWord;
    FServerHost: string;
    FTimerInterval: LongWord;
    FVersion: word;
    FOnAddToLog: TAddToLog;
    procedure SetClientName(Value: string);
    procedure SetClientID(Value: LongWord);
    procedure SetMaxMsgLength(Value: Integer);
    procedure SetWaitIOTimeout(Value: LongWord);
    procedure Execute;
    procedure ReadData();
    function SendBuffer(const ABuf: pointer; const ALength: LongWord): boolean;
    procedure ProcessQuery();
    procedure TruncateBuffer(APosTrunc: integer);
    function GetCaptionResponse(): boolean;
    function GetHeadResponse(): boolean;
    function GetBodyResponse(): boolean;
    function CheckParamResponse(): boolean;
    procedure LostConnect();
    procedure RestoreConnect();
    procedure CheckReconnect();
  protected
    function GetServerPort(): LongWord; virtual; abstract;
    function GetServerHost(): string; virtual; abstract;
  protected                                                                     // Логирование сообщений
    procedure AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const);
    procedure DoBeforeConnect(); virtual;                                       // Срабатывает при инициализации подключения
    procedure DoAfterConnect(); virtual;                                        // Срабатывает при успешном подключении
    procedure DoLostConnect(); virtual;                                         // Срабатывает при потере связи с сервером
    procedure DoReConnect(); virtual;                                           // Срабатывает при успешном востановлении связи
    procedure DoTimer(); virtual;                                               // Срабатывание таймера
    procedure DoProcessResponse(const AResponse: TCSResponse); virtual;         // Срабатывает при асинхронном получении сообщения
    procedure DoBeforeDisconnect(); virtual;                                    // Срабатывает при инициализации отключении
    procedure DoAfterDisconnect(); virtual;                                     // Срабатывает при отключении
  protected
    property TimerInterval: LongWord read FTimerInterval write FTimerInterval;  // Время срабатывания таймера в мс
    property WaitIOTimeout: LongWord read FWaitIOTimeout write SetWaitIOTimeout;// Максимальное время ожидания операций чтения, записи
    property MaxMsgLength: Integer read FMaxMsgLength write SetMaxMsgLength;    // Максимальная длинна принимаемого сообщения
    property Version: word read FVersion write FVersion;                        // Версия поддерживаемого протокола
    property TimeOut: LongWord read FTimeOut write FTimeOut;                    // Время ожидания ответа сервера (в мс)
  protected
    function SendRequest(ARequest: TCSRequest): boolean;                        // Послать запрос серверу
                                                                                // Ожидание сообщения
    function WaitMessage(const AMsgCommand: string; var AMsg: TCSResponse): boolean;
    property Request: TCSRequest read FRequest;                                 // Вспомогательная переменная
  public
    constructor Create();
    destructor Destroy(); override;
    function Connect(): boolean;                                                // Соединение с сервером
    procedure Disconnect();                                                     // Отсоединение от сервера
    function TestConnect(): boolean;                                            // Проверить соединение с сервером
  public
    property ClientName: string read FClientName write SetClientName;           // Название клиента
    property ClientID: LongWord read FClientID write SetClientID;               // Уникальный номер клиента
    property ServerHost: string read GetServerHost;                             // Адресс сервера
    property ServerPort: LongWord read GetServerPort;                           // Серверный порт
  public
    property ClientIP: string read FClientIP;                                   // Текущий IP адресс клиента
    property ClientHost: string read FClientHost;                               // Текущий Host клиента
    property ClientPort: LongWord read FClientPort;                             // Текущий порт клиента
    property Active: boolean read FActive;                                      // Признак подключения к серверу
    property ServerName: string read FServerName;                               // Наименование сервера
    property ServerID: LongWord read FServerID;                                 // Уникальный номер сервера
  public
    property OnAddToLog: TAddToLog read FOnAddToLog write FOnAddToLog;          // Для логирования сообщений
  end;

implementation

const // Информационный сообщения
  info_WinSock_Dll      = 'Библиотека WinSock: version - %d.%d (%d.%d), description - "%s".';
  info_Try_Start        = '--> Инициализация клиента с параметрами: name - "%s", id - "%d".';
  info_Try_Start_1      = '--> Параметры сервера: server_host - "%s", server_port - "%d".';
  info_Try_Start_2      = '--> Версия протокола: "%d.%d".';
  info_Create_Socket    = 'Сокет создан успешно: handle - "%d".';
  info_Close_Socket     = 'Закрываем сокет: handle - "%d".';
  info_Client_Start     = '--> Клиент успешно подключен к серверу: server_name - "%s", server_id - "%d".';
  info_Try_Stop_Client  = '--> Отключение клиента от сервера.';
  info_Client_Stop      = '--> Клиент успешно отключен от сервера.';
  info_Get_Client_Info  = 'Параметры клиента: host - "%s", ip - "%s", port - "%d".';
  info_Create_Ev_Sock   = 'Сокетное событие создано успешно: handle - "%d".';
  info_Close_Ev_Sock    = 'Закрываем сокетное событие: handle - "%d".';
  info_Create_Ev_Stop   = 'Событие остановки создано успешно: handle - "%d".';
  info_Close_Ev_Stop    = 'Закрываем событие остановки: handle - "%d".';
  info_Create_Ev_Msg    = 'Событие ожидания сообщения создано успешно: handle - "%d".';
  info_Close_Ev_Msg     = 'Закрываем событие ожидания сообщения: handle - "%d".';
  info_Start_Thread     = 'Основной поток запущен: handle - "%d", id - "%d".';
  info_Stop_Thread      = 'Останавливаем основной поток: handle - "%d", id - "%d".';
  info_Start_Timer      = 'Таймер создан успешно: handle - "%d", interval - "%d".';
  info_Stop_Timer       = 'Закрываем таймер: handle - "%d", interval - "%d".';
  info_Stop_Work_Thread = 'Основной поток остановлен: handle - "%d", id - "%d".';
  info_Create_Buf_Read  = 'Буфер первичного приема создан успешно: mem_size - "%d".';
  info_Restore_Connect  = '--> Связь с сервером успешно востановлена: socket - "%d"';
  info_Test_Connect     = 'Запрос на тест связи.';
  info_Set_Param        = 'Параметр "%s" установлен успешно.';  

const // Предупреждающие сообщения
  warn_Try_ReConnect    = '--> Попытка востановить подключение.';
  warn_Server_Host      = 'Изменилось имя хоста сервера: old_host - "%s", new_host - "%s".';
  warn_Server_Port      = 'Изменился порт сервера: old_port - "%d", new_port - "%d".';

const // Сообщения об ошибках
  err_Init_Dll_Sock     = 'Библиотека WinSock не инициализированна!';
  err_Create_Socket     = 'Ошибка создания клиентского сокета: "%s".';
  err_ServPort_NotDef   = 'Серверный порт не определен.';
  err_ServHost_NotDef   = 'Серверный хост не определен.';
  err_Not_Change_Port   = 'Нельзя менять номер серверного порта при активном клиенте!';
  err_Not_Change_Host   = 'Нельзя менять серверный хост при активном клиенте!';
  err_Not_Change_Name   = 'Нельзя менять наименование при активном клиенте!';
  err_Not_Change_ID     = 'Нельзя менять уникальный номер при активном клиенте!';
  err_Not_Change_MaxMsg = 'Нельзя менять максимальный размер сообщения при активном клиенте!';
  err_Connect_Server    = 'Ошибка соединения с сервером: handle - "%d", server_host - "%s", server_port - "%d", "%s".';
  err_Get_Client_Info   = 'Ошибка получения дополнительной информации: "%s".';
  err_Create_Ev_Sock    = 'Ошибка создания сокетного события: handle - "%d", "%s".';
  err_Create_Ev_Stop    = 'Ошибка создания события остановки: "%s".';
  err_Create_Ev_Msg     = 'Ошибка создания события ожидания сообщения: "%s".';
  err_Create_Ev_Time    = 'Ошибка создания таймера: handle - "%d", "%s".';
  err_Not_DefName       = 'Не определено наименование клиента.';
  err_Not_DefID         = 'Не определен уникальный номер клиента.';
  err_Request           = 'Ошибка обработки данных: ошибка сервера: code - "%d", "%s".';
  err_Server_Name       = 'Ошибка обработки данных: неуказано наименование сервера.';
  err_Server_ID         = 'Ошибка обработки данных: неуказан уникальный номер сервера.';
  err_Server_ID_Change  = 'Ошибка обработки данных: ожидался уникальный номер сервера "%d" вместо "%d".';
  err_Stop_Work_Thread  = 'Ошибка остановки основного потока: handle - "%d", id - "%d".';
  err_Start_Thread      = 'Ошибка запуска основного потока.';
  err_Test_Connect      = 'Ошибка проверки подключения к серверу.';
  err_Common_Send       = 'Ошибка посылки запроса: msg_id - "%d", msg_len - "%d", "%s".';
  err_Lost_Connect      = '--> Связь с серером "%s" потеряна.';
  err_Write_Data        = 'Ошибка отправки данных: function - "%s", err_code - "%d", "%s".';
  err_Read_Data         = 'Ошибка чтения данных: function - "%s", socket - "%d", err_code - "%d", "%s".';
  err_Read_Length       = 'Переполнение буфера: max_msg_len - "%d".';
  err_Process_Caption   = 'Ошибка обработки заголовка сообщения: неизвестный протокол "%s".';
  err_Process_Caption_1 = 'Ошибка обработки заголовка сообщения: версия "%d.%d" не поддерживается.';
  err_Process_Caption_3 = 'Ошибка обработки заголовка сообщения: неверный параметр "%s".';
  err_Set_Param         = 'Ошибка установки параметра "%s": "%s".';

// -----------------------------------------------------------------------------
function MainThread(AOwner: pointer): integer;
begin
  Result := 0;
  TTCPIPClient(AOwner).Execute();
end;

function CheckConnect(AOwner: pointer): integer;
begin
  Result := 0;
  TTCPIPClient(AOwner).CheckReconnect();
end;

{ TCSRequest }

constructor TCSRequest.Create();
begin
  inherited;
  FHeadParams := TStringList.Create();
  FBodyParams := TStringList.Create();
  FBodyBynaryData := TMemoryStream.Create();
end;

destructor TCSRequest.Destroy();
begin
  FreeAndNil(FBodyBynaryData);
  FreeAndNil(FBodyParams);
  FreeAndNil(FHeadParams);
  inherited;
end;

procedure TCSRequest.Clear();
begin
  FMethod := mrtGet;
  FCommand := '';
  FHeadParams.Clear();
  FBodyParams.Clear();
  FBodyBynaryData.SetSize(0);
  HeadParams[hdr_CONNECTION] := 'Keep-Alive';
end;

function TCSRequest.GetHeadParams(Index: string): string;
var
  n: integer;
  tmpStr: string;
begin
  Result := '';
  for n:=0 to FHeadParams.Count - 1 do
  begin
    tmpStr := FHeadParams.Strings[n];
    if (Pos(Index, tmpStr) = 1) then
    begin
      Result := Copy(tmpStr, (Pos(': ', tmpStr) + 2), Length(tmpStr));
      Exit;
    end;
  end;
end;

procedure TCSRequest.SetHeadParams(Index: string; Value: string);
var
  n: integer;
  tmpStr: string;
  tmpIndexStr: integer;
begin
  // Поищем может быть он уже есть
  tmpIndexStr := -1;
  for n:=0 to FHeadParams.Count - 1 do
  begin
    tmpStr := FHeadParams.Strings[n];
    if (Pos(Index, tmpStr) = 1) then
    begin
      tmpIndexStr := n;
      Break;
    end;
  end;
  // Добавим данные
  if (tmpIndexStr >= 0) then
  begin
    if (Value <> '') then
      FHeadParams.Strings[tmpIndexStr] := Index + ': ' + Value
    else
      FHeadParams.Delete(tmpIndexStr);
  end else
  begin
    if (Value <> '') then FHeadParams.Add(Index + ': ' + Value);
  end;
end;

function TCSRequest.GetBodyParamsValue(Index: string): string;
begin
  Result := FBodyParams.Values[Index];
end;

procedure TCSRequest.SetBodyParamsValue(Index: string; Value: string);
begin
  FBodyParams.Values[Index] := Value;
end;

function TCSRequest.GetBodyParamsName(Index: integer): string;
begin
  Result := FBodyParams.Names[Index];
end;

function TCSRequest.GetBodyParamsCount: integer;
begin
  Result := FBodyParams.Count;
end;

{ TCSResponse }

constructor TCSResponse.Create();
begin
  inherited;
  FHeadParams := TStringList.Create();
  FBodyParams := TStringList.Create();
  FBodyBynaryData := TMemoryStream.Create();
end;

destructor TCSResponse.Destroy();
begin
  FreeAndNil(FBodyBynaryData);
  FreeAndNil(FBodyParams);
  FreeAndNil(FHeadParams);
  inherited;
end;

procedure TCSResponse.Clear();
begin
  FErrorCode := 0;
  FErrorStr := '';
  FHeadParams.Clear();
  FBodyParams.Clear();
  FBodyBynaryData.SetSize(0);
end;

function TCSResponse.GetHeadParams(Index: string): string;
var
  n: integer;
  tmpStr: string;
begin
  Result := '';
  for n:=0 to FHeadParams.Count - 1 do
  begin
    tmpStr := FHeadParams.Strings[n];
    if (Pos(Index, tmpStr) = 1) then
    begin
      Result := Copy(tmpStr, (Pos(': ', tmpStr) + 2), Length(tmpStr));
      Exit;
    end;
  end;
end;

function TCSResponse.GetBodyParamsValue(Index: string): string;
begin
  Result := FBodyParams.Values[Index];
end;

function TCSResponse.GetBodyParamsName(Index: integer): string;
begin
  Result := FBodyParams.Names[Index];
end;

function TCSResponse.GetBodyParamsCount: integer;
begin
  Result := FBodyParams.Count;
end;

{ TTCPIPClient }

procedure TTcpIpClient.DoTimer();
begin
end;

procedure TTcpIpClient.DoAfterDisconnect();
begin
end;

procedure TTcpIpClient.DoBeforeDisconnect();
begin
end;

procedure TTcpIpClient.DoAfterConnect();
begin
end;

procedure TTcpIpClient.DoBeforeConnect();
begin
end;

procedure TTcpIpClient.DoProcessResponse(const AResponse: TCSResponse);
begin
end;

procedure TTcpIpClient.DoLostConnect();
begin
end;

procedure TTcpIpClient.DoReConnect();
begin
end;

procedure TTcpIpClient.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const);
begin
  if Assigned(OnAddToLog) then
  begin
    EnterCriticalSection(FCSAddToLog);
    try
      OnAddToLog(AGroup, AType, '"%d". ' + Format(AStrMsg, AParams), [LongWord(Self)]);
    except
    end;
    LeaveCriticalSection(FCSAddToLog);
  end;
end;

procedure TTcpIpClient.SetWaitIOTimeout(Value: LongWord);
begin
  InterlockedExchange(Integer(FWaitIOTimeout), Integer(Value));
end;

procedure TTcpIpClient.SetMaxMsgLength(Value: Integer);
begin
  if (Active) then Exception.Create(err_Not_Change_MaxMsg);
  FMaxMsgLength := Value;
end;

procedure TTcpIpClient.SetClientName(Value: string);
begin
  if (Active) then Exception.Create(err_Not_Change_Name);
  FClientName := Value;
end;

procedure TTcpIpClient.SetClientID(Value: LongWord);
begin
  if (Active) then Exception.Create(err_Not_Change_ID);
  FClientID := Value;
end;

constructor TTcpIpClient.Create();
var
  Version: word;
begin
  inherited;
  FActive := False;
  InitializeCriticalSection(FCSAddToLog);
  InitializeCriticalSection(FCSSocket);
  InitializeCriticalSection(FCSMessage);
  FTimeOut := 1000;
  FMessageEvent := INVALID_HANDLE_VALUE;
  FWaitMsgCommand := #1;
  TVersion(FVersion).Major := 1;
  TVersion(FVersion).Minor := 0;
  FSocket := INVALID_SOCKET;
  FSockEvents := WSA_INVALID_EVENT;
  FStopEvent := INVALID_HANDLE_VALUE;
  FTimeEvent := INVALID_HANDLE_VALUE;
  FMainThHandle := LongWord(nil);
  FMainThIndex := 0;
  FTimerInterval := 60000;
  FMaxMsgLength := 1024;
  FWaitIOTimeout := 1000;
  SetLength(FInBuffer, 0);
  FResponse := TCSResponse.Create();
  FWaitResponse := TCSResponse.Create();
  FRequest := TCSRequest.Create();
  // Инициализируем сокетную библиотеку
  Version := MakeWord(2, 0);
  if (WSAStartup(Version, FVerData)<>0) then ZeroMemory(@FVerData, SizeOf(TWSAData));
end;

destructor TTcpIpClient.Destroy();
begin
  if Active then Disconnect();
  FreeAndNil(FRequest);
  FreeAndNil(FWaitResponse);
  FreeAndNil(FResponse);
  DeleteCriticalSection(FCSMessage);
  DeleteCriticalSection(FCSSocket);
  DeleteCriticalSection(FCSAddToLog);
  // Завершаем работу с сокетной библиотекой
  WSACleanup();
  inherited;
end;

function TTcpIpClient.Connect(): boolean;
var
  tmpInt: Integer;
  SockOptInt: Integer;
  SockParam: TSockAddr;
  HostEnt: PHostEnt;
  tmp: TLargeInteger;
begin
  if Active then Disconnect();
  Result := False;
  try
    FServerName := '';
    FServerID := 0;
    FWaitMsgCommand := #1;
    DoBeforeConnect();
    // Проверим параметры
    if (FClientName = '') then raise Exception.Create(err_Not_DefName);
    if (FClientID = 0) then raise Exception.Create(err_Not_DefID);
    // Проверим что библиотека WinSock инициализирована
    if (FVerData.wVersion = 0) then raise Exception.Create(err_Init_Dll_Sock);
    AddToLog(lgNetwork, ltInformation, info_WinSock_Dll, [Lo(FVerData.wVersion), Hi(FVerData.wVersion),
                                                          Lo(FVerData.wHighVersion), Hi(FVerData.wHighVersion),
                                                          FVerData.szDescription]);
    // Проверим параметры
    FServerPort := ServerPort;
    FServerHost := ServerHost;
    if (FServerPort = 0) then raise Exception.Create(err_ServPort_NotDef);
    if (FServerHost = '') then raise Exception.Create(err_ServHost_NotDef);
    // Для информации
    AddToLog(lgNetwork, ltInformation, info_Try_Start, [FClientName, FClientID]);
    AddToLog(lgNetwork, ltInformation, info_Try_Start_1, [FServerHost, FServerPort]);
    AddToLog(lgNetwork, ltInformation, info_Try_Start_2, [TVersion(FVersion).Major, TVersion(FVersion).Minor]);
    // Создаем сокет
    FSocket := WSASocket(AF_INET, SOCK_STREAM, IPPROTO_IP, nil, 0, WSA_FLAG_OVERLAPPED);
    if (FSocket = INVALID_SOCKET) then raise Exception.CreateFmt(err_Create_Socket, [SysErrorMessage(WSAGetLastError())]);
    AddToLog(lgNetwork, ltInformation, info_Create_Socket, [FSocket]);
    // Устанавливаем опцию SO_RCVBUF
    SockOptInt := 1024 * 5;
    if (SetSockOpt(FSocket, SOL_SOCKET, SO_RCVBUF, PAnsiChar(@SockOptInt), SizeOf(SockOptInt)) <> 0) then
      raise Exception.CreateFmt(err_Set_Param, ['SO_RCVBUF', SysErrorMessage(WSAGetLastError())]);
    AddToLog(lgNetwork, ltInformation, info_Set_Param, ['SO_RCVBUF']);
    // Устанавливаем опцию SO_SNDBUF
    SockOptInt := 1024 * 5;
    if (SetSockOpt(FSocket, SOL_SOCKET, SO_SNDBUF, PAnsiChar(@SockOptInt), SizeOf(SockOptInt)) <> 0) then
      raise Exception.CreateFmt(err_Set_Param, ['SO_SNDBUF', SysErrorMessage(WSAGetLastError())]);
    AddToLog(lgNetwork, ltInformation, info_Set_Param, ['SO_SNDBUF']);
    // Устанавливаем семейство протоколов
    SockParam.sin_family := AF_INET;
    // устанавливаем номер порта для сокета
    SockParam.sin_port := hToNs(FServerPort);
    // устанавливаем IP для связи
    SockParam.sin_addr := TInAddr(iNet_Addr(PAnsiChar(GetStrIpAddress(FServerHost))));
    // Соеденяемся с сервером
    if (WinSock.Connect(FSocket, SockParam, SizeOf(SockParam)) <> 0) then
      raise Exception.CreateFmt(err_Connect_Server, [FSocket, FServerHost, FServerPort, SysErrorMessage(WSAGetLastError())]);
    // Получим дополнительные параметры сокета
    tmpInt := SizeOf(SockParam);
    if (GetSockName(FSocket, SockParam, tmpInt) <> 0) then
      raise Exception.CreateFmt(err_Get_Client_Info, [SysErrorMessage(WSAGetLastError())]);
    HostEnt := GetHostByAddr(@SockParam.sin_addr, SizeOf(TInAddr), AF_INET);
    FClientIP := iNet_ntoa(SockParam.sin_addr);
    FClientHost := HostEnt^.h_name;
    FClientPort := nToHs(SockParam.sin_port);
    AddToLog(lgNetwork, ltInformation, info_Get_Client_Info, [FClientHost, FClientIP, FClientPort]);
    // Создаем событие сокета
    FSockEvents := WSACreateEvent;
    if (FSockEvents = WSA_INVALID_EVENT) then
      raise Exception.CreateFmt(err_Create_Ev_Sock, [FSockEvents, SysErrorMessage(WSAGetLastError())]);
    // Устанавливаем маску события
    if (WSAEventSelect(FSocket, FSockEvents, FD_CLOSE or FD_READ) = SOCKET_ERROR) then
      raise Exception.CreateFmt(err_Create_Ev_Sock, [FSockEvents, SysErrorMessage(WSAGetLastError())]);
    AddToLog(lgNetwork, ltInformation, info_Create_Ev_Sock, [FSockEvents]);
    // Создаем событие остановки клиента
    FStopEvent := CreateEvent(nil, True, False, nil);
    if (FStopEvent = INVALID_HANDLE_VALUE) then
      raise Exception.CreateFmt(err_Create_Ev_Stop, [SysErrorMessage(GetLastError())]);
    AddToLog(lgNetwork, ltInformation, info_Create_Ev_Stop, [FStopEvent]);
    // Создаем событие синхронного чтения
    FMessageEvent := CreateEvent(nil, False, False, nil);
    if (FMessageEvent = INVALID_HANDLE_VALUE) then
      raise Exception.CreateFmt(err_Create_Ev_Msg, [SysErrorMessage(GetLastError())]);
    AddToLog(lgNetwork, ltInformation, info_Create_Ev_Msg, [FMessageEvent]);
    // Инициализируем буфер приема
    FCurBufPos := 0;
    SetLength(FInBuffer, FMaxMsgLength * 2);
    ZeroMemory(@FInBuffer[1], FMaxMsgLength * 2);
    AddToLog(lgNetwork, ltInformation, info_Create_Buf_Read, [FMaxMsgLength]);    
    // Создаем событие таймера
    FTimeEvent := CreateWaitableTimer(nil, False, nil);
    if (FTimeEvent = INVALID_HANDLE_VALUE) then
      raise Exception.CreateFmt(err_Create_Ev_Time, [FTimeEvent, SysErrorMessage(GetLastError())]);
    // Устанавливаем таймер
    tmp := 0;
    if (not SetWaitableTimer(FTimeEvent, tmp, FTimerInterval, nil, nil, False)) then
      raise Exception.CreateFmt(err_Create_Ev_Time, [FTimeEvent, SysErrorMessage(GetLastError())]);
    AddToLog(lgNetwork, ltInformation, info_Start_Timer, [FTimeEvent, FTimerInterval]);
    // Запускаем рабочий поток
    FMainThHandle := BeginThread(nil, 0, MainThread, Self, 0, FMainThIndex);
    if (FMainThHandle = 0) then
      raise Exception.Create(err_Start_Thread);
    AddToLog(lgNetwork, ltInformation, info_Start_Thread, [FMainThHandle, FMainThIndex]);
    // Проверим подключение к серверу
    if (not TestConnect()) then
      raise Exception.Create(err_Test_Connect);
    AddToLog(lgNetwork, ltInformation, info_Client_Start, [ServerName, ServerID]);
    // Дальнейшая обработка
    DoAfterConnect();
    // Если здесь, то все ОК
    FActive := True;
    Result := True;
  except
    on E: Exception do
    begin
      AddToLog(lgNetwork, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'Connect()']);
      Disconnect();
    end;
  end;
end;

procedure TTcpIpClient.Disconnect();
begin
  try
    if Active then
    begin
      DoBeforeDisconnect();
      AddToLog(lgNetwork, ltInformation, info_Try_Stop_Client, []);
    end;
    // Останавливаем поток
    if (FMainThHandle <> 0) then
    begin
      SetEvent(FStopEvent);
      if (WaitForSingleObject(FMainThHandle, 10000) = WAIT_TIMEOUT) then
        AddToLog(lgNetwork, ltError, err_Stop_Work_Thread, [FMainThHandle, FMainThIndex])
      else
        AddToLog(lgNetwork, ltInformation, info_Stop_Work_Thread, [FMainThIndex, FMainThHandle]);
      CloseHandle(FMainThHandle);
      FMainThHandle := LongWord(nil);
      FMainThIndex := 0;
    end;
    // Закрываем таймер
    if (FTimeEvent <> INVALID_HANDLE_VALUE) then
    begin
      AddToLog(lgNetwork, ltInformation, info_Stop_Timer, [FTimeEvent, FTimerInterval]);
      CancelWaitableTimer(FTimeEvent);
      CloseHandle(FTimeEvent);
      FTimeEvent := INVALID_HANDLE_VALUE;
    end;
    // Закрываем событие синхронного чтения
    if (FMessageEvent <> INVALID_HANDLE_VALUE) then
    begin
      AddToLog(lgNetwork, ltInformation, info_Close_Ev_Msg, [FMessageEvent]);
      CloseHandle(FMessageEvent);
      FMessageEvent := INVALID_HANDLE_VALUE;
    end;
    // Закрываем событие остановки
    if (FStopEvent <> INVALID_HANDLE_VALUE) then
    begin
      AddToLog(lgNetwork, ltInformation, info_Close_Ev_Stop, [FStopEvent]);
      CloseHandle(FStopEvent);
      FStopEvent := INVALID_HANDLE_VALUE;
    end;
    // Закрываем сокетное событие
    if (FSockEvents <> WSA_INVALID_EVENT) then
    begin
      AddToLog(lgNetwork, ltInformation, info_Close_Ev_Sock, [FSockEvents]);
      if (FSocket <> INVALID_SOCKET) then WSAEventSelect(FSocket, FSockEvents, 0);
      WSACloseEvent(FSockEvents);
      FSockEvents := WSA_INVALID_EVENT;
    end;
    // Закрываем сокет
    if (FSocket <> INVALID_SOCKET) then
    begin
      AddToLog(lgNetwork, ltInformation, info_Close_Socket, [FSocket]);
      ShutDown(FSocket, SD_SEND);
      CloseSocket(FSocket);
      FSocket := INVALID_SOCKET;
    end;
    // Очищаем данные
    FServerName := '';
    FServerID := 0;
    FWaitMsgCommand := #1;
    // Все ОК
    if Active then
    begin
      AddToLog(lgNetwork, ltInformation, info_Client_Stop, []);
      DoAfterDisconnect();
    end;
  except
    on E: Exception do AddToLog(lgNetwork, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'Disconnect()']);
  end;
  SetLength(FInBuffer, 0);  
  FClientPort := 0;
  FClientIP := '';
  FClientHost := '';
  FActive := False;
end;

function TTcpIpClient.SendBuffer(const ABuf: pointer; const ALength: LongWord): boolean;
var
  tmpCnt: integer;
  tmpCurBuf: pointer;
  tmpResult: integer;
  tmpError: integer;
  tmpErrCount: integer;
begin
  Result := False;
  try
    EnterCriticalSection(FCSSocket);
    try
      tmpCnt := ALength;
      tmpCurBuf := ABuf;
      tmpErrCount := 0;
      repeat
        tmpResult := Send(FSocket, tmpCurBuf^, tmpCnt, 0);
        if (tmpResult <> SOCKET_ERROR) then
        begin
          LongWord(tmpCurBuf) := LongWord(tmpCurBuf) + LongWord(tmpResult);
          tmpCnt := tmpCnt - tmpResult;
        end else
        begin
          tmpError := WSAGetLastError();
          if (tmpError <> WSAEWOULDBLOCK) then Inc(tmpErrCount);
          Sleep(10);
        end;
      until (tmpCnt = 0)or(tmpErrCount > 5);
      Result := (tmpCnt = 0)and(tmpErrCount <= 5);
      if not Result then
      begin
        tmpError := WSAGetLastError();
        raise Exception.CreateFmt(err_Write_Data, ['Send', tmpError, SysErrorMessage(tmpError)]);
      end;
    finally
      LeaveCriticalSection(FCSSocket);
    end;
  except
    on E: Exception do AddToLog(lgNetwork, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'SendBuffer()']);
  end;
end;

function TTcpIpClient.SendRequest(ARequest: TCSRequest): boolean;
var
  tmpSendString: string;
  tmpParamStr: string;
  n: integer;

  function CalcContentLength(): integer;
  begin
    Result := ARequest.BodyBynaryData.Size;
    if (Result <> 0) then Exit;
    Result := Length(tmpParamStr);
  end;

begin
  Result := False;
  try
    // Сформируем строку с параметрами
    tmpParamStr := '';
    if (ARequest.FBodyParams.Count <> 0) then
    begin
      tmpParamStr := HTTPEncode(ARequest.FBodyParams.Names[0]) + '=' +
                     HTTPEncode(ARequest.FBodyParams.Values[ARequest.FBodyParams.Names[0]]);
      for n:=1 to (ARequest.FBodyParams.Count - 1) do
        tmpParamStr := tmpParamStr + '&' + HTTPEncode(ARequest.FBodyParams.Names[n]) + '=' +
                                           HTTPEncode(ARequest.FBodyParams.Values[ARequest.FBodyParams.Names[n]]);
    end;
    // Добавим обязательные параметры
    ARequest.HeadParams[hdr_USER_AGENT] := ClientName;
    ARequest.HeadParams[hdr_USER_ID] := IntToStr(ClientID);
    ARequest.HeadParams[hdr_CONTENT_LENGTH] := IntToStr(CalcContentLength());
    if (ARequest.FBodyParams.Count <> 0) then
      ARequest.HeadParams[hdr_CONTENT_TYPE] := mime_APP_WWW_FORM;
    // Сформируем заголовок сообщения
    tmpSendString := Format(hdr_CS_SEND_CAPTION, [METHOD_NAME[ARequest.Method],
                                                  ARequest.Command,
                                                  TVersion(Version).Major,
                                                  TVersion(Version).Minor]);
    tmpSendString := tmpSendString + #$D#$A + ARequest.FHeadParams.Text + #$D#$A;
    // Отправим заголовок
    if (not SendBuffer(Pointer(tmpSendString), Length(tmpSendString))) then Exit;
    // Отправим именованные параметры
    if (ARequest.FBodyParams.Count <> 0) then
    begin
      if (not SendBuffer(Pointer(tmpParamStr), Length(tmpParamStr))) then Exit;
      Result := True;
      Exit;
    end;
    // Отправим тело сообщения
    if (ARequest.BodyBynaryData.Size <> 0) then
    begin
      if (not SendBuffer(ARequest.BodyBynaryData.Memory, ARequest.BodyBynaryData.Size)) then Exit;
      Result := True;
      Exit;
    end;
    Result := True;
  except
    on E: Exception do AddToLog(lgNetwork, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'SendRequest()']);
  end;
end;

procedure TTcpIpClient.ReadData();
var
  tmpCnt: integer;
  tmpResult: integer;
  tmpError: integer;
begin
  try
    EnterCriticalSection(FCSSocket);
    try
      // Посмотрим сколько данных в буфере
      IOCtlSocket(FSocket, FIONREAD, tmpCnt);
      if (tmpCnt <= 0) then Exit;
      // Проверим что-бы не вылететь за границы
      if (tmpCnt > (FMaxMsgLength * 2 - FCurBufPos - 1)) then tmpCnt := (FMaxMsgLength * 2 - FCurBufPos - 1);
      // Зачитаем данные
      tmpResult := Recv(FSocket, (@FInBuffer[FCurBufPos + 1])^, tmpCnt, 0);
      if (tmpResult = SOCKET_ERROR) then
      begin
        tmpError := WSAGetLastError();
        raise Exception.CreateFmt(err_Read_Data, ['Recv', FSocket, tmpError, SysErrorMessage(tmpError)]);
      end;
      Inc(FCurBufPos, tmpCnt);
      // Передадим на дальнейшую обработку
      ProcessQuery();
    finally
      LeaveCriticalSection(FCSSocket);
    end;
  except
    on E: Exception do AddToLog(lgNetwork, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'ReadData()']);
  end;
end;

function TTcpIpClient.WaitMessage(const AMsgCommand: string; var AMsg: TCSResponse): boolean;
begin
  Result := False;
  AMsg := nil;
  EnterCriticalSection(FCSMessage);
  FWaitMsgCommand := AMsgCommand;
  LeaveCriticalSection(FCSMessage);
  ResetEvent(FMessageEvent);
  if (WaitForSingleObject(FMessageEvent, FTimeOut) = WAIT_OBJECT_0) then
  begin
    EnterCriticalSection(FCSMessage);
    FWaitResponse.Clear();
    FWaitResponse.FErrorCode := FResponse.ErrorCode;
    FWaitResponse.FErrorStr := FResponse.ErrorStr;
    FWaitResponse.FHeadParams.Assign(FResponse.FHeadParams);
    FWaitResponse.FBodyParams.Assign(FResponse.FBodyParams);
    FWaitResponse.FBodyBynaryData.LoadFromStream(FResponse.FBodyBynaryData);
    FResponse.FBodyBynaryData.Position := 0;
    AMsg := FWaitResponse;
    LeaveCriticalSection(FCSMessage);
    Result := True;
  end;
  FWaitMsgCommand := #1;
end;

procedure TTcpIpClient.TruncateBuffer(APosTrunc: integer);
begin
  Move(Pointer(@FInBuffer[APosTrunc])^, Pointer(@FInBuffer[1])^, (FCurBufPos - APosTrunc + 1));
  Dec(FCurBufPos, (APosTrunc - 1));
  ZeroMemory(@FInBuffer[FCurBufPos + 1], APosTrunc);
end;

function TTcpIpClient.GetCaptionResponse(): boolean;
var
  tmpInt: integer;
  tmpCaptionStr: string;
  tmpPChar: PChar;
  tmpStr: string;
  tmpVersion: word;
begin
  Result := False;
  try
    // Выделим заголовок сообщения
    tmpInt := Pos(#$D#$A, FInBuffer); if (tmpInt = 0) then Exit;
    tmpCaptionStr := Copy(FInBuffer, 1, tmpInt - 1);
    tmpPChar := Pointer(tmpCaptionStr);
    // Удалим из буффера обработанную информацию
    TruncateBuffer(tmpInt + 2);
    // Выделим протокол
    tmpInt := Pos('/', tmpPChar); if (tmpInt = 0) then Exit;
    tmpStr := Copy(tmpPChar, 1, tmpInt - 1);
    if (tmpStr <> PROTOCOL_NAME[ptASTP]) then
      raise Exception.CreateFmt(err_Process_Caption, [tmpStr]);
    Inc(tmpPChar, tmpInt);
    // Выделим версию протокола
    tmpInt := Pos('.', tmpPChar); if (tmpInt = 0) then Exit;
    TVersion(tmpVersion).Major := StrToInt(Copy(tmpPChar, 1, tmpInt - 1));
    Inc(tmpPChar, tmpInt);
    tmpInt := Pos(' ', tmpPChar); if (tmpInt = 0) then Exit;
    TVersion(tmpVersion).Minor := StrToInt(Copy(tmpPChar, 1, tmpInt - 1));
    Inc(tmpPChar, tmpInt);
    // Проверим версию протокола
    if (tmpVersion <> Version) then
      raise Exception.CreateFmt(err_Process_Caption_1, [TVersion(tmpVersion).Major, TVersion(tmpVersion).Minor]);
    // Выделим код ошибки
    tmpInt := Pos(' ', tmpPChar); if (tmpInt = 0) then Exit;
    FResponse.FErrorCode := StrToInt(Copy(tmpPChar, 1, tmpInt - 1));
    Inc(tmpPChar, tmpInt);
    // Выделим текстовое описание ошибки
    FResponse.FErrorStr := tmpPChar;
    // Если здесь, то все ОК
    Result := True;
  except
    on E: Exception do AddToLog(lgNetwork, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'GetCaptionResponse()']);
  end;
end;

function TTcpIpClient.GetHeadResponse(): boolean;
var
  tmpHeadStr: string;
  tmpStr: string;
  tmpPChar: PChar;
  tmpInt: integer;
begin
  Result := False;
  try
    // Выделим голову сообщения
    tmpInt := Pos(#$D#$A#$D#$A, FInBuffer); if (tmpInt = 0) then Exit;
    tmpHeadStr := Copy(FInBuffer, 1, tmpInt + 1);
    tmpPChar := Pointer(tmpHeadStr);
    // Удалим из буффера обработанную информацию
    TruncateBuffer(tmpInt + 4);
    // Обработаем все элементы
    while (Length(tmpPChar) <> 0) do
    begin
      // Определяем конец строки
      tmpInt := Pos(#$D#$A, tmpPChar);
      // Копируем строку
      tmpStr := Copy(tmpPChar, 1, tmpInt - 1);
      // Переходим к следующей строке
      Inc(tmpPChar, (tmpInt + 1));
      // Обрабатываем полученную строку
      if (Pos(': ', tmpStr) = 0) then
        raise Exception.CreateFmt(err_Process_Caption_3, [tmpStr]);
      FResponse.FHeadParams.Add(tmpStr);
    end;
    Result := True;
  except
    on E: Exception do AddToLog(lgNetwork, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'GetHeadResponse()']);
  end;
end;

function TTcpIpClient.GetBodyResponse(): boolean;
var
  tmpContLen: integer;
begin
  Result := False;
  try
    // Получим длинну тела сообщения
    try
      tmpContLen := StrToInt(FResponse.HeadParams[hdr_CONTENT_LENGTH])
    except
      tmpContLen := 0;
    end;
    // Проверим на длинну сообщения
    if (tmpContLen > FMaxMsgLength) then Exit;
    // Проверим что пришли все данные
    if (tmpContLen > FCurBufPos) then Exit;
    // Проверим наличие параметров в теле запроса
    if (FResponse.HeadParams[hdr_CONTENT_TYPE] = MIME_APP_WWW_FORM)and(tmpContLen <> 0) then
    begin
      ParseParam(Copy(FInBuffer, 1, tmpContLen), FResponse.FBodyParams);
      TruncateBuffer(tmpContLen + 1);
      Result := True;
      Exit;
    end;
    // Проверим наличие бинарных данных в теле
    if (tmpContLen <> 0) then
    begin
      FResponse.FBodyBynaryData.Write(Pointer(FInBuffer)^, tmpContLen);
      FResponse.FBodyBynaryData.Seek(0, soFromBeginning);
      TruncateBuffer(tmpContLen + 1);
      Result := True;
      Exit;
    end;
    // Если данных не было
    Result := True;
  except
    on E: Exception do AddToLog(lgNetwork, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'GetBodyResponse()']);
  end;
end;

function TTcpIpClient.CheckParamResponse(): boolean;
var
  tmpServerID: integer;
  tmpServerName: string;
begin
  Result := False;
  try
    // Проверим уникальный номер сервера
    try
      tmpServerID := StrToInt(FResponse.HeadParams[hdr_SERVER_ID]);
    except
      tmpServerID := 0;
    end;
    if (tmpServerID = 0) then
      raise Exception.Create(err_Server_ID);
    if (FServerID <> 0)and(tmpServerID <> Integer(FServerID)) then
      raise Exception.CreateFmt(err_Server_ID_Change, [FServerID, tmpServerID]);
    if (tmpServerID <> Integer(FServerID)) then FServerID := tmpServerID;
    // Прологируем наименование сервера
    tmpServerName := FResponse.HeadParams[hdr_SERVER_NAME];
    if (tmpServerName = '') then
      raise Exception.Create(err_Server_Name);
    if (tmpServerName <> FServerName) then FServerName := tmpServerName;
    // Проверим код ошибки
    if (FResponse.ErrorCode >= 300) then
      raise Exception.CreateFmt(err_Request, [FResponse.ErrorCode, FResponse.ErrorStr]);
    Result := True;
  except
    on E: Exception do AddToLog(lgNetwork, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'CheckParamResponse()']);
  end;
end;

procedure TTcpIpClient.ProcessQuery();
begin
  try
    // Обработаем пришедшие сообщения
    while True do
      case FResponse.FCurState of
        rqtWait:
          begin
            EnterCriticalSection(FCSMessage);
            try
              FResponse.Clear();
              if GetCaptionResponse() then FResponse.FCurState := rqtHead else Break;
            finally
              LeaveCriticalSection(FCSMessage);
            end;
          end;
        rqtHead:
          begin
            EnterCriticalSection(FCSMessage);
            try
              if GetHeadResponse() then FResponse.FCurState := rqtBody else Break;
            finally
              LeaveCriticalSection(FCSMessage);
            end;
          end;
        rqtBody:
          begin
            EnterCriticalSection(FCSMessage);
            try
              if GetBodyResponse() then FResponse.FCurState := rqtAll else Break;
            finally
              LeaveCriticalSection(FCSMessage);
            end;
          end;
        rqtAll:
          begin
            // Передаем на дальнейшую обработку
            if CheckParamResponse() then
            begin
              EnterCriticalSection(FCSMessage);
              try
                if (FResponse.HeadParams[hdr_CONTENT_LOCATION] = FWaitMsgCommand) then
                  SetEvent(FMessageEvent)
                else
                  DoProcessResponse(FResponse);
              finally
                LeaveCriticalSection(FCSMessage);
              end;
            end;
            Sleep(0);
            FResponse.FCurState := rqtWait;
          end;
      end;
    // Проверим на максимальную длинну сообщения
    if (FCurBufPos > FMaxMsgLength) then
    begin
      FCurBufPos := 0;
      ZeroMemory(@FInBuffer[1], FMaxMsgLength * 2);
      FResponse.FCurState := rqtWait;
      raise Exception.CreateFmt(err_Read_Length, [FMaxMsgLength]);
    end;
  except
    on E: Exception do AddToLog(lgNetwork, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'ProcessQuery()']);
  end;
end;

procedure TTcpIpClient.Execute;
var
  NetWorkEvents: TWSANetWorkEvents;
  WaitEvents: array [0..2] of THandle;
begin
  try
    // Инициализируем ActiveX
    CoInitialize(nil);
    // Запускаем основной цикл
    WaitEvents[0] := FSockEvents;
    WaitEvents[1] := FStopEvent;
    WaitEvents[2] := FTimeEvent;
    while (True) do
      case WaitForMultipleObjects(3, @WaitEvents, False, INFINITE) of
        WAIT_OBJECT_0: // Событие сокета
          begin
            EnterCriticalSection(FCSSocket);
            try
              ResetEvent(FSockEvents);
              WSAEnumNetworkEvents(FSocket, FSockEvents, @NetWorkEvents);
              // Пришли данные, обработаем запрос
              if ((NetWorkEvents.lNetworkEvents and FD_READ) = FD_READ) then
                ReadData();
              // Сокет закрываетсья со стороны сервера
              if ((NetWorkEvents.lNetworkEvents and FD_CLOSE) = FD_CLOSE) then
              begin
                AddToLog(lgNetwork, ltError, err_Lost_Connect, [ServerName]);
                LostConnect();
                DoLostConnect();
              end;
            finally
              LeaveCriticalSection(FCSSocket);
            end;
          end;
        WAIT_OBJECT_0 + 1: // Завершение работы клиента
          Break;
        WAIT_OBJECT_0 + 2: // Сработал таймер
          begin
            if (FSocket = INVALID_SOCKET) then RestoreConnect();
            DoTimer();
          end;
      end;
    // Завершаем работу с ActiveX
    CoUninitialize();
  except
    on E: Exception do AddToLog(lgNetwork, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'Execute()']);
  end;
end;

procedure TTcpIpClient.LostConnect();
begin
  EnterCriticalSection(FCSSocket);
  try
    if (FSocket <> INVALID_SOCKET) then
    begin
      WSAEventSelect(FSocket, FSockEvents, 0);
      ShutDown(FSocket, SD_SEND);
      CloseSocket(FSocket);
      FSocket := INVALID_SOCKET;
    end;
  except
    on E: Exception do AddToLog(lgNetwork, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'LostConnect()']);
  end;
  LeaveCriticalSection(FCSSocket);
end;

procedure TTcpIpClient.RestoreConnect();
var
  tmpHostName: string;
  tmpPort: LongWord;
  SockParam: TSockAddr;
  tmpThIndex: LongWord;  
begin
  try
    AddToLog(lgNetwork, ltWarning, warn_Try_ReConnect, []);
    // Передадим проверить изменение параметров
    tmpHostName := ServerHost;
    tmpPort := ServerPort;
    // Ежели изменилось сообщим
    if (tmpHostName <> FServerHost) then
    begin
      AddToLog(lgNetwork, ltWarning, warn_Server_Host, [FServerHost, tmpHostName]);
      FServerHost := tmpHostName;
    end;
    if (tmpPort <> FServerPort) then
    begin
      AddToLog(lgNetwork, ltWarning, warn_Server_Port, [FServerPort, tmpPort]);
      FServerPort := tmpPort;
    end;
    // Пытаемся востановить соединение
    EnterCriticalSection(FCSSocket);
    try
      // Создаем сокет
      FSocket := WSASocket(AF_INET, SOCK_STREAM, IPPROTO_IP, nil, 0, WSA_FLAG_OVERLAPPED);
      if (FSocket = INVALID_SOCKET) then
        raise Exception.CreateFmt(err_Create_Socket, [SysErrorMessage(WSAGetLastError())]);
      // Устанавливаем семейство протоколов
      SockParam.sin_family := AF_INET;
      // устанавливаем номер порта для сокета
      SockParam.sin_port := hToNs(FServerPort);
      // устанавливаем IP для связи
      SockParam.sin_addr := TInAddr(iNet_Addr(PAnsiChar(GetStrIPAddress(FServerHost))));
      // Соеденяемся с сервером
      if (WinSock.Connect(FSocket, SockParam, SizeOf(SockParam)) <> 0) then
        raise Exception.CreateFmt(err_Connect_Server, [FSocket, FServerHost, FServerPort, SysErrorMessage(WSAGetLastError())]);
      // Устанавливаем маску события
      if (WSAEventSelect(FSocket, FSockEvents, FD_CLOSE or FD_READ) = SOCKET_ERROR) then
        raise Exception.CreateFmt(err_Create_Ev_Sock, [FSockEvents, SysErrorMessage(WSAGetLastError())]);
    finally
      LeaveCriticalSection(FCSSocket);
    end;
    FCheckReconnectThHandle := BeginThread(nil, 0, CheckConnect, Self, 0, tmpThIndex);
  except
    on E: Exception do
    begin
      AddToLog(lgNetwork, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'RestoreConnect()']);
      LostConnect();
    end;
  end;
end;

procedure TTcpIpClient.CheckReconnect();
begin
  try
    if (not TestConnect()) then
      LostConnect()
    else begin // подключение успешно
      AddToLog(lgNetwork, ltInformation, info_Restore_Connect, [FSocket]);
      // Инициализируем ActiveX
      CoInitialize(nil);
      // Передаем на дальнейшую обработку
      DoReConnect();
      // Завершаем работу с ActiveX
      CoUninitialize();
    end;
  except
    on E: Exception do AddToLog(lgNetwork, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'CheckReconnect()']);
  end;
  CloseHandle(FCheckReconnectThHandle);
end;

function TTcpIpClient.TestConnect(): boolean;
var
  tmpWaitResponse: TCSResponse;
begin
  Result := False;
  try
    AddToLog(lgNetwork, ltInformation, info_Test_Connect, []);
    Request.Clear();
    Request.Command := 'TEST_CONNECT';
    if SendRequest(Request) then
      if WaitMessage('TEST_CONNECT', tmpWaitResponse) then
        Result := (tmpWaitResponse.ErrorCode = 200);
  except
    on E: Exception do AddToLog(lgNetwork, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'TestConnect()']);
  end;
end;

end.
