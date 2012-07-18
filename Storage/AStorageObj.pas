{**
@Abstract(Набор классов для работы с хранилищами)
@Author(Prof1983 <prof1983@ya.ru>)
@Created(12.04.2006)
@LastMod(18.07.2012)
}
unit AStorageObj;

interface

uses
  Windows, Consts, Classes, SysUtils, ActiveX, Math,
  AConsts2, ALogObj, ATypes, AUtils1;

type
  {** @abstract(Класс исключения возникающего в случае ошибок.)}
  TStorageException = class(Exception)
  end;

  {**
    Возможные типы параметров для сохранения в хранилище.
    @value(vtUnknown неизвестный или неопределенный тип)
    @value(vtString строковое значение)
    @value(vtBool логическое значение)
    @value(vtInt целой 4-х байтовое число)
    @value(vtFloat вещественное число)
    @value(vtDateTime дата и время)
    @value(vtStorage ветка дерева содержащего другие значение)
  }
  TValueType = (
      vtUnknown,
      vtString,
      vtBool,
      vtInt,
      vtFloat,
      vtDateTime,
      vtStorage
    );

  {**
    @abstract(Класс для хранения параметров в виде дерева.)

    Класс осуществляющий работу со специализированным хранилищем.
    Позволяет хранить параметры простых типов в виде дерева.@br
    Недостатком является невозможность хранить значения в корневой директории.

    @bold(Пример использования:)
    @longcode(#
      var
        tmpStorage: TPropertyStorage;
      begin
        tmpStorage := TPropertyStorage.Create('C:\test.stg');
        tmpStorage.Open();

        tmpStorage.OpenKey('test', False);
        tmpStorage.WriteString('test_string', 'sample');
        tmpStorage.CloseKey();

        tmpStorage.OpenKey('test', True);
        ShowMessage(tmpStorage.ReadString('test_string', 'default'));
        tmpStorage.CloseKey();

        tmpStorage.Close();
        FreeAndNil(tmpStorage);
      end;
    #)

    @member(Create         Конструктор объекта.
                           @param(AStgName Имя файла хранилища))
    @member(Destroy        Деструктор объекта.)
    @member(ReadString     Чтение строкового параметра из текущего ключа хранилища.
                           @param(AIdent Текстовое имя параметра)
                           @param(ADefault Значение возвращаемое в случае отсутсвия заданного параметра в хранилище)
                           @return(Значение параметра из хранилища или значение заданное по умолчанию)
                           @raises(TStorageException Возникает в случае ошибки чтения параметра))
    @member(ReadBoolean    Чтение логического параметра из текущего ключа хранилища.
                           @param(AIdent Текстовое имя параметра)
                           @param(ADefault Значение возвращаемое в случае отсутсвия заданного параметра в хранилище)
                           @return(Значение параметра из хранилища или значение заданное по умолчанию)
                           @raises(TStorageException Возникает в случае ошибки чтения параметра))
    @member(ReadInteger    Чтение целочисленного параметра из текущего ключа хранилища.
                           @param(AIdent Текстовое имя параметра)
                           @param(ADefault Значение возвращаемое в случае отсутсвия заданного параметра в хранилище)
                           @return(Значение параметра из хранилища или значение заданное по умолчанию)
                           @raises(TStorageException Возникает в случае ошибки чтения параметра))
    @member(ReadFloat      Чтение вещественного параметра из текущего ключа хранилища.
                           @param(AIdent Текстовое имя параметра)
                           @param(ADefault Значение возвращаемое в случае отсутсвия заданного параметра в хранилище)
                           @return(Значение параметра из хранилища или значение заданное по умолчанию)
                           @raises(TStorageException Возникает в случае ошибки чтения параметра))
    @member(ReadDateTime   Чтение параметра даты из текущего ключа хранилища.
                           @param(AIdent Текстовое имя параметра)
                           @param(ADefault Значение возвращаемое в случае отсутсвия заданного параметра в хранилище)
                           @return(Значение параметра из хранилища или значение заданное по умолчанию)
                           @raises(TStorageException Возникает в случае ошибки чтения параметра))
    @member(WriteString    Запись текстового параметра в текущий ключ хранилища.
                           @param(AIdent Текстовое имя параметра)
                           @param(AValue Значение параметра для записи)
                           @raises(TStorageException Возникает в случае ошибки записи параметра))
    @member(WriteBoolean   Запись логического параметра в текущий ключ хранилища.
                           @param(AIdent Текстовое имя параметра)
                           @param(AValue Значение параметра для записи)
                           @raises(TStorageException Возникает в случае ошибки записи параметра))
    @member(WriteInteger   Запись целочисленного параметра в текущий ключ хранилища.
                           @param(AIdent Текстовое имя параметра)
                           @param(AValue Значение параметра для записи)
                           @raises(TStorageException Возникает в случае ошибки записи параметра))
    @member(WriteFloat     Запись вещественного параметра в текущий ключ хранилища.
                           @param(AIdent Текстовое имя параметра)
                           @param(AValue Значение параметра для записи)
                           @raises(TStorageException Возникает в случае ошибки записи параметра))
    @member(WriteDateTime  Запись параметра даты в текущий ключ хранилища.
                           @param(AIdent Текстовое имя параметра)
                           @param(AValue Значение параметра для записи)
                           @raises(TStorageException Возникает в случае ошибки записи параметра))
    @member(Open           Открывает указанное хранилище. При открытии проверяется наличие файла.
                           В случае отсутсвия файла, предпринимается попытка его создания.
                           @return(@true в случае успешного открытия хранилища.))
    @member(OpenKey        Открывает указанный ключ с заданным доступом и делает его текущим.
                           @param(AKey Имя ключа. Для разделения ключей используется символ "\".)
                           @param(AIsReadOnly Если @true, то ключ будет открыт только для чтения
                                              и при попытке записи будет возникать исключение.)
                           @return(@true в случае успешного открытия ключа.))
    @member(CloseKey       Закрывает текущий ключ. При закрытии автоматический выполняется Commit().)
    @member(Commit         Сбрасывает системный буфер на диск.)
    @member(GetRootKeys    Возвращает список ключей верхнего уровня.
                           @param(AList Список для заполнения.)
                           @return(@true в случае успешного выполнения.))
    @member(GetKeyNames    Получить список подключей в текушем ключе.
                           @param(AList Список для заполнения.)
                           @return(@true в случае успешного выполнения.))
    @member(GetValueNames  Получить список значений в текушем ключе.
                           @param(AList Список для заполнения.)
                           @return(@true в случае успешного выполнения.))
    @member(GetValueType   Получить тип значения в текущем ключе.
                           @param(AIdent Наименования параметра.)
                           @return(Тип параметра. Если параметр не существеут, то
                                   возвращается vtUnknown.))
    @member(ClearKey       Удалить все заначения и все подключи в текущем ключе.
                           @return(@true в случае успешного выполнения.))
    @member(SetDescription Задать описание хранилища
                           @param(ADescr Описание.)
                           @return(@true в случае успешного выполнения.))
    @member(DeleteSubKey   Удалить подключ в текущем ключе.
                           @param(AIdent Наименование удаляемого ключа.)
                           @raises(TStorageException Возникает в случае ошибки удаления ключа.))
    @member(DeleteValue    Удалить параметр в текущем ключе.
                           @param(AIdent Наименование удаляемого параметра.)
                           @raises(TStorageException Возникает в случае ошибки удаления параметра.))
    @member(Close          Закрыть хранилище. При этом текущий ключ автоматический закрывается и
                           выполняется Commit().)

    @member(StorageFileName Имя файла хранилища.)
    @member(Description     Описание хранилища.)
    @member(IsOpen          Признак открытого хранилища.)
    @member(IsKeyOpen       Признак открытого ключа.)
    @member(CurrentKeyName  Путь текущего ключа.)
    @member(CurrentKeyInfo  Информация об открытом ключе.)
    @member(IsChanged       Признак изменения значений. Т.е. имеет значение @true
                            если была произведена запись в хранилище.)
  }
  TPropertyStorage = class(TLoggerObject)
  private
    FSubKeyProp: TList;
    FIsChanged: boolean;
    FMainStorage: IStorage;
    FCurrentKeyName: string;
    FStorageFileName: string;
    FDescription: string;
    FCurrentKeyInfo: TStatPropSetStg;
    function GetIsKeyOpen(): boolean;
    function GetIsOpen(): boolean;
    function OpenSubKey(ARoot: IStorage; const AKeyName: string; const AFullKeyName: string; AIsReadOnly: boolean): boolean;
    function OpenSubKeys(const AKeyName: string; const AFullKeyName: string; AIsReadOnly: boolean): boolean;
    procedure ReadValue(const AName: string; var AValue: TPropVariant);
    procedure WriteValue(const AName: string; var AValue: TPropVariant);
    function ReadDescription(ARoot: IStorage): HResult;
  public
    constructor Create(const AStgName: string);
    destructor Destroy; override;
  public
    function ReadString(const AIdent: string; const ADefault: string): string;
    function ReadBoolean(const AIdent: string; ADefault: boolean): boolean;
    function ReadInteger(const AIdent: string; ADefault: Integer): Integer;
    function ReadFloat(const AIdent: string; ADefault: Double): Double;
    function ReadDateTime(const AIdent: string; ADefault: TDateTime): TDateTime;
  public
    procedure WriteString(const AIdent: string; const AValue: AnsiString);
    procedure WriteBoolean(const AIdent: string; AValue: boolean);
    procedure WriteInteger(const AIdent: string; AValue: Integer);
    procedure WriteFloat(const AIdent: string; AValue: Double);
    procedure WriteDateTime(const AIdent: string; AValue: TDateTime);
  public
    function Open(): boolean;
    function OpenKey(const AKey: string; AIsReadOnly: boolean = False): boolean;
    procedure CloseKey();
    procedure Commit();
    function GetRootKeys(AList: TStrings): boolean;
    function GetKeyNames(AList: TStrings): boolean;
    function GetValueNames(AList: TStrings): boolean;
    function GetValueType(const AIdent: string): TValueType;
    function ClearKey(): boolean;
    function SetDescription(const ADescr: string): boolean;
    procedure DeleteSubKey(const AIdent: string);
    procedure DeleteValue(const AIdent: string);
    procedure Close();
  public
    property StorageFileName: string read FStorageFileName;
    property Description: string read FDescription;
    property IsOpen: boolean read GetIsOpen;
    property IsKeyOpen: boolean read GetIsKeyOpen;
    property CurrentKeyName: string read FCurrentKeyName;
    property CurrentKeyInfo: TStatPropSetStg read FCurrentKeyInfo;
    property IsChanged: boolean read FIsChanged;
  end;

  {**
    @abstract(Класс для хранения бинарных потоков в виде дерева.)

    Класс осуществляющий работу со специализированным хранилищем.
    Позволяет хранить бинарные потоки в виде дерева.

    @member(Create         Конструктор объекта.
                           @param(AStgName Имя файла хранилища))
    @member(Destroy        Деструктор объекта.)
    @member(Open           Открывает указанное хранилище. При открытии проверяется наличие файла.
                           В случае отсутсвия файла, предпринимается попытка его создания.
                           @param(AIsReadOnly Если @true, то хранилище будет открыто только для чтения
                                              и при попытке записи будет возникать исключение.)
                           @return(@true в случае успешного открытия хранилища.))
    @member(Commit         Сбрасывает системный буфер на диск.)
    @member(SetDescription Задать описание хранилища
                           @param(ADescr Описание.)
                           @return(@true в случае успешного выполнения.))
    @member(OpenKey        Открывает указанный ключ и делает его текущим.
                           @param(AKey Имя ключа. Для разделения ключей используется символ "\".)
                           @return(@true в случае успешного открытия ключа.))
    @member(GetRootKeys    Возвращает список ключей верхнего уровня.
                           @param(AList Список для заполнения.)
                           @return(@true в случае успешного выполнения.))
    @member(GetKeysName    Получить список подключей в текушем ключе.
                           @param(AList Список для заполнения.)
                           @return(@true в случае успешного выполнения.))
    @member(GetStreamsName Получить список потоков в текушем ключе.
                           @param(AList Список для заполнения.)
                           @return(@true в случае успешного выполнения.))
    @member(ReadStream     Прочитать поток из текущего ключа.
                           @param(AName Наименование потока.)
                           @param(AStream Объект в который будут прочитаны данные.)
                           @return(@true в случае успешного выполнения.))
    @member(WriteStream    Записать поток в текущий ключ. Если поток с заданным наименованием
                           уже существует, то он перезаписывается.
                           @param(AName Наименование потока.)
                           @param(AStream Объект из которого будут прочитаны данные.)
                           @return(@true в случае успешного выполнения.))
    @member(CloseKey       Закрывает текущий ключ. При закрытии автоматический выполняется Commit().)
    @member(Close          Закрыть хранилище. При этом текущий ключ автоматический закрывается и
                           выполняется Commit().)

    @member(StorageFileName Имя файла хранилища.)
    @member(Description     Описание хранилища.)
    @member(IsOpen          Признак открытого хранилища.)
    @member(IsKeyOpen       Признак открытого ключа.)
    @member(CurrentKeyName  Путь текущего ключа.)
    @member(IsChanged       Признак изменения значений. Т.е. имеет значение @true
                            если была произведена запись в хранилище.)
    @member(IsReadOnly      Текущий уровень доступа.)
  }
  TStreamStorage = class(TLoggerObject)
  private
    FSubKeyProp: TList;
    FIsChanged: boolean;
    FMainStorage: IStorage;
    FStorageFileName: string;
    FDescription: string;
    FIsReadOnly: boolean;
    FCurrentKeyName: string;
    function GetIsOpen(): boolean;
    function GetIsKeyOpen(): boolean;
    function ReadDescription(ARoot: IStorage): HResult;
    function OpenSubKey(ARoot: IStorage; const AKeyName: string; const AFullKeyName: string): boolean;
    function OpenSubKeys(const AKeyName: string; const AFullKeyName: string): boolean;
  public
    constructor Create(const AStgName: string);
    destructor Destroy; override;
  public
    function Open(AIsReadOnly: boolean = False): boolean;
    procedure Commit();
    function SetDescription(const ADescr: string): boolean;
    function OpenKey(const AKey: string): boolean;
    function GetRootKeys(AList: TStrings): boolean;
    function GetKeysName(AList: TStrings): boolean;
    function GetStreamsName(AList: TStrings): boolean;
    function WriteStream(const AName: string; AStream: TMemoryStream): boolean;
    function ReadStream(const AName: string; AStream: TMemoryStream): boolean;
    procedure CloseKey();
    procedure Close();
  public
    property StorageFileName: string read FStorageFileName;
    property Description: string read FDescription;
    property IsOpen: boolean read GetIsOpen;
    property IsKeyOpen: boolean read GetIsKeyOpen;
    property IsReadOnly: boolean read FIsReadOnly;
    property IsChanged: boolean read FIsChanged;
    property CurrentKeyName: string read FCurrentKeyName;
  end;

implementation

resourcestring
  info_Create_Storage         = 'Создано хранилище: name - "%s".';
  info_Create_Key             = 'В ключе "%s" создан подключ "%s".';
  info_Create_New_Stream      = 'Создан новый поток "%s".';

  err_Create_Stg              = 'Ошибка создания хранилища: name - "%s", err_code - "%s".';
  err_Create_Sub_Storage      = 'Ошибка создания набора подключей: err_code - "%s".';
  err_Create_Sub_Key          = 'Ошибка создания подключа: name - "%s", err_code - "%s".';
  err_Set_Key_Name            = 'Ошибка записи наименования подключа: name - "%s", err_code - "%s".';
  err_Commit_Storage          = 'Ошибка внесения измений: level - "%d", err_code - "%s".';
  err_Write_Value             = 'Ошибка записи значения: name - "%s", err_code - "%s".';
  err_Read_Value              = 'Ошибка чтения значения: name - "%s", err_code - "%s".';
  err_Clear_Key               = 'Ошибка очистки ключа: name - "%s", err_code - "%s".';
  err_Delete_Sub_Key          = 'Ошибка удаления подключа: key - "%s", sub_key - "%s", err_code - "%s".';
  err_Delete_Value            = 'Ошибка удаления параметра: key - "%s", name - "%s", err_code - "%s".';
  err_Set_Description         = 'Ошибка задания описания: err_code - "%s".';
  err_Read_Root_Keys          = 'Ошибка чтения основных ключей: err_code - "%s".';
  err_Read_Key_Names          = 'Ошибка чтения списка подключей: err_code - "%s".';
  err_Read_Value_Names        = 'Ошибка чтения списка значений: err_code - "%s".';
  err_Read_Only               = 'Для выполнения данной операции необходим доступ на запись.';

const
  str_Descr_Name_Stream       = 'DESCRIPTION';
  str_Descr_New_Storage       = 'неизвестно';
const
  IID_IPropertySetStorage: TGUID = '{0000013A-0000-0000-C000-000000000046}';
  STGM_NOSNAPSHOT                = $00200000;
  STGC_CONSOLIDATE               = $00000008;
const
  stgmOpenMode: array[Boolean]of LongInt = (
      STGM_TRANSACTED or STGM_READWRITE or STGM_SHARE_DENY_NONE or STGM_NOSNAPSHOT,
      STGM_TRANSACTED or STGM_READ or STGM_SHARE_DENY_NONE or STGM_NOSNAPSHOT
    );
  stgmOpenModeStg: array[Boolean]of LongInt = (
      STGM_TRANSACTED or STGM_READWRITE or STGM_SHARE_EXCLUSIVE,
      STGM_TRANSACTED or STGM_READ or STGM_SHARE_EXCLUSIVE
    );

function StgCreatePropSetStg(pStorage: IStorage; dwReserved: LongWord; out stgOpen: IPropertySetStorage): HResult; stdcall; external 'ole32.dll' name 'StgCreatePropSetStg';

// TStreamStorage --------------------------------------------------------------
// -----------------------------------------------------------------------------
constructor TStreamStorage.Create(const AStgName: string);
begin
  inherited Create();
  FMainStorage := nil;
  FStorageFileName := AStgName;
  FIsReadOnly := True;
  FSubKeyProp := TList.Create();
  FDescription := '';
  FCurrentKeyName := '';
  FIsChanged := False;
end;

// -----------------------------------------------------------------------------
destructor TStreamStorage.Destroy;
begin
  if IsOpen then Close();
  FreeAndNil(FSubKeyProp);
  inherited;
end;

// -----------------------------------------------------------------------------
function TStreamStorage.GetIsOpen(): boolean;
begin
  Result := Assigned(FMainStorage);
end;

// -----------------------------------------------------------------------------
function TStreamStorage.GetIsKeyOpen(): boolean;
begin
  Result := (FSubKeyProp.Count <> 0);
end;

// -----------------------------------------------------------------------------
function TStreamStorage.Open(AIsReadOnly: boolean = False): boolean;
var
  Res: HResult;
begin
  Result := False;
  try
    if IsOpen then Close();
    // Откроем хранилище
    FIsReadOnly := AIsReadOnly;
    Res := StgOpenStorage(PWideChar(WideString(FStorageFileName)), nil, stgmOpenMode[FIsReadOnly], nil, 0, FMainStorage);
    // Если открыть не удалось
    if (not Assigned(FMainStorage)) then
    begin
      if (IsReadOnly) then
        raise TStorageException.CreateFmt(err_Create_Stg, [FStorageFileName, DecodeOleError(Res)]);
      // Если файл существует, то удалим
      if FileExists(FStorageFileName) then
        DeleteFile(FStorageFileName);
      // Создадим новое хранилище
      Res := StgCreateDocfile(PWideChar(WideString(FStorageFileName)), stgmOpenMode[FIsReadOnly], 0, FMainStorage);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Create_Stg, [FStorageFileName, DecodeOleError(Res)]);
      AddToLog2(lgSetup, ltInformation, info_Create_Storage, [FStorageFileName]);
      SetDescription(str_Descr_New_Storage);
      // Внесем изменения
      Res := FMainStorage.Commit(STGC_DEFAULT or STGC_CONSOLIDATE);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Set_Description, [DecodeOleError(Res)]);
    end;
    // Прочитаем описание
    ReadDescription(FMainStorage);
    Result := True;
  except
    on E: Exception do
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'Open()']);
  end;
end;

// -----------------------------------------------------------------------------
procedure TStreamStorage.Close();
begin
  if IsKeyOpen then
    CloseKey();
  FDescription := '';
  FIsReadOnly := True;
  FIsChanged := False;
  FCurrentKeyName := '';
  FMainStorage := nil;
end;

// -----------------------------------------------------------------------------
function TStreamStorage.SetDescription(const ADescr: string): boolean;
var
  tmpStream: IStream;
  Res: HResult;
begin
  Result := False;
  try
    if (FDescription = ADescr) then Exit;
    if (not IsOpen) then Exit;
    if IsReadOnly then
      raise TStorageException.Create(err_Read_Only);
    if (FMainStorage.OpenStream(str_Descr_Name_Stream, nil, STGM_READWRITE or STGM_SHARE_EXCLUSIVE, 0, tmpStream) <> S_Ok) then
    begin
      Res := FMainStorage.CreateStream(str_Descr_Name_Stream, STGM_READWRITE or STGM_SHARE_EXCLUSIVE, 0, 0, tmpStream);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Set_Description, [DecodeOleError(Res)]);
    end;
    try
      Res := tmpStream.SetSize(Length(ADescr));
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Set_Description, [DecodeOleError(Res)]);
      Res := tmpStream.Write(Pointer(ADescr), Length(ADescr), nil);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Set_Description, [DecodeOleError(Res)]);
      Res := tmpStream.Commit(STGC_DEFAULT);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Set_Description, [DecodeOleError(Res)]);
      Res := FMainStorage.Commit(STGC_DEFAULT or STGC_CONSOLIDATE);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Set_Description, [DecodeOleError(Res)]);
      FDescription := ADescr;
      Result := True;
    finally
      tmpStream := nil;
    end;
  except
    on E: Exception do
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'SetDescription()']);
  end;
end;

// -----------------------------------------------------------------------------
function TStreamStorage.ReadDescription(ARoot: IStorage): HResult;
var
  tmpStream: IStream;
  tmpSize: Int64;
  tmpInt: Int64;
begin
  FDescription := '';
  Result := $01;
  if (not IsOpen) then Exit;
  Result := FMainStorage.OpenStream(str_Descr_Name_Stream, nil, STGM_READ or STGM_SHARE_EXCLUSIVE, 0, tmpStream);
  if (Result <> 0) then Exit;
  try
    Result := tmpStream.Seek(0, STREAM_SEEK_END, tmpSize);
    if (Result <> 0) then Exit;
    Result := tmpStream.Seek(0, STREAM_SEEK_SET, tmpInt);
    if (Result <> 0) then Exit;
    SetLength(FDescription, tmpSize);
    Result := tmpStream.Read(Pointer(FDescription), tmpSize, nil);
    if (Result <> 0) then Exit;
  finally
    tmpStream := nil;
  end;
end;

// -----------------------------------------------------------------------------
procedure TStreamStorage.Commit();
var
  n: integer;
  Res: HResult;
begin
  try
    if IsChanged then
    begin
      for n:=FSubKeyProp.Count - 1 downto 0 do
      begin
        Res := IStorage(FSubKeyProp.Items[n]).Commit(STGC_DEFAULT);
        if (Res <> 0) then
          raise TStorageException.CreateFmt(err_Commit_Storage, [(n + 1), DecodeOleError(Res)]);
      end;
      Res := FMainStorage.Commit(STGC_DEFAULT or STGC_CONSOLIDATE);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Commit_Storage, [0, DecodeOleError(Res)]);
      FIsChanged := False;
    end;
  except
    on E: Exception do
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'Commit()']);
  end;
end;

// -----------------------------------------------------------------------------
function TStreamStorage.OpenSubKey(ARoot: IStorage; const AKeyName: string; const AFullKeyName: string): boolean;
var
  Res: HResult;
  tmpStorage: IStorage;
begin
  Result := False;
  Res := ARoot.OpenStorage(PWideChar(WideString(AKeyName)), nil, stgmOpenModeStg[IsReadOnly], nil, 0, tmpStorage);
  if (Res <> 0) then
  begin
    if IsReadOnly then Exit;
    Res := ARoot.CreateStorage(PWideChar(WideString(AKeyName)), stgmOpenModeStg[IsReadOnly], 0, 0, tmpStorage);
    if (Res <> 0) then
      raise TStorageException.CreateFmt(err_Create_Sub_Key, [AKeyName, DecodeOleError(Res)]);
    FIsChanged := True;
    AddToLog2(lgSetup, ltInformation, info_Create_Key, [AFullKeyName, AKeyName]);
  end;
  tmpStorage._AddRef();
  FSubKeyProp.Add(Pointer(tmpStorage));
  Commit();
  Result := True;
end;

// -----------------------------------------------------------------------------
function TStreamStorage.OpenSubKeys(const AKeyName: string; const AFullKeyName: string): boolean;
var
  tmpPath: string;
  tmpKey: string;
begin
  Result := False;
  tmpPath := ExcludeTrailingBackslash(ExtractFilePath(AKeyName));
  tmpKey := ExtractFileName(AKeyName);
  if (tmpPath <> '') then
  begin
    if (not OpenSubKeys(tmpPath, AFullKeyName)) then Exit;
    Result := OpenSubKey(IStorage(FSubKeyProp.Items[FSubKeyProp.Count - 1]), tmpKey, tmpPath);
  end else
    Result := OpenSubKey(FMainStorage, tmpKey, '');
end;

// -----------------------------------------------------------------------------
function TStreamStorage.OpenKey(const AKey: string): boolean;
var
  tmpKeyName: string;
begin
  Result := False;
  try
    if (not IsOpen) then Exit;
    if (AKey = '') then Exit;
    if IsKeyOpen then
    begin
      tmpKeyName := IncludeTrailingBackslash(FCurrentKeyName) + ExcludeTrailingBackslash(AKey);
      CloseKey;
    end else
      tmpKeyName := ExcludeTrailingBackslash(AKey);
    Result := OpenSubKeys(tmpKeyName, tmpKeyName);
    FCurrentKeyName := tmpKeyName;
    if (not Result) then
      CloseKey();
  except
    on E: Exception do
    begin
      CloseKey();
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'OpenKey()']);
    end;
  end;
end;

// -----------------------------------------------------------------------------
procedure TStreamStorage.CloseKey();
var
  n: integer;
begin
  try
    try
      Commit();
      for n := (FSubKeyProp.Count - 1) downto 0 do
      begin
        IStorage(FSubKeyProp.Items[n])._Release();
        FSubKeyProp.Items[n] := nil;
      end;
      if (FSubKeyProp.Count > 0) then
        while FSubKeyProp.Count <> 0 do
          FSubKeyProp.Delete(FSubKeyProp.Count - 1);
    finally
      FCurrentKeyName := '';
    end;
  except
    on E: Exception do
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'CloseKey()']);
  end;
end;

// -----------------------------------------------------------------------------
function TStreamStorage.GetRootKeys(AList: TStrings): boolean;
var
  tmpEnum: IEnumSTATSTG;
  tmpDate: TStatStg;
  Res: HResult;
begin
  Result := False;
  try
    AList.Clear();
    if (not Assigned(FMainStorage)) then Exit;
    Res := FMainStorage.EnumElements(0, nil, 0, tmpEnum);
    if (Res <> 0) then
      raise TStorageException.CreateFmt(err_Read_Root_Keys, [DecodeOleError(Res)]);
    try
      while tmpEnum.Next(1, tmpDate, nil) = S_Ok do
      try
        if (tmpDate.dwType = STGTY_STORAGE) then AList.Add(tmpDate.pwcsName);
      finally
        CoTaskMemFree(tmpDate.pwcsName);
      end;
      Result := True;
    finally
      tmpEnum := nil;
    end;
  except
    on E: Exception do
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'GetRootKeys()']);
  end;
end;

// -----------------------------------------------------------------------------
function TStreamStorage.GetKeysName(AList: TStrings): boolean;
var
  tmpEnum: IEnumSTATSTG;
  tmpDate: TStatStg;
  Res: HResult;
begin
  Result := False;
  try
    AList.Clear();
    if (not IsKeyOpen) then
      Exit;
    Res := IStorage(FSubKeyProp.Items[FSubKeyProp.Count - 1]).EnumElements(0, nil, 0, tmpEnum);
    if (Res <> 0) then
      raise TStorageException.CreateFmt(err_Read_Root_Keys, [DecodeOleError(Res)]);
    try
      while tmpEnum.Next(1, tmpDate, nil) = S_Ok do
      try
        if (tmpDate.dwType = STGTY_STORAGE) then AList.Add(tmpDate.pwcsName);
      finally
        CoTaskMemFree(tmpDate.pwcsName);
      end;
      Result := True;
    finally
      tmpEnum := nil;
    end;
  except
    on E: Exception do
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'GetKeysName()']);
  end;
end;

// -----------------------------------------------------------------------------
function TStreamStorage.GetStreamsName(AList: TStrings): boolean;
var
  tmpEnum: IEnumSTATSTG;
  tmpDate: TStatStg;
  Res: HResult;
begin
  Result := False;
  try
    AList.Clear();
    if (not IsKeyOpen) then
      Exit;
    Res := IStorage(FSubKeyProp.Items[FSubKeyProp.Count - 1]).EnumElements(0, nil, 0, tmpEnum);
    if (Res <> 0) then
      raise TStorageException.CreateFmt(err_Read_Root_Keys, [DecodeOleError(Res)]);
    try
      while tmpEnum.Next(1, tmpDate, nil) = S_Ok do
      try
        if (tmpDate.dwType = STGTY_STREAM) then AList.Add(tmpDate.pwcsName);
      finally
        CoTaskMemFree(tmpDate.pwcsName);
      end;
      Result := True;
    finally
      tmpEnum := nil;
    end;
  except
    on E: Exception do
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'GetStreamsName()']);
  end;
end;

// -----------------------------------------------------------------------------
function TStreamStorage.WriteStream(const AName: string; AStream: TMemoryStream): boolean;
var
  tmpStream: IStream;
  Res: HResult;
begin
  Result := False;
  try
    if (not IsKeyOpen) then
      Exit;
    if IsReadOnly then
      Exit;
    if (AName = '') then
      Exit;
    if (not Assigned(AStream)) then
      Exit;
    if (IStorage(FSubKeyProp.Items[FSubKeyProp.Count - 1]).OpenStream(PWideChar(WideString(AName)), nil, STGM_READWRITE or STGM_SHARE_EXCLUSIVE, 0, tmpStream) <> S_Ok) then
    begin
      Res := IStorage(FSubKeyProp.Items[FSubKeyProp.Count - 1]).CreateStream(PWideChar(WideString(AName)), STGM_READWRITE or STGM_SHARE_EXCLUSIVE, 0, 0, tmpStream);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Write_Value, [AName, DecodeOleError(Res)]);
      AddToLog2(lgSetup, ltInformation, info_Create_New_Stream, [AName]);
    end;
    try
      Res := tmpStream.SetSize(AStream.Size);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Write_Value, [AName, DecodeOleError(Res)]);
      Res := tmpStream.Write(AStream.Memory, AStream.Size, nil);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Write_Value, [AName, DecodeOleError(Res)]);
      Res := tmpStream.Commit(STGC_DEFAULT);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Write_Value, [AName, DecodeOleError(Res)]);
      FIsChanged := True;
      Commit();
      Result := True;
    finally
      tmpStream := nil;
    end;
  except
    on E: Exception do
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'WriteStream()']);
  end;
end;

// -----------------------------------------------------------------------------
function TStreamStorage.ReadStream(const AName: string; AStream: TMemoryStream): boolean;
var
  tmpStream: IStream;
  tmpSize: Int64;
  tmpInt: Int64;
  Res: HResult;
begin
  Result := False;
  try
    if (not IsKeyOpen) then Exit;
    if (AName = '') then Exit;
    if (not Assigned(AStream)) then Exit;
    if (IStorage(FSubKeyProp.Items[FSubKeyProp.Count - 1]).OpenStream(PWideChar(WideString(AName)), nil, STGM_READ or STGM_SHARE_EXCLUSIVE, 0, tmpStream) <> S_Ok) then Exit;
    try
      Res := tmpStream.Seek(0, STREAM_SEEK_END, tmpSize);
      if (Res <> 0) then Exit;
      Res := tmpStream.Seek(0, STREAM_SEEK_SET, tmpInt);
      if (Res <> 0) then Exit;
      AStream.SetSize(tmpSize);
      Res := tmpStream.Read(AStream.Memory, tmpSize, nil);
      if (Res <> 0) then Exit;
      Result := True;
    finally
      tmpStream := nil;
    end;
  except
    on E: Exception do
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'WriteStream()']);
  end;
end;

// TPropertyStorage ------------------------------------------------------------
// -----------------------------------------------------------------------------
constructor TPropertyStorage.Create(const AStgName: string);
begin
  inherited Create();
  FSubKeyProp := TList.Create();
  FDescription := '';
  FIsChanged := False;
  FMainStorage := nil;
  FCurrentKeyName := '';
  ZeroMemory(@FCurrentKeyInfo, SizeOf(TStatPropSetStg));
  FStorageFileName := AStgName;
end;

// -----------------------------------------------------------------------------
destructor TPropertyStorage.Destroy;
begin
  if IsOpen then Close();
  FreeAndNil(FSubKeyProp);
  inherited;
end;

// -----------------------------------------------------------------------------
function TPropertyStorage.Open(): boolean;
var
  Res: HResult;
begin
  Result := False;
  try
    if IsOpen then Close();
    // Откроем хранилище
    StgOpenStorage(PWideChar(WideString(FStorageFileName)), nil,
                   STGM_TRANSACTED or STGM_READWRITE or STGM_SHARE_DENY_NONE or STGM_NOSNAPSHOT,
                   nil, 0, FMainStorage);
    // Если открыть не удалось
    if (not Assigned(FMainStorage)) then
    begin
      // Если файл существует, то удалим
      if FileExists(FStorageFileName) then
        DeleteFile(FStorageFileName);
      // Создадим новое хранилище
      Res := StgCreateDocfile(PWideChar(WideString(FStorageFileName)),
                              STGM_TRANSACTED or STGM_READWRITE or STGM_SHARE_DENY_NONE or STGM_NOSNAPSHOT,
                              0, FMainStorage);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Create_Stg, [FStorageFileName, DecodeOleError(Res)]);
      AddToLog2(lgSetup, ltInformation, info_Create_Storage, [FStorageFileName]);
      SetDescription(str_Descr_New_Storage);
      // Внесем изменения
      Res := FMainStorage.Commit(STGC_DEFAULT or STGC_CONSOLIDATE);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Set_Description, [DecodeOleError(Res)]);
    end;
    // Прочитаем описание
    ReadDescription(FMainStorage);
    Result := True;    
  except
    on E: Exception do
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'Open()']);
  end;
end;

// -----------------------------------------------------------------------------
procedure TPropertyStorage.Close();
begin
  if IsKeyOpen then CloseKey();
  FDescription := '';
  FIsChanged := False;
  FCurrentKeyName := '';
  ZeroMemory(@FCurrentKeyInfo, SizeOf(TStatPropSetStg));
  FMainStorage := nil;
end;

// -----------------------------------------------------------------------------
function TPropertyStorage.SetDescription(const ADescr: string): boolean;
var
  tmpStream: IStream;
  Res: HResult;
begin
  Result := False;
  try
    if (FDescription = ADescr) then
      Exit;
    if (not IsOpen) then
      Exit;
    if (FMainStorage.OpenStream(str_Descr_Name_Stream, nil, STGM_READWRITE or STGM_SHARE_EXCLUSIVE, 0, tmpStream) <> S_Ok) then
    begin
      Res := FMainStorage.CreateStream(str_Descr_Name_Stream, STGM_READWRITE or STGM_SHARE_EXCLUSIVE, 0, 0, tmpStream);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Set_Description, [DecodeOleError(Res)]);
    end;
    try
      Res := tmpStream.SetSize(Length(ADescr));
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Set_Description, [DecodeOleError(Res)]);
      Res := tmpStream.Write(Pointer(ADescr), Length(ADescr), nil);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Set_Description, [DecodeOleError(Res)]);
      Res := tmpStream.Commit(STGC_DEFAULT);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Set_Description, [DecodeOleError(Res)]);
      Res := FMainStorage.Commit(STGC_DEFAULT or STGC_CONSOLIDATE);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Set_Description, [DecodeOleError(Res)]);
      FDescription := ADescr;
      Result := True;
    finally
      tmpStream := nil;
    end;
  except
    on E: Exception do
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'SetDescription()']);
  end;
end;

// -----------------------------------------------------------------------------
function TPropertyStorage.ReadDescription(ARoot: IStorage): HResult;
var
  tmpStream: IStream;
  tmpSize: Int64;
  tmpInt: Int64;
begin
  FDescription := '';
  Result := $01;
  if (not IsOpen) then Exit;
  Result := FMainStorage.OpenStream(str_Descr_Name_Stream, nil, STGM_READWRITE or STGM_SHARE_EXCLUSIVE, 0, tmpStream);
  if (Result <> 0) then Exit;
  try
    Result := tmpStream.Seek(0, STREAM_SEEK_END, tmpSize);
    if (Result <> 0) then Exit;
    Result := tmpStream.Seek(0, STREAM_SEEK_SET, tmpInt);
    if (Result <> 0) then Exit;
    SetLength(FDescription, tmpSize);
    Result := tmpStream.Read(Pointer(FDescription), tmpSize, nil);
    if (Result <> 0) then Exit;
  finally
    tmpStream := nil;
  end;
end;

// -----------------------------------------------------------------------------
procedure TPropertyStorage.ReadValue(const AName: string; var AValue: TPropVariant);
var
  tmpPropInfo: TPropSpec;
  Res: HResult;
begin
  tmpPropInfo.ulKind := PRSPEC_LPWSTR;
  tmpPropInfo.lpwstr := PWideChar(WideString(AName));
  Res := IPropertyStorage(FSubKeyProp.Items[FSubKeyProp.Count - 1]).ReadMultiple(1, @tmpPropInfo, @AValue);
  if (Res <> 0)and(Res <> $01) then
    raise TStorageException.CreateFmt(err_Read_Value, [AName, DecodeOleError(Res)]);
end;

// -----------------------------------------------------------------------------
procedure TPropertyStorage.WriteValue(const AName: string; var AValue: TPropVariant);
var
  tmpPropInfo: TPropSpec;
  Res: HResult;
begin
  tmpPropInfo.ulKind := PRSPEC_LPWSTR;
  tmpPropInfo.lpwstr := PWideChar(WideString(AName));
  Res := IPropertyStorage(FSubKeyProp.Items[FSubKeyProp.Count - 1]).WriteMultiple(1, @tmpPropInfo, @AValue, PID_FIRST_USABLE);
  if (Res <> 0) then
    raise TStorageException.CreateFmt(err_Write_Value, [AName, DecodeOleError(Res)]);
  FIsChanged := True;
end;

// -----------------------------------------------------------------------------
function TPropertyStorage.GetIsKeyOpen(): boolean;
begin
  Result := (FSubKeyProp.Count <> 0);
end;

// -----------------------------------------------------------------------------
function TPropertyStorage.GetIsOpen(): boolean;
begin
  Result := Assigned(FMainStorage);
end;

// -----------------------------------------------------------------------------
procedure TPropertyStorage.Commit();
var
  n: integer;
  Res: HResult;
begin
  try
    if IsChanged then
    begin
      for n := FSubKeyProp.Count - 1 downto 0 do
      begin
        Res := IPropertyStorage(FSubKeyProp.Items[n]).Commit(STGC_DEFAULT);
        if (Res <> 0) then
          raise TStorageException.CreateFmt(err_Commit_Storage, [(n + 1), DecodeOleError(Res)]);
      end;
      Res := FMainStorage.Commit(STGC_DEFAULT or STGC_CONSOLIDATE);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Commit_Storage, [0, DecodeOleError(Res)]);
      FIsChanged := False;
    end;
  except
    on E: Exception do
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'Commit()']);
  end;
end;

// -----------------------------------------------------------------------------
function TPropertyStorage.OpenSubKey(ARoot: IStorage; const AKeyName: string; const AFullKeyName: string; AIsReadOnly: boolean): boolean;
var
  Res: HResult;
  tmpPropId: TPropID;
  tmpStr: POleStr;
  tmpCurPropStg: IPropertySetStorage;
  tmpProp: IPropertyStorage;
  tmpGUID: TGUID;

  function MakeGUIDByName(const AStr: string): TGUID;
  var
    m: integer;
    tmpStr: string[16];
  begin
    ZeroMemory(@Result, SizeOf(TGUID));
    ZeroMemory(@tmpStr, SizeOf(tmpStr));
    tmpStr := AStr;
    Result.D1 := MakeLong(MakeWord(byte(tmpStr[1]),byte(tmpStr[2])), MakeWord(byte(tmpStr[3]), byte(tmpStr[4])));
    Result.D2 := MakeWord(byte(tmpStr[5]), byte(tmpStr[6]));
    Result.D3 := MakeWord(byte(tmpStr[7]), byte(tmpStr[8]));
    for m:=0 to 7 do
      Result.D4[m] := byte(tmpStr[9 + m]);
  end;

begin
  Result := False;
  tmpGUID := MakeGUIDByName(AKeyName);
  Res := StgCreatePropSetStg(ARoot, 0, tmpCurPropStg);
  if (Res <> 0) then
    raise TStorageException.CreateFmt(err_Create_Sub_Storage, [DecodeOleError(Res)]);
  Res := tmpCurPropStg.Open(tmpGUID, STGM_TRANSACTED or STGM_READWRITE or STGM_SHARE_EXCLUSIVE, tmpProp);
  if (Res <> 0) then
  begin
    if AIsReadOnly then
      Exit;
    Res := tmpCurPropStg.Create(tmpGUID, PGUID(nil)^, PROPSETFLAG_NONSIMPLE or PROPSETFLAG_ANSI, STGM_TRANSACTED or STGM_READWRITE or STGM_SHARE_EXCLUSIVE, tmpProp);
    if (Res <> 0) then
      raise TStorageException.CreateFmt(err_Create_Sub_Key, [AKeyName, DecodeOleError(Res)]);
    tmpPropId := PID_DICTIONARY;
    tmpStr := PWideChar(WideString(AKeyName));
    Res := tmpProp.WritePropertyNames(1, @tmpPropId, @tmpStr);
    if (Res <> 0) then
     raise TStorageException.CreateFmt(err_Set_Key_Name, [AKeyName, DecodeOleError(Res)]);
    FIsChanged := True;
    AddToLog2(lgSetup, ltInformation, info_Create_Key, [AFullKeyName, AKeyName]);
  end;
  tmpProp._AddRef();
  tmpProp.Stat(@FCurrentKeyInfo);
  FSubKeyProp.Add(Pointer(tmpProp));
  Commit();
  Result := True;
end;

// -----------------------------------------------------------------------------
function TPropertyStorage.OpenSubKeys(const AKeyName: string; const AFullKeyName: string; AIsReadOnly: boolean): boolean;
var
  tmpPath: string;
  tmpKey: string;
  tmpPropVal: TPropVariant;
begin
  Result := False;
  tmpPath := ExcludeTrailingBackslash(ExtractFilePath(AKeyName));
  tmpKey := ExtractFileName(AKeyName);
  if (tmpPath <> '') then
  begin
    if (not OpenSubKeys(tmpPath, AFullKeyName, AIsReadOnly)) then Exit;
    ReadValue(tmpKey, tmpPropVal);
    if (tmpPropVal.vt <> VT_STORAGE) then
    begin
      if AIsReadOnly then Exit;
      tmpPropVal.vt := VT_STORAGE;
      tmpPropVal.pStorage := nil;
      WriteValue(tmpKey, tmpPropVal);
      Commit();
      ReadValue(tmpKey, tmpPropVal);
    end;
    Result := OpenSubKey(IStorage(tmpPropVal.pStorage), tmpKey, tmpPath, AIsReadOnly);
  end else
    Result := OpenSubKey(FMainStorage, tmpKey, '', AIsReadOnly);
end;

// -----------------------------------------------------------------------------
function TPropertyStorage.OpenKey(const AKey: string; AIsReadOnly: boolean = False): boolean;
var
  tmpKeyName: string;
begin
  Result := False;
  try
    if (not IsOpen) then Exit;
    if IsKeyOpen then
    begin
      tmpKeyName := IncludeTrailingBackslash(FCurrentKeyName) + ExcludeTrailingBackslash(AKey);
      CloseKey;
    end else
      tmpKeyName := ExcludeTrailingBackslash(AKey);
    Result := OpenSubKeys(tmpKeyName, tmpKeyName, AIsReadOnly);
    FCurrentKeyName := tmpKeyName;
    if (not Result) then CloseKey();
  except
    on E: Exception do
    begin
      CloseKey();
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'OpenKey()']);
    end;
  end;
end;

// -----------------------------------------------------------------------------
procedure TPropertyStorage.CloseKey();
var
  n: integer;
begin
  try
    try
      Commit();
      for n:=FSubKeyProp.Count - 1 downto 0 do
      begin
        IPropertyStorage(FSubKeyProp.Items[n])._Release();
        FSubKeyProp.Items[n] := nil;
      end;
      if (FSubKeyProp.Count > 0) then
        while FSubKeyProp.Count <> 0 do
          FSubKeyProp.Delete(FSubKeyProp.Count - 1);
    finally
      ZeroMemory(@FCurrentKeyInfo, SizeOf(TStatPropSetStg));
      FCurrentKeyName := '';
    end;
  except
    on E: Exception do
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'CloseKey()']);
  end;
end;

// -----------------------------------------------------------------------------
function TPropertyStorage.ReadString(const AIdent: string; const ADefault: string): string;
var
  tmpPropVal: TPropVariant;
begin
  ReadValue(AIdent, tmpPropVal);
  if (tmpPropVal.vt = VT_LPSTR) then
    Result := tmpPropVal.pszVal
  else
    Result := ADefault;
end;

// -----------------------------------------------------------------------------
function TPropertyStorage.ReadBoolean(const AIdent: string; ADefault: boolean): boolean;
var
  tmpPropVal: TPropVariant;
begin
  ReadValue(AIdent, tmpPropVal);
  if (tmpPropVal.vt = VT_BOOL) then
    Result := tmpPropVal.boolVal
  else
    Result := ADefault;
end;

// -----------------------------------------------------------------------------
function TPropertyStorage.ReadInteger(const AIdent: string; ADefault: Integer): Integer;
var
  tmpPropVal: TPropVariant;
begin
  ReadValue(AIdent, tmpPropVal);
  if (tmpPropVal.vt = VT_I4) then
    Result := tmpPropVal.lVal
  else
    Result := ADefault;
end;

// -----------------------------------------------------------------------------
function TPropertyStorage.ReadFloat(const AIdent: string; ADefault: Double): Double;
var
  tmpPropVal: TPropVariant;
begin
  ReadValue(AIdent, tmpPropVal);
  if (tmpPropVal.vt = VT_R8) then
    Result := tmpPropVal.dblVal
  else
    Result := ADefault;
end;

// -----------------------------------------------------------------------------
function TPropertyStorage.ReadDateTime(const AIdent: string; ADefault: TDateTime): TDateTime;
var
  tmpPropVal: TPropVariant;
begin
  ReadValue(AIdent, tmpPropVal);
  if (tmpPropVal.vt = VT_DATE) then
    Result := tmpPropVal.date
  else
    Result := ADefault;
end;

// -----------------------------------------------------------------------------
procedure TPropertyStorage.WriteString(const AIdent: string; const AValue: AnsiString);
var
  tmpPropVal: TPropVariant;
begin
  ReadValue(AIdent, tmpPropVal);
  if (tmpPropVal.vt <> VT_LPSTR)or(tmpPropVal.pszVal <> AValue) then
  begin
    tmpPropVal.vt := VT_LPSTR;
    tmpPropVal.pszVal := PAnsiChar(AValue);
    WriteValue(AIdent, tmpPropVal);
  end;
end;

// -----------------------------------------------------------------------------
procedure TPropertyStorage.WriteBoolean(const AIdent: string; AValue: boolean);
var
  tmpPropVal: TPropVariant;
begin
  ReadValue(AIdent, tmpPropVal);
  if (tmpPropVal.vt <> VT_BOOL)or(tmpPropVal.boolVal <> AValue) then
  begin
    tmpPropVal.vt := VT_BOOL;
    tmpPropVal.boolVal := AValue;
    WriteValue(AIdent, tmpPropVal);
  end;
end;

// -----------------------------------------------------------------------------
procedure TPropertyStorage.WriteInteger(const AIdent: string; AValue: Integer);
var
  tmpPropVal: TPropVariant;
begin
  ReadValue(AIdent, tmpPropVal);
  if (tmpPropVal.vt <> VT_I4)or(tmpPropVal.lVal <> AValue) then
  begin
    tmpPropVal.vt := VT_I4;
    tmpPropVal.lVal := AValue;
    WriteValue(AIdent, tmpPropVal);
  end;
end;

// -----------------------------------------------------------------------------
procedure TPropertyStorage.WriteFloat(const AIdent: string; AValue: Double);
var
  tmpPropVal: TPropVariant;
begin
  ReadValue(AIdent, tmpPropVal);
  if (tmpPropVal.vt <> VT_R8)or(tmpPropVal.dblVal <> AValue) then
  begin
    tmpPropVal.vt := VT_R8;
    tmpPropVal.dblVal := AValue;
    WriteValue(AIdent, tmpPropVal);
  end;
end;

// -----------------------------------------------------------------------------
procedure TPropertyStorage.WriteDateTime(const AIdent: string; AValue: TDateTime);
var
  tmpPropVal: TPropVariant;
begin
  ReadValue(AIdent, tmpPropVal);
  if (tmpPropVal.vt <> VT_DATE)or(tmpPropVal.date <> AValue) then
  begin
    tmpPropVal.vt := VT_DATE;
    tmpPropVal.date := AValue;
    WriteValue(AIdent, tmpPropVal);
  end;
end;

// -----------------------------------------------------------------------------
function TPropertyStorage.GetRootKeys(AList: TStrings): boolean;
var
  tmpCurPropStg: IPropertySetStorage;
  tmpPorpStg: IPropertyStorage;
  tmpEnum: IEnumSTATPROPSETSTG;
  tmpDate: TStatPropSetStg;
  tmpPropId: TPropID;
  tmpStr: POleStr;
  Res: HResult;
begin
  Result := False;
  try
    AList.Clear();
    if (not Assigned(FMainStorage)) then Exit;
    try
      Res := StgCreatePropSetStg(FMainStorage, 0, tmpCurPropStg);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Read_Root_Keys, [DecodeOleError(Res)]);
      Res := tmpCurPropStg.Enum(tmpEnum);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Read_Root_Keys, [DecodeOleError(Res)]);
      while tmpEnum.Next(1, tmpDate, nil) = S_Ok do
      try
        Res := tmpCurPropStg.Open(tmpDate.fmtid, STGM_TRANSACTED or STGM_READWRITE or STGM_SHARE_EXCLUSIVE, tmpPorpStg);
        if (Res <> 0) then
          raise TStorageException.CreateFmt(err_Read_Root_Keys, [DecodeOleError(Res)]);
        tmpPropId := PID_DICTIONARY;
        Res := tmpPorpStg.ReadPropertyNames(1, @tmpPropId, @tmpStr);
        if (Res <> 0) then
          raise TStorageException.CreateFmt(err_Read_Root_Keys, [DecodeOleError(Res)]);
        AList.Add(tmpStr);
        CoTaskMemFree(tmpStr);
        tmpStr := nil;
      finally
        tmpPorpStg := nil;
      end;
      Result := True;
    finally
      tmpEnum := nil;
      tmpCurPropStg := nil;
    end;
  except
    on E: Exception do
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'GetRootKeys()']);
  end;
end;

// -----------------------------------------------------------------------------
function TPropertyStorage.GetKeyNames(AList: TStrings): boolean;
var
  tmpEnum: IEnumSTATPROPSTG;
  tmpDataProp: TStatPropStg;
  Res: HResult;
begin
  Result := False;
  try
    AList.Clear();
    if (not IsKeyOpen) then Exit;
    try
      Res := IPropertyStorage(FSubKeyProp.Items[FSubKeyProp.Count - 1]).Enum(tmpEnum);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Read_Key_Names, [DecodeOleError(Res)]);
      while tmpEnum.Next(1, tmpDataProp, nil) = S_Ok do
      begin
        if (tmpDataProp.vt = VT_STORAGE) then
          Alist.Add(tmpDataProp.lpwstrName);
        CoTaskMemFree(tmpDataProp.lpwstrName);
        tmpDataProp.lpwstrName := nil;
      end;
      Result := True;
    finally
      tmpEnum := nil;
    end;
  except
    on E: Exception do
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'GetKeyNames()']);
  end;
end;

// -----------------------------------------------------------------------------
function TPropertyStorage.GetValueNames(AList: TStrings): boolean;
var
  tmpEnum: IEnumSTATPROPSTG;
  tmpDataProp: TStatPropStg;
  Res: HResult;
begin
  Result := False;
  try
    AList.Clear();
    if (not IsKeyOpen) then Exit;
    try
      Res := IPropertyStorage(FSubKeyProp.Items[FSubKeyProp.Count - 1]).Enum(tmpEnum);
      if (Res <> 0) then
        raise TStorageException.CreateFmt(err_Read_Value_Names, [DecodeOleError(Res)]);
      while tmpEnum.Next(1, tmpDataProp, nil) = S_Ok do
      begin
        if (tmpDataProp.vt <> VT_STORAGE) then
          Alist.Add(tmpDataProp.lpwstrName);
        CoTaskMemFree(tmpDataProp.lpwstrName);
        tmpDataProp.lpwstrName := nil;
      end;
      Result := True;
    finally
      tmpEnum := nil;
    end;
  except
    on E: Exception do
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'GetValueNames()']);
  end;
end;

// -----------------------------------------------------------------------------
function TPropertyStorage.GetValueType(const AIdent: string): TValueType;
var
  tmpPropInfo: TPropSpec;
  tmpPropVal: TPropVariant;
  Res: HResult;
begin
  Result := vtUnknown;
  if (not IsKeyOpen) then Exit;
  tmpPropInfo.ulKind := PRSPEC_LPWSTR;
  tmpPropInfo.lpwstr := PWideChar(WideString(AIdent));
  Res := IPropertyStorage(FSubKeyProp.Items[FSubKeyProp.Count - 1]).ReadMultiple(1, @tmpPropInfo, @tmpPropVal);
  if (Res <> 0)and(Res <> $01) then
    raise TStorageException.CreateFmt(err_Read_Value, [AIdent, DecodeOleError(Res)]);
  case tmpPropVal.vt of
    VT_STORAGE: Result := vtStorage;
    VT_LPSTR:   Result := vtString;
    VT_BOOL:    Result := vtBool;
    VT_I4:      Result := vtInt;
    VT_R8:      Result := vtFloat;
    VT_DATE:    Result := vtDateTime;
  end;
end;

// -----------------------------------------------------------------------------
function TPropertyStorage.ClearKey(): boolean;
var
  tmpList: TStringList;
  n: integer;
begin
  Result := False;
  try
    if (not IsKeyOpen) then Exit;
    tmpList := TStringList.Create();
    try
      if (not GetValueNames(tmpList)) then Exit;
      for n:=0 to tmpList.Count - 1 do
        DeleteValue(tmpList[n]);
      if (not GetKeyNames(tmpList)) then Exit;
      for n:=0 to tmpList.Count - 1 do
        DeleteSubKey(tmpList[n]);
      FIsChanged := True;
      Result := True;
    finally
      FreeAndNil(tmpList);
    end;
  except
    on E: Exception do
      AddToLog2(lgSetup, ltError, err_Exception_Str, [E.Message, Self.ClassName, 'ClearKey()']);
  end;
end;

// -----------------------------------------------------------------------------
procedure TPropertyStorage.DeleteSubKey(const AIdent: string);
var
  tmpPropInfo: TPropSpec;
  Res: HResult;
begin
  if (not IsKeyOpen) then Exit;
  if (GetValueType(AIdent) = vtStorage) then
  begin
    tmpPropInfo.ulKind := PRSPEC_LPWSTR;
    tmpPropInfo.lpwstr := PWideChar(WideString(AIdent));
    Res := IPropertyStorage(FSubKeyProp.Items[FSubKeyProp.Count - 1]).DeleteMultiple(1, @tmpPropInfo);
    if (Res <> 0) then
      raise TStorageException.CreateFmt(err_Delete_Sub_Key, [CurrentKeyName, AIdent, DecodeOleError(Res)]);
    FIsChanged := True;
  end;
end;

// -----------------------------------------------------------------------------
procedure TPropertyStorage.DeleteValue(const AIdent: string);
var
  tmpPropInfo: TPropSpec;
  Res: HResult;
begin
  if (not IsKeyOpen) then Exit;
  if (GetValueType(AIdent) <> vtStorage) then
  begin
    tmpPropInfo.ulKind := PRSPEC_LPWSTR;
    tmpPropInfo.lpwstr := PWideChar(WideString(AIdent));
    Res := IPropertyStorage(FSubKeyProp.Items[FSubKeyProp.Count - 1]).DeleteMultiple(1, @tmpPropInfo);
    if (Res <> 0) then
      raise TStorageException.CreateFmt(err_Delete_Value, [CurrentKeyName, AIdent, DecodeOleError(Res)]);
    FIsChanged := True;
  end;
end;

end.
