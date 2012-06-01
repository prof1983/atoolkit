{**
@Abstract(Информация о зарегистрированном модуле. Работа со списком модулей)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.04.2006)
@LastMod(10.05.2012)
@Version(0.5)
}
unit AModuleList;

interface

uses
  SysUtils, Classes;
  {ProfGlobals;}

type //** @abstract(Информация о зарегистрированном модуле)
  TModuleInfo = class(TObject)
  private
    FID: WideString;
    FHost: string;
    FName: string;
    FDescr: string;
  public
    //** Номер модуля
    property ID: WideString read FID write FID;
    //** Хост на котором зарегестрирован модуль
    property Host: string read FHost write FHost;
    //** Наименование модуля
    property Name: string read FName write FName;
    //** Описание модуля
    property Descr: string read FDescr write FDescr;
  end;

type //** @abstract(Работа со списком модулей)
  TModulesInfoList = class(TObject)
  private
    FModuleInfo: TModuleInfo;
  private
    function GetCount(): Integer;
    function GetItems(Index: Integer): TModuleInfo;
    function GetCountByHost(Host: string): Integer;
    function GetItemsByHost(Host: string; Index: Integer): TModuleInfo;
    function GetCountByName(Name: string): Integer;
    function GetItemsByName(Name: string; Index: Integer): TModuleInfo;
    function GetCountByID(ID: integer): Integer;
    function GetItemsByID(ID: integer; Index: Integer): TModuleInfo;
    function GetCountHost(): Integer;
    function GetItemsHost(Index: integer): string;
    procedure ClearModuleInfoItem(AItem: TModuleInfo);
  public
    constructor Create();
    destructor Destroy(); override;
  public
    //** Добавить новый модуль к списку
    function AddModule(AItem: TModuleInfo): Boolean;
    //** Удалить модуль из списка по номеру
    procedure DelModuleByID(const AHost: string; AID: Integer);
    //** Удалить модуль из списка по наименованию
    procedure DelModuleByName(const AHost: string; const AName: string);
  public
    //** Получить описание модуля по уникальному номеру
    function GetModuleInfoByID(const AHost: string; AID: Integer): TModuleInfo;
    //** Получить описание модуля по наименованию
    function GetModuleInfoByName(const AHost: string; const AName: string): TModuleInfo;
  public
    //** Количество известных хостов
    property CountHost: Integer read GetCountHost;
    //** Список известных хостов по индексу
    property ItemsHost[Index: Integer]: string read GetItemsHost;
  public
    //** Общее количество модулей
    property Count: Integer read GetCount;
    //** Список модулей по индексу
    property ItemsByIndex[Index: Integer]: TModuleInfo read GetItems;
    //** Количество модулей на указанном хосте
    property CountByHost[Host: string]: Integer read GetCountByHost;
    //** Список модулей по индексу для указанного хоста
    property ItemsByHost[Host: string; Index: Integer]: TModuleInfo read GetItemsByHost;
    //** Количество модулей по наименованию
    property CountByName[Name: string]: Integer read GetCountByName;
    //** Список модулей по индексу с указанным наименованием
    property ItemsByName[Name: string; Index: Integer]: TModuleInfo read GetItemsByName;
    //** Количество модулей по уникальному номеру
    property CountByID[ID: integer]: Integer read GetCountByID;
    //** Список модулей по индексу с указанным номером
    property ItemsByID[ID: integer; Index: Integer]: TModuleInfo read GetItemsByID;
  end;

implementation

resourcestring
  info_Delete_TCPIP_Table     = 'Удалена информация о модуле "%s".';
  info_Add_TCPIP_Table        = 'Добавлен новый модуль "%s": id - "%d", host - "%s".';
  info_Change_Module_Host     = 'Изменен хост модуля "%s" с "%s" на "%s".';
  info_Change_Module_Descr    = 'Изменено описание модуля "%s" с "%s" на "%s".';
  info_Change_Module_ID       = 'Изменен уникальный номер модуля "%s" с "%d" на "%d".';
const
  str_Module_Key_Name         = 'Список модулей';
  str_Prop_Module_Descr       = 'Description';
  str_Prop_Module_ID          = 'ID';

{ TModulesInfoList }

constructor TModulesInfoList.Create();
begin
  inherited Create();
  FModuleInfo := TModuleInfo.Create();
end;

destructor TModulesInfoList.Destroy();
begin
  FreeAndNil(FModuleInfo);
  inherited;
end;

procedure TModulesInfoList.ClearModuleInfoItem(AItem: TModuleInfo);
begin
  with AItem do
  begin
    AItem.ID := '';
    AItem.Host := '';
    AItem.Name := '';
    AItem.Descr := '';
  end;
end;

function TModulesInfoList.AddModule(AItem: TModuleInfo): Boolean;
{var
  tmpStr: string;
  tmpInt: integer;}
begin
  Result := False;
  {if not(Assigned(FSetupRec)) then Exit;

  FSetupRec.Lock();
  try
    if (not FSetupRec.GlobalsStorage.Open()) then Exit;
    if (not FSetupRec.GlobalsStorage.OpenKey(str_Module_Key_Name + '\' + AItem.Host + '\' + AItem.Name)) then Exit;
    tmpInt := FSetupRec.GlobalsStorage.ReadInteger(str_Prop_Module_ID, 0);
    if (tmpInt <> Integer(AItem.ID)) then
    begin
      FSetupRec.GlobalsStorage.WriteInteger(str_Prop_Module_ID, AItem.ID);
      FSetupRec.AddToLog(lgSetup, ltInformation, info_Change_Module_ID, [AItem.Name, tmpInt, AItem.ID]);
    end;
    tmpStr := FSetupRec.GlobalsStorage.ReadString(str_Prop_Module_Descr, '');
    if (tmpStr <> AItem.Descr) then
    begin
      FSetupRec.GlobalsStorage.WriteString(str_Prop_Module_Descr, AItem.Descr);
      FSetupRec.AddToLog(lgSetup, ltInformation, info_Change_Module_Descr, [AItem.Name, tmpStr, AItem.Descr]);
    end;
    Result := True;
  finally
    FSetupRec.GlobalsStorage.Close();
    FSetupRec.UnLock();
  end;}
end;

function TModulesInfoList.GetCount(): Integer;
{var
  tmpList: TStringList;
  tmpValList: TStringList;
  n: Integer;}
begin
  Result := 0;
  {if not(Assigned(FSetupRec)) then Exit;

  FSetupRec.Lock();
  try
    tmpList := TStringList.Create();
    tmpValList := TStringList.Create();
    if (not FSetupRec.GlobalsStorage.Open()) then Exit;
    if (not FSetupRec.GlobalsStorage.OpenKey(str_Module_Key_Name)) then Exit;
    FSetupRec.GlobalsStorage.GetKeyNames(tmpList);
    FSetupRec.GlobalsStorage.CloseKey();
    for n:=0 to tmpList.Count - 1 do
    try
      FSetupRec.GlobalsStorage.OpenKey(str_Module_Key_Name + '\' + tmpList[n]);
      tmpValList.Clear();
      FSetupRec.GlobalsStorage.GetKeyNames(tmpValList);
      Result := Result + tmpValList.Count;
    finally
      FSetupRec.GlobalsStorage.CloseKey();
    end;
  finally
    FreeAndNil(tmpValList);
    FreeAndNil(tmpList);
    FSetupRec.GlobalsStorage.Close();
    FSetupRec.UnLock();
  end;}
end;

function TModulesInfoList.GetItems(Index: Integer): TModuleInfo;
{var
  tmpList: TStringList;
  tmpValList: TStringList;
  tmpIndex: Integer;
  n: Integer;}
begin
  // Очищаем значение
  ClearModuleInfoItem(FModuleInfo);
  // Вернем результат
  Result := FModuleInfo;

  {if not(Assigned(FSetupRec)) then Exit;


  // Получим значения
  FSetupRec.Lock();
  try
    tmpList := TStringList.Create();
    tmpValList := TStringList.Create();
    if (not FSetupRec.GlobalsStorage.Open()) then Exit;
    if (not FSetupRec.GlobalsStorage.OpenKey(str_Module_Key_Name)) then Exit;
    FSetupRec.GlobalsStorage.GetKeyNames(tmpList);
    FSetupRec.GlobalsStorage.CloseKey();
    tmpIndex := 0;
    for n:=0 to tmpList.Count - 1 do
    try
      FSetupRec.GlobalsStorage.OpenKey(str_Module_Key_Name + '\' + tmpList[n]);
      tmpValList.Clear();
      FSetupRec.GlobalsStorage.GetKeyNames(tmpValList);
      if (tmpIndex <= Index) and (Index < tmpIndex + tmpValList.Count) then
      begin
        FSetupRec.GlobalsStorage.CloseKey();
        FSetupRec.GlobalsStorage.OpenKey(str_Module_Key_Name + '\' + tmpList[n] + '\' + tmpValList[Index - tmpIndex]);
        FModuleInfo.ID := FSetupRec.GlobalsStorage.ReadInteger(str_Prop_Module_ID, 0);
        FModuleInfo.Name := tmpValList[Index - tmpIndex];
        FModuleInfo.Descr := FSetupRec.GlobalsStorage.ReadString(str_Prop_Module_Descr, '');
        FModuleInfo.Host := tmpList[n];
        Break;
      end;
      tmpIndex := tmpIndex + tmpValList.Count;
    finally
      FSetupRec.GlobalsStorage.CloseKey();
    end;
  finally
    FreeAndNil(tmpValList);
    FreeAndNil(tmpList);
    FSetupRec.GlobalsStorage.Close();
    FSetupRec.UnLock();
  end;}
end;

function TModulesInfoList.GetCountByHost(Host: string): Integer;
{var
  tmpList: TStringList;}
begin
  Result := 0;
  {if not(Assigned(FSetupRec)) then Exit;

  FSetupRec.Lock();
  try
    tmpList := TStringList.Create();
    if (not FSetupRec.GlobalsStorage.Open()) then Exit;
    if (not FSetupRec.GlobalsStorage.OpenKey(str_Module_Key_Name + '\' + Host)) then Exit;
    FSetupRec.GlobalsStorage.GetKeyNames(tmpList);
    Result := tmpList.Count;
    FSetupRec.GlobalsStorage.CloseKey();
  finally
    FreeAndNil(tmpList);
    FSetupRec.GlobalsStorage.Close();
    FSetupRec.UnLock();
  end;}
end;

function TModulesInfoList.GetItemsByHost(Host: string; Index: Integer): TModuleInfo;
{var
  tmpList: TStringList;}
begin
  // Очищаем значение
  ClearModuleInfoItem(FModuleInfo);
  // Вернем результат
  Result := FModuleInfo;
  {if not(Assigned(FSetupRec)) then Exit;

  // Получим значения
  FSetupRec.Lock();
  try
    tmpList := TStringList.Create();
    if (not FSetupRec.GlobalsStorage.Open()) then Exit;
    if (not FSetupRec.GlobalsStorage.OpenKey(str_Module_Key_Name + '\' + Host)) then Exit;
    FSetupRec.GlobalsStorage.GetKeyNames(tmpList);
    FSetupRec.GlobalsStorage.CloseKey();
    FSetupRec.GlobalsStorage.OpenKey(str_Module_Key_Name + '\' + Host + '\' + tmpList[Index]);
    FModuleInfo.ID := FSetupRec.GlobalsStorage.ReadInteger(str_Prop_Module_ID, 0);
    FModuleInfo.Name := tmpList[Index];
    FModuleInfo.Descr := FSetupRec.GlobalsStorage.ReadString(str_Prop_Module_Descr, '');
    FModuleInfo.Host := Host;
    FSetupRec.GlobalsStorage.CloseKey();
  finally
    FreeAndNil(tmpList);
    FSetupRec.GlobalsStorage.Close();
    FSetupRec.UnLock();
  end;}
end;

function TModulesInfoList.GetCountByID(ID: integer): Integer;
{
var
  n: Integer;
  tmpCount: Integer;
}
begin
  Result := 0;
  {
  tmpCount := GetCount();
  for n:=0 to tmpCount - 1 do
    if (ItemsByIndex[n].ID = ID) then
      Inc(Result);
  }
end;

function TModulesInfoList.GetItemsByID(ID: integer; Index: Integer): TModuleInfo;
{
var
  n: Integer;
  tmpCount: Integer;
  tmpIndex: Integer;
}
begin
  Result := FModuleInfo;
  {
  tmpIndex := 0;
  tmpCount := GetCount();
  for n:=0 to tmpCount - 1 do
    if (ItemsByIndex[n].ID = ID) then
    begin
      if (tmpIndex = Index) then Exit;
      Inc(tmpIndex);
    end;
  ClearModuleInfoItem(FModuleInfo);
  }
end;

function TModulesInfoList.GetCountByName(Name: string): Integer;
var
  n: Integer;
  tmpCount: Integer;
begin
  Result := 0;
  tmpCount := GetCount();
  for n:=0 to tmpCount - 1 do
    if (ItemsByIndex[n].Name = Name) then
      Inc(Result);
end;

function TModulesInfoList.GetItemsByName(Name: string; Index: Integer): TModuleInfo;
var
  n: Integer;
  tmpCount: Integer;
  tmpIndex: Integer;
begin
  Result := FModuleInfo;
  tmpIndex := 0;
  tmpCount := GetCount();
  for n:=0 to tmpCount - 1 do
    if (ItemsByIndex[n].Name = Name) then
    begin
      if (tmpIndex = Index) then Exit;
      Inc(tmpIndex);
    end;
  ClearModuleInfoItem(FModuleInfo);
end;

procedure TModulesInfoList.DelModuleByID(const AHost: string; AID: Integer);
{var
  tmpInfo: TModuleInfo;}
begin
  {if not(Assigned(FSetupRec)) then Exit;

  tmpInfo := GetModuleInfoByID(AHost, AID);
  if (tmpInfo.ID = AID)and(tmpInfo.Host = AHost)and(tmpInfo.Name <> '') then
  begin
    FSetupRec.Lock();
    try
      if (not FSetupRec.GlobalsStorage.Open()) then Exit;
      if (not FSetupRec.GlobalsStorage.OpenKey(str_Module_Key_Name + '\' + tmpInfo.Host, True)) then Exit;
      FSetupRec.GlobalsStorage.DeleteSubKey(tmpInfo.Name);
      FSetupRec.AddToLog(lgSetup, ltInformation, info_Delete_TCPIP_Table, [tmpInfo.Name]);
    finally
      FSetupRec.GlobalsStorage.Close();
      FSetupRec.UnLock();
    end;
  end;}
end;

procedure TModulesInfoList.DelModuleByName(const AHost: string; const AName: string);
{var
  tmpInfo: TModuleInfo;}
begin
  {if not(Assigned(FSetupRec)) then Exit;

  tmpInfo := GetModuleInfoByName(AHost, AName);
  if (tmpInfo.ID <> 0)and(tmpInfo.Host = AHost)and(tmpInfo.Name = AName) then
  begin
    FSetupRec.Lock();
    try
      if (not FSetupRec.GlobalsStorage.Open()) then Exit;
      if (not FSetupRec.GlobalsStorage.OpenKey(str_Module_Key_Name + '\' + AHost, True)) then Exit;
      FSetupRec.GlobalsStorage.DeleteSubKey(AName);
      FSetupRec.AddToLog(lgSetup, ltInformation, info_Delete_TCPIP_Table, [AName]);
    finally
      FSetupRec.GlobalsStorage.Close();
      FSetupRec.UnLock();
    end;
  end;}
end;

function TModulesInfoList.GetModuleInfoByID(const AHost: string; AID: Integer): TModuleInfo;
{
var
  tmpCount: Integer;
  n: Integer;
}
begin
  // Вернем результат
  Result := FModuleInfo;
  {
  // Найдем нужное значение
  tmpCount := GetCountByHost(AHost);
  for n:=0 to tmpCount - 1 do
    if (ItemsByHost[AHost, n].ID = AID) then
      Exit;
  // Очищаем значение
  ClearModuleInfoItem(FModuleInfo);
  }
end;

function TModulesInfoList.GetModuleInfoByName(const AHost: string; const AName: string): TModuleInfo;
begin
  // Очищаем значение
  ClearModuleInfoItem(FModuleInfo);
  // Вернем результат
  Result := FModuleInfo;
  {if not(Assigned(FSetupRec)) then Exit;


  // Получаем значение из хранилища
  FSetupRec.Lock();
  try
    if (not FSetupRec.GlobalsStorage.Open()) then Exit;
    if (not FSetupRec.GlobalsStorage.OpenKey(str_Module_Key_Name + '\' + AHost + '\' + AName, True)) then Exit;
    FModuleInfo.ID := FSetupRec.GlobalsStorage.ReadInteger(str_Prop_Module_ID, 0);
    FModuleInfo.Descr := FSetupRec.GlobalsStorage.ReadString(str_Prop_Module_Descr, '');
    FModuleInfo.Name := AName;
    FModuleInfo.Host := AHost;
  finally
    FSetupRec.GlobalsStorage.Close();
    FSetupRec.UnLock();
  end;}
end;

function TModulesInfoList.GetCountHost(): Integer;
{var
  tmpList: TStringList;}
begin
  Result := 0;
  {if not(Assigned(FSetupRec)) then Exit;

  FSetupRec.Lock();
  try
    if (not FSetupRec.GlobalsStorage.Open()) then Exit;
    if (not FSetupRec.GlobalsStorage.OpenKey(str_Module_Key_Name)) then Exit;
    tmpList := TStringList.Create();
    try
      FSetupRec.GlobalsStorage.GetKeyNames(tmpList);
      Result := tmpList.Count;
    finally
      FreeAndNil(tmpList);
    end;
  finally
    FSetupRec.GlobalsStorage.Close();
    FSetupRec.UnLock();
  end;}
end;

function TModulesInfoList.GetItemsHost(Index: integer): string;
{var
  tmpList: TStringList;}
begin
  Result := '';
  {if not(Assigned(FSetupRec)) then Exit;

  FSetupRec.Lock();
  try
    if (not FSetupRec.GlobalsStorage.Open()) then Exit;
    if (not FSetupRec.GlobalsStorage.OpenKey(str_Module_Key_Name)) then Exit;
    tmpList := TStringList.Create();
    try
      FSetupRec.GlobalsStorage.GetKeyNames(tmpList);
      Result := tmpList[Index];
    finally
      FreeAndNil(tmpList);
    end;
  finally
    FSetupRec.GlobalsStorage.Close();
    FSetupRec.UnLock();
  end;}
end;

end.
