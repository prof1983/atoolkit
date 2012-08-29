/*  Base consts and types
 *  Author Prof1983 <prof1983@ya.ru>
 *  Created 06.03.2008
 *  LastMod 29.08.2012
 */

#ifndef ABaseH
#define ABaseH

#include <stdint.h>

/* --- Types0 --- */

typedef float AFloat32;
typedef double AFloat64;
typedef int AInt;
typedef int8_t AInt8; //typedef __int8 AInt8;
typedef int16_t AInt16; //typedef __int16 AInt16;
typedef int32_t AInt32; //typedef __int32 AInt32;
typedef int64_t AInt64; //typedef __int64 AInt64;
typedef unsigned int AUInt;
typedef uint8_t AUInt8; //typedef unsigned __int8 AUInt8;
typedef uint16_t AUInt16; //typedef unsigned __int16 AUInt16;
typedef uint32_t AUInt32; //typedef unsigned __int32 AUInt32;
typedef uint64_t AUInt64; //typedef unsigned __int64 AUInt64;

/* --- Types1 --- */

typedef char AChar;

typedef int ABoolean;
typedef AFloat64 AFloat;
typedef AInt AInteger;

#define AFalse 0 //const AFalse = 0;
#define ATrue 1 //const ATrue = 1;

/* --- Types2 --- */

/** Version.
 *  Format $AABBCCDD = AA.BB.CC.DD
 *  AA - Major
 *  BB - Minor
 *  CC - Revision/Patch
 *  DD - Build
 */
typedef AUInt32 AVersion;

/** Маска для проверки соответсвия версий модулей */
#define AVersionMask 0xFFFF0000;
//const AVersion            AVersionMask = 0xFFFF0000;

/** Возвращаемое значение функций. Значения:
 *  <0 - ошибка при выполнении,
 *  0 - выполнение прошло успешно
 *  >0 - выполнение прошло успешно, но есть замечания или информация
 */
typedef AInt AError;

typedef AInt AColor;
typedef AInt AConfig;
typedef AInt AEvent;

/* --- String --- */

typedef char* AAnsiString;
typedef char* AStr;
//typedef wchar_t* AStrW;
//#define PChar char*

typedef struct
{
	AStr Str;
	AInt Len;
} AString_Type_2;

typedef struct
{
	//** UTF-8 or Ansi \0-terminated value. Analog GString Points to the string's current \0-terminated value (gchar).
	AStr Str;
	//** Length (count chars). Analog GString Current length (gsize)
	AInt Len;
	//** Allocated size in bytes. Analog GString allocated_len (gsize).
	AInt AllocSize;
	//** Code: 0 - UTF-8; 1 - PAnsiChar
	AInt Code;
} AString_Type_4;

typedef AString_Type_4 AString_Type;

typedef AString_Type* AString;

#endif
