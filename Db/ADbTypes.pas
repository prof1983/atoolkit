{**
@Abstract Глобальные типы и константы для DB
@Author Prof1983 <prof1983@ya.ru>
@Created 25.04.2006
@LastMod 09.08.2012
}
unit ADbTypes;

interface

uses
  AdoInt, SysUtils, Windows;

const // Стандартные константы для работы с БД Access --------------------------
  //** Имя пользователя
  DB_USERNAME = 'AR';
  //** Пароль пользователя
  DB_USERPASSWORD = 'ar';

  //** Имя основной базы
  DB_MAIN_NAME = 'main.mdb';
  //** Имя базы для хранения описаний всех таблиц
  DB_DESCR_NAME = 'descr_db.mdb';
  //** Имя базы для хранения описаний отчетов
  //DB_REPORT_NAME = 'report_db.mdb';

type
  //** Описание структур для автосоздания БД
  TtblJoinType = (dajtInner, dajtLeftOuter, dajtRightOuter, dajtOuter);

  TfldType = (ftUnknown, ftString, ftSmallint, ftInteger,
      ftBoolean, ftFloat, ftCurrency, ftDate, ftTime, ftDateTime,
      ftAutoInc, ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftFixedChar,
      ftWideString);

  //** описание связи таблиц
  TJoinRec = packed record
      //** тип объединения
    jnType: TtblJoinType;
      //** внешняя таблица
    jnTable: string;
      //** поля для связи
    jnFieldIn: string;
      //** поля во внешней таблице для связи
    jnFieldOut: string;
      //** оператор связи
    jnOperator: string;
  end;
  TJoinArr = array [0..1000] of TJoinRec;
  PJoinArr = ^TJoinArr;

  //** описание поля
  TFieldRec = packed record
      //** наименование поля
    fldName: string;
      //** наименование поля по русский
    fldDescription: string;
      //** тип поля
    fldType: TfldType;
      //** размер поля
    fldSize: LongWord;
      //** не может содержать пустых занчений
    fldNotNull: boolean;
      //** значение по умолчанию
    fldDefault: string;
  end;
  TFieldArr = array [0..1000] of TFieldRec;
  PFieldArr = ^TFieldArr;

  //** тип индекса
  TTypeIndex = (idxNotUniqum, idxUniqum, idxPrimary);
  //** описание индекса
  TIndexRec = packed record
      //** Имя индекса
    idxName: string;
      //** Список полей
    idxField: string;
      //** Тип индекса
    idxType: TTypeIndex;
  end;
  TIndexArr = array [0..1000] of TIndexRec;
  PIndexArr = ^TIndexArr;

  //** тип доступа внешних пользователей
  TTableAccess = (tbNone, tbRead, tbReadWrite);
  //** описания таблицы
  TTableRec = packed record
      //** наименование таблицы
    tblName: string;
      //** наименование таблицы по русский
    tblDescription: string;
      //** Доступ для других пользователей
    tblAccess: TTableAccess;
      //** Количество столбцов
    tblFieldsCount: word;
      //** Список полей
    tblFields: PFieldArr;
      //** Количество индексов в таблице
    tblIndexsCount: word;
      //** Список индексов
    tblIndexs: PIndexArr;
      //** Количество объединений
    tblJoinsCount: word;
      //** Список обьединений
    tblJoins: PJoinArr;
  end;
  PTableRec = ^TTableRec;
  TTableArr = array [0..1000] of PTableRec;
  PTableArr = ^TTableArr;

  //** описания представлений
  TViewRec = packed record
      //** имя представления
    vewName: string;
      //** наименование представления по русский
    vewDescription: string;
      //** Доступ для других пользователей
    vewAccess: TTableAccess;
      //** Количество столбцов
    vewFieldsCount: word;
      //** описание полей
    vewFields: PFieldArr;
      //** Количество объединений
    vewJoinsCount: word;
      //** Список обьединений
    vewJoins: PJoinArr;
      //** строка для создания представления
    vewSQLCreate: string;
  end;
  PViewRec = ^TViewRec;
  TViewArr = array [0..1000] of PViewRec;
  PViewArr = ^TViewArr;

  //** описание базы данных
  TDBMain = packed record
      //** количество таблиц
    dbTablesCount: word;
      //** описание таблиц
    dbTables: PTableArr;
      //** количество представлений
    dbViewsCount: word;
      //** описание представлений
    dbViews: PViewArr;
  end;
  PDBMain = ^TDBMain;

  //** описание поля для отчуждения
  TFieldRecOut = packed record
      //** наименование поля
    fldName: string;
      //** наименование поля по русский
    fldDescription: string;
      //** тип поля
    fldType: DataTypeEnum;
      //** признак вычисляемого поля
    fldIsCalc: boolean;
  end;

type //** Тип модуля данных
  TDmType = (
    dmtImport,
    dmtExport,
    dmtSynchronize,
    dmtImportReplica,
    dmtExportReplica
    );
  TDmTypeSet = set of TDmType;

const
  INT_DmType: array[TDmType] of Integer = (1, 2, 4, 8, 16);

implementation
end.
