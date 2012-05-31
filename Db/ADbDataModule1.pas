{**
@Abstract(Класс с основными функциями работы с БД)
@Author(Prof1983 prof1983@ya.ru)
@Created(12.10.2005)
@LastMod(27.04.2012)
@Version(0.5)
}
unit ADbDataModule1;

interface

uses
  AdoDB, Classes, Controls, DB, Dialogs, Forms, Graphics, Messages, SysUtils, Windows,
  AConsts2, ADbCheckMsAccess, ADbTypes, ATypes,
  ADbConnection1;

type //** Класс с основными функциями работы с БД
  TProfDataModule = class(TObject)
  private
    //** Полное имя файла главной БД
    FDBFileNameMain: WideString;
    //** Полное имя файла БД описания структуры таблиц и полей
    FDBFileNameDesc: WideString;
    //** Расположение БД, файла .mdw
    FDBPath: WideString;
    //** Путь к файлу AR_CheckDB_MSAccess.dll
    FDllPath: WideString;
    //** ID ветки логирования
    FLogParentID: Integer;
    //** Функция логирования
    FOnToLog: TProcAddToLog;
    //** Список таблиц
    FTables: array of TAdoTable;
    //** Использовать файл .mdw
    FUseMdw: Boolean;
    function GetTableByIndex(Index: Integer): TAdoTable;
    function GetTableByName(TableName: WideString): TAdoTable;
  protected
    //** Соединение с БД ADO
    FConnection: TProfAdoConnection;
    //** Струкрута БД программы
    FDBMain: TDBMain;
    //** Структура БД описания таблиц и полей для ReportBuilder
    FDBDescr: TDBMain;
  protected
    //** Добавить сообщение в лог
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
    //** Возникает перед закрытием
    function DoClose(): WordBool; virtual;
    //** Возникает после открытия
    function DoOpen(): WordBool; virtual;
      // Добавить сообщение в лог
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; virtual;
      // Добавить сообщение в лог
    function ToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer; virtual;
  public
    //** Тестирование БД
    function CheckDB(): WordBool;
    //** Закрыть
    procedure CloseDB(); virtual;
    {** Создает модуль данных
      @param(AUseMdw - использовать файл ar.mdw) }
    constructor Create(ADllPath, ADBPath, ADBFileName: WideString;
        ADBMain, ADBDescr: TDBMain; AUseMdw: Boolean = False; AConnection: TProfAdoConnection = nil;
        AOpenNow: Boolean = False; AAddToLog: TProcAddToLog = nil);
    procedure Free();
    //** Возвращает True, если Connection создано
    function IsAssignedConnection(): Boolean;
    //** Создание DataSource компонента
    function OpenDataSource(ADataSet: TDataSet): TDataSource; overload;
    //** Создание DataSource компонента
    function OpenDataSource(var ADataSource: TDataSource; ADataSet: TDataSet): Boolean; overload;
    //** Открытие БД (Создание Connection)
    function OpenDB(const AConnectionString: WideString = ''): WordBool; virtual;
    //** Создание TAdoQuery компонента
    function OpenQuery(var AQuery: TAdoQuery; ASql: WideString; AAddToLog: TAddToLog = nil): Boolean; overload;
    //** Создание TAdoQuery компонента
    function OpenQuery(ASql: WideString; AAddToLog: TAddToLog = nil): TAdoQuery; overload;
    //** Создание TAdoTable компонента
    function OpenTable(const ATableName: WideString): TAdoTable; overload; virtual;
    //** Создание TAdoTable компонента
    function OpenTable(var ATable: TAdoTable; const ATableName: WideString; ALoadDescr: Boolean = True): Boolean; overload; virtual;
    //** Открыть таблицу и добавить в FTables
    function OpenTableA(const ATableName: WideString; ALoadDescr: Boolean = True): TAdoTable; overload;
    //** Открыть таблицу и добавить в FTables
    function OpenTableA(var ATable: TAdoTable; const ATableName: WideString; ALoadDescr: Boolean = True): WordBool; overload;
    //** Таблици по индексу
    property TableByIndex[Index: Integer]: TAdoTable read GetTableByIndex;
    //** Таблици по имени
    property TableByName[TableName: WideString]: TAdoTable read GetTableByName;
  published
    //** Полное имя файла БД
    property DBFileName: WideString read FDBFileNameMain write FDBFileNameMain;
    //** Имя файлы БД описания
    property DBFileNameDesc: WideString read FDBFileNameDesc write FDBFileNameDesc;
    //** Струкрута БД
    property DBMain: TDBMain read FDBMain;
    //** Расположение БД (файла ar.mdw)
    property DBPath: WideString read FDBPath write FDBPath;
    //** Путь к файлу AR_CheckDB_MSAccess.dll
    property DllPath: WideString read FDllPath write FDllPath;
    //** Соединение
    property Connection: TProfAdoConnection read FConnection;
    property LogParentID: Integer read FLogParentID write FLogParentID;
    //** Функция логирования
    property OnToLog: TProcAddToLog read FOnToLog write FOnToLog;
  end;

resourcestring // Сообщения ----------------------------------------------------
  stCheckDB                  = 'Проверка БД "%s" DllPath="%s"';
  stConnect_Ok               = 'Соединено';
  stConnect_Error            = 'Ошибка при присоединении к БД "%s" "%s" <%s.%s>';
  stNotAssignedConnection    = 'Соединение не создано';
  stOpenDataSourceError      = 'Ошибка при открытии DataSource "%s"';
  stOpenQueryError           = 'Ошибка при открытии запроса %s "%s"';
  stOpenQueryOk              = 'Запрос %s выполнен';
  stOpenQueryStart           = 'Открытие запроса %s';
  stOpenTableError           = 'Ошибка при открытии таблици %s "%s"';
  stOpenTableOk              = 'Таблица %s открыта';
  stOpenTableStart           = 'Открытие таблици %s';

const
  //** Строка подключения 
  cConnectionString = 'Provider=Microsoft.Jet.OLEDB.4.0;'+
      'Data Source=%s;'+
      'Mode=ReadWrite;Persist Security Info=True';

implementation

{ TProfDataModultMain }

function TProfDataModule.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
begin
  Result := (ToLog2(AGroup, AType, AStrMsg, AParams) > 0);
end;

function TProfDataModule.CheckDB(): WordBool;
var
  Res: Boolean;
  //LogID: Integer;
begin
  //Result := True;
  //LogID := 0;
  //LogID := ToLog(lgDataBase, ltInformation, stCheckDB, [FDBFileName, FDllPath], 0);

  // Проверка доступа ------------------------
  Result := MSAccess_CheckUser(FDBFileNameMain, ToLog);
  if not(Result) then
    ToLog(lgGeneral, ltWarning, Format('MSAccess_CheckUser = False <%s.%s>', [ClassName, 'CheckDB']));

  // Проверка структуры БД --------------------
  Res := MSAccess_CheckData(FDBFileNameMain, @FDBMain, ToLog);
  if not(Res) then
    ToLog(lgGeneral, ltWarning, Format('MSAccess_CheckData = False <%s.%s>', [ClassName, 'CheckDB']));
  Result := Result and Res;

  // Создание описания главной БД --------------
  if FDBFileNameDesc = '' then
    FDBFileNameDesc := DB_DESCR_NAME;

  // Создание БД описания структуры
  Res := MSAccess_CheckUser(FDBFileNameMain, ToLog);
  Result := Result and Res;
  Res := MSAccess_CheckData(FDBFileNameMain, @FDBDescr, ToLog);
  Result := Result and Res;

  {Res := MSAccess_CheckDescr(FDBPath + FDBFileNameDesc, @FDBMain, ToLog);
  if not(Res) then
    ToLog(lgGeneral, ltWarning, 'MSAccess_CheckDescr = False <%s.%s>', [ClassName, 'CheckDB']);
  Result := Result and Res;}
end;

procedure TProfDataModule.CloseDB();
begin
  SetLength(FTables, 0);
  DoClose();
  FConnection.Close();
  {if Assigned(FConnection) then
  try
    FConnection.Connected := False;
    FConnection.Free();
  finally
    FConnection := nil;
  end;}
end;

constructor TProfDataModule.Create(ADllPath, ADBPath, ADBFileName: WideString;
    ADBMain, ADBDescr: TDBMain; AUseMdw: Boolean = False; AConnection: TProfAdoConnection = nil;
    AOpenNow: Boolean = False; AAddToLog: TProcAddToLog = nil);
begin
  inherited Create;
  OnToLog := AAddToLog;
  FDBFileNameMain := ADBFileName;
  FDBPath := ADBPath;
  FDBMain := ADBMain;
  FDBDescr := ADBDescr;
  FDllPath := ADllPath;
  FUseMdw := AUseMdw;
  FConnection := AConnection;

  // Если путь к БД не задан, то по умолчанию
  if FDBPath = '' then
    FDBPath := ExtractFilePath(Application.ExeName) + '..\' + DEFAULT_DB_DIR + '\';
  // Если путь к файлу AR_CheckDB_MSAccess.dll не задан, то по умолчанию
  if FDllPath = '' then
    FDllPath := ExtractFilePath(Application.ExeName) + '..\' + DEFAULT_MODULE_DIR + '\';
  // Если имя БД не задано, то по умолчанию
  if FDBFileNameMain = '' then
    FDBFileNameMain := FDBPath + 'Data.mdb';

  if AOpenNow then
  begin
    // Тестирование БД
    CheckDB();
    // Открытие БД (Создание Connection)
    if Assigned(FConnection) then
    try
      FConnection.Open();
    except
    end
    else
      OpenDB();
  end;
end;

function TProfDataModule.DoOpen(): WordBool;
begin
  Result := True;
end;

function TProfDataModule.DoClose(): WordBool;
begin
  Result := True;
end;

function TProfDataModule.GetTableByIndex(Index: Integer): TAdoTable;
begin
  if (Index >= 0) and (Index < Length(FTables)) then
    Result := FTables[Index]
  else
    Result := nil;
end;

function TProfDataModule.GetTableByName(TableName: WideString): TAdoTable;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to High(FTables) do
    if FTables[i].TableName = TableName then
    begin
      Result := FTables[i];
      Exit;
    end;
end;

procedure TProfDataModule.Free();
begin
  if Assigned(FConnection) then
  try
    FConnection.Free();
  finally
    FConnection := nil;
  end;

  inherited Free();
end;

function TProfDataModule.OpenDataSource(ADataSet: TDataSet): TDataSource;
begin
  Result := nil;
  OpenDataSource(Result, ADataSet);
end;

function TProfDataModule.OpenDataSource(var ADataSource: TDataSource; ADataSet: TDataSet): Boolean;
begin
  Result := False;
  if not(Assigned(ADataSource)) then
    ADataSource := TDataSource.Create(nil);
  try
    ADataSource.DataSet := ADataSet;
    ADataSource.Enabled := True;
    Result := True;
  except
    on E: Exception do
      AddToLog(lgDataBase, ltError, stOpenDataSourceError, [E.Message]);
  end;
end;

function TProfDataModule.IsAssignedConnection(): Boolean;
begin
  Result := Assigned(FConnection);
  if not(Result) then
    AddToLog(lgDataBase, ltError, stNotAssignedConnection, []);
end;

function TProfDataModule.OpenDB(const AConnectionString: WideString = ''): WordBool;
var
  tmpConnectionString: WideString;
begin
  try
    if not(Assigned(FConnection)) then
      FConnection := TProfAdoConnection.Create();
    if FConnection.Connected then
      FConnection.Close();
    if AConnectionString = '' then
      tmpConnectionString := Format(cConnectionString, [FDBFileNameMain, FDBPath])
    else
      tmpConnectionString := AConnectionString;
    FConnection.ConnectionString := tmpConnectionString;
    FConnection.LoginPrompt := False;
    FConnection.DBFileName := FDBFileNameMain;
    Result := FConnection.Initialize();
    if Result then
    begin
      AddToLog(lgGeneral, ltInformation, stConnect_Ok, []);
      Result := DoOpen();
    end;
  except
    on E: Exception do
    begin
      AddToLog(lgGeneral, ltError, stConnect_Error, [FDBFileNameMain, E.Message, ClassName, 'OpenDB']);
      Result := False;
    end;
  end;
end;

function TProfDataModule.OpenQuery(var AQuery: TAdoQuery; ASql: WideString; AAddToLog: TAddToLog = nil): Boolean;
begin
  Result := False;
  //<Prof>
  {if Assigned(AAddToLog) then
    AAddToLog(lgDataBase, ltInformation, stOpenQueryStart, [ASql])
  else
    AddToLog(lgDataBase, ltInformation, stOpenQueryStart, [ASql]);}
  //</Prof>
  if not(Assigned(AQuery)) then
    AQuery := TAdoQuery.Create(nil);
  if AQuery.Active then
    AQuery.Close();
  try
    AQuery.Connection := FConnection;
    AQuery.SQL.Clear;
    AQuery.SQL.Add(ASql);
    AQuery.Open;
    Result := True;
    if Assigned(AAddToLog) then
      AAddToLog(lgDataBase, ltInformation, stOpenQueryOk, [ASql])
    else
      AddToLog(lgDataBase, ltInformation, stOpenQueryOk, [ASql]);
  except
    on E: Exception do if Assigned(AAddToLog) then
      AAddToLog(lgDataBase, ltError, stOpenQueryError, [ASql, E.Message])
    else
      AddToLog(lgDataBase, ltError, stOpenQueryError, [ASql, E.Message]);
  end;
end;

function TProfDataModule.OpenQuery(ASql: WideString; AAddToLog: TAddToLog = nil): TAdoQuery;
begin
  Result := nil;
  if not(IsAssignedConnection) then Exit;
    Result := TAdoQuery.Create(nil);
    OpenQuery(Result, ASql, AAddToLog);
end;

function TProfDataModule.OpenTable(var ATable: TAdoTable; const ATableName: WideString; ALoadDescr: Boolean): Boolean;
begin
  Result := False;
  ATable := nil;
  //<Prof>
  //AddToLog(lgDataBase, ltInformation, stOpenTableStart, [ATableName]);
  //</Prof>
  if not(IsAssignedConnection) then Exit;
  try
    if not(Assigned(ATable)) then
      ATable := TAdoTable.Create(nil);
    TAdoTable(ATable).Connection := FConnection;
    TAdoTable(ATable).TableName := ATableName;
    TAdoTable(ATable).ReadOnly := False;
    // Открытие таблици
    ATable.Active := True;
    Result := ATable.Active;
    if Result then
      AddToLog(lgDataBase, ltInformation, stOpenTableOk, [ATableName])
    else
      AddToLog(lgDataBase, ltError, stOpenTableError, [ATableName, 'Active = False']);
  except
    on E: Exception do
    begin
      if ATable.Active then
        ATable.Close();
      ATable.Free();
      ATable := nil;
      AddToLog(lgDataBase, ltError, stOpenTableError, [ATableName, E.Message]);
    end;
  end;
end;

function TProfDataModule.OpenTable(const ATableName: WideString): TAdoTable;
begin
  Result := nil;
  OpenTable(Result, ATableName);
end;

function TProfDataModule.OpenTableA(const ATableName: WideString; ALoadDescr: Boolean): TAdoTable;
var
  i: Integer;
begin
  Result := TableByName[ATableName];
  if not(Assigned(Result)) then
  begin
    if OpenTable(Result, ATableName, ALoadDescr) then
    begin
      i := Length(FTables);
      SetLength(FTables, i + 1);
      FTables[i] := Result;
    end;
  end;
end;

function TProfDataModule.OpenTableA(var ATable: TAdoTable; const ATableName: WideString; ALoadDescr: Boolean): WordBool;
begin
  ATable := OpenTableA(ATableName, ALoadDescr);
  Result := Assigned(ATable);
end;

function TProfDataModule.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  Result := ToLog2(AGroup, AType, AStrMsg, []);
end;

function TProfDataModule.ToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := -1;
  if Assigned(FOnToLog) then
  try
    //if AParent < 0 then AParent := FLogParentID;
    Result := FOnToLog(AGroup, AType, Format(AStrMsg, AParams));
  except
  end;
end;

end.
