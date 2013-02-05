{**
@Abstract Глобальные типы и константы для DB
@Author Prof1983 <prof1983@ya.ru>
@Created 25.04.2006
@LastMod 30.05.2012
}
unit ADbGlobalsObj;

interface

uses
  ActiveX, AdoInt, Classes, SysUtils, Variants, Windows,
  ADbTypes, ATypes;

type
  TNativADOConnectionString = class;
  TNativADOConnection = class;
  TNativADOCommand = class;
  TNativADORecordset = class;
  TADORemoteInsert = class;
  TADOManageOneRecord = class;

  //** Реализует интерфейс для работы со сторокой подключения
  {$M+}
  TNativADOConnectionString = class(TObject)
  private
    FUserName: string;
    FUserPass: string;
    FConnStr: string;
  public
    constructor Create(const AConnStr: string = '');
    destructor Destroy(); override;
    procedure Assign(ASrc: TNativADOConnectionString); overload;
    procedure Assign(ASrc: string); overload;
  public // Создание стандартных строк подключения
    procedure Make_MSAccess(const ADBPath: string; const ASysDBPath: string);
    procedure Make_dBase_5_0(const ADBPath: string);
    procedure Make_Paradox_7_x(const ADBPath: string);
    procedure Make_CSV_Text(const ADBPath: string);
  published
    //** Строка подключения в формате ADO
    property ConnectionString: string read FConnStr write FConnStr;
    //** Имя пользователя
    property UserName: string read FUserName write FUserName;
    //** Пароль пользователя
    property UserPass: string read FUserPass write FUserPass;
  end;
  {$M-}

  //** Реализует интерфейс к подключению
  TNativADOConnection = class(TObject)
  private
    FMainCS: TRTLCriticalSection;
    FConnection: _Connection;
    FIsTransEnabled: boolean;
    FIsTransStarted: boolean;
    FConnStr: TNativADOConnectionString;
    function GetActive(): boolean;
  protected
    function GetParamSize(AType: DataTypeEnum): integer;    
  public
    constructor Create();
    destructor Destroy(); override;
  public
    //** Открыть соединение
    procedure Open();
    //** Закрыть соединение
    procedure Close();
    //** Начать транзакцию
    procedure BeginTrans();
    //** Откатить транзакцию
    procedure RollbackTrans();
    //** Завершить транзакцию
    procedure CommitTrans();
    //** Попытаться блокировать подключение
    function TryLock(): boolean;
    //** Блокировать подключение
    procedure Lock();
    //** Разблокировать подключение
    procedure UnLock();
  public // Различные варианты выполнения команды
    function ExecCommand(const ACmdText: string; AParams: array of const): integer;
    function ExecGetRecordset(const ACmdText: string; AParams: array of const): _Recordset;
  public
    //** Прямой доступ к объекту
    property Connection: _Connection read FConnection;
    //** Строка подключения
    property ConnectionString: TNativADOConnectionString read FConnStr;
    //** Признак открытого соединения
    property Active: boolean read GetActive;
    //** Признак поддержки транзакций
    property IsTransEnabled: boolean read FIsTransEnabled;
    //** Признак активной транзакции
    property IsTransStarted: boolean read FIsTransStarted;
  end;

  //** Реализует интерфейс к команде подготовленной к выполнению на сервере
  TNativADOCommand = class(TObject)
  private
    FConn: TNativADOConnection;
    FCommand: _Command;
    function GetParamsCount(): integer;
    function GetParamByIndex(Index: integer): _Parameter;
    function GetParamByName(Index: string): _Parameter;
    function GetParamsValues(): Variant;
  public
    constructor Create(AConn: TNativADOConnection; const ACmdText: string);
    destructor Destroy(); override;
  public // Различные варианты выполнения команды
    function ExecCommand(): integer; overload;
    function ExecCommand(const AParams: Variant): integer; overload;
    function ExecGetRecordset(): _Recordset; overload;
    function ExecGetRecordset(const AParams: Variant): _Recordset; overload;
  public
    //** Добавить параметр
    procedure AddInputParam(const AName: string; AType: DataTypeEnum);
  public
    //** Количество параметров
    property ParamsCount: integer read GetParamsCount;
    //** Обратиться к параметру по индексу
    property ParamByIndex[Index: integer]: _Parameter read GetParamByIndex;
    //** Обратиться к параметру по имени
    property ParamByName[Index: string]: _Parameter read GetParamByName; default;
    //** Значения параметров
    property ParamsValues: Variant read GetParamsValues;
  end;

  //** Реализует интерфейс для рекордсета
  TNativADORecordset = class(TObject)
  private
    FRecordset: _Recordset;
    FConn: TNativADOConnection;
    FStandartFields: TStringList;
    FCalclFields: TStringList;
    function GetEOF(): boolean;
    function GetBOF(): boolean;
    function GetFieldsCount(): integer;
    function GetFieldsName(Index: integer): string;
    function GetFieldsType(Index: string): DataTypeEnum;
    function GetValueAsVariant(Index: string): Variant;
    function GetValueAsInteger(Index: string): integer;
    function GetValueAsString(Index: string): string;
    function GetValueAsDouble(Index: string): Double;
    function GetFieldsValues(): Variant;
  protected
    procedure AddCalcField(const AName: string; AType: DataTypeEnum);
    function DoGetCalcFieldValue(const AName: string): Variant; virtual;
    procedure DoCalcField(); virtual;
  public
    constructor Create(AConn: TNativADOConnection; const ACmdText: string); overload;
    constructor Create(ACommand: TNativADOCommand); overload;
    destructor Destroy(); override;
  public
    //** Получить массив значений полей по аказанному списку
    function GetFiledsValues(AFieldList: TStringList): Variant;
  public // Навигация по набору данных
    procedure Next;
    procedure First;
    procedure Last;
    procedure Previous;
    property EOF: boolean read GetEOF;
    property BOF: boolean read GetBOF;
  public
    property Recordset: _Recordset read FRecordset;                             // Доступ непосредственно к данным
    property FieldsCount: integer read GetFieldsCount;                          // Количество всех полей в наборе
    property FieldsName[Index: integer]: string read GetFieldsName;             // Название всех полей в наборе
    property FieldsType[Index: string]: DataTypeEnum read GetFieldsType;        // Получает тип поля
    property ValueAsVariant[Index: string]: Variant read GetValueAsVariant;     // Получает значение поля как вариант
    property ValueAsInteger[Index: string]: Integer read GetValueAsInteger;     // Получает значение поля как целое
    property ValueAsDouble[Index: string]: Double read GetValueAsDouble;        // Получает значение поля как вещественное
    property ValueAsString[Index: string]: string read GetValueAsString;        // Получает значение поля как строку
    property FieldsValues: Variant read GetFieldsValues;                        // Получить значения всех полей
  end;

  //** Реализует интерфейс для команды экспорта данных
  TADORemoteInsert = class(TObject)
  private
    FFieldList: TStringList;
    FCommand: _Command;
  public
    constructor Create(AConn: TNativADOConnection; const ARemoteTableName: string; AFieldList: TStringList; AFieldType: array of DataTypeEnum);
    destructor Destroy(); override;
  public
    procedure InsertCurrent(AValue: Variant); overload;                         // Отправить на сервер текущую запись
  end;

  TADOManageOneRecord = class(TObject)
  private
    FConn: TNativADOConnection;
    FSelectSQL: TNativADOCommand;
    FInsertSQL: TNativADOCommand;
    FDeleteSQL: TNativADOCommand;
    FUpdateSQL: TNativADOCommand;
  protected
    procedure MakeCommandSelect(ACmd: string);
    procedure MakeCommandInsert(ACmd: string);
    procedure MakeCommandDelete(ACmd: string);
    procedure MakeCommandUpdate(ACmd: string);
    property SelectSQL: TNativADOCommand read FSelectSQL;                            // Команда для выборки значений одногой записи
    property InsertSQL: TNativADOCommand read FInsertSQL;                            // Команда для вставки значений одногой записи
    property DeleteSQL: TNativADOCommand read FDeleteSQL;                            // Команда для удаления значений одногой записи
    property UpdateSQL: TNativADOCommand read FUpdateSQL;                            // Команда для обновления значений одногой записи
  public
    constructor Create(AConn: TNativADOConnection);
    destructor Destroy(); override;
  public
    function CheckExist(AParams: Variant): boolean;                             // Проверить существование записи
    function GetValues(AParams: Variant): Variant;                              // Получить значения записи
    procedure Insert(AParams: Variant);                                         // Вставить новую запись
    procedure Delete(AParams: Variant);                                         // Удалить запись
    procedure Update(AParams: Variant);                                         // Обновить запись
  end;

// Функции для проверки БД -----------------------------------------------------
function MSAccess_CheckUser(const APathDLL: string; const ADBDataFile: string; AFunc: TAddToLog): boolean;
function MSAccess_CheckData(const APathDLL: string; const ADBDataFile: string; ADBMain: PDBMain; AFunc: TAddToLog): boolean;
function MSAccess_CheckDescr(const APathDLL: string; const ADBDescrFile: string; ADBMain: PDBMain; AFunc: TAddToLog): boolean;

const // Стандартные строки подключения ----------------------------------------
  conn_MSAccess_No_SysDB  = 'Provider=Microsoft.Jet.OLEDB.4.0; Data Source=%s; Persist Security Info=True;';
  conn_MSAccess           = 'Provider=Microsoft.Jet.OLEDB.4.0; Data Source=%s; Jet OLEDB:System Database=%s; Persist Security Info=True;';
  conn_Paradox_7_x        = 'Provider=Microsoft.Jet.OLEDB.4.0; Data Source=%s; Extended Properties=Paradox 7.x; Persist Security Info=True;';
  conn_dBase_5_0          = 'Provider=Microsoft.Jet.OLEDB.4.0; Data Source=%s; Extended Properties=dBase 5.0; Persist Security Info=True;';
  conn_CSV_Text           = 'Provider=Microsoft.Jet.OLEDB.4.0; Data Source=%s; Extended Properties="Text; HDR=Yes; FMT=Delimited "; Persist Security Info=True;';

implementation

type // тип функции для проверки базы данных ----------------------------------------
  TCheckUser = function (const ADBDataFile: PChar; AFunc: TAddToLog): boolean; stdcall;
  TCheckData = function (const ADBDataFile: PChar; ADBMain: PDBMain; AFunc: TAddToLog): boolean; stdcall;
const // -----------------------------------------------------------------------
  err_Connet_DB  = 'Ошибка подключения к удаленной БД.';
  err_Connet_DB1 = 'Ошибка подключения к БД.';
const // -----------------------------------------------------------------------
  str_LibraryName = 'AR_CheckDB_MSAccess.dll';

// -----------------------------------------------------------------------------

function MSAccess_CheckUser(const APathDLL: string; const ADBDataFile: string; AFunc: TAddToLog): boolean;
var
  hUnitLib: THandle;
  FProc: FARPROC;
begin
  Result := False;
  hUnitLib := LoadLibrary(PChar(IncludeTrailingBackslash(APathDLL) + str_LibraryName));
  if (hUnitLib >= 32) then
  begin
    FProc := GetProcAddress(hUnitLib, 'CheckDBUser');
    if (@FProc <> nil) then
      Result := TCheckUser(FProc)(PChar(ADBDataFile), AFunc);
    FreeLibrary(hUnitLib);
  end;
end;

function MSAccess_CheckData(const APathDLL: string; const ADBDataFile: string; ADBMain: PDBMain; AFunc: TAddToLog): boolean;
var
  hUnitLib: THandle;
  FProc: FARPROC;
begin
  Result := False;
  hUnitLib := LoadLibrary(PChar(IncludeTrailingBackslash(APathDLL) + str_LibraryName));
  if (hUnitLib >= 32) then
  begin
    FProc := GetProcAddress(hUnitLib, 'CheckDBData');
    if (@FProc <> nil) then
    try
      Result := TCheckData(FProc)(PChar(ADBDataFile), ADBMain, AFunc);
    except
      on E: Exception do
        if Assigned(AFunc) then
          AFunc(lgDataBase, ltError, 'Ошибка при проверке БД "%s" <%s.%s>', [E.Message, 'unDBGlobals', 'MSAccess_CheckData']);
    end;
    FreeLibrary(hUnitLib);
  end;
end;

function MSAccess_CheckDescr(const APathDLL: string; const ADBDescrFile: string; ADBMain: PDBMain; AFunc: TAddToLog): boolean;
var
  hUnitLib: THandle;
  FProc: FARPROC;
begin
  Result := False;
  hUnitLib := LoadLibrary(PChar(IncludeTrailingBackslash(APathDLL) + str_LibraryName));
  if (hUnitLib >= 32) then
  begin
    FProc := GetProcAddress(hUnitLib, 'CheckDBDescr');
    if (@FProc <> nil) then
      Result := TCheckData(FProc)(PChar(ADBDescrFile), ADBMain, AFunc);
    FreeLibrary(hUnitLib);
  end;
end;

{ TADOManageOneRecord }

constructor TADOManageOneRecord.Create(AConn: TNativADOConnection);
begin
  inherited Create();
  FConn := AConn;
end;

destructor TADOManageOneRecord.Destroy();
begin
  if Assigned(FSelectSQL) then FreeAndNil(FSelectSQL);
  if Assigned(FInsertSQL) then FreeAndNil(FInsertSQL);
  if Assigned(FDeleteSQL) then FreeAndNil(FDeleteSQL);
  if Assigned(FUpdateSQL) then FreeAndNil(FUpdateSQL);
  inherited;
end;

procedure TADOManageOneRecord.MakeCommandUpdate(ACmd: string);
begin
  if Assigned(FUpdateSQL) then FreeAndNil(FUpdateSQL);
  FUpdateSQL := TNativADOCommand.Create(FConn, ACmd);
end;

procedure TADOManageOneRecord.MakeCommandSelect(ACmd: string);
begin
  if Assigned(FSelectSQL) then FreeAndNil(FSelectSQL);
  FSelectSQL := TNativADOCommand.Create(FConn, ACmd);
end;

procedure TADOManageOneRecord.MakeCommandInsert(ACmd: string);
begin
  if Assigned(FInsertSQL) then FreeAndNil(FInsertSQL);
  FInsertSQL := TNativADOCommand.Create(FConn, ACmd);
end;

procedure TADOManageOneRecord.MakeCommandDelete(ACmd: string);
begin
  if Assigned(FDeleteSQL) then FreeAndNil(FDeleteSQL);
  FDeleteSQL := TNativADOCommand.Create(FConn, ACmd);
end;

function TADOManageOneRecord.CheckExist(AParams: Variant): boolean;
var
  tmpRecord: _Recordset;
begin
  Result := False;
  if Assigned(FSelectSQL) then
  try
    tmpRecord := FSelectSQL.ExecGetRecordset(AParams);
    Result := not (tmpRecord.BOF and tmpRecord.EOF);
  finally
    tmpRecord := nil;
  end;
end;

function TADOManageOneRecord.GetValues(AParams: Variant): Variant;
var
  tmpRecord: _Recordset;
  n: integer;
begin
  Result := null;
  if Assigned(FSelectSQL) then
  try
    tmpRecord := FSelectSQL.ExecGetRecordset(AParams);
    if (tmpRecord.BOF and tmpRecord.EOF) then Exit;
    Result := VarArrayCreate([0, tmpRecord.Fields.Count - 1], varVariant);
    for n:=0 to tmpRecord.Fields.Count - 1 do
      Result[n] := tmpRecord.Fields[n].Value;
  finally
    tmpRecord := nil;
  end;
end;

procedure TADOManageOneRecord.Insert(AParams: Variant);
begin
  if Assigned(FInsertSQL) then FInsertSQL.ExecCommand(AParams);
end;

procedure TADOManageOneRecord.Delete(AParams: Variant);
begin
  if Assigned(FDeleteSQL) then FDeleteSQL.ExecCommand(AParams);
end;

procedure TADOManageOneRecord.Update(AParams: Variant);
begin
  if Assigned(FUpdateSQL) then FUpdateSQL.ExecCommand(AParams);
end;

{ TNativADOConnectionString }

constructor TNativADOConnectionString.Create(const AConnStr: string = '');
begin
  inherited Create();
  FConnStr := AConnStr;
end;

destructor TNativADOConnectionString.Destroy();
begin
  inherited;
end;

procedure TNativADOConnectionString.Assign(ASrc: TNativADOConnectionString);
begin
  FConnStr := ASrc.FConnStr;
  FUserName := ASrc.FUserName;
  FUserPass := ASrc.FUserPass;
end;

procedure TNativADOConnectionString.Assign(ASrc: string);
begin
  FConnStr := ASrc;
  FUserName := '';
  FUserPass := '';
end;

procedure TNativADOConnectionString.Make_MSAccess(const ADBPath: string; const ASysDBPath: string);
begin
  if (ASysDBPath <> '') then
    FConnStr := Format(conn_MSAccess, [ADBPath, ASysDBPath])
  else
    FConnStr := Format(conn_MSAccess_No_SysDB, [ADBPath]);
end;

procedure TNativADOConnectionString.Make_dBase_5_0(const ADBPath: string);
begin
  FConnStr := Format(conn_dBase_5_0, [ADBPath]);
end;

procedure TNativADOConnectionString.Make_Paradox_7_x(const ADBPath: string);
begin
  FConnStr := Format(conn_Paradox_7_x, [ADBPath]);
end;

procedure TNativADOConnectionString.Make_CSV_Text(const ADBPath: string);
begin
  FConnStr := Format(conn_CSV_Text, [ADBPath]);
end;

{ TNativADOConnection }

function TNativADOConnection.GetActive(): Boolean;
begin
  Result := (FConnection.State <> adStateClosed);
end;

function TNativADOConnection.TryLock(): Boolean;
begin
  Result := TryEnterCriticalSection(FMainCS);
end;

procedure TNativADOConnection.Lock();
begin
  EnterCriticalSection(FMainCS);
end;

procedure TNativADOConnection.UnLock();
begin
  LeaveCriticalSection(FMainCS);
end;

constructor TNativADOConnection.Create();
begin
  inherited Create();
  InitializeCriticalSection(FMainCS);
  FConnection := CoConnection.Create();
  FConnStr := TNativADOConnectionString.Create();
  FIsTransEnabled := False;
  FIsTransStarted := False;
end;

destructor TNativADOConnection.Destroy();
begin
  if Active then Close();
  FConnection := nil;
  FreeAndNil(FConnStr);
  DeleteCriticalSection(FMainCS);
  inherited;
end;

procedure TNativADOConnection.Open();
begin
  if Active then Close();
  EnterCriticalSection(FMainCS);
  try
    FConnection.Open(FConnStr.FConnStr, FConnStr.FUserName, FConnStr.FUserPass, 0);
    if (not Active) then raise Exception.Create(err_Connet_DB1);
    FIsTransEnabled := (FConnection.Properties['Transaction DDL'].Value <> 0);
    FIsTransStarted := False;
  except
    LeaveCriticalSection(FMainCS);
    raise;
  end;
  LeaveCriticalSection(FMainCS);
end;

procedure TNativADOConnection.Close();
begin
  if (not Active) then Exit;
  EnterCriticalSection(FMainCS);
  try
    RollbackTrans();
    FConnection.Close();
  except
  end;
  LeaveCriticalSection(FMainCS);
end;

function TNativADOConnection.ExecGetRecordset(const ACmdText: string; AParams: array of const): _Recordset;
var
  tmpVariant: OleVariant;
begin
  EnterCriticalSection(FMainCS);
  try
    Result := FConnection.Execute(Format(ACmdText, AParams), tmpVariant, adCmdText);
  except
    LeaveCriticalSection(FMainCS);
    raise;
  end;
  LeaveCriticalSection(FMainCS);
end;

function TNativADOConnection.ExecCommand(const ACmdText: string; AParams: array of const): integer;
var
  tmpVariant: OleVariant;
begin
  EnterCriticalSection(FMainCS);
  try
    FConnection.Execute(Format(ACmdText, AParams), tmpVariant, adCmdText + adExecuteNoRecords);
    Result := tmpVariant;
  except
    LeaveCriticalSection(FMainCS);
    raise;
  end;
  LeaveCriticalSection(FMainCS);
end;

procedure TNativADOConnection.BeginTrans();
begin
  if (not FIsTransEnabled) then Exit;
  EnterCriticalSection(FMainCS);
  try
    FConnection.BeginTrans();
    FIsTransStarted := True;
  except
    LeaveCriticalSection(FMainCS);
    raise;
  end;
  LeaveCriticalSection(FMainCS);
end;

procedure TNativADOConnection.RollbackTrans();
begin
  if (not FIsTransEnabled) then Exit;
  EnterCriticalSection(FMainCS);
  if FIsTransStarted then
  try
    FConnection.RollbackTrans();
    FIsTransStarted := False;
  except
    LeaveCriticalSection(FMainCS);
    raise;
  end;
  LeaveCriticalSection(FMainCS);
end;

procedure TNativADOConnection.CommitTrans();
begin
  if (not FIsTransEnabled) then Exit;
  EnterCriticalSection(FMainCS);
  if FIsTransStarted then
  try
    FConnection.CommitTrans();
    FIsTransStarted := False;
  except
    LeaveCriticalSection(FMainCS);
    raise;
  end;
  LeaveCriticalSection(FMainCS);
end;

function TNativADOConnection.GetParamSize(AType: DataTypeEnum): integer;
begin
  case AType of
    adDate:     Result := 8;
    adInteger:  Result := 4;
    adVarChar:  Result := 255;
    adVarWChar: Result := 255;
    adSingle:   Result := 4;
    adBoolean:  Result := 1;
    adTinyInt:  Result := 1;
  else
    Result := 0;
  end;
end;

{ TNativADOCommand }

constructor TNativADOCommand.Create(AConn: TNativADOConnection; const ACmdText: string);
begin
  inherited Create();
  FConn := AConn;
  FCommand := CoCommand.Create();
  FCommand.Set_ActiveConnection(FConn.Connection);
  FCommand.CommandType := adCmdText;
  FCommand.CommandText := ACmdText;
  FCommand.Prepared := True;
end;

destructor TNativADOCommand.Destroy();
begin
  FCommand := nil;
  inherited;
end;

function TNativADOCommand.GetParamsCount(): Integer;
begin
  Result := FCommand.Parameters.Count;
end;

function TNativADOCommand.GetParamByIndex(Index: integer): _Parameter;
begin
  Result := FCommand.Parameters[Index];
end;

function TNativADOCommand.GetParamByName(Index: string): _Parameter;
begin
  Result := FCommand.Parameters[Index];
end;

procedure TNativADOCommand.AddInputParam(const AName: string; AType: DataTypeEnum);
begin
  FCommand.Parameters.Append(FCommand.CreateParameter(AName, AType, adParamInput, FConn.GetParamSize(AType), null));
end;

function TNativADOCommand.ExecCommand(const AParams: Variant): integer;
var
  tmpVariant: OleVariant;
begin
  FConn.Lock();
  try
    FCommand.Execute(tmpVariant, AParams, adCmdText + adExecuteNoRecords);
    Result := tmpVariant;
  except
    FConn.UnLock();
    raise;
  end;
  FConn.UnLock();
end;

function TNativADOCommand.GetParamsValues(): Variant;
var
  n: integer;
begin
  if (ParamsCount <= 0) then
    Result := null
  else begin
    Result := VarArrayCreate([0, ParamsCount - 1], varVariant);
    for n:=0 to ParamsCount - 1 do
      Result[n] := ParamByIndex[n].Value;
  end;
end;

function TNativADOCommand.ExecCommand(): integer;
var
  tmpVariant: OleVariant;
begin
  FConn.Lock();
  try
    FCommand.Execute(tmpVariant, ParamsValues, adCmdText + adExecuteNoRecords);
    Result := tmpVariant;
  except
    FConn.UnLock();
    raise;
  end;
  FConn.UnLock();
end;

function TNativADOCommand.ExecGetRecordset(const AParams: Variant): _Recordset;
var
  tmpVariant: OleVariant;
begin
  FConn.Lock();
  try
    Result := FCommand.Execute(tmpVariant, AParams, adCmdText);
  except
    FConn.UnLock();
    raise;
  end;
  FConn.UnLock();  
end;

function TNativADOCommand.ExecGetRecordset(): _Recordset;
var
  tmpVariant: OleVariant;
begin
  FConn.Lock();
  try
    Result := FCommand.Execute(tmpVariant, ParamsValues, adCmdText);
  except
    FConn.UnLock();
    raise;
  end;
  FConn.UnLock();
end;

{ TNativADORecordset }

constructor TNativADORecordset.Create(AConn: TNativADOConnection; const ACmdText: string);
var
  n: integer;
begin
  inherited Create();
  FConn := AConn;
  FStandartFields := TStringList.Create();
  FCalclFields := TStringList.Create();
  FRecordset := FConn.ExecGetRecordset(ACmdText, []);
  for n:=0 to FRecordset.Fields.Count - 1 do
    FStandartFields.Add(FRecordset.Fields[n].Name);
  First();
end;

constructor TNativADORecordset.Create(ACommand: TNativADOCommand);
var
  n: integer;
begin
  inherited Create();
  FConn := ACommand.FConn;
  FStandartFields := TStringList.Create();
  FCalclFields := TStringList.Create();
  FRecordset := ACommand.ExecGetRecordset();
  for n:=0 to FRecordset.Fields.Count - 1 do
    FStandartFields.Add(FRecordset.Fields[n].Name);
  First();
end;

destructor TNativADORecordset.Destroy();
begin
  FRecordset := nil;
  FreeAndNil(FCalclFields);
  FreeAndNil(FStandartFields);
  inherited;
end;

procedure TNativADORecordset.AddCalcField(const AName: string; AType: DataTypeEnum);
begin
  FCalclFields.AddObject(AName, Pointer(AType));
end;

function TNativADORecordset.GetFieldsCount(): integer;
begin
  Result := FStandartFields.Count + FCalclFields.Count;
end;

function TNativADORecordset.GetFieldsName(Index: integer): string;
begin
  if (Index < FStandartFields.Count) then
    Result := FStandartFields[Index]
  else
    Result := FCalclFields[Index - FStandartFields.Count];
end;

function TNativADORecordset.GetFieldsType(Index: string): DataTypeEnum;
begin
  try
    if (FCalclFields.IndexOf(Index) >= 0) then
      Result := Integer(FCalclFields.Objects[FCalclFields.IndexOf(Index)])
    else
      Result := FRecordset.Fields[Index].Type_;
  except
    raise Exception.Create('GetFieldsType: ' + Index);
  end;
end;

function TNativADORecordset.GetValueAsInteger(Index: string): integer;
begin
  Result := 0;
  try
    Result := GetValueAsVariant(Index);
  except
  end;
end;

function TNativADORecordset.GetValueAsString(Index: string): string;
begin
  Result := '';
  try
    Result := GetValueAsVariant(Index);
  except
  end;
end;

function TNativADORecordset.GetValueAsDouble(Index: string): Double;
begin
  Result := 0;
  try
    Result := GetValueAsVariant(Index);
  except
  end;
end;

function TNativADORecordset.GetValueAsVariant(Index: string): Variant;
var
  tmpField: Field;
begin
  if (FCalclFields.IndexOf(Index) >= 0) then
    Result := DoGetCalcFieldValue(Index)
  else
  begin
    tmpField := FRecordset.Fields[Index];
    Result := tmpField.Value;
  end;
end;

function TNativADORecordset.DoGetCalcFieldValue(const AName: string): Variant;
begin
  Result := null;
end;

function TNativADORecordset.GetFieldsValues(): Variant;
var
  n: integer;
begin
  Result := VarArrayCreate([0, FieldsCount - 1], varVariant);
  for n:=0 to FieldsCount - 1 do
    Result[n] := ValueAsVariant[FieldsName[n]];
end;

function TNativADORecordset.GetFiledsValues(AFieldList: TStringList): Variant;
var
  n: integer;
begin
  Result := VarArrayCreate([0, AFieldList.Count - 1], varVariant);
  for n:=0 to AFieldList.Count - 1 do
    Result[n] := ValueAsVariant[AFieldList.Names[n]];
end;

procedure TNativADORecordset.Next();
begin
  try
    FRecordset.MoveNext();
  except
  end;
  DoCalcField();
end;

procedure TNativADORecordset.First();
begin
  try
    FRecordset.MoveFirst();
  except
  end;
  DoCalcField();
end;

procedure TNativADORecordset.Last();
begin
  try
    FRecordset.MoveLast();
  except
  end;
  DoCalcField();
end;

procedure TNativADORecordset.Previous();
begin
  try
    FRecordset.MovePrevious();
  except
  end;
  DoCalcField();
end;

function TNativADORecordset.GetEOF(): Boolean;
begin
  Result := FRecordset.Eof;
end;

function TNativADORecordset.GetBOF(): Boolean;
begin
  Result := FRecordset.Bof;
end;

procedure TNativADORecordset.DoCalcField();
begin
end;

{ TADORemoteInsert }

constructor TADORemoteInsert.Create(AConn: TNativADOConnection; const ARemoteTableName: string; AFieldList: TStringList; AFieldType: array of DataTypeEnum);
var
  tmpStr: string;
  tmpStr1: string;
  n: integer;
begin
  inherited Create();
  FFieldList := TStringList.Create();
  FFieldList.AddStrings(AFieldList);
  FCommand := CoCommand.Create();
  FCommand.Set_ActiveConnection(AConn.Connection);
  FCommand.CommandType := adCmdText;
  // Формирование команды
  tmpStr := '';
  tmpStr1 := '';
  for n:=0 to FFieldList.Count - 1 do
  begin
    if (tmpStr <> '') then tmpStr := tmpStr + ', ';
    tmpStr := tmpStr + FFieldList.Values[FFieldList.Names[n]];
    if (tmpStr1 <> '') then tmpStr1 := tmpStr1 + ',';
    tmpStr1 := tmpStr1 + '?';
  end;
  FCommand.CommandText := 'insert into ' + ARemoteTableName + ' (' + tmpStr + ') values (' + tmpStr1 + ')';
  // Добавим необходимые параметры
  for n:=0 to FFieldList.Count - 1 do
  begin
    tmpStr := FFieldList.Names[n];
    FCommand.Parameters.Append(FCommand.CreateParameter('prm_' + FFieldList.Values[tmpStr], AFieldType[n], adParamInput, AConn.GetParamSize(AFieldType[n]), null));
  end;
  // Подготовим
  FCommand.Prepared := True;
end;

procedure TADORemoteInsert.InsertCurrent(AValue: Variant);
var
  tmpVariant: OleVariant;
begin
  FCommand.Execute(tmpVariant, AValue, adCmdText + adExecuteNoRecords);
end;

destructor TADORemoteInsert.Destroy();
begin
  FCommand := nil;
  FreeAndNil(FFieldList);
  inherited;
end;

end.
