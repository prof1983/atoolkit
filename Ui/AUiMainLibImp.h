/*  AUi
    Author Prof1983 <prof1983@ya.ru>
    Created 29.08.2012
    LastMod 03.09.2012 */

#ifndef AUiMainLibImp_H
#define AUiMainLibImp_H

#include "ABase.h"
#include "ALibraries.h"

AError
afunc AUiMain_Boot(ALibrary Lib);

// ---

AError
afunc AUi_CreateMainForm();

AMenuItem
afunc AUi_GetMainMenuItem();

ATrayIcon
afunc AUi_GetMainTrayIcon();

AWindow
afunc AUi_GetMainWindow();

AError
afunc AUi_Init();

AInteger
afunc AUi_Run();

AError
afunc AUi_SetHideOnClose(ABoolean Value);

AError
afunc AUi_SetProgramState(AInteger State);

AInteger
afunc AUi_ShellExecute(AString Operation, AString FileName, AString Parameters, AString Directory);

AInteger
afunc AUi_ShellExecuteA(AStr Operation, AStr FileName, AStr Parameters, AStr Directory);

AError
afunc AUi_Shutdown();


#endif
