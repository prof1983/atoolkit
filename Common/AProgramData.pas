{**
@Author Prof1983 <prof1983@ya.ru>
@Created 18.12.2012
@LastMod 18.12.2012
}
unit AProgramData;

interface

uses
  Windows,
  ABase,
  ATypes;

var
  {** Критическая секция добавления в лог }
  FCSAddToLog: TRTLCriticalSection;
  FConfigDir: APascalString;
  FDataDir: APascalString;
  FDependencies: WideString;
  FExeFullName: WideString;
  FFileVersionInfo: TFileVersionInfoA;
  //FMaxClientAccount: Integer;
  //FObjectGlobalId: Integer;
  //FObjectOwnerName: WideString;
  //FOrgOwnerName: WideString;
  FProgramDescription: WideString;
  FProgramId: LongWord;
  FProgramIdStr: WideString;
  FProgramNameDisplay: WideString;
  FSystemName: WideString;
  FTimerInterval: LongWord;
var
  FIsComServer: ABoolean;
  FIsConsole: Boolean;
  FIsDebug: Boolean;
  FIsDemo: Boolean;
  FIsService: Boolean;
  FIsSilent: Boolean;
  FIsSplash: Boolean;
  FIsTeach: Boolean;
  FIsTest: Boolean;
var
  FConfigDocument: AXmlDocument;
  FConfigFileName: WideString;
  FConfigInitialize: Boolean;
  FDateStart: TDateTime;

implementation

end.
