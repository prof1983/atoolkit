/*  ASystem lib import
	Author Prof1983 <prof1983@ya.ru>
	Created 28.08.2012
	LastMod 28.08.2012
*/

#include "ALibraries.h"
#include "ASystemLibImp.h"

ASystem_GetConfig_Proc _GetConfig;
ASystem_GetResourceString_Proc _GetResourceString;
ASystem_Init_Proc _Init;
ASystem_ParamStr_Proc _ParamStr;
ASystem_Prepare_Proc _Prepare;
ASystem_Prepare2_Proc _Prepare2;
ASystem_Prepare2A_Proc _Prepare2A;
ASystem_ProcessMessages_Proc _ProcessMessages;
ASystem_ShellExecute_Proc _ShellExecute;
ASystem_ShowMessage_Proc _ShowMessage;
ASystem_ShowMessageA_Proc _ShowMessageA;
ASystem_ShowMessageEx_Proc _ShowMessageEx;

// ----

AError
afunc ASystem_Boot(ALibrary Lib)
{
	_GetConfig = (ASystem_GetConfig_Proc)ALibrary_GetProcAddressA(Lib, "ASystem_GetConfig");
	_Init = (ASystem_Init_Proc)ALibrary_GetProcAddressA(Lib, "ASystem_Init");
	_ParamStr = (ASystem_ParamStr_Proc)ALibrary_GetProcAddressA(Lib, "ASystem_ParamStr");
	_Prepare = (ASystem_Prepare_Proc)ALibrary_GetProcAddressA(Lib, "ASystem_Prepare");
	_Prepare2 = (ASystem_Prepare2_Proc)ALibrary_GetProcAddressA(Lib, "ASystem_Prepare2");
	_Prepare2A = (ASystem_Prepare2A_Proc)ALibrary_GetProcAddressA(Lib, "ASystem_Prepare2A");
	_ProcessMessages = (ASystem_ProcessMessages_Proc)ALibrary_GetProcAddressA(Lib, "ASystem_ProcessMessages");
	_ShellExecute = (ASystem_ShellExecute_Proc)ALibrary_GetProcAddressA(Lib, "ASystem_ShellExecute");
	_ShowMessage = (ASystem_ShowMessage_Proc)ALibrary_GetProcAddressA(Lib, "ASystem_ShowMessage");
	_ShowMessageA = (ASystem_ShowMessageA_Proc)ALibrary_GetProcAddressA(Lib, "ASystem_ShowMessageA");
	_ShowMessageEx = (ASystem_ShowMessageEx_Proc)ALibrary_GetProcAddressA(Lib, "ASystem_ShowMessageEx");
	return 0;
}

AError
afunc ASystem_Fin()
{
	return _Fin();
}

AConfig
afunc ASystem_GetConfig()
{
	return _GetConfig();
}

AError
afunc ASystem_Init()
{
	return _Init();
}

AInt
afunc ASystem_ParamStr(AInt Index, /*out*/ AString Value)
{
	return _ParamStr(Index, Value);
}

AError
afunc ASystem_Prepare()
{
	return _Prepare();
}

AError
afunc A_System_Prepare2(
	/*const*/ AString Title,
	/*const*/ AString ProgramName,
	AVersion ProgramVersion,
	/*const*/ AString ProductName,
	AVersion ProductVersion,
	/*const*/ AString CompanyName,
	/*const*/ AString Copyright,
	/*const*/ AString Url,
	/*const*/ AString Description,
	/*const*/ AString DataPath)
{
	return _Prepare2(Title, ProgramName, ProgramVersion, ProductName, ProductVersion,
		CompanyName, Copyright, Url, Description, DataPath);
}

AError
afunc ASystem_Prepare2A(
	/*const*/ AStr Title,
	/*const*/ AStr ProgramName,
	AVersion ProgramVersion,
	/*const*/ AStr ProductName,
	AVersion ProductVersion,
	/*const*/ AStr CompanyName,
	/*const*/ AStr Copyright,
	/*const*/ AStr Url,
	/*const*/ AStr Description,
	/*const*/ AStr DataPath)
{
	return _Prepare2A(Title, ProgramName, ProgramVersion, ProductName, ProductVersion,
		CompanyName, Copyright, Url, Description, DataPath);
}

AError
afunc ASystem_ProcessMessages()
{
	return _ProcessMessages();
}

AInt
afunc ASystem_ShellExecute(
	/*const*/ AString Operation,
	/*const*/ AString FileName,
	/*const*/ AString Parameters,
	/*const*/ AString Directory)
{
	return _ShellExecute(Operation, FileName, Parameters, Directory);
}

ADialogBoxCommands
afunc ASystem_ShowMessage(/*const*/ AString Msg)
{
	return _ShowMessage(Msg);
}

ADialogBoxCommands
afunc ASystem_ShowMessageA(/*const*/ AStr Msg)
{
	return _ShowMessageA(Msg);
}

