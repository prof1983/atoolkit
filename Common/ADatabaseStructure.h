/*
Abstract(Database sructures)
Author(Prof1983 prof1983@ya.ru)
Created(03.04.2012)
LastMod(05.04.2012)
*/

#ifndef ADatabaseStructureH
#define ADatabaseStructureH

#include "ABase.h"

typedef enum {
	AFieldType_Unknown = 0,
	AFieldType_String = 1,
	AFieldType_SmallInt = 2,
	AFieldType_Integer = 3,
	AFieldType_Int64 = 4,
	AFieldType_Numeric = 5,
	AFieldType_Boolean = 6,
	AFieldType_Float = 7,
	AFieldType_Date = 8,
	AFieldType_Time = 9,
	AFieldType_DateTime = 10,
	AFieldType_AutoInc = 11,
	AFieldType_Blob = 12,
	AFieldType_Memo = 13 // VARCHAR
} AFieldType;
//typedef int AFieldType;
/*
const AFieldType_Unknown = 0;
const AFieldType_String = 1;
const AFieldType_SmallInt = 2;
const AFieldType_Integer = 3;
const AFieldType_Int64 = 4;
const AFieldType_Numeric = 5;
const AFieldType_Boolean = 6;
const AFieldType_Float = 7;
const AFieldType_Date = 8;
const AFieldType_Time = 9;
const AFieldType_DateTime = 10;
const AFieldType_AutoInc = 11;
const AFieldType_Blob = 12;
const AFieldType_Memo = 13; // VARCHAR
*/

typedef int AIndexType;
typedef int ATableAccess;

//#include "ADataTypes.h";

typedef struct {
	AAnsiString FieldDefault;
	AAnsiString FieldName;
	AFieldType FieldType;
	int FieldSize;
	//bool FieldNotNull;
	AAnsiString DefaultValue;
	AAnsiString Description;
} AFieldStructure_Type;
#define AFieldStructure AFieldStructure_Type*

typedef struct {
	// Index name
	AAnsiString Name;
	// List of fields
	AAnsiString IndexField;
	// Index type
	AIndexType IndexType;
} AIndexStructure_Type;
#define AIndexStructure AIndexStructure_Type*

#define TABLE_STRUCTURE_FIELDS_MAX 255

typedef struct {
	ATableAccess Access;
	AAnsiString Description;
	int FieldsCount;
	AFieldStructure Fields[TABLE_STRUCTURE_FIELDS_MAX];
	int IndexsCount;
	AIndexStructure Indexs[255];
	AAnsiString TableName;
} ATableStructure_Type;
#define ATableStructure ATableStructure_Type*

/*
function ATableStruct_AddField(const FieldName: WideString; FieldType: TAFieldType): TAFieldStructure; overload;
function ATableStruct_AddField(const FieldName: WideString; FieldType: TAFieldType; FieldSize: Integer; NotNull: Boolean; const Description: WideString): TAFieldStructure; overload;
function ATableStruct_AddField(const FieldName: WideString; FieldType: TAFieldType; FieldSize: Integer; NotNull: Boolean; const Default, Description: WideString): TAFieldStructure; overload;
function ATableStruct_AddFieldItem(Field: TAFieldStructure): Integer;
function ATableStruct_AddIndex(const IndexName: WideString; IndexType: TAIndexType; const IndexFields: WideString): TAIndexStructure;
function ATableStruct_AddIndexItem(Index: TAIndexStructure): Integer;
constructor ATableStruct_Create(const TableName: WideString);
*/

typedef struct {
	int TablesCount;
	ATableStructure Tables[255];
} ADatabaseStructure_Type;
#define ADatabaseStructure ADatabaseStructure_Type*

/*
function Get_TableByIndex(Index: Integer): TATableStructure;
function Get_TableCount: Integer;
function AddTableItem(Table: TATableStructure): Integer;
procedure Clear;
*/

/* Add new table struct to Database struct. */
ATableStructure DatabaseStructure_AddTable(ADatabaseStructure DatabaseStructure, AAnsiString TableName);

/* Get table struct from Database struct by table name. */
ATableStructure DatabaseStructure_GetTableByName(ADatabaseStructure DatabaseStructure, AAnsiString TableName);

/* Allocate memory for new DatabaseStructure. */
ADatabaseStructure DatabaseStructure_New();

/* Add new FieldStructure to TableStructure. */
AFieldStructure TableStructure_AddField1(ATableStructure TableStructure, AAnsiString FieldName,
			AFieldType FieldType);

/* Add new FieldStructure to TableStructure. */
AFieldStructure TableStructure_AddField2(ATableStructure TableStructure, AAnsiString FieldName,
			AFieldType FieldType, int FieldSize, ABoolean NotNull, AAnsiString Description);

/* Add existing FieldStructure item to TableStructure. */
AInt TableStructure_AddFieldItem(ATableStructure TableStructure, AFieldStructure Field);

/* Free memory TableStructure. */
AInt TableStructure_Free(ATableStructure TableStructure);

/* Allocate memory for new TableStructure. */
ATableStructure TableStructure_New(AAnsiString TableName);

#endif
