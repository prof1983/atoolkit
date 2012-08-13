{**
@Abstract ASystem
@Author Prof1983 <prof1983@ya.ru>
@Created 27.09.2011
@LastMod 13.08.2012
}
unit ASystemMain;

{$I Defines.inc}

{$IFNDEF NoRuntime}
  {$DEFINE USE_RUNTIME}
{$ENDIF}

interface

uses
  {$IFNDEF FPC}
    {$IFNDEF UNIX}ShellApi,{$ENDIF}
  {$ENDIF}
  {$IFNDEF UNIX}Windows,{$ENDIF}
  ABase, ABaseTypes,
  {$IFDEF USE_RUNTIME}ARuntime,{$ENDIF}
  AStrings, ASystemData;

// --- ASystem ---

function ASystem_Fin(): AError; stdcall;

function ASystem_GetConfig(): AConfig; stdcall;

function ASystem_GetConfigDirectoryPathP(): APascalString; stdcall;

function ASystem_GetDataDirectoryPathP(): APascalString; stdcall;

function ASystem_GetExePathP(): APascalString; stdcall;

function ASystem_GetTitleP(): APascalString; stdcall;

function ASystem_Init(): AError; stdcall;

function ASystem_Prepare3P(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath, ConfigPath: APascalString): AError; stdcall;

function ASystem_ShellExecute(const Operation, FileName, Parameters, Directory: AString_Type): AInteger; stdcall;

function ASystem_ShellExecuteP(const Operation, FileName, Parameters, Directory: APascalString): AInteger; stdcall;

function ASystem_ShowMessage(const Msg: AString_Type): ADialogBoxCommands; stdcall;

function ASystem_ShowMessageExP(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

function ASystem_ShowMessageExWS(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

function ASystem_ShowMessageP(const Msg: APascalString): ADialogBoxCommands; stdcall;

function ASystem_ShowMessageWS(const Msg: AWideString): ADialogBoxCommands; stdcall;

{$IFDEF USE_RUNTIME}
function ASystem_Shutdown(): AError; stdcall;
{$ENDIF}

// --- System ---

function System_ShowMessage(const Msg: AWideString): ADialogBoxCommands;
function System_ShowMessageEx(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands;

implementation

// TODO: Remove
uses
  ASystem;

// --- ASystem ---

function ASystem_Fin(): AError; 
begin
  Result := 0;
end;

function ASystem_GetConfig(): AConfig;
begin
  Result := FConfig;
end;

function ASystem_GetConfigDirectoryPathP(): APascalString;
begin
  Result := FConfigPath;
end;

function ASystem_GetDataDirectoryPathP(): APascalString;
begin
  Result := FDataPath;
end;

function ASystem_GetExePathP(): APascalString;
begin
  Result := FExePath;
end;

function ASystem_GetTitleP(): APascalString;
begin
  Result := FTitle;
end;

function ASystem_Init(): AError;
begin
  Result := InitConfig();
end;

function ASystem_Prepare3P(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath, ConfigPath: APascalString): AError;
begin
  Result := Prepare3WS(Title, ProgramName, ProgramVersion, ProductName, ProductVersion,
      CompanyName, Copyright, Url, Description, DataPath, ConfigPath);
end;

function ASystem_ShellExecute(const Operation, FileName, Parameters, Directory: AString_Type): AInteger;
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

function ASystem_ShellExecuteP(const Operation, FileName, Parameters, Directory: APascalString): AInteger;
begin
  Result := ShellExecuteA(0,
      PAnsiChar(AnsiString(Operation)),
      PAnsiChar(AnsiString(FileName)),
      PAnsiChar(AnsiString(Parameters)),
      PAnsiChar(AnsiString(Directory)),
      SW_SHOW);
end;

function ASystem_ShowMessage(const Msg: AString_Type): ADialogBoxCommands;
begin
  try
    Result := System_ShowMessage(AStrings.String_ToPascalString(Msg));
  except
    Result := -1;
  end;
end;

function ASystem_ShowMessageExP(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands;
begin
  try
    Result := System_ShowMessageEx(Text, Caption, Flags);
  except
    Result := -1;
  end;
end;

function ASystem_ShowMessageExWS(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands;
begin
  try
    Result := System_ShowMessageEx(Text, Caption, Flags);
  except
    Result := -1;
  end;
end;

function ASystem_ShowMessageP(const Msg: APascalString): ADialogBoxCommands;
begin
  try
    Result := System_ShowMessage(Msg);
  except
    Result := -1;
  end;
end;

function ASystem_ShowMessageWS(const Msg: AWideString): ADialogBoxCommands;
begin
  try
    Result := System_ShowMessage(Msg);
  except
    Result := -1;
  end;
end;

{$IFDEF USE_RUNTIME}
function ASystem_Shutdown(): AError;
begin
  Result := ARuntime_Shutdown();
end;
{$ENDIF USE_RUNTIME}

// --- System ---

function System_ShowMessage(const Msg: AWideString): ADialogBoxCommands;
begin
  Result := System_ShowMessageEx(Msg, FTitle, MB_OK);
end;

function System_ShowMessageEx(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands;
begin
  if Assigned(FOnShowMessage) then
    Result := FOnShowMessage(Text, Caption, Flags)
  else
    Result := 0;
end;

end.
 