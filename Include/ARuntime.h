/*
Author Prof1983 <prof1983@ya.ru>
Created 17.06.2011
*/

#ifndef ARuntimeH
#define ARuntimeH

#include "ABase.h"
#include "ABase2.h"
#include "ARuntimeBase.h"

// --- ARuntime ---

AInt
afunc ARuntime_AddModule(AModule Module);

AInt
afunc ARuntime_DeleteModuleByIndex(AInt Index);


AInt
afunc ARuntime_DeleteModuleByName(AStr Name);

AInt
afunc ARuntime_DeleteModuleByUid(AModuleUid Uid);

AError
afunc ARuntime_Fin();

AInt
afunc ARuntime_FindModuleByName(AStr Name);

AInt
afunc ARuntime_FindModuleByUid(AModuleUid Uid);

ABool
afunc ARuntime_GetIsShutdown();

// Module - out
AInt
afunc ARuntime_GetModuleByName(AStr Name, AModule Module);

// Module - out
AInt
afunc ARuntime_GetModuleByUid(AModuleUid Uid, AModule Module);

AInt
afunc ARuntime_GetModuleNameByIndex(AInt Index, AStr Name, AInt MaxLen);

AInt
afunc ARuntime_GetModuleNameByUid(AInt Uid, AStr Name, AInt MaxLen);

AModuleUid
afunc ARuntime_GetModuleUidByIndex(AInt Index);

APointer
afunc ARuntime_GetModuleProcsByUid(AModuleUid Uid);

AInt
afunc ARuntime_GetModulesCount();

AProc
afunc ARuntime_GetOnAfterRun();

AProc
afunc ARuntime_GetOnBeforeRun();

APointer
afunc ARuntime_GetProcByName(AStr ModuleName, AStr ProcName);

AError
afunc ARuntime_Init();

AInt
afunc ARuntime_InitModuleByName(AStr Name);

AInt
afunc ARuntime_InitModuleByUid(AModuleUid Uid);

AInt
afunc ARuntime_RegisterModule(AModule Module);

AError
afunc ARuntime_Run();

AError
afunc ARuntime_SetOnAfterRun(AProc Value);

AError
afunc ARuntime_SetOnBeforeRun(AProc Value);

AError
afunc ARuntime_SetOnRun(AProc Value);

AError
afunc ARuntime_SetOnShutdown(AProc Value);

AError
afunc ARuntime_Shutdown();

#endif
