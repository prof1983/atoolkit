{**
@Abstract(Встраиваемое меню для модулей данных)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.05.2006)
@LastMod(02.05.2012)
@Version(0.5)
}
unit ADataModulesMenu;

interface

uses
  Classes, Controls, Menus, SysUtils,
  AConfig2007, AConfigForm2006, ADbDataModule2, ADbDataModules, ADbTypes, ASetDmForm;

type //** Встраиваемое меню для модулей данных
  TmiDataModules = class(TMenuItem)
  private
    FConfigSettingForm: TConfigNode1;
    FDataModules: TDataModules;
    FImageIndexExport: Integer;
    FImageIndexImport: Integer;
    FImageIndexSetting: Integer;
    FImageIndexSynchronize: Integer;
    FIsDebug: WordBool;
    FKeyName: WideString;
    FOnSave: TNotifyEvent;
    FParentWindowHandle: Integer;
    FStorageDir: WideString;
    procedure SetDataModules(Value: TDataModules);
    procedure miExportAllClick(Sender: TObject);
    procedure miExportReplicaClick(Sender: TObject);
    procedure miImportAllClick(Sender: TObject);
    procedure miSettingClick(Sender: TObject);
    procedure miSynchronizeAllClick(Sender: TObject);
    procedure miImportReplicaClick(Sender: TObject);
    procedure miReplicaReplicateClick(Sender: TObject);
    //procedure miReplicaConfigClick(Sender: TObject);
  public
    property ConfigSettingForm: TConfigNode1 read FConfigSettingForm write FConfigSettingForm;
    property DataModules: TDataModules read FDataModules write SetDataModules;
    property ImageIndexExport: Integer read FImageIndexExport write FImageIndexExport;
    property ImageIndexImport: Integer read FImageIndexImport write FImageIndexImport;
    property ImageIndexSetting: Integer read FImageIndexSetting write FImageIndexSetting;
    property ImageIndexSynchronize: Integer read FImageIndexSynchronize write FImageIndexSynchronize;
    // Событие возникает, когда произошло сохранение измененых параметров.
    property OnSave: TNotifyEvent read FOnSave write FOnSave;
    property ParentWindowHandle: Integer read FParentWindowHandle write FParentWindowHandle;
    procedure Refresh();
  published
    // Режим отладки - дополнительные пункты меню
    property IsDebug: WordBool read FIsDebug write FIsDebug;
    // Ключ сохранения настроек в хранилище
    property KeyName: WideString read FKeyName write FKeyName;
    // Путь к файлу хранилища settings.stg
    property StorageDir: WideString read FStorageDir write FStorageDir;
  end;

implementation

{ TmiDataModules }

procedure TmiDataModules.miExportAllClick(Sender: TObject);
var
  Name: string;
  Res: Boolean;
begin
  Res := False;
  if not(Sender is TMenuItem) then Exit;
  try
    if (Sender as TMenuItem).Tag >= 0 then
    begin
      //AddToLog(lgUser, ltInformation, 'Экспорт "%d"', [(Sender as TMenuItem).Tag]);
      Name := FDataModules.dmExport[(Sender as TMenuItem).Tag].Name;
      Res := FDataModules.dmExport[(Sender as TMenuItem).Tag].ExportData();
    end
    else if (Sender as TMenuItem).Tag = -1 then
      Res := FDataModules.ExportAll()
    else if (Sender as TMenuItem).Tag = -2 then
    begin
      FDataModules.NewDataModule([dmtExport]);
      Refresh();
    end;
  except
  end;
  {if Res then
  begin
    AddToLog(lgGeneral, ltInformation, 'Экспорт "%s" выполнен успешно <%s.%s>', [Name, ClassName, 'miExportAllClick']);
    MessageDlg(Format('Экспорт "%s" выполнен успешно', [Name]), mtInformation, [mbOk], 0);
  end
  else
  begin
    AddToLog(lgGeneral, ltError, 'Ошибка при экспорте "%s" <%s.%s>', [Name, ClassName, 'miExportAllClick']);
    MessageDlg(Format('Ошибка при экспорте "%s"', [Name]), mtError, [mbOk], 0);
  end;}
end;

procedure TmiDataModules.miExportReplicaClick(Sender: TObject);
var
  Name: string;
  Res: Boolean;
begin
  Res := False;
  if not(Sender is TMenuItem) then Exit;
  try
    if (Sender as TMenuItem).Tag >= 0 then
    begin
      Name := FDataModules.dmExportReplica[(Sender as TMenuItem).Tag].Name;
      Res := FDataModules.dmExportReplica[(Sender as TMenuItem).Tag].ExportData();
    end
    else if (Sender as TMenuItem).Tag = -1 then
      Res := FDataModules.ExportReplicaAll()
    else if (Sender as TMenuItem).Tag = -2 then
    begin
      FDataModules.NewDataModule([dmtExportReplica]);
      Refresh();
    end;
  except
  end;
end;

procedure TmiDataModules.miImportAllClick(Sender: TObject);
var
  dm: TDataModule2;
  Name: string;
  Res: Boolean;
const
  stImport = 'Даные из "%s" импортированы успешно';
  errImport = 'Данные из "%s" не импортированы';
begin
  //AddToLog(lgUser, ltInformation, 'Импорт "%d" <%s.%s>', [(Sender as TMenuItem).Tag, ClassName, 'miImportAllClick']);
  Res := False;
  if not(Sender is TMenuItem) then Exit;
  try
    if (Sender as TMenuItem).Tag >= 0 then
    begin
      dm := FDataModules.dmImport[(Sender as TMenuItem).Tag];
      Name := dm.Name;
      Res := dm.ImportData();
    end
    else if (Sender as TMenuItem).Tag = -1 then
      Res := FDataModules.ImportAll()
    else if (Sender as TMenuItem).Tag = -2 then
    begin
      FDataModules.NewDataModule([dmtImport]);
      Refresh();
    end;
  except
  end;

  {if Res then
  begin
    AddToLog(lgGeneral, ltInformation, ' <%s.%s>', [Name, ClassName, 'miImportAllClick']);
    MessageDlg(Format(stImport, [Name]), mtInformation, [mbOk], 0);
  end
  else
  begin
    AddToLog(lgGeneral, ltError, errImport+' <%s.%s>', [Name, ClassName, 'miImportAllClick']);
    MessageDlg(Format(errImport, [Name]), mtError, [mbOk], 0);
  end;}
end;

procedure TmiDataModules.miImportReplicaClick(Sender: TObject);
var
  dm: TDataModule2;
  Name: string;
  Res: Boolean;
begin
  Res := False;
  if not(Sender is TMenuItem) then Exit;
  try
    if (Sender as TMenuItem).Tag >= 0 then
    begin
      dm := FDataModules.dmImportReplica[(Sender as TMenuItem).Tag];
      Name := dm.Name;
      Res := dm.ImportData();
    end
    else if (Sender as TMenuItem).Tag = -1 then
      Res := FDataModules.ImportReplicaAll()
    else if (Sender as TMenuItem).Tag = -2 then
    begin
      FDataModules.NewDataModule([dmtImportReplica]);
      Refresh();
    end;
  except
  end;
end;

{procedure TmiDataModules.miReplicaConfigClick(Sender: TObject);
var
  fm: TfrmConfigReplica;
begin
  fm := TfrmConfigReplica.Create(Self);
  try
    fm.ShowModal();
  finally
    fm.Free();
  end;
end;}

{var
  fm: TfmReplicaConfig;
begin
  if Assigned(FDataModules) and Assigned(FDataModules.Replica)
  and (FDataModules.Replica.IsConnected) and (FParentWindowHandle > 0) then
  try
    fm := TfmReplicaConfig.Create(FDataModules.Replica.Config);
    if fm.ShowModal() = mrOk then
      FDataModules.Replica.Commit();
  finally
    fm.Free();
  end;
end;}

procedure TmiDataModules.miReplicaReplicateClick(Sender: TObject);
begin
end;

procedure TmiDataModules.miSettingClick(Sender: TObject);
var
  fmSetExport: TfmSetExport;
begin
  try
    fmSetExport := TfmSetExport.Create(Self);
    // Настройки положения и размеров окна
    if Assigned(FConfigSettingForm) then
      AConfigForm2006.ConfigToForm2006(FConfigSettingForm, fmSetExport);
    try
      fmSetExport.DataModules := FDataModules;
      if fmSetExport.ShowModal() = mrOk then
      begin
        //FDataModules.SaveParams(ExtractFilePath(ParamStr(0)) + STATICA_STORAGE_DIR, SETUP_DM);
        if (FStorageDir <> '') and (FKeyName <> '') then
          FDataModules.SaveParams(FStorageDir, FKeyName);
        // Сохранение положения и размеров окна
        //unConfigForm.XmlFromFormConfig(FConfigSettingForm, fmSetExport);
        if Assigned(FConfigSettingForm) then
          AConfigForm2006.ConfigFromForm2006(FConfigSettingForm, fmSetExport);
        if Assigned(FOnSave) then
          FOnSave(Self);
      end;
    finally
      fmSetExport.Free();
    end;
  except
  end;
end;

procedure TmiDataModules.miSynchronizeAllClick(Sender: TObject);
var
  Name: string;
  Res: Boolean;
begin
  Res := False;
  if not(Sender is TMenuItem) then Exit;
  try
    if (Sender as TMenuItem).Tag >= 0 then
    begin
      //AddToLog(lgUser, ltInformation, 'Синхронизация "%d" <%s.%s>', [(Sender as TMenuItem).Tag, ClassName, 'miSynchronizeAllClick']);
      Name := FDataModules.dmSynchronize[(Sender as TMenuItem).Tag].Name;
      Res := FDataModules.dmSynchronize[(Sender as TMenuItem).Tag].SynchronizeData();
    end
    else if (Sender as TMenuItem).Tag = -1 then
      Res := FDataModules.SynchronizeAll()
    else if (Sender as TMenuItem).Tag = -2 then
    begin
      FDataModules.NewDataModule([dmtSynchronize]);
      Refresh();
    end;
  except
  end;
  {if Res then
  begin
    AddToLog(lgGeneral, ltInformation, 'Синхронизация "%s" выполнена успешно <%s.%s>', [Name, ClassName, 'miSynchronizeAllClick']);
    MessageDlg(Format('Синхронизация "%s" выполнена успешно', [Name]), mtInformation, [mbOk], 0);
  end
  else
  begin
    AddToLog(lgGeneral, ltError, 'Ошибка при синхронизации "%s" <%s.%s>', [Name, ClassName, 'miSynchronizeAllClick']);
    MessageDlg(Format('Ошибка при синхронизации "%s"', [Name]), mtError, [mbOk], 0);
  end;}
end;

procedure TmiDataModules.Refresh();
var
  Count: Integer;
  I: Integer;
  miItem: TMenuItem;
  miExport: TMenuItem;
  miImport: TMenuItem;
  //miSynchronize: TMenuItem;
  miExportAll: TMenuItem;
  miImportAll: TMenuItem;
  //miSynchronizeAll: TMenuItem;
begin
  Self.Clear();
  Self.Caption := 'Данные';

  // ----------------------------------------
  // Создаем меню экспорта
  miExport := TMenuItem.Create(Self);
  miExport.Caption := 'Экспорт';
  miExport.Tag := -2;
  miExport.ImageIndex := FImageIndexExport;
  //miExport.OnClick := miExportAllClick;
  Self.Add(miExport);

  // Создаем меню экспорта всех
  miExportAll := TMenuItem.Create(Self);
  miExportAll.Caption := 'Все';
  miExportAll.Tag := -1;
  miExportAll.ImageIndex := FImageIndexExport;
  miExportAll.OnClick := miExportAllClick;
  miExport.Add(miExportAll);

  // Создаем элемент отчеркивания
  miItem := TMenuItem.Create(Self);
  miItem.Caption := '-';
  miExport.Add(miItem);

  // Создаем список экспорта
  Count := FDataModules.dmExportCount;
  for I := 0 to Count - 1 do
    if FDataModules.dmExport[I].Enabled then
    begin
      miItem := TMenuItem.Create(miExport);
      miItem.Caption := FDataModules.dmExport[I].Name;
      miItem.Hint := FDataModules.dmExport[I].Description;
      miItem.Tag := I;
      miItem.OnClick := miExportAllClick;
      miItem.ImageIndex := miExportAll.ImageIndex;
      miExport.Add(miItem);
    end;

  // Создаем элемент отчеркивания
  miItem := TMenuItem.Create(Self);
  miItem.Caption := '-';
  miExport.Add(miItem);

  // Создаем меню "добавить"
  miItem := TMenuItem.Create(Self);
  miItem.Caption := 'Добавить';
  miItem.Tag := -2;
  miItem.ImageIndex := FImageIndexSetting;
  miItem.OnClick := miExportAllClick;
  miExport.Add(miItem);

  // ----------------------------------------
  // Создаем меню экспорта для модулей Replica
  miExport := TMenuItem.Create(Self);
  miExport.Caption := 'Экспорт(Replica)';
  miExport.Tag := -2;
  miExport.ImageIndex := FImageIndexExport;
  //miExport.OnClick := miExportAllClick;
  Self.Add(miExport);

  // Создаем меню экспорта всех
  miExportAll := TMenuItem.Create(Self);
  miExportAll.Caption := 'Все';
  miExportAll.Tag := -1;
  miExportAll.ImageIndex := FImageIndexExport;
  miExportAll.OnClick := miExportReplicaClick;
  miExport.Add(miExportAll);

  // Создаем элемент отчеркивания
  miItem := TMenuItem.Create(Self);
  miItem.Caption := '-';
  miExport.Add(miItem);

  // Создаем список экспорта
  Count := FDataModules.dmExportReplicaCount;
  for I := 0 to Count - 1 do
    if FDataModules.dmExportReplica[I].Enabled then
    begin
      miItem := TMenuItem.Create(miExport);
      miItem.Caption := FDataModules.dmExportReplica[I].Name;
      miItem.Hint := FDataModules.dmExportReplica[I].Description;
      miItem.Tag := I;
      miItem.OnClick := miExportReplicaClick;
      miItem.ImageIndex := miExportAll.ImageIndex;
      miExport.Add(miItem);
    end;

  // Создаем элемент отчеркивания
  miItem := TMenuItem.Create(Self);
  miItem.Caption := '-';
  miExport.Add(miItem);

  // Создаем меню "добавить"
  miItem := TMenuItem.Create(Self);
  miItem.Caption := 'Добавить';
  miItem.Tag := -2;
  miItem.ImageIndex := FImageIndexSetting;
  miItem.OnClick := miExportReplicaClick;
  miExport.Add(miItem);

  // -------------------------------------------
  // Создаем меню импорта
  miImport := TMenuItem.Create(Self);
  miImport.Caption := 'Импорт';
  miImport.Tag := -1;
  miImport.ImageIndex := FImageIndexImport;
  //miExport.OnClick := miImportAllClick;
  Self.Add(miImport);

  // Создаем меню импорта всех
  miImportAll := TMenuItem.Create(Self);
  miImportAll.Caption := 'Все';
  miImportAll.Tag := -1;
  miImportAll.ImageIndex := FImageIndexImport;
  miImportAll.OnClick := miImportAllClick;
  miImport.Add(miImportAll);

  // Создаем элемент отчеркивания
  miItem := TMenuItem.Create(Self);
  miItem.Caption := '-';
  miImport.Add(miItem);

  // Создаем список импорта
  Count := FDataModules.dmImportCount;
  for I := 0 to Count - 1 do
    if FDataModules.dmImport[I].Enabled then
    begin
      miItem := TMenuItem.Create(miImport);
      miItem.Caption := FDataModules.dmImport[I].Name;
      miItem.Hint := FDataModules.dmImport[I].Description;
      miItem.Tag := I;
      miItem.OnClick := miImportAllClick;
      miItem.ImageIndex := miImportAll.ImageIndex;
      miImport.Add(miItem);
    end;

  // Создаем элемент отчеркивания
  miItem := TMenuItem.Create(Self);
  miItem.Caption := '-';
  miImport.Add(miItem);

  // Создаем меню "Добавить"
  miItem := TMenuItem.Create(Self);
  miItem.Caption := 'Добавить';
  miItem.Tag := -2;
  miItem.ImageIndex := FImageIndexSetting;
  miItem.OnClick := miImportAllClick;
  miImport.Add(miItem);

  // -------------------------------------------
  // Создаем меню импорта для модулей Replica
  miImport := TMenuItem.Create(Self);
  miImport.Caption := 'Импорт(Replica)';
  miImport.Tag := -1;
  miImport.ImageIndex := FImageIndexImport;
  //miExport.OnClick := miImportAllClick;
  Self.Add(miImport);

  // Создаем меню импорта всех
  miImportAll := TMenuItem.Create(Self);
  miImportAll.Caption := 'Все';
  miImportAll.Tag := -1;
  miImportAll.ImageIndex := FImageIndexImport;
  miImportAll.OnClick := miImportReplicaClick;
  miImport.Add(miImportAll);

  // Создаем элемент отчеркивания
  miItem := TMenuItem.Create(Self);
  miItem.Caption := '-';
  miImport.Add(miItem);

  // Создаем список импорта
  Count := FDataModules.dmImportReplicaCount;
  for I := 0 to Count - 1 do
    if FDataModules.dmImportReplica[I].Enabled then
    begin
      miItem := TMenuItem.Create(miImport);
      miItem.Caption := FDataModules.dmImportReplica[I].Name;
      miItem.Hint := FDataModules.dmImportReplica[I].Description;
      miItem.Tag := I;
      miItem.OnClick := miImportReplicaClick;
      miItem.ImageIndex := miImportAll.ImageIndex;
      miImport.Add(miItem);
    end;

  // Создаем элемент отчеркивания
  miItem := TMenuItem.Create(Self);
  miItem.Caption := '-';
  miImport.Add(miItem);

  // Создаем меню "Добавить"
  miItem := TMenuItem.Create(Self);
  miItem.Caption := 'Добавить';
  miItem.Tag := -2;
  miItem.ImageIndex := FImageIndexSetting;
  miItem.OnClick := miImportReplicaClick;
  miImport.Add(miItem);

  {// -----------------------------------------------
  // Создаем меню синхронизации
  miSynchronize := TMenuItem.Create(Self);
  miSynchronize.Caption := 'Синхронизация';
  miSynchronize.Tag := -1;
  miSynchronize.ImageIndex := FImageIndexSynchronize;
  //miSynchronize.OnClick := miSynchronizeAllClick;
  Self.Add(miSynchronize);

  // Создаем меню синхронизации всех
  miSynchronizeAll := TMenuItem.Create(Self);
  miSynchronizeAll.Caption := 'Все';
  miSynchronizeAll.Tag := -1;
  miSynchronizeAll.ImageIndex := FImageIndexSynchronize;
  miSynchronizeAll.OnClick := miSynchronizeAllClick;
  miSynchronize.Add(miSynchronizeAll);

  // Создаем элемент отчеркивания
  miItem := TMenuItem.Create(Self);
  miItem.Caption := '-';
  miSynchronize.Add(miItem);

  // Создаем список синхронизации
  Count := FDataModules.dmSynchronizeCount;
  for I := 0 to Count - 1 do
    if FDataModules.dmSynchronize[I] then
    begin
      miItem := TMenuItem.Create(miSynchronize);
      miItem.Caption := FDataModules.dmSynchronize[I].Name;
      miItem.Hint := FDataModules.dmSynchronize[I].Description;
      miItem.Tag := I;
      miItem.OnClick := miSynchronizeAllClick;
      miItem.ImageIndex := miSynchronizeAll.ImageIndex;
      miSynchronize.Add(miItem);
    end;

  // Создаем элемент отчеркивания
  miItem := TMenuItem.Create(Self);
  miItem.Caption := '-';
  miSynchronize.Add(miItem);

  // Создаем меню "Добавить"
  miItem := TMenuItem.Create(Self);
  miItem.Caption := 'Добавить';
  miItem.Tag := -2;
  miItem.ImageIndex := FImageIndexSetting;
  miItem.OnClick := miSynchronizeAllClick;
  miSynchronize.Add(miItem);}

  // -----------------------------------------------
  // Настройки обмена данными
  miItem := TMenuItem.Create(Self);
  miItem.Caption := 'Настройки';
  miItem.ImageIndex := FImageIndexSetting;
  miItem.OnClick := miSettingClick;
  Self.Add(miItem);

  if IsDebug then
  begin
    // Выполнить действие AR_Replica
    miItem := TMenuItem.Create(Self);
    miItem.Caption := 'Выполнить действие AR_Replica';
    miItem.ImageIndex := FImageIndexSynchronize;
    miItem.OnClick := miReplicaReplicateClick;
    Self.Add(miItem);
  end;
end;

procedure TmiDataModules.SetDataModules(Value: TDataModules);
begin
  FDataModules := Value;
  Refresh();
end;

end.
