{**
@abstract ASystem function
@author Prof1983 <prof1983@ya.ru>
@created 19.08.2009
@lastmod 19.07.2012
}
unit ASystem;

{DEFINE NoRuntimeConfig}

{$I Defines.inc}

{$IFDEF A02}
  {$DEFINE A0}
{$ENDIF A02}

{$IFDEF A03}
  {$DEFINE A0}
{$ENDIF A03}

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

interface

uses
  {$IFNDEF FPC}
    {$IFNDEF UNIX}ShellApi,{$ENDIF}
  {$ENDIF}

  {$IFDEF USE_SYSUTILS}SysUtils,{$ENDIF}
  {$IFNDEF UNIX}Windows,{$ENDIF}
  {$IFDEF USE_EVENTS}AEvents,{$ENDIF}
  {$IFDEF USE_CONFIG}ASystemConfig,{$ENDIF}
  ABase, ABaseTypes, ALibraries, ARuntime,
  ABaseUtils, AStrings, ASystemData, ASystemMain, ASystemPrepare, ASystemResourceString, ASystemUtils;

function ASystem_GetExePath(): APascalString; stdcall;

// --- Info functions ---

{ Gets the company name associated with the application.
  Возвращает наименование компании.
  Prototype: System.Application.Info.CompanyName }
function Info_GetCompanyName(out Value: AString_Type): AInteger; stdcall;

{ Gets the company name associated with the application.
  Возвращает наименование компании.
  Prototype: System.Application.Info.CompanyName }
function Info_GetCompanyNameP: APascalString; stdcall;

{ Gets the company name associated with the application.
  Возвращает наименование компании.
  Prototype: System.Application.Info.CompanyName }
function Info_GetCompanyNameWS(): AWideString; stdcall;

{ Возвращает комментарий к программе. }
function Info_GetCommentsWS(): AWideString; stdcall;

{ Gets the copyright notice associated with the application.
  Возвращает информацию о правах.
  Prototype: System.Application.Info.Copyright }
function Info_GetCopyright(out Value: AString_Type): AInteger; stdcall;

{ Gets the copyright notice associated with the application.
  Возвращает информацию о правах.
  Prototype: System.Application.Info.Copyright }
function Info_GetCopyrightP: APascalString; stdcall;

{ Gets the copyright notice associated with the application.
  Возвращает информацию о правах.
  Prototype: System.Application.Info.Copyright }
function Info_GetCopyrightWS(): AWideString; stdcall;

//** Возвращает полный путь к директории с данными.
function Info_GetDataDirectoryPathP: APascalString; stdcall;

//** Возвращает полный путь к директории с данными.
function Info_GetDataDirectoryPathWS(): AWideString; stdcall;

{ Gets the description associated with the application.
  Возвращает описание программы (Runtime_GetDescription).
  Prototype: System.Application.Info.Description }
function Info_GetDescription(out Value: AString_Type): AInteger; stdcall;

{ Gets the description associated with the application.
  Возвращает описание программы.
  Prototype: System.Application.Info.Description }
function Info_GetDescriptionP: APascalString; stdcall;

{ Gets the description associated with the application.
  Возвращает описание программы.
  Prototype: System.Application.Info.Description }
function Info_GetDescriptionWS(): AWideString; stdcall;

{ Gets the directory where the application is stored.
  Prototype: System.Application.Info.DirectoryPath }
function Info_GetDirectoryPath(out Value: AString_Type): AInteger; stdcall;

{ Gets the directory where the application is stored.
  Prototype: System.Application.Info.DirectoryPath }
function Info_GetDirectoryPathP: APascalString; stdcall;

{ Gets the directory where the application is stored.
  Prototype: System.Application.Info.DirectoryPath }
function Info_GetDirectoryPathWS(): AWideString; stdcall;

{ Gets the product name associated with the application.
  Возвращает наименование продукта (Runtime_GetProductName).
  Prototype: System.Application.Info.ProductName }
function Info_GetProductName(out Value: AString_Type): AInteger; stdcall;

{ Gets the product name associated with the application.
  Возвращает наименование продукта (Runtime_GetProductName).
  Prototype: System.Application.Info.ProductName }
function Info_GetProductNameP: APascalString; stdcall;

{ Gets the product name associated with the application.
  Возвращает наименование продукта (Runtime_GetProductName).
  Prototype: System.Application.Info.ProductName }
function Info_GetProductNameWS(): AWideString; stdcall;

{ Возвращает версию продукта.
  Prototype: System.Application.Info.ProductVersion }
function Info_GetProductVersion(): AVersion; stdcall;

{ Возвращает версию продукта.
  Prototype: System.Application.Info.ProductVersion }
function Info_GetProductVersionStrP: APascalString; stdcall; deprecated;

{ Возвращает версию продукта.
  Prototype: System.Application.Info.ProductVersion }
function Info_GetProductVersionStrWS(): AWideString; stdcall;

{ Gets the name, without the extension, of the assembly file for the application.
  Возвращает наименование программы (Runtime_GetProgramName).
  Prototype: System.Application.Info.AssemblyName }
function Info_GetProgramName(out Value: AString_Type): AInteger; stdcall;

{ Gets the name, without the extension, of the assembly file for the application.
  Возвращает наименование программы (Runtime_GetProgramName).
  Prototype: System.Application.Info.AssemblyName }
function Info_GetProgramNameP: APascalString; stdcall;

{ Gets the name, without the extension, of the assembly file for the application.
  Возвращает наименование программы (Runtime_GetProgramName).
  Prototype: System.Application.Info.AssemblyName }
function Info_GetProgramNameWS(): AWideString; stdcall;

{ Gets the version number of the application.
  Возвращает версию программы.
  Prototype: System.Application.Info.Version }
function Info_GetProgramVersion(): AVersion; stdcall;

{ Gets the version number of the application.
  Возвращает версию программы.
  Prototype: System.Application.Info.Version }
function Info_GetProgramVersionStrP: APascalString; stdcall;

{ Gets the version number of the application.
  Возвращает версию программы.
  Prototype: System.Application.Info.Version }
function Info_GetProgramVersionStrWS(): AWideString; stdcall;

{ Gets the title associated with the application.
  Возвращает заголовок (краткое наименование) программы.
  Prototype: System.Application.Info.Title }
function Info_GetTitle(out Value: AString_Type): AInteger; stdcall;

{ Gets the title associated with the application.
  Возвращает заголовок (краткое наименование) программы.
  Prototype: System.Application.Info.Title }
function Info_GetTitleP: APascalString; stdcall;

{ Gets the title associated with the application.
  Возвращает заголовок (краткое наименование) программы.
  Prototype: System.Application.Info.Title }
function Info_GetTitleWS(): AWideString; stdcall;

{ Возвращает адрес сайта программы в интернете (Runtime_GetUrl).
  Prototype: System.Application.Info.Url }
function Info_GetUrl(out Value: AString_Type): AInteger; stdcall;

{ Возвращает адрес сайта программы в интернете (Runtime_GetUrl).
  Prototype: System.Application.Info.Url }
function Info_GetUrlP: APascalString; stdcall;

{ Возвращает адрес сайта программы в интернете (Runtime_GetUrl).
  Prototype: System.Application.Info.Url }
function Info_GetUrlWS(): AWideString; stdcall;

{ Gets the company name associated with the application.
  Возвращает наименование компании (Runtime_GetCompanyName).
  Use Info_GetCompanyNameP()
  Prototype: System.Application.Info.CompanyName }
function Info_CompanyName: APascalString; stdcall; deprecated;

{ Gets the copyright notice associated with the application.
  Возвращает информацию о правах.
  Use Info_GetCopyrightP()
  Prototype: System.Application.Info.Copyright }
function Info_Copyright: APascalString; stdcall; deprecated;

{ Gets the description associated with the application.
  Возвращает описание программы.
  Use Info_GetDesctiprionP()
  Prototype: System.Application.Info.Description }
function Info_Description: APascalString; stdcall; deprecated;

{ Gets the directory where the application is stored.
  Use Info_GetDirectoryPathP()
  Prototype: System.Application.Info.DirectoryPath }
function Info_DirectoryPath: APascalString; stdcall; deprecated;

{ Gets the product name associated with the application.
  Возвращает наименование продукта (Runtime_GetProductName).
  Use Info_GetProductNameP()
  Prototype: System.Application.Info.ProductName }
function Info_ProductName: APascalString; stdcall; deprecated;

{ Возвращает версию продукта (Runtime_GetProductVersion).
  Prototype: System.Application.Info.ProductVersion }
function Info_ProductVersion: AVersion; stdcall;
//function Application_Info_ProductVersion: AVersion; stdcall;

{ Возвращает версию продукта.
  Use Info_GetProductVersionStr()
  Prototype: System.Application.Info.ProductVersion }
function Info_ProductVersionStr: APascalString; stdcall; deprecated;

{ Gets the name, without the extension, of the assembly file for the application.
  Возвращает наименование программы (Runtime_GetProgramName).
  Use Info_GetProgramNameP()
  Prototype: System.Application.Info.AssemblyName }
function Info_ProgramName: APascalString; stdcall; deprecated;

{ Gets the version number of the application.
  Возвращает версию программы (Runtime_GetProgramVersion).
  Prototype: System.Application.Info.Version }
function Info_ProgramVersion: AVersion; stdcall;
//function Application_Info_Version: AVersion; stdcall;

{ Gets the version number of the application.
  Возвращает версию программы.
  Use Info_GetProgramVersionStrP
  Prototype: System.Application.Info.Version }
function Info_ProgramVersionStr: APascalString; stdcall; deprecated;

function Info_SetDataDirectoryPathP(const DataDir: string): AError; stdcall;

{ Gets the title associated with the application.
  Возвращает заголовок (краткое наименование) программы.
  Use Info_GetTitleP()
  Prototype: System.Application.Info.Title }
function Info_Title: APascalString; stdcall; deprecated;

{ Возвращает адрес сайта программы в интернете (Runtime_GetUrl).
  Use Info_GetUrlP()
  Prototype: System.Application.Info.Url }
function Info_Url: APascalString; stdcall; deprecated;

// Use Info_GetDataDirectoryPathP()
function Info_DataDirectoryPath: APascalString; stdcall; deprecated;

function Info_ConfigDirectoryPath: APascalString; stdcall;

// Use GetConfig()
function Config: AConfig; stdcall; deprecated;

// --- File ---

function FileTextClose(FileID: AInteger): AError; stdcall;
function FileTextEof(FileID: AInteger): ABoolean; stdcall;
function FileTextOpenWS(const FileName: AWideString): AInteger; stdcall;
function FileTextReadLnAnsi(FileID: AInteger; var Stroka: AnsiString): AError; stdcall;

// ---

//** Возвращает параметр.
function ParamStr(Index: AInteger; out Value: AString_Type): AInteger; stdcall;

//** Возвращает параметр.
function ParamStrP(Index: AInteger): APascalString; stdcall;

//** Возвращает параметр.
function ParamStrWS(Index: AInteger): AWideString; stdcall;

//** Обрабатывает сообщения от ОС.
function ProcessMessages(): AError; stdcall;

//** Обрабатывает сообщения от ОС.
procedure ProcessMessages02(); stdcall;

//** Выводит сообщение и ждет потверджения.
function ShowMessage(const Msg: AString_Type): ADialogBoxCommands; stdcall;

//** Выводит сообщение и ждет потверджения.
function ShowMessage02(const Msg: AWideString): ADialogBoxCommands; stdcall;

//** Выводит сообщение и ждет потверджения.
function ShowMessage2P(const Text, Caption: APascalString; Flags: AMessageBoxFlags
    ): ADialogBoxCommands; stdcall; deprecated; // Use ShowMessageExP()

//** Выводит сообщение и ждет потверджения.
function ShowMessageA(const Msg: PAnsiChar): ADialogBoxCommands; stdcall;

//** Выводит сообщение и ждет потверджения.
function ShowMessageEx(const Text, Caption: AString_Type; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

//** Выводит сообщение и ждет потверджения.
function ShowMessageExA(const Text, Caption: PAnsiChar; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

//** Выводит сообщение и ждет потверджения.
function ShowMessageExP(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

//** Выводит сообщение и ждет потверджения.
function ShowMessageExWS(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

//** Выводит сообщение и ждет потверджения.
function ShowMessageP(const Msg: APascalString): ADialogBoxCommands; stdcall;

//** Выводит сообщение и ждет потверджения.
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
function OnAfterRun_Disconnect(Callback: ACallbackProc): AInteger; stdcall;
//** Подключает к событию.
function OnBeforeRun_Connect(Callback: ACallbackProc; Weight: AInteger = High(AInteger)): AInteger; stdcall;
{$IFDEF A02}function OnBeforeRun_Connect02(Callback: ACallbackProc02; Weight: AInteger = High(AInteger)): AInteger; stdcall;{$ENDIF}
//** Отключает от события.
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

// Prepare system.
function Prepare3P(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath, ConfigPath: APascalString): AError; stdcall;

// Prepare system.
function Prepare3WS(const Title, ProgramName: AWideString; ProgramVersion: AVersion;
    const ProductName: AWideString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath, ConfigPath: AWideString): AError; stdcall;

// Prepare system.
procedure Prepare4P(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
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

// Открывает модуль (библиотеку). Возвращяет идентификатор.
function Library_Open(const FileName: AString_Type; Flags: ALibraryFlags): ALibrary; stdcall;

// Открывает модуль (библиотеку). Возвращяет идентификатор.
function Library_OpenP(const FileName: APascalString; Flags: ALibraryFlags): ALibrary; stdcall;

// Открывает модуль (библиотеку). Возвращяет идентификатор.
function Library_OpenS({const} FileName: AString; Flags: ALibraryFlags): ALibrary; stdcall;

// Открывает модуль (библиотеку). Возвращяет идентификатор.
function Library_OpenWS(const FileName: AWideString; Flags: ALibraryFlags): ALibrary; stdcall;

// Закрывает модуль (библиотеку)
function Library_Close(Lib: ALibrary): ABoolean; stdcall;
function Library_BuildPath({const} Directory, LibraryName: AString; {out} Value: AString): AInteger; stdcall;
function Library_BuildPathP(const Directory, LibraryName: APascalString): APascalString; stdcall;
function Library_BuildPathS(const Directory, LibraryName: AString_Type; out Value: AString_Type): AInteger; stdcall;
function Library_GetName(Lib: ALibrary; {out} Value: AString): AInteger; stdcall;
function Library_GetNameP(Lib: ALibrary): APascalString; stdcall;
function Library_GetNameS(Lib: ALibrary; out Value: AString_Type): AInteger; stdcall;

// Возвращает адрес функции.
function Library_GetProcAddress(Lib: ALibrary; const Name: AString_Type): Pointer; stdcall;

// Возвращает адрес функции.
function Library_GetProcAddressP(Lib: ALibrary; const Name: APascalString): Pointer; stdcall;

// Возвращает адрес функции.
function Library_GetProcAddressS(Lib: ALibrary; {const} Name: AString): Pointer; stdcall;

// Возвращает адрес функции.
function Library_GetProcAddressWS(Lib: ALibrary; const Name: AWideString): Pointer; stdcall;

// Возвращает адрес функции
function Library_GetSymbol(Lib: ALibrary; {const} SymbolName: AString; {var} Symbol: PPointer): ABoolean; stdcall;
// Возвращает адрес функции
function Library_GetSymbolP(Lib: ALibrary; const SymbolName: APascalString; var Symbol: Pointer): ABoolean; stdcall;
// Возвращает адрес функции
function Library_GetSymbolS(Lib: ALibrary; const SymbolName: AString_Type; var Symbol: Pointer): ABoolean; stdcall;

{ Old }

procedure Runtime_SetConfig(Value: AConfig); stdcall; {deprecated}

// Use ShowMessageWS()
function Runtime_ShowMessage(const Msg: AWideString): ADialogBoxCommands; stdcall; deprecated;

// Use ShowMessageExWS()
function Runtime_ShowMessageA(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall; deprecated;

// Use ShellExecuteP()
function Runtime_ShellExecute(const Operation, FileName, Parameters, Directory: APascalString): AInteger; stdcall; deprecated;

function GetCompanyName(): APascalString; stdcall; deprecated;

function GetCopyright(): APascalString; stdcall; deprecated;

function GetDescription(): AWideString; stdcall; deprecated;

function GetExePath(): APascalString; stdcall; deprecated; // Use Info_GetDirectoryPathWS()

function GetExePathWS(): AWideString; stdcall;

function GetProductName(): APascalString; stdcall; //deprecated;

function GetProductVersion(): APascalString; stdcall; //deprecated;

function GetExeName(): APascalString; stdcall;

function GetExeNameWS(): AWideString; stdcall;

{**
  Gets the name, without the extension, of the assembly file for the application.
  Возвращает наименование программы.
  Prototype: System.Application.Info.AssemblyName
}
function GetProgramName(): APascalString; stdcall; deprecated; // Use GetProgramNameWS

{**
  Gets the name, without the extension, of the assembly file for the application.
  Возвращает наименование программы.
  Prototype: System.Application.Info.AssemblyName
}
function GetProgramNameWS(): AWideString; stdcall;

function GetProgramVersion(): APascalString; stdcall; deprecated;

function GetProgramVersionWS(): AWideString; stdcall;

function GetTitle(): APascalString; stdcall; deprecated; // Use Info_GetTitleWS()

//** Возвращает наименование программы.
function GetTitleWS(): AWideString; stdcall;

function GetUrl(): APascalString; stdcall; deprecated;

//** Возвращает полный путь к директории с данными.
function GetDataDirectoryPathWS(): APascalString; stdcall;

//** Возвращает полный путь к директории с данными.
function GetDataPath: APascalString; stdcall; //deprecated; // Use GetDataDirectoryPathWS()

//** Возвращает ресурс в виде строки.
function GetResourceString(const Section, Name, Default: AString_Type;
    out Value: AString_Type): AInteger; stdcall;

//** Возвращает ресурс в виде строки.
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

// Возвращяет указатель на конфигурацию программы.
function GetConfig(): AConfig; stdcall;

// Возвращент True, если получена команда на завершение работы
function GetIsShutdown(): ABoolean; stdcall;

{$IFDEF AOLD}
{$ELSE}
function ShellExecute(const Operation, FileName, Parameters, Directory: AString_Type): AInteger; stdcall;
{$ENDIF AOLD}

function ShellExecuteP(const Operation, FileName, Parameters, Directory: APascalString): AInteger; stdcall;

function ShellExecuteWS(const Operation, FileName, Parameters, Directory: AWideString): AInteger; stdcall;

function ShowError(const UserMessage, ExceptMessage: AString_Type): AError; stdcall;

procedure ShowError02(const UserMessage, ExceptMessage: AWideString); stdcall;

// Завершает работу программы.
procedure Shutdown(); stdcall;

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

// Обработчик по умолчанию
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

// --- ASystem ---

function ASystem_GetExePath(): APascalString; stdcall;
begin
  Result := FExePath;
end;

{ System public procs }

function Config: AConfig; stdcall;
begin
  Result := FConfig;
end;

{IFDEF AOLD}
{ELSE}
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
{ENDIF AOLD}

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

function Prepare(): AError; stdcall;
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

procedure Prepare4P(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, Comments, DataPath, ConfigPath: APascalString); stdcall;
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
end;

function Done(): AError; stdcall;
begin
  Result := 0;
end;

function Done03(): AInteger; stdcall;
begin
  Result := 0;
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

function GetExeName(): APascalString; stdcall;
begin
  Result := FExeName;
end;

function GetExeNameWS(): AWideString; stdcall;
begin
  Result := FExeName;
end;

function GetExePath(): APascalString; stdcall;
begin
  Result := FExePath;
end;

function GetExePathWS(): AWideString; stdcall;
begin
  Result := FExePath;
end;

function GetIsShutdown(): ABoolean; stdcall;
begin
  Result := ARuntime.GetIsShutdown;
end;

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
  Result := FTitle;
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
  Result := InitConfig();
end;

function Init03(): AInteger; stdcall;
begin
  Result := InitConfig();
end;

function InitConfig(): AInteger; stdcall;
begin
  {$IFDEF USE_CONFIG}
  System_InitConfig;
  {$ENDIF USE_CONFIG}
  Result := 0;
end;

function Library_BuildPath(Directory, LibraryName: AString; Value: AString): AInteger; stdcall;
begin
  Result := Library_BuildPathS(Directory^, LibraryName^, Value^);
end;

function Library_BuildPathP(const Directory, LibraryName: APascalString): APascalString; stdcall;
begin
  try
    Result := ALibraries.Library_BuildPath(Directory, LibraryName);
  except
    Result := '';
  end;
end;

function Library_BuildPathS(const Directory, LibraryName: AString_Type; out Value: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignP(Value, Library_BuildPathP(
        AStrings.String_ToWideString(Directory),
        AStrings.String_ToWideString(LibraryName)));
  except
    Result := 0;
  end;
end;

function Library_Close(Lib: ALibrary): ABoolean; stdcall;
begin
  try
    Result := ALibraries.Library_Close(Lib);
  except
    Result := False;
  end;
end;

function Library_GetName(Lib: ALibrary; Value: AString): AInteger; stdcall;
begin
  Result := Library_GetNameS(Lib, Value^);
end;

function Library_GetNameP(Lib: ALibrary): APascalString; stdcall;
begin
  try
    Result := ALibraries.Library_GetName(Lib);
  except
    Result := '';
  end;
end;

function Library_GetNameS(Lib: ALibrary; out Value: AString_Type): AInteger; stdcall;
var
  TmpValue: APascalString;
begin
  try
    TmpValue := Library_GetNameP(Lib);
    Result := AStrings.String_AssignP(Value, TmpValue);
  except
    Result := 0;
  end;
end;

function Library_GetProcAddress(Lib: ALibrary; const Name: AString_Type): Pointer; stdcall;
begin
  try
    Result := ALibraries.Library_GetProcAddress(Lib, AStrings.String_ToWideString(Name));
  except
    Result := nil;
  end;
end;

function Library_GetProcAddressP(Lib: ALibrary; const Name: APascalString): Pointer; stdcall;
begin
  try
    Result := ALibraries.Library_GetProcAddress(Lib, Name);
  except
    Result := nil;
  end;
end;

function Library_GetProcAddressS(Lib: ALibrary; Name: AString): Pointer; stdcall;
begin
  Result := Library_GetProcAddress(Lib, Name^);
end;

function Library_GetProcAddressWS(Lib: ALibrary; const Name: AWideString): Pointer; stdcall;
begin
  try
    Result := ALibraries.Library_GetProcAddress(Lib, Name);
  except
    Result := nil;
  end;
end;

function Library_GetSymbol(Lib: ALibrary; SymbolName: AString; Symbol: PPointer): ABoolean; stdcall;
begin
  Result := Library_GetSymbolS(Lib, SymbolName^, Symbol^);
end;

function Library_GetSymbolP(Lib: ALibrary; const SymbolName: APascalString; var Symbol: Pointer): ABoolean; stdcall;
begin
  try
    Result := ALibraries.Library_GetSymbol(Lib, SymbolName, Symbol);
  except
    Result := False;
  end;
end;

function Library_GetSymbolS(Lib: ALibrary; const SymbolName: AString_Type; var Symbol: Pointer): ABoolean; stdcall;
begin
  try
    Result := Library_GetSymbolP(Lib, AStrings.String_ToWideString(SymbolName), Symbol);
  except
    Result := False;
  end;
end;

function Library_Open(const FileName: AString_Type; Flags: ALibraryFlags): ALibrary; stdcall;
begin
  try
    Result := ALibraries.Library_Open(AStrings.String_ToWideString(FileName), Flags);
  except
    Result := 0;
  end;
end;

function Library_OpenP(const FileName: APascalString; Flags: ALibraryFlags): ALibrary; stdcall;
begin
  try
    Result := ALibraries.Library_Open(FileName, Flags);
  except
    Result := 0;
  end;
end;

function Library_OpenS(FileName: AString; Flags: ALibraryFlags): ALibrary; stdcall;
begin
  Result := Library_Open(FileName^, Flags);
end;

function Library_OpenWS(const FileName: AWideString; Flags: ALibraryFlags): ALibrary; stdcall;
begin
  try
    Result := ALibraries.Library_Open(FileName, Flags);
  except
    Result := 0;
  end;
end;

(*
{$IFDEF USE_EVENTS}
function Runtime_OnAfterRun: AEvent; stdcall;
begin
  Result := FOnAfterRunEvent;
end;
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
function Runtime_OnAfterRun_Connect(Callback: ACallbackProc; Weight: AInteger): Integer; stdcall;
begin
  Result := Event_Connect(FOnAfterRunEvent, Callback, Weight);
end;
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
function Runtime_OnAfterRun_Disconnect(Callback: ACallbackProc): Integer; stdcall;
begin
  Result := Event_Disconnect(FOnAfterRunEvent, Callback);
end;
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
function Runtime_OnBeforeRun: AEvent; stdcall;
begin
  Result := FOnBeforeRunEvent;
end;
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
function Runtime_OnBeforeRun_Connect(Callback: ACallbackProc; Weight: AInteger = High(AInteger)): AInteger; stdcall;
begin
  Result := Event_Connect(FOnBeforeRunEvent, Callback, Weight);
end;
{$ENDIF USE_EVENTS}

{$IFDEF USE_EVENTS}
function Runtime_OnBeforeRun_Disconnect(Callback: ACallbackProc): Integer; stdcall;
begin
  Result := Event_Disconnect(FOnBeforeRunEvent, Callback);
end;
{$ENDIF USE_EVENTS}

function Runtime_ParamCount: AInteger; stdcall;
begin
  Result := ParamCount;
end;

function Runtime_ParamStr(Index: AInteger): APascalString; stdcall;
begin
  Result := System.ParamStr(Index);
end;

procedure Runtime_ProcessMessages; stdcall;
begin
  ProcessMessages;
end;
*)

procedure Runtime_SetConfig(Value: AConfig); stdcall;
begin
  FConfig := Value;
end;

(*
procedure Runtime_SetOnProcessMessages(Value: AProc); stdcall;
begin
  SetOnProcessMessages(Value); //FOnProcessMessages := Value;
end;

procedure Runtime_SetOnShowError(Value: TAShowErrorProc); stdcall;
begin
  SetOnShowError(Value); //FOnShowError := Value;
end;

procedure Runtime_SetOnShowMessage(Value: TAShowMessageProc); stdcall;
begin
  SetOnShowMessage(Value); //FOnShowMessage := Value;
end;
*)

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
  Result := System_ShowMessage(Msg);
end;

function Runtime_ShowMessageA(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;
begin
  Result := System_ShowMessageEx(Text, Caption, Flags);
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
  try
    Result := ShellExecuteWS(
        AStrings.String_ToWideString(Operation),
        AStrings.String_ToWideString(FileName),
        AStrings.String_ToWideString(Parameters),
        AStrings.String_ToWideString(Directory));
  except
    Result := -1;
  end;
end;

function ShellExecuteP(const Operation, FileName, Parameters, Directory: APascalString): AInteger; stdcall;
begin
  Result := ShellExecuteA(0,
      PAnsiChar(AnsiString(Operation)),
      PAnsiChar(AnsiString(FileName)),
      PAnsiChar(AnsiString(Parameters)),
      PAnsiChar(AnsiString(Directory)),
      SW_SHOW);
end;

function ShellExecuteWS(const Operation, FileName, Parameters, Directory: AWideString): AInteger; stdcall;
begin
  //{$IFNDEF UNIX}
  Result := ShellExecuteA(0,
      PAnsiChar(AnsiString(Operation)),
      PAnsiChar(AnsiString(FileName)),
      PAnsiChar(AnsiString(Parameters)),
      PAnsiChar(AnsiString(Directory)),
      SW_SHOW);
  //{$ENDIF}
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
  try
    Result := System_ShowMessage(AStrings.String_ToPascalString(Msg));
  except
    Result := -1;
  end;
end;

function ShowMessage02(const Msg: AWideString): ADialogBoxCommands; stdcall;
begin
  try
    Result := System_ShowMessage(Msg);
  except
    Result := -1;
  end;
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
  try
    Result := System_ShowMessageEx(Text, Caption, Flags);
  except
    Result := -1;
  end;
end;

function ShowMessageExWS(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;
begin
  try
    Result := System_ShowMessageEx(Text, Caption, Flags);
  except
    Result := -1;
  end;
end;

function ShowMessageP(const Msg: APascalString): ADialogBoxCommands; stdcall;
begin
  try
    Result := System_ShowMessage(Msg);
  except
    Result := -1;
  end;
end;

function ShowMessageWS(const Msg: AWideString): ADialogBoxCommands; stdcall;
begin
  try
    Result := System_ShowMessage(Msg);
  except
    Result := -1;
  end;
end;

procedure Shutdown(); stdcall;
begin
  ARuntime.Shutdown();
end;

end.
