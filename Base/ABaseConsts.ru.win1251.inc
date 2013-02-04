{
Abstract Base consts
Author Prof1983 <prof1983@ya.ru>
Created 06.03.2008
LastMod 04.02.2013
}

const 
  // --- Стандартные сообщения ---
  info_ConfigureLoad = 'Конфигурации загружены';
  info_ConfigureSave = 'Конфигурации сохранены';
  stConfigureLoadOk = 'Конфигурации загружены';
  stConfigureLoadError = 'Конфигурации не загружены';
  stConfigureLoadStart = 'Загрузка конфигураций';
  stConfigureSaveStart = 'Сохранение конфигураций';
  stConfigureSaveOk = 'Конфигурации сохранены';
  stConfigureSaveError = 'Конфигурации не сохранены';
  stCreateOk = 'Объект создан';
  stCreateOkA = 'Объект "%s" создан';
  stFinalize = 'Финализация';
  stFinalizeError = 'Не финализировано';
  stFinalizeOk = 'Финализировано';
  stFinalizeStart = 'Финализация';
  stFreeOk = 'Объект уничтожен';
  stInitialize = 'Инициализация';
  stInitializeError = 'Ошибка при инициализации';
  stInitializedA = 'Объект "%s" инициализирован';
  stInitializeOk = 'Инициализировано';
  stInitialize_Error = 'Ошибка при инициализации объекта "%s"';
  stInitialize_Ok = 'Объект "%s" инициализирован';
  stInitialize_Start = 'Инициализация обекта "%s"';
  stNotActive = 'Не активирован';
  stNotAssigned = '"%s.%s" не задан';
  stNotInitialized = 'Не инициализировано';
  stNotOverride = 'Функция не переопределена';
  stNotOverrideA = 'Функция "%s" не переопределена';
  stNotOverrideB = 'Функция не переопределена "%s.%s"';
  stProgram = 'Сообщения программы';

  // --- Константы приведения типов ---
  STR_BOOL_RUS: array [Boolean] of string = ('нет', 'да');
  STR_BOOL_RUS2: array [Boolean] of string = ('Нет', 'Да');

  // --- Текстовых описания глобальных типов ---
  STR_MONTH_RUS: array [0..12] of string =
    ('неизвестен', 'январь', 'февраль', 'март', 'апрель', 'май', 'июнь', 'июль',
     'август', 'сентябрь', 'октябрь', 'ноябрь', 'декабрь');
  STR_MONTH_RUS_H: array [0..12] of string =
    ('Неизвестен', 'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль',
     'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь');
  STR_DAYOFWEEK_RUS: array [0..7] of string =
    ('неизвестно', 'воскресенье', 'понедельник', 'вторник', 'среда', 'четверг', 'пятница', 'суббота');
