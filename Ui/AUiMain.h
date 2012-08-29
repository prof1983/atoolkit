/*  AUiMain functions
    Author Prof1983 <prof1983@ya.ru>
    Created 29.08.2012
    LastMod 29.08.2012 */

#ifndef AUiMain_H
#define AUiMain_H

#include "AUiBase.h"

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

AInt
afunc AUi_Run();

AError
afunc AUi_SetHideOnClose(ABoolean Value);

AError
afunc AUi_SetProgramState(AInt State);

AInt
afunc AUi_ShellExecute(AString Operation, AString FileName, AString Parameters, AString Directory);

AInt
afunc AUi_ShellExecuteA(AStr Operation, AStr FileName, AStr Parameters, AStr Directory);

AError
afunc AUi_Shutdown();

#endif