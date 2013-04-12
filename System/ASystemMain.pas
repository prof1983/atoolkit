{**
@Abstract ASystem
@Author Prof1983 <prof1983@ya.ru>
@Created 27.09.2011
@LastMod 27.03.2013
}
unit ASystemMain;

{$I Defines.inc}

{define AStdCall}

{$ifndef NoRuntime}
  {$define UseRuntime}
{$endif}

{$ifdef UseRuntime}
  {$ifndef NoRuntimeEvents}
    {$define UseEvents}
  {$endif}
{$endif}

interface

uses
  {$IFNDEF FPC}
    {$IFNDEF UNIX}ShellApi,{$ENDIF}
  {$ENDIF}
  {$IFNDEF UNIX}Windows,{$ENDIF}
  ABase,
  ABaseTypes,
  AErrorObj,
  {$ifdef UseRuntime}ARuntimeMain,{$endif}
  AStringMain,
  {$ifdef UseConfig}ASystemConfig,{$endif}
  ASystemData,
  {$ifdef UseEvents}ASystemEvents,{$endif}
  ASystemPrepare;

// --- ASystem ---

function ASystem_Fin(): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetComments(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetCommentsP(): APascalString;

function ASystem_GetCompanyName(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetCompanyNameP(): APascalString;

function ASystem_GetConfig(): AConfig; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetConfigDirectoryPath(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetConfigDirectoryPathP(): APascalString;

function ASystem_GetCopyright(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetCopyrightP(): APascalString;

function ASystem_GetDataDirectoryPath(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetDataDirectoryPathP(): APascalString;

function ASystem_GetDescription(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetDescriptionP(): APascalString;

function ASystem_GetDirectoryPath(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetDirectoryPathP(): APascalString;

function ASystem_GetExeName(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetExeNameP(): APascalString;

function ASystem_GetExePath(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetExePathP(): APascalString;

function ASystem_GetParamStr(Index: AInt; out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetParamStrP(Index: AInt): APascalString;

function ASystem_GetProductName(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetProductNameP(): APascalString;

function ASystem_GetProductVersionStr(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetProductVersionStrP(): APascalString;

function ASystem_GetProgramName(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetProgramNameP(): APascalString;

function ASystem_GetProgramVersionStr(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetProgramVersionStrP(): APascalString;

function ASystem_GetTitle(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetTitleP(): APascalString;

function ASystem_GetUrl(out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetUrlP(): APascalString;

function ASystem_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_ParamStr(Index: AInt; out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif} deprecated {$ifdef ADeprText}'Use ASystem_GetParamStr()'{$endif};

function ASystem_ParamStrP(Index: AInt): APascalString; deprecated {$ifdef ADeprText}'Use ASystem_GetParamStrP()'{$endif};

function ASystem_Prepare(const Title, ProgramName: AString_Type; ProgramVersion: AVersion;
    const ProductName: AString_Type; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath, ConfigPath: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_PrepareA(Title, ProgramName: AStr; ProgramVersion: AVersion;
    ProductName: AStr; ProductVersion: AVersion;
    CompanyName, Copyright, Url, Description, DataPath, ConfigPath: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_PrepareP(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath, ConfigPath: APascalString): AError;

function ASystem_ProcessMessages(): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_SetConfig(Value: AConfig): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_SetDataDirectoryPath(const DataDir: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_SetDataDirectoryPathP(const DataDir: APascalString): AError;

function ASystem_SetOnProcessMessages(Value: AProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_SetOnShowErrorA(Value: AShowErrorA_Proc): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_SetOnShowMessageA(Value: AShowMessageA_Proc): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_ShellExecute(const Operation, FileName, Parameters, Directory: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_ShellExecuteP(const Operation, FileName, Parameters, Directory: APascalString): AInt;

function ASystem_ShowError(const UserMessage, ExceptMessage: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_ShowErrorA(UserMessage, ExceptMessage: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_ShowErrorExP(const SimpleMessage: APascalString; Error: AError): AError;

function ASystem_ShowErrorP(const UserMessage, ExceptMessage: APascalString): AError;

function ASystem_ShowMessage(const Msg: AString_Type): ADialogBoxCommands; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_ShowMessageA(Msg: AStr): ADialogBoxCommands; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_ShowMessageEx(const Text, Caption: AString_Type; Flags: AMessageBoxFlags): ADialogBoxCommands; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_ShowMessageExA(Text, Caption: AStr; Flags: AMessageBoxFlags): ADialogBoxCommands; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_ShowMessageExP(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands;

function ASystem_ShowMessageP(const Msg: APascalString): ADialogBoxCommands;

{$ifdef UseRuntime}
function ASystem_Shutdown(): AError; {$ifdef AStdCall}stdcall;{$endif}
{$endif}

implementation

// --- Events ---

function DoShowMessageA(Text, Caption: AStr; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;
begin
  if (Length(Caption) <= 0) then
    Result := Windows.MessageBox(0, PChar(string(Text)), PChar(string(FTitle)), Flags)
  else
    Result := Windows.MessageBox(0, PChar(string(Text)), PChar(string(Caption)), Flags);
end;

// --- ASystem ---

function ASystem_Fin(): AError; 
begin
  Result := 0;
end;

function ASystem_GetComments(out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, FComments);
end;

function ASystem_GetCommentsP(): APascalString;
begin
  Result := FComments;
end;

function ASystem_GetCompanyName(out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, FCompanyName);
end;

function ASystem_GetCompanyNameP(): APascalString;
begin
  Result := FCompanyName;
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

function ASystem_GetCopyright(out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, FCopyright);
end;

function ASystem_GetCopyrightP(): APascalString;
begin
  Result := FCopyright;
end;

function ASystem_GetDataDirectoryPath(out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, FDataPath);
end;

function ASystem_GetDataDirectoryPathP(): APascalString;
begin
  Result := FDataPath;
end;

function ASystem_GetDescription(out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, FDescription);
end;

function ASystem_GetDescriptionP(): APascalString;
begin
  Result := FDescription;
end;

function ASystem_GetDirectoryPath(out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, FExePath);
end;

function ASystem_GetDirectoryPathP(): APascalString;
begin
  Result := FExePath;
end;

function ASystem_GetExeName(out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, FExeName);
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

function ASystem_GetParamStr(Index: AInt; out Value: AString_Type): AError;
var
  Res: string;
begin
  try
    Res := System.ParamStr(Index);
    Result := AString_AssignP(Value, Res);
  except
    Result := -1;
  end;
end;

function ASystem_GetParamStrP(Index: AInt): APascalString;
begin
  try
    Result := System.ParamStr(Index);
  except
    Result := '';
  end;
end;

function ASystem_GetProductName(out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, FProductName);
end;

function ASystem_GetProductNameP(): APascalString;
begin
  Result := FProductName;
end;

function ASystem_GetProductVersionStr(out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, FProductVersionStr);
end;

function ASystem_GetProductVersionStrP(): APascalString;
begin
  Result := FProductVersionStr;
end;

function ASystem_GetProgramName(out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, FProgramName);
end;

function ASystem_GetProgramNameP(): APascalString;
begin
  Result := FProgramName;
end;

function ASystem_GetProgramVersionStr(out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, FProgramVersionStr);
end;

function ASystem_GetProgramVersionStrP(): APascalString;
begin
  Result := FProgramVersionStr;
end;

function ASystem_GetTitle(out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, FTitle);
end;

function ASystem_GetTitleP(): APascalString;
begin
  Result := FTitle;
end;

function ASystem_GetUrl(out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, FUrl);
end;

function ASystem_GetUrlP(): APascalString;
begin
  Result := FUrl;
end;

function ASystem_Init(): AError;
begin
  {$ifdef UseConfig}
  System_InitConfig();
  {$endif}
  Result := 0;
end;

function ASystem_ParamStr(Index: AInt; out Value: AString_Type): AError;
begin
  Result := ASystem_GetParamStr(Index, Value);
end;

function ASystem_ParamStrP(Index: AInt): APascalString;
begin
  Result := ASystem_GetParamStrP(Index);
end;

function ASystem_Prepare(const Title, ProgramName: AString_Type; ProgramVersion: AVersion;
    const ProductName: AString_Type; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath, ConfigPath: AString_Type): AError;
begin
  Result := ASystem_PrepareP(
      AString_ToPascalString(Title),
      AString_ToPascalString(ProgramName),
      ProgramVersion,
      AString_ToPascalString(ProductName),
      ProductVersion,
      AString_ToPascalString(CompanyName),
      AString_ToPascalString(Copyright),
      AString_ToPascalString(Url),
      AString_ToPascalString(Description),
      AString_ToPascalString(DataPath),
      AString_ToPascalString(ConfigPath));
end;

function ASystem_PrepareA(Title, ProgramName: AStr; ProgramVersion: AVersion;
    ProductName: AStr; ProductVersion: AVersion;
    CompanyName, Copyright, Url, Description, DataPath, ConfigPath: AStr): AError;
begin
  Result := ASystem_PrepareP(
      AnsiString(Title),
      AnsiString(ProgramName),
      ProgramVersion,
      AnsiString(ProductName),
      ProductVersion,
      AnsiString(CompanyName),
      AnsiString(Copyright),
      AnsiString(Url),
      AnsiString(Description),
      AnsiString(DataPath),
      AnsiString(ConfigPath));
end;

function ASystem_PrepareP(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, DataPath, ConfigPath: APascalString): AError;
{$ifdef UseEvents}
var
  R: AError;
{$endif}
begin
  try
    ASystem_SetOnShowMessageA(DoShowMessageA);
    {$ifdef UseEvents}
    R := ASystemEvents_Init();
    if (R < 0) then
    begin
      Result := R;
      Exit;
    end;
    {$endif}

    System_Prepare(Title, ProgramName, ProgramVersion, ProductName, ProductVersion,
        CompanyName, Copyright, Url, Description, '', DataPath, ConfigPath);

    Result := 0;
  except
    Result := -1;
  end;
end;

function ASystem_ProcessMessages(): AError;
var
  R: AError;
begin
  R := 1;

  if Assigned(FOnProcessMessages) then
  try
    FOnProcessMessages;
    R := 0;
  except
    R := -1;
  end;

  Result := R;
  Exit;
end;

function ASystem_SetConfig(Value: AConfig): AError;
begin
  FConfig := Value;
  Result := 0;
end;

function ASystem_SetDataDirectoryPath(const DataDir: AString_Type): AError;
begin
  Result := ASystem_SetDataDirectoryPathP(AString_ToPascalString(DataDir));
end;

function ASystem_SetDataDirectoryPathP(const DataDir: APascalString): AError;
begin
  FDataPath := DataDir;
  Result := 0;
end;

function ASystem_SetOnProcessMessages(Value: AProc): AError;
begin
  FOnProcessMessages := Value;
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

function ASystem_ShellExecute(const Operation, FileName, Parameters, Directory: AString_Type): AInt;
begin
  try
    Result := ASystem_ShellExecuteP(
        AString_ToPascalString(Operation),
        AString_ToPascalString(FileName),
        AString_ToPascalString(Parameters),
        AString_ToPascalString(Directory));
  except
    Result := -1;
  end;
end;

function ASystem_ShellExecuteP(const Operation, FileName, Parameters, Directory: APascalString): AInt;
begin
  Result := ShellExecuteA(0,
      PAnsiChar(AnsiString(Operation)),
      PAnsiChar(AnsiString(FileName)),
      PAnsiChar(AnsiString(Parameters)),
      PAnsiChar(AnsiString(Directory)),
      SW_SHOW);
end;

function ASystem_ShowError(const UserMessage, ExceptMessage: AString_Type): AError;
begin
  try
    Result := ASystem_ShowErrorP(
          AString_ToPascalString(UserMessage),
          AString_ToPascalString(ExceptMessage));
  except
    Result := -1;
  end;
end;

function ASystem_ShowErrorA(UserMessage, ExceptMessage: AStr): AError;
begin
  try
    Result := ASystem_ShowErrorP(
        APascalString(AnsiString(UserMessage)),
        APascalString(AnsiString(ExceptMessage)));
  except
    Result := -1;
  end;
end;

function ASystem_ShowErrorExP(const SimpleMessage: APascalString; Error: AError): AError;
begin
  Result := ASystem_ShowErrorP(SimpleMessage, AError_GetMsgP(Error));
end;

function ASystem_ShowErrorP(const UserMessage, ExceptMessage: APascalString): AError;
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
    Result := ASystem_ShowMessageP(APascalString(AnsiString(Msg)));
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
    Result := ASystem_ShowMessageExP(
        APascalString(AnsiString(Text)),
        APascalString(AnsiString(Caption)),
        Flags);
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
    Result := 0;
  except
    Result := -1;
  end;
end;

function ASystem_ShowMessageP(const Msg: APascalString): ADialogBoxCommands;
begin
  Result := ASystem_ShowMessageExP(Msg, FTitle, MB_OK);
end;

{$ifdef UseRuntime}
function ASystem_Shutdown(): AError;
begin
  Result := ARuntime_Shutdown();
end;
{$endif}

end.
 