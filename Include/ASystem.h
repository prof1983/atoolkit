/*
Author Prof1983 <prof1983@ya.ru>
Created 04.03.2013
LastMod 04.03.2013
*/

#include "ABase"

AError
afunc ASystem_Fin();

AError
afunc ASystem_GetComments(AString Value);

AError
afunc ASystem_GetCompanyName(AString Value);

AConfig
afunc ASystem_GetConfig();

AError
afunc ASystem_GetConfigDirectoryPath(AString Value);

AError
afunc ASystem_GetCopyright(AString Value);

AError
afunc ASystem_GetDataDirectoryPath(AString Value);

AError
afunc ASystem_GetDescription(AString Value);

AError
afunc ASystem_GetDirectoryPath(AString Value);

AError
afunc ASystem_GetExeName(AString Value);

AError
afunc ASystem_GetExePath(AString Value);

AInt
afunc ASystem_GetParamStr(AInt Index, AString Value);

AError
afunc ASystem_GetProductName(AString Value);

AError
afunc ASystem_GetProductVersionStr(AString Value);

AError
afunc ASystem_GetProgramName(AString Value);

AError
afunc ASystem_GetProgramVersionStr(AString Value);

AError
afunc ASystem_GetTitle(AString Value);

AError
afunc ASystem_GetUrl(AString Value);

AError
afunc ASystem_Init();

AError
afunc ASystem_Prepare(AString Title, AString ProgramName, AVersion ProgramVersion,
    AString ProductName, AVersion ProductVersion, Astring CompanyName, AString Copyright,
    AString Url, AString Description, AString DataPath, AString ConfigPath);

AError
afunc ASystem_PrepareA(AStr Title, AStr ProgramName, AVersion ProgramVersion,
    AStr ProductName, AVersion ProductVersion, AStr CompanyName, AStr Copyright,
    AStr Url, AStr Description, AStr DataPath, AStr ConfigPath);

AError
afunc ASystem_ProcessMessages();

AError
afunc ASystem_SetConfig(AConfig Value);

AError
afunc ASystem_SetDataDirectoryPath(AString DataDir);

AError
afunc ASystem_SetOnProcessMessages(AProc Value);

AError
afunc ASystem_SetOnShowErrorA(AShowErrorA_Proc Value);

AError
afunc ASystem_SetOnShowMessageA(AShowMessageA_Proc Value);

AInt
afunc ASystem_ShellExecute(AString Operation, AString FileName, AString Parameters, AString Directory);

AError
afunc ASystem_ShowError(AString UserMessage, AString ExceptMessage);

AError
afunc ASystem_ShowErrorA(AStr UserMessage, AStr ExceptMessage);

ADialogBoxCommands
afunc ASystem_ShowMessage(AString Msg);

ADialogBoxCommands
afunc ASystem_ShowMessageA(AStr Msg);

ADialogBoxCommands
afunc ASystem_ShowMessageEx(AString Text, AString Caption, AMessageBoxFlags Flags);

ADialogBoxCommands
afunc ASystem_ShowMessageExA(AStr Text, AStr Caption, AMessageBoxFlags Flags);
