/*  AUiMain functions
    Author Prof1983 <prof1983@ya.ru>
    Created 29.08.2012
    LastMod 29.08.2012 */

#include "AUiMain.h"
#include "AUiMainLibImp.h"

// --- AUi ---

typedef AError
afunc (*AUi_CreateMainForm_Proc)();

typedef AMenuItem
afunc (*AUi_GetMainMenuItem_Proc)();

typedef ATrayIcon
afunc (*AUi_GetMainTrayIcon_Proc)();

typedef AWindow
afunc (*AUi_GetMainWindow_Proc)();

typedef AError
afunc (*AUi_Init_Proc)();

typedef AInt
afunc (*AUi_Run_Proc)();

typedef AError
afunc (*AUi_SetHideOnClose_Proc)(ABoolean Value);

typedef AError
afunc (*AUi_SetProgramState_Proc)(AInt State);

typedef AInt
afunc (*AUi_ShellExecute_Proc)(AString Operation, AString FileName, AString Parameters, AString Directory);

typedef AInt
afunc (*AUi_ShellExecuteA_Proc)(AStr Operation, AStr FileName, AStr Parameters, AStr Directory);

typedef AError
afunc (*AUi_Shutdown_Proc)();

// ----

AUi_CreateMainForm_Proc _AUi_CreateMainForm;
AUi_GetMainMenuItem_Proc _AUi_GetMainMenuItem;
AUi_GetMainTrayIcon_Proc _AUi_GetMainTrayIcon;
AUi_GetMainWindow_Proc _AUi_GetMainWindow;
AUi_Init_Proc _AUi_Init;
AUi_Run_Proc _AUi_Run;
AUi_SetHideOnClose_Proc _AUi_SetHideOnClose;
AUi_SetProgramState_Proc _AUi_SetProgramState;
AUi_ShellExecute_Proc _AUi_ShellExecute;
AUi_ShellExecuteA_Proc _AUi_ShellExecuteA;
AUi_Shutdown_Proc _AUi_Shutdown;

// ----

AError
afunc AUi_CreateMainForm()
{
    if (_AUi_CreateMainForm = NULL)
        return -100;
    return _AUi_CreateMainForm();
}

AMenuItem
afunc AUi_GetMainMenuItem()
{
    if (_AUi_GetMainMenuItem = NULL)
        return 0;
    return _AUi_GetMainMenuItem();
}

ATrayIcon
afunc AUi_GetMainTrayIcon()
{
    if (_AUi_GetMainTrayIcon = NULL)
        return 0;
    return _AUi_GetMainTrayIcon();
}

AWindow
afunc AUi_GetMainWindow()
{
    if (_AUi_GetMainWindow = NULL)
        return 0;
    return _AUi_GetMainWindow();
}

AError
afunc AUi_Init()
{
    if (_AUi_Init = NULL)
        return -100;
    return _AUi_Init();
}

AInt
afunc AUi_Run()
{
    if (_AUi_Run = NULL)
        return -100;
    return _AUi_Run();
}

AError
afunc AUi_SetHideOnClose(ABoolean Value)
{
    if (_AUi_SetHideOnClose = NULL)
        return -100;
    return _AUi_SetHideOnClose(Value);
}

AError
afunc AUi_SetProgramState(AInt State)
{
    if (_AUi_SetProgramState = NULL)
        return -100;
    return _AUi_SetProgramState(State);
}

AInt
afunc AUi_ShellExecute(AString Operation, AString FileName, AString Parameters, AString Directory)
{
    if (_AUi_ShellExecute = NULL)
        return -100;
    return _AUi_ShellExecute(Operation, FileName, Parameters, Directory);
}

AInt
afunc AUi_ShellExecuteA(AStr Operation, AStr FileName, AStr Parameters, AStr Directory)
{
    if (_AUi_ShellExecuteA = NULL)
        return -100;
    return _AUi_ShellExecuteA(Operation, FileName, Parameters, Directory);
}

AError
afunc AUi_Shutdown()
{
    if (_AUi_Shutdown = NULL)
        return -100;
    return _AUi_Shutdown();
}

// ----

AError
afunc AUiMain_Boot(ALibrary Lib)
{
    _AUi_CreateMainForm = (AUi_CreateMainForm_Proc)ALibrary_GetProcAddressA(Lib, "AUi_CreateMainForm");
    _AUi_GetMainMenuItem = (AUi_GetMainMenuItem_Proc)ALibrary_GetProcAddressA(Lib, "AUi_GetMainMenuItem");
    _AUi_GetMainTrayIcon = (AUi_GetMainTrayIcon_Proc)ALibrary_GetProcAddressA(Lib, "AUi_GetMainTrayIcon");
    _AUi_GetMainWindow = (AUi_GetMainWindow_Proc)ALibrary_GetProcAddressA(Lib, "AUi_GetMainWindow");
    _AUi_Init = (AUi_Init_Proc)ALibrary_GetProcAddressA(Lib, "AUi_Init");
    _AUi_Run = (AUi_Run_Proc)ALibrary_GetProcAddressA(Lib, "AUi_Run");
    _AUi_SetHideOnClose = (AUi_SetHideOnClose_Proc)ALibrary_GetProcAddressA(Lib, "AUi_SetHideOnClose");
    _AUi_SetProgramState = (AUi_SetProgramState_Proc)ALibrary_GetProcAddressA(Lib, "AUi_SetProgramState");
    _AUi_ShellExecute = (AUi_ShellExecute_Proc)ALibrary_GetProcAddressA(Lib, "AUi_ShellExecute");
    _AUi_ShellExecuteA = (AUi_ShellExecuteA_Proc)ALibrary_GetProcAddressA(Lib, "AUi_ShellExecuteA");
    _AUi_Shutdown = (AUi_Shutdown_Proc)ALibrary_GetProcAddressA(Lib, "AUi_Shutdown");
    return 0;
}