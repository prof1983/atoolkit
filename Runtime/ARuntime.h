/*
Author(Prof1983 prof1983@ya.ru)
Created(17.06.2011)
LastMod(17.06.2011)
Version(0.5)
*/

#ifndef ARuntime_H
#define ARuntime_H

#include "ABase.h"

// --- Types ---------------------------------------------------------------------------------------

// Уникальный идентификатор модуля.
// Записывается в формате $YYMMDDxx, где YY - год, MM-месяц, DD-день, xx-порядковый номер }
typedef AInteger AModuleUid;

typedef int AModule;
/*
type // Module (8x4)
  AModule = ^AModule_Type;
  AModule_Type = packed record
	Version: AVersion;         // Module version ($AABBCCDD). AA=00h, BB=03h.
	Uid: AModuleUid;           // Module unique identificator $YYMMDDxx YY - Year, MM - Month, DD - Day
	Name: PChar;               // Module unuque name
	Description: AModuleDescription; // Module information and description
	Init: AModuleInitProc;     // Init proc
	Done: AModuleDoneProc;     // Done proc
	Reserved06: AInteger;      //Delete: AModuleDeleteProc;
	Procs: Pointer;
  end;
*/

// --- Procs ---------------------------------------------------------------------------------------

// --- Set event functions ---

// A_Runtime_OnRun_Set_Proc = procedure(Value: ARuntimeProc); stdcall;
typedef AProc (*A_Runtime_OnRun_Set_Proc)(AProc Value);

// A_Runtime_OnShutdown_Set_Proc = procedure(Value: ARuntimeProc); stdcall;
typedef AProc (*A_Runtime_OnShutdown_Set_Proc)(AProc Value);

// A_Runtime_OnAfterRun_Set_Proc = procedure(Value: ARuntimeProc); stdcall;
typedef AProc (*A_Runtime_OnAfterRun_Set_Proc)(AProc Value);

// A_Runtime_OnBeforeRun_Set_Proc = procedure(Value: ARuntimeProc); stdcall;
typedef AProc (*A_Runtime_OnBeforeRun_Set_Proc)(AProc Value);

// --- Module ---

// A_Runtime_Module_Register_Proc = function(Module: AModule): AInteger; stdcall;
typedef AInteger AFunction (*A_Runtime_Module_Register_Proc)(AModule Module);

// --- Modules ---

// A_Runtime_Modules_AddModule_Proc = function(Module: AModule): AInteger; stdcall;
typedef AInteger AFunction (*A_Runtime_Modules_AddModule_Proc)(AModule Module);

// A_Runtime_Modules_Count_Proc = function: AInteger; stdcall;
typedef AInteger AFunction (*A_Runtime_Modules_Count_Proc)();

// A_Runtime_Modules_DeleteByName_Proc = function(Name: PChar): AInteger; stdcall;
typedef AInteger AFunction (*A_Runtime_Modules_DeleteByName_Proc)(AAnsiString Name);

// A_Runtime_Modules_DeleteByUid_Proc = function(Uid: AModuleUid): AInteger; stdcall;
typedef AInteger AFunction (*A_Runtime_Modules_DeleteByUid_Proc)(AModuleUid Uid);

// A_Runtime_Modules_FindByName_Proc = function(Name: PChar): AInteger; stdcall;
typedef AInteger AFunction (*A_Runtime_Modules_FindByName_Proc)(AAnsiString Name);

// A_Runtime_Modules_FindByUid_Proc = function(Uid: AModuleUid): AInteger; stdcall;
typedef AInteger AFunction (*A_Runtime_Modules_FindByUid_Proc)(AModuleUid Uid);

// A_Runtime_Modules_GetByName_Proc = function(Name: PChar; Module: AModule): AInteger; stdcall;
typedef AInteger AFunction (*A_Runtime_Modules_GetByName_Proc)(AAnsiString Name, AModule Module);

// Возвращает индекс модуля в массиве или -1 если не найден.
// A_Runtime_Modules_GetByUid_Proc = function(Uid: AModuleUid; Module: AModule): AInteger; stdcall;
typedef AInteger AFunction (*A_Runtime_Modules_GetByUid_Proc)(AModuleUid Uid, AModule Module);

// Инициализирует модуль по имени. Возврашает:
// 0 - инициализация прошла успешно, >0 - имеются замечания, <0 - произошла ошибка при инициализации
// A_Runtime_Modules_InitByName_Proc = function(Name: PChar): AInteger; stdcall;
typedef AInteger AFunction (*A_Runtime_Modules_InitByName_Proc)(AAnsiString Name);

// Инициализирует модуль по уникальному идентификатору. Возврашает:
// 0 - инициализация прошла успешно, >0 - имеются замечания, <0 - произошла ошибка при инициализации
// A_Runtime_Modules_InitByUid_Proc = function(Uid: AModuleUid): AInteger; stdcall;
typedef AInteger AFunction (*A_Runtime_Modules_InitByUid_Proc)(AModuleUid Uid);

// A_Runtime_Modules_GetNameByIndex_Proc = function(Index: AInteger; Name: PChar; MaxLen: AInteger): AInteger; stdcall;
typedef AInteger AFunction (*A_Runtime_Modules_GetNameByIndex_Proc)(AInteger Index, AAnsiString Name, AInteger MaxLen);

// A_Runtime_Modules_GetProcsByUid_Proc = function(Uid: AModuleUid): Pointer; stdcall;
typedef APointer AFunction (*A_Runtime_Modules_GetProcsByUid_Proc)(AModuleUid Uid);

// A_Runtime_Modules_GetUidByIndex_Proc = function(Index: AInteger): AModuleUid; stdcall;
typedef AModuleUid AFunction (*A_Runtime_Modules_GetUidByIndex_Proc)(AInteger Index);

// --- System ---

// A_Runtime_IsShutdown_Proc = function: ABoolean; stdcall;
typedef ABoolean AFunction (*A_Runtime_IsShutdown_Proc)();

// A_Runtime_Shutdown_Proc = function: AInteger; stdcall;
typedef AInteger AFunction (*A_Runtime_Shutdown_Proc)();

// --- ARuntimeProcs_Type --------------------------------------------------------------------------

struct ARuntimeProcs_Type
{
	// --- Set event functions ---
	A_Runtime_OnAfterRun_Set_Proc       OnAfterRun_Set;
	A_Runtime_OnBeforeRun_Set_Proc      OnBeforeRun_Set;
	A_Runtime_OnRun_Set_Proc            OnRun_Set;
	A_Runtime_OnShutdown_Set_Proc       OnShutdown_Set;

	A_Runtime_Modules_AddModule_Proc    Modules_AddModule;
	A_Runtime_Modules_Count_Proc        Modules_Count;
	A_Runtime_Modules_FindByName_Proc   Modules_FindByName;
	A_Runtime_Modules_FindByUid_Proc    Modules_FindByUid;
	A_Runtime_Modules_DeleteByName_Proc Modules_DeleteByName;
	A_Runtime_Modules_DeleteByUid_Proc  Modules_DeleteByUid;
	A_Runtime_Modules_GetByName_Proc    Modules_GetByName;
	A_Runtime_Modules_GetByUid_Proc     Modules_GetByUid;
	A_Runtime_Modules_GetNameByIndex_Proc Modules_GetNameByIndex;
	A_Runtime_Modules_GetUidByIndex_Proc  Modules_GetUidByIndex;
	A_Runtime_Modules_InitByName_Proc   Modules_InitByName;
	A_Runtime_Modules_InitByUid_Proc    Modules_InitByUid;

	A_Runtime_IsShutdown_Proc           IsShutdown;
	A_Runtime_Shutdown_Proc             Shutdown;
	A_Runtime_Module_Register_Proc      Module_Register;
	A_Runtime_Modules_GetProcsByUid_Proc Modules_GetProcsByUid;
	AInteger                            Reserved20;
	AInteger                            Reserved21;
	AInteger                            Reserved22;
	AInteger                            Reserved23;
	AInteger                            Reserved24;
	AInteger                            Reserved25;
	AInteger                            Reserved26;
	AInteger                            Reserved27;
	AInteger                            Reserved28;
	AInteger                            Reserved29;
	AInteger                            Reserved30;
	AInteger                            Reserved31;

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
