/*
Abstract(Base consts and types)
Author(Prof1983 prof1983@ya.ru)
Created(06.03.2008)
LastMod(23.05.2012)
Version(0.5)
*/

#ifndef ABaseH
#define ABaseH

/* --- Types0 --- */

typedef float AFloat32;
typedef double AFloat64;
typedef int AInt;
typedef __int8 AInt8;
typedef __int16 AInt16;
typedef __int32 AInt32;
typedef __int64 AInt64;
typedef unsigned int AUInt;
typedef unsigned __int8 AUInt8;
typedef unsigned __int16 AUInt16;
typedef unsigned __int32 AUInt32;
typedef unsigned __int64 AUInt64;

/* --- Types1 --- */

typedef int/*BOOL*/ ABoolean;
typedef AFloat64 AFloat;
typedef AInt AInteger;

//const AFalse = 0;
//const ATrue = 1;

/* --- Types2 --- */

// Версия. Имеет формат $AABBCCDD = AA.BB.CC.DD
typedef AUInt32 AVersion;
// Маска для проверки соответсвия версий модулей
#define AVersionMask 0xFFFF0000;
//const AVersion            AVersionMask = 0xFFFF0000;

/*
	Возвращаемое значение функций. Значения:
	<0 - ошибка при выполнении,
	0 - выполнение прошло успешно
	>0 - выполнение прошло успешно, но есть замечания или информация
*/
typedef AInt AError;

typedef AInt AConfig;
typedef AInt AEvent;

/* --- String --- */

/* string define */
typedef char* AAnsiString; //#define PChar char*

typedef struct
{
	AAnsiString Str;
    AInt Len;
} AString_Type;

//#define AString AString_Type*

#endif
