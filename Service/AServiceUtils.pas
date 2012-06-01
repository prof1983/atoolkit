{**
@Abstract(Основные определения для работы с сервисами WindowsNT)
@Author(Prof1983 prof1983@ya.ru)
@Created(01.09.2005)
@LastMod(10.05.2012)
@Version(0.5)
}
unit AServiceUtils;

interface

uses
  Windows, WinSvc;

{ Выполняет проверку на наличие сервиса в локальной системе
  AName:  наименование сервиса который необходимо проверить }
function IsServiceInstall(const AName: String): Boolean; overload;

{ Выполняет проверку на наличие сервиса в удаленной системе
  AName:  наименование сервиса который необходимо проверить
  AHost:  имя хоста на котором выполняется проверка }
function IsServiceInstall(const AHost: String; const AName: String): Boolean; overload;

{ Выполняет проверку на активность сервиса в локальной системе
  AName:  наименование сервиса который необходимо проверить }
function IsServiceRun(const AName: String): Boolean; overload;

{ Выполняет проверку на активность сервиса в удаленной системе
  AName:  наименование сервиса который необходимо проверить
  AHost:  имя хоста на котором выполняется проверка }
function IsServiceRun(const AHost: String; const AName: String): Boolean; overload;

{ Выполняет запуск сервиса в локальной системе
  AName:  наименование сервиса который необходимо запустить }
function StartService(const AName: String): Boolean; overload;

{ Выполняет запуск сервиса в удаленной системе
  AName:  наименование сервиса который необходимо запустить
  AHost:  имя хоста на котором необходимо запустить }
function StartService(const AHost: String; const AName: String): Boolean; overload;

{ Выполняет остановку сервиса в локальной системе
  AName:  наименование сервиса который необходимо остановить }
function StopService(const AName: String): Boolean; overload;

{ Выполняет остановку сервиса в удаленной системе
  AName:  наименование сервиса который необходимо остановить
  AHost:  имя хоста на котором необходимо остановить }
function StopService(const AHost: String; const AName: String): Boolean; overload;

function ChangeServiceConfig2(hService: SC_HANDLE; dwInfoLevel: LongWord; lpInfo: Pointer): LongBool; stdcall; external 'advapi32.dll' name 'ChangeServiceConfig2A';
function RegisterServiceCtrlHandlerEx(lpServiceName: PChar;lpHandlerProc: ThandlerFunction; lpContext: pointer): SERVICE_STATUS_HANDLE; stdcall; external 'advapi32.dll' name 'RegisterServiceCtrlHandlerExA';

implementation

// --- Public ---

function IsServiceInstall(const AName: String): Boolean;
begin
  Result := IsServiceInstall('', AName);
end;

function IsServiceInstall(const AHost: String; const AName: String): Boolean;
var
  SvcMgr: Integer;
  Svc: Integer;
begin
  Result := False;
  // Откроем менеджер сервисоа
  if (AHost = '') then
    SvcMgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS)
  else
    SvcMgr := OpenSCManager(PChar(AHost), nil, SC_MANAGER_ALL_ACCESS);
  // Если не удалось открыть менеджер
  if (SvcMgr = 0) then Exit;
  try
    // Получим доступ к сервису
    Svc := OpenService(SvcMgr, PChar(AName), SERVICE_ALL_ACCESS);
    // Если не удалось получить доступ
    if (Svc = 0) then Exit;
    // Если удалось, то он существует
    Result := True;
    // Закроем сервис
    CloseServiceHandle(Svc);
  finally
    // Закроем менеджер
    CloseServiceHandle(SvcMgr);
  end;
end;

function IsServiceRun(const AName: String): Boolean;
begin
  Result := IsServiceRun('', AName);
end;

function IsServiceRun(const AHost: String; const AName: String): Boolean;
var
  SvcMgr: Integer;
  Svc: Integer;
  ServiceStatus: TServiceStatus;
begin
  Result := False;
  // Откроем менеджер сервисоа
  if (AHost <> '') then
    SvcMgr := OpenSCManager(PChar(AHost), nil, SC_MANAGER_ALL_ACCESS)
  else
    SvcMgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  // Если не удалось открыть менеджер
  if (SvcMgr = 0) then Exit;
  try
    // Получим доступ к сервису
    Svc := OpenService(SvcMgr, PChar(AName), SERVICE_ALL_ACCESS);
    // Если не удалось получить доступ
    if (Svc = 0) then Exit;
    // Запросим текущее состояние сервиса
    if QueryServiceStatus(Svc, ServiceStatus) then
      // Проверим текущее состояние
      if (ServiceStatus.dwCurrentState = SERVICE_RUNNING) then
        // Вернем результат
        Result := True;
    // Закроем сервис
    CloseServiceHandle(Svc);
  finally
    // Закроем менеджер
    CloseServiceHandle(SvcMgr);
  end;
end;

function StartService(const AName: String): Boolean;
begin
  Result := StartService('', AName);
end;

function StartService(const AHost: String; const AName: String): Boolean;
var
  SvcMgr: Integer;
  Svc: Integer;
  ServiceStatus: TServiceStatus;
  tmpStr: PChar;
begin
  tmpStr := nil;
  Result := False;
  // Откроем менеджер сервисоа
  if (AHost <> '') then
    SvcMgr := OpenSCManager(PChar(AHost), nil, SC_MANAGER_ALL_ACCESS)
  else
    SvcMgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  // Если не удалось открыть менеджер
  if (SvcMgr = 0) then Exit;
  try
    // Получим доступ к сервису
    Svc := OpenService(SvcMgr, PChar(AName), SERVICE_ALL_ACCESS);
    // Если не удалось получить доступ
    if (Svc = 0) then Exit;
    // Запросим текущее состояние сервиса
    if QueryServiceStatus(Svc, ServiceStatus) then
      // Проверим текущее состояние
      if (ServiceStatus.dwCurrentState = SERVICE_STOPPED) then
      begin
        // Дадим команду на запуск
        WinSvc.StartService(Svc, 0, tmpStr);
        // Вернем результат
        Result := True;
      end;
    // Закроем сервис
    CloseServiceHandle(Svc);
  finally
    // Закроем менеджер
    CloseServiceHandle(SvcMgr);
  end;
end;

function StopService(const AName: String): Boolean;
begin
  Result := StopService('', AName);
end;

function StopService(const AHost: String; const AName: String): Boolean;
var
  SvcMgr: Integer;
  Svc: Integer;
  ServiceStatus: TServiceStatus;
begin
  Result := False;
  // Откроем менеджер сервисоа
  if (AHost <> '') then
    SvcMgr := OpenSCManager(PChar(AHost), nil, SC_MANAGER_ALL_ACCESS)
  else
    SvcMgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  // Если не удалось открыть менеджер
  if (SvcMgr = 0) then Exit;
  try
    // Получим доступ к сервису
    Svc := OpenService(SvcMgr, PChar(AName), SERVICE_ALL_ACCESS);
    // Если не удалось получить доступ
    if (Svc = 0) then Exit;
    // Запросим текущее состояние сервиса
    if QueryServiceStatus(Svc, ServiceStatus) then
      // Проверим текущее состояние
      if (ServiceStatus.dwCurrentState = SERVICE_RUNNING) then
      begin
        // Дадим команду на остановку
        ControlService(Svc, SERVICE_CONTROL_STOP, ServiceStatus);
        // Вернем результат
        Result := True;
      end;
    // Закроем сервис
    CloseServiceHandle(Svc);
  finally
    // Закроем менеджер
    CloseServiceHandle(SvcMgr);
  end;
end;

end.



