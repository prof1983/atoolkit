{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(29.05.2011)
@LastMod(22.05.2012)
@Version(0.5)

0.3.2
[+] FOnProcessMessages02 (01.09.2011)
}
unit ASystemData;

{$I Defines.inc}

{$IFDEF UNIX}
  {$DEFINE NoRuntimeSysUtils}
{$ENDIF}

{$IFNDEF NoRuntimeEvents}
  {$DEFINE USE_EVENTS}
{$ENDIF NoRuntimeEvents}

{$IFNDEF NoRuntimeSysUtils}
  {$DEFINE USE_SYSUTILS}
{$ENDIF NoRuntimeSysUtils}

interface

uses
  ABase, ABaseTypes;

var
  FCompanyName: APascalString;
  FConfig: AConfig;
  FConfigPath: APascalString;
  FComments: APascalString;
  FCopyright: APascalString;
  FDataPath: APascalString;
  FDescription: APascalString;
  FExeFileName: APascalString; // "Program1.exe"  // Полный путь и имя выполняемого файла
  FExeName: APascalString;     // "Program1"      // Имя выполняемого файла
  FExePath: APascalString;     // "C:\Programs\Program1\"  // Путь к выполняемому файлу
  FProductName: APascalString;
  FProductVersion: AVersion;
  FProductVersionStr: APascalString;
  // Original Program name. Use for config file <ProgramName>.ini
  FProgramName: APascalString;
  FProgramVersion: AVersion;
  FProgramVersionStr: APascalString;
  FTitle: APascalString;
  FUrl: APascalString;
  FOnProcessMessages: AProc;
  FOnProcessMessages02: AProc02;
  FOnShowError: TAShowErrorWSProc;
  FOnShowMessage: TAShowMessageWSProc;
  {$IFDEF USE_EVENTS}
  FOnAfterRunEvent: AEvent;                  // После
  FOnBeforeRunEvent: AEvent;                 // Перед
  {$ENDIF USE_EVENTS}

implementation

end.
 