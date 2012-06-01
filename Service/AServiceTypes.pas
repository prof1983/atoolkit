{**
@Abstract(Основные определения для работы с сервисами WindowsNT)
@Author(Prof1983 prof1983@ya.ru)
@Created(01.09.2005)
@LastMod(10.05.2012)
@Version(0.5)
}
unit AServiceTypes;

interface

uses
  Windows; 

// Описание для Service API ---------------------------------------------------
const
  SERVICE_CONFIG_DESCRIPTION     = 1;
  SERVICE_CONFIG_FAILURE_ACTIONS = 2;

  SERVICE_ACCEPT_PARAMCHANGE           = $00000008;
  SERVICE_ACCEPT_NETBINDCHANGE         = $00000010;
  SERVICE_ACCEPT_HARDWAREPROFILECHANGE = $00000020;
  SERVICE_ACCEPT_POWEREVENT            = $00000040;
  SERVICE_ACCEPT_SESSIONCHANGE         = $00000080;

  SERVICE_CONTROL_NETBINDADD           = $00000007;
  SERVICE_CONTROL_NETBINDREMOVE        = $00000008;
  SERVICE_CONTROL_NETBINDENABLE        = $00000009;
  SERVICE_CONTROL_NETBINDDISABLE       = $0000000A;
  SERVICE_CONTROL_DEVICEEVENT          = $0000000B;
  SERVICE_CONTROL_HARDWAREPROFILECHANGE= $0000000C;
  SERVICE_CONTROL_POWEREVENT           = $0000000D;
  SERVICE_CONTROL_SESSIONCHANGE        = $0000000E;
  SERVICE_CONTROL_USER_PARAMCHANGE     = $00000080;

  PBT_APMQUERYSUSPEND                  = $0000;
  PBT_APMQUERYSUSPENDFAILED            = $0002;
  PBT_APMSUSPEND                       = $0004;
  PBT_APMSTANDBY                       = $0005;
  PBT_APMRESUMECRITICAL                = $0006;
  PBT_APMRESUMESUSPEND                 = $0007;
  PBT_APMBATTERYLOW                    = $0009;
  PBT_APMOEMEVENT                      = $000B;
  PBT_APMPOWERSTATUSCHANGE             = $000A;
  PBT_APMRESUMEAUTOMATIC               = $0012;

  WTS_CONSOLE_CONNECT                  = $1;
  WTS_CONSOLE_DISCONNECT               = $2;
  WTS_REMOTE_CONNECT                   = $3;
  WTS_REMOTE_DISCONNECT                = $4;
  WTS_SESSION_LOGON                    = $5;
  WTS_SESSION_LOGOFF                   = $6;
  WTS_SESSION_LOCK                     = $7;
  WTS_SESSION_UNLOCK                   = $8;

type
  TServiceProc = procedure (argc: LongWord; var argv: array of PChar); stdcall;
  TServiceCtrl = function (dwControl: LongWord; dwEventType: LongWord; lpEventData: pointer; lpContext: pointer): LongWord; stdcall;
type
  SERVICE_DESCRIPTION = record
    lpDescription: LPTSTR;
  end;

implementation

end.



