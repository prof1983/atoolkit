{**
@Abstract Базовый модуль основных типов для Delphi 5,7,9
@Author Prof1983 <prof1983@ya.ru>
@Created 06.06.2004
@LastMod 20.12.2012
}
unit ABase2;

{$I A.inc}

interface

uses
  ABase, ATypes;

// Простые типы ----------------------------------------------------------------
{$IFDEF VER130}
type
  UInt64 = Int64;
{$ENDIF}

type // Другие простые типы ----------------------------------------------------
  Char08 = Char;
  Char16 = WideChar;
  Char016 = WideChar;
  Int008 = AInt08;
  Int016 = AInt16;
  Int032 = AInt32;
  Int064 = AInt64;
  Int128 = record I1, I2: Int064 end;
  Int256 = record I1, I2: Int128 end;
  Float32 = Single;
  Float64 = Double;
  UInt008 = AUInt08;
  UInt016 = AUInt16;
  UInt032 = AUInt32;
  UInt064 = AUInt64;
  UInt128 = record I1, I2: UInt064 end;
  UInt256 = record I1, I2: UInt128 end;

type
  TDateTime32 = ATypes.TDateTime32;
  TDateTime64 = ATypes.TDateTime64;
  THandle = ATypes.THandle;
  THandle32 = ATypes.THandle32;
  THandle64 = ATypes.THandle64;
  TId = ATypes.TId;
  TId32 = ATypes.TId32;
  TId64 = ATypes.TId64;

// Константы -------------------------------------------------------------------
const
  HighInt08 = High(AInt08);
  HighInt16 = High(Int16);
  HighInt32 = High(Int32);
  HighInt64 = High(Int64);
  HighUInt08 = High(AUInt08);
  HighUInt16 = High(UInt16);
  HighUInt32 = High(UInt32);
  HighUInt64 = High(UInt64);

const // Константы времени -----------------------------------------------------
  DateTimeDay = 1;
  DateTimeHour = DateTimeDay / 24;
  DateTimeMinute = DateTimeHour / 60;
  DateTimeSecond = DateTimeMinute / 60;

type // Тип callback функции для добавления в лог файл -------------------------
  TProfAddToLog = function(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg, AParams: WideString; AParentId: Integer): Integer of object;

const // Стандартные сообщения -------------------------------------------------
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

implementation

end.
