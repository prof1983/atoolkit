{**
@Author Prof1983 <prof1983@ya.ru>
@Created 04.07.2008
@LastMod 05.02.2013
}
unit ADatabaseUtils;

interface

uses
  Classes, DB, SysUtils, Variants, Windows,
  ADataTypes,
  AUtilsMain;

type
  TExecSqlProc = procedure(Sql: string);

const
  STR_FIELD_TYPE_FB: array[TAFieldType] of string = (
    '',          //aftUnknown
    'CHAR',      //aftString,
    'SMALLINT',  //aftSmallint,
    'INTEGER',   //aftInteger,
    'INT64',     //aftInt64
    'NUMERIC',   //aftNumeric
    'CHAR',      //aftBoolean, // Analog 'CHAR(1)'
    'FLOAT',     //aftFloat,
    'DATE',      //aftDate,
    'TIME',      //aftTime,
    'TIMESTAMP', //aftDateTime,
    'INTEGER',   //aftAutoInc,
    'BLOB',      //aftBlob,
    'VARCHAR'    //aftMemo,
    );

function FieldTypeToA(FieldType: TFieldType): TAFieldType;
function FieldTypeToStr(FieldType: TAFieldType; FieldSize: Integer): string;
function ReadDateTime(Field: TField): TDateTime;
function ReadFloat(Field: TField): Double;
function ReadInteger(Field: TField): Integer;
function ReadString(Field: TField): string;
{** Read value from Field and return in SQL format }
function ReadValue(Field: TField): string;
procedure RefreshDataSet(DS: TDataSet; const FieldName: string);

implementation

function CompareFieldType(FieldType1, FieldType2: TAFieldType): Boolean;
begin
  case FieldType2 of
    aftDate: Result := (FieldType1 = aftDate) or (FieldType1 = aftDateTime);
    aftDateTime: Result := (FieldType1 = aftDate) or (FieldType1 = aftDateTime);
    aftAutoInc: Result := (FieldType1 = aftAutoInc) or (FieldType1 = aftInteger);
    aftBoolean: Result := (FieldType1 = aftBoolean) or (FieldType1 = aftString);
  else
    Result := (FieldType1 = FieldType2);
  end;
end;

function FieldTypeToA(FieldType: TFieldType): TAFieldType;
begin
  case FieldType of
    ftUnknown: Result := aftUnknown;
    ftString: Result := aftString;
    ftSmallint: Result := aftSmallint;
    ftInteger, ftWord: Result := aftInteger;
    ftBoolean: Result := aftBoolean;
    ftFloat, ftCurrency: Result := aftFloat;
    ftDate: Result := aftDate;
    ftTime: Result := aftTime;
    ftDateTime: Result := aftDateTime;
    ftBytes: Result := aftNumeric;
    ftVarBytes, ftBlob: Result := aftBlob;
    ftAutoInc: Result := aftAutoInc;
    ftMemo: Result := aftMemo;
    ftLargeint: Result := aftInt64;
  else
    Result := aftUnknown;
  end;
end;

function FieldTypeToStr(FieldType: TAFieldType; FieldSize: Integer): string;
begin
  case FieldType of
    aftString: Result := STR_FIELD_TYPE_FB[FieldType] + '(' + AUtils_IntToStrP(FieldSize) + ')';
    aftNumeric: Result := STR_FIELD_TYPE_FB[FieldType] + '(' + AUtils_IntToStrP(FieldSize) + ',3)';
  else
    Result := STR_FIELD_TYPE_FB[FieldType];
  end;
end;

function ReadDateTime(Field: TField): TDateTime;
begin
  if Assigned(Field) and not(Field.IsNull) then
    Result := Field.AsDateTime
  else
    Result := 0;
end;

function ReadFloat(Field: TField): Double;
begin
  if Assigned(Field) and not(Field.IsNull) then
    Result := Field.AsFloat
  else
    Result := 0;
end;

function ReadInteger(Field: TField): Integer;
begin
  if Assigned(Field) and not(Field.IsNull) then
    Result := Field.AsInteger
  else
    Result := 0;
end;

function ReadString(Field: TField): string;
begin
  if Assigned(Field) and not(Field.IsNull) then
    Result := Field.AsString
  else
    Result := '';
end;

function ReadValue(Field: TField): string;
begin
  case Field.DataType of
    ftBoolean: Result := 'NULL';
    ftString, ftDate, ftTime: if Field.IsNull then Result := 'NULL' else Result := '''' + Field.AsString + '''';
    ftFloat: Result := AUtils_ReplaceCommaP(AUtils_FloatToStrP(Field.AsFloat), '.');
    ftSmallInt, ftInteger: if Field.IsNull then Result := 'NULL' else Result := AUtils_IntToStrP(Field.AsInteger);
  else
    if Field.IsNull then Result := 'NULL' else Result := Field.AsString;
  end;
end;

procedure RefreshDataSet(DS: TDataSet; const FieldName: string);
var
  Field: TField;
  V: Variant;
begin
  if not(DS.Active) then
  begin
    DS.Open;
    Exit;
  end;

  DS.DisableControls;
  if (DS.State = dsEdit) or (DS.State = dsInsert) then
    DS.Post;
  if (FieldName = '') then
    Field := DS.Fields[0]
  else
    Field := DS.FieldByName(FieldName);
  if (Field = nil) or (Field.IsNull) then
    V := Null
  else
    V := Field.Value;
  DS.Close;
  DS.Open;
  if (V <> null) then
    DS.Locate(FieldName,V,[]);
  DS.EnableControls;
end;

end.
