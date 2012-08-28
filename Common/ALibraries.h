/*  ALibraries
	Author Prof1983 <prof1983@ya.ru>
	Created 05.06.2012
	LastMod 28.08.2012
*/

#ifndef ALibraries_H
#define ALibraries_H

//extern "C" {

#include "ABase2.h"

typedef int ALibrary;
typedef int ALibraryFlags;

/** Close dinamic library
	Закрывает модуль (библиотеку)
	@return(AError value) */
AError
afunc ALibrary_Close(ALibrary Lib);

/** Open dynamic library.
	@return(ALibrary identifier) */
ALibrary
afunc ALibrary_OpenA(const AStr FileName, ALibraryFlags Flags);

/** Возвращает адрес функции */
APointer
afunc ALibrary_GetProcAddressA(ALibrary Lib, AStr Name);

//}

#endif