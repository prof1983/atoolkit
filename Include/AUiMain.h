/*
AUiMain functions
Author Prof1983 <prof1983@ya.ru>
Created 29.08.2012
*/

#ifndef AUiMain_H
#define AUiMain_H

#include "AUiBase.h"

AInt
afunc AUi_AddObject(AInt Value);

AError
afunc AUi_CreateMainForm();

AError
afunc AUi_Fin();

ABool
afunc AUi_GetIsShowApp();

AMenuItem
afunc AUi_GetMainMenuItem();

AControl
afunc AUi_GetMainToolBar();

ATrayIcon
afunc AUi_GetMainTrayIcon();

AWindow
afunc AUi_GetMainWindow();

AError
afunc AUi_Init();

AError
afunc AUi_ProcessMessages();

AError
afunc AUi_Run();

AError
afunc AUi_SetAboutMemoDefaultSize(AInt Width, AInt Height);

AError
afunc AUi_SetHideOnClose(ABoolean Value);

AError
afunc AUi_SetIsShowApp(ABool Value);

AError
afunc AUi_SetMainToolBar(AControl ToolBar);

AError
afunc AUi_SetOnAboutClick(AProc Value);

AError
afunc AUi_SetOnMainFormCreate(AProc Value);

AError
afunc AUi_SetProgramState(AUiProgramState State);

AInt
afunc AUi_ShellExecute(AString Operation, AString FileName, AString Parameters, AString Directory);

AInt
afunc AUi_ShellExecuteA(AStr Operation, AStr FileName, AStr Parameters, AStr Directory);

AError
afunc AUi_ShowHelp();

AError
afunc AUi_ShowHelp2(AString FileName);

AError
afunc AUi_Shutdown();

#endif
