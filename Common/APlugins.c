/*
Abstract(APlugins)
Author(Prof1983 prof1983@ya.ru)
Created(06.02.2012)
LastMod(07.02.2012)
Version(0.0.0)
*/

#include "ABase.h"
#include "APlugins.h"
#include "AStrings.h"

#include <ctype.h>
//#include <stdio.h>
//#include <string.h>
//#include <windows.h>
#include <stdio.h>
#include <dir.h>

AError
AFunction Plugins_Find(const AAnsiString Path)
{
	#define MAX_LEN 100
	struct ffblk ffblk;
	int done;
	char s[MAX_LEN];
	/*
	AString_Type S;

	if (String_AssignC(&S, Path) < 0)
	{
		return -2;
	}
	if (String_CatC(&S, "*.*") < 0)
	{
		return -2;
	}
	*/

	//printf("Directory listing of *.*\n");
	if (strcpy_s(s, MAX_LEN, Path) != 0)
	{
		return -2;
	}
	if (strncat_s(s, MAX_LEN, "*.*", MAX_LEN) != 0)
	{
		return -3;
	}
	done = findfirst(s,&ffblk,0);
	while (!done)
	{
		/*
		String
		tolower(
		if (ffblk.ff_name )
		{

		}
		*/
		//printf("  %s\n", ffblk.ff_name);
		done = findnext(&ffblk);
	}
	//FindFile
	//LoadLibrary("");
	return 0;
}

AError
AFunction FindC(char * Path)
{
	return Plugins_Find(Path);
}
