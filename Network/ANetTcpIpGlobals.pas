{**
@Abstract(TcpIpGlobals)
@Author(Prof1983 <prof1983@ya.ru>)
@Created(25.04.2006)
@LastMod(04.05.2012)
}
unit ANetTcpIpGlobals;

interface

uses
  Windows, WinSock, Classes, SysUtils;

type // Типы для работы с сетью
  TArrChar10 = array [0..9] of char;

  //** Заголовок сообщения
  THeaderMsg = packed record
    Signature:  TArrChar10; // Сигнатура
    Separator1: char;       // Разделитель
    MsgDate:    TDateTime;  // Дата
    Separator2: char;       // Разделитель
    Code:       word;       // Код сообщения
    Separator3: char;       // Разделитель
    Length:     LongWord;   // Размер тела сообщения
    Separator4: char;       // Разделитель
  end;

const // Константы для работы с сетью
  // Сигнатура начала сообщения
  SIGNATURE: TArrChar10 = '""ARSer""';
  // разделитель
  SEPARATOR: char =       ';';
  // длинна заголовка сообщения
  HEADER_LENGTH =         SizeOf(THeaderMsg);
  // Максимальная длинна сообщения (2MB)
  MAX_LENGTH_MSG =        2097152;
  
// Для хранения версий протоколов ----------------------------------------------
type
  TVersion = packed record
    Major, Minor: byte
  end;

// Типы протоколов и методов ---------------------------------------------------
type
  TProtocol = (ptUnknown, ptHTTP, ptASTP);
  TMethodRequest = (mrtUnknown, mrtGet, mrtPost, mrtOptions);
const
  PROTOCOL_NAME: array[TProtocol] of string = ('Unknown', 'HTTP', 'ASTP');
  METHOD_NAME: array[TMethodRequest] of string = ('Unknown', 'GET', 'POST', 'OPTIONS');

// Описание кодов ответа сервера -----------------------------------------------
const
  err_HTTP_200          = 'ОК';
  err_HTTP_201          = 'Успешная команда POST';
  err_HTTP_202          = 'Принято';
  err_HTTP_203          = 'Неавторитетная информация';
  err_HTTP_204          = 'Нет содержимого';
  err_HTTP_205          = 'Сброс содержимого';
  err_HTTP_206          = 'Частичное содержимое';
  err_HTTP_214          = 'Применено преобразование';
  err_HTTP_300          = 'Несколько вариантов';
  err_HTTP_301          = 'Ресурс перенесен';
  err_HTTP_302          = 'Ресурс временно удален';
  err_HTTP_303          = 'Смотри другое';
  err_HTTP_304          = 'Не изменено';
  err_HTTP_305          = 'Используйте прокси';
  err_HTTP_307          = 'Временное перенаправление';
  err_HTTP_400          = 'Плохой запрос от клиента';
  err_HTTP_401          = 'Неавторизованый запрос';
  err_HTTP_402          = 'Требуется платеж';
  err_HTTP_403          = 'Доступ запрещен';
  err_HTTP_404          = 'Ресурс не найден';
  err_HTTP_405          = 'Метод не применим для данного ресурса';
  err_HTTP_406          = 'Неприемлемо';
  err_HTTP_407          = 'Прокси требует авторизации доступа';
  err_HTTP_408          = 'Таймаут запроса';
  err_HTTP_409          = 'Конфликт';
  err_HTTP_410          = 'Ресурс исчез';
  err_HTTP_411          = 'Требуется длина';
  err_HTTP_413          = 'Объект запроса слишком большой';
  err_HTTP_414          = 'Слишком длинное URI запроса';
  err_HTTP_415          = 'Не поддерживаемый тип устройства';
  err_HTTP_416          = 'Запрошенный диапазон пуст';
  err_HTTP_417          = 'Предположение не оправдалось';
  err_HTTP_500          = 'Внутренняя ошибка сервера';
  err_HTTP_501          = 'Метод не выполнен';
  err_HTTP_502          = 'Плохой шлюз';
  err_HTTP_503          = 'Служба недоступна';
  err_HTTP_504          = 'Таймаут шлюза';
  err_HTTP_505          = 'Версия не поддерживается';

// MIME типы поддерживаемые сервером и клиентом --------------------------------
const // Типы данных (текстовые)
  mime_TEXT_SGML      = 'text/sgml';
  mime_TEXT_JAVASRIPT = 'text/javascript';
  mime_TEXT_CSS       = 'text/css';
  mime_TEXT_HTML      = 'text/html';
  mime_TEXT_PLAIN     = 'text/plain';
  mime_TEXT_RICHTEXT  = 'text/richtext';
  mime_TEXT_XML       = 'text/xml';
  mime_TEXT_XSLT      = 'text/xslt';
  mime_CHARSET_1251   = 'charset="Windows-1251"';
  mime_CHARSET_KOI8_R = 'charset="koi8-r"';
  mime_CHARSET_ASCII  = 'charset="us-ascii"';
const // Типы данных (изображения)
  mime_IMAGE_GIF      = 'image/gif';
  mime_IMAGE_JPEG     = 'image/jpeg';
  mime_IMAGE_MSBMP    = 'image/x-MS-bmp';
  mime_IMAGE_PIXMAP   = 'image/x-xpixmap';
const // Типы данных (приложения)
  mime_APP_HTA        = 'application/hta';
  mime_APP_MSWORD     = 'application/msword';
  mime_APP_OCTET      = 'application/octet-stream';
  mime_APP_PDF        = 'application/pdf';
  mime_APP_RTF        = 'application/rtf';
  mime_APP_ZIP        = 'application/zip';
  mime_APP_RSS_XML    = 'application/rss+xml';
  mime_APP_FLASH      = 'application/x-shockwave-flash';
  mime_APP_WWW_FORM   = 'application/x-www-form-urlencoded';
const // Типы данных (из нескольких частей)
  mime_MULTI_FORM     = 'multipart/form-data';
  mime_MULTI_MIXED    = 'multipart/mixed';
  mime_BOUNDARY       = 'boundary=';
  cont_DISP_FORM      = 'form-data';
  cont_DISP_UNSPEC    = 'unspecified';
  cont_DISP_OTHER     = 'other';
  cont_DISP_ATTACH    = 'attachment';
  cont_DISP_INLINE    = 'inline';

// Элементы заголовков сообщений -----------------------------------------------
const
  hdr_CS_SEND_CAPTION     = '%s %s ASTP/%d.%d';
  hdr_SEND_MAIN           = '%s/%d.%d %d %s';
  hdr_SERVER_NAME         = 'Server';
  hdr_SERVER_ID           = 'Server-ID';
  hdr_HOST                = 'Host';
  hdr_REFERER             = 'Referer';
  hdr_LOCATION            = 'Location';
  hdr_UPGRADE             = 'Upgrade';
  hdr_STATUS              = 'Status';
  hdr_USER_AGENT          = 'User-Agent';
  hdr_USER_ID             = 'User-ID';
  hdr_CONNECTION          = 'Connection';
  hdr_CONTENT_LENGTH      = 'Content-Length';
  hdr_CONTENT_TYPE        = 'Content-Type';
  hdr_CONTENT_LOCATION    = 'Content-Location';
  hdr_CONTENT_LANGUAGE    = 'Content-Language';
  hdr_CONTENT_ENCODING    = 'Content-Encoding';
  hdr_USER_AUTHOR         = 'Authorization';
  hdr_SEND_AUTH           = 'WWW-Authenticate';
  hdr_ACCEPT              = 'Accept';
  hdr_ACCEPT_CHARSET      = 'Accept-Charset';
  hdr_ACCEPT_LANGUAGE     = 'Accept-Language';
  hdr_IF_MATCH            = 'If-Match';
  hdr_IF_MODIFIED_SINCE   = 'If-Modified-Since';
  hdr_NONE_MATCH          = 'If-None-Match';
  hdr_IF_UNMODIFIED_SINCE = 'If-Unmodified-Since';
  hdr_EXPIRES             = 'Expires';
  hdr_CACHE_CONTROL       = 'Cache-Control';
  hdr_PRAGMA              = 'Pragma';

// Вспомогательные функции -----------------------------------------------------
// Декодирует строку в кодировке Base64
function Base64ToStr(const AStr: string): string;
// Кодирует строку в кодировке Base64
function StrToBase64(const AStr: string): string;
// Переобразует дату в формате HTTP заголовков
function ParseHTTPDate(const DateStr: string): TDateTime;
// Декодирует строку в формате HTTP
function HTTPDecode(const AStr: String): string;
// Кодирование строку для передачи по HTTP
function HTTPEncode(const AStr: String): string;
// Выделяет имя пользователя и пароль для Basic авторизации
procedure DecodeBasicAuth(const AStr: string; var AUser: string; var APwd: string);
// Обрабатывает строчку параметров
procedure ParseParam(const AStr: string; AList: TStrings);

// Описания для WinSock2 API ---------------------------------------------------
const // Дополнительные коды ошибок
  WSA_INVALID_EVENT = 0;
  WSA_IO_PENDING    = 997;
  WSA_IO_INCOMPLETE = 996;
const // Константы для функции Shutdown
  SD_RECEIVE = 0;
  SD_SEND    = 1;
  SD_BOTH    = 2;
const // Флаги для функции WSASocket()
  WSA_FLAG_OVERLAPPED        = $01;
  WSA_FLAG_MULTIPOINT_C_ROOT = $02;
  WSA_FLAG_MULTIPOINT_C_LEAF = $04;
  WSA_FLAG_MULTIPOINT_D_ROOT = $08;
  WSA_FLAG_MULTIPOINT_D_LEAF = $10;
const // Вспомогательные константы
  FD_MAX_EVENTS	        = 8;
  MAX_PROTOCOL_CHAIN    = 7;
  WSAPROTOCOL_LEN       = 255;
  SO_CONDITIONAL_ACCEPT = $3002;
  CF_ACCEPT             = 0;
  CF_REJECT             = 1;
  CF_DEFER              = 2;

type
  TWSAProtocolChain = packed record
    ChainLen: Integer;
    ChainEntries: Array[0..MAX_PROTOCOL_CHAIN-1] of LongInt;
  end;

  PWSAProtocol_Info = ^TWSAProtocol_InfoA;
  TWSAProtocol_InfoA = packed record
    dwServiceFlags1: LongInt;
    dwServiceFlags2: LongInt;
    dwServiceFlags3: LongInt;
    dwServiceFlags4: LongInt;
    dwProviderFlags: LongInt;
    ProviderId: TGUID;
    dwCatalogEntryId: LongInt;
    ProtocolChain: TWSAProtocolChain;
    iVersion: Integer;
    iAddressFamily: Integer;
    iMaxSockAddr: Integer;
    iMinSockAddr: Integer;
    iSocketType: Integer;
    iProtocol: Integer;
    iProtocolMaxOffset: Integer;
    iNetworkByteOrder: Integer;
    iSecurityScheme: Integer;
    dwMessageSize: LongInt;
    dwProviderReserved: LongInt;
    szProtocol: Array [0..WSAPROTOCOL_LEN] of Char;
  end;

  PWSABuf = ^TWSABuf;
  TWSABuf = packed record
    Len: LongWord;
    Buf: PChar;
  end;

  PWSANetWorkEvents = ^TWSANetWorkEvents;
  TWSANetWorkEvents = packed record
    lNetworkEvents: LongInt;
    iErrorCode: array [0..FD_MAX_EVENTS-1] of integer;
  end;

  PWSAOverlapped = ^TWSAOverlapped;
  TWSAOverlapped = packed record
    Internal: LongWord;
    InternalHigh: LongWord;
    Offet: LongWord;
    OffsetHigh: LongWord;
    hEvent: THandle;
  end;

  TWSAOverlappedCompletionRoutine = procedure(dwError: LongWord; cdTransferred: LongWord; lpOverlapped: PWSAOverlapped; dwFlags: LongWord); stdcall;

  TWSAConditionProc = function(lpCallerId, lpCallerData: PWSABuf; lpSQOS, lpGQOS: pointer; lpCalleeID, lpCalleeData: PWSABuf; var g: LongWord; dwCallbackData: LongWord): Integer; stdcall;

function WSAAccept(S: TSocket; Addr: PSockAddr; AddrLen: PInteger; lpfnCondition: TWSAConditionProc; dwCallbackData: LongWord): TSocket; stdcall; external 'ws2_32.dll' name 'WSAAccept';
function WSASocket(af, iType, protocol: Integer; lpProtocolInfo: PWSAProtocol_Info; g: LongWord; dwFlags: LongWord): TSocket; stdcall; external 'ws2_32.dll' name 'WSASocketA';
function WSACreateEvent: THandle; stdcall; external 'ws2_32.dll' name 'WSACreateEvent';
function WSAResetEvent(hEvent: THandle): Boolean; stdcall; external 'ws2_32.dll' name 'WSAResetEvent';
function WSACloseEvent(hEvent: THandle): Boolean; stdcall; external 'ws2_32.dll' name 'WSACloseEvent';
function WSAEventSelect(s: TSocket; hEventObject: THandle; lNetworkEvents: Integer): Integer; stdcall; external 'ws2_32.dll' name 'WSAEventSelect';
function WSAEnumNetworkEvents(s: TSocket; hEventObject: THandle; lpNetworkEvents: PWSANetWorkEvents): integer; stdcall; external 'ws2_32.dll' name 'WSAEnumNetworkEvents';
function WSARecv(s: TSocket; var lpBuffers: TWSABuf; dwBufferCount: LongWord; var NumberOfBytesRecvd: LongWord; var Flags: LongWord; lpOverlapped: PWSAOverlapped; lpCompletionRoutine: TWSAOverlappedCompletionRoutine): Integer; stdcall; external 'ws2_32.dll' name 'WSARecv';
function WSASend(s: TSocket; var lpBuffers: TWSABuf; dwBufferCount: LongWord; var NumberOfBytesSent: LongWord; Flags: LongWord; lpOverlapped: PWSAOverlapped; lpCompletionRoutine: TWSAOverlappedCompletionRoutine): Integer; stdcall; external 'ws2_32.dll' name 'WSASend';
function WSAGetOverlappedResult(s: TSocket; lpOverlapped: PWSAOverlapped; var cbTransfer: LongWord; fWait: LongBool; var Flags: LongWord): LongBool; stdcall; external 'ws2_32.dll' name 'WSAGetOverlappedResult';
// -----------------------------------------------------------------------------

implementation

const
  B64: array [0..63] of char = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

// -----------------------------------------------------------------------------
procedure ParseParam(const AStr: string; AList: TStrings);
var
  tmpPChar: PChar;
  tmpInt: integer;
begin
  tmpPChar := Pointer(AStr);
  while (Length(tmpPChar) <> 0) do
  begin
    tmpInt := Pos('&', tmpPChar);
    if (tmpInt = 0) then
    begin
      tmpInt := Length(tmpPChar);
      AList.Add(HTTPDecode(Copy(tmpPChar, 1, tmpInt)));
      Inc(tmpPChar, tmpInt);
    end else
    begin
      AList.Add(HTTPDecode(Copy(tmpPChar, 1, tmpInt - 1)));
      Inc(tmpPChar, tmpInt);
    end;
  end;
end;

// -----------------------------------------------------------------------------
procedure DecodeBasicAuth(const AStr: string; var AUser: string; var APwd: string);
var
  tmpStr: string;
begin
  AUser := '';
  APwd := '';
  if (Pos('Basic ', AStr) <> 1) then Exit;
  tmpStr := Base64ToStr(Copy(AStr, Length('Basic ') + 1, Length(AStr)));
  AUser := Copy(tmpStr, 1, Pos(':', tmpStr) - 1);
  APwd := Copy(tmpStr, Pos(':', tmpStr) + 1, Length(tmpStr));
end;

// -----------------------------------------------------------------------------
function HTTPDecode(const AStr: String): String;
var
  Sp, Rp, Cp: PChar;
begin
  SetLength(Result, Length(AStr));
  Sp := PChar(AStr);
  Rp := PChar(Result);
  while (Sp^ <> #0) do
  begin
    if (not (Sp^ in ['+','%'])) then Rp^ := Sp^
    else
      if Sp^ = '+' then Rp^ := ' '
      else
      begin
        inc(Sp);
        if Sp^ = '%' then Rp^ := '%'
        else
        begin
          Cp := Sp;
          Inc(Sp);
          Rp^ := Char(StrToInt('$' + Cp^ + Sp^));
        end;
      end;
    Inc(Rp);
    Inc(Sp);
  end;
  SetLength(Result, Rp - PChar(Result));
end;

// -----------------------------------------------------------------------------
function HTTPEncode(const AStr: String): String;
const
  NoConversion = ['A'..'Z', 'a'..'z', '*', '@', '.', '_', '-', '0'..'9', '$', '!', '''', '(', ')'];
var
  Sp, Rp: PChar;
begin
  SetLength(Result, Length(AStr) * 3);
  Sp := PChar(AStr);
  Rp := PChar(Result);
  while (Sp^ <> #0) do
  begin
    if (Sp^ in NoConversion) then Rp^ := Sp^
    else
      if Sp^ = ' ' then Rp^ := '+'
      else
      begin
        FormatBuf(Rp^, 3, '%%%.2x', 6, [Ord(Sp^)]);
        Inc(Rp,2);
      end;
    Inc(Rp);
    Inc(Sp);
  end;
  SetLength(Result, Rp - PChar(Result));
end;

// -----------------------------------------------------------------------------
const
  Months: array[1..12] of string = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
  DaysOfWeek: array[1..7] of string = ('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat');

function ParseHTTPDate(const DateStr: string): TDateTime;
var
  Month, Day, Year, Hour, Minute, Sec: Integer;
  Parser: TParser;
  StringStream: TStringStream;

  function GetMonth: Boolean;
  begin
    Month := 1;
    while not Parser.TokenSymbolIs(Months[Month]) and (Month < 13) do Inc(Month);
    Result := Month < 13;
  end;

  procedure GetTime;
  begin
    with Parser do
    begin
      Hour := TokenInt;
      NextToken;
      if Token = ':' then NextToken;
      Minute := TokenInt;
      NextToken;
      if Token = ':' then NextToken;
      Sec := TokenInt;
      NextToken;
    end;
  end;

begin
  StringStream := TStringStream.Create(DateStr);
  try
    Parser := TParser.Create(StringStream);
    with Parser do
    try
      NextToken;
      if Token = ':' then NextToken;
      NextToken;
      if Token = ',' then NextToken;
      if GetMonth then
      begin
        NextToken;
        Day := TokenInt;
        NextToken;
        GetTime;
        Year := TokenInt;
      end else
      begin
        Day := TokenInt;
        NextToken;
        if Token = '-' then NextToken;
        GetMonth;
        NextToken;
        if Token = '-' then NextToken;
        Year := TokenInt;
        if Year < 100 then Inc(Year, 1900);
        NextToken;
        GetTime;
      end;
      Result := EncodeDate(Year, Month, Day) + EncodeTime(Hour, Minute, Sec, 0);
    finally
      Free;
    end;
  finally
    StringStream.Free;
  end;
end;

// -----------------------------------------------------------------------------
function StrToBase64(const AStr: string): string;
var
  Shift: byte;
  i: byte;
  c1,c2: byte;
begin
  Result := '';
  c2 := 0;
  Shift := 2;
  for i:=1 to Length(AStr) do
  begin
    c1 := Ord(AStr[i]);
    Result := Result + B64[c2 or c1 shr Shift];
    c2 := (c1 shl (6 - Shift)) and 63;
    Shift := (Shift + 2) and 7;
    if (Shift = 0) then
    begin
      Shift := 2;
      Result := Result + B64[c2];
      c2 := 0;
    end;
  end;
  if (Shift > 2) then Result := Result + B64[c2];
end;

// -----------------------------------------------------------------------------
function Base64ToStr(const AStr: string): string;
var
  Shift: byte;
  i: byte;
  c1,c2: byte;
begin
  Result := '';
  Shift := 0;
  c1 := 0;
  for i:=1 to Length(AStr) do
  begin
    if (AStr[i] = '=') then Break;
    c2 := Pos(AStr[i], B64) - 1;
    if (Shift > 0) then
      Result := Result + Chr((c1 shl Shift) or (c2 shr (6 - Shift)));
    Shift := (Shift + 2) and 7;
    c1 := c2;
  end;
end;

end.
