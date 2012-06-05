/*
Abstract(Функции для работы с динамическими модулями (библиотеками .dll, .so))
Author(Prof1983 prof1983@ya.ru)
Created(20.02.2012)
LastMod(05.06.2012)
Version(0.5)
*/

#include <windows.h>
#include "ALibraries.h"

#define APointer void* //typedef void* APointer;

/** Close dinamic library
	Закрывает модуль (библиотеку)
	@return(AError value) */
func ALibrary_Close(ALibrary Lib)
{
	FreeLibrary((HMODULE)Lib);
	return 0;
}

/** Open dynamic library.
	Открывает модуль (библиотеку). Возвращает идентификатор.
	@return(ALibrary identifier) */
func ALibrary_Open(const AAnsiString FileName, ALibraryFlags Flags)
{
	HMODULE HLib;

	HLib = LoadLibrary(FileName);
	if ((int)HLib < 32) {
		return 0;
	}
	return (ALibrary)HLib;
}

//function Library_BuildPath(const Directory, LibraryName: APascalString): APascalString; stdcall;

//function Library_GetName(Lib: ALibrary): APascalString; stdcall;

// Возвращает адрес функции
APointer
AFunction ALibrary_GetProcAddress(ALibrary Lib, const AAnsiString Name)
{
	// ...
	return NULL;
}

//function Library_GetSymbol(Lib: ALibrary; const SymbolName: APascalString; var Symbol: Pointer): ABoolean; stdcall;
