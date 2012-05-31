/*
Abstract(AStrings)
Author(Prof1983 prof1983@ya.ru)
Created(07.02.2012)
LastMod(20.02.2012)
Version(0.0.0)
*/

#include <stdlib.h>
#include <string.h>

#include "ABase.h"
#include "AStrings.h"

AError
AFunction String_AssignC(AString S, const AAnsiString Value)
{
	AInteger i;
	AInteger length;
	AChar c;
	void* mem;

	length = strlen(Value);
	mem = calloc(length+1, sizeof(char)); //mem = calloc(length+1, sizeof(wchar_t));
	if (mem == 0)
	{
		return -2;
	};
	(*S).Str = (AAnsiString)mem;
	for (i = 0; i < length+1; i++)
	{
		c = Value[i];
		(*S).Str[i] = c;
	}
	(*S).Len = length;
	return 0;
}

AError
AFunction String_CatC(AString S, const AAnsiString Value)
{
	AInteger Len;
	AInteger Len2;
	AInteger I;
	AChar C;
	void* mem;

	Len = strlen((*S).Str); //Len = wcslen((*S).Str);
	Len2 = strlen(Value);
	mem = (void*)(*S).Str;
	mem = realloc(mem, Len + Len2 + 1);
	if (mem == 0)
	{
		return -2;
	}
	for (I = 0; I < Len2+1; I++)
	{
		C = Value[I];
		(*S).Str[Len+I] = C;
	}
	(*S).Len = Len+Len2;
	//memmove(mem+Len*sizeof(AChar), Value
	// ...
	return 0;
}

AError
AFunction String_Copy(AString S, const AString_Type Str2)
{
	if (strcpy((*S).Str, Str2.Str) == (*S).Str)
	{
		return 0;
	}
	else
		return -1;
}

AError
AFunction String_CopyN(AString S, const AString_Type Str2, ASize Count)
{
	if (strncpy((*S).Str, Str2.Str, Count) == (*S).Str)
	{
		return 0;
	}
	else
		return -1;
}

AInteger
AFunction String_Pos(const AString_Type S, const AString_Type SubStr)
{
	AInteger I;
	I = (AInteger)strstr(S.Str, SubStr.Str);
	if (I == 0)
	{
		return -1;
	}
	return (I - (AInteger)(&S));
}

AInteger
AFunction String_PosC(const AString_Type S, const AAnsiString SubStr)
{
	AInteger I;
	I = (AInteger)strstr(S.Str, SubStr);
	if (I == 0)
	{
		return 0;
	}
	return (I - (AInteger)(&S));
}

AError
AFunction String_ToLower(AString S)
{
	AInteger I;
	AInteger length;

	length = strlen((*S).Str); //length = wcslen((*S).Str);
	if ((*S).Len != length)
	{
		return - 2;
	}
	for (I = 0; I < length; I++)
	{
		(*S).Str[I] = towlower((*S).Str[I]);
	}
	return 0;
}

// -------------------------------------------------------------------------------------------------

/*
typedef AError AFunction (*A_String_ToLower_Proc)(AString S);

struct AStrings
{
	//A_String_AssignC_Proc String_AssignC;
	//A_String_CatC_Proc String_CatC;
	//A_String_Pos_Proc String_Pos;
	//A_String_PosC_Proc String_PosC;
	A_String_ToLower_Proc String_ToLower;
};
*/
