/*
Abstract(Функции для работы с динамическими модулями (библиотеками .dll, .so))
Author(Prof1983 prof1983@ya.ru)
Created(20.02.2012)
LastMod(20.02.2012)
Version(0.5)
*/

#include "ABase.h"

typedef int ALibrary;
typedef int ALibraryFlags;
#define APointer void* //typedef void* APointer;

// Открывает модуль (библиотеку). Возвращает идентификатор.
ALibrary
AFunction Library_Open(const AAnsiString FileName, ALibraryFlags Flags)
{
	// ...
	return 0;
}

// Закрывает модуль (библиотеку)
ABoolean
AFunction Library_Close(ALibrary Lib)
{
	// ...
	return A_BOOL_TRUE; //false;
}

//function Library_BuildPath(const Directory, LibraryName: APascalString): APascalString; stdcall;

//function Library_GetName(Lib: ALibrary): APascalString; stdcall;

// Возвращает адрес функции
APointer
AFunction Library_GetProcAddress(ALibrary Lib, const AAnsiString Name)
{
	// ...
	return NULL;
}

//function Library_GetSymbol(Lib: ALibrary; const SymbolName: APascalString; var Symbol: Pointer): ABoolean; stdcall;
