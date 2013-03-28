/*
ACore lib client
Author Prof1983 <prof1983@ya.ru>
Created 16.06.2011
LastMod 27.03.2013
*/

#include "ABase2.h"
#include "ACore.h"
#include "ALibraries.h"

ALibrary Lib;

AError
afunc CoreLib_Open(AStr CoreLibName)
{
    Lib = ALibrary_OpenA(CoreLibName, 0);
    if (Lib == NULL)
    {
        return -1;
    }

    ACore_Boot = (ACore_Boot_Proc)ALibrary_GetProcAddressA(Lib, "ACore_Boot");
    ACore_Fin = (ACore_Fin_Proc)ALibrary_GetProcAddressA(Lib, "ACore_Fin");
    ACore_Init = (ACore_Init_Proc)ALibrary_GetProcAddressA(Lib, "ACore_Init");
    ACore_Run = (ACore_Run_Proc)ALibrary_GetProcAddressA(Lib, "ACore_Run");

    return 0;
}

AError
afunc CoreLib_Close()
{
    if (Lib != NULL)
    {
        ALibrary_Close(Lib);
        Lib = NULL;
    }
    return 0;
}
