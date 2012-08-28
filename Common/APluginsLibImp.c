/*  APlugins
	Author Prof1983 <prof1983@ya.ru>
	Created 28.08.2012
	LastMod 28.08.2012
*/

#include "ABase"

typedef AError afunc (*APlugins_AddPluginA)(AStr FileName);

typedef AError afunc (*APlugins_Clear)();

typedef AError afunc (*APlugins_Delete)(AInt Index);

typedef AError afunc (*APlugins_Fin)();

typedef AError afunc (*APlugins_FindA)(AStr Path);

typedef AInt afunc (*APlugins_GetCount)();

typedef AError afunc (*APlugins_Init)();
