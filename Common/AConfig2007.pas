{**
@Abstract(Конфигурации в виде XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.01.2006)
@LastMod(02.07.2012)
@Version(0.5)

[+] 30.09.2006 Prof - CLR
}
unit AConfig2007;

interface

uses
  Classes, SysUtils, TypInfo, XmlIntf,
  AConsts2, ATypes, AXmlDocumentImpl, AXmlNodeImpl, AXmlUtils;

type
  TConfigDocument = AXmlDocumentImpl.TProfXmlDocument;
  TConfigDocument1 = AXmlDocumentImpl.TProfXmlDocument1;
  TConfigNode = AXmlNodeImpl.TProfXmlNode4;
  TConfigNode1 = AXmlNodeImpl.TProfXmlNode1;

resourcestring // Сообщения ----------------------------------------------------
  info_Start_Load_Param       = '--> Загрузка параметров.';
  info_Succ_Load_Param        = '--> Параметры загружены успешно.';
  info_Start_Save_Param       = '--> Сохранение параметров.';
  info_Succ_Save_Param        = '--> Параметры успешно сохранены.';

function LoadObjectFromConfig(AConfig: IXmlNode; AObject: TObject; AAddToLog: TAddToLogProc): WordBool;
function SaveObjectToConfig(AConfig: IXmlNode; AObject: TObject; AAddToLog: TAddToLogProc): WordBool;
// --- From unConfig2006 ---
function LoadObjectFromConfig2006(AConfig: TConfigNode1; AObject: TObject; AAddToLog: TAddToLog): WordBool;
function SaveObjectToConfig2006(AConfig: TConfigNode1; AObject: TObject; AAddToLog: TAddToLog): WordBool;

function ProcessLoadObject(AConfig: IXmlNode; AObj: TObject): Boolean; {forward;}
function ProcessLoadObject2006(AConfig: TConfigNode1; AObj: TObject): Boolean; {forward;}

implementation

// -----------------------------------------------------------------------------
function LoadObjectFromConfig(AConfig: IXmlNode; AObject: TObject; AAddToLog: TAddToLogProc): WordBool;
//function LoadObjectFromConfig(AConfig: TConfigNode; AObject: TObject; AAddToLog: TAddToLogA): WordBool;
begin
  Result := False;
  {$IFNDEF CLR}
  try
    //Lock();
    try
      //if (not FStorage.Open()) then
      //  Exit;
      try
        //FStorage.SetDescription(str_Description);
        if Assigned(AAddToLog) then
          AAddToLog(lgSetup, ltInformation, info_Start_Load_Param);
        // Загрузим параметры
        Result := ProcessLoadObject(AConfig, AObject);
        if Assigned(AAddToLog) then
          AAddToLog(lgSetup, ltInformation, info_Succ_Load_Param);
      finally
        //FStorage.Close();
      end;
    finally
      //UnLock();
    end;
  except
    on E: Exception do
      if Assigned(AAddToLog) then
        AAddToLog(lgSetup, ltError, Format(err_Exception_Str, [E.Message, '', 'LoadObjectFromConfig()']));
  end;
  {$ENDIF}
end;

function LoadObjectFromConfig2006(AConfig: TConfigNode1; AObject: TObject; AAddToLog: TAddToLog): WordBool;
begin
  Result := False;
  {$IFNDEF CLR}
  try
    //Lock();
    try
      //if (not FStorage.Open()) then
      //  Exit;
      try
        //FStorage.SetDescription(str_Description);
        if Assigned(AAddTOLog) then
          AAddToLog(lgSetup, ltInformation, info_Start_Load_Param, []);
        // Загрузим параметры
        Result := ProcessLoadObject2006(AConfig, AObject);
        if Assigned(AAddToLog) then
          AAddToLog(lgSetup, ltInformation, info_Succ_Load_Param, []);
      finally
        //FStorage.Close();
      end;
    finally
      //UnLock();
    end;
  except
    on E: Exception do
      if Assigned(AAddToLog) then
        AAddToLog(lgSetup, ltError, err_Exception_Str, [E.Message, {Self.ClassName} '', 'LoadObjectFromConfig()']);
  end;
  {$ENDIF}
end;

function ProcessLoadObject(AConfig: IXmlNode; AObj: TObject): Boolean;
//function ProcessLoadObject(AConfig: TConfigNode; AObj: TObject): Boolean;

  {$IFNDEF CLR}
  procedure LoadIntegerProps(const APropInfo: TPropInfo);
  var
    tmpInt: Integer;
  begin
    if Assigned(APropInfo.SetProc) then
    begin
      if TProfXmlNode4.ReadIntegerA(AConfig, APropInfo.Name, tmpInt) then
        SetOrdProp(AObj, APropInfo.Name, tmpInt)
      else
        TProfXmlNode4.WriteIntegerA(AConfig, APropInfo.Name, GetOrdProp(AObj, APropInfo.Name));
    end;
  end;

  procedure LoadFloatProps(const APropInfo: TPropInfo);
  var
    tmpFloat: Double;
  begin
    if Assigned(APropInfo.SetProc) then
    begin
      if TProfXmlNode4.ReadFloat64A(AConfig, APropInfo.Name, tmpFloat) then
        SetFloatProp(AObj, APropInfo.Name, tmpFloat)
      else
        TProfXmlNode4.WriteFloat64A(AConfig, APropInfo.Name, GetFloatProp(AObj, APropInfo.Name));
    end;
  end;

  procedure LoadStringProps(const APropInfo: TPropInfo);
  var
    tmpStr: WideString;
  begin
    if (APropInfo.SetProc <> nil) then
    begin
      if TProfXmlNode4.ReadStringA(AConfig, APropInfo.Name, tmpStr) then
        SetStrProp(AObj, APropInfo.Name, tmpStr)
      else
        TProfXmlNode4.WriteStringA(AConfig, APropInfo.Name, GetStrProp(AObj, APropInfo.Name));
    end;
  end;

  procedure LoadStringListProps(const APropInfo: TPropInfo);
  {var
    tmpStrings: TStrings;
    n: TConfigNode;}
  begin
    // TODO: Реализовать
    {tmpStrings := (GetObjectProp(AObj, APropInfo.Name, TStrings) as TStrings);
    if (not Assigned(tmpStrings)) then Exit;
    n := AConfig.FindNode(APropInfo.Name);
    if Assigned(n) then
      ReadStringList(GetObjectPropClass(AObj, APropInfo.Name).InheritsFrom(TParamStringList), APropInfo.Name, tmpStrings)
    else
    begin
      WriteStringList(GetObjectPropClass(AObj, APropInfo.Name).InheritsFrom(TParamStringList), APropInfo.Name, tmpStrings);
      AddToLog(lgSetup, ltInformation, info_Change_Param_Str, [GetPrmDesc(APrefix, AObj, APropInfo.Name), '', tmpStrings.CommaText]);
    end;}


    {if (FStorage.GetValueType(APropInfo.Name) = vtStorage) then
      ReadStringList(GetObjectPropClass(AObj, APropInfo.Name).InheritsFrom(TParamStringList), APropInfo.Name, tmpStrings)
    else begin
      WriteStringList(GetObjectPropClass(AObj, APropInfo.Name).InheritsFrom(TParamStringList), APropInfo.Name, tmpStrings);
      AddToLog(lgSetup, ltInformation, info_Change_Param_Str, [GetPrmDesc(APrefix, AObj, APropInfo.Name), '', tmpStrings.CommaText]);
    end;}
  end;

  procedure LoadCollectionProps(const APropInfo: TPropInfo);
  {var
    tmpCollection: TSetupRecCollection;
    tmpStringList: TStringList;
    tmpOldKeyName: string;
    m: integer;}
  begin
    // TODO: Реализовать
    {// Проверим на соответствие типов
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
    end;}
  end;

  procedure LoadClassProps(const APropInfo: TPropInfo);
  {var
    tmpOldKeyName: string;}
  begin
    //tmpOldKeyName := FStorage.CurrentKeyName;
    try
      //FStorage.CloseKey();
      if Assigned(GetObjectProp(AObj, APropInfo.Name, TObject)) then
        ProcessLoadObject(TProfXmlNode4.GetNodeByNameA(AConfig, APropInfo.Name), GetObjectProp(AObj, APropInfo.Name, TObject));
        //ProcessLoadObject(GetPrmDesc(APrefix, AObj, APropInfo.Name), GetObjectProp(AObj, APropInfo.Name, TObject), AReestrKey + '\' + APropInfo.Name)
    finally
      //FStorage.CloseKey();
      //FStorage.OpenKey(tmpOldKeyName);
    end;
  end;
  {$ENDIF}

{$IFNDEF CLR}
var
  tmpTypeData: PTypeData;
  tmpList: PPropList;
  n, i: integer;
{$ENDIF}
begin
  Result := False;
  {$IFNDEF CLR}
  if not(Assigned(AConfig)) or not(Assigned(AObj)) then Exit;
  // Откроем ключ
  //if (not FStorage.OpenKey(AReestrKey)) then Exit;
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
            {else if GetObjectPropClass(AObj, tmpList[i]).InheritsFrom(TSetupRecCollection) then
              LoadCollectionProps(tmpList[i]^) // Сохраним список объектов}
            else
              LoadClassProps(tmpList[i]^); // Обработаем произвольный класс
          end;
      end;
    Result := True;
  finally
    FreeMem(tmpList, SizeOf(PPropInfo) * n);
    //FStorage.CloseKey();
  end;
  {$ENDIF}
end;

function ProcessLoadObject2006(AConfig: TConfigNode1; AObj: TObject): Boolean;

  {$IFNDEF CLR}
  procedure LoadIntegerProps(const APropInfo: TPropInfo);
  var
    tmpInt: Integer;
  begin
    if Assigned(APropInfo.SetProc) then
    begin
      if AConfig.ReadInt32(APropInfo.Name, tmpInt) then
        SetOrdProp(AObj, APropInfo.Name, tmpInt)
      else
        AConfig.WriteInt32(APropInfo.Name, GetOrdProp(AObj, APropInfo.Name));
    end;
  end;

  procedure LoadFloatProps(const APropInfo: TPropInfo);
  var
    tmpFloat: Double;
  begin
    if (APropInfo.SetProc <> nil) then
    begin
      if AConfig.ReadFloat64(APropInfo.Name, tmpFloat) then
        SetFloatProp(AObj, APropInfo.Name, tmpFloat)
      else
        AConfig.WriteFloat64(APropInfo.Name, GetFloatProp(AObj, APropInfo.Name));
    end;
  end;

  procedure LoadStringProps(const APropInfo: TPropInfo);
  var
    tmpStr: WideString;
  begin
    if (APropInfo.SetProc <> nil) then
    begin
      if AConfig.ReadString(APropInfo.Name, tmpStr) then
        SetStrProp(AObj, APropInfo.Name, tmpStr)
      else
        AConfig.WriteString(APropInfo.Name, GetStrProp(AObj, APropInfo.Name));
    end;
  end;

  procedure LoadStringListProps(const APropInfo: TPropInfo);
  {var
    tmpStrings: TStrings;
    n: TConfigNode;}
  begin
    // TODO: Реализовать
    {tmpStrings := (GetObjectProp(AObj, APropInfo.Name, TStrings) as TStrings);
    if (not Assigned(tmpStrings)) then Exit;
    n := AConfig.FindNode(APropInfo.Name);
    if Assigned(n) then
      ReadStringList(GetObjectPropClass(AObj, APropInfo.Name).InheritsFrom(TParamStringList), APropInfo.Name, tmpStrings)
    else
    begin
      WriteStringList(GetObjectPropClass(AObj, APropInfo.Name).InheritsFrom(TParamStringList), APropInfo.Name, tmpStrings);
      AddToLog(lgSetup, ltInformation, info_Change_Param_Str, [GetPrmDesc(APrefix, AObj, APropInfo.Name), '', tmpStrings.CommaText]);
    end;}


    {if (FStorage.GetValueType(APropInfo.Name) = vtStorage) then
      ReadStringList(GetObjectPropClass(AObj, APropInfo.Name).InheritsFrom(TParamStringList), APropInfo.Name, tmpStrings)
    else begin
      WriteStringList(GetObjectPropClass(AObj, APropInfo.Name).InheritsFrom(TParamStringList), APropInfo.Name, tmpStrings);
      AddToLog(lgSetup, ltInformation, info_Change_Param_Str, [GetPrmDesc(APrefix, AObj, APropInfo.Name), '', tmpStrings.CommaText]);
    end;}
  end;

  procedure LoadCollectionProps(const APropInfo: TPropInfo);
  {var
    tmpCollection: TSetupRecCollection;
    tmpStringList: TStringList;
    tmpOldKeyName: string;
    m: integer;}
  begin
    // TODO: Реализовать
    {// Проверим на соответствие типов
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
    end;}
  end;

  procedure LoadClassProps(const APropInfo: TPropInfo);
  {var
    tmpOldKeyName: string;}
  begin
    //tmpOldKeyName := FStorage.CurrentKeyName;
    try
      //FStorage.CloseKey();
      if Assigned(GetObjectProp(AObj, APropInfo.Name, TObject)) then
        ProcessLoadObject2006(AConfig.GetNodeByName(APropInfo.Name), GetObjectProp(AObj, APropInfo.Name, TObject));
        //ProcessLoadObject(GetPrmDesc(APrefix, AObj, APropInfo.Name), GetObjectProp(AObj, APropInfo.Name, TObject), AReestrKey + '\' + APropInfo.Name)
    finally
      //FStorage.CloseKey();
      //FStorage.OpenKey(tmpOldKeyName);
    end;
  end;
  {$ENDIF}

{$IFNDEF CLR}
var
  tmpTypeData: PTypeData;
  tmpList: PPropList;
  n, i: integer;
{$ENDIF}
begin
  Result := False;
  {$IFNDEF CLR}
  if not(Assigned(AConfig)) or not(Assigned(AObj)) then Exit;
  // Откроем ключ
  //if (not FStorage.OpenKey(AReestrKey)) then Exit;
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
            {else if GetObjectPropClass(AObj, tmpList[i]).InheritsFrom(TSetupRecCollection) then
              LoadCollectionProps(tmpList[i]^) // Сохраним список объектов}
            else
              LoadClassProps(tmpList[i]^); // Обработаем произвольный класс
          end;
      end;
    Result := True;
  finally
    FreeMem(tmpList, SizeOf(PPropInfo) * n);
    //FStorage.CloseKey();
  end;
  {$ENDIF}
end;

// -----------------------------------------------------------------------------
function ProcessSaveObject(AConfig: IXmlNode; AObj: TObject): boolean;

  {$IFNDEF CLR}
  // -------------------------------------------------------------------------
  procedure SaveIntegerProps(const APropInfo: TPropInfo);
  var
    tmpInt, tmpOldInt: Integer;
  begin
    tmpInt := GetOrdProp(AObj, APropInfo.Name);
    if not(ProfXmlNode_ReadInt(AConfig, APropInfo.Name, tmpOldInt)) or (tmpInt <> tmpOldInt) then
    begin
      ProfXmlNode_WriteInt(AConfig, APropInfo.Name, tmpInt);
      //AddToLogOrdProp(APrefix, AObj, APropInfo, tmpInt, tmpOldInt);
      //Result := True;
    end;
    {if not(AConfig.ReadInt32(APropInfo.Name, tmpOldInt)) or (tmpInt <> tmpOldInt) then
    begin
      AConfig.WriteInt32(APropInfo.Name, tmpInt);
      //AddToLogOrdProp(APrefix, AObj, APropInfo, tmpInt, tmpOldInt);
      //Result := True;
    end;}


    {if (FStorage.GetValueType(APropInfo.Name) = vtInt) then
    begin
      tmpInt := GetOrdProp(AObj, APropInfo.Name);
      tmpOldInt := FStorage.ReadInteger(APropInfo.Name, 0);
      if (tmpInt <> tmpOldInt) then
      begin
        FStorage.WriteInteger(APropInfo.Name, tmpInt);
        AddToLogOrdProp(APrefix, AObj, APropInfo, tmpInt, tmpOldInt);
        Result := True;
      end;
    end else
    begin
      FStorage.WriteInteger(APropInfo.Name, GetOrdProp(AObj, APropInfo.Name));
      AddToLogOrdProp(APrefix, AObj, APropInfo, GetOrdProp(AObj, APropInfo.Name), 0);
    end;}
  end;

  // -------------------------------------------------------------------------
  procedure SaveFloatProps(const APropInfo: TPropInfo);
  var
    tmpFloat, tmpOldFloat: Double;
  begin
    tmpFloat := GetFloatProp(AObj, APropInfo.Name);
    if not(ProfXmlNode_ReadFloat64(AConfig, APropInfo.Name, tmpOldFloat)) or (tmpFloat <> tmpOldFloat) then
    begin
      ProfXmlNode_WriteFloat64(AConfig, APropInfo.Name, tmpFloat);
      //AddToLog(lgSetup, ltInformation, info_Change_Param_Float, [GetPrmDesc(APrefix, AObj, APropInfo.Name), tmpOldFloat, tmpFloat]);
      //Result := True;
    end;

    {if (FStorage.GetValueType(APropInfo.Name) = vtFloat) then
    begin
      tmpFloat := GetFloatProp(AObj, APropInfo.Name);
      tmpOldFloat := FStorage.ReadFloat(APropInfo.Name, 0.0);
      if (tmpFloat <> tmpOldFloat) then
      begin
        FStorage.WriteFloat(APropInfo.Name, tmpFloat);
        AddToLog(lgSetup, ltInformation, info_Change_Param_Float, [GetPrmDesc(APrefix, AObj, APropInfo.Name), tmpOldFloat, tmpFloat]);
        Result := True;
      end;
    end else
    begin
      FStorage.WriteFloat(APropInfo.Name, GetFloatProp(AObj, APropInfo.Name));
      AddToLog(lgSetup, ltInformation, info_Change_Param_Float, [GetPrmDesc(APrefix, AObj, APropInfo.Name), 0.0, GetFloatProp(AObj, APropInfo.Name)]);
    end;}
  end;

  // -------------------------------------------------------------------------
  procedure SaveStringProps(const APropInfo: TPropInfo);
  var
    tmpStr, tmpOldStr: WideString;
  begin
    tmpStr := GetStrProp(AObj, APropInfo.Name);
    if not(ProfXmlNode_ReadString(AConfig, APropInfo.Name, tmpOldStr)) or (tmpStr <> tmpOldStr) then
    begin
      ProfXmlNode_WriteString(AConfig, APropInfo.Name, tmpStr);
      //AddToLog(lgSetup, ltInformation, info_Change_Param_Str, [GetPrmDesc(APrefix, AObj, APropInfo.Name), tmpOldStr, tmpStr]);
      //Result := True;
    end;

    {if (FStorage.GetValueType(APropInfo.Name) = vtString) then
    begin
      tmpStr := GetStrProp(AObj, APropInfo.Name);
      tmpOldStr := FStorage.ReadString(APropInfo.Name, '');
      if (tmpStr <> tmpOldStr) then
      begin
        FStorage.WriteString(APropInfo.Name, tmpStr);
        AddToLog(lgSetup, ltInformation, info_Change_Param_Str, [GetPrmDesc(APrefix, AObj, APropInfo.Name), tmpOldStr, tmpStr]);
        Result := True;
      end;
    end else
    begin
      FStorage.WriteString(APropInfo.Name, GetStrProp(AObj, APropInfo.Name));
      AddToLog(lgSetup, ltInformation, info_Change_Param_Str, [GetPrmDesc(APrefix, AObj, APropInfo.Name), '', GetStrProp(AObj, APropInfo.Name)]);
    end;}
  end;

  // -------------------------------------------------------------------------
  procedure SaveStringListProps(const APropInfo: TPropInfo);
  {var
    tmpStrings: TStrings;
    tmpIsChangeList: boolean;
    tmpOldStrings: TStringList;
    tmpStr: string;
    k: integer;}
  begin
    // TODO: Реализовать
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

  // -------------------------------------------------------------------------
  procedure SaveCollectionProps(const APropInfo: TPropInfo);
  {var
    tmpCollection: TSetupRecCollection;
    tmpOldKeyName: string;
    tmpStringList: TStringList;
    m: integer;}
  begin
    // TODO: Реализовать
    {tmpCollection := (GetObjectProp(AObj, APropInfo.Name, TSetupRecCollection) as TSetupRecCollection);
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
    end;}
  end;

  // -------------------------------------------------------------------------
  procedure SaveClassProps(const APropInfo: TPropInfo);
  {var
    tmpOldKeyName: string;}
  begin
    //tmpOldKeyName := FStorage.CurrentKeyName;
    try
      //FStorage.CloseKey();
      if Assigned(GetObjectProp(AObj, APropInfo.Name, TObject)) then
        Result := ProcessSaveObject(TProfXmlNode4.GetNodeByNameA(AConfig, APropInfo.Name), GetObjectProp(AObj, APropInfo.Name, TObject)) or Result;
        //Result := ProcessSaveObject(GetPrmDesc(APrefix, AObj, APropInfo.Name), GetObjectProp(AObj, APropInfo.Name, TObject), AReestrKey + '\' + APropInfo.Name) or Result;
    finally
      //FStorage.CloseKey();
      //FStorage.OpenKey(tmpOldKeyName);
    end;
  end;
  {$ENDIF}

{$IFNDEF CLR}
var
  tmpTypeData: PTypeData;
  tmpList: PPropList;
  n, i: integer;
{$ENDIF}
begin
  Result := False;
  {$IFNDEF CLR}
  if not(Assigned(AConfig)) or not(Assigned(AObj)) then Exit;
  //if (not FStorage.OpenKey(AReestrKey)) then
  //  Exit;
  // Получим информацию о свойствах
  tmpTypeData := GetTypeData(AObj.ClassInfo);
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
            {else if GetObjectPropClass(AObj, tmpList[i]).InheritsFrom(TSetupRecCollection) then
              SaveCollectionProps(tmpList[i]^) // Сохраним список обьектов}
            else
              SaveClassProps(tmpList[i]^); // Обработаем произвольный класс
          end;
      end;
  finally
    FreeMem(tmpList, SizeOf(PPropInfo) * n);
    //FStorage.CloseKey();
  end;
  {$ENDIF}
end;

function ProcessSaveObject2006(AConfig: TConfigNode1; AObj: TObject): Boolean;

  {$IFNDEF CLR}
  // -------------------------------------------------------------------------
  procedure SaveIntegerProps(const APropInfo: TPropInfo);
  var
    tmpInt, tmpOldInt: Integer;
  begin
    tmpInt := GetOrdProp(AObj, APropInfo.Name);
    if not(AConfig.ReadInt32(APropInfo.Name, tmpOldInt)) or (tmpInt <> tmpOldInt) then
    begin
      AConfig.WriteInt32(APropInfo.Name, tmpInt);
      //AddToLogOrdProp(APrefix, AObj, APropInfo, tmpInt, tmpOldInt);
      //Result := True;
    end;


    {if (FStorage.GetValueType(APropInfo.Name) = vtInt) then
    begin
      tmpInt := GetOrdProp(AObj, APropInfo.Name);
      tmpOldInt := FStorage.ReadInteger(APropInfo.Name, 0);
      if (tmpInt <> tmpOldInt) then
      begin
        FStorage.WriteInteger(APropInfo.Name, tmpInt);
        AddToLogOrdProp(APrefix, AObj, APropInfo, tmpInt, tmpOldInt);
        Result := True;
      end;
    end else
    begin
      FStorage.WriteInteger(APropInfo.Name, GetOrdProp(AObj, APropInfo.Name));
      AddToLogOrdProp(APrefix, AObj, APropInfo, GetOrdProp(AObj, APropInfo.Name), 0);
    end;}
  end;

  // -------------------------------------------------------------------------
  procedure SaveFloatProps(const APropInfo: TPropInfo);
  var
    tmpFloat, tmpOldFloat: Double;
  begin
    tmpFloat := GetFloatProp(AObj, APropInfo.Name);
    if not(AConfig.ReadFloat64(APropInfo.Name, tmpOldFloat)) or (tmpFloat <> tmpOldFloat) then
    begin
      AConfig.WriteFloat64(APropInfo.Name, tmpFloat);
      //AddToLog(lgSetup, ltInformation, info_Change_Param_Float, [GetPrmDesc(APrefix, AObj, APropInfo.Name), tmpOldFloat, tmpFloat]);
      //Result := True;
    end;

    {if (FStorage.GetValueType(APropInfo.Name) = vtFloat) then
    begin
      tmpFloat := GetFloatProp(AObj, APropInfo.Name);
      tmpOldFloat := FStorage.ReadFloat(APropInfo.Name, 0.0);
      if (tmpFloat <> tmpOldFloat) then
      begin
        FStorage.WriteFloat(APropInfo.Name, tmpFloat);
        AddToLog(lgSetup, ltInformation, info_Change_Param_Float, [GetPrmDesc(APrefix, AObj, APropInfo.Name), tmpOldFloat, tmpFloat]);
        Result := True;
      end;
    end else
    begin
      FStorage.WriteFloat(APropInfo.Name, GetFloatProp(AObj, APropInfo.Name));
      AddToLog(lgSetup, ltInformation, info_Change_Param_Float, [GetPrmDesc(APrefix, AObj, APropInfo.Name), 0.0, GetFloatProp(AObj, APropInfo.Name)]);
    end;}
  end;

  // -------------------------------------------------------------------------
  procedure SaveStringProps(const APropInfo: TPropInfo);
  var
    tmpStr, tmpOldStr: WideString;
  begin
    tmpStr := GetStrProp(AObj, APropInfo.Name);
    if not(AConfig.ReadString(APropInfo.Name, tmpOldStr)) or (tmpStr <> tmpOldStr) then
    begin
      AConfig.WriteString(APropInfo.Name, tmpStr);
      //AddToLog(lgSetup, ltInformation, info_Change_Param_Str, [GetPrmDesc(APrefix, AObj, APropInfo.Name), tmpOldStr, tmpStr]);
      //Result := True;
    end;

    {if (FStorage.GetValueType(APropInfo.Name) = vtString) then
    begin
      tmpStr := GetStrProp(AObj, APropInfo.Name);
      tmpOldStr := FStorage.ReadString(APropInfo.Name, '');
      if (tmpStr <> tmpOldStr) then
      begin
        FStorage.WriteString(APropInfo.Name, tmpStr);
        AddToLog(lgSetup, ltInformation, info_Change_Param_Str, [GetPrmDesc(APrefix, AObj, APropInfo.Name), tmpOldStr, tmpStr]);
        Result := True;
      end;
    end else
    begin
      FStorage.WriteString(APropInfo.Name, GetStrProp(AObj, APropInfo.Name));
      AddToLog(lgSetup, ltInformation, info_Change_Param_Str, [GetPrmDesc(APrefix, AObj, APropInfo.Name), '', GetStrProp(AObj, APropInfo.Name)]);
    end;}
  end;

  // -------------------------------------------------------------------------
  procedure SaveStringListProps(const APropInfo: TPropInfo);
  {var
    tmpStrings: TStrings;
    tmpIsChangeList: boolean;
    tmpOldStrings: TStringList;
    tmpStr: string;
    k: integer;}
  begin
    // TODO: Реализовать
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

  // -------------------------------------------------------------------------
  procedure SaveCollectionProps(const APropInfo: TPropInfo);
  {var
    tmpCollection: TSetupRecCollection;
    tmpOldKeyName: string;
    tmpStringList: TStringList;
    m: integer;}
  begin
    // TODO: Реализовать
    {tmpCollection := (GetObjectProp(AObj, APropInfo.Name, TSetupRecCollection) as TSetupRecCollection);
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
    end;}
  end;

  // -------------------------------------------------------------------------
  procedure SaveClassProps(const APropInfo: TPropInfo);
  {var
    tmpOldKeyName: string;}
  begin
    //tmpOldKeyName := FStorage.CurrentKeyName;
    try
      //FStorage.CloseKey();
      if Assigned(GetObjectProp(AObj, APropInfo.Name, TObject)) then
        Result := ProcessSaveObject2006(AConfig.GetNodeByName(APropInfo.Name), GetObjectProp(AObj, APropInfo.Name, TObject)) or Result;
        //Result := ProcessSaveObject(GetPrmDesc(APrefix, AObj, APropInfo.Name), GetObjectProp(AObj, APropInfo.Name, TObject), AReestrKey + '\' + APropInfo.Name) or Result;
    finally
      //FStorage.CloseKey();
      //FStorage.OpenKey(tmpOldKeyName);
    end;
  end;
  {$ENDIF}

{$IFNDEF CLR}
var
  tmpTypeData: PTypeData;
  tmpList: PPropList;
  n, i: integer;
{$ENDIF}
begin
  Result := False;
  {$IFNDEF CLR}
  if not(Assigned(AConfig)) or not(Assigned(AObj)) then Exit;
  //if (not FStorage.OpenKey(AReestrKey)) then
  //  Exit;
  // Получим информацию о свойствах
  tmpTypeData := GetTypeData(AObj.ClassInfo);
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
            {else if GetObjectPropClass(AObj, tmpList[i]).InheritsFrom(TSetupRecCollection) then
              SaveCollectionProps(tmpList[i]^) // Сохраним список обьектов}
            else
              SaveClassProps(tmpList[i]^); // Обработаем произвольный класс
          end;
      end;
  finally
    FreeMem(tmpList, SizeOf(PPropInfo) * n);
    //FStorage.CloseKey();
  end;
  {$ENDIF}
end;

function SaveObjectToConfig(AConfig: IXmlNode{IProfXmlNode}; AObject: TObject; AAddToLog: TAddToLogProc): WordBool;
begin
  Result := False;
  {$IFNDEF CLR}
  try
    //Lock();
    try
      //if (not FStorage.Open()) then
      //  Exit;
      try
        if Assigned(AAddToLog) then
          AAddToLog(lgSetup, ltInformation, info_Start_Save_Param);
        // Запишем основные параметры
        Result := ProcessSaveObject(AConfig, AObject);
        if Assigned(AAddToLog) then
          AAddToLog(lgSetup, ltInformation, info_Succ_Save_Param);
      finally
        //FStorage.Close();
      end;
    finally
      //UnLock();
    end;
  except
    on E: Exception do
      if Assigned(AAddToLog) then
        AAddToLog(lgSetup, ltError, Format(err_Exception_Str, [E.Message, {Self.ClassName}'', 'SaveObjectToConfig()']));
  end;
  {$ENDIF}
end;

function SaveObjectToConfig2006(AConfig: TConfigNode1; AObject: TObject; AAddToLog: TAddToLog): WordBool;
begin
  Result := False;
  {$IFNDEF CLR}
  try
    //Lock();
    try
      //if (not FStorage.Open()) then
      //  Exit;
      try
        if Assigned(AAddToLog) then
          AAddToLog(lgSetup, ltInformation, info_Start_Save_Param, []);
        // Запишем основные параметры
        Result := ProcessSaveObject2006(AConfig, AObject);
        if Assigned(AAddToLog) then
          AAddToLog(lgSetup, ltInformation, info_Succ_Save_Param, []);
      finally
        //FStorage.Close();
      end;
    finally
      //UnLock();
    end;
  except
    on E: Exception do
      if Assigned(AAddToLog) then
        AAddToLog(lgSetup, ltError, err_Exception_Str, [E.Message, {Self.ClassName}'', 'SaveObjectToConfig()']);
  end;
  {$ENDIF}
end;

end.
