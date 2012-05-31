/*
Abstract(Database structure functions)
Author(Prof1983 prof1983@ya.ru)
Created(03.04.2012)
LastMod(05.04.2012)
*/

#include <stdio.h>
#include <stdlib>
#include <string.h>
#include "ADatabaseStructure.h"

typedef size_t ASize;

void* AllocMem(ASize Size) {
	// --- vars ---
	void* P;

	// --- code ---
	P = malloc(Size);
	memset(P, 0, Size);
}

char STR_FIELD_TYPE_FB[][16] = {
	"",          // AFiedType_Unknown
	"CHAR",      // AFiedType_String
	"SMALLINT",  // AFiedType_Smallint
	"INTEGER",   // AFiedType_Integer
	"INT64",     // AFiedType_Int64
	"NUMERIC",   // AFiedType_Numeric
	"CHAR",      // AFiedType_Boolean // Аналогично 'CHAR(1)'
	"FLOAT",     // AFiedType_Float
	"TIMESTAMP", //'DATE',      // AFiedType_Date
	"TIME",      // AFiedType_Time
	"TIMESTAMP", // AFiedType_DateTime
	"INTEGER",   // AFiedType_AutoInc
	"BLOB",      // AFiedType_Blob
	"VARCHAR"    // AFiedType_Memo
};

AInt FieldTypeToStr(AAnsiString Buf, AFieldType FieldType, AInt FieldSize) {
	// --- vars ---
	//PChar Buf2;

	// --- code ---
	//Buf2 = malloc(256);
	//if (FieldTypeFbToStr(Buf2, 256, FieldType) < 0) return -2;
	sprintf(Buf, "%s (%d)", STR_FIELD_TYPE_FB[FieldType], FieldSize);
	return 0;
	/*
	case {
		AFieldType_String:
			return FieldTypeFbToStr(FieldType) + "(" + IntToStr(FieldSize) + ")";
	}
	*/
/*
  case FieldType of
	aftString: Result := STR_FIELD_TYPE_FB[FieldType] + '(' + IntToStr(FieldSize) + ')';
	aftNumeric: Result := STR_FIELD_TYPE_FB[FieldType] + '(' + IntToStr(FieldSize) + ',3)';
  else
	Result := STR_FIELD_TYPE_FB[FieldType];
  end;
*/
}

// --- DatabaseStructure ---

ATableStructure DatabaseStructure_AddTable(ADatabaseStructure DatabaseStructure, AAnsiString TableName) {
	// --- vars ---
	ATableStructure T;

	// --- code ---
	T = DatabaseStructure_GetTableByName(DatabaseStructure, TableName);
	if (T != NULL) return T;

	T = TableStructure_New(TableName);
	DatabaseStructure_AddTableItem(DatabaseStructure, T);
	return T;
}

int DatabaseStructure_AddTableItem(ADatabaseStructure DatabaseStructure, ATableStructure TableStructure) {
	// --- vars ---
	AInt I;

	// --- code ---
	I = DatabaseStructure->TablesCount;
	DatabaseStructure->Tables[I] = TableStructure;
	I++;
	DatabaseStructure->TablesCount = I;
}

int DatabaseStructure_Clear(ADatabaseStructure DatabaseStructure) {
	// --- vars ---
	AInt I;

	// --- code ---
	if (DatabaseStructure = NULL) return -1;
	for (I = 0; I < DatabaseStructure->TablesCount; I++) {
		TableStructure_Free(DatabaseStructure->Tables[I]);
	}
	memset(DatabaseStructure, 0, sizeof(ADatabaseStructure_Type));
}

ATableStructure DatabaseStructure_GetTableByName(ADatabaseStructure DatabaseStructure, AAnsiString TableName) {
	// --- vars ---
	AInt I;
	ATableStructure Table;

	// --- code ---
	for (I = 0; I < DatabaseStructure->TablesCount; I++) {
		Table = DatabaseStructure->Tables[I];
		if (Table != NULL) {
			if (strcmp(Table->TableName, TableName) == 0) {
				return DatabaseStructure->Tables[I];
			}
		}
	}
	return NULL;
}

ADatabaseStructure DatabaseStructure_New() {
	return (ADatabaseStructure)AllocMem(sizeof(ADatabaseStructure_Type));
}

AFieldStructure FieldStructure_New(AAnsiString FieldName, AFieldType FieldType,
			int FieldSize, ABoolean FieldNotNull, AAnsiString Description) {
	return (AFieldStructure)AllocMem(sizeof(AFieldStructure_Type));

/*
  FFieldName := FieldName;
  FFieldType := FieldType;
  FFieldSize := FieldSize;
  FFieldNotNull := FieldNotNull;
  FDescription := Description;
*/
}

AFieldStructure TableStructure_AddField1(ATableStructure TableStructure, AAnsiString FieldName,
			AFieldType FieldType) {
	return TableStructure_AddField2(TableStructure, FieldName, FieldType, 0, AFalse, "");
}

AFieldStructure TableStructure_AddField2(ATableStructure TableStructure, AAnsiString FieldName,
			AFieldType FieldType, int FieldSize, ABoolean NotNull, AAnsiString Description) {
	// --- var ---
	AFieldStructure F;

	// --- code ---
	if (TableStructure == NULL) return -2;
	if (TableStructure->FieldsCount == TABLE_STRUCTURE_FIELDS_MAX) return -3;
	if (TableStructure_FindFieldByName(TableStructure, FieldName) > 0) return -4;
	F = FieldStructure_New(FieldName, FieldType, FieldSize, NotNull, Description);
	TableStructure_AddFieldItem(TableStructure, F);
	return F;
}

/*
function TATableStructure.AddField(const FieldName: WideString; FieldType: TAFieldType;
  FieldSize: Integer; NotNull: Boolean; const Default, Description: WideString): TAFieldStructure;
var
  F: TAFieldStructure;
begin
  Result := Get_FieldByName(FieldName);
  if not(Assigned(Result)) then
  begin
	F := TAFieldStructure.Create(FieldName, FieldType, FieldSize, NotNull, Description);
	F.DefaultValue := Default;
	AddFieldItem(F);
	Result := F;
  end;
end;
*/

AInt TableStructure_AddFieldItem(ATableStructure TableStructure, AFieldStructure Field) {
	// --- vars ---
	AInt I;

	// --- code ---
	I = TableStructure->FieldsCount;
	if (I >= TABLE_STRUCTURE_FIELDS_MAX) return -2;
	TableStructure->Fields[I] = Field;
	return I;
}

AInt TableStructure_FindFieldByName(ATableStructure TableStructure, AAnsiString FieldName) {
	// --- var ---
	AInt I;

	// --- code ---
	for (I = 0; I < TableStructure->FieldsCount; I++) {
		if (strcmp(TableStructure->Fields[I]->FieldName, FieldName) == 0) {
			return I;
		}
	}
	return -1;
}

AInt TableStructure_Free(ATableStructure TableStructure) {
	// --- vars ---
	AInt I;

	// --- code ---
	if (TableStructure == NULL) return -1;
	for (I = 0; I < TableStructure->FieldsCount; I++) {
		free(TableStructure->Fields[I]);
	}
	free(TableStructure);
	return 0;
}

AFieldStructure TableStructure_GetFieldByName(ATableStructure TableStructure, AAnsiString FieldName) {
	// --- var ---
	AInt I;

	// --- code ---
	for (I = 0; I < TableStructure->FieldsCount; I++) {
		if (strcmp(TableStructure->Fields[I]->FieldName, FieldName) == 0) {
			return TableStructure->Fields[I];
		}
	}
	return NULL;
}

ATableStructure TableStructure_New(AAnsiString TableName) {
	// --- vars ---
	ATableStructure T;

	// --- code ---
	T = (ATableStructure)AllocMem(sizeof(ATableStructure_Type));
	//T = (ATableStructure)malloc(sizeof(ATableStructure_Type));
	//memset(T, 0, sizeof(ATableStructure_Type));
	T->Access = 1;
	T->TableName = TableName;
	return T;
}
