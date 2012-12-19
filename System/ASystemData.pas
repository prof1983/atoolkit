{**
@Abstract ASystem data
@Author Prof1983 <prof1983@ya.ru>
@Created 29.05.2011
@LastMod 19.12.2012
}
unit ASystemData;

{$I Defines.inc}

{$IFNDEF NoRuntimeEvents}
  {$DEFINE USE_EVENTS}
{$ENDIF NoRuntimeEvents}

interface

uses
  ABase, ABaseTypes;

var
  FCompanyName: APascalString;
  FConfig: AConfig;
  FConfigDir: APascalString;
  FConfigFileName: APascalString;
  FConfigPath: APascalString;
  FComments: APascalString;
  FCopyright: APascalString;
  FDataDir: APascalString;
  FDataPath: APascalString;
  FDescription: APascalString;
  FExeFileName: APascalString; // "Program1.exe"
  FExeName: APascalString;     // "Program1"
  FExePath: APascalString;     // "C:\Programs\Program1\"
  FIsPrepare: Boolean;
  FLogDir: APascalString;
  FLogFilePath: APascalString;
  FProductName: APascalString;
  FProductVersion: AVersion;
  FProductVersionStr: APascalString;
  // Original Program name. Use for config file <ProgramName>.ini
  FProgramName: APascalString;
  FProgramVersion: AVersion;
  FProgramVersionStr: APascalString;
  FTitle: APascalString;
  FUrl: APascalString;
  FOnProcessMessages02: AProc02;
  FOnProcessMessages03: AProc03;
  FOnShowErrorA: AShowErrorA_Proc;
  FOnShowErrorWS: TAShowErrorWSProc;
  FOnShowMessageA: AShowMessageA_Proc;
  FOnShowMessageWS: TAShowMessageWSProc;
  {$IFDEF USE_EVENTS}
  FOnAfterRunEvent: AEvent;
  FOnBeforeRunEvent: AEvent;
  {$ENDIF USE_EVENTS}

implementation

end.
 