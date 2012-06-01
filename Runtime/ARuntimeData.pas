{**
@Abstract(Глобальные переменные модуля ARuntime)
@Author(Prof1983 prof1983@ya.ru)
@Created(13.07.2011)
@LastMod(10.11.2011)
@Version(0.5)

0.3.2
[+] FOnRun02, FOnShutdown02 (01.09.2011)
}
unit ARuntimeData;

interface

uses
  ABase;

var
  FIsShutdown: ABoolean;
  FOnAfterRun: AProc;                   // После
  FOnBeforeRun: AProc;                  // Перед
  FOnRun: AProc;
  FOnRun02: AProc02;
  FOnShutdown: AProc03;
  FOnShutdown02: AProc02;

implementation

end.
 