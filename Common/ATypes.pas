{**
@Abstract(Глобальные типы для всех проектов)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.02.2007)
@LastMod(03.07.2012)
@Version(0.5)

0.0.5.8 - 30.12.2011
[+] TProfMessageRec
0.0.5.5 - 14.07.2011
[*] TProfMessage
[+] TProfMessageSafe
0.0.5.5 - 15.07.2011
[+] Add TLogType.lTreeView
}
unit ATypes;

interface

uses
  ABase;

// Базовые типы ----------------------------------------------------------------

// TODO: Use base types from ABase.pas
type
  Char08 = Char;
  Char16 = WideChar;
  SByte = ShortInt;
  Float32 = AFloat32;
  Float64 = AFloat64;
  Int08 = ShortInt;
  Int16 = SmallInt;
  Int32 = AInt32;
  //Int64 = Int64;
  UInt08 = AUInt08;
  UInt16 = AUInt16;
  UInt32 = AUInt32;
  IntPtr = Int32;
  UIntPtr = UInt32;

type
  //** @abstract(Результат выполнения функций. Если 0 - нет ошибки, меньше нуля - ошибка, больше нуля - сообщение)
  TProfError = ABase.AError;
  TError = ABase.AError;
const
  PROF_RESULT_OK          = 0;
const // Префиксы, указывающие тип сообщения
  PROF_RESULT_FATAL_ERROR = $C0000000;
  PROF_RESULT_ERROR       = $80000000;
  PROF_RESULT_WARNING     = $40000000;
  PROF_RESULT_INFORMATION = $00000000;

type // from ABase2.pas
  TDateTime32 = Float32;
  TDateTime64 = Float64;
  THandle = UIntPtr;
  THandle32 = UInt32;
  THandle64 = UInt64;
  TId = UIntPtr;
  TId32 = UInt32;
  TId64 = UInt64;

type
  //** @abstract(Массив строк)
  TProfStrings = array of WideString;

// Типы для лог-сообщений ------------------------------------------------------

type
  //** Тип сообщений для записи в лог файл
  TLogTypeMessage = (
      //** неизвестно или неопределено
    ltNone,
      //** ошибка
    ltError,
      //** предупреждение
    ltWarning,
      //** сообщение
    ltInformation,
      //** операция выполнена успешно
    ltOk,
      //** операция отменена
    ltCancel
  );
{
type
  //** Тип сообщений для записи в лог файл
  TLogTypeMessage = Integer;
const
    //** неизвестно или неопределено
  ltNone        = $01;
    //** ошибка
  ltError       = $02;
    //** предупреждение
  ltWarning     = $04;
    //** сообщение
  ltInformation = $08;
}

{type //** Множество значений @link(TLogTypeMessage).
  TLogTypeMessageSet = set of TLogTypeMessage;}

type
  //** Группа сообщения для записи в лог файл
  TLogGroupMessage = (
      //** неизвестно или неопределено
    lgNone,
      //** работа сети, сокетов, протокола TCP/IP
    lgNetwork,
      //** настройки
    lgSetup,
      //** общая информация
    lgGeneral,
      //** работа базы данных
    lgDataBase,
      //** работа с ключом защиты
    lgKey,
      //** работа специализированного оборудования
    lgEquipment,
      //** работа математических алгоритмов
    lgAlgorithm,
      //** работа системы Windows
    lgSystem,
      //** действия пользователя
    lgUser,
      //** @abstract(Группа лог-сообщений от агентов)
    lgAgent
  );

{type //** Множество значений @link(TLogGroupMessage).
  TLogGroupMessageSet = set of TLogGroupMessage;}

const // -----------------------------------------------------------------------
  CHR_LOG_GROUP_MESSAGE: array[TLogGroupMessage] of string = (
      'Non', 'Net', 'Set', 'Gen', 'DB', 'Key', 'Equ', 'Alg', 'Sys', 'Usr', 'Agn'
    );
  CHR_LOG_TYPE_MESSAGE: array[TLogTypeMessage] of string = (
      'N', 'E', 'W', 'I', '+', '-'
    );

// --- Constants for enum EnumGroupMessage ---
type //** @abstract(Группа сообщения для записи в лог файл)
  GroupMessageEnum = Integer;
  EnumGroupMessage = GroupMessageEnum;
const
    //** неизвестно или неопределено
  elgNone      = $00000000;
    //** работа сети, сокетов, протокола TCP/IP
  elgNetwork   = $00000001;
    //** настройки
  elgSetup     = $00000002;
    //** общая информация
  elgGeneral   = $00000004;
    //** работа базы данных
  elgDataBase  = $00000008;
    //** работа с ключом защиты
  elgKey       = $00000010;
    //** работа специализированного оборудования
  elgEquipment = $00000020;
    //** работа математических алгоритмов
  elgAlgorithm = $00000040;
    //** работа системы Windows
  elgSystem    = $00000080;
    //** действия пользователя
  elgUser      = $00000100;
    //** @abstract(Группа лог-сообщений от агентов)
  elgAgent     = $00010000;

const
  OLE_GROUP_MESSAGE: array[TLogGroupMessage] of EnumGroupMessage = (
      elgNone, elgNetwork, elgSetup, elgGeneral, elgDataBase, elgKey, elgEquipment, elgAlgorithm, elgSystem, elgUser, elgAgent
    );

// ---

type
  //** @abstract(Статус нода логирования)
  EnumNodeStatus = Integer;
  StatusNodeEnum = EnumNodeStatus;
  //TLogNodeStatus = Integer;
const
    //** Не определено
  elsNone    = $01;
    //** Выполнено
  elsOK      = $02;
    //** Отменено
  elsCancel  = $04;
    //** Ошибка
  elsError   = $08;
    //** Предупреждение
  elsWarning = $10;
    //** Информация
  elsInformation = $20;

// Prof1983: 26.06.2011 from unLogGlobals-old.pas
type //** Статус нода логирования
  TLogNodeStatus = (
    lsNone,       //**< Не определено
    lsOk,         //**< Выполнено
    lsCancel,     //**< Отменено
    lsError,      //**< Ошибка
    lsWarning,    //**< Предупреждение
    lsInformation //**< Информация
    );
  //TLogNodeStatusSet = set of TLogNodeStatus;

type //** @abstract(Тип логирования)
  TLogType = (
      //** TLogDocuments - записывает сразу в несколько мест (unLogDocuments)
    lDocuments,
      //** Записывать в файл (unLogFile)
    lFile,
      //** Показывать в окне (unLogFormTree)
    lWindow,
      //** Подключаться к сервису логирования AR_LogSystem
    lLogSystem,
      //** Выводить в лог программы (класс TProgram) (unLogProgram)
    lProgram,
      //** Выводить лог в TreeView (unLogTreeView, unLogControl)
    lTreeView,
      //** Uncnown
    lUnknown
    );
  TLogTypeSet = set of TLogType;

const
  int_lDocuments = $01;   // TLogDocuments - записывает сразу в несколько мест
  int_lFile      = $02;   // Записывать в файл
  int_lWindow    = $04;   // Показывать в окне
  int_lLogSystem = $08;   // Подключаться к сервису логирования AR_LogSystem
  int_lProgram   = $10;   // Выводить в лог программы (класс TProgram)
  int_lTreeView  = $20;   // Выводить в TreeView
  int_lUnknown   = $40;   // Uncnown
{
type
  //** @abstract(Тип логирования)
  TLogType = Integer;
const
    //** Нет логирования
  lNone      = $01;
    //** Не известно
  lUnknown   = $02;
    //** TLogDocuments - записывает сразу в несколько мест (unLogDocuments)
  lDocuments = $04;
    //** Записывать в файл (unLogFile)
  lFile      = $08;
    //** Показывать в окне (unLogFormTree)
  lWindow    = $10;
    //** Подключаться к сервису логирования AR_LogSystem (unLogSystem)
  lLogSystem = $20;
    //** Выводить в лог программы (класс TProgram) (unLogProgram)
  lProgram   = $40;
    //** Выводить лог в TreeView (unLogTreeView, unLogControl)
  lTreeView  = $80;
}

// Дополнительные типы ---------------------------------------------------------

type
  //** @abstract(Тип сущности)
  TProfEntityType = AId;
const
  ENTITY_TYPE_NONE          = $01;
  ENTITY_TYPE_UNKNOWN       = $02;
  ENTYTY_TYPE_LIST          = $03;
  ENTITY_TYPE_ATTRIBUTE     = $04;
  ENTITY_TYPE_ATTRIBUTES    = $05;
  ENTITY_TYPE_NODE          = $06;
  ENTITY_TYPE_NODES         = $07;
  ENTITY_TYPE_DOCUMENT      = $08;
  ENTITY_TYPE_DOCUMENTS     = $09;
  ENTITY_TYPE_LOG_NODE      = $0A;
  ENTITY_TYPE_LOG_DOCUMENT  = $0B;
  ENTITY_TYPE_LOG_DOCUMENTS = $0C;
  ENTITY_TYPE_CONFIG_NODE   = $0D;
  ENTITY_TYPE_CONFIG_NODES  = $0E;
  ENTITY_TYPE_CONFIG_DOCUMENT  = $0F;
  ENTITY_TYPE_CONFIG_DOCUMENTS = $10;

type // Тип сообщения ----------------------------------------------------------
  TMessageType = (
    mtNone,   // No message. Use in konveer messages.
    mtComand, // Comand - выполнить команду
    mtEvent,  // Event - произошло событие
    mtAnswer, // Result - ответ на команду
    mtPing,   // Ping - ответить на пинг (для проверки связи)
    mtUncnown // Uncnown
    );
{
type
  //** @abstract(Тип сообщения)
  TMessageType = Integer;
const
    //** No message. Use in konveer messages.
  mtNone    = $0001;
    //** Uncnown - не известно
  mtUncnown = $0002;
    //** Comand - выполнить команду
  mtComand  = $0004;
    //** Event - произошло событие
  mtEvent   = $0008;
    //** Result - ответ на команду
  mtAnswer  = $0010;
    //** Ping - ответить на пинг (для проверки связи)
  mtPing    = $0020;
}

type // Constants for enum EnumTypeMessage -------------------------------------
  TypeMessageEnum = Integer;
  EnumTypeMessage = Integer;
  EnumLogTypeMessage = EnumTypeMessage;
const
  eltNone        = $00000000;
  eltError       = $00000001;
  eltWarning     = $00000002;
  eltInformation = $00000004;
  // Дополнительно
  eltOk          = $00000010;
  eltCancel      = $00000020;

const
  OLE_TYPE_MESSAGE: array[TLogTypeMessage] of EnumTypeMessage = (
      eltNone, eltError, eltWarning, eltInformation, eltOk, eltCancel
    );

// ---

type
  //** @abstract(Состояние процесса)
  TThreadState = Integer;
const
    //** @abstract(Работает)
  tsStarted      = $0001;
    //** @abstract(Происходит запуск)
  tsStarting     = $0002;
    //** @abstract(Не работает)
  tsTerminated   = $0004;
    //** @abstract(Происходит завершение)
  tsTerminating  = $0008;
    //** @abstract(Пауза)
  tsPaused       = $0010;
    //** @abstract(Происходит постановка на паузу)
  tsPausing      = $0020;
    //** @abstract(Нет соединения)
  tsNotConnected = $0040;
    //** @abstract(Не известно)
  tsUncnown      = $1000;

// ---
type // TODO: Избавиться
  TArrayByte = array of Byte;
  TArrayChar = array of Char;
  TArrayFloat32 = array of Float32;
  TArrayString = array of String;
// ---

// Процедурные типы ------------------------------------------------------------

type
  // TODO: Избавиться от использования этого типа
  {** Тип события (callback функции) для добавления в лог файл
    @param(AGroup Группа сообщения)
    @param(AType Тип сообщения)
    @param(AStrMsg Строка для добавления в лог)
    @param(AParam Параметры строки (функция Format))
    @returns(True - если запись добавлена)
  }
  TAddToLog = function (
                         AGroup: TLogGroupMessage;
                         AType: TLogTypeMessage;
                         const AStrMsg: string;
                         AParams: array of const
                       ): Boolean of object; {deprecated;}

type // Тип callback функции для добавления в лог файл -------------------------
  TProfAddToLog = function(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
      const AStrMsg: WideString; AParams: array of const): Integer of object;

type //** Тип callback функции для добавления в лог файл
  TAddToLogProc = function(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
      const AStrMsg: WideString): Integer of object;
  TProcAddToLog = TAddToLogProc;
  TProcAddToLogA = TAddToLogProc;
  TProcToLog = TAddToLogProc;

type
  {**
    Тип callback функции для посылки сообщения или команды
    Подробнее: http://prof-ar.narod.ru/development/acl/
  }
  //TProcMessage = function(Msg: AMessage): Integer of object;
  TProcMessageX = function(Msg: AMessage{IProfNode}): Integer of object;
  {**
    Тип callback функции для посылки сообщения или команды
    Подробнее: http://prof-ar.narod.ru/development/acl/
  }
  TProcMessageSafe = function(Msg: AMessage{IProfMessage}): Integer of object; safecall;
  {**
    Тип callback функции для посылки сообщения или команды
    Формат команды:
      Вариант 1: 'comand param1="value1" param2="value2"'
      Вариант 2: '<comand param1="value1" param2="value2">data</comand>'
  }
  TProcMessageStr = function(const AMsg: WideString): AInt of object;
  {**
    @abstract(Тип callback функции для посылки сообщения или команды)
    Формат команды: Вариант 1: 'comand param1="value1" param2="value2"' @br
                    Вариант 2: '<comand param1="value1" param2="value2">data</comand>' @br
    Подробнее: http://prof-ar.narod.ru/development/messages.html
  }
  TProcMessageStrSafe = function(const AMsg: WideString): Integer of object; safecall;
  TProcMessageA = TProcMessageSafe;

  //TProfMessage = function(const AMsg: WideString): WordBool of object;

type //** @abstract(Тип callback функции для изменения ProgressBar)
  TProgressSafeProc = function(AID, AProgress: Integer; const AMsg: WideString): Integer of object; safecall;
  TProcProgress = TProgressSafeProc;

//type
  // См. Graphics.TProgressEvent
  //TProcessEvent = procedure (Sender: TObject; PercentDone: Byte; const Msg: string) of object;


type //** Сообщение
  TProfMessageRec = record
      //** Содержание сообщения
    FContent: WideString;
      //** Идентификатор сообщений
    FConversationID: WideString;
      //** Строка, идентифицирующая сообщение соответствует параметру reply-with при ответе на сообщение
    FInReplyTo: WideString;
      //** Имя получателя [Prof]
    FReceiverName: WideString;
      //** Время, к которому необходимо получить ответ
    FReplyBy: TDateTime;
      //** Строка, идентифицирующая сообщение
    FReplyWith: WideString;
      //** Имя отправителя [Prof]
    FSenderName: WideString;
      //** Id объекта соединения с ядром
    ConnectionId: UInt64;
      //** Идентификатор сообщения. Идентификатор ответа равен идентификатору посланой команды или события.
    Ident: Int32;
      //** Вся строка
    Msg: WideString;
      //** ID команды/события/ответа
    MsgId: UInt64;
      //** Имя команды/события/ответа
    MsgName: WideString;
      //** Тип сообщения (Comand/Event/Receive)
    MsgType: TMessageType;
      //** Id отправителя
    OwnerId: UInt64;
      //** Дополнительные параметры. Имя нода = 'Params'
    Params: WideString{IProfXmlNode};
  end;

type //** Тип версии системы
  TWinVersion = (wvUnknown, wv95, wv98, wvME, wvNT3, wvNT4, wvW2K, wvXP, wv2003);

const // Текстовых описания глобальных типов
  STR_WIN_VERSION: array[TWinVersion] of string = (
      'неизвестно',
      'Windows 95',
      'Windows 98',
      'Windows ME',
      'Windows NT3',
      'Windows NT4',
      'Windows 2000',
      'Windows XP',
      'Windows 2003');
  STR_GROUP_LOG: array[TLogGroupMessage] of string = (
      'все',
      'сеть',
      'настройки',
      'общее',
      'база данных',
      'ключ',
      'оборудование',
      'алгоритм',
      'система',
      'пользователь',
      'lgAgent');
  STR_GROUP_LOG_ENG: array[TLogGroupMessage] of string = (
      ' none     ',
      ' network  ',
      ' setup    ',
      ' general  ',
      ' database ',
      ' key      ',
      ' equipment',
      ' algorithm',
      ' system   ',
      ' user     ',
      ' lgAgent  ');
  STR_TYPE_LOG: array[TLogTypeMessage] of string = (
      'неизвестно',
      'ошибка',
      'предупреждение',
      'сообщение',
      'ok',
      'cancel');
  STR_TYPE_LOG_ENG: array[TLogTypeMessage] of string = (
      ' none  ',
      ' error ',
      ' warn  ',
      ' info  ',
      ' ok    ',
      ' cancel');

// --- from ProfGlobals.pas ---

type //** @abstract(Информация о файле)
  TFileVersionInfo = record
    ProductName: string;
    ProductVersion: string;
    OriginalFileName: string;
    InternalName: string;
    FileVersion: string;
    LegalCopyright: string;
    CompanyName: string;
    FileDescription: string;
  end;

type //** @abstract(Параметры командной строки)
  TSwitch = (sTest, sDebug, sSilent, sConsole, sInstall, sUnInstall, sStart, sStop, sNoSplash, sTeach, sDemo);
const
  STR_SWITCH: array[TSwitch] of string = ('TEST', 'DEBUG', 'SILENT', 'CONSOLE', 'INSTALL', 'UNINSTALL', 'START', 'STOP', 'NOSPLASH', 'TEACH', 'DEMO');

type //** @abstract(Типы возможных клиентов)
  TClientType = (
                  cltUnknown, //**< неизвестно или неопределено
                  cltInfo,    //**< информационный клиент
                  cltConfig,  //**< клиент для настройки параметров
                  cltWork     //**< рабочий клиент
                );
type //** @abstract(Множество значений @link(TClientType))
  TClientTypeSet = set of TClientType;

type
  ALogDocument = type AInt; // = TALogDocument
  ALogDocument2 = ALogDocument;

// --- Entity ---

type
  {** Сущность }
  AEntity_Type = record
      //** Тип сущности
    EntityType: TProfEntityType;
      //** Идентификатор
    Id: AId;
      //** Префикс лог-сообщений
    LogPrefix: WideString;
      //** Имя
    Name: WideString;
  end;

  {** Именованая сущность }
  ANamedEntity_Type = record
    Entity: AEntity_Type;
      //** Имя
    Name: WideString;
  end;

  {** Опции удаления пробелов в функции StrDeleteStace }
  TDeleteSpaceOptions = (
    dsFirst,  //**< Первые
    dsLast,   //**< Последние
    dsRep     //**< Повторяющиеся
    );
  TDeleteSpaceOptionsSet = set of TDeleteSpaceOptions;

  TDeleteSpaceOption = TDeleteSpaceOptions;
  TDeleteSpaceOptionSet = TDeleteSpaceOptionsSet;

  {** Атрибут (Name="Value") }
  TAttribute = record
    Name: WideString;
    Value: WideString;
  end;

  {** Атрибуты (Name1="Value1" Name2="Value2") }
  TAttributes = array of TAttribute;

implementation

end.
