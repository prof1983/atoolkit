{**
@Abstract(Базовый класс для любого хранилища настроек)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.02.2007)
@LastMod(25.05.2012)
@Version(0.5)

http://www.realcoding.net/article/view/2591 - XML сериализация объекта Delphi
}
unit AStorageImpl;

// TODO: При записи и чтении значений Float сделать запись с разделителем '.' Например: 123.456

interface

uses
  Classes, TypInfo,
  AReaderIntf, {uProfIntf,} AStorageIntf, AWriterIntf; {unProfStorageTypes;}

type
{$M+}
  //** @abstract(Базовый класс для создания вложеных веток сохранения параметров)
  TParamItem = class(TInterfacedObject);

  {**
    @abstract(Класс для сохранения параметров вида @code(<имя> = <значение>).)

    Данный класс просто указывает что строки нужно сохранять в указанном виде.
    Если в качестве параметра выступает объект класса @code(TStringList), то
    параметры сохраняются в виде @code(<№ п/п> = <значение>).
  }
  TParamStringList    = class(TStringList)
  end;

  {**
    @abstract(Базовый класс для любого хранилища настроек)
    Данный класс автоматический осуществляет сохранение и чтение параметров
    объявленных в разделе @code(published) в локальное хранилище программы.
  }
  TProfStorage = class(TInterfacedObject, IStorageReader, IStorageWriter)
  private
    //** Объект для чтения настроек
    FReader: IStorageReader;
    //** Объект для записи настроек
    FWriter: IStorageWriter;
  protected
    //** Процедура загрузки(сохранения) всех параметров, находящихся в секции published класса
    function ProcessLoadObject(AObj: TObject; AReader: IProfReader2): WordBool;
    //** Процедура сохранения всех параметров, находящихся в секции published класса
    function ProcessSaveObject(AObj: TObject; AWriter: IProfWriter2): WordBool;
  protected
    //** Получить элемент для чтения параметров дочернего нода
    function GetReaderByName(const Name: WideString): IProfReader2; safecall;
    //** Получить элемент для записи параметров дочернего нода
    function GetWriterByName(const Name: WideString): IProfWriter2; safecall;
  public
    //** Не используется
    procedure Close(); safecall;
    //** Не используется
    function Open(): WordBool; safecall;
    //** Прочитать параметр Bool
    function ReadBool(const Name: WideString; var Value: WordBool): WordBool; safecall;
    //** Прочитать параметр Bool
    function ReadBoolDef(const Name: WideString; DefValue: WordBool): WordBool; safecall;
    //** Прочитать параметр DateTime
    function ReadDateTime(const Name: WideString; var Value: TDateTime): WordBool; safecall;
    //** Прочитать параметр DateTime
    function ReadDateTimeDef(const Name: WideString; DefValue: TDateTime): TDateTime; safecall;
    //** Прочитать параметр Float64
    function ReadFloat64(const Name: WideString; var Value: Double): WordBool; safecall;
    //** Прочитать параметр Float64
    function ReadFloat64Def(const Name: WideString; DefValue: Double): Double; safecall;
    //** Прочитать параметр Int32
    function ReadInt32(const Name: WideString; var Value: Integer): WordBool; safecall;
    //** Прочитать параметр Int32
    function ReadInt32Def(const Name: WideString; DefValue: Integer): Integer; safecall;
    //** Прочитать параметр Int64
    function ReadInt64(const Name: WideString; var Value: Int64): WordBool; safecall;
    //** Прочитать параметр Int64
    function ReadInt64Def(const Name: WideString; DefValue: Int64): Int64; safecall;
    //** Прочитать параметр String
    function ReadString(const Name: WideString; var Value: WideString): WordBool; safecall;
    //** Прочитать параметр String
    function ReadStringDef(const Name: WideString; const DefValue: WideString): WideString; safecall;
    //** Записать параметр Bool
    function WriteBool(const Name: WideString; Value: WordBool): WordBool; safecall;
    //** Записать параметр DateTime
    function WriteDateTime(const Name: WideString; Value: TDateTime): WordBool; safecall;
    //** Записать параметр Float64
    function WriteFloat64(const Name: WideString; Value: Double): WordBool; safecall;
    //** Записать параметр Int32
    function WriteInt32(const Name: WideString; Value: Integer): WordBool; safecall;
    //** Записать параметр Int64
    function WriteInt64(const Name: WideString; Value: Int64): WordBool; safecall;
    //** Записать параметр String
    function WriteString(const Name, Value: WideString): WordBool; safecall;
  public
    //** Прочитать все настройки
    function ReadAll(): WordBool;
    //** Записать все настройки
    function WriteAll(): WordBool;
  public
    //** Объект для чтения настроек
    property Reader: IStorageReader read FReader write FReader;
    //** Вложеные ветки (для чтения)
    property ReaderByName[const Name: WideString]: IProfReader2 read GetReaderByName;
    //** Объект для записи настроек
    property Writer: IStorageWriter read FWriter write FWriter;
    //** Вложеные ветки (для записи)
    property WriterByName[const Name: WideString]: IProfWriter2 read GetWriterByName;
  published
    // Сохраняемые параметры должны находится здесь в виде property
  end;
{$M-}

implementation

{ TProfStorage }

procedure TProfStorage.Close();
begin
  try
    if Assigned(FReader) then
      FReader.Close();
    if Assigned(FWriter) then
      FWriter.Close();
  except
  end;
end;

function TProfStorage.GetReaderByName(const Name: WideString): IProfReader2;
begin
  Result := nil;
  if Assigned(FReader) then
  try
    Result := FReader.ReaderByName[Name];
  except
  end;
end;

function TProfStorage.GetWriterByName(const Name: WideString): IProfWriter2;
begin
  Result := nil;
  if Assigned(FWriter) then
  try
    Result := FWriter.WriterByName[Name];
  except
  end;
end;

function TProfStorage.Open(): WordBool;
begin
  Result := False;
  // ...
end;

function TProfStorage.ProcessLoadObject(AObj: TObject; AReader: IProfReader2): WordBool;

    procedure LoadIntegerProps(const APropInfo: TPropInfo);
    var
      tmp: Integer;
    begin
      if AReader.ReadInt32(APropInfo.Name, tmp) and (APropInfo.SetProc <> nil) then
        SetOrdProp(AObj, APropInfo.Name, tmp);
    end;

    procedure LoadFloatProps(const APropInfo: TPropInfo);
    var
      tmp: Double;
    begin
      if AReader.ReadFloat64(APropInfo.Name, tmp) and (APropInfo.SetProc <> nil) then
        SetFloatProp(AObj, APropInfo.Name, tmp);
    end;

    procedure LoadStringProps(const APropInfo: TPropInfo);
    var
      tmp: WideString;
    begin
      if AReader.ReadString(APropInfo.Name, tmp) and (APropInfo.SetProc <> nil) then
        SetStrProp(AObj, APropInfo.Name, tmp);
    end;

    procedure LoadStringListProps(const APropInfo: TPropInfo);
    var
      tmpStrings: TStrings;
      //n: Integer;
    begin
      // TODO: Реализовать

      tmpStrings := (GetObjectProp(AObj, APropInfo.Name, TStrings) as TStrings);
      if (not Assigned(tmpStrings)) then Exit;

      if GetObjectPropClass(AObj, APropInfo.Name).InheritsFrom(TParamStringList) then
      begin
//        for n := 0 to tmpStrings.Count - 1 do
//        begin
//          tmpStr := tmpStrings[n];
//          AList.Values[tmpStr] := FStorage.ReadString(tmpStr, tmpStr);
//        end;
      end
      else
      begin
//        for n := 0 to tmpStrings.Count - 1 do
//          AList.Add(FStorage.ReadString(IntToStr(n + 1), IntToStr(n + 1)));
      end;

//      APropInfo.Name
//      tmpStrings

//      if (FStorage.GetValueType(APropInfo.Name) = vtStorage) then
//        ReadStringList(GetObjectPropClass(AObj, APropInfo.Name).InheritsFrom(TParamStringList), APropInfo.Name, tmpStrings)
//      else begin
//        WriteStringList(GetObjectPropClass(AObj, APropInfo.Name).InheritsFrom(TParamStringList), APropInfo.Name, tmpStrings);
//        AddToLog(lgSetup, ltInformation, info_Change_Param_Str, [GetPrmDesc(APrefix, AObj, APropInfo.Name), '', tmpStrings.CommaText]);
//      end;
    end;

    {procedure LoadCollectionProps(const APropInfo: TPropInfo);
    var
      tmpCollection: TSetupRecCollection;
      tmpStringList: TStringList;
      tmpOldKeyName: string;
      m: integer;
    begin
      // Проверим на соответствие типов
      tmpCollection := (GetObjectProp(AObj, APropInfo.Name, TSetupRecCollection) as TSetupRecCollection);
      if (not tmpCollection.ItemClass.InheritsFrom(TSetupRecItem)) then Exit;
      tmpStringList := TStringList.Create;
      tmpOldKeyName := FStorage.CurrentKeyName;
      try
        // Откроем ключь
        FStorage.CloseKey();
        FStorage.OpenKey(IncludeTrailingBackslash(tmpOldKeyName) + APropInfo.Name);
        // Получим список сохранненых объектов
        FStorage.GetKeyNames(tmpStringList);
        // Закроем ключ
        FStorage.CloseKey();
        // Добавим новые элементы в случае необходимости
        for m:=0 to tmpStringList.Count - 1 do
          try
            tmpCollection.Add(StrToInt(tmpStringList.Strings[m]));
          except
          end;
        // Загрузим параметры по каждому элементу
        for m:=0 to tmpCollection.Count - 1 do
          ProcessLoadObject(GetPrmDesc(APrefix, AObj, APropInfo.Name), tmpCollection.ItemsByIndex[m], AReestrKey + '\' + APropInfo.Name + '\' + IntToStr(tmpCollection.ItemsByIndex[m].ID));
      finally
        FreeAndNil(tmpStringList);
        FStorage.CloseKey();
        FStorage.OpenKey(tmpOldKeyName);
      end;
    end;}

    procedure LoadClassProps(const APropInfo: TPropInfo);
    var
      //tmpOldKeyName: string;
      obj: TObject;
    begin
      try
        obj := GetObjectProp(AObj, APropInfo.Name, TObject);
        if Assigned(obj) then
          ProcessLoadObject(obj, ReaderByName[APropInfo.Name])
      except
      end;

//      tmpOldKeyName := FStorage.CurrentKeyName;
//      try // Не работает!!!  Если читаем объект, то в функции tmpTypeData := GetTypeData(AObj.ClassInfo); возникает ошибка
//        FStorage.CloseKey();
//        obj := GetObjectProp(AObj, APropInfo.Name, TObject);
//        if Assigned(obj) then
//          ProcessLoadObject(GetPrmDesc(APrefix, AObj, APropInfo.Name), obj{GetObjectProp(AObj, APropInfo.Name, TObject)}, AReestrKey + '\' + APropInfo.Name)
//      finally
//        FStorage.CloseKey();
//        FStorage.OpenKey(tmpOldKeyName);
//      end;
    end;

var
  tmpTypeData: PTypeData; // Информация о свойствах
  tmpList: PPropList;
  n: Integer;             // Колличество свойств
  i: Integer;             // Счетчик
begin
  Result := Assigned(AReader);
  if not(Result) then Exit;
  // Получим информацию о свойствах
  tmpTypeData := GetTypeData(AObj.ClassInfo);
  n := tmpTypeData.PropCount;
  if (n <= 0) then Exit;
  GetMem(tmpList, SizeOf(PPropInfo) * n);
  // Прочитаем значения свойств из реестра
  try
    GetPropInfos(AObj.ClassInfo, tmpList);
    for i:= 0 to n - 1 do
      case tmpList[i].PropType^.Kind of
        tkInteger, tkEnumeration, tkSet, tkChar:
          LoadIntegerProps(tmpList[i]^);
        tkFloat:
          LoadFloatProps(tmpList[i]^);
        tkString, tkWChar, tkLString, tkWString:
          LoadStringProps(tmpList[i]^);
        tkClass:
          begin
            if GetObjectPropClass(AObj, tmpList[i]).InheritsFrom(TStrings) then
              LoadStringListProps(tmpList[i]^) // Сохраним список
            //else if GetObjectPropClass(AObj, tmpList[i]).InheritsFrom(TSetupRecCollection) then
            //  LoadCollectionProps(tmpList[i]^) // Сохраним список объектов
            else
              LoadClassProps(tmpList[i]^); // Обработаем произвольный класс
          end;
    end;
  finally
    FreeMem(tmpList, SizeOf(PPropInfo) * n);
  end;
end;

function TProfStorage.ProcessSaveObject(AObj: TObject; AWriter: IProfWriter2): WordBool;

    procedure SaveIntegerProps(const APropInfo: TPropInfo);
    begin
      AWriter.WriteInt32(APropInfo.Name, GetOrdProp(AObj, APropInfo.Name));
    end;

    procedure SaveFloatProps(const APropInfo: TPropInfo);
    begin
      AWriter.WriteFloat64(APropInfo.Name, GetFloatProp(AObj, APropInfo.Name));
    end;

    procedure SaveStringProps(const APropInfo: TPropInfo);
    begin
      AWriter.WriteString(APropInfo.Name, GetStrProp(AObj, APropInfo.Name));
    end;

    procedure SaveStringListProps(const APropInfo: TPropInfo);
    {var
      tmpStrings: TStrings;
      tmpIsChangeList: boolean;
      tmpOldStrings: TStringList;
      tmpStr: string;
      k: integer;}
    begin
      {tmpStrings := (GetObjectProp(AObj, APropInfo.Name, TStrings) as TStrings);
      if (not Assigned(tmpStrings)) then Exit;
      if (FStorage.GetValueType(APropInfo.Name) = vtStorage) then
      begin
        tmpOldStrings := TStringList.Create();
        try
          ReadStringList(GetObjectPropClass(AObj, APropInfo.Name).InheritsFrom(TParamStringList), APropInfo.Name, tmpOldStrings);
          tmpIsChangeList := False;
          if GetObjectPropClass(AObj, APropInfo.Name).InheritsFrom(TParamStringList) then
          begin
            // Проверим на добавление элементов
            for k:=0 to tmpStrings.Count - 1 do
            begin
              tmpStr := tmpStrings.Names[k];
              if (tmpOldStrings.IndexOfName(tmpStr) < 0) then
              begin
                AddToLog(lgSetup, ltInformation, info_Change_Param_List, [GetPrmDesc(APrefix, AObj, APropInfo.Name), tmpStr, '', tmpStrings.Values[tmpStr]]);
                tmpIsChangeList := True;
              end;
            end;
            // Проверим на удаление элементов
            for k:=0 to tmpOldStrings.Count - 1 do
            begin
              tmpStr := tmpOldStrings.Names[k];
              if (tmpStrings.IndexOfName(tmpStr) < 0) then
              begin
                AddToLog(lgSetup, ltInformation, info_Change_Param_List, [GetPrmDesc(APrefix, AObj, APropInfo.Name), tmpStr, tmpOldStrings.Values[tmpStr], '']);
                tmpIsChangeList := True;
              end;
            end;
            // Проверим на изменение элементов
            for k:=0 to tmpStrings.Count - 1 do
            begin
              tmpStr := tmpStrings.Names[k];
              if (tmpOldStrings.IndexOfName(tmpStr) >= 0) then
                if (tmpOldStrings.Values[tmpStr] <> tmpStrings.Values[tmpStr]) then
                begin
                  AddToLog(lgSetup, ltInformation, info_Change_Param_List, [GetPrmDesc(APrefix, AObj, APropInfo.Name), tmpStr, tmpOldStrings.Values[tmpStr], tmpStrings.Values[tmpStr]]);
                  tmpIsChangeList := True;
                end;
            end;
          end else
          begin
            // Проверим на добавление элементов
            for k:=0 to tmpStrings.Count - 1 do
              if (tmpOldStrings.IndexOf(tmpStrings.Strings[k]) < 0) then
              begin
                AddToLog(lgSetup, ltInformation, info_Add_Param_List, [GetPrmDesc(APrefix, AObj, APropInfo.Name), tmpStrings.Strings[k]]);
                tmpIsChangeList := True;
              end;
            // Проверим на удаление элементов
            for k:=0 to tmpOldStrings.Count - 1 do
              if (tmpStrings.IndexOf(tmpOldStrings.Strings[k]) < 0) then
              begin
                AddToLog(lgSetup, ltInformation, info_Delete_Param_List, [GetPrmDesc(APrefix, AObj, APropInfo.Name), tmpOldStrings.Strings[k]]);
                tmpIsChangeList := True;
              end;
          end;
          // Если изменился, то запишем
          if tmpIsChangeList then
          begin
            WriteStringList(GetObjectPropClass(AObj, APropInfo.Name).InheritsFrom(TParamStringList), APropInfo.Name, tmpStrings);
            Result := True;
          end;
        finally
          FreeAndNil(tmpOldStrings);
        end;
      end else
      begin
        WriteStringList(GetObjectPropClass(AObj, APropInfo.Name).InheritsFrom(TParamStringList), APropInfo.Name, tmpStrings);
        AddToLog(lgSetup, ltInformation, info_Change_Param_Str, [GetPrmDesc(APrefix, AObj, APropInfo.Name), '', tmpStrings.CommaText]);
        Result := True;
      end;}
    end;

    {procedure SaveCollectionProps(const APropInfo: TPropInfo);
    var
      tmpCollection: TSetupRecCollection;
      tmpOldKeyName: string;
      tmpStringList: TStringList;
      m: integer;
    begin
      tmpCollection := (GetObjectProp(AObj, APropInfo.Name, TSetupRecCollection) as TSetupRecCollection);
      if (not tmpCollection.ItemClass.InheritsFrom(TSetupRecItem)) then Exit;
      tmpOldKeyName := FStorage.CurrentKeyName;
      tmpStringList := TStringList.Create;
      try
        // Откроем ключь
        FStorage.CloseKey();
        FStorage.OpenKey(IncludeTrailingBackslash(tmpOldKeyName) + APropInfo.Name);
        // Получим список сохранненых объектов
        FStorage.GetKeyNames(tmpStringList);
        // Удалим из реестра ключи которых нет в списке
        for m := 0 to tmpStringList.Count - 1 do
          try
            if (tmpCollection.GetItemsByID(StrToInt(tmpStringList.Strings[m])) = nil) then
            begin
              FStorage.DeleteSubKey(tmpStringList.Strings[m]);
              AddToLog(lgSetup, ltInformation, info_Delete_Object, [tmpCollection.DescObject + ' №' + tmpStringList.Strings[m]]);
              Result := True;
            end;
          except
          end;
        // Закроем ключ
        FStorage.CloseKey();
        // Добавляем новые объекты
        for m := 0 to tmpCollection.Count - 1 do
          if (tmpStringList.IndexOf(IntToStr(tmpCollection[m].ID)) < 0) then
          begin
            AddToLog(lgSetup, ltInformation, info_Add_New_Object, [tmpCollection.DescObject + ' №' + IntToStr(tmpCollection[m].ID)]);
            Result := True;
          end;
        // Сохраним параметры по каждому элементу
        for m := 0 to tmpCollection.Count - 1 do
          Result := ProcessSaveObject(GetPrmDesc(APrefix, AObj, APropInfo.Name), tmpCollection.ItemsByIndex[m], AReestrKey + '\' + APropInfo.Name + '\' + IntToStr(tmpCollection.ItemsByIndex[m].ID)) or Result;
      finally
        FreeAndNil(tmpStringList);
        FStorage.CloseKey();
        FStorage.OpenKey(tmpOldKeyName);
      end;
    end;}

    procedure SaveClassProps(const APropInfo: TPropInfo);
    var
      obj: TObject;
    begin
      try
        obj := GetObjectProp(AObj, APropInfo.Name, TObject);
        if Assigned(obj) then
          Result := ProcessSaveObject(obj, WriterByName[APropInfo.Name]) or Result;
      except
      end;
    end;

var
  tmpTypeData: PTypeData; // Информация о свойствах
  tmpList: PPropList;
  n: Integer;             // Колличество свойств
  i: Integer;             // Счетчик
  p: Pointer;
begin
  Result := Assigned(AWriter) and Assigned(AObj);
  if not(Result) then Exit;
  // Получим информацию о свойствах
  try
    p := AObj.ClassInfo;
    if not(Assigned(p)) then
    begin
      // Если p = nil, значит класс обекта не помечен как {$M+} {$M-}
      Result := False;
      Exit;
    end;
    tmpTypeData := GetTypeData(p);
    n := tmpTypeData.PropCount;
    if (n <= 0) then Exit;
    GetMem(tmpList, SizeOf(PPropInfo) * n);
    // Запишем все свойства
    try
      GetPropInfos(AObj.ClassInfo, tmpList);
      for i := 0 to n - 1 do
        case tmpList[i].PropType^.Kind of
          tkInteger, tkEnumeration, tkSet, tkChar:
            SaveIntegerProps(tmpList[i]^);
          tkFloat:
            SaveFloatProps(tmpList[i]^);
          tkString, tkWChar, tkLString, tkWString:
            SaveStringProps(tmpList[i]^);
          tkClass:
            begin
              if GetObjectPropClass(AObj, tmpList[i]).InheritsFrom(TStrings) then
                SaveStringListProps(tmpList[i]^) // Сохраним список
              //else if GetObjectPropClass(AObj, tmpList[i]).InheritsFrom(TSetupRecCollection) then
              //  SaveCollectionProps(tmpList[i]^) // Сохраним список обьектов
              else
                SaveClassProps(tmpList[i]^); // Обработаем произвольный класс
            end;
        end;
    finally
      FreeMem(tmpList, SizeOf(PPropInfo) * n);
    end;
  except
    Result := False;
  end;
end;

function TProfStorage.ReadAll(): WordBool;
begin
  Result := False;
  if not(Assigned(FReader)) then Exit;
  try
    //Lock();
    try
      if not(FReader.Open) then Exit;
      try
        // Загрузим параметры
        Result := ProcessLoadObject(Self, FReader);
      finally
        FReader.Close();
      end;
    finally
      //UnLock();
    end;
  except
  end;
end;

function TProfStorage.ReadBool(const Name: WideString; var Value: WordBool): WordBool;
begin
  Result := Assigned(FReader);
  if not(Result) then Exit;
  try
    Result := FReader.ReadBool(Name, Value);
  except
    Result := False;
  end;
end;

function TProfStorage.ReadBoolDef(const Name: WideString; DefValue: WordBool): WordBool;
begin
  Result := DefValue;
  ReadBool(Name, Result);
end;

function TProfStorage.ReadDateTime(const Name: WideString; var Value: TDateTime): WordBool;
begin
  Result := Assigned(FReader);
  if not(Result) then Exit;
  try
    Result := FReader.ReadDateTime(Name, Value);
  except
    Result := False;
  end;
end;

function TProfStorage.ReadDateTimeDef(const Name: WideString; DefValue: TDateTime): TDateTime;
begin
  Result := DefValue;
  ReadDateTime(Name, Result);
end;

function TProfStorage.ReadFloat64(const Name: WideString; var Value: Double): WordBool;
begin
  Result := Assigned(FReader);
  if not(Result) then Exit;
  try
    Result := FReader.ReadFloat64(Name, Value);
  except
    Result := False;
  end;
end;

function TProfStorage.ReadFloat64Def(const Name: WideString; DefValue: Double): Double;
begin
  Result := DefValue;
  ReadFloat64(Name, Result);
end;

function TProfStorage.ReadInt32(const Name: WideString; var Value: Integer): WordBool;
begin
  Result := Assigned(FReader);
  if not(Result) then Exit;
  try
    Result := FReader.ReadInt32(Name, Value);
  except
    Result := False;
  end;
end;

function TProfStorage.ReadInt32Def(const Name: WideString; DefValue: Integer): Integer;
begin
  Result := DefValue;
  ReadInt32(Name, Result);
end;

function TProfStorage.ReadInt64(const Name: WideString; var Value: Int64): WordBool;
begin
  Result := Assigned(FReader);
  if not(Result) then Exit;
  try
    Result := FReader.ReadInt64(Name, Value);
  except
    Result := False;
  end;
end;

function TProfStorage.ReadInt64Def(const Name: WideString; DefValue: Int64): Int64;
begin
  Result := DefValue;
  ReadInt64(Name, Result);
end;

function TProfStorage.ReadString(const Name: WideString; var Value: WideString): WordBool;
begin
  Result := Assigned(FReader);
  if not(Result) then Exit;
  try
    Result := FReader.ReadString(Name, Value);
  except
    Result := False;
  end;
end;

function TProfStorage.ReadStringDef(const Name, DefValue: WideString): WideString;
begin
  Result := DefValue;
  ReadString(Name, Result);
end;

function TProfStorage.WriteAll(): WordBool;
begin
  Result := False;
  if not(Assigned(FWriter)) then Exit;
  try
    //Lock();
    try
      if not(FWriter.Open()) then Exit;
      try
        // Запишем основные параметры
        Result := ProcessSaveObject(Self, FWriter);
      finally
        FWriter.Close();
      end;
    finally
      //UnLock();
    end;
  except
  end;
end;

function TProfStorage.WriteBool(const Name: WideString; Value: WordBool): WordBool;
begin
  Result := Assigned(FWriter);
  if not(Result) then Exit;
  try
    Result := FWriter.WriteBool(Name, Value);
  except
    Result := False;
  end;
end;

function TProfStorage.WriteDateTime(const Name: WideString; Value: TDateTime): WordBool;
begin
  Result := Assigned(FWriter);
  if not(Result) then Exit;
  try
    Result := FWriter.WriteDateTime(Name, Value);
  except
    Result := False;
  end;
end;

function TProfStorage.WriteFloat64(const Name: WideString; Value: Double): WordBool;
begin
  Result := Assigned(FWriter);
  if not(Result) then Exit;
  try
    Result := FWriter.WriteFloat64(Name, Value);
  except
    Result := False;
  end;
end;

function TProfStorage.WriteInt32(const Name: WideString; Value: Integer): WordBool;
begin
  Result := Assigned(FWriter);
  if not(Result) then Exit;
  try
    Result := FWriter.WriteInt32(Name, Value);
  except
    Result := False;
  end;
end;

function TProfStorage.WriteInt64(const Name: WideString; Value: Int64): WordBool;
begin
  Result := Assigned(FWriter);
  if not(Result) then Exit;
  try
    Result := FWriter.WriteInt64(Name, Value);
  except
    Result := False;
  end;
end;

function TProfStorage.WriteString(const Name, Value: WideString): WordBool;
begin
  Result := Assigned(FWriter);
  if not(Result) then Exit;
  try
    Result := FWriter.WriteString(Name, Value);
  except
    Result := False;
  end;
end;

end.
