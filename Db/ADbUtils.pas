{**
@Abstract(Интерфейс для модулей импорта, экспорта и синхронизации)
@Author(Prof1983 prof1983@ya.ru)
@Created(06.04.2006)
@LastMod(02.05.2012)
@Version(0.5)

  Команды формарования строк вставки и обновления данных (SqlInsert, SqlUpdate)
  %OutTableName%   - Имя внешней таблици
  %OutFieldNames%  - Список имен полей внешней таблици через запятую
  %OutFieldValues% - Список значений полей внешенй таблици через запятую
  %InTableName%    - Имя локальной таблици
  %InFieldNames%   - Список имен полей локальной таблици через запятую
  %InFieldValues%  - Список значений локальной таблици через запятую
}
unit ADbUtils;

interface

uses
  AdoInt,
  Classes, Db, Variants,
  ADbTypes,
  AXml2007;

function DmTypeToInt(Value: TDmTypeSet): Integer;
function IntToDmTypeSet(Value: Integer): TDmTypeSet;
function Naprav(DmType: TDmTypeSet): string;

function ReadFieldBool(AField: Field; ADefValue: Boolean): Boolean; overload;
function ReadFieldBool(AField: TField; ADefValue: Boolean): Boolean; overload;
function ReadFieldFloat(AField: Field; ADefValue: Double): Double; overload;
function ReadFieldFloat(AField: TField; ADefValue: Double): Double; overload;
function ReadFieldInt(AField: Field; ADefValue: Integer): Integer; overload;
function ReadFieldInt(AField: TField; ADefValue: Integer): Integer; overload;
function ReadFieldString(AField: Field; ADefValue: string): string; overload;
function ReadFieldString(AField: TField; ADefValue: string): string; overload;

function StringListToXml(AXml: TProfXmlNode1; AStrings: TStringList; ADescr: TStringList = nil): Boolean;
function XmlToStringList(AXml: TProfXmlNode1; AStrings: TStringList; ADescr: TStringList = nil): Boolean;

implementation

const
  LOG_NAME_DM = 'AReason_DM.log';
  LOG_NAME_DM_OLD = 'AReason_DM_Old.log';

{ Public }

function DmTypeToInt(Value: TDmTypeSet): Integer;
var
  tmp: TDMType;
begin
  Result := 0;
  for tmp := Low(TDMType) to High(TDMType) do
    if (tmp in Value) then
      Result := Result or INT_DMType[tmp];
end;

function IntToDmTypeSet(Value: Integer): TDmTypeSet;
var
  tmp: TDMType;
begin
  Result := [];
  for tmp := Low(TDMType) to High(TDMType) do
    if (Value and INT_DMType[tmp] <> 0) then Result := Result + [tmp];
end;

function Naprav(DmType: TDmTypeSet): string;
begin
  Result := '';
  if (dmtImport in DMType) and (dmtExport in DMType) then
    Result := '<-->'
  else if dmtSynchronize in DMType then
    Result := '<-->'
  else if dmtExport in DMType then
    Result := '-->'
  else if dmtImport in DMType then
    Result := '<--';

  if (dmtImportReplica in DMType) and (dmtExportReplica in DMType) then
    Result := Result + '<-R->'
  else if dmtExportReplica in DMType then
    Result := Result + '-R->'
  else if dmtImportReplica in DMType then
    Result := Result + '<-R-';


  if DMType = [] then
    Result := '--';
end;

function ReadFieldBool(AField: Field; ADefValue: Boolean): Boolean; overload;
begin
  Result := ADefValue;
  if Assigned(AField) and (AField.Value <> Null) then
  try
    Result := AField.Value;
  except
  end;
end;

function ReadFieldBool(AField: TField; ADefValue: Boolean): Boolean; overload;
begin
  Result := ADefValue;
  if Assigned(AField) and (AField.Value <> Null) then
  try
    Result := AField.Value;
  except
  end;
end;

function ReadFieldFloat(AField: TField; ADefValue: Double): Double; overload;
begin
  Result := ADefValue;
  if Assigned(AField) and (AField.Value <> Null) then
  try
    Result := AField.Value;
  except
  end;
end;

function ReadFieldFloat(AField: Field; ADefValue: Double): Double; overload;
begin
  Result := ADefValue;
  if Assigned(AField) and (AField.Value <> Null) then
  try
    Result := AField.Value;
  except
  end;
end;

function ReadFieldInt(AField: Field; ADefValue: Integer): Integer; overload;
begin
  Result := ADefValue;
  if Assigned(AField) and (AField.Value <> Null) then
  try
    Result := AField.Value;
  except
  end;
end;

function ReadFieldInt(AField: TField; ADefValue: Integer): Integer; overload;
begin
  Result := ADefValue;
  if Assigned(AField) and (AField.Value <> Null) then
  try
    Result := AField.Value;
  except
  end;
end;

function ReadFieldString(AField: Field; ADefValue: string): string; overload;
begin
  Result := ADefValue;
  if Assigned(AField) and (AField.Value <> Null) then
  try
    Result := AField.Value;
  except
  end;
end;

function ReadFieldString(AField: TField; ADefValue: string): string; overload;
begin
  Result := ADefValue;
  if Assigned(AField) and (AField.Value <> Null) then
  try
    Result := AField.Value;
  except
  end;
end;

function StringListToXml(AXml: TProfXmlNode1; AStrings: TStringList; ADescr: TStringList = nil): Boolean;
var
  I: Integer;
  n: TProfXmlNode1;
begin
  Result := Assigned(AStrings) and Assigned(AXml);
  if not(Result) then Exit;
  for I := 0 to AStrings.Count - 1 do
  begin
    //n := AXml.GetNodeByName(AStrings.Strings[I]);
    n := AXml.Collection.NewNode(AStrings.Strings[I]);
    if Assigned(ADescr) then
      n.AsString := ADescr.Strings[I];
  end;
end;

function XmlToStringList(AXml: TProfXmlNode1; AStrings: TStringList; ADescr: TStringList = nil): Boolean;
var
  I: Integer;
  n: TProfXmlNode1;
begin
  Result := Assigned(AXml) and Assigned(AStrings);
  if not(Result) then Exit;
  for I := 0 to AXml.Collection.Count - 1 do
  begin
    n := AXml.Collection.Nodes[I];
    AStrings.Add(n.NodeName);
    if Assigned(ADescr) then
      ADescr.Add(n.AsString);
  end;
end;

end.
