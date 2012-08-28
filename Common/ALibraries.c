/*  Функции для работы с динамическими модулями (библиотеками .dll, .so)
	Author Prof1983 <prof1983@ya.ru>
	Created 20.02.2012
	LastMod 28.08.2012
*/

#include <windows.h>
#include "ALibraries.h"

// --- Types ---

#define APointer void* //typedef void* APointer;

//typedef HMODULE ALibrary;

// ----

/** Close dinamic library
	Закрывает модуль (библиотеку)
	@return(AError value) */
AError
afunc ALibrary_Close(ALibrary Lib)
{
	if (FreeLibrary((HMODULE)Lib)) {
		return 0;
	} else {
		return -1;
	}
}

/** Open dynamic library.
	Открывает модуль (библиотеку). Возвращает идентификатор.
	@return(ALibrary identifier) */
ALibrary
afunc ALibrary_OpenA(AStr FileName, ALibraryFlags Flags)
{
	HMODULE HLib;

	HLib = LoadLibraryA(FileName);
	if ((int)HLib < 32) {
		return 0;
	}
	return (ALibrary)HLib;
}

/** Возвращает адрес функции */
APointer
afunc ALibrary_GetProcAddressA(ALibrary Lib, AStr Name)
{
	return GetProcAddress((HMODULE)Lib, Name);
}

