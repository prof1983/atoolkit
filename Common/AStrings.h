/*
Abstract(AStrings)
Author(Prof1983 prof1983@ya.ru)
Created(07.02.2012)
LastMod(07.02.2012)
Version(0.0.0)
*/

#ifndef AStrings_H
#define AStrings_H

#include "ABase.h"

AError
AFunction String_AssignC(AString S, const AAnsiString Value);

AError
AFunction String_CatC(AString S, const AAnsiString Value);

/* Копирует содержимое строки Str2 в строку S. Параметр Str2 должен указывать на строку с завершающим нулевым символом. */
AError
AFunction String_Copy(AString S, const AString_Type Str2);

AError
AFunction String_CopyN(AString S, const AString_Type Str2, ASize Count);

/* Возвращает указатель на первое вхождение подстроки, адресуемой параметром SubStr, в строку,
   адресуемую параметром S. Если совпадение не обнаружено, возвращается нулевой указатель. */
AInteger
AFunction String_Pos(const AString_Type S, const AString_Type SubStr);
//AFunction String_Pos(AString S, AString SubStr);

/* Возвращает указатель на первое вхождение подстроки, адресуемой параметром SubStr, в строку,
   адресуемую параметром S. Если совпадение не обнаружено, возвращается нулевой указатель. */
AInteger
AFunction String_PosC(const AString_Type S, const AAnsiString SubStr);
//AFunction String_PosC(AString S, const AAnsiString SubStr);

AError
AFunction String_ToLower(AString S);

#endif AStrings_H
