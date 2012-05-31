{**
@Abstract(Константы для ядра и модулей)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.03.2008)
@LastMod(15.10.2008)
@Version(0.5)
}
unit AConsts;

{
Общие команды для всей системы
==============================

cmdSendMessage
--------------
Отправить сообщение от имени модуля, к которому направлена команда.
Используется как Ping модулей, а также для пересылки сообщений к удаленным модулям.
Data:
  record
    // Идентификатор модуля к которому необходимо переслать сообщение
    ModuleID: Integer;
    // Команда в пересылаемом сообщении
    Command: Integer;
    // Размер пересылаемых данных
    DataSize: Integer;
    // Пересылаемые данные
    Data: array[0..DataSize-1] of Byte;
  end;
Возвращает идентификатор сообщения (>0) или ошибку (<0).

cmdResult
---------
Команда генерируется модулем, к которому предварительно было сделано обращение на выполнение
какого-либо действия. Сообщение направляется тому модулю от которого был запрос на выполнение действия.
Data: Формат данных зависит от модуля и выполняемой команды. См. пояснения в описании команд.
Возвращает идентификатор сообщения-результата (>0) или ошибку (<0).
ErrorCode:
-1 - модуль назначения не найден
-2 - стек сообщений модуля назначения переполнен

cmdEvent
--------
Первоначальное сообщение генерируется модулем при наступлении какого-либо события и
сообщение отправляется модулю AssistantEventManager (midEventManager) с указанием идентификатора
события как Command. После чего сообщение рассылается менеджером событий всем подписавшимся на это
событие модулям с указанием отправителя - модуля первоисточника идентификатора события в данных.
Data:
  record
    //EventID: Integer
    DataSize: Integer;
    Data: array[0..DataSize-1] of Byte;
  end;
Возвращает присвоеный идентификатор события (>0) или ошибку (<0).


Команды ядра
============

cmdCoreLoadPlugin
-----------------
Загружает плугин и регистрирует в ядре.
Data: nil
Возвращает идентификатор плугина (>0) или ошибку (<0).

cmdCoreUnLoadPlugin
-------------------
Останавливает, финализирует и выгружает плугин.
Data: ModuleID: Integer - идентификатор модуля(плугина)
Возвращает значение TAssistantResult.


Общие команды всех плугинов
===========================

cmdModuleInitialize
-------------------
Инициализирует модуль(плугин).
Data: nil
Возвращает идентификатор сообщения (>0) или ошибку (<0).

cmdModuleFinalize
-----------------
Финализирует модуль(плугин).
Data: nil
Возвращает идентификатор сообщения (>0) или ошибку (<0).

cmdModuleStart
--------------
Запускает выполнение внутреннего подпроцесса в модуле(плугине).
Data: nil
Возвращает идентификатор сообщения (>0) или ошибку (<0).

cmdModuleStop
-------------
Останавливает выполнение внутреннего подпроцесса в модуле(плугине).
Data: nil
Возвращает идентификатор сообщения (>0) или ошибку (<0).

cmdModulePause
--------------
Приостанавливает выполнение внутреннего подпроцесса в модуле(плугине).
Data: nil
Возвращает идентификатор сообщения (>0) или ошибку (<0).


Команды модуля(плугина) AssistantGui (agui.dll)
===============================================

cmdGuiNewLayout
---------------
Создает новое окно для работы.
Data: nil
Возвращает идентификатор сообщения (>0) или ошибку (<0).
После выполнения команды модуль AssistantGui возвращает идентификатор
}

interface

//const
  {**
    @abstract(Начальный идентификатор для нумерации подключаемых модулей)
    Идентификаторы 0..AssistantModuleIDStart-1 зарезервированы под системные модули.
  }
  //ASystemModuleIDStart = 1024;
  //AUserModuleIDStart = 65536;

// ---

// Первые 1023 (1..1023) зарезервированы
// 1025..65535 зарезервированы под системные модули
const
  midCore         = $01; // Ядро
  //midEventManager = $04; // Менеджер событий
  //midModuleManager = $05; // Менеджер модулей

const // Общие команды для всей системы
  cmdSendMessage = $00;
  cmdResult      = $01;
  cmdEvent       = $02;

//const // Команды микроядра (Kernel)
  //cmdKernelGetIsWorking = $10;

const
  cmdMainTerminate = $01;
  cmdMainUpdate    = $02;

const // Команды ядра (Core)
  cmdCoreGetIsWorking   = $10;
  cmdCoreGetModuleCount = $11;
  cmdCoreGetModule      = $12;
  cmdCoreLoadPlugin     = $13;
  cmdCoreUnLoadPlugin   = $14;
  cmdCoreGetEventCount  = $21;
  cmdCoreGetEvent       = $22;
  cmdCoreNewEvent       = $23;
  cmdCoreDeleteEvent    = $24;
  cmdRuntime_GetModuleCount = $0101;

const // Общие команды всех модулей(плугинов)
  cmdModuleInitialize = $11;
  cmdModuleFinalize   = $12;
  cmdModuleStart      = $13;
  cmdModuleStop       = $14;
  cmdModulePause      = $15;

const // Команды модуля(плугина) AssistantGui (agui.dll)
  cmdGuiNewLayout        = $0101;
  cmdGuiNewPerspective   = $0102;
  cmdGuiNewViewPlace     = $0103;
  cmdGuiNewButton        = $0201;
  cmdGuiRegisterEditor   = $0301;
  cmdGuiUnRegisterEditor = $0302;
  cmdGuiRegisterViewer   = $0303;
  cmdGuiUnRegisterViewer = $0304;

const // Команды модуля AssistantEnviroment (aenv.dll)
  cmdEnvNewEntity      = $0101;
  cmdEnvNewInt         = $0102;
  cmdEnvNewBool        = $0103;
  cmdEnvNewFloat       = $0104;
  cmdEnvNewString      = $0105;
  cmdEnvNewClass       = $0106;
  cmdEnvNewObject      = $0107;
  cmdEnvFreeEntity     = $01FF;
  cmdEnvAddProperty    = $0201;
  cmdEnvRemoveProperty = $0202;
  cmdEnvGetPropertyValue = $0203;
  cmdEnvSetPropertyValue = $0204;
  cmdEnvAddMethod      = $0211;
  cmdEnvRemoveMethod   = $0212;
  cmdEnvGetMethod      = $0213;
  cmdEnvSetMethod      = $0214;
  cmdEnvRunMethod      = $0215;

// --- Results ---

const
  rTrue = 0;
  rFalse = -1;
  rCommandNotSupported = -2;
  rModuleNotInitialized = -3;

implementation

end.
