/* ALibraries
Author(Prof1983 prof1983@yandex.ru)
Created(05.06.2012)
LastMod(05.06.2012)
Version(0.5)
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
func ALibrary_Close(ALibrary Lib);

/** Open dynamic library.
	@return(ALibrary identifier) */
func ALibrary_Open(const AAnsiString FileName, ALibraryFlags Flags);

//}

#endif