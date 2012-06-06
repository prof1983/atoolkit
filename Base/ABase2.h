/*
Abstract(Base types and consts)
Author(Prof1983 prof1983@ya.ru)
Created(06.03.2008)
LastMod(06.06.2012)
Version(0.5)
*/

#ifndef ABase2_H
#define ABase2_H

// For size_t
#include <stddef.h>
#include "ABase.h"

// --- API function define ---
#if defined(A_BUILD_DLL)
#  define func __export
#else
# if defined(A_BUILD_APP)
#  define func __import
# else
#  define func
# endif
#endif

#define AFunction /*__stdcall*/
typedef void* APointer; //#define APointer void *

//{$I A.inc}

typedef size_t ASize;

// --- Proc ---

// TODO: int AFunction -> func
typedef int	AFunction /*__stdcall*/ (*AProc)();
typedef void AFunction /*__stdcall*/ (*ACallbackProc)(AInteger Obj, AInteger Data);

// --- AId ---

/*
	Идентификатор. Глобальный тип для использования во всех модулях.
	Номер 0 может использоваться для хранения глобальных параметров AI системы.
	Номера от 0 до 1023 заререзвированы.
	Номер 1024 используется для хранения настроек AI программы.
	Номера от 1025 до 2047 используются для определения внутренних типов AI программы.
	Номера от 2028 до 65535 зарезервированы.
	Номера от 65535 до 2^31 используются свободно для локального приложения.
	Использование номеров от 2^32 до 2^63 выделяются сервером AI системы.
	Сущности с номерами от 2^32 хранятся на сервере
	(локальные копии могут хранится на локальном компьютере).
	Аналог:
	  ru.narod.profsoft.ai.common.BaseTypes
	  org.framerd.OID.OID
*/
typedef int TAId;

// -------------------------------------------------------------------------------------------------

typedef int ALogFlags;

/*
int L_ICONERROR = 00000010x0;       // MB_ICONHAND, MB_ICONSTOP
const int L_ICONQUESTION = 00000020x0;
const int L_ICONWARNING = 00000030x0;     // ICONEXCLAMATION
const int L_ICONINFORMATION = 00000040x0; // MB_ICONASTERISK
const int L_USERICON = 00000080x0;
*/

//#define A_BOOL_TRUE 0
//#define A_BOOL_FALSE 1

/*
const
  STR_BOOL: array [Boolean] of string = ('False', 'True');
  //** @abstract(Константный массив для преобразования Boolean <-> WideString) (ASettings)
  //STR_BOOL: array[Boolean] of WideString = ('False', 'True');
  STR_BOOL_FIB: array [Boolean] of string = ('''0''', '''1''');

const // Константы приведения типов --------------------------------------------
  STR_BOOL_ENG: array [Boolean] of string = ('false', 'true');
  STR_BOOL_RUS: array [Boolean] of string = ('нет', 'да');
const // Текстовых описания глобальных типов -----------------------------------
  STR_MONTH_2: array [0..12] of string = ('00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12');
  STR_MONTH_RUS: array [0..12] of string =
	('неизвестен', 'январь', 'февраль', 'март', 'апрель', 'май', 'июнь', 'июль',
	 'август', 'сентябрь', 'октябрь', 'ноябрь', 'декабрь');
  STR_MONTH_RUS_H: array [0..12] of string =
	('Неизвестен', 'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль',
	 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь');
  STR_MONTH_ENG: array [0..12] of string =
	('none', 'January', 'February', 'March', 'April', 'May', 'June', 'July',
	 'August', 'September', 'October', 'November', 'December');
  STR_DAYOFWEEK_RUS: array [0..7] of string =
	('неизвестно', 'воскресенье', 'понедельник', 'вторник', 'среда', 'четверг', 'пятница', 'суббота');
  STR_DAYOFWEEK_ENG: array [0..7] of string =
	('none', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
*/

typedef int AMessageBoxFlags;
/*
const int MB_OK = $00000000;
const MB_OKCANCEL = $00000001;
const MB_ABORTRETRYIGNORE = $00000002;
const MB_YESNOCANCEL = $00000003;
const MB_YESNO = $00000004;
const MB_RETRYCANCEL = $00000005;

const MB_ICONERROR = $00000010;       // MB_ICONHAND, MB_ICONSTOP
const MB_ICONQUESTION = $00000020;
const MB_ICONWARNING = $00000030;     // ICONEXCLAMATION
const MB_ICONINFORMATION = $00000040; // MB_ICONASTERISK
const MB_USERICON = $00000080;
*/

/*
enum AMessageBoxFlags {
 MB_OK = 0,
 MB_OKCANCEL = 1,
 MB_ABORTRETRYIGNORE = 2,
 MB_YESNOCANCEL = 3,
 MB_YESNO = 4,
 MB_RETRYCANCEL = 5,
 MB_ICONERROR = $00000010,       // MB_ICONHAND, MB_ICONSTOP
 MB_ICONQUESTION = $00000020,
 MB_ICONWARNING = $00000030,     // ICONEXCLAMATION
 MB_ICONINFORMATION = $00000040, // MB_ICONASTERISK
 MB_USERICON = $00000080 }
*/


typedef int ADialogBoxCommands;
/*
const ID_OK = 1;
const ID_CANCEL = 2;
const ID_ABORT = 3;
const ID_RETRY = 4;
const ID_IGNORE = 5;
const ID_YES = 6;
const ID_NO = 7;
const ID_CLOSE = 8;
const ID_HELP = 9;
const ID_TRYAGAIN = 10;
const ID_CONTINUE = 11;
*/

//typedef ADialogBoxCommands *TAShowMessageProc(const AString Text, const AString Caption, AMessageBoxFlags Flags);

#endif
