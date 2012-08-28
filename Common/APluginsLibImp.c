/*  APlugins
	Author Prof1983 <prof1983@ya.ru>
	Created 28.08.2012
	LastMod 28.08.2012 */

#include "ABase"
#include "ALibraries.h"
#include "APluginsLibImp.h"

// --- Types ---

typedef AError afunc (*APlugins_AddPluginA_Proc)(AStr FileName);

typedef AError afunc (*APlugins_Clear_Proc)();

typedef AError afunc (*APlugins_Delete_Proc)(AInt Index);

typedef AError afunc (*APlugins_Fin_Proc)();

typedef AError afunc (*APlugins_FindA_Proc)(AStr Path);

typedef AInt afunc (*APlugins_GetCount_Proc)();

typedef AError afunc (*APlugins_Init_Proc)();

// --- Var ---

APlugins_AddPluginA_Proc _AddPluginA;
APlugins_Clear_Proc _Clear;
APlugins_Delete_Proc _Delete;
APlugins_Fin_Proc _Fin;
APlugins_FindA_Proc _FindA;
APlugins_GetCount_Proc _GetCount;
APlugins_Init_Proc _Init;

// ----

AError
afunc APlugins_Boot(ALibrary Lib)
{
	_AddPluginA = (APlugins_AddPluginA_Proc)ALibrary_GetProcAddressA(Lib, "APlugins_AddPluginA");
	_Clear = (APlugins_Clear_Proc)ALibrary_GetProcAddressA(Lib, "APlugins_Clear");
	_Delete = (APlugins_Delete_Proc)ALibrary_GetProcAddressA(Lib, "APlugins_Delete");
	_Fin = (APlugins_Fin_Proc)ALibrary_GetProcAddressA(Lib, "APlugins_Fin");
	_FindA = (APlugins_FindA_Proc)ALibrary_GetProcAddressA(Lib, "APlugins_FindA");
	_GetCount = (APlugins_GetCount_Proc)ALibrary_GetProcAddressA(Lib, "APlugins_GetCount");
	_Init = (APlugins_Init_Proc)ALibrary_GetProcAddressA(Lib, "APlugins_Init");
	return 0;
}

AError
afunc APlugins_AddPluginA(AStr FileName)
{
	if (_AddPluginA = NULL) return -100;
	return _AddPluginA(FileName);
}

AError
afunc APlugins_Clear()
{
	if (_Clear = NULL) return -100;
	return _Clear();
}

AError
afunc APlugins_Delete(AInt Index)
{
	if (_Delete = NULL) return -100;
	return _Delete(Index);
}

AError
afunc APlugins_Fin()
{
	if (_Fin = NULL) return -100;
	return _Fin();
}

AError
afunc APlugins_FindA(AStr Path)
{
	if (_FindA = NULL) return -100;
	return _FindA(Path);
}

AInt
afunc APlugins_GetCount()
{
	if (_GetCount = NULL) return 0;
	return _GetCount();
}

AError
afunc APlugins_Init()
{
	if (_Init = NULL) return -100;
	return _Init();
}

