{**
@Abstract ASystem
@Author Prof1983 <prof1983@ya.ru>
@Created 27.09.2011
@LastMod 25.12.2012
}
unit ASystemMain;

{$I Defines.inc}

{$define AStdCall}

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
  {$IFDEF USE_RUNTIME}ARuntimeMain,{$ENDIF}
  AStrings, ASystemData;

// --- ASystem ---

function ASystem_Fin(): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetConfig(): AConfig; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetConfigDirectoryPath(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetConfigDirectoryPathP(): APascalString; stdcall;

function ASystem_GetDataDirectoryPath(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetDataDirectoryPathP(): APascalString; stdcall;

function ASystem_GetDirectoryPath(out Value: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetDirectoryPathP(): APascalString;

function ASystem_GetExeNameP(): APascalString;

function ASystem_GetExePath(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetExePathP(): APascalString; stdcall;

function ASystem_GetProgramName(out Value: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetProgramNameP(): APascalString; stdcall;

function ASystem_GetTitle(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetTitleP(): APascalString; stdcall;

function ASystem_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_ParamStr(Index: AInteger; out Value: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_ParamStrP(Index: AInteger): APascalString; stdcall;

function ASystem_Prepare3P(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath, ConfigPath: APascalString): AError; stdcall;

function ASystem_ProcessMessages(): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_SetOnProcessMessages(Value: AProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_SetOnShowErrorA(Value: AShowErrorA_Proc): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_SetOnShowMessageA(Value: AShowMessageA_Proc): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_SetOnShowMessageWS(Value: TAShowMessageWSProc): AError;

function ASystem_ShellExecute(const Operation, FileName, Parameters, Directory: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_ShellExecuteP(const Operation, FileName, Parameters, Directory: APascalString): AInteger; stdcall;

function ASystem_ShowError(const UserMessage, ExceptMessage: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_ShowErrorA(UserMessage, ExceptMessage: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_ShowErrorP(const UserMessage, ExceptMessage: APascalString): AError; stdcall;

function ASystem_ShowMessage(const Msg: AString_Type): ADialogBoxCommands; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_ShowMessageA(Msg: AStr): ADialogBoxCommands; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_ShowMessageEx(const Text, Caption: AString_Type; Flags: AMessageBoxFlags): ADialogBoxCommands; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_ShowMessageExA(Text, Caption: AStr; Flags: AMessageBoxFlags): ADialogBoxCommands; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_ShowMessageExP(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

function ASystem_ShowMessageExWS(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

function ASystem_ShowMessageP(const Msg: APascalString): ADialogBoxCommands; stdcall;

function ASystem_ShowMessageWS(const Msg: AWideString): ADialogBoxCommands; stdcall;

{$IFDEF USE_RUNTIME}
function ASystem_Shutdown(): AError; {$ifdef AStdCall}stdcall;{$endif}
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

function ASystem_GetConfigDirectoryPath(out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, FConfigPath);
end;

function ASystem_GetConfigDirectoryPathP(): APascalString;
begin
  Result := FConfigPath;
end;

function ASystem_GetDataDirectoryPath(out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, FDataPath);
end;

function ASystem_GetDataDirectoryPathP(): APascalString;
begin
  Result := FDataPath;
end;

function ASystem_GetDirectoryPath(out Value: AString_Type): AInteger;
begin
  Result := AStrings.String_AssignP(Value, FExePath);
end;

function ASystem_GetDirectoryPathP(): APascalString;
begin
  Result := FExePath;
end;

function ASystem_GetExeNameP(): APascalString;
begin
  Result := FExeName;
end;

function ASystem_GetExePath(out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, FExePath);
end;

function ASystem_GetExePathP(): APascalString;
begin
  Result := FExePath;
end;

function ASystem_GetProgramName(out Value: AString_Type): AInteger;
begin
  Result := AString_AssignP(Value, FProgramName);
end;

function ASystem_GetProgramNameP(): APascalString;
begin
  Result := FProgramName;
end;

function ASystem_GetTitle(out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, FTitle);
end;

function ASystem_GetTitleP(): APascalString;
begin
  Result := FTitle;
end;

function ASystem_Init(): AError;
begin
  Result := InitConfig();
end;

function ASystem_ParamStr(Index: AInteger; out Value: AString_Type): AInteger;
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

function ASystem_ParamStrP(Index: AInteger): APascalString; 
begin
  try
    Result := System.ParamStr(Index);
  except
    Result := '';
  end;
end;

function ASystem_Prepare3P(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath, ConfigPath: APascalString): AError;
begin
  Result := Prepare3WS(Title, ProgramName, ProgramVersion, ProductName, ProductVersion,
      CompanyName, Copyright, Url, Description, DataPath, ConfigPath);
end;

function ASystem_ProcessMessages(): AError;
var
  R: AError;
begin
  R := 1;

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

  if Assigned(FOnProcessMessages03) then
  try
    FOnProcessMessages03;
    R := 0;
  except
    R := -1;
  end;

  Result := R;
  Exit;
end;

function ASystem_SetOnProcessMessages(Value: AProc): AError;
begin
  FOnProcessMessages03 := Value;
  Result := 0;
end;

function ASystem_SetOnShowErrorA(Value: AShowErrorA_Proc): AError;
begin
  FOnShowErrorA := Value;
  Result := 0;
end;

function ASystem_SetOnShowMessageA(Value: AShowMessageA_Proc): AError;
begin
  FOnShowMessageA := Value;
  Result := 0;
end;

function ASystem_SetOnShowMessageWS(Value: TAShowMessageWSProc): AError;
begin
  FOnShowMessageWS := Value;
  Result := 0;
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

function ASystem_ShowError(const UserMessage, ExceptMessage: AString_Type): AError; stdcall;
begin
  try
    Result := ASystem_ShowErrorP(
          AString_ToPascalString(UserMessage),
          AString_ToPascalString(ExceptMessage));
  except
    Result := -1;
  end;
end;

function ASystem_ShowErrorA(UserMessage, ExceptMessage: AStr): AError; stdcall;
begin
  try
    Result := ASystem_ShowErrorP(AnsiString(UserMessage), AnsiString(ExceptMessage));
  except
    Result := -1;
  end;
end;

function ASystem_ShowErrorP(const UserMessage, ExceptMessage: APascalString): AError; stdcall;
var
  R: AError;
begin
  try
    R := 1;
    if Assigned(FOnShowErrorA) then
    begin
      FOnShowErrorA(AStr(AnsiString(FTitle)), AStr(AnsiString(UserMessage)), AStr(AnsiString(ExceptMessage)));
      R := 0;
    end;
    if Assigned(FOnShowErrorWS) then
    begin
      FOnShowErrorWS(FTitle, UserMessage, ExceptMessage);
      R := 0;
    end;
    Result := R;
  except
    Result := -1;
  end;
end;

function ASystem_ShowMessage(const Msg: AString_Type): ADialogBoxCommands;
begin
  try
    Result := ASystem_ShowMessageP(AString_ToPascalString(Msg));
  except
    Result := -1;
  end;
end;

function ASystem_ShowMessageA(Msg: AStr): ADialogBoxCommands;
begin
  try
    Result := ASystem_ShowMessageP(AnsiString(Msg));
  except
    Result := -1;
  end;
end;

function ASystem_ShowMessageEx(const Text, Caption: AString_Type; Flags: AMessageBoxFlags): ADialogBoxCommands;
begin
  try
    Result := ASystem_ShowMessageExP(
        AString_ToPascalString(Text),
        AString_ToPascalString(Caption),
        Flags);
  except
    Result := -1;
  end;
end;

function ASystem_ShowMessageExA(Text, Caption: AStr; Flags: AMessageBoxFlags): ADialogBoxCommands;
begin
  try
    Result := ASystem_ShowMessageExP(AnsiString(Text), AnsiString(Caption), Flags);
  except
    Result := -1;
  end;
end;

function ASystem_ShowMessageExP(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands;
begin
  try
    if Assigned(FOnShowMessageA) then
    begin
      Result := FOnShowMessageA(AStr(AnsiString(Text)), AStr(AnsiString(Caption)), Flags);
      Exit;
    end;
    if Assigned(FOnShowMessageWS) then
    begin
      Result := FOnShowMessageWS(Text, Caption, Flags);
      Exit;
    end;
    Result := 0;
  except
    Result := -1;
  end;
end;

function ASystem_ShowMessageExWS(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands;
begin
  Result := ASystem_ShowMessageExP(Text, Caption, Flags);
end;

function ASystem_ShowMessageP(const Msg: APascalString): ADialogBoxCommands;
begin
  Result := ASystem_ShowMessageExP(Msg, FTitle, MB_OK);
end;

function ASystem_ShowMessageWS(const Msg: AWideString): ADialogBoxCommands;
begin
  Result := ASystem_ShowMessageP(Msg);
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
  Result := ASystem_ShowMessageP(Msg);
end;

function System_ShowMessageEx(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands;
begin
  Result := ASystem_ShowMessageExP(Text, Caption, Flags);
end;

end.
 