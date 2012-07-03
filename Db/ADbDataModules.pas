{**
@Abstract(Интерфейс для модулей импорта, экспорта и синхронизации)
@Author(Prof1983 prof1983@ya.ru)
@Created(06.04.2006)
@LastMod(03.07.2012)
@Version(0.5)

  Команды формарования строк вставки и обновления данных (SqlInsert, SqlUpdate)
  %OutTableName%   - Имя внешней таблици
  %OutFieldNames%  - Список имен полей внешней таблици через запятую
  %OutFieldValues% - Список значений полей внешенй таблици через запятую
  %InTableName%    - Имя локальной таблици
  %InFieldNames%   - Список имен полей локальной таблици через запятую
  %InFieldValues%  - Список значений локальной таблици через запятую
}
unit ADbDataModules;

interface

uses
  AdoDB, AdoInt, Dialogs, SysUtils,
  ABase, AConfig2007, ADbDataModule2, ADbTypes, ATypes, AXmlNodeListUtils, AXmlNodeUtils;

type
  TDataModules = class(TObject)
  private
    FConfig: TConfigNode1;       // Конфигурации модулей обмена данными
    FDataModules: array of TDataModule2;
    FDefConnection: TAdoConnection;
    FOnAddToLog: TProfAddToLog;
    function GetDataModule(Index: Integer): TDataModule2;
    function GetDataModuleByName(Name: WideString): TDataModule2;
    function GetDataModulesCount(): Integer;
    function GetDmExport(Index: Integer): TDataModule2;
    function GetDMExportCount(): Integer;
    function GetDMExportReplicaCount(): Integer;
    function GetDMImport(Index: Integer): TDataModule2;
    function GetDMImportCount(): Integer;
    function GetDMSynchronize(Index: Integer): TDataModule2;
    function GetDMSynchronizeCount(): Integer;
    function GetDMExportReplica(Index: Integer): TDataModule2;
    function GetDM(AIndex: Integer; AType: TDmType): TDataModule2;
    function GetDMCount(AType: TDMType): Integer;
    function GetDMImportReplicaCount: Integer;
    function GetDMImportReplica(Index: Integer): TDataModule2;
  protected
    function AddDataModule(ADataModule: TDataModule2): Integer;
    function AddDMExport(AdmExport: TDataModule2): Integer;
    function AddDMImport(AdmImport: TDataModule2): Integer;
    function AddDMSynchronize(AdmSynchronize: TDataModule2): Integer;
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
  public
    procedure Close(); virtual;
    // Конфигурации модулей обмена данными
    property Config: TConfigNode1 read FConfig write FConfig;
    function ConfigureLoad(ConfigNode: AXmlNode): AError;
    function ConfigureLoad1(AConfigNode: TConfigNode1 = nil): WordBool;
    function ConfigureLoad2(const AXml: WideString): WordBool;
    function ConfigureSave(ConfigNode: AXmlNode): AError;
    function ConfigureSave1(AConfigNode: TConfigNode1 = nil): WordBool; overload;
    function ConfigureSave2(var AXml: WideString): WordBool; overload;
    property DataModuleByName[Name: WideString]: TDataModule2 read GetDataModuleByName;
    property DataModulesCount: Integer read GetDataModulesCount;
    property DataModules[Index: Integer]: TDataModule2 read GetDataModule;
    // Внутренняя БД, используемая по умолчанию для модулей обмена данными
    property DefConnection: TAdoConnection read FDefConnection write FDefConnection;
    function DeleteDataModule(const AModuleName: WideString): WordBool;
    property dmExport[Index: Integer]: TDataModule2 read GetDMExport;
    property dmExportCount: Integer read GetDMExportCount;
    property dmExportReplica[Index: Integer]: TDataModule2 read GetDMExportReplica;
    property dmExportReplicaCount: Integer read GetDMExportReplicaCount;
    property dmImport[Index: Integer]: TDataModule2 read GetDMImport;
    property dmImportCount: Integer read GetDMImportCount;
    property dmImportReplica[Index: Integer]: TDataModule2 read GetDMImportReplica;
    property dmImportReplicaCount: Integer read GetDMImportReplicaCount;
    property dmSynchronizeCount: Integer read GetDMSynchronizeCount;
    property dmSynchronize[Index: Integer]: TDataModule2 read GetDMSynchronize;
    function ExportAll(): Boolean;
    function ExportReplicaAll(): Boolean;
    function ImportAll(): Boolean;
    function ImportReplicaAll(): Boolean;
    function LoadParams(const AStorageDir, AKeyName: WideString): Boolean; virtual;
    function NewDataModule(ADMTypeSet: TDMTypeSet = []): TDataModule2;
    property OnAddToLog: TProfAddToLog read FOnAddToLog write FOnAddToLog;
    function Open(): Boolean; virtual;
    function SaveParams(const AStorageDir, AKeyName: WideString): Boolean; virtual;
    function SynchronizeAll(): Boolean;
  end;

//type Tdms = TDataModules;

implementation

{ TDataModules }

function TDataModules.AddDataModule(ADataModule: TDataModule2): Integer;
begin
  Result := Length(FDataModules);
  SetLength(FDataModules, Result + 1);
  FDataModules[Result] := ADataModule;
  FDataModules[Result].OnAddToLog := ToLog;
  if not(Assigned(FDataModules[Result].ConnectionIn)) then
    FDataModules[Result].ConnectionIn := FDefConnection;
end;

function TDataModules.AddDMExport(AdmExport: TDataModule2): Integer;
begin
  {Result := Length(FExports);
  SetLength(FExports, Result + 1);
  FExports[Result] := AdmExport;}
  Result := AddDataModule(AdmExport);
end;

function TDataModules.AddDMImport(AdmImport: TDataModule2): Integer;
begin
  {Result := Length(FImports);
  SetLength(FImports, Result + 1);
  FImports[Result] := AdmImport;}
  Result := AddDataModule(AdmImport);
end;

function TDataModules.AddDMSynchronize(AdmSynchronize: TDataModule2): Integer;
begin
  {Result := Length(FSynchronize);
  SetLength(FSynchronize, Result + 1);
  FSynchronize[Result] := AdmSynchronize;}
  Result := AddDataModule(AdmSynchronize);
end;

procedure TDataModules.Close();
//var
//  I: Integer;
begin
  //SetLength(FExports, 0);
  //SetLength(FImports, 0);
  //SetLength(FSynchronize, 0);

  {for I := 0 to High(FDataModules) do
  try
    FDataModules[I].Free();
  except
  end;}
  SetLength(FDataModules, 0);
end;

function TDataModules.ConfigureLoad(ConfigNode: AXmlNode): AError;
begin
  if (TObject(ConfigNode) is TConfigNode1) then
    ConfigureLoad1(TConfigNode1(ConfigNode))
  else
    ConfigureLoad1(nil);
  Result := 0;
end;

function TDataModules.ConfigureLoad1(AConfigNode: TConfigNode1 = nil): WordBool;
var
  C: Integer;
  I: Integer;
  Node: TConfigNode1;
  Nodes: AXmlNodeList;
begin
  Result := Assigned(AConfigNode);
  if not(Result) then
  begin
    AConfigNode := FConfig;
    Result := Assigned(AConfigNode);
    if not(Result) then Exit;
  end;

  Close();

  Nodes := AConfigNode.GetChildNodes();
  C := AXmlNodeList_GetCount(Nodes);
  SetLength(FDataModules, C);
  for I := 0 to C - 1 do
  begin
    Node := AConfigNode.GetNode(I);
    FDataModules[I] := TDataModule2.Create([], Node.NodeName, '');
    FDataModules[I].ConfigureLoad(Node);
  end;
end;

function TDataModules.ConfigureLoad2(const AXml: WideString): WordBool;
var
  C: TConfigDocument1;
  N: AXmlNode;
begin
  C := TConfigDocument1.Create();
  try
    N := C.GetDocumentElement();
    AXmlNode_SetName(N, 'DataModules');
    AXmlNode_SetXml(N, AXml);
    Result := (ConfigureLoad(N) >= 0);
  finally
    C.Free();
  end;
end;

function TDataModules.ConfigureSave(ConfigNode: AXmlNode): AError;
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

function TDataModules.ConfigureSave1(AConfigNode: TConfigNode1 = nil): WordBool;
var
  I: Integer;
  N: AXmlNode;
begin
  Result := Assigned(AConfigNode);
  if not(Result) then
  begin
    AConfigNode := FConfig;
    Result := Assigned(AConfigNode);
    if not(Result) then Exit;
  end;

  AConfigNode.Clear();

  for I := 0 to High(FDataModules) do
  begin
    N := AConfigNode.NewNode(FDataModules[I].Name);
    if (FDataModules[I].ConfigureSave(N) < 0) then
      Result := False;
  end;
end;

function TDataModules.ConfigureSave2(var AXml: WideString): WordBool;
var
  C: TConfigDocument1;
  N: AXmlNode;
  Res: AError;
begin
  C := TConfigDocument1.Create();
  try
    N := C.GetDocumentElement();
    AXmlNode_SetName(N, 'DataModules');
    Res := ConfigureSave(N);
    AXml := AXmlNode_GetXml(N);
  finally
    C.Free();
  end;
  Result := (Res >= 0);
end;

function TDataModules.DeleteDataModule(const AModuleName: WideString): WordBool;
var
  I: Integer;
  I2: Integer;
begin
  Result := False;
  for I := 0 to High(FDataModules) do
    if FDataModules[I].Name = AModuleName then
    begin
      FDataModules[I].Free();
      for I2 := I to High(FDataModules) - 1 do
        FDataModules[I2] := FDataModules[I2 + 1];
      SetLength(FDataModules, High(FDataModules));
      Result := True;
      Exit;
    end;
end;

function TDataModules.ExportAll(): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to dmExportCount - 1 do
    if not(dmExport[I].ExportData()) then
      Result := False;
end;

function TDataModules.ExportReplicaAll(): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to dmExportReplicaCount - 1 do
    if not(dmExportReplica[I].ExportData()) then
      Result := False;
end;

function TDataModules.GetDataModule(Index: Integer): TDataModule2;
begin
  if (Index >= 0) and (Index < Length(FDataModules)) then
    Result := FDataModules[Index]
  else
    Result := nil;
end;

function TDataModules.GetDataModuleByName(Name: WideString): TDataModule2;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to High(FDataModules) do
    if FDataModules[I].Name = Name then
    begin
      Result := FDataModules[I];
      Exit;
    end;
end;

function TDataModules.GetDataModulesCount(): Integer;
begin
  Result := Length(FDataModules);
end;

function TDataModules.GetDM(AIndex: Integer; AType: TDmType): TDataModule2;
var
  I: Integer;
  N: Integer;
begin
  Result := nil;
  N := -1;
  for I := 0 to High(FDataModules) do
    if AType in FDataModules[I].DMType then
    begin
      Inc(N);
      if N = AIndex then
      begin
        Result := FDataModules[I];
        Exit;
      end;
    end;
  {if (Index >= 0) and (Index < Length(FExports)) then
    Result := FExports[Index]
  else
    Result := nil;}
end;

function TDataModules.GetDMCount(AType: TDMType): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to High(FDataModules) do
    if AType in FDataModules[I].DMType then
      Inc(Result);
end;

function TDataModules.GetDmExport(Index: Integer): TDataModule2;
begin
  Result := GetDM(Index, dmtExport);
end;

function TDataModules.GetDMExportCount(): Integer;
begin
  Result := GetDMCount(dmtExport);
end;

function TDataModules.GetDMExportReplica(Index: Integer): TDataModule2;
begin
  Result := GetDM(Index, dmtExportReplica);
end;

function TDataModules.GetDMExportReplicaCount(): Integer;
begin
  Result := GetDMCount(dmtExportReplica);
end;

function TDataModules.GetDMImport(Index: Integer): TDataModule2;
begin
  Result := GetDM(Index, dmtImport);
end;

function TDataModules.GetDMImportCount(): Integer;
begin
  Result := GetDMCount(dmtImport);
end;

function TDataModules.GetDMImportReplica(Index: Integer): TDataModule2;
begin
  Result := GetDM(Index, dmtImportReplica);
end;

function TDataModules.GetDMImportReplicaCount(): Integer;
begin
  Result := GetDMCount(dmtImportReplica);
end;

function TDataModules.GetDMSynchronize(Index: Integer): TDataModule2;
begin
  Result := GetDM(Index, dmtSynchronize);
end;

function TDataModules.GetDMSynchronizeCount(): Integer;
begin
  Result := GetDMCount(dmtSynchronize);
end;

function TDataModules.ImportAll(): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to dmImportCount - 1 do
    if not(dmImport[I].ImportData()) then
      Result := False;
end;

function TDataModules.ImportReplicaAll(): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to dmImportReplicaCount - 1 do
    if not(dmImportReplica[I].ImportData()) then
      Result := False;
end;

function TDataModules.LoadParams(const AStorageDir, AKeyName: WideString): Boolean;
var
  I: Integer;
  {AStorageName: string;
  Count: Integer;
  ps: TPropertyStorage;}
begin
  Result := True;
  //Close();
  ToLog(lgSetup, ltInformation, 'Загрузка параметров', []);
  // Создание модулей обмена данными
  {AStorageName := AStorageDir + FILE_NAME_SETTING;
  ps := TPropertyStorage.Create(AStorageName);
  ps.Open();
  ps.OpenKey(AKeyName);
  Count := ps.ReadInteger('Count', 0);
  SetLength(FDataModules, Count);
  ps.Free();}

  // Чтение настроек модулей
  for I := 0 to High(FDataModules) do
  try
    if not(Assigned(FDataModules[I])) then
      FDataModules[I] := TDataModule2.Create([], '', '');
    if not(FDataModules[I].LoadParams(AStorageDir, AKeyName + '\' + 'DataModule' + IntToStr(I))) then Result := False;
  except
    Result := False;
  end;
  if Result then
    ToLog(lgSetup, ltInformation, 'Загрузка параметров выполнена успешно', [])
  else
    ToLog(lgSetup, ltWarning, 'Ошибки при загрузке параметров', []);
end;

function TDataModules.NewDataModule(ADMTypeSet: TDMTypeSet = []): TDataModule2;
var
  I: Integer;
  s: string;
  descr: string;
begin
  s := InputBox('Новый модуль обмена данными', 'Введите имя нового модуля обмена данными', 'NewDataModule');
  Result := nil;
  if (s = '') then Exit;
  descr := InputBox('Новый модуль обмена данными', 'Введите описание нового модуля', '');

  Result := TDataModule2.Create(ADMTypeSet, s, descr);

  I := Length(FDataModules);
  SetLength(FDataModules, I + 1);
  FDataModules[I] := Result;
end;

function TDataModules.Open(): Boolean;
begin
  Result := True;
  {// Присоединение к AR_Replica
  if not(Assigned(FReplica)) then
    FReplica := TReplica.Create();
  Result := FReplica.Connect();}
end;

function TDataModules.SaveParams(const AStorageDir, AKeyName: WideString): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to High(FDataModules) do
  try
    if not(FDataModules[I].SaveParams(AStorageDir, AKeyName)) then Result := False;
  except
    Result := False;
  end;
end;

function TDataModules.SynchronizeAll(): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to dmSynchronizeCount - 1 do
    if not(dmSynchronize[I].SynchronizeData()) then
      Result := False;
end;

function TDataModules.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := 1;
  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(AGroup, AType, AStrMsg, AParams);
  except
  end;
end;

end.
 