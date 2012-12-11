/*
Author Prof1983 <prof1983@ya.ru>
Created 17.06.2011
LastMod 10.12.2012
*/

#ifndef ARuntime_H
#define ARuntime_H

#include "ABase2.h"

// --- Types ---------------------------------------------------------------------------------------

// Уникальный идентификатор модуля.
// Записывается в формате $YYMMDDxx, где YY - год, MM-месяц, DD-день, xx-порядковый номер }
typedef AInteger AModuleUid;
typedef char* PAnsiChar;
typedef AInt AModuleDescription;
typedef void* Pointer;

//typedef int AModule;

typedef AError AFunction (*AModuleFinProc)();
typedef AError AFunction (*AModuleInitProc)();
typedef Pointer (*AModuleGetProc)(AStr ProcName);

typedef struct AModule_Type {
    /** Module version ($AABBCCDD) */
    AVersion Version;
    /** Module unique identificator $YYMMDDxx YY - Year, MM - Month, DD - Day */
    AModuleUid Uid;
    /** Module unuque name */
    PAnsiChar Name;
    /** Module information and description */
    AModuleDescription Description;
    /** Initialize proc */
    AModuleInitProc Init;
    /** Finalize proc */
    AModuleFinProc Fin;
    /** Get proc address */
    AModuleGetProc GetProc;
    /** Module proc list */
    Pointer Procs;
};

typedef struct AModule_Type * AModule;

// --- Procs ---------------------------------------------------------------------------------------

// --- Set event functions ---

typedef AError AFunction (*ARuntime_SetOnRun_Proc)(AProc Value);

typedef AError AFunction (*ARuntime_SetOnShutdown_Proc)(AProc Value);

typedef AError AFunction (*ARuntime_SetOnAfterRun_Proc)(AProc Value);

typedef AError AFunction (*ARuntime_SetOnBeforeRun_Proc)(AProc Value);

// --- Module ---

typedef AInteger AFunction (*ARuntime_RegisterModule_Proc)(AModule Module);

// --- Modules ---

typedef AInteger AFunction (*ARuntime_AddModule_Proc)(AModule Module);

typedef AInteger AFunction (*ARuntime_GetModulesCount_Proc)();

typedef AInteger AFunction (*ARuntime_DeleteModuleByName_Proc)(AAnsiString Name);

typedef AInteger AFunction (*ARuntime_DeleteModuleByUid_Proc)(AModuleUid Uid);

typedef AInteger AFunction (*ARuntime_FindModuleByName_Proc)(AAnsiString Name);

typedef AInteger AFunction (*ARuntime_FindModuleByUid_Proc)(AModuleUid Uid);

typedef AInteger AFunction (*ARuntime_GetModuleByName_Proc)(AAnsiString Name, AModule Module);

typedef AInteger AFunction (*ARuntime_GetModuleByUid_Proc)(AModuleUid Uid, AModule Module);

typedef AInteger AFunction (*ARuntime_InitModuleByName_Proc)(AAnsiString Name);

typedef AInteger AFunction (*ARuntime_InitModuleByUid_Proc)(AModuleUid Uid);

typedef AInteger AFunction (*ARuntime_GetModuleNameByIndex_Proc)(AInteger Index, AAnsiString Name, AInteger MaxLen);

typedef APointer AFunction (*ARuntime_GetModuleProcsByUid_Proc)(AModuleUid Uid);

typedef AModuleUid AFunction (*ARuntime_GetModuleUidByIndex_Proc)(AInteger Index);

// --- System ---

typedef ABoolean AFunction (*ARuntime_GetIsShutdown_Proc)();

typedef AError AFunction (*ARuntime_Run_Proc)();

typedef AInteger AFunction (*ARuntime_Shutdown_Proc)();

// --- ARuntimeProcs_Type --------------------------------------------------------------------------

typedef struct ARuntimeProcs_Type
{
	// --- Set event functions ---
	ARuntime_SetOnAfterRun_Proc SetOnAfterRun;
	ARuntime_SetOnBeforeRun_Proc SetOnBeforeRun;
	ARuntime_SetOnRun_Proc SetOnRun;
	AInt Reserved03;

	ARuntime_AddModule_Proc AddModule;
	ARuntime_GetModulesCount_Proc GetModulesCount;
	ARuntime_FindModuleByName_Proc FindModuleByName;
	ARuntime_FindModuleByUid_Proc FindModuleByUid;
	ARuntime_DeleteModuleByName_Proc DeleteModuleByName;
	ARuntime_DeleteModuleByUid_Proc DeleteModuleByUid;
	ARuntime_GetModuleByName_Proc GetModuleByName;
	ARuntime_GetModuleByUid_Proc GetModuleByUid;
	ARuntime_GetModuleNameByIndex_Proc GetModuleNameByIndex;
	ARuntime_GetModuleUidByIndex_Proc GetModuleUidByIndex;
	ARuntime_InitModuleByName_Proc InitModuleByName;
	ARuntime_InitModuleByUid_Proc InitModuleByUid;

	ARuntime_GetIsShutdown_Proc GetIsShutdown;
	ARuntime_Shutdown_Proc Shutdown;
	ARuntime_RegisterModule_Proc RegisterModule;
	ARuntime_GetModuleProcsByUid_Proc GetModuleProcsByUid;
    ARuntime_Run_Proc Run;
    ARuntime_SetOnShutdown_Proc SetOnShutdown;
	AInteger Reserved22;
	AInteger Reserved23;
	AInteger Reserved24;
	AInteger Reserved25;
	AInteger Reserved26;
	AInteger Reserved27;
	AInteger Reserved28;
	AInteger Reserved29;
	AInteger Reserved30;
	AInteger Reserved31;

	AInteger Reserved32;
	AInteger Reserved33;
	AInteger Reserved34;
	AInteger Reserved35;
	AInteger Reserved36;
	AInteger Reserved37;
	AInteger Reserved38;
	AInteger Reserved39;
	AInteger Reserved40;
	AInteger Reserved41;
	AInteger Reserved42;
	AInteger Reserved43;
	AInteger Reserved44;
	AInteger Reserved45;
	AInteger Reserved46;
	AInteger Reserved47;
	AInteger Reserved48;
	AInteger Reserved49;
	AInteger Reserved50;
	AInteger Reserved51;
	AInteger Reserved52;
	AInteger Reserved53;
	AInteger Reserved54;
	AInteger Reserved55;
	AInteger Reserved56;
	AInteger Reserved57;
	AInteger Reserved58;
	AInteger Reserved59;
	AInteger Reserved60;
	AInteger Reserved61;
	AInteger Reserved62;
	AInteger Reserved63;
};

#define ARuntimeProcs struct ARuntimeProcs_Type *
typedef struct ARuntimeProcs_Type * ARuntimeProc1;

#endif ARuntime_H
