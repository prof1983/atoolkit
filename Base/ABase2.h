/* Base types and consts
 * Author Prof1983 <prof1983@ya.ru>
 * Created 06.03.2008
 * LastMod 04.03.2013
 */

#define AExport __declspec(dllexport) /* __export */
#define AImport __declspec(dllimport) /* __import */

// --- API function define ---
#if defined(A_BUILD_DLL)
#  define afunc AExport __stdcall
#else
# if defined(A_BUILD_APP)
#  define afunc AImport __stdcall
# else
#  define afunc __stdcall
# endif // A_BUILD_APP
#endif // A_BUILD_DLL


#ifndef ABase2_H
#define ABase2_H

// For size_t
#include <stddef.h>
#include "ABase.h"

#define AFunction __stdcall

typedef void* APointer; //#define APointer void*

typedef size_t ASize;

// --- Proc ---

// TODO: int AFunction -> func
typedef AInt AFunction (*AProc)();
typedef AError AFunction (*ACallbackProc)(AInt Obj, AInt Data);

// --- AId ---

/** Идентификатор. Глобальный тип для использования во всех модулях.
 *  Номер 0 может использоваться для хранения глобальных параметров AI системы.
 *  Номера от 0 до 1023 заререзвированы.
 *  Номер 1024 используется для хранения настроек AI программы.
 *  Номера от 1025 до 2047 используются для определения внутренних типов AI программы.
 *  Номера от 2028 до 65535 зарезервированы.
 *  Номера от 65535 до 2^31 используются свободно для локального приложения.
 *  Использование номеров от 2^32 до 2^63 выделяются сервером AI системы.
 *  Сущности с номерами от 2^32 хранятся на сервере
 *  (локальные копии могут хранится на локальном компьютере).
 *  Аналоги:
 *    org.framerd.OID.OID
*/
typedef int AId;

// -------------------------------------------------------------------------------------------------

//#define A_BOOL_TRUE 0
//#define A_BOOL_FALSE 1

/*
const
  STR_BOOL: array [Boolean] of string = ('False', 'True');
  // @abstract(Константный массив для преобразования Boolean <-> WideString) (ASettings)
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

// -------------------------------------------------------------------------------------------------

typedef int ADialogBoxCommands;
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

typedef AInt ALogType;
const ALogType_Error = 0x00000010;
const ALogType_Question = 0x00000020;
const ALogType_Warning = 0x00000030;
const ALogType_Information = 0x00000040;

typedef AInt ALogFlags;
const ALogFlags_IconMask = 0x000000F0;
const ALogFlags_IconError = 0x00000010; // ALogType_Error
const ALogFlags_IconQuestion = 0x00000020; // ALogType_Question
const ALogFlags_IconWarning = 0x00000030; // ALogType_Warning
const ALogFlags_IconInformation = 0x00000040; // ALogType_Information
const ALogFlags_IconUser = 0x00000080;

typedef AInt AMessageBoxFlags;
const AMessageBoxFlags_Ok = 0x00000000;
const AMessageBoxFlags_OkCancel = 0x00000001;
const AMessageBoxFlags_AbortRetryIgnore = 0x00000002;
const AMessageBoxFlags_YesNoCancel = 0x00000003;
const AMessageBoxFlags_YesNo = 0x00000004;
const AMessageBoxFlags_RetryCancel = 0x00000005;
const AMessageBoxFlags_ApplyOkCancel = 0x00000006;
const AMessageBoxFlags_IconError = 0x00000010;
const AMessageBoxFlags_IconQuestion = 0x00000020;
const AMessageBoxFlags_IconWarning = 0x00000030;
const AMessageBoxFlags_IconInformation = 0x00000040;
const AMessageBoxFlags_UserIcon = 0x00000080;

typedef AInt AFunction (*AAddToLogA_Proc)(AStr Msg, ALogFlags Flags, AInt Data);
typedef AError AFunction (*AShowErrorA_Proc)(AStr Caption, AStr UserMessage, AStr ExceptMessage);
typedef ADialogBoxCommands AFunction (*AShowMessageA_Proc)(AStr Text, AStr Caption, AMessageBoxFlags Flags);

/*
TRealArray = array of Real;
TIntArray = array of Integer;
TLongIntArray = array of LongInt;
TBoolArray = array of Boolean;
*/

typedef AInt ACollection;
typedef AInt AStream;
typedef AInt AStringList;

#endif
