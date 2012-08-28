/*  ACore
	Author Prof1983 <prof1983@ya.ru>
	Created 19.08.2009
	LastMod 28.08.2012
*/

#ifndef ACore_H
#define ACore_H

#include "ABase2.h"
//#include "ARuntime.h"

// --- Proc types ---

typedef AProc ACore_Boot_Proc;
typedef AProc ACore_Fin_Proc;
typedef AProc ACore_Init_Proc;
typedef AProc ACore_Run_Proc;
//typedef APointer/*ARuntimeProcs*/ __stdcall (*A_Core_Runtime_Proc)();

// --- Vars ---

ACore_Boot_Proc ACore_Boot;
ACore_Fin_Proc ACore_Fin;
ACore_Init_Proc ACore_Init;
ACore_Run_Proc ACore_Run;
//ACore_Runtime_Proc ACore_Runtime;

/*
struct ACoreProcs_Type
{
	ACore_Boot_Proc Boot;
	ACore_Fin_Proc Fin;
	ACore_Init_Proc Init;
	ACore_Run_Proc Run;
	//ACore_Runtime_Proc Runtime;
};

struct ACoreProcs_Type ACore;
*/

// ----

int CoreLib_Open(AStr CoreLibName);

void CoreLib_Close();

#endif ACore_H
