
// === Константы ===============================================================

const // Константы приведения типов --------------------------------------------
  STR_BOOL: array[Boolean] of string =
    ('False', 'True');
  STR_BOOL_ENG: array[Boolean] of string =
    ('false', 'true');
  STR_BOOL_RUS: array[Boolean] of string =
    ('нет', 'да');
  STR_MONTH_RUS: array[0..12]of string =
    ('неизвестен', 'январь', 'февраль', 'март', 'апрель', 'май', 'июнь', 'июль',
     'август', 'сентябрь', 'октябрь', 'ноябрь', 'декабрь');
  STR_MONTH_ENG: array[0..12]of string =
    ('none', 'January', 'February', 'March', 'April', 'May', 'June', 'July',
     'August', 'September', 'October', 'November', 'December');
  STR_DAYOFWEEK_RUS: array[0..7]of string =
    ('неизвестно', 'воскресенье', 'понедельник', 'вторник', 'среда', 'четверг',
     'пятница', 'суббота');
  STR_DAYOFWEEK_ENG: array[0..7]of string =
    ('none', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday',
     'Saturday');

// === Сообщения ===============================================================

resourcestring // Сообщения ----------------------------------------------------
  sER_LogGroup_None      = 'неизвестно или неопределено';
  sER_LogGroup_NetWork   = 'работа сети, сокетов, протокола TCP/IP';
  sER_LogGroup_Setup     = 'настройки';
  sER_LogGroup_General   = 'общая информация';
  sER_LogGroup_DataBase  = 'работа базы данных';
  sER_LogGroup_Key       = 'работа с ключом защиты';
  sER_LogGroup_Equipment = 'работа специализированного оборудования';
  sER_LogGroup_Algorithm = 'работа математических алгоритмов';
  sER_LogGroup_System    = 'работа системы Windows';
  sER_LogGroup_User      = 'действия пользователя';
resourcestring
  sER_LogType_None        = 'неизвестно или неопределено';
  sER_LogType_Error       = 'ошибка';
  sER_LogType_Warning     = 'предупреждение';
  sER_LogType_Information = 'сообщение';
  sEr_LogType_Do          = 'выполнить';
const // Стандартные сообщения ----------------------------------------
  info_ConfigureLoad   = 'Конфигурации загружены';
  info_ConfigureSave   = 'Конфигурации сохранены';
  stConfigureLoadOk    = 'Конфигурации загружены';
  stConfigureLoadError = 'Конфигурации не загружены';
  stConfigureLoadStart = 'Загрузка конфигураций';
  stConfigureSaveStart = 'Сохранение конфигураций';
  stConfigureSaveOk    = 'Конфигурации сохранены';
  stConfigureSaveError = 'Конфигурации не сохранены';
  stCreateOk           = 'Объект создан';
  stCreateOkA          = 'Объект "%s" создан';
  stFinalize           = 'Финализация';
  stFinalizeError      = 'Не финализировано';
  stFinalizeOk         = 'Финализировано';
  stFinalizeStart      = 'Финализация';
  stFreeOk             = 'Объект уничтожен';
  stInitialize         = 'Инициализация';
  stInitializeError    = 'Ошибка при инициализации';
  stInitializedA       = 'Объект "%s" инициализирован';
  stInitializeOk       = 'Инициализировано';
  stInitialize_Error   = 'Ошибка при инициализации объекта "%s"';
  stInitialize_Ok      = 'Объект "%s" инициализирован';
  stInitialize_Start   = 'Инициализация обекта "%s"';
  stNotActive          = 'Не активирован';
  stNotAssigned        = '"%s.%s" не задан';
  stNotInitialized     = 'Не инициализировано';
  stNotOverride        = 'Функция не переопределена';
  stNotOverrideA       = 'Функция "%s" не переопределена';
  stNotOverrideB       = 'Функция не переопределена "%s.%s"';
  stProgram            = 'Сообщения программы';

resourcestring // Сообщения ----------------------------------------------------
  err_SaveToFile      = 'Ошибка при сохранении файла "%s" "%s"';
  err_Xml_Load1       = 'Не найден закрывающий тег "?>" Line=%d';
  err_Xml_Load2       = 'Не задан элемент Line=%d';
  err_Xml_ReadNodes_1 = 'Не найдена закрывающая символ ">"';

const //** @abstract(Для логирования всех ошибок)
  err_Exception_Str = '%s <%s.%s>.';

const
  cAboutCaption = 'О программе';
  cCompanyName = 'Компания: ';
  cDescription = 'Описание: ';
  cProgramName = 'Имя файла: ';
  cProgramVersion = 'Версия: ';
  cProductVersion = 'Версия продукта: ';

implementation

end.
