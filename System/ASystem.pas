{**
@Abstract ASystem function
@Author Prof1983 <prof1983@ya.ru>
@Created 19.08.2009
@LastMod 01.02.2013
}
unit ASystem;

{DEFINE NoRuntimeConfig}

{$I Defines.inc}

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

  {$IFNDEF UNIX}Windows,{$ENDIF}
  {$IFDEF USE_CONFIG}ASystemConfig,{$ENDIF}
  {$IFDEF USE_EVENTS}ASystemEvents,{$ENDIF}
  ABase, ABaseTypes, ABaseUtils,
  {$IFDEF USE_RUNTIME}ARuntime,{$ENDIF}
  AStringMain,
  ASystemData,
  ASystemMain,
  ASystemPrepare,
  ASystemResourceString,
  ASystemUtils;

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

function Info_GetDataDirectoryPathP: APascalString; stdcall; deprecated; // Use ASystem_GetDataDirectoryPathP()

function Info_GetDataDirectoryPathWS(): AWideString; stdcall; deprecated; // Use ASystem_GetDataDirectoryPathP()

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
function Info_GetProgramName(out Value: AString_Type): AInteger; stdcall; deprecated; // Use ASystem_GetProgramName()

{** Gets the name, without the extension, of the assembly file for the application.
    Prototype: System.Application.Info.AssemblyName }
function Info_GetProgramNameP: APascalString; stdcall; deprecated; // Use ASystem_GetProgramNameP()

{** Gets the name, without the extension, of the assembly file for the application.
    Prototype: System.Application.Info.AssemblyName }
function Info_GetProgramNameWS(): AWideString; stdcall; deprecated; // Use ASystem_GetProgramNameP()

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
function FileTextGetIndex(FileID: AInt): AInt; stdcall;
function FileTextOpenP(const FileName: APascalString): AInt; stdcall;
function FileTextOpenWS(const FileName: AWideString): AInteger; stdcall;
function FileTextReadLnAnsi(FileID: AInteger; var Stroka: AnsiString): AError; stdcall;

// ---

function ParamStr(Index: AInteger; out Value: AString_Type): AInteger; stdcall;

function ParamStrP(Index: AInteger): APascalString; stdcall;

function ParamStrWS(Index: AInteger): AWideString; stdcall;

function ProcessMessages(): AError; stdcall;

function ShowMessage(const Msg: AString_Type): ADialogBoxCommands; stdcall;

function ShowMessage2P(const Text, Caption: APascalString; Flags: AMessageBoxFlags
    ): ADialogBoxCommands; stdcall; deprecated; // Use ShowMessageExP()

function ShowMessageA(const Msg: PAnsiChar): ADialogBoxCommands; stdcall;

function ShowMessageEx(const Text, Caption: AString_Type; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

function ShowMessageExA(const Text, Caption: PAnsiChar; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

function ShowMessageExP(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

function ShowMessageP(const Msg: APascalString): ADialogBoxCommands; stdcall;

function SetDataDirectoryPathP(const DataDir: APascalString): AError; stdcall;

procedure SetOnProcessMessages(Value: AProc); stdcall;

{$IFDEF USE_EVENTS}
function OnAfterRun: AEvent; stdcall;
function OnBeforeRun: AEvent; stdcall;
function OnAfterRun_Connect(Callback: ACallbackProc; Weight: AInteger = High(AInteger)): Integer; stdcall;
function OnAfterRun_Disconnect(Callback: ACallbackProc): AInteger; stdcall;
function OnBeforeRun_Connect(Callback: ACallbackProc; Weight: AInteger = High(AInteger)): AInteger; stdcall;
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

{** Prepare system }
function Prepare3A(Title, ProgramName: AStr; ProgramVersion: AVersion;
    ProductName: AStr; ProductVersion: AVersion;
    CompanyName, Copyright, Url, Description, DataPath, ConfigPath: AStr): AError; stdcall;

// Prepare system.
function Prepare3P(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath, ConfigPath: APascalString): AError; stdcall;

{** Prepare system }
function Prepare4A(Title, ProgramName: AStr; ProgramVersion: AVersion;
    ProductName: AStr; ProductVersion: AVersion;
    CompanyName, Copyright, Url, Description, Comments, DataPath, ConfigPath: AStr): AError; stdcall;

{** Prepare system }
function Prepare4P(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, Comments, DataPath, ConfigPath: APascalString): AError; stdcall;

{** Initialise system }
function Init(): AError; stdcall;

{** Finalize system }
function Fin(): AError; stdcall;

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

function GetDirectoryPathP(): APascalString; stdcall;

function GetExePath(out Value: AString_Type): AInteger; stdcall;

function GetExePathP(): APascalString; stdcall; deprecated; // Use GetDirectoryPathP()

function GetProductName(): APascalString; stdcall; //deprecated;

function GetProductVersion(): APascalString; stdcall; //deprecated;

function GetExeName(): APascalString; stdcall;

function GetExeNameWS(): AWideString; stdcall;

{** Gets the name, without the extension, of the assembly file for the application.
    Prototype: System.Application.Info.AssemblyName }
function GetProgramName(): APascalString; stdcall; deprecated; // Use GetProgramNameWS

function GetProgramVersion(): APascalString; stdcall; deprecated;

function GetTitle(): APascalString; stdcall; deprecated; // Use Info_GetTitleWS()

function GetUrl(): APascalString; stdcall; deprecated;

function GetDataDirectoryPathWS(): APascalString; stdcall;

function GetDataPath: APascalString; stdcall; //deprecated; // Use GetDataDirectoryPathWS()

function GetResourceString(const Section, Name, Default: AString_Type;
    out Value: AString_Type): AInteger; stdcall;

function Runtime_GetCompanyName(): APascalString; stdcall; deprecated;
function Runtime_GetCopyright(): APascalString; stdcall; deprecated;
function Runtime_GetDescription(): APascalString; stdcall; deprecated;
function Runtime_GetExePath(): APascalString; stdcall; deprecated; // Use ASystem_GetExePath()
function Runtime_GetProductName(): APascalString; stdcall; deprecated;
function Runtime_GetProductVersion(): APascalString; stdcall; deprecated;
function Runtime_GetExeName(): APascalString; stdcall; deprecated;
function Runtime_GetProgramName(): APascalString; stdcall; deprecated; // Use ASystem_GetProgramNameP()
function Runtime_GetProgramVersion(): APascalString; stdcall; deprecated;
function Runtime_GetTitle(): APascalString; stdcall; deprecated;
function Runtime_GetUrl(): APascalString; stdcall; deprecated;
function Runtime_GetDataPath(): APascalString; stdcall; deprecated; // Use ASystem_GetDataDirectoryPathP()

function GetConfig(): AConfig; stdcall;

{$IFDEF USE_RUNTIME}
function GetIsShutdown(): ABoolean; stdcall;
{$ENDIF USE_RUNTIME}

function ShellExecute(const Operation, FileName, Parameters, Directory: AString_Type): AInteger; stdcall;

function ShellExecuteP(const Operation, FileName, Parameters, Directory: APascalString): AInteger; stdcall;

function ShowError(const UserMessage, ExceptMessage: AString_Type): AError; stdcall;

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
  Result := AString_AssignP(Value, FCompanyName);
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
  Result := ASystem_GetCommentsP();
end;

function Info_GetCopyright(out Value: AString_Type): AInteger; stdcall;
begin
  Result := AString_AssignP(Value, FCopyright);
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
  Result := AString_AssignP(Value, FDescription);
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
  Result := AString_AssignP(Value, FExePath);
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
  Result := AString_AssignP(Value, FProductName);
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
  Result := AString_AssignP(Value, FProgramName);
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
  Result := AString_AssignP(Value, FTitle);
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
  Result := AString_AssignP(Value, FUrl);
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
function OnAfterRun(): AEvent;
begin
  Result := FOnAfterRunEvent;
end;
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
function OnAfterRun_Connect(Callback: ACallbackProc; Weight: AInt): AInt;
begin
  Result := ASystem_OnAfterRun_Connect(Callback, Weight);
end;
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
function OnAfterRun_Disconnect(Callback: ACallbackProc): AInt;
begin
  Result := ASystem_OnAfterRun_Disconnect(Callback);
end;
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
function OnBeforeRun(): AEvent;
begin
  Result := FOnBeforeRunEvent;
end;
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
function OnBeforeRun_Connect(Callback: ACallbackProc; Weight: AInt): AInt;
begin
  Result := ASystem_OnBeforeRun_Connect(Callback, Weight);
end;
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
function OnBeforeRun_Disconnect(Callback: ACallbackProc): AInt;
begin
  Result := ASystem_OnBeforeRun_Disconnect(Callback);
end;
{$ENDIF USE_EVENTS}

{ System public procs }

function Config(): AConfig;
begin
  Result := FConfig;
end;

function ParamStr(Index: AInteger; out Value: AString_Type): AInteger; 
begin
  Result := ASystem_ParamStr(Index, Value);
end;

function ParamStrP(Index: AInteger): APascalString;
begin
  Result := ASystem_ParamStrP(Index);
end;

function ParamStrWS(Index: AInteger): AWideString;
begin
  Result := ASystem_ParamStrP(Index);
end;

function Prepare(): AError;
begin
  Result := ASystem_Prepare();
end;

procedure Prepare1(); stdcall;
begin
  Prepare2P('', '', $00000000, '', $00000000, '', '', '', '', '');
end;

function Prepare2(const Title, ProgramName: AString_Type; ProgramVersion: AVersion;
    const ProductName: AString_Type; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath: AString_Type): AError;
begin
  try
    Prepare2P(
        AString_ToPascalString(Title),
        AString_ToPascalString(ProgramName),
        ProgramVersion,
        AString_ToPascalString(ProductName),
        ProductVersion,
        AString_ToPascalString(CompanyName),
        AString_ToPascalString(Copyright),
        AString_ToPascalString(Url),
        AString_ToPascalString(Description),
        AString_ToPascalString(DataPath));
    Result := 0;
  except
    Result := -1;
  end;
end;

function Prepare2A(Title, ProgramName: PAnsiChar; ProgramVersion: AVersion;
    ProductName: PAnsiChar; ProductVersion: AVersion;
    CompanyName, Copyright, Url, Description, DataPath: PAnsiChar): AError;
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
    const CompanyName, Copyright, Url, Description, DataPath: APascalString): AError;
begin
  Result := ASystem_Prepare3P(Title, ProgramName, ProgramVersion, ProductName, ProductVersion,
      CompanyName, Copyright, Url, Description, DataPath, '');
end;

function Prepare3A(Title, ProgramName: AStr; ProgramVersion: AVersion;
    ProductName: AStr; ProductVersion: AVersion;
    CompanyName, Copyright, Url, Description, DataPath, ConfigPath: AStr): AError;
begin
  Result := ASyStem_Prepare3P(AnsiString(Title), AnsiString(ProgramName), ProgramVersion,
      AnsiString(ProductName), ProductVersion,
      AnsiString(CompanyName), AnsiString(Copyright),
      AnsiString(Url), AnsiString(Description),
      AnsiString(DataPath), AnsiString(ConfigPath));
end;

function Prepare3P(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath, ConfigPath: APascalString): AError;
begin
  Result := ASystem_Prepare3P(Title, ProgramName, ProgramVersion, ProductName, ProductVersion,
      CompanyName, Copyright, Url, Description, DataPath, ConfigPath);
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
  ASystemEvents_Init();
  {$ENDIF USE_EVENTS}

  System_Prepare(Title, ProgramName, ProgramVersion, ProductName, ProductVersion,
      CompanyName, Copyright, Url, Description, Comments, DataPath, ConfigPath);
  Result := 0;
end;

function DoneConfig(): AInt;
begin
  {$IFDEF USE_CONFIG}
  System_DoneConfig;
  {$ENDIF USE_CONFIG}
  Result := 0;
end;

function Fin(): AError;
begin
  Result := ASystem_Fin();
end;

function ProcessMessages(): AError;
begin
  Result := ASystem_ProcessMessages();
end;

{ --- }

function FileTextClose(FileID: AInt): AError;
begin
  Result := ASystem_FileTextClose(FileId);
end;

function FileTextEof(FileID: AInt): ABool;
begin
  Result := ASystem_FileTextEof(FileId);
end;

function FileTextGetIndex(FileID: AInt): AInt;
begin
  Result := ASystem_FileTextGetIndex(FileId);
end;

function FileTextOpenP(const FileName: APascalString): AInt;
begin
  Result := ASystem_FileTextOpenP(FileName);
end;

function FileTextOpenWS(const FileName: AWideString): AInt;
begin
  Result := ASystem_FileTextOpenP(FileName);
end;

function FileTextReadLnAnsi(FileID: AInt; var Stroka: AnsiString): AError;
begin
  Result := ASystem_FileTextReadLnAnsi(FileId, Stroka);
end;

{ --- }

function GetCompanyName(): APascalString;
begin
  Result := ASystem_GetCompanyNameP();
end;

function GetConfig(): AConfig;
begin
  Result := FConfig;
end;

function GetCopyright(): APascalString;
begin
  Result := ASystem_GetCopyrightP();
end;

function GetDataDirectoryPathWS(): APascalString;
begin
  Result := FDataPath;
end;

function GetDataPath(): APascalString;
begin
  Result := FDataPath;
end;

function GetDescription(): AWideString;
begin
  Result := FDescription;
end;

function GetDirectoryPath(out Value: AString_Type): AInteger;
begin
  Result := ASystem_GetDirectoryPath(Value);
end;

function GetDirectoryPathP(): APascalString;
begin
  Result := FExePath;
end;

function GetExeName(): APascalString;
begin
  Result := FExeName;
end;

function GetExeNameWS(): AWideString;
begin
  Result := FExeName;
end;

function GetExePath(out Value: AString_Type): AInteger;
begin
  Result := AString_AssignP(Value, FExePath);
end;

function GetExePathP(): APascalString;
begin
  Result := FExePath;
end;

{$IFDEF USE_RUNTIME}
function GetIsShutdown(): ABoolean;
begin
  Result := ARuntime.GetIsShutdown;
end;
{$ENDIF USE_RUNTIME}

function GetProductName(): APascalString;
begin
  Result := ASystem_GetProductNameP();
end;

function GetProductVersion(): APascalString;
begin
  Result := ASystem_GetProductVersionStrP();
end;

function GetProgramName(): APascalString;
begin
  Result := FProgramName;
end;

function GetProgramVersion(): APascalString;
begin
  Result := ASystem_GetProgramVersionStrP();
end;

function GetResourceString(const Section, Name, Default: AString_Type; out Value: AString_Type): AInt;
begin
  Result := ASystem_GetResourceString(Section, Name, Default, Value);
end;

function GetTitle(): APascalString;
begin
  Result := ASystem_GetTitleP();
end;

function GetUrl(): APascalString;
begin
  Result := ASystem_GetUrlP();
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
  Result := ASystem_ShowMessageP(Msg);
end;

function Runtime_ShowMessageA(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;
begin
  Result := ASystem_ShowMessageExP(Text, Caption, Flags);
end;

function SetDataDirectoryPathP(const DataDir: APascalString): AError;
begin
  Result := ASystem_SetDataDirectoryPathP(DataDir);
end;

procedure SetOnProcessMessages(Value: AProc);
begin
  FOnProcessMessages := Value;
end;

function ShellExecute(const Operation, FileName, Parameters, Directory: AString_Type): AInteger;
begin
  Result := ASystem_ShellExecute(Operation, FileName, Parameters, Directory);
end;

function ShellExecuteP(const Operation, FileName, Parameters, Directory: APascalString): AInteger;
begin
  Result := ASystem_ShellExecuteP(Operation, FileName, Parameters, Directory);
end;

function ShowError(const UserMessage, ExceptMessage: AString_Type): AError;
begin
  Result := ASystem_ShowError(UserMessage, ExceptMessage);
end;

function ShowMessage(const Msg: AString_Type): ADialogBoxCommands;
begin
  Result := ASystem_ShowMessage(Msg);
end;

function ShowMessage2P(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands;
begin
  Result := ASystem_ShowMessageExP(Text, Caption, Flags);
end;

function ShowMessageA(const Msg: PAnsiChar): ADialogBoxCommands;
begin
  Result := ASystem_ShowMessageA(Msg);
end;

function ShowMessageEx(const Text, Caption: AString_Type; Flags: AMessageBoxFlags): ADialogBoxCommands;
begin
  Result := ASystem_ShowMessageEx(Text, Caption, Flags);
end;

function ShowMessageExA(const Text, Caption: PAnsiChar; Flags: AMessageBoxFlags): ADialogBoxCommands;
begin
  Result := ASystem_ShowMessageExA(Text, Caption, Flags);
end;

function ShowMessageExP(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands;
begin
  Result := ASystem_ShowMessageExP(Text, Caption, Flags);
end;

function ShowMessageP(const Msg: APascalString): ADialogBoxCommands;
begin
  Result := ASystem_ShowMessageP(Msg);
end;

{$IFDEF USE_RUNTIME}
procedure Shutdown();
begin
  ASystem_Shutdown();
end;
{$ENDIF USE_RUNTIME}

end.
