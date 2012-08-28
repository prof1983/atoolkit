/*  ACore lib client
	Author Prof1983 <prof1983@ya.ru>
	Created 16.06.2011
	LastMod 28.08.2012
*/

#include "ACore.h"
#include "ALibraries.h"

ALibrary Lib;

int CoreLib_Open(AStr CoreLibName)
{
	Lib = ALibrary_OpenA(CoreLibName, 0);
	if (Lib == NULL)
	{
		// тут обрабатываем ошибку, если библиотека не загрузилась
		//ShowMessage("Plugin1.dll не загружен.");
		return -1;
	}

	ACore_Boot = (ACore_Boot_Proc)ALibrary_GetProcAddressA(Lib, "Core_Boot");
	ACore_Fin = (ACore_Fin_Proc)ALibrary_GetProcAddressA(Lib, "Core_Fin");
	ACore_Init = (ACore_Init_Proc)ALibrary_GetProcAddressA(Lib, "Core_Init");
	ACore_Run = (ACore_Run_Proc)ALibrary_GetProcAddressA(Lib, "Core_Run");
	//ACore.Runtime = (ACore_Runtime_Proc)GetProcAddress(Lib, "Core_Runtime");
	/*
	Core_Boot = GetProcAddress(Lib, "Core_Boot");
	Core_Init = GetProcAddress(Lib, "Core_Init");
	Core_Run = GetProcAddress(Lib, "Core_Run");
	Core_Done = GetProcAddress(Lib, "Core_Done");
	Core_Runtime = GetProcAddress(Lib, "Core_Runtime");
	*/

	return 0;
}

void CoreLib_Close()
{
	if (Lib != NULL)
	{
		ALibrary_Close(Lib);
		Lib = NULL;
	}
}
