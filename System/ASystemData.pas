{**
@Abstract ASystem data
@Author Prof1983 <prof1983@ya.ru>
@Created 29.05.2011
@LastMod 28.01.2013
}
unit ASystemData;

{$I Defines.inc}

{$ifndef NoRuntimeEvents}
  {$define UseEvents}
{$endif}

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
  FOnProcessMessages: AProc;
  FOnShowErrorA: AShowErrorA_Proc;
  FOnShowMessageA: AShowMessageA_Proc;
  {$ifdef UseEvents}
  FOnAfterRunEvent: AEvent;
  FOnBeforeRunEvent: AEvent;
  {$endif}

implementation

end.
 