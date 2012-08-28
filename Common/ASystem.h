/*  ASystem
	Author Prof1983 <prof1983@ya.ru>
	Created 17.06.2011
	LastMod 28.08.2012
*/

#ifndef ASystem_H
#define ASystem_H

#include "ABase2.h"

#define ASystem_Uid 0x11051501

// --- Types ---

typedef AInteger AConfig;

// --- Proc types ---

// --- My.Application.Info functions ---

// A_Application_DataPath_Proc = function(out Value: AString_Type): AInteger; stdcall;
//typedef AInteger AFunction (*A_Application_DataPath_Proc)(/*out*/ AString Value);

// A_Application_DirectoryPath_Proc = function(out Value: AString_Type): AInteger; stdcall;
//typedef AInteger AFunction (*A_Application_DirectoryPath_Proc)(/*out*/ AString Value);

// A_Application_ExeName_Proc = function(out Value: AString_Type): AInteger; stdcall;
//typedef AInteger AFunction (*A_Application_ExeName_Proc)(/*out*/ AString Value);

// A_Application_Info_CompanyName_Proc = function(out Value: AString_Type): AInteger; stdcall;
//typedef AInteger AFunction (*A_Application_Info_CompanyName_Proc)(/*out*/ AString Value);

// A_Application_Info_Copyright_Proc = function(out Value: AString_Type): AInteger; stdcall;
//typedef AInteger AFunction (*A_Application_Info_Copyright_Proc)(/*out*/ AString Value);

// A_Application_Info_Description_Proc = function(out Value: AString_Type): AInteger; stdcall;
//typedef AInteger AFunction (*A_Application_Info_Description_Proc)(/*out*/ AString Value);

// A_Application_Info_Name_Proc = function(out Value: AString_Type): AInteger; stdcall;
//typedef AInteger AFunction (*A_Application_Info_Name_Proc)(/*out*/ AString Value);

// A_Application_Info_ProductName_Proc = function(out Value: AString_Type): AInteger; stdcall;
//typedef AInteger AFunction (*A_Application_Info_ProductName_Proc)(/*out*/ AString Value);

// A_Application_Info_ProductVersion_Proc = function: AVersion; stdcall;
//typedef AVersion AFunction (*A_Application_Info_ProductVersion_Proc)();

// A_Application_Info_Version_Proc = function: AVersion; stdcall;
//typedef AVersion AFunction (*A_Application_Info_Version_Proc)();

// A_Application_Info_Title_Proc = function(out Value: AString_Type): AInteger; stdcall;
//typedef AInteger AFunction (*A_Application_Info_Title_Proc)(/*out*/ AString Value);

// A_Application_Info_Url_Proc = function(out Value: AString_Type): AInteger; stdcall;
//typedef AInteger AFunction (*A_Application_Info_Url_Proc)(/*out*/ AString Value);

// ---

typedef AConfig
afunc (*ASystem_GetConfig_Proc)();

typedef AInt
afunc (*ASystem_GetResourceString_Proc)(
	AString Section,            // const
	AString Name,               // const
	AString Default,            // const
	AString Value);             // out

typedef AError
afunc (*ASystem_Init_Proc)();

typedef AInt
afunc (*ASystem_ParamStr_Proc)(AInt Index, /*out*/ AString Value);

typedef AError
afunc (*ASystem_Prepare_Proc)();

typedef AError
afunc (*ASystem_Prepare2_Proc)(
	/*const*/ AString Title,
	/*const*/ AString ProgramName,
	AVersion ProgramVersion,
	/*const*/ AString ProductName,
	AVersion ProductVersion,
	/*const*/ AString CompanyName,
	/*const*/ AString Copyright,
	/*const*/ AString Url,
	/*const*/ AString Description,
	/*const*/ AString DataPath);

typedef AError
afunc (*ASystem_Prepare2A_Proc)(
	/*const*/ AStr Title,
	/*const*/ AStr ProgramName,
	AVersion ProgramVersion,
	/*const*/ AStr ProductName,
	AVersion ProductVersion,
	/*const*/ AStr CompanyName,
	/*const*/ AStr Copyright,
	/*const*/ AStr Url,
	/*const*/ AStr Description,
	/*const*/ AStr DataPath);

typedef AError
afunc (*ASystem_ProcessMessages_Proc)();

//typedef void AFunction (*A_System_SetConfig_Proc)(AConfig Value);

typedef AInt
afunc (*ASystem_ShellExecute_Proc)(
	/*const*/ AString Operation,
	/*const*/ AString FileName,
	/*const*/ AString Parameters,
	/*const*/ AString Directory);

//typedef void AFunction (*A_System_ShowError_Proc)(
//	/*const*/ AString UserMessage,
//	/*const*/ AString ExceptMessage);

typedef ADialogBoxCommands
afunc (*ASystem_ShowMessage_Proc)(/*const*/ AString Msg);

typedef ADialogBoxCommands
afunc (*ASystem_ShowMessageA_Proc)(/*const*/ AStr Msg);

typedef ADialogBoxCommands
afunc (*ASystem_ShowMessageEx_Proc)(
	/*const*/ AString Text,
	/*const*/ AString Caption,
	AMessageBoxFlags Flags);

// A_System_Shutdown_Proc = procedure; stdcall;

// --- Set event functions ---

// A_Runtime_SetOnProcessMessages_Proc = procedure(Value: AProc); stdcall;
//typedef void AFunction (*A_System_SetOnProcessMessages_Proc)(AProc Value);

// A_Runtime_SetOnShowError_Proc = procedure(Value: TAShowErrorProc); stdcall;
//typedef void AFunction (*A_System_SetOnShowError_Proc)(TAShowErrorProc Value);

// A_Runtime_SetOnShowMessage_Proc = procedure(Value: TAShowMessageProc); stdcall;
//typedef void AFunction (*A_System_SetOnShowMessage_Proc)(TAShowMessageProc Value);

// --- Events and tools ---

// A_Runtime_OnAfterRun_Proc = function: AEvent; stdcall;
//typedef AEvent AFunction (*A_System_OnAfterRun_Proc)();

// A_Runtime_OnBeforeRun_Proc = function: AEvent; stdcall;
//typedef AEvent AFunction (*A_System_OnBeforeRun_Proc)();

// A_Runtime_OnAfterRunConnect_Proc = function(Callback: ACallbackProc; Weight: AInteger = High(AInteger)): Integer; stdcall;
//typedef AInteger AFunction (*A_System_OnAfterRunConnect_Proc)(
//	ACallbackProc Callback,
//	AInteger Weight); // = High(AInteger)

// A_Runtime_OnAfterRunDisconnect_Proc = function(Callback: ACallbackProc): AInteger; stdcall;
//typedef AInteger AFunction (*A_System_OnAfterRunDisconnect_Proc)(ACallbackProc Callback);

// A_Runtime_OnBeforeRunConnect_Proc = function(Callback: ACallbackProc; Weight: AInteger = High(AInteger)): AInteger; stdcall;
//typedef AInteger AFunction (*A_System_OnBeforeRunConnect_Proc)(
//	ACallbackProc Callback,
//	AInteger Weight); // = High(AInteger)

// A_Runtime_OnBeforeRunDisconnect_Proc = function(Callback: ACallbackProc): AInteger; stdcall;
//typedef AInteger AFunction (*A_System_OnBeforeRunDisconnect_Proc)(ACallbackProc Callback);

// ----

AError
afunc ASystem_Fin();

AConfig
afunc ASystem_GetConfig();

AError
afunc ASystem_Init();

AInt
afunc ASystem_ParamStr(AInt Index, /*out*/ AString Value);

AError
afunc ASystem_Prepare();

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
	/*const*/ AString DataPath);

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
	/*const*/ AStr DataPath);

AError
afunc ASystem_ProcessMessages();

AInt
afunc ASystem_ShellExecute(
	/*const*/ AString Operation,
	/*const*/ AString FileName,
	/*const*/ AString Parameters,
	/*const*/ AString Directory);

ADialogBoxCommands
afunc ASystem_ShowMessage(/*const*/ AString Msg);

ADialogBoxCommands
afunc ASystem_ShowMessageA(/*const*/ AStr Msg);

#endif ASystem_H