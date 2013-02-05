{**
@Abstract AData - DatabaseStructure
@Author Prof1983 <prof1983@ya.ru>
@Created 25.10.2008
@LastMod 05.02.2013
}
unit ADatabaseStructure;

interface

uses
  ADataTypes;

type
  TAFieldStructure = class
  private
    FFieldDefault: WideString;
    FFieldName: WideString;
    FFieldType: TAFieldType;
    FFieldSize: Integer;
    FFieldNotNull: Boolean;
    FDefaultValue: WideString;
    FDescription: WideString;
  protected
    function Get_Description: WideString;
    function Get_FieldDefault: WideString;
    function Get_FieldName: WideString;
    function Get_FieldType: TAFieldType;
    function Get_FieldSize: Integer;
    function Get_FieldNotNull: WordBool;
    procedure Set_FieldDefault(const Value: WideString);
  public
    constructor Create(const FieldName: WideString; FieldType: TAFieldType; FieldSize: Integer; FieldNotNull: Boolean; const Description: WideString);
    property FieldName: WideString read FFieldName;
    property FieldType: TAFieldType read FFieldType;
    property FieldSize: Integer read FFieldSize;
    property FieldNotNull: Boolean read FFieldNotNull;
    property DefaultValue: WideString read FDefaultValue write FDefaultValue;
    property Description: WideString read FDescription;
  end;

type
  TAIndexStructure = class
  private
    FName: WideString;
    FIndexField: WideString;
    FIndexType: TAIndexType;
  protected
    function Get_IndexField: WideString;
    function Get_IndexType: TAIndexType;
    function Get_Name: WideString;
  public
    property Name: WideString read FName write FName;
    property IndexField: WideString read FIndexField write FIndexField;
    property IndexType: TAIndexType read FIndexType write FIndexType;
  end;

type
  TATableStructure = class
  private
    FAccess: TATableAccess;
    FDescription: WideString;
    FFields: array of TAFieldStructure;
    FIndexs: array of TAIndexStructure;
    FTableName: WideString;
  protected
    function Get_Access: TATableAccess;
    function Get_Description: WideString;
    function Get_FieldByIndex(Index: Integer): TAFieldStructure;
    function Get_FieldByName(const Name: WideString): TAFieldStructure;
    function Get_FieldCount: Integer;
    function Get_IndexByIndex(Index: Integer): TAIndexStructure;
    function Get_IndexCount: Integer;
    function Get_Name: WideString;
    procedure Set_Description(const Value: WideString);
  public
    function AddField(const FieldName: WideString; FieldType: TAFieldType): TAFieldStructure; overload;
    function AddField(const FieldName: WideString; FieldType: TAFieldType; FieldSize: Integer; NotNull: Boolean; const Description: WideString): TAFieldStructure; overload;
    function AddField(const FieldName: WideString; FieldType: TAFieldType; FieldSize: Integer; NotNull: Boolean; const Default, Description: WideString): TAFieldStructure; overload;
    function AddFieldItem(Field: TAFieldStructure): Integer;
    function AddIndex(const IndexName: WideString; IndexType: TAIndexType; const IndexFields: WideString): TAIndexStructure;
    function AddIndexItem(Index: TAIndexStructure): Integer;
    constructor Create(const TableName: WideString);
  public
    property Description: WideString read Get_Description write Set_Description;
    property FieldByIndex[Index: Integer]: TAFieldStructure read Get_FieldByIndex;
    property FieldCount: Integer read Get_FieldCount;
    property TableName: WideString read FTableName;
  end;

type
  TADatabaseStructure = class
  private
    FTables: array of TATableStructure;
  protected
    function Get_TableByIndex(Index: Integer): TATableStructure;
    function Get_TableByName(const Name: WideString): TATableStructure;
    function Get_TableCount: Integer;
  public
    function GetTableByIndex(Index: Integer): TATableStructure;
    function GetTableByName(const Name: WideString): TATableStructure;
    function GetTableCount: Integer;
  public
    function AddTable(const TableName: WideString): TATableStructure;
    function AddTableItem(Table: TATableStructure): Integer;
    procedure Clear;
  public
    property TableByIndex[Index: Integer]: TATableStructure read Get_TableByIndex;
    property TableByName[const Name: WideString]: TATableStructure read Get_TableByName;
    property TableCount: Integer read Get_TableCount;
  end;

implementation

{ TADatabaseStructure }

function TADatabaseStructure.AddTable(const TableName: WideString): TATableStructure;
var
  T: TATableStructure;
begin
  Result := Get_TableByName(TableName);
  if not(Assigned(Result)) then
  begin
    T := TATableStructure.Create(TableName);
    AddTableItem(T);
    Result := T;
  end;
end;

function TADatabaseStructure.AddTableItem(Table: TATableStructure): Integer;
begin
  Result := Length(FTables);
  SetLength(FTables, Result + 1);
  FTables[Result] := Table;
end;

procedure TADatabaseStructure.Clear();
begin
  SetLength(FTables, 0);
end;

function TADatabaseStructure.GetTableByIndex(Index: Integer): TATableStructure;
begin
  if (Index >= 0) and (Index < Length(FTables)) then
    Result := FTables[Index]
  else
    Result := nil;
end;

function TADatabaseStructure.GetTableByName(const Name: WideString): TATableStructure;
var
  I: Integer;
begin
  for I := 0 to High(FTables) do
  begin
    if (FTables[I].TableName = Name) then
    begin
      Result := FTables[I];
      Exit;
    end;
  end;
  Result := nil;
end;

function TADatabaseStructure.GetTableCount(): Integer;
begin
  Result := Length(FTables);
end;

function TADatabaseStructure.Get_TableByIndex(Index: Integer): TATableStructure;
begin
  if (Index >= 0) and (Index < Length(FTables)) then
    Result := FTables[Index]
  else
    Result := nil;
end;

function TADatabaseStructure.Get_TableByName(const Name: WideString): TATableStructure;
var
  I: Integer;
begin
  for I := 0 to High(FTables) do
  begin
    if (FTables[I].TableName = Name) then
    begin
      Result := FTables[I];
      Exit;
    end;
  end;
  Result := nil;
end;

function TADatabaseStructure.Get_TableCount(): Integer;
begin
  Result := Length(FTables);
end;

{ TAFieldStructure }

constructor TAFieldStructure.Create(const FieldName: WideString; FieldType: TAFieldType;
  FieldSize: Integer; FieldNotNull: Boolean; const Description: WideString);
begin
  inherited Create();
  FFieldName := FieldName;
  FFieldType := FieldType;
  FFieldSize := FieldSize;
  FFieldNotNull := FieldNotNull;
  FDescription := Description;
end;

function TAFieldStructure.Get_Description(): WideString;
begin
  Result := FDescription;
end;

function TAFieldStructure.Get_FieldDefault(): WideString;
begin
  Result := FFieldDefault;
end;

function TAFieldStructure.Get_FieldName(): WideString;
begin
  Result := FFieldName;
end;

function TAFieldStructure.Get_FieldNotNull(): WordBool;
begin
  Result := FFieldNotNull;
end;

function TAFieldStructure.Get_FieldSize(): Integer;
begin
  Result := FFieldSize;
end;

function TAFieldStructure.Get_FieldType(): TAFieldType;
begin
  Result := FFieldType;
end;

procedure TAFieldStructure.Set_FieldDefault(const Value: WideString);
begin
  FFieldDefault := Value;
end;

{ TAIndexStructure }

function TAIndexStructure.Get_IndexField(): WideString;
begin
  Result := FIndexField;
end;

function TAIndexStructure.Get_IndexType(): TAIndexType;
begin
  Result := FIndexType;
end;

function TAIndexStructure.Get_Name(): WideString;
begin
  Result := FName;
end;

{ TATableStructure }

function TATableStructure.AddField(const FieldName: WideString; FieldType: TAFieldType): TAFieldStructure;
begin
  Result := AddField(FieldName, FieldType, 0, False, '');
end;

function TATableStructure.AddField(const FieldName: WideString; FieldType: TAFieldType;
  FieldSize: Integer; NotNull: Boolean; const Description: WideString): TAFieldStructure;
var
  F: TAFieldStructure;
begin
  Result := Get_FieldByName(FieldName);
  if not(Assigned(Result)) then
  begin
    F := TAFieldStructure.Create(FieldName, FieldType, FieldSize, NotNull, Description);
    AddFieldItem(F);
    Result := F;
  end;
end;

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

function TATableStructure.AddFieldItem(Field: TAFieldStructure): Integer;
begin
  Result := Length(FFields);
  SetLength(FFields, Result + 1);
  FFields[Result] := Field;
end;

function TATableStructure.AddIndex(const IndexName: WideString; IndexType: TAIndexType;
  const IndexFields: WideString): TAIndexStructure;
var
  Index: TAIndexStructure;
begin
  Index := TAIndexStructure.Create();
  Index.Name := IndexName;
  Index.IndexType := IndexType;
  Index.IndexField := IndexFields;
  AddIndexItem(Index);
  Result := Index;
end;

function TATableStructure.AddIndexItem(Index: TAIndexStructure): Integer;
begin
  Result := Length(FIndexs);
  SetLength(FIndexs, Result + 1);
  FIndexs[Result] := Index;
end;

constructor TATableStructure.Create(const TableName: WideString);
begin
  inherited Create();
  FTableName := TableName;
end;

function TATableStructure.Get_FieldByName(const Name: WideString): TAFieldStructure;
var
  I: Integer;
begin
  for I := 0 to High(FFields) do
  begin
    if (FFields[I].FieldName = Name) then
    begin
      Result := FFields[I];
      Exit;
    end;
  end;
  Result := nil;
end;

function TATableStructure.Get_Access(): TATableAccess;
begin
  Result := FAccess;
end;

function TATableStructure.Get_Description(): WideString;
begin
  Result := FDescription;
end;

function TATableStructure.Get_FieldByIndex(Index: Integer): TAFieldStructure;
begin
  if (Index >= 0) and (Index < Length(FFields)) then
    Result := FFields[Index]
  else
    Result := nil;
end;

function TATableStructure.Get_FieldCount(): Integer;
begin
  Result := Length(FFields);
end;

function TATableStructure.Get_IndexByIndex(Index: Integer): TAIndexStructure;
begin
  if (Index >= 0) and (Index < Length(FIndexs)) then
    Result := FIndexs[Index]
  else
    Result := nil;
end;

function TATableStructure.Get_IndexCount(): Integer;
begin
  Result := Length(FIndexs);
end;

function TATableStructure.Get_Name(): WideString;
begin
  Result := FTableName;
end;

procedure TATableStructure.Set_Description(const Value: WideString);
begin
  FDescription := Value;
end;

end.
