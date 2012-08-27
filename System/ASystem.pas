{**
@Abstract ASystem function
@Author Prof1983 <prof1983@ya.ru>
@Created 19.08.2009
@LastMod 27.08.2012
}
unit ASystem;

{DEFINE NoRuntimeConfig}

{$I Defines.inc}

{DEFINE A01}
{DEFINE A02}

{$IFDEF UNIX}
  {$DEFINE NoRuntimeSysUtils}
{$ENDIF}

{$IFDEF NoSysUtils}
  {$DEFINE NoRuntimeSysUtils}
{$ENDIF NoSysUtils}

{$IFNDEF NoRuntimeConfig}
  {$DEFINE USE_CONFIG}
{$ENDIF NoRuntimeConfig}

{$IFNDEF NoRuntimeEvents}
  {$DEFINE USE_EVENTS}
{$ENDIF NoRuntimeEvents}

{$IFNDEF NoRuntimeSysUtils}
  {$DEFINE USE_SYSUTILS}
{$ENDIF NoRuntimeSysUtils}

{$IFNDEF NoRuntime}
  {$DEFINE USE_RUNTIME}
{$ENDIF}

interface

uses
  {$IFNDEF FPC}
    {$IFNDEF UNIX}ShellApi,{$ENDIF}
  {$ENDIF}

  //{$IFDEF USE_SYSUTILS}SysUtils,{$ENDIF}
  {$IFNDEF UNIX}Windows,{$ENDIF}
  {$IFDEF USE_EVENTS}AEvents,{$ENDIF}
  {$IFDEF USE_CONFIG}ASystemConfig,{$ENDIF}
  ABase, ABaseTypes, ABaseUtils,
  {ALibraries,}
  {$IFDEF USE_RUNTIME}ARuntime,{$ENDIF}
  AStrings, ASystemData, ASystemMain, ASystemPrepare, ASystemResourceString, ASystemUtils;

// --- Info functions ---

{** Gets the company name associated with the application.
    Prototype: System.Application.Info.CompanyName }
function Info_GetCompanyName(out Value: AString_Type): AInteger; stdcall;

{** Gets the company name associated with the application.
    Prototype: System.Application.Info.CompanyName }
function Info_GetCompanyNameP: APascalString; stdcall;

{** Gets the company name associated with the application.
    Prototype: System.Application.Info.CompanyName }
function Info_GetCompanyNameWS(): AWideString; stdcall;

function Info_GetCommentsWS(): AWideString; stdcall;

{** Gets the copyright notice associated with the application.
    Prototype: System.Application.Info.Copyright }
function Info_GetCopyright(out Value: AString_Type): AInteger; stdcall;

{** Gets the copyright notice associated with the application.
    Prototype: System.Application.Info.Copyright }
function Info_GetCopyrightP: APascalString; stdcall;

{** Gets the copyright notice associated with the application.
    Prototype: System.Application.Info.Copyright }
function Info_GetCopyrightWS(): AWideString; stdcall;

function Info_GetDataDirectoryPathP: APascalString; stdcall;

function Info_GetDataDirectoryPathWS(): AWideString; stdcall;

{** Gets the description associated with the application.
    Prototype: System.Application.Info.Description }
function Info_GetDescription(out Value: AString_Type): AInteger; stdcall;

{** Gets the description associated with the application.
    Prototype: System.Application.Info.Description }
function Info_GetDescriptionP: APascalString; stdcall;

{** Gets the description associated with the application.
    Prototype: System.Application.Info.Description }
function Info_GetDescriptionWS(): AWideString; stdcall;

{** Gets the directory where the application is stored.
    Prototype: System.Application.Info.DirectoryPath }
function Info_GetDirectoryPath(out Value: AString_Type): AInteger; stdcall;

{** Gets the directory where the application is stored.
    Prototype: System.Application.Info.DirectoryPath }
function Info_GetDirectoryPathP: APascalString; stdcall;

{** Gets the directory where the application is stored.
    Prototype: System.Application.Info.DirectoryPath }
function Info_GetDirectoryPathWS(): AWideString; stdcall;

{** Gets the product name associated with the application.
    Prototype: System.Application.Info.ProductName }
function Info_GetProductName(out Value: AString_Type): AInteger; stdcall;

{** Gets the product name associated with the application.
    Prototype: System.Application.Info.ProductName }
function Info_GetProductNameP: APascalString; stdcall;

{** Gets the product name associated with the application.
    Prototype: System.Application.Info.ProductName }
function Info_GetProductNameWS(): AWideString; stdcall;

{** Get product version
    Prototype: System.Application.Info.ProductVersion }
function Info_GetProductVersion(): AVersion; stdcall;

{** Get product version as string
    Prototype: System.Application.Info.ProductVersion }
function Info_GetProductVersionStrP: APascalString; stdcall; deprecated;

{** Get product version as WideString
    Prototype: System.Application.Info.ProductVersion }
function Info_GetProductVersionStrWS(): AWideString; stdcall;

{** Gets the name, without the extension, of the assembly file for the application.
    Prototype: System.Application.Info.AssemblyName }
function Info_GetProgramName(out Value: AString_Type): AInteger; stdcall;

{** Gets the name, without the extension, of the assembly file for the application.
    Prototype: System.Application.Info.AssemblyName }
function Info_GetProgramNameP: APascalString; stdcall;

{** Gets the name, without the extension, of the assembly file for the application.
    Prototype: System.Application.Info.AssemblyName }
function Info_GetProgramNameWS(): AWideString; stdcall;

{** Gets the version number of the application.
    Prototype: System.Application.Info.Version }
function Info_GetProgramVersion(): AVersion; stdcall;

{** Gets the version number of the application.
    Prototype: System.Application.Info.Version }
function Info_GetProgramVersionStrP: APascalString; stdcall;

{** Gets the version number of the application.
    Prototype: System.Application.Info.Version }
function Info_GetProgramVersionStrWS(): AWideString; stdcall;

{** Gets the title associated with the application.
    Prototype: System.Application.Info.Title }
function Info_GetTitle(out Value: AString_Type): AInteger; stdcall;

{** Gets the title associated with the application.
    Prototype: System.Application.Info.Title }
function Info_GetTitleP: APascalString; stdcall;

{** Gets the title associated with the application.
    Prototype: System.Application.Info.Title }
function Info_GetTitleWS(): AWideString; stdcall;

{** Get program about page url
    Prototype: System.Application.Info.Url }
function Info_GetUrl(out Value: AString_Type): AInteger; stdcall;

{** Get program about page url
    Prototype: System.Application.Info.Url }
function Info_GetUrlP: APascalString; stdcall;

{** Get program about page url
    Prototype: System.Application.Info.Url }
function Info_GetUrlWS(): AWideString; stdcall;

{** Gets the company name associated with the application.
    Prototype: System.Application.Info.CompanyName }
function Info_CompanyName: APascalString; stdcall; deprecated; // Use Info_GetCompanyNameP()

{** Gets the copyright notice associated with the application.
    Prototype: System.Application.Info.Copyright }
function Info_Copyright: APascalString; stdcall; deprecated; // Use Info_GetCopyrightP()

{** Gets the description associated with the application.
    Prototype: System.Application.Info.Description }
function Info_Description: APascalString; stdcall; deprecated; // Use Info_GetDesctiprionP()

{** Gets the directory where the application is stored.
    Prototype: System.Application.Info.DirectoryPath }
function Info_DirectoryPath: APascalString; stdcall; deprecated; // Use Info_GetDirectoryPathP()

{** Gets the product name associated with the application.
    Prototype: System.Application.Info.ProductName }
function Info_ProductName: APascalString; stdcall; deprecated; // Use Info_GetProductNameP()

{** Get product version
    Prototype: System.Application.Info.ProductVersion }
function Info_ProductVersion: AVersion; stdcall;

{** Get product version as string
    Prototype: System.Application.Info.ProductVersion }
function Info_ProductVersionStr: APascalString; stdcall; deprecated; // Use Info_GetProductVersionStr()

{** Gets the name, without the extension, of the assembly file for the application.
    Prototype: System.Application.Info.AssemblyName }
function Info_ProgramName: APascalString; stdcall; deprecated; // Use Info_GetProgramNameP()

{** Gets the version number of the application.
    Prototype: System.Application.Info.Version }
function Info_ProgramVersion: AVersion; stdcall;

{** Gets the version number of the application.
    Prototype: System.Application.Info.Version }
function Info_ProgramVersionStr: APascalString; stdcall; deprecated; // Use Info_GetProgramVersionStrP

function Info_SetDataDirectoryPathP(const DataDir: string): AError; stdcall;

{** Gets the title associated with the application.
    Prototype: System.Application.Info.Title }
function Info_Title: APascalString; stdcall; deprecated; // Use Info_GetTitleP()

{** Get program about page url
    Prototype: System.Application.Info.Url }
function Info_Url: APascalString; stdcall; deprecated; // Use Info_GetUrlP()

function Info_DataDirectoryPath(): APascalString; stdcall; deprecated; // Use Info_GetDataDirectoryPathP()

function Info_ConfigDirectoryPath(): APascalString; stdcall;

function Config(): AConfig; stdcall; deprecated; // Use GetConfig()

// --- File ---

function FileTextClose(FileID: AInteger): AError; stdcall;
function FileTextEof(FileID: AInteger): ABoolean; stdcall;
function FileTextOpenWS(const FileName: AWideString): AInteger; stdcall;
function FileTextReadLnAnsi(FileID: AInteger; var Stroka: AnsiString): AError; stdcall;

// ---

function ParamStr(Index: AInteger; out Value: AString_Type): AInteger; stdcall;

function ParamStrP(Index: AInteger): APascalString; stdcall;

function ParamStrWS(Index: AInteger): AWideString; stdcall;

function ProcessMessages(): AError; stdcall;

procedure ProcessMessages02(); stdcall;

function ShowMessage(const Msg: AString_Type): ADialogBoxCommands; stdcall;

function ShowMessage02(const Msg: AWideString): ADialogBoxCommands; stdcall;

function ShowMessage2P(const Text, Caption: APascalString; Flags: AMessageBoxFlags
    ): ADialogBoxCommands; stdcall; deprecated; // Use ShowMessageExP()

function ShowMessageA(const Msg: PAnsiChar): ADialogBoxCommands; stdcall;

function ShowMessageEx(const Text, Caption: AString_Type; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

function ShowMessageExA(const Text, Caption: PAnsiChar; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

function ShowMessageExP(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

function ShowMessageExWS(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

function ShowMessageP(const Msg: APascalString): ADialogBoxCommands; stdcall;

function ShowMessageWS(const Msg: AWideString): ADialogBoxCommands; stdcall;

function SetDataDirectoryPathP(const DataDir: APascalString): AError; stdcall;

function SetDataDirectoryPathWS(const DataDir: AWideString): AError; stdcall;

procedure SetOnProcessMessages(Value: AProc); stdcall;
procedure SetOnProcessMessages02(Value: AProc02); stdcall;
procedure SetOnProcessMessages03(Value: AProc03); stdcall;
procedure SetOnShowError(Value: TAShowErrorWSProc); stdcall;
procedure SetOnShowMessage(Value: TAShowMessageWSProc); stdcall;

{$IFDEF USE_EVENTS}
function OnAfterRun: AEvent; stdcall;
function OnBeforeRun: AEvent; stdcall;
function OnAfterRun_Connect(Callback: ACallbackProc; Weight: AInteger = High(AInteger)): Integer; stdcall;
{$IFDEF A02}function OnAfterRun_Connect02(Callback: ACallbackProc02; Weight: AInteger): Integer; stdcall;{$ENDIF}
function OnAfterRun_Disconnect(Callback: ACallbackProc): AInteger; stdcall;
function OnBeforeRun_Connect(Callback: ACallbackProc; Weight: AInteger = High(AInteger)): AInteger; stdcall;
{$IFDEF A02}function OnBeforeRun_Connect02(Callback: ACallbackProc02; Weight: AInteger = High(AInteger)): AInteger; stdcall;{$ENDIF}
function OnBeforeRun_Disconnect(Callback: ACallbackProc): AInteger; stdcall;
{$ENDIF USE_EVENTS}

// Prepare system.
function Prepare(): AError; stdcall;

// Prepare system.
procedure Prepare1(); stdcall;

// Prepare system.
function Prepare2(const Title, ProgramName: AString_Type; ProgramVersion: AVersion;
    const ProductName: AString_Type; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath: AString_Type): AError; stdcall;

// Prepare system.
function Prepare2A(Title, ProgramName: PAnsiChar; ProgramVersion: AVersion;
    ProductName: PAnsiChar; ProductVersion: AVersion;
    CompanyName, Copyright, Url, Description, DataPath: PAnsiChar): AError; stdcall;

// Prepare system.
function Prepare2P(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath: APascalString): AError; stdcall;

// Prepare system.
procedure Prepare2WS(const Title, ProgramName: AWideString; ProgramVersion: AVersion;
    const ProductName: AWideString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath: AWideString); stdcall;

{** Prepare system }
function Prepare3A(Title, ProgramName: AStr; ProgramVersion: AVersion;
    ProductName: AStr; ProductVersion: AVersion;
    CompanyName, Copyright, Url, Description, DataPath, ConfigPath: AStr): AError; stdcall;

// Prepare system.
function Prepare3P(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath, ConfigPath: APascalString): AError; stdcall;

// Prepare system.
function Prepare3WS(const Title, ProgramName: AWideString; ProgramVersion: AVersion;
    const ProductName: AWideString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath, ConfigPath: AWideString): AError; stdcall;

{** Prepare system }
function Prepare4A(Title, ProgramName: AStr; ProgramVersion: AVersion;
    ProductName: AStr; ProductVersion: AVersion;
    CompanyName, Copyright, Url, Description, Comments, DataPath, ConfigPath: AStr): AError; stdcall;

{** Prepare system }
function Prepare4P(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, Comments, DataPath, ConfigPath: APascalString): AError; stdcall;

// Prepare system.
procedure Prepare4P_Old(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, Comments, DataPath, ConfigPath: APascalString); stdcall;

// Initialise system.
function Init(): AError; stdcall;

// Initialise system.
function Init03(): AInteger; stdcall;

// Done system.
function Done(): AError; stdcall;

// Done system.
function Done03(): AInteger; stdcall;

// Initialise system config file (ini).
function InitConfig(): AInteger; stdcall;

// Finalize Core
function DoneConfig: AInteger; stdcall;

{ Old }

procedure Runtime_SetConfig(Value: AConfig); stdcall; {deprecated}

function Runtime_ShowMessage(const Msg: AWideString): ADialogBoxCommands; stdcall; deprecated; // Use ASystem_ShowMessageP() or ASystem_ShowMessageWS()

function Runtime_ShowMessageA(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall; deprecated; // Use ASystem_ShowMessageExP() or ASystem_ShowMessageExWS()

// Use ShellExecuteP()
function Runtime_ShellExecute(const Operation, FileName, Parameters, Directory: APascalString): AInteger; stdcall; deprecated;

function GetCompanyName(): APascalString; stdcall; deprecated;

function GetCopyright(): APascalString; stdcall; deprecated;

function GetDescription(): AWideString; stdcall; deprecated;

function GetDirectoryPath(out Value: AString_Type): AInteger; stdcall;

function GetExePath(out Value: AString_Type): AInteger; stdcall;

function GetExePathP(): APascalString; stdcall; deprecated; // Use GetDirectoryPathP()

function GetExePathWS(): AWideString; stdcall;

function GetProductName(): APascalString; stdcall; //deprecated;

function GetProductVersion(): APascalString; stdcall; //deprecated;

function GetExeName(): APascalString; stdcall;

function GetExeNameWS(): AWideString; stdcall;

{** Gets the name, without the extension, of the assembly file for the application.
    Prototype: System.Application.Info.AssemblyName }
function GetProgramName(): APascalString; stdcall; deprecated; // Use GetProgramNameWS

{** Gets the name, without the extension, of the assembly file for the application.
    Prototype: System.Application.Info.AssemblyName }
function GetProgramNameWS(): AWideString; stdcall;

function GetProgramVersion(): APascalString; stdcall; deprecated;

function GetProgramVersionWS(): AWideString; stdcall;

function GetTitle(): APascalString; stdcall; deprecated; // Use Info_GetTitleWS()

function GetTitleWS(): AWideString; stdcall;

function GetUrl(): APascalString; stdcall; deprecated;

function GetDataDirectoryPathWS(): APascalString; stdcall;

function GetDataPath: APascalString; stdcall; //deprecated; // Use GetDataDirectoryPathWS()

function GetResourceString(const Section, Name, Default: AString_Type;
    out Value: AString_Type): AInteger; stdcall;

function GetResourceStringWS(const Section, Name, Default: AWideString): AWideString; stdcall;

function Runtime_GetCompanyName(): APascalString; stdcall; deprecated;
function Runtime_GetCopyright(): APascalString; stdcall; deprecated;
function Runtime_GetDescription(): APascalString; stdcall; deprecated;
function Runtime_GetExePath(): APascalString; stdcall; deprecated; // Use ASystem_GetExePath()
function Runtime_GetProductName(): APascalString; stdcall; deprecated;
function Runtime_GetProductVersion(): APascalString; stdcall; deprecated;
function Runtime_GetExeName(): APascalString; stdcall; deprecated;
function Runtime_GetProgramName(): APascalString; stdcall; deprecated;
function Runtime_GetProgramVersion(): APascalString; stdcall; deprecated;
function Runtime_GetTitle(): APascalString; stdcall; deprecated;
function Runtime_GetUrl(): APascalString; stdcall; deprecated;
function Runtime_GetDataPath: APascalString; stdcall; deprecated; // Use Info_GetDataDirectoryPathWS()

function GetConfig(): AConfig; stdcall;

{$IFDEF USE_RUNTIME}
function GetIsShutdown(): ABoolean; stdcall;
{$ENDIF USE_RUNTIME}

function ShellExecute(const Operation, FileName, Parameters, Directory: AString_Type): AInteger; stdcall;

function ShellExecuteP(const Operation, FileName, Parameters, Directory: APascalString): AInteger; stdcall;

function ShellExecuteWS(const Operation, FileName, Parameters, Directory: AWideString): AInteger; stdcall;

function ShowError(const UserMessage, ExceptMessage: AString_Type): AError; stdcall;

procedure ShowError02(const UserMessage, ExceptMessage: AWideString); stdcall;

{$IFDEF USE_RUNTIME}
procedure Shutdown(); stdcall;
{$ENDIF USE_RUNTIME}

implementation

{ Private }

type
  TATextFile = record
    ID: Integer;
    F: TextFile;
  end;

var
  FTextFiles: array of TATextFile;

{
function TryStrToVersion(const S: APascalString; out Version: AVersion): ABoolean;
begin
  // ...
  Result := False;
end;
}

function _FileText_GetIndex(FileID: AInteger): Integer;
var
  J: Integer;
begin
  for J := 0 to High(FTextFiles) do
  begin
    if (FTextFiles[J].ID = FileID) then
    begin
      Result := J;
      Exit;
    end;
  end;
  Result := -1;
end;

{ Events }

{$IFDEF USE_EVENTS}
function DoAfterRun(): AInteger; stdcall;
begin
  Result := AEvents.Event_Invoke(FOnAfterRunEvent, 0);
end;
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
procedure DoAfterRun02(); stdcall;
begin
  AEvents.Event_Invoke(FOnAfterRunEvent, 0);
end;
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
function DoBeforeRun(): AInteger; stdcall;
begin
  Result := AEvents.Event_Invoke(FOnBeforeRunEvent, 0);
end;
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
procedure DoBeforeRun02(); stdcall;
begin
  AEvents.Event_Invoke(FOnBeforeRunEvent, 0);
end;
{$ENDIF USE_EVENTS}

function DoShowMessage(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;
begin
  if (Length(Caption) <= 0) then
    Result := Windows.MessageBox(0, PChar(string(Text)), PChar(string(FTitle)), Flags)
  else
    Result := Windows.MessageBox(0, PChar(string(Text)), PChar(string(Caption)), Flags);
end;

{ Info }

function Info_CompanyName: APascalString; stdcall;
begin
  Result := FCompanyName;
end;

function Info_ConfigDirectoryPath: APascalString; stdcall;
begin
  Result := FConfigPath;
end;

function Info_Copyright(): APascalString; stdcall;
begin
  Result := FCopyright;
end;

function Info_DataDirectoryPath: APascalString; stdcall;
begin
  Result := FDataPath;
end;

function Info_Description: APascalString; stdcall;
begin
  Result := FDescription;
end;

function Info_DirectoryPath: APascalString; stdcall;
begin
  Result := FExePath;
end;

function Info_GetCompanyName(out Value: AString_Type): AInteger; stdcall;
begin
  Result := AStrings.String_AssignP(Value, FCompanyName);
end;

function Info_GetCompanyNameP: APascalString; stdcall;
begin
  Result := FCompanyName;
end;

function Info_GetCompanyNameWS(): AWideString; stdcall;
begin
  Result := FCompanyName;
end;

function Info_GetCommentsWS(): AWideString; stdcall;
begin
  Result := FComments;
end;

function Info_GetCopyright(out Value: AString_Type): AInteger; stdcall;
begin
  Result := AStrings.String_AssignP(Value, FCopyright);
end;

function Info_GetCopyrightP: APascalString; stdcall;
begin
  Result := FCopyright;
end;

function Info_GetCopyrightWS(): AWideString; stdcall;
begin
  Result := FCopyright;
end;

function Info_GetDataDirectoryPathP: APascalString; stdcall;
begin
  Result := FDataPath;
end;

function Info_GetDataDirectoryPathWS(): AWideString; stdcall;
begin
  Result := FDataPath;
end;

function Info_GetDescription(out Value: AString_Type): AInteger; stdcall;
begin
  Result := AStrings.String_AssignP(Value, FDescription);
end;

function Info_GetDescriptionP: APascalString; stdcall;
begin
  Result := FDescription;
end;

function Info_GetDescriptionWS(): AWideString; stdcall;
begin
  Result := FDescription;
end;

function Info_GetDirectoryPath(out Value: AString_Type): AInteger; stdcall;
begin
  Result := AStrings.String_AssignP(Value, FExePath);
end;

function Info_GetDirectoryPathP: APascalString; stdcall;
begin
  Result := FExePath;
end;

function Info_GetDirectoryPathWS(): AWideString; stdcall;
begin
  Result := FExePath;
end;

function Info_GetProductName(out Value: AString_Type): AInteger; stdcall;
begin
  Result := AStrings.String_AssignP(Value, FProductName);
end;

function Info_GetProductNameP: APascalString; stdcall;
begin
  Result := FProductName;
end;

function Info_GetProductNameWS(): AWideString; stdcall;
begin
  Result := FProductName;
end;

function Info_GetProductVersion(): AVersion; stdcall;
begin
  Result := FProductVersion;
end;

function Info_GetProductVersionStrP: APascalString; stdcall;
begin
  Result := FProductVersionStr;
end;

function Info_GetProductVersionStrWS(): AWideString; stdcall;
begin
  Result := FProductVersionStr;
end;

function Info_GetProgramName(out Value: AString_Type): AInteger; stdcall;
begin
  Result := AStrings.String_AssignP(Value, FProgramName);
end;

function Info_GetProgramNameP: APascalString; stdcall;
begin
  Result := FProgramName;
end;

function Info_GetProgramNameWS(): AWideString; stdcall;
begin
  Result := FProgramName;
end;

function Info_GetProgramVersion(): AVersion; stdcall;
begin
  Result := FProgramVersion;
end;

function Info_GetProgramVersionStrP: APascalString; stdcall;
begin
  Result := FProgramVersionStr;
end;

function Info_GetProgramVersionStrWS(): AWideString; stdcall;
begin
  Result := FProgramVersionStr;
end;

function Info_GetTitle(out Value: AString_Type): AInteger; stdcall;
begin
  Result := AStrings.String_AssignP(Value, FTitle);
end;

function Info_GetTitleP: APascalString; stdcall;
begin
  Result := FTitle;
end;

function Info_GetTitleWS(): AWideString; stdcall;
begin
  Result := FTitle;
end;

function Info_GetUrl(out Value: AString_Type): AInteger; stdcall;
begin
  Result := AStrings.String_AssignP(Value, FUrl);
end;

function Info_GetUrlP: APascalString; stdcall;
begin
  Result := FUrl;
end;

function Info_GetUrlWS(): AWideString; stdcall;
begin
  Result := FUrl;
end;

function Info_ProductName: APascalString; stdcall;
begin
  Result := FProductName;
end;

function Info_ProductVersion: AVersion; stdcall;
begin
  Result := FProductVersion;
end;

function Info_ProductVersionStr: APascalString; stdcall;
begin
  Result := FProductVersionStr;
end;

function Info_ProgramName: APascalString; stdcall;
begin
  Result := FProgramName;
end;

function Info_ProgramVersion: AVersion; stdcall;
begin
  Result := FProgramVersion;
end;

function Info_ProgramVersionStr: APascalString; stdcall;
begin
  Result := FProgramVersionStr;
end;

function Info_SetDataDirectoryPathP(const DataDir: string): AError; stdcall;
begin
  FDataPath := DataDir;
  Result := 0;
end;

function Info_Title: APascalString; stdcall;
begin
  Result := FTitle;
end;

function Info_Url: APascalString; stdcall;
begin
  Result := FUrl;
end;

{$IFDEF USE_EVENTS}
function OnAfterRun: AEvent; stdcall;
begin
  Result := FOnAfterRunEvent;
end;
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
function OnAfterRun_Connect(Callback: ACallbackProc; Weight: AInteger): Integer; stdcall;
begin
  Result := AEvents.Event_Connect(FOnAfterRunEvent, Callback, Weight);
end;
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
{$IFDEF A02}
function OnAfterRun_Connect02(Callback: ACallbackProc02; Weight: AInteger): Integer; stdcall;
begin
  Result := AEvents.Event_Connect(FOnAfterRunEvent, Callback, Weight);
end;
{$ENDIF A02}
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
function OnAfterRun_Disconnect(Callback: ACallbackProc): Integer; stdcall;
begin
  Result := AEvents.Event_Disconnect(FOnAfterRunEvent, Callback);
end;
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
function OnBeforeRun: AEvent; stdcall;
begin
  Result := FOnBeforeRunEvent;
end;
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
function OnBeforeRun_Connect(Callback: ACallbackProc; Weight: AInteger = High(AInteger)): AInteger; stdcall;
begin
  Result := AEvents.Event_Connect(FOnBeforeRunEvent, Callback, Weight);
end;
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
{$IFDEF A02}
function OnBeforeRun_Connect02(Callback: ACallbackProc02; Weight: AInteger = High(AInteger)): AInteger; stdcall;
begin
  Result := AEvents.Event_Connect(FOnBeforeRunEvent, Callback, Weight);
end;
{$ENDIF A02}
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
function OnBeforeRun_Disconnect(Callback: ACallbackProc): Integer; stdcall;
begin
  Result := AEvents.Event_Disconnect(FOnBeforeRunEvent, Callback);
end;
{$ENDIF USE_EVENTS}

{ System public procs }

function Config: AConfig; stdcall;
begin
  Result := FConfig;
end;

function ParamStr(Index: AInteger; out Value: AString_Type): AInteger; stdcall;
var
  Res: string;
begin
  try
    Res := System.ParamStr(Index);
    Result := AStrings.String_AssignP(Value, Res);
  except
    Result := -1;
  end;
end;

function ParamStrP(Index: AInteger): APascalString; stdcall;
begin
  try
    Result := System.ParamStr(Index);
  except
    Result := '';
  end;
end;

function ParamStrWS(Index: AInteger): AWideString; stdcall;
begin
  try
    Result := System.ParamStr(Index);
  except
    Result := '';
  end;
end;

function Prepare(): AError;
begin
  try
    Prepare1();
    Result := 0;
  except
    Result := -1;
  end;
end;

procedure Prepare1(); stdcall;
begin
  Prepare2P('', '', $00000000, '', $00000000, '', '', '', '', '');
end;

function Prepare2(const Title, ProgramName: AString_Type; ProgramVersion: AVersion;
    const ProductName: AString_Type; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath: AString_Type): AError; stdcall;
begin
  try
    Prepare2P(
        AStrings.String_ToWideString(Title),
        AStrings.String_ToWideString(ProgramName),
        ProgramVersion,
        AStrings.String_ToWideString(ProductName),
        ProductVersion,
        AStrings.String_ToWideString(CompanyName),
        AStrings.String_ToWideString(Copyright),
        AStrings.String_ToWideString(Url),
        AStrings.String_ToWideString(Description),
        AStrings.String_ToWideString(DataPath));
    Result := 0;
  except
    Result := -1;
  end;
end;

function Prepare2A(Title, ProgramName: PAnsiChar; ProgramVersion: AVersion;
    ProductName: PAnsiChar; ProductVersion: AVersion;
    CompanyName, Copyright, Url, Description, DataPath: PAnsiChar): AError; stdcall;
begin
  try
    Prepare2P(
        AnsiString(Title),
        AnsiString(ProgramName),
        ProgramVersion,
        AnsiString(ProductName),
        ProductVersion,
        AnsiString(CompanyName),
        AnsiString(Copyright),
        AnsiString(Url),
        AnsiString(Description),
        AnsiString(DataPath));
    Result := 0;
  except
    Result := -1;
  end;
end;

function Prepare2P(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath: APascalString): AError; stdcall;
begin
  Result := Prepare3WS(Title, ProgramName, ProgramVersion, ProductName, ProductVersion,
      CompanyName, Copyright, Url, Description, DataPath, '');
end;

procedure Prepare2WS(const Title, ProgramName: AWideString; ProgramVersion: AVersion;
    const ProductName: AWideString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath: AWideString); stdcall;
begin
  Prepare3WS(Title, ProgramName, ProgramVersion, ProductName, ProductVersion,
      CompanyName, Copyright, Url, Description, DataPath, '');
end;

function Prepare3A(Title, ProgramName: AStr; ProgramVersion: AVersion;
    ProductName: AStr; ProductVersion: AVersion;
    CompanyName, Copyright, Url, Description, DataPath, ConfigPath: AStr): AError;
begin
  Result := Prepare3P(AnsiString(Title), AnsiString(ProgramName), ProgramVersion,
      AnsiString(ProductName), ProductVersion,
      AnsiString(CompanyName), AnsiString(Copyright),
      AnsiString(Url), AnsiString(Description),
      AnsiString(DataPath), AnsiString(ConfigPath));
end;

function Prepare3P(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath, ConfigPath: APascalString): AError; stdcall;
begin
  Result := Prepare3WS(Title, ProgramName, ProgramVersion, ProductName, ProductVersion,
      CompanyName, Copyright, Url, Description, DataPath, ConfigPath);
end;

function Prepare3WS(const Title, ProgramName: AWideString; ProgramVersion: AVersion;
    const ProductName: AWideString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath, ConfigPath: AWideString): AError; stdcall;
begin
  SetOnShowMessage(DoShowMessage);
  {$IFDEF USE_EVENTS}
    if (AEvents.Init() < 0) then
    begin
      Result := -3;
      Exit;
    end;

    FOnAfterRunEvent := AEvents.Event_NewW(0, 'AfterRun');
    FOnBeforeRunEvent := AEvents.Event_NewW(0, 'BeforeRun');
    {$IFDEF A01}
      ARuntime.OnAfterRun_Set(DoAfterRun02);
      ARuntime.OnBeforeRun_Set(DoBeforeRun02);
    {$ELSE}
      {$IFDEF A02}
      ARuntime.OnAfterRun_Set(DoAfterRun02);
      ARuntime.OnBeforeRun_Set(DoBeforeRun02);
      {$ELSE}
      ARuntime.OnAfterRun_Set(DoAfterRun);
      ARuntime.OnBeforeRun_Set(DoBeforeRun);
      {$ENDIF A02}
    {$ENDIF A01}
  {$ENDIF USE_EVENTS}

  System_Prepare(Title, ProgramName, ProgramVersion, ProductName, ProductVersion,
      CompanyName, Copyright, Url, Description, '', DataPath, ConfigPath);

  Result := 0;
end;

function Prepare4A(Title, ProgramName: AStr; ProgramVersion: AVersion;
    ProductName: AStr; ProductVersion: AVersion;
    CompanyName, Copyright, Url, Description, Comments, DataPath, ConfigPath: AStr): AError;
begin
  Result := Prepare4P(AnsiString(Title), AnsiString(ProgramName), ProgramVersion,
      AnsiString(ProductName), ProductVersion,
      AnsiString(CompanyName), AnsiString(Copyright),
      AnsiString(Url), AnsiString(Description),
      AnsiString(Comments), AnsiString(DataPath), AnsiString(ConfigPath));
end;

function Prepare4P(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, Comments, DataPath, ConfigPath: APascalString): AError;
begin
  {$IFDEF USE_EVENTS}
    FOnAfterRunEvent := AEvents.Event_NewW(0, 'AfterRun');
    FOnBeforeRunEvent := AEvents.Event_NewW(0, 'BeforeRun');
    {$IFDEF A01}
      ARuntime.OnAfterRun_Set(DoAfterRun02);
      ARuntime.OnBeforeRun_Set(DoBeforeRun02);
    {$ELSE}
      {$IFDEF A02}
      ARuntime.OnAfterRun_Set(DoAfterRun02);
      ARuntime.OnBeforeRun_Set(DoBeforeRun02);
      {$ELSE}
      ARuntime.OnAfterRun_Set(DoAfterRun);
      ARuntime.OnBeforeRun_Set(DoBeforeRun);
      {$ENDIF A02}
    {$ENDIF A01}
  {$ENDIF USE_EVENTS}

  System_Prepare(Title, ProgramName, ProgramVersion, ProductName, ProductVersion,
      CompanyName, Copyright, Url, Description, Comments, DataPath, ConfigPath);
  Result := 0;
end;

procedure Prepare4P_Old(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, Comments, DataPath, ConfigPath: APascalString); stdcall;
begin
  Prepare4P(Title, ProgramName, ProgramVersion, ProductName, ProductVersion,
      CompanyName, Copyright, Url, Description, Comments, DataPath, ConfigPath);
end;

function Done(): AError; stdcall;
begin
  Result := ASystem_Fin();
end;

function Done03(): AInteger; stdcall;
begin
  Result := ASystem_Fin();
end;

function DoneConfig: AInteger; stdcall;
begin
  {$IFDEF USE_CONFIG}
  System_DoneConfig;
  {$ENDIF USE_CONFIG}
  Result := 0;
end;

function ProcessMessages(): AError; stdcall;
begin
  if Assigned(FOnProcessMessages02) then
  begin
    try
      FOnProcessMessages02;
      Result := 0;
    except
      Result := -1;
    end;
    Exit;
  end;

  if not(Assigned(FOnProcessMessages03)) then
  begin
    Result := 1;
    Exit;
  end;
  try
    FOnProcessMessages03;
    Result := 0;
  except
    Result := -1;
  end;
end;

procedure ProcessMessages02(); stdcall;
begin
  ProcessMessages();
  {if Assigned(FOnProcessMessages) then
    FOnProcessMessages;}
end;

{ --- }

function FileTextClose(FileID: AInteger): AError; stdcall;
var
  I: Integer;
begin
  try
    I := _FileText_GetIndex(FileID);
    if (I < 0) then
    begin
      Result := -2;
      Exit;
    end;
    {$I-}CloseFile(FTextFiles[I].F);{$I+}

    if (I < High(FTextFiles)) then
      FTextFiles[I] := FTextFiles[High(FTextFiles)];
    SetLength(FTextFiles, High(FTextFiles));

    Result := 0;
  except
    Result := -1;
  end;
end;

function FileTextEof(FileID: AInteger): ABoolean; stdcall;
var
  I: Integer;
  Value: Boolean;
begin
  try
    I := _FileText_GetIndex(FileID);
    if (I < 0) then
    begin
      Result := True;
      Exit;
    end;

    {$I-}Value := Eof(FTextFiles[I].F);{$I+}
    if (IOResult() <> 0) then
    begin
      Result := True;
      Exit;
    end
    else
      Result := Value;
  except
    Result := True;
  end;
end;

function FileTextGetIndex(FileID: AInteger): Integer; stdcall;
begin
  try
    Result := _FileText_GetIndex(FileID);
  except
    Result := -1;
  end;
end;

function FileTextOpenWS(const FileName: AWideString): AInteger; stdcall;
var
  I: Integer;
  J: Integer;
  Max: Integer;
begin
  I := Length(FTextFiles);
  SetLength(FTextFiles, I + 1);
  FTextFiles[I].ID := 0;
  try
    AssignFile(FTextFiles[I].F, FileName);
    {$I-}Reset(FTextFiles[I].F);{$I+}
    if (IOResult() <> 0) then
    begin
      {$I-}Reset(FTextFiles[I].F);{$I+}
      if (IOResult() <> 0) then
      begin
        Result := -2;
        Exit;
      end;
    end;

    Max := 0;
    for J := 0 to High(FTextFiles)-1 do
    begin
      if (FTextFiles[J].ID > Max) then
        Max := FTextFiles[J].ID;
    end;

    FTextFiles[I].ID := Max + 1;

    Result := Max + 1;
  except
    Result := -1;
  end;
  (*I := Length(FTextFiles);
  try
    AssignFile(F, FileName);
    {$I-}Reset(F);{$I+}
    if (IOResult() <> 0) then
    begin
      {$I-}Reset(F);{$I+}
      if (IOResult() <> 0) then
      begin
        Result := -2;
        Exit;
      end;
    end;

    Max := 0;
    for J := 0 to High(FTextFiles) do
    begin
      if (FTextFiles[J].ID > Max) then
        Max := FTextFiles[J].ID;
    end;

    SetLength(FTextFiles, I + 1);
    FTextFiles[I].ID := Max + 1;
    FTextFiles[I].F := F;

    Result := Max + 1;
  except
    Result := -1;
  end;*)
end;

function FileTextReadLnAnsi(FileID: AInteger; var Stroka: AnsiString): AError; stdcall;
var
  I: Integer;
begin
  try
    I := _FileText_GetIndex(FileID);
    if (I < 0) then
    begin
      Result := -2;
      Exit;
    end;
    {$I-}ReadLn(FTextFiles[I].F, Stroka);{$I+}
    if (IOResult() <> 0) then
    begin
      Result := -3;
      Exit;
    end;
    Result := 0;
  except
    Result := -1;
  end;
end;

{ --- }

function GetCompanyName(): APascalString; stdcall;
begin
  Result := FCompanyName;
end;

function GetConfig(): AConfig; stdcall;
begin
  Result := FConfig;
end;

function GetCopyright(): APascalString; stdcall;
begin
  Result := FCopyright;
end;

function GetDataDirectoryPathWS(): APascalString; stdcall;
begin
  Result := FDataPath;
end;

function GetDataPath(): APascalString; stdcall;
begin
  Result := FDataPath;
end;

function GetDescription(): AWideString; stdcall;
begin
  Result := FDescription;
end;

function GetDirectoryPath(out Value: AString_Type): AInteger;
begin
  Result := AStrings.String_AssignP(Value, FExePath);
end;

function GetExeName(): APascalString; stdcall;
begin
  Result := FExeName;
end;

function GetExeNameWS(): AWideString; stdcall;
begin
  Result := FExeName;
end;

function GetExePath(out Value: AString_Type): AInteger;
begin
  Result := AStrings.String_AssignP(Value, FExePath);
end;

function GetExePathP(): APascalString;
begin
  Result := FExePath;
end;

function GetExePathWS(): AWideString; stdcall;
begin
  Result := FExePath;
end;

{$IFDEF USE_RUNTIME}
function GetIsShutdown(): ABoolean; stdcall;
begin
  Result := ARuntime.GetIsShutdown;
end;
{$ENDIF USE_RUNTIME}

function GetProductName(): APascalString; stdcall;
begin
  Result := FProductName;
end;

function GetProductVersion(): APascalString; stdcall;
begin
  Result := FProductVersionStr;
end;

function GetProgramName(): APascalString; stdcall;
begin
  Result := FProgramName;
end;

function GetProgramNameWS(): AWideString; stdcall;
begin
  Result := FProgramName;
end;

function GetProgramVersion(): APascalString; stdcall;
begin
  Result := FProgramVersionStr;
end;

function GetProgramVersionWS(): AWideString; stdcall;
begin
  Result := FProgramVersionStr;
end;

function GetResourceString(const Section, Name, Default: AString_Type; out Value: AString_Type): AInteger; stdcall;
var
  Res: APascalString;
begin
  try
    Res := ASystemResourceString.Runtime_GetResourceString(
            AStrings.String_ToPascalString(Section),
            AStrings.String_ToPascalString(Name),
            AStrings.String_ToPascalString(Default));
    Result := AStrings.String_AssignP(Value, Res);
  except
    Result := 0;
  end;
end;

function GetResourceStringWS(const Section, Name, Default: AWideString): AWideString; stdcall;
begin
  try
    Result := ASystemResourceString.Runtime_GetResourceString(
            Section,
            Name,
            Default);
  except
    Result := '';
  end;
end;

function GetTitle(): APascalString; stdcall;
begin
  Result := ASystem_GetTitleP();
end;

function GetTitleWS(): AWideString; stdcall;
begin
  Result := FTitle;
end;

function GetUrl(): APascalString; stdcall;
begin
  Result := FUrl;
end;

{ Runtime }

function Runtime_GetCompanyName: APascalString; stdcall;
begin
  Result := FCompanyName;
end;

function Runtime_GetConfig: AConfig; stdcall;
begin
  Result := FConfig;
end;

function Runtime_GetCopyright: APascalString; stdcall;
begin
  Result := FCopyright;
end;

function Runtime_GetDataPath: APascalString; stdcall;
begin
  Result := Info_DataDirectoryPath;
end;

function Runtime_GetDescription: APascalString; stdcall;
begin
  Result := FDescription;
end;

function Runtime_GetExeName: APascalString; stdcall;
begin
  Result := FExeName;
end;

function Runtime_GetExePath: APascalString; stdcall;
begin
  Result := FExePath;
end;

function Runtime_GetProductName: APascalString; stdcall;
begin
  Result := FProductName;
end;

function Runtime_GetProductVersion: APascalString; stdcall;
begin
  Result := FProductVersionStr;
end;

function Runtime_GetProgramName: APascalString; stdcall;
begin
  Result := FProgramName;
end;

function Runtime_GetProgramVersion: APascalString; stdcall;
begin
  Result := FProgramVersionStr;
end;

function Runtime_GetTitle: APascalString; stdcall;
begin
  Result := FTitle;
end;

function Runtime_GetUrl: APascalString; stdcall;
begin
  Result := FUrl;
end;

function Init(): AError; stdcall;
begin
  Result := ASystem_Init();
end;

function Init03(): AInteger; stdcall;
begin
  Result := ASystem_Init();
end;

function InitConfig(): AInteger; stdcall;
begin
  {$IFDEF USE_CONFIG}
  System_InitConfig;
  {$ENDIF USE_CONFIG}
  Result := 0;
end;

procedure Runtime_SetConfig(Value: AConfig); stdcall;
begin
  FConfig := Value;
end;

function Runtime_ShellExecute(const Operation, FileName, Parameters, Directory: APascalString): AInteger; stdcall;
begin
  Result := ShellExecuteA(0,
      PAnsiChar(AnsiString(Operation)),
      PAnsiChar(AnsiString(FileName)),
      PAnsiChar(AnsiString(Parameters)),
      PAnsiChar(AnsiString(Directory)),
      SW_SHOW);
end;

function Runtime_ShowMessage(const Msg: AWideString): ADialogBoxCommands; stdcall;
begin
  Result := ASystem_ShowMessageWS(Msg);
end;

function Runtime_ShowMessageA(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;
begin
  Result := ASystem_ShowMessageExWS(Text, Caption, Flags);
end;

function SetDataDirectoryPathP(const DataDir: APascalString): AError; stdcall;
begin
  FDataPath := DataDir;
  Result := 0;
end;

function SetDataDirectoryPathWS(const DataDir: AWideString): AError; stdcall;
begin
  FDataPath := DataDir;
  Result := 0;
end;

procedure SetOnProcessMessages(Value: AProc); stdcall;
begin
  {$IFDEF A02}
  FOnProcessMessages02 := Value;
  {$ELSE}
  FOnProcessMessages03 := Value;
  {$ENDIF}
end;

procedure SetOnProcessMessages02(Value: AProc02); stdcall;
begin
  FOnProcessMessages02 := Value;
end;

procedure SetOnProcessMessages03(Value: AProc03); stdcall;
begin
  FOnProcessMessages03 := Value;
end;

procedure SetOnShowError(Value: TAShowErrorWSProc); stdcall;
begin
  FOnShowError := Value;
end;

procedure SetOnShowMessage(Value: TAShowMessageWSProc); stdcall;
begin
  FOnShowMessage := Value;
end;

function ShellExecute(const Operation, FileName, Parameters, Directory: AString_Type): AInteger; stdcall;
begin
  Result := ASystem_ShellExecute(Operation, FileName, Parameters, Directory);
end;

function ShellExecuteP(const Operation, FileName, Parameters, Directory: APascalString): AInteger; stdcall;
begin
  Result := ASystem_ShellExecuteP(Operation, FileName, Parameters, Directory);
end;

function ShellExecuteWS(const Operation, FileName, Parameters, Directory: AWideString): AInteger; stdcall;
begin
  {IFNDEF UNIX}
  Result := ShellExecuteA(0,
      PAnsiChar(AnsiString(Operation)),
      PAnsiChar(AnsiString(FileName)),
      PAnsiChar(AnsiString(Parameters)),
      PAnsiChar(AnsiString(Directory)),
      SW_SHOW);
  {ENDIF}
end;

function ShowError(const UserMessage, ExceptMessage: AString_Type): AError; stdcall;
begin
  try
    if Assigned(FOnShowError) then
      FOnShowError(
          FTitle,
          AStrings.String_ToPascalString(UserMessage),
          AStrings.String_ToPascalString(ExceptMessage));
    Result := 0;
  except
    Result := -1;
  end;
end;

procedure ShowError02(const UserMessage, ExceptMessage: AWideString); stdcall;
begin
  try
    if Assigned(FOnShowError) then
      FOnShowError(FTitle, UserMessage, ExceptMessage);
  except
  end;
end;

function ShowMessage(const Msg: AString_Type): ADialogBoxCommands; stdcall;
begin
  Result := ASystem_ShowMessage(Msg);
end;

function ShowMessage02(const Msg: AWideString): ADialogBoxCommands; stdcall;
begin
  Result := ASystem_ShowMessageWS(Msg);
end;

function ShowMessage2P(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;
begin
  Result := ShowMessageExP(Text, Caption, Flags);
end;

function ShowMessageA(const Msg: PAnsiChar): ADialogBoxCommands; stdcall;
var
  S: AnsiString;
begin
  try
    S := Msg;
    Result := System_ShowMessage(S);
  except
    Result := -1;
  end;
end;

function ShowMessageEx(const Text, Caption: AString_Type; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;
begin
  try
    Result := System_ShowMessageEx(
        AStrings.String_ToPascalString(Text),
        AStrings.String_ToPascalString(Caption),
        Flags);
  except
    Result := -1;
  end;
end;

function ShowMessageExA(const Text, Caption: PAnsiChar; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;
begin
  try
    Result := System_ShowMessageEx(Text, Caption, Flags);
  except
    Result := -1;
  end;
end;

function ShowMessageExP(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;
begin
  Result := ASystem_ShowMessageExP(Text, Caption, Flags);
end;

function ShowMessageExWS(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;
begin
  Result := ASystem_ShowMessageExWS(Text, Caption, Flags);
end;

function ShowMessageP(const Msg: APascalString): ADialogBoxCommands; stdcall;
begin
  Result := ASystem_ShowMessageP(Msg);
end;

function ShowMessageWS(const Msg: AWideString): ADialogBoxCommands; stdcall;
begin
  Result := ASystem_ShowMessageWS(Msg);
end;

{$IFDEF USE_RUNTIME}
procedure Shutdown(); stdcall;
begin
  ASystem_Shutdown();
end;
{$ENDIF USE_RUNTIME}

end.
