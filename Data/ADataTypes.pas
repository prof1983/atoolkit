{**
@Abstract Модуль работы с базами и структурами данных
@Author Prof1983 <prof1983@ya.ru>
@Created 13.10.2008
@LastMod 25.02.2013
}
unit ADataTypes;

interface

uses
  ABase, ABaseTypes, ADataBase;

const
  ADataBdeGuid: TGuid = '{3A401EE1-A8DC-421F-9048-E8FC1CDC5EC1}';
  BdeDriverName: string = 'Bde';

const
  ADataFibGuid: TGuid = '{724541D0-31DD-4632-AAEC-BA52F3C3C3A9}';
  FibDriverName: string = 'Fib';

// --- Types ---------------------------------------------------------------------------------------

type
  TAFieldType = (
    aftUnknown  = 0,
    aftString   = 1,
    aftSmallInt = 2,
    aftInteger  = 3,
    aftInt64    = 4,
    aftNumeric  = 5,
    aftBoolean  = 6,
    aftFloat    = 7,
    aftDate     = 8,
    aftTime     = 9,
    aftDateTime = 10,
    aftAutoInc  = 11,
    aftBlob     = 12,
    aftMemo     = 13  // VARCHAR
    );

type // Тип индекса
  TAIndexType = (
    idxNotUniqum = 0,
    idxUniqum    = 1,
    idxPrimary   = 2
    );

type
  TAJoinType = (
    jtInner      = 0,
    jtLeftOuter  = 1,
    jtRightOuter = 2,
    jtOuter      = 3
    );

type // Тип доступа внешних пользователей
  TATableAccess = (
    tbNone      = 0,
    tbRead      = 1,
    tbWrite     = 2,
    tbReadWrite = 3
    );

// --- Structures ----------------------------------------------------------------------------------

// --- Data ---

type
  // описание поля
  AFieldStructure = type AInt; // IAFieldStructure;

  // Описание индекса
  AIndexStructure = type AInt; // IAIndexStructure

type
  TADatabaseVersion = AInt;
const
  DatabaseVersionMask = $FFFF0000;
  DatabaseVersion10 = $01000000;
  DatabaseVersion11 = $01010000; // v 1.1
  DatabaseVersion12 = $01020000; // v 1.2

{
type
  TADatabaseStructureProc = procedure(Struct: ADataStructure; DatabaseVersion: TADatabaseVersion); stdcall;
  TAGetStrProc = function: AWideString; stdcall;
}

// --- Interfaces ----------------------------------------------------------------------------------

{
type // Описание поля
  IAFieldStructure = interface
    function Get_FieldDefault(): WideString;
    function Get_FieldName(): WideString;
    function Get_FieldType(): TAFieldType;
    function Get_FieldSize(): AInt;
    function Get_FieldNotNull(): WordBool;
    function Get_Description(): WideString;
    procedure Set_FieldDefault(const Value: WideString);

    // наименование поля
    property FieldName: WideString read Get_FieldName;
    // тип поля
    property FieldType: TAFieldType read Get_FieldType;
    // размер поля
    property FieldSize: AInt read Get_FieldSize;
    // не может содержать пустых значений
    property FieldNotNull: WordBool read Get_FieldNotNull;
    // наименование поля по русский
    property Description: WideString read Get_Description;
    // Вычисляемое виртуальное поле
    //IsCalculated: Bool;
    // значение по умолчанию
    property FieldDefault: WideString read Get_FieldDefault write Set_FieldDefault;
  end;
}

{
type // Описание индекса
  IAIndexStructure = interface
    function Get_IndexField: WideString;
    function Get_IndexType: TAIndexType;
    function Get_Name: WideString;

    // Имя индекса
    property Name: WideString read Get_Name;
    // Список полей
    property IndexField: WideString read Get_IndexField;
    // Тип индекса
    property IndexType: TAIndexType read Get_IndexType;
  end;
}

{
type // Описания таблицы
  IATableStructure = interface
    function Get_Description(): WideString;
    function Get_FieldByIndex(Index: AInt): IAFieldStructure;
    function Get_FieldCount(): Integer;
    function Get_IndexByIndex(Index: AInt): IAIndexStructure;
    function Get_IndexCount(): AInt;
    function Get_Access(): TATableAccess;
    function Get_Name(): WideString;
    procedure Set_Description(const Value: WideString);

    function AddField(const FieldName: WideString; FieldType: TAFieldType): IAFieldStructure; overload;
    function AddField(const FieldName: WideString; FieldType: TAFieldType; FieldSize: AInt; NotNull: ABool; const Description: WideString): IAFieldStructure; overload;
    function AddField(const FieldName: WideString; FieldType: TAFieldType; FieldSize: AInt; NotNull: ABool; const Default, Description: WideString): IAFieldStructure; overload;
    function AddFieldItem(Field: IAFieldStructure): AInt;
    function AddIndex(const IndexName: WideString; IndexType: TAIndexType; const IndexFields: WideString): IAIndexStructure;

    // Наименование таблицы
    property Name: WideString read Get_Name;
    // Наименование таблицы по русский
    property Description: WideString read Get_Description write Set_Description;
    // Доступ для других пользователей
    property Access: TATableAccess read Get_Access;
    // Количество столбцов
    property FieldCount: AInt read Get_FieldCount;
    // Поля
    property FieldByIndex[Index: AInt]: IAFieldStructure read Get_FieldByIndex;
    // Количество индексов в таблице
    property IndexCount: AInt read Get_IndexCount;
    // Список индексов
    property IndexByIndex[Index: AInt]: IAIndexStructure read Get_IndexByIndex;
    // Количество объединений
    //TableJoinsCount: Word;
    // Список обьединений
    //TableJoins: PJoinArray;
  end;
}

// --- Procs ---

{
type
  ADatabase_Close_Proc = function(Database: ADataConnection): AError; stdcall;
  ADatabase_Connect_Proc = function(Database: ADataConnection): ABool; stdcall;
  ADatabase_CreateDatabase_Proc = function(Database: ADataConnection): ABool; stdcall;
  ADatabase_Disconnect_Proc = function(Database: ADataConnection): AError; stdcall;
  //ADatabase_ExecuteSql = function(Database: ADataConnection; const Sql: AWideString): ABool; stdcall;
  ADatabase_ChechDatabaseStructure_Proc = function(Database: ADataConnection; Struct: ADataStructure;
      Logger: AAddToLogA_Proc): ABool; stdcall;
  ADatabase_CheckTableStructure = function(Database: ADataConnection; TableStruct: ATableStructure;
      Logger: AAddToLogA_Proc): ABool; stdcall;
  ADatabase_GetConnected = function(Database: ADataConnection): ABool; stdcall;
  //ADatabase_GetConnectionString = function(Database: ADataConnection): AWideString; stdcall;
  //ADatabase_New = function(const DriverName: AWideString): ADataConnection; stdcall;
  //ADatabase_NewDataSet = function(Database: ADataConnection; const SelectSqlText: AWideString; ReadOnly: ABool): ADataSet; stdcall;
  //ADatabase_NewDataSetA = function(Database: ADataConnection; const SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText, RefreshSqlText: AWideString): ADataSet; stdcall;
  //ADatabase_SetConnectionString = procedure(Database: ADataConnection; const Value: AWideString); stdcall;
type
  ADatabaseStructure_New_Proc = function(): ADataStructure; stdcall;
type
  ADriver_Register_Proc = function(DataDriver: ADataDriver): AInt; stdcall;
type
  // Значение по умолчанию
  AFieldStructure_GetFieldDefault = function(): AWideString;
  // Наименование поля
  AFieldStructure_GetFieldName = function(): AWideString;
  // Тип поля
  AFieldStructure_GetFieldType = function(): TAFieldType;
  // Размер поля
  AFieldStructure_GetFieldSize = function(): AInt;
  // Не может содержать пустых значений
  AFieldStructure_GetFieldNotNull = function(): ABool;
  // Наименование поля по русский
  AFieldStructure_GetDescription = function(): AWideString;
  AFieldStructure_SetFieldDefault = procedure(const Value: AWideString);
}

// --- Testing functions ---------------------------------------------------------------------------

{
var
  FieldStructure_GetFieldDefault: AFieldStructure_GetFieldDefault;
  FieldStructure_GetFieldName: AFieldStructure_GetFieldName;
  FieldStructure_GetFieldType: AFieldStructure_GetFieldType;
  FieldStructure_GetFieldSize: AFieldStructure_GetFieldSize;
  FieldStructure_GetFieldNotNull: AFieldStructure_GetFieldNotNull;
  FieldStructure_GetDescription: AFieldStructure_GetDescription;
  FieldStructure_SetFieldDefault: AFieldStructure_SetFieldDefault;
}

type
  ADataDriverGetProc_Proc = function(ProcName: AStr): Pointer; stdcall;

implementation

end.
