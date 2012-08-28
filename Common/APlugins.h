/*  APlugins
	Author Prof1983 <prof1983@ya.ru>
	Created 06.02.2012
	LastMod 28.08.2012
*/

#include "ABase2.h"

//typedef TCheckPluginProc function(Lib: ALibrary): ABoolean; stdcall;

// ----

AError
afunc APlugins_AddPluginA(AStr FileName);

AError
afunc APlugins_Clear();

AError
afunc APlugins_Delete(AInt Index);

AError
afunc APlugins_Fin();

AError
afunc APlugins_FindA(AStr Path);

//AError
//afunc APlugins_Find(const AStr Path);

AInt
afunc APlugins_GetCount();

AError
afunc APlugins_Init();

//AError
//afunc APlugins_SetOnCheckPlugin(TCheckPluginProc CheckPluginProc);


//AError
//func FindC(const AStr Path);
