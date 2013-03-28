/*
Author Prof1983 <prof1983@ya.ru>
Created 19.08.2009
LastMod 27.03.2013
*/

#ifndef ACore_H
#define ACore_H

#include "ABase2.h"

// --- Proc types ---

typedef AProc ACore_Boot_Proc;
typedef AProc ACore_Fin_Proc;
typedef AProc ACore_Init_Proc;
typedef AProc ACore_Run_Proc;

// --- Vars ---

ACore_Boot_Proc ACore_Boot;
ACore_Fin_Proc ACore_Fin;
ACore_Init_Proc ACore_Init;
ACore_Run_Proc ACore_Run;

// ----

AError
afunc CoreLib_Open(AStr CoreLibName);

AError
afunc CoreLib_Close();

#endif ACore_H
