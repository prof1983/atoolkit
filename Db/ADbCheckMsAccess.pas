{**
@Abstract(Главный объект проверки БД)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.04.2006)
@LastMod(03.07.2012)
@Version(0.5)

Как получить последнюю версию пакета обновлений для Microsoft Jet 4.0 Database Engine
http://support.microsoft.com/kb/239114/ru
}
unit ADbCheckMsAccess;

interface

uses
  ActiveX, AdoInt, AdoX, SysUtils, Variants,
  ABaseObjectImpl, ADbCheckConst, ADbGlobalsObj, ADbTypes, ATypes,
  ADbDescFields, ADbDescTable;

// Интерфейсные функции --------------------------------------------------------
//** Проверить пользователя БД
function CheckDBUser (const ADBDataFile: WideString; AFunc: TAddToLogProc): boolean; stdcall;
//** Проверить структуру таблиц и полей в БД
function CheckDBData (const ADBDataFile: WideString; ADBMain: PDBMain; AFunc: TAddToLogProc): boolean; stdcall;
//** Создать описание таблиц и полей БД
function CheckDBDescr(const ADBDescrFile: WideString; ADBMain: PDBMain; AFunc: TAddToLogProc): boolean; stdcall;

// Интерфейсные функции --------------------------------------------------------
//** Проверить пользователя БД
function MSAccess_CheckUser (const ADBDataFile: WideString; AFunc: TAddToLogProc): boolean; stdcall;
//** Проверить структуру таблиц и полей в БД
function MSAccess_CheckData (const ADBDataFile: WideString; ADBMain: PDBMain; AFunc: TAddToLogProc): boolean; stdcall;
//** Создать описание таблиц и полей БД
function MSAccess_CheckDescr(const ADBDescrFile: WideString; ADBMain: PDBMain; AFunc: TAddToLogProc): boolean; stdcall;

implementation

type //** Для работы с таблицами описаний
  TTableDescrTable = class(TADOManageOneRecord)
  public
    constructor Create(AConn: TNativADOConnection);
  end;

type //** Для работы с таблицами описаний
  TTableDescrField = class(TADOManageOneRecord)
  public
    constructor Create(AConn: TNativADOConnection);
  end;

type //** Для работы с таблицами описаний
  TTableJoinTable = class(TADOManageOneRecord)
  public
    constructor Create(AConn: TNativADOConnection);
  end;

type //** Выполняет проверку базы данных MSAccess и необходимых таблиц
  TCheckAccessDB = class(TProfBaseObject)
  private
    FadoShema: _Catalog;
    FMainConn: TNativADOConnection;
    FCurrDBFileName: string;
    FDescrTable: TTableDescrTable;
    FDescrField: TTableDescrField;
    FJoinTable: TTableJoinTable;
  private
    procedure CreateAccessDB(const ADBDataFile: string);
    procedure CreateAccessSysDB(const ADBSysFile: string);
    function GetSQLType(const AFieldsDesc: TFieldRec): string;
    function CheckDataTable(const ATableDesc: TTableRec): boolean;
    function CheckDataView(const AViewDesc: TViewRec): boolean;
    function CheckDescTable(const ATableDesc: TTableRec): boolean;
    function CheckDescView(const AViewDesc: TViewRec): boolean;
  public
    constructor Create();
    destructor Destroy(); override;
  public
    function CheckDBUser(const ADBDataFile, ADbSysDataFile: string): Boolean;
    function CheckDBData(const ADBDataFile: string; ADBMain: PDBMain): boolean;
    function CheckDBDescr(const ADBDescrFile: string; ADBMain: PDBMain): boolean;
  end;

const // -----------------------------------------------------------------------
  DB_GUEST_GROUP          = 'Users';
  DB_GUEST_NAME           = 'Guest';
  DB_ADMIN_GROUP          = 'Admins';
  DB_ADMIN_NAME           = 'Admin';
  DB_ADMIN_PASSWORD       = DB_USERPASSWORD + 'admin';
  DB_USER_UNIQUM_ID       = 'h87fh7sh87gr98fwhgfd';
const // -----------------------------------------------------------------------
  info_StartCheckUser    = '"%s". Старт проверки пользователей.';
  info_StartDataDB       = '"%s". Старт проверки структуры.';
  info_StartDescrDB      = '"%s". Старт проверки описания.';
  info_CreateDataDB      = '"%s". Файла базы данных создан успешно.';
  info_CreateSysDB       = '"%s". Файла системной базы данных создан успешно: sys_db - "%s".';
  info_CreateARUser   = '"%s". В базу добавлен новый пользователь: user - "%s".';
  info_AddUserToAdmins   = '"%s". Пользователь добавлен в группу: group - "%s", user - "%s".';
  info_CheckUserSucc     = '"%s". Проверка пользователей успешно завершена.';
  info_CheckDataDBSucc   = '"%s". Проверка структуры успешно завершена.';
  info_CheckDescrDBSucc  = '"%s". Проверка описаний успешно завершена.';
  info_CreateTable       = '"%s". Создана новая таблица: "%s".';
  info_AddColumn         = '"%s". "%s". В таблицу добавленно новое поле: "%s".';
  info_CreateIndex       = '"%s". "%s". В таблице создан новый индекс: "%s".';
  info_CreateView        = '"%s". Создано новое представление: "%s".';
const // -----------------------------------------------------------------------
  err_CheckUser          = '"%s". Ошибка проверки пользователей: "%s".';
  err_CheckDataDB        = '"%s". Ошибка проверки структуры: "%s".';
  err_CheckDescDB        = '"%s". Ошибка проверки описания: "%s".';
  err_CheckTable         = '"%s". "%s". Ошибка проверки таблицы: "%s".';
  err_CheckView          = '"%s". "%s". Ошибка проверки представления: "%s".';
  err_CheckTableDesc     = '"%s". "%s". Ошибка проверки описаний таблицы: "%s".';
  err_CheckViewDesc      = '"%s". "%s". Ошибка проверки описаний пердставления: "%s".';
const // -----------------------------------------------------------------------------
  sql_Create_New_User         = 'create user %s %s %s';
  sql_Add_Column              = 'alter table %s add column %s %s';
  sql_RevokeAllPriv           = 'revoke all privileges on table %s from %s';
  sql_GrantSelect             = 'grant SELECT, SELECTSCHEMA on table %s to %s';
  sql_GrantUpdate             = 'grant SELECT, SELECTSCHEMA, INSERT, UPDATE, DELETE on table %s to %s';
  sql_DropView                = 'drop view %s';
  sql_DeleteDescrField        = 'delete from '+DescField+' where ID_TABLE=(select max(ID) from '+DescTable+' where '+DescTableTblName+'=''%s'')';
  sql_DeleteTableDescr        = 'delete from '+DescTable+' where '+DescTableTblName+'=''%s''';
  sql_InsertAR_DESC_TABLE    = 'insert into '+DescTable+'('+DescTableTblName+', '+DescTableTblDesc+') values(?, ?)';
  sql_SelectAR_DESC_TABLE    = 'select ID from '+DescTable+' where '+DescTableTblName+'=?';
  sql_InsertAR_DESC_FIELD    = 'insert into '+DescField+'('+Desc_ID_TABLE+', '+Desc_TBL_NAME+', '+Desc_FLD_NAME+', '+Desc_FLD_DESC+', '+Desc_FLD_SELECT+', '+Desc_FLD_SEARCH+', '+Desc_FLD_SORT+', '+Desc_FLD_PARAM+', '+Desc_FLD_REQUER+', '+Desc_FLD_TYPE+') values(?, ?, ?, ?, ''T'', ''T'', ''T'', ''F'', ''F'', ?)';
  sql_SelectAR_DESC_FIELD    = 'select '+Desc_TBL_NAME+', '+Desc_FLD_NAME+' from '+DescField+' where '+Desc_ID_TABLE+'=? and '+Desc_FLD_NAME+'=?';
  sql_InsertAR_TABLE_JOIN    = 'insert into AR_TABLE_JOIN(TBL_NAME_1, TBL_NAME_2, JOIN_TYPE, FLD_NAME_1, FLD_NAME_2, OPERATORS) values(?, ?, ?, ?, ?, ?)';
  sql_SelectAR_TABLE_JOIN    = 'select TBL_NAME_1, TBL_NAME_2 from AR_TABLE_JOIN where TBL_NAME_1=? and TBL_NAME_2=? and FLD_NAME_1=? and FLD_NAME_2=?';
  slq_SetDefaultValue         = 'update %s set %s = %s';

// -----------------------------------------------------------------------------

function CheckDBUser(const ADBDataFile: WideString; AFunc: TAddToLogProc): Boolean;
var
  tmpCheck: TCheckAccessDB;
  Path: String;
begin
  tmpCheck := TCheckAccessDB.Create();
  try
    tmpCheck.OnAddToLog := AFunc;
    Path := ExtractFilePath(ADbDataFile);
    Result := tmpCheck.CheckDBUser(ADbDataFile, Path + 'ar.mdw');
  finally
    FreeAndNil(tmpCheck);
  end;
end;

function CheckDBData(const ADBDataFile: WideString; ADBMain: PDBMain; AFunc: TAddToLogProc): Boolean;
var
  tmpCheck: TCheckAccessDB;
begin
  tmpCheck := TCheckAccessDB.Create();
  try
    tmpCheck.OnAddToLog := AFunc;
    Result := tmpCheck.CheckDBData(ADBDataFile, ADBMain);
  finally
    FreeAndNil(tmpCheck);
  end;
end;

function CheckDBDescr(const ADBDescrFile: WideString; ADBMain: PDBMain; AFunc: TAddToLogProc): boolean;
var
  tmpCheck: TCheckAccessDB;
begin
  tmpCheck := TCheckAccessDB.Create();
  try
    tmpCheck.OnAddToLog := AFunc;
    Result := tmpCheck.CheckDBDescr(ADBDescrFile, ADBMain);
  finally
    FreeAndNil(tmpCheck);
  end;
end;

// Интерфейсные функции MSAccess -----------------------------------------------
// Проверить пользователя БД
function MSAccess_CheckUser(const ADBDataFile: WideString; AFunc: TAddToLogProc): boolean;
begin
  Result := CheckDBUser(ADBDataFile, AFunc);
end;

// Проверить структуру таблиц и полей в БД
function MSAccess_CheckData (const ADBDataFile: WideString; ADBMain: PDBMain; AFunc: TAddToLogProc): boolean;
begin
  Result := CheckDBData(ADBDataFile, ADBMain, AFunc);
end;

// Создать описание таблиц и полей БД
function MSAccess_CheckDescr(const ADBDescrFile: WideString; ADBMain: PDBMain; AFunc: TAddToLogProc): boolean;
begin
  Result := CheckDBDescr(ADBDescrFile, ADBMain, AFunc);
end;

{ TTableDescrTable }

constructor TTableDescrTable.Create(AConn: TNativADOConnection);
begin
  inherited;
  MakeCommandSelect(sql_SelectAR_DESC_TABLE);
  with SelectSQL do
  begin
    AddInputParam('prm_tbl_name', adVarChar);
  end;
  MakeCommandInsert(sql_InsertAR_DESC_TABLE);
  with InsertSQL do
  begin
    AddInputParam('prm_tbl_name', adVarChar);
    AddInputParam('prm_tbl_descr', adVarChar);
  end;
end;

{ TTableDescrField }

constructor TTableDescrField.Create(AConn: TNativADOConnection);
begin
  inherited;
  MakeCommandSelect(sql_SelectAR_DESC_FIELD);
  with SelectSQL do
  begin
    AddInputParam('prm_tbl_id', adInteger);
    AddInputParam('prm_fld_name', adVarChar);
  end;
  MakeCommandInsert(sql_InsertAR_DESC_FIELD);
  with InsertSQL do
  begin
    AddInputParam('prm_tbl_id', adInteger);
    AddInputParam('prm_tbl_name', adVarChar);
    AddInputParam('prm_fld_name', adVarChar);
    AddInputParam('prm_fld_descr', adVarChar);
    AddInputParam('prm_fld_type', adVarChar);
  end;
end;

{ TTableJoinTable }

constructor TTableJoinTable.Create(AConn: TNativADOConnection);
begin
  inherited;
  MakeCommandSelect(sql_SelectAR_TABLE_JOIN);
  with SelectSQL do
  begin
    AddInputParam('prm_tbl_name_1', adVarChar);
    AddInputParam('prm_tbl_name_2', adVarChar);
    AddInputParam('prm_fld_name_1', adVarChar);
    AddInputParam('prm_fld_name_2', adVarChar);
  end;
  MakeCommandInsert(sql_InsertAR_TABLE_JOIN);
  with InsertSQL do
  begin
    AddInputParam('prm_tbl_name_1', adVarChar);
    AddInputParam('prm_tbl_name_2', adVarChar);
    AddInputParam('prm_join', adVarChar);
    AddInputParam('prm_fld_name_1', adVarChar);
    AddInputParam('prm_fld_name_2', adVarChar);
    AddInputParam('prm_operator', adVarChar);
  end;
end;

{ TCheckAccessDB }

constructor TCheckAccessDB.Create();
begin
  inherited;
  CoInitialize(nil);
end;

destructor TCheckAccessDB.Destroy();
begin
  CoUnInitialize;
  inherited;
end;

function TCheckAccessDB.CheckDBUser(const ADBDataFile, ADbSysDataFile: string): boolean;
var
  tmpChangeAdminPwd: boolean;
begin
  tmpChangeAdminPwd := False;
  Result := False;
  try
    FCurrDBFileName := ExtractFileName(ADBDataFile);
    AddToLog(lgDataBase, ltInformation, Format(info_StartCheckUser, [FCurrDBFileName]));
    // Проверим наличие файлов
    if not(FileExists(ADbDataFile)) then
      CreateAccessDB(ADbDataFile);
    // Подключаемся к БД
    FMainConn := TNativADOConnection.Create();
    try
      FMainConn.ConnectionString.Make_MSAccess(ADbDataFile, ADbSysDataFile);
      //FMainConn.ConnectionString.ConnectionString := Format(conn_MsAccess_NoSysDb_NoSecurity, [ADbDataFile]);
      //'Provider=Microsoft.Jet.OLEDB.4.0; Data Source=' + ADbDataFile + ';Jet OLEDB:Engine Type=5;';
      FMainConn.ConnectionString.UserName := DB_ADMIN_NAME;
      FMainConn.ConnectionString.UserPass := DB_ADMIN_PASSWORD;
      try
        FMainConn.Open();
      except
        FMainConn.ConnectionString.UserName := DB_ADMIN_NAME;
        FMainConn.ConnectionString.UserPass := '';
        FMainConn.Open();
        tmpChangeAdminPwd := True;
      end;
      FadoShema := CoCatalog.Create();
      // Устанавливаем активное соединение
      FadoShema.Set_ActiveConnection(FMainConn.Connection);
      // Проверяем наличие пароля у пользователя Admin
      if tmpChangeAdminPwd then
        FadoShema.Users[DB_ADMIN_NAME].ChangePassword('', DB_ADMIN_PASSWORD);
      // Проверяем наличие пользователя AR
      try
        FadoShema.Users[DB_USERNAME];
      except
        FMainConn.ExecCommand(sql_Create_New_User, [DB_USERNAME, DB_USERPASSWORD, DB_USER_UNIQUM_ID]);
        AddToLog(lgDataBase, ltInformation, Format(info_CreateARUser, [FCurrDBFileName, DB_USERNAME]));
      end;
      FadoShema.Users.Refresh();
      // Проверяем на вхождение пользователя AR в группу администраторов
      try
        FadoShema.Groups[DB_ADMIN_GROUP].Users[DB_USERNAME];
      except
        FadoShema.Users[DB_USERNAME].Groups.Append(DB_ADMIN_GROUP);
        AddToLog(lgDataBase, ltInformation, Format(info_AddUserToAdmins, [FCurrDBFileName, DB_ADMIN_GROUP, DB_USERNAME]));
      end;
      // Проверяем наличие пользователя Guest
      try
        FadoShema.Users[DB_GUEST_NAME];
      except
        FadoShema.Users.Append(DB_GUEST_NAME, '');
        AddToLog(lgDataBase, ltInformation, Format(info_CreateARUser, [FCurrDBFileName, DB_GUEST_NAME]));
        FadoShema.Users[DB_GUEST_NAME].Groups.Append(DB_GUEST_GROUP);
        AddToLog(lgDataBase, ltInformation, Format(info_AddUserToAdmins, [FCurrDBFileName, DB_GUEST_GROUP, DB_GUEST_NAME]));
      end;
      // Устанавливаем права для пользователя AR
      FadoShema.Users[DB_USERNAME].SetPermissions('', adPermObjTable, adAccessSet, adRightFull, adInheritNone, null);
      // Все ОК
      AddToLog(lgDataBase, ltInformation, Format(info_CheckUserSucc, [FCurrDBFileName]));
    finally
      FadoShema := nil;
      FreeAndNil(FMainConn);
    end;
    Result := True;
  except
    on E: Exception do AddToLog(lgDataBase, ltError, Format(err_CheckUser, [FCurrDBFileName, E.Message]));
  end;
end;

function TCheckAccessDB.CheckDBData(const ADBDataFile: string; ADBMain: PDBMain): boolean;
var
  n: integer;
begin
  Result := False;
  try
    FCurrDBFileName := ExtractFileName(ADBDataFile);
    AddToLog(lgDataBase, ltInformation, Format(info_StartDataDB, [FCurrDBFileName]));
    // Проверим наличие файлов
    if not FileExists(ADBDataFile) then
      CreateAccessDB(ADBDataFile);
    // Подключаемся к БД
    FMainConn := TNativADOConnection.Create();
    try
      FMainConn.ConnectionString.Make_MSAccess(ADBDataFile, '');
      FMainConn.Open();
      FadoShema := CoCatalog.Create();
      // Устанавливаем активное соединение
      FadoShema.Set_ActiveConnection(FMainConn.Connection);
      Result := True;
      // пройдемся по всем таблицам
      for n:=0 to ADBMain.dbTablesCount - 1 do
        Result := CheckDataTable(ADBMain.dbTables[n]^) and Result;
      // пройдемся по всем представлениям
      for n:=0 to ADBMain.dbViewsCount - 1 do
        Result := CheckDataView(ADBMain.dbViews[n]^) and Result;
      // Все ОК
      AddToLog(lgDataBase, ltInformation, Format(info_CheckDataDBSucc, [FCurrDBFileName]));
    finally
      FadoShema := nil;
      FreeAndNil(FMainConn);
    end;
  except
    on E: Exception do AddToLog(lgDataBase, ltError, err_CheckDataDB); //[FCurrDBFileName, E.Message]);
  end;
end;

function TCheckAccessDB.CheckDBDescr(const ADBDescrFile: string; ADBMain: PDBMain): boolean;
var
  n: integer;
begin
  Result := False;
  try
    FCurrDBFileName := ExtractFileName(ADBDescrFile);
    AddToLog(lgDataBase, ltInformation, info_StartDescrDB); //[FCurrDBFileName]);
    // Проверим наличие файлов
    if not FileExists(ADBDescrFile) then
      CreateAccessDB(ADBDescrFile);
    // Подключаемся к БД
    FMainConn := TNativADOConnection.Create();
    try
      FMainConn.ConnectionString.Make_MSAccess(ADBDescrFile, '');
      FMainConn.Open();
      FadoShema := CoCatalog.Create();
      // Устанавливаем активное соединение
      FadoShema.Set_ActiveConnection(FMainConn.Connection);
      Result := True;
      // Создаем управление таблицами
      FDescrTable := TTableDescrTable.Create(FMainConn);
      FDescrField := TTableDescrField.Create(FMainConn);
      FJoinTable := TTableJoinTable.Create(FMainConn);
      // пройдемся по всем таблицам
      for n:=0 to ADBMain.dbTablesCount - 1 do
        Result := CheckDescTable(ADBMain.dbTables[n]^) and Result;
      // пройдемся по всем представлениям
      for n:=0 to ADBMain.dbViewsCount - 1 do
        Result := CheckDescView(ADBMain.dbViews[n]^) and Result;
      // Все ОК
      AddToLog(lgDataBase, ltInformation, Format(info_CheckDescrDBSucc, [FCurrDBFileName]));
    finally
      if Assigned(FDescrTable) then FreeAndNil(FDescrTable);
      if Assigned(FDescrField) then FreeAndNil(FDescrField);
      if Assigned(FJoinTable) then FreeAndNil(FJoinTable);
      FadoShema := nil;
      FreeAndNil(FMainConn);
    end;
    Result := True;
  except
    on E: Exception do AddToLog(lgDataBase, ltError, Format(err_CheckDescDB, [FCurrDBFileName, E.Message]));
  end;
end;

procedure TCheckAccessDB.CreateAccessDB(const ADBDataFile: string);
var
  adoShem: _Catalog;
begin
  try
    ForceDirectories(ExtractFilePath(ADBDataFile));
    adoShem := CoCatalog.Create();
    adoShem.Create('Provider=Microsoft.Jet.OLEDB.4.0; Data Source=' + ADBDataFile + ';Jet OLEDB:Engine Type=5;');
    AddToLog(lgDataBase, ltInformation, Format(info_CreateDataDB, [ExtractFileName(ADBDataFile)]));
  finally
    adoShem := nil;
  end;
end;

procedure TCheckAccessDB.CreateAccessSysDB(const ADBSysFile: string);
var
  adoShem: _Catalog;
begin
  try
    ForceDirectories(ExtractFilePath(ADBSysFile));
    adoShem := CoCatalog.Create();
    adoShem.Create('Provider=Microsoft.Jet.OLEDB.4.0; Data Source=' + ADBSysFile + '; Jet OLEDB:Create System Database=True;Jet OLEDB:Engine Type=5;');
    AddToLog(lgDataBase, ltInformation, Format(info_CreateSysDB, [FCurrDBFileName, ExtractFileName(ADBSysFile)]));
  finally
    adoShem := nil;
  end;
end;

function TCheckAccessDB.GetSQLType(const AFieldsDesc: TFieldRec): string;
begin
  Result := STR_FIELD_SQL_TYPE[AFieldsDesc.fldType];
  case AFieldsDesc.fldType of
    ftString,
    ftFixedChar,
    ftWideString: Result := Result + '(' + IntToStr(AFieldsDesc.fldSize) + ')';
  end;
  if (AFieldsDesc.fldNotNull) then
    Result := Result + ' not null';
end;

function TCheckAccessDB.CheckDataTable(const ATableDesc: TTableRec): boolean;
var
  n: integer;
  S: string;
begin
  Result := False;
  try
    // Проверяем существование таблицы
    try
      FadoShema.Tables[ATableDesc.tblName];
    except
      // таблица не существует создаем
      S := 'create table ' + ATableDesc.tblName + ' (';
      for n:=0 to ATableDesc.tblFieldsCount - 1 do
      begin
        S := S + ATableDesc.tblFields[n].fldName + ' ' + GetSQLType(ATableDesc.tblFields[n]);
        if (ATableDesc.tblFields[n].fldDefault <> '') then S := S + ' default ' + ATableDesc.tblFields[n].fldDefault;
        if (n <> (ATableDesc.tblFieldsCount - 1)) then S := S + ', ';
      end;
      S := S + ')';
      // Создаем таблицу
      FMainConn.ExecCommand(S, []);
      FadoShema.Tables.Refresh();
      AddToLog(lgDataBase, ltInformation, info_CreateTable); //[FCurrDBFileName, ATableDesc.tblName]);
    end;
    // Проверим на добавление полей
    for n:=0 to ATableDesc.tblFieldsCount - 1 do
    try
      FadoShema.Tables[ATableDesc.tblName].Columns[ATableDesc.tblFields[n].fldName];
    except
      // Если не нашли,  то добавляем
      S := Format(sql_Add_Column, [ATableDesc.tblName, ATableDesc.tblFields[n].fldName, GetSQLType(ATableDesc.tblFields[n])]);
      if (ATableDesc.tblFields[n].fldDefault <> '') then S := S + ' default ' + ATableDesc.tblFields[n].fldDefault;
      FMainConn.ExecCommand(S, []);
      // Если есть значение по умолчанию, то устанавливаем
      if (ATableDesc.tblFields[n].fldDefault <> '') then
        FMainConn.ExecCommand(slq_SetDefaultValue, [ATableDesc.tblName, ATableDesc.tblFields[n].fldName, ATableDesc.tblFields[n].fldDefault]);
      AddToLog(lgDataBase, ltInformation, info_AddColumn); //[FCurrDBFileName, ATableDesc.tblName, ATableDesc.tblFields[n].fldName]);
    end;
    // Проверяем индексы
    for n:=0 to ATableDesc.tblIndexsCount - 1 do
    try
      FadoShema.Tables[ATableDesc.tblName].Indexes[ATableDesc.tblIndexs[n].idxName];
    except
      // Если не найден,  то создаем
      S := 'create ';
      if (ATableDesc.tblIndexs[n].idxType = idxUniqum) then S := S + 'unique ';
      S := S + 'index ' + ATableDesc.tblIndexs[n].idxName + ' on ' + ATableDesc.tblName + ' (' + ATableDesc.tblIndexs[n].idxField + ')';
      if (ATableDesc.tblIndexs[n].idxType = idxPrimary) then S := S + ' with PRIMARY';
      FMainConn.ExecCommand(S, []);
      AddToLog(lgDataBase, ltInformation, info_CreateIndex); //[FCurrDBFileName, ATableDesc.tblName, ATableDesc.tblIndexs^[n].idxName]);
    end;
    // Устанавливаем доступ всегда т.к. проблемы с получением текущего значения
    // Все ОК
    Result := True;
  except
    on E: Exception do AddToLog(lgDataBase, ltError, err_CheckTable); //[FCurrDBFileName, ATableDesc.tblName, E.Message]);
  end;
end;

function TCheckAccessDB.CheckDataView(const AViewDesc: TViewRec): boolean;
var
  tmpIsCreateView: boolean;
  tmpIsDropView: boolean;
var
  n: integer;
  S: string;
begin
  tmpIsCreateView := False;
  tmpIsDropView := False;
  Result := False;
  try
    // Проверим на существование
    try
      FadoShema.Tables[AViewDesc.vewName];
    except
      tmpIsCreateView := True;
    end;
    // Проверим на количество полей
    if (not tmpIsCreateView) then
      if (FadoShema.Tables[AViewDesc.vewName].Columns.Count <> AViewDesc.vewFieldsCount) then
        tmpIsDropView := True;
    // Проверим на наименования полей
    if (not tmpIsCreateView)and(not tmpIsDropView) then
      for n:=0 to FadoShema.Tables[AViewDesc.vewName].Columns.Count - 1 do
      try
        FadoShema.Tables[AViewDesc.vewName].Columns[AViewDesc.vewFields[n].fldName];
      except
        tmpIsDropView := True;
      end;
    // Если необходимо, то удаляем представление
    if tmpIsDropView then
    begin
      FMainConn.ExecCommand(sql_DropView, [AViewDesc.vewName]);
      try
        FMainConn.ExecCommand(sql_DeleteDescrField, [AViewDesc.vewName]);
        FMainConn.ExecCommand(sql_DeleteTableDescr, [AViewDesc.vewName]);
      except
      end;
      tmpIsCreateView := True;
    end;
    // Если необходимо, то создаем заново
    if tmpIsCreateView then
    begin
      S := 'create view ' + AViewDesc.vewName + ' (';
      for n:=0 to AViewDesc.vewFieldsCount - 1 do
      begin
        S := S + AViewDesc.vewFields^[n].fldName;
        if (n <> (AViewDesc.vewFieldsCount - 1)) then S := S + ', ';
      end;
      S := S + ') as ' + AViewDesc.vewSQLCreate;
      FMainConn.ExecCommand(S, []);
      AddToLog(lgDataBase, ltInformation, info_CreateView); //[FCurrDBFileName, AViewDesc.vewName]);
    end;
    // Все ОК
    Result := True;
  except
    on E: Exception do AddToLog(lgDataBase, ltError, err_CheckView); //[FCurrDBFileName, AViewDesc.vewName, E.Message]);
  end;
end;

function TCheckAccessDB.CheckDescTable(const ATableDesc: TTableRec): boolean;
var
  tmpTblID: integer;
  n: integer;
begin
  Result := False;
  try
    // Проверим на добавление в описание таблицы
    if not FDescrTable.CheckExist(VarArrayOf([ATableDesc.tblName])) then
    begin
      if (ATableDesc.tblDescription = '') then
        FDescrTable.Insert(VarArrayOf([ATableDesc.tblName, ATableDesc.tblName]))
      else
        FDescrTable.Insert(VarArrayOf([ATableDesc.tblName, ATableDesc.tblDescription]));
    end;
    // Получим ID таблицы
    tmpTblID := FDescrTable.GetValues(VarArrayOf([ATableDesc.tblName]))[0];
    // Проверим описания полей
    for n:=0 to ATableDesc.tblFieldsCount - 1 do
      if not FDescrField.CheckExist(VarArrayOf([tmpTblID, ATableDesc.tblFields[n].fldName])) then
      begin
        if (ATableDesc.tblFields[n].fldDescription = '') then
          FDescrField.Insert(VarArrayOf([tmpTblID, ATableDesc.tblName, ATableDesc.tblFields[n].fldName, ATableDesc.tblFields^[n].fldName, STR_FIELD_REPORT_TYPE[ATableDesc.tblFields[n].fldType]]))
        else
          FDescrField.Insert(VarArrayOf([tmpTblID, ATableDesc.tblName, ATableDesc.tblFields[n].fldName, ATableDesc.tblFields^[n].fldDescription, STR_FIELD_REPORT_TYPE[ATableDesc.tblFields[n].fldType]]));
      end;
    // Проверим обьединения
    for n:=0 to ATableDesc.tblJoinsCount - 1 do
      if not FJoinTable.CheckExist(VarArrayOf([ATableDesc.tblName, ATableDesc.tblJoins[n].jnTable, ATableDesc.tblJoins[n].jnFieldIn, ATableDesc.tblJoins[n].jnFieldOut])) then
        FJoinTable.Insert(VarArrayOf([ATableDesc.tblName, ATableDesc.tblJoins[n].jnTable, STR_JOIN_TYPE[ATableDesc.tblJoins[n].jnType], ATableDesc.tblJoins[n].jnFieldIn, ATableDesc.tblJoins[n].jnFieldOut, ATableDesc.tblJoins[n].jnOperator]));
    // Все ОК
    Result := True;
  except
    on E: Exception do AddToLog(lgDataBase, ltError, err_CheckTableDesc); //[FCurrDBFileName, ATableDesc.tblName, E.Message]);
  end;
end;

function TCheckAccessDB.CheckDescView(const AViewDesc: TViewRec): boolean;
var
  tmpTblID: integer;
  n: integer;
begin
  Result := False;
  try
    // Проверим на добавление в описание таблицы
    if not FDescrTable.CheckExist(VarArrayOf([AViewDesc.vewName])) then
    begin
      if (AViewDesc.vewDescription = '') then
        FDescrTable.Insert(VarArrayOf([AViewDesc.vewName, AViewDesc.vewName]))
      else
        FDescrTable.Insert(VarArrayOf([AViewDesc.vewName, AViewDesc.vewDescription]));
    end;
    // Получим ID таблицы
    tmpTblID := FDescrTable.GetValues(VarArrayOf([AViewDesc.vewName]))[0];
    // Проверим описания полей
    for n:=0 to AViewDesc.vewFieldsCount - 1 do
      if not FDescrField.CheckExist(VarArrayOf([tmpTblID, AViewDesc.vewFields[n].fldName])) then
      begin
        if (AViewDesc.vewFields[n].fldDescription = '') then
          FDescrField.Insert(VarArrayOf([tmpTblID, AViewDesc.vewName, AViewDesc.vewFields[n].fldName, AViewDesc.vewFields[n].fldName, STR_FIELD_REPORT_TYPE[AViewDesc.vewFields[n].fldType]]))
        else
          FDescrField.Insert(VarArrayOf([tmpTblID, AViewDesc.vewName, AViewDesc.vewFields[n].fldName, AViewDesc.vewFields[n].fldDescription, STR_FIELD_REPORT_TYPE[AViewDesc.vewFields[n].fldType]]));
      end;
    // Проверим обьединения
    for n:=0 to AViewDesc.vewJoinsCount - 1 do
      if not FJoinTable.CheckExist(VarArrayOf([AViewDesc.vewName, AViewDesc.vewJoins[n].jnTable, AViewDesc.vewJoins[n].jnFieldIn, AViewDesc.vewJoins[n].jnFieldOut])) then
        FJoinTable.Insert(VarArrayOf([AViewDesc.vewName, AViewDesc.vewJoins[n].jnTable, STR_JOIN_TYPE[AViewDesc.vewJoins[n].jnType], AViewDesc.vewJoins[n].jnFieldIn, AViewDesc.vewJoins[n].jnFieldOut, AViewDesc.vewJoins[n].jnOperator]));
    // Все ОК
    Result := True;
  except
    on E: Exception do AddToLog(lgDataBase, ltError, err_CheckViewDesc); //[FCurrDBFileName, AViewDesc.vewName, E.Message]);
  end;
end;

end.
