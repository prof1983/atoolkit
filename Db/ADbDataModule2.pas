{**
@Abstract Интерфейс для модулей импорта, экспорта и синхронизации
@Author Prof1983 <prof1983@ya.ru>
@Created 06.04.2006
@LastMod 14.11.2012

See ADb.txt
}
unit ADbDataModule2;

interface

uses
  AdoDB, AdoInt, SysUtils,
  ABase, AConfig2007, AConsts2, ADbConsts, ADbTable, ADbTypes, ADbUtils,
  AStorageObj, ATypes, AXmlNodeListUtils;

type // Общий класс для модулей импорта, экспорта и синхронизации
  TDataModule2 = class(TObject)
  private
    FAutoEnabled: WordBool;
    FAutoInterval: Integer;
    FConnectionIn: TAdoConnection;
    FConnectionOut: TAdoConnection;
    FConnectionString: WideString;
    FDescription: WideString;
    FDMType: TDMTypeSet;
    FEnabled: WordBool;
    FFullUpdate: WordBool;
    FName: WideString;
    FOnlyNewRecords: WordBool;
    FOnAddToLog: TProfAddToLog;
    FTables: array of TTableDM;
    function GetIsProfDM(): WordBool;
    function GetIsReplica(): WordBool;
    function GetTable(Index: Integer): TTableDM;
    function GetTableCount(): Integer;
  protected
    // Выполняется при создании объекта
    procedure DoCreate(); virtual;
    // Выполняется при уничтожении объекта
    procedure DoDestroy(); virtual;
    function MoveDataReplica(): WordBool; virtual;
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
  public
    // Добавить таблицу
    function AddTable(const ATitle, ATableNameIn, ATableNameOut: WideString): Boolean;
    // Проверить все таблици
    function Check(): Boolean;
    // Очистить
    procedure Clear();
    // Закрыть соединение с внешней БД
    procedure Close();
    // Загрузить из XML
    function ConfigureLoad(ConfigNode: AXmlNode): AError; virtual;
    function ConfigureLoad1(AConfigNode: TConfigNode1): WordBool; virtual;
    // Сохранить в XML
    function ConfigureSave(ConfigNode: AXmlNode): AError; virtual;
    function ConfigureSave1(AConfigNode: TConfigNode1): WordBool; virtual;
    // Соединение с локальной БД
    property ConnectionIn: TAdoConnection read FConnectionIn write FConnectionIn;
    // Соединение с внешней БД
    property ConnectionOut: TAdoConnection read FConnectionOut;
    constructor Create(ADMType: TDMTypeSet; const AName, ADescription: WideString);
    // Удалить таблицу
    function DeleteTable(AIndex: Integer): Boolean;
    // Прочитать параметры
    function LoadParams(const AStorageDir, AKeyName: WideString): Boolean;
    // Функция логирования
    property OnAddToLog: TProfAddToLog read FOnAddToLog write FOnAddToLog;
    // Сохранить параметры
    function SaveParams(const AStorageDir, AKeyName: WideString): Boolean;
    // Колличество таблиц для импорта/экспорта/синхроницации
    property TableCount: Integer read GetTableCount;
    // Таблици для импорта/экспорта/синхроницации
    property Tables[Index: Integer]: TTableDM read GetTable;
    function Open(): Boolean;
    procedure Free();
  public
    class function GetDefaultName(): WideString; virtual;
    class function GetDefaultDescription(): WideString; virtual;
  public
    // Экспортировать данные
    function ExportData(): WordBool; virtual;
    // Импортировать данные
    function ImportData(): WordBool; virtual;
    // Синхронизировать данные
    function SynchronizeData(): WordBool; virtual;
  published
    // Включить автоматическое обновление
    property AutoEnabled: WordBool read FAutoEnabled write FAutoEnabled;
    // Интервал автоматического обновления, мс
    property AutoInterval: Integer read FAutoInterval write FAutoInterval;
    // Строка подключения к внешней БД
    property ConectionString: WideString read FConnectionString write FConnectionString;
    // Описание модуля данных
    property Description: WideString read FDescription write FDescription;
    // Тип модуля данных
    property DMType: TDMTypeSet read FDMType write FDMType;
    // Использовать этот модуль данных
    property Enabled: WordBool read FEnabled write FEnabled;
    // Обновлять данные полностью.
    property FullUpdate: WordBool read FFullUpdate write FFullUpdate;
    // Этот модуль обменивается данными, используя внутреннюю реализацию
    property IsProfDM: WordBool read GetIsProfDM;
    // Этот модуль обменивается данными через AR_Replica
    property IsReplica: WordBool read GetIsReplica;
    // Название модуля данных
    property Name: WideString read FName write FName;
    // Только добавлять новые записи (старые не обновлять)
    property OnlyNewRecords: WordBool read FOnlyNewRecords write FOnlyNewRecords;
  end;

implementation

const // Константы для файлов настроек
  FILE_EXT_SETTING = '.stg';
  //** Имя файла настроек
  FILE_NAME_SETTING = 'settings' + FILE_EXT_SETTING;

{ TDataModule2 }

function TDataModule2.AddTable(const ATitle, ATableNameIn, ATableNameOut: WideString): Boolean;
var
  I: Integer;
begin
  I := Length(FTables);
  SetLength(FTables, I + 1);
  FTables[I] := TTableDM.Create(Self);
  FTables[I].Title := ATitle;
  FTables[I].TableNameIn := ATableNameIn;
  FTables[I].TableNameOut := ATableNameOut;
  Result := True;
end;

function TDataModule2.Check(): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to High(FTables) do
    Result := Result and FTables[I].Check();

  {if not(Assigned(FKeyFields)) then
  begin
    AddToLog(lgDataBase, ltError, 'KeyFields не задано', []);
    Exit;
  end;
  if not(Assigned(FTableIn)) then
  begin
    AddToLog(lgDataBase, ltError, 'TableIn не задано', []);
    Exit;
  end;
  if not(Assigned(FTableOut)) then
  begin
    AddToLog(lgDataBase, ltError, 'TableOut не задано', []);
    Exit;
  end;

  Result := True;}
end;

procedure TDataModule2.Clear();
var
  I: Integer;
begin
  FAutoEnabled := False;
  FAutoInterval := 0;
  FConnectionString := '';
  FDescription := '';
  FDMType := [];
  FEnabled := False;
  //FName := '';
  FOnlyNewRecords := False;
  for I := 0 to High(FTables) do
  try
    FTables[I].Free();
  except
  end;
  SetLength(FTables, 0);
end;

procedure TDataModule2.Close();
begin
  if Assigned(FConnectionOut) then
  try
    FConnectionOut.Close();
    FConnectionOut.Free();
  finally
    FConnectionOut := nil;
  end;
end;

function TDataModule2.ConfigureLoad(ConfigNode: AXmlNode): AError;
begin
  if (TObject(ConfigNode) is TConfigNode1) then
  begin
    if ConfigureLoad1(TConfigNode1(ConfigNode)) then
      Result := 0
    else
      Result := -3;
  end
  else
    Result := -2;
end;

function TDataModule2.ConfigureLoad1(AConfigNode: TConfigNode1): WordBool;
var
  C: Integer;
  I: Integer;
  Node: {IXmlNode}TConfigNode1;
  Nodes: AXmlNodeList;
begin
  Result := Assigned(AConfigNode);
  if not(Result) then Exit;

  Clear();

  AConfigNode.ReadBool(config_AutoEnabled, FAutoEnabled);
  AConfigNode.ReadInt32(config_AutoInterval, FAutoInterval);
  AConfigNode.ReadString(config_ConnectionString, FConnectionString);
  AConfigNode.ReadString(config_Description, FDescription);
  AConfigNode.ReadInt32(config_DMType, I);
  FDmType := IntToDmTypeSet(I);
  AConfigNode.ReadBool(config_Enabled, FEnabled);
  AConfigNode.ReadString(config_Name, FName);
  AConfigNode.ReadBool(config_OnlyNewRecords, FOnlyNewRecords);

  Node := AConfigNode.GetNodeByName1(config_Tables);
  Nodes := Node.GetChildNodes();
  C := AXmlNodeList_GetCount(Nodes);
  SetLength(FTables, C);
  for I := 0 to C - 1 do
  begin
    FTables[I] := TTableDM.Create(Self);
    FTables[I].OnToLog := ToLog;
    if not(FTables[I].ConfigureLoad(Node.GetNodeByName1(config_Table+IntToStr(I)))) then
      Result := False;
  end;
end;

function TDataModule2.ConfigureSave(ConfigNode: AXmlNode): AError;
begin
  if (TObject(ConfigNode) is TConfigNode1) then
  begin
    if ConfigureSave1(TConfigNode1(ConfigNode)) then
      Result := 0
    else
      Result := -3;
  end
  else
    Result := -2;
end;

function TDataModule2.ConfigureSave1(AConfigNode: TConfigNode1): WordBool;
var
  I: Integer;
  Node: TConfigNode1;
begin
  Result := Assigned(AConfigNode);
  if not(Result) then Exit;

  AConfigNode.Clear();

  AConfigNode.WriteBool(config_AutoEnabled, FAutoEnabled);
  AConfigNode.WriteInt32(config_AutoInterval, FAutoInterval);
  AConfigNode.WriteString(config_ConnectionString, FConnectionString);
  AConfigNode.WriteString(config_Description, FDescription);
  AConfigNode.WriteInt32(config_DMType, DmTypeToInt(FDMType));
  AConfigNode.WriteBool(config_Enabled, FEnabled);
  AConfigNode.WriteString(config_Name, FName);
  AConfigNode.WriteBool(config_OnlyNewRecords, FOnlyNewRecords);

  Node := AConfigNode.GetNodeByName1(config_Tables);
  for I := 0 to High(FTables) do
    if not(FTables[I].ConfigureSave(Node.GetNodeByName1(config_Table+IntToStr(I)))) then
      Result := False;
end;

constructor TDataModule2.Create(ADMType: TDMTypeSet; const AName, ADescription: WideString);
begin
  inherited Create();
  FName := AName;
  FDescription := ADescription;
  FDMType := ADMType;
  DoCreate();
end;

procedure TDataModule2.DoCreate();
begin
end;

procedure TDataModule2.DoDestroy();
begin
end;

function TDataModule2.ExportData(): WordBool;
var
  I: Integer;
begin
  Result := False;
  if IsReplica then
    Result := MoveDataReplica();

  if IsProfDM then
  begin
    // Проверка наличия таблиц для экспорта
    Result := Check();
    if not(Result) then Exit;
    // Открытие внешней БД
    Result := Open();
    if not(Result) then Exit;

    for I := 0 to TableCount - 1 do
    begin
      Tables[I].ExportData();
    end;
    Close();
  end;
end;

function TDataModule2.DeleteTable(AIndex: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if (AIndex < 0) or (AIndex >= Length(FTables)) then Exit;
  FTables[AIndex].Free();
  for I := AIndex to High(FTables) - 1 do
    FTables[I] := FTables[I + 1];
  SetLength(FTables, High(FTables));
end;

procedure TDataModule2.Free();
begin
  DoDestroy();
  inherited Free();
end;

class function TDataModule2.GetDefaultDescription(): WideString;
begin
  Result := ClassName+'_Description';
end;

class function TDataModule2.GetDefaultName(): WideString;
begin
  Result := ClassName;
end;

function TDataModule2.GetIsProfDM(): WordBool;
begin
  Result := (dmtExport in FDMType) or (dmtImport in FDMType) or (dmtSynchronize in FDMType);
end;

function TDataModule2.GetIsReplica(): WordBool;
begin
  Result := (dmtExportReplica in FDMType) or (dmtImportReplica in FDMType);
end;

function TDataModule2.GetTable(Index: Integer): TTableDM;
begin
  if (Index >= 0) and (Index < Length(FTables)) then
    Result := FTables[Index]
  else
    Result := nil;
end;

function TDataModule2.GetTableCount(): Integer;
begin
  Result := Length(FTables);
end;

function TDataModule2.ImportData(): WordBool;
var
  I: Integer;
begin
  Result := False;
  if IsReplica then
    Result := MoveDataReplica();

  if IsProfDM then
  begin
    // Проверка наличия таблиц для импорта
    Result := Check();
    if not(Result) then Exit;
    // Открытие внешней БД
    Result := Open();
    if not(Result) then
    begin
      ToLog(lgGeneral, ltError, 'Ошибка открытия внешней БД', []);
      Exit;
    end;

    for I := 0 to TableCount - 1 do
    begin
      Tables[I].ImportData();
    end;
    Close();
  end;
end;

function TDataModule2.LoadParams(const AStorageDir, AKeyName: WideString): Boolean;
var
  AStorageName: string;
  Count: Integer;
  ps: TPropertyStorage;
  I: Integer;
begin
  Clear();

  AStorageName := AStorageDir + FILE_NAME_SETTING;
  ps := TPropertyStorage.Create(AStorageName);
  ps.Open();
  ps.OpenKey(AKeyName);
  FConnectionString := ps.ReadString('ConnectionString', '');
  FEnabled := ps.ReadBoolean('Enabled', False);
  Count := ps.ReadInteger('TableCount', 0);
  SetLength(FTables, Count);
  for I := 0 to High(FTables) do
  begin
    FTables[I] := TTableDM.Create(Self);
    FTables[I].OnToLog := ToLog;
    FTables[I].LoadParams(AStorageName, AKeyName + '\' + 'Table' + IntToStr(I));
  end;

  ps.Free();
  Result := True;
end;

function TDataModule2.MoveDataReplica(): WordBool;
begin
end;

function TDataModule2.Open(): Boolean;
const
  errSetup = 'Setup не задан для модуля данных "%s" <%s.%s>';
  errConnectionString = 'Setup.ConectionString не задана для модуля данных "%s" <%s.%s>';
  errOpen = 'Ошибка при открытии модуля данных "%s" "%s" <%s.%s>';
begin
  Result := Assigned(FConnectionOut);
  if Result then Exit;
  Result := False;

  if FConnectionString = '' then
  begin
    ToLog(lgDataBase, ltError, errConnectionString, [Name, ClassName, 'Open']);
    Exit;
  end;

  try
    FConnectionOut := TAdoConnection.Create(nil);
    FConnectionOut.LoginPrompt := False;
    FConnectionOut.ConnectionString := FConnectionString;
    FConnectionOut.Open();
    Result := FConnectionOut.Connected;
  except
    on E: Exception do
    begin
      ToLog(lgDataBase, ltError, errOpen, [Name, E.Message, ClassName, 'Open']);
      FConnectionOut.Free();
      FConnectionOut := nil;
    end;
  end;
end;

function TDataModule2.SaveParams(const AStorageDir, AKeyName: WideString): Boolean;
var
  AStorageName: string;
  ps: TPropertyStorage;
  I: Integer;
begin
  AStorageName := AStorageDir + FILE_NAME_SETTING;
  ps := TPropertyStorage.Create(AStorageName);
  ps.Open();
  ps.OpenKey(AKeyName);
  ps.WriteString('ConnectionString', FConnectionString);
  ps.WriteBoolean('Enabled', FEnabled);
  ps.WriteInteger('TableCount', Length(FTables));
  for I := 0 to High(FTables) do
  begin
    FTables[I] := TTableDM.Create(Self);
    FTables[I].SaveParams(AStorageName, AKeyName + '\' + 'Table' + IntToStr(I));
  end;

  ps.Free();
  Result := True;
end;

function TDataModule2.SynchronizeData(): WordBool;
begin
  Result := False;
end;

function TDataModule2.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := -1;
  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(AGroup, AType, AStrMsg, AParams);
  except
  end;
end;

end.
 