{**
@Abstract Настройки импорта/экспотра и синхронизации справочкиков БД
@Author Prof1983 <prof1983@ya.ru>
@Created 24.04.2006
@LastMod 17.12.2012
}
unit ASetDm;

interface

uses
  AdoDB, Buttons, Classes, Controls, Dialogs, ExtCtrls, Forms, Graphics, ImgList,
  Messages, StdCtrls, SysUtils, Windows,
  ABase, ADbDataModule2, ADbTable, ADbTypes, AUiSpin, AXmlDocumentImpl, AXmlDocumentUtils;

type
  TfrSetDM = class(TFrame)
    ckbEnabled: TCheckBox;
    ckbAutoEnabled: TCheckBox;
    Label1: TLabel;
    lbConnectionString: TLabel;
    edConnectionString: TEdit;
    btConnectionString: TButton;
    ckbOnlyNewRecords: TCheckBox;
    lbTables: TListBox;
    pnFields: TPanel;
    edTableNameIn: TEdit;
    edTableNameOut: TEdit;
    lbKeyFieldsIn: TListBox;
    lbKeyFieldsOut: TListBox;
    lbFieldsIn: TListBox;
    lbFieldsOut: TListBox;
    lbTableIn: TLabel;
    lbTableOut: TLabel;
    btAddKeyField: TSpeedButton;
    btDeleteKeyField: TSpeedButton;
    btAddField: TSpeedButton;
    btDeleteField: TSpeedButton;
    btAddTable: TSpeedButton;
    btDeleteTable: TSpeedButton;
    ImageList: TImageList;
    btIOType: TSpeedButton;
    ckbExport: TCheckBox;
    ckbImport: TCheckBox;
    ckbSynchronize: TCheckBox;
    Label2: TLabel;
    btLoad: TButton;
    btSave: TButton;
    lbFile: TLabel;
    edFile: TEdit;
    btSetFile: TButton;
    edSqlInsert: TEdit;
    btRefreshSql: TSpeedButton;
    edSqlUpdate: TEdit;
    btAll: TButton;
    ckbFullUpdate: TCheckBox;
    procedure ckbEnabledClick(Sender: TObject);
    procedure ckbAutoEnabledClick(Sender: TObject);
    procedure btConnectionStringClick(Sender: TObject);
    procedure btAddKeyFieldClick(Sender: TObject);
    procedure btDeleteKeyFieldClick(Sender: TObject);
    procedure btAddFieldClick(Sender: TObject);
    procedure btDeleteFieldClick(Sender: TObject);
    procedure btAddTableClick(Sender: TObject);
    procedure btDeleteTableClick(Sender: TObject);
    procedure btIOTypeClick(Sender: TObject);
    procedure lbTablesClick(Sender: TObject);
    procedure lbTablesKeyPress(Sender: TObject; var Key: Char);
    procedure btLoadClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure btSetFileClick(Sender: TObject);
    procedure lbKeyFieldsInDblClick(Sender: TObject);
    procedure lbKeyFieldsOutDblClick(Sender: TObject);
    procedure lbFieldsInDblClick(Sender: TObject);
    procedure lbFieldsOutDblClick(Sender: TObject);
    procedure lbTablesDblClick(Sender: TObject);
    procedure btRefreshSqlClick(Sender: TObject);
  private
    edAutoTime: TSpinEdit;
    FDM: TDataModule2;
    FIOType: TDmType;
    FFieldIn_Descr: TStringList;
    FFieldOut_Descr: TStringList;
    FKeyFieldIn_Descr: TStringList;
    FKeyFieldOut_Descr: TStringList;
    FLastItemIndex: Integer;
    // Вовзращает имя текушей локальной таблици
    function GetTableNameIn(): string;
    // Возвращает имя теущей внешней таблици
    function GetTableNameOut(): string;
    // Обновить форму
    procedure RefreshDM();
    procedure SetIOType(Value: TDMType);
    procedure SetDM(Value: TDataModule2);
    procedure SetEnabled(Value: Boolean);
  public
    // Очиска всей формы
    procedure Clear();
    constructor Create(AOwner: TComponent); override;
    // Очиска панели таблици
    procedure ClearTable();
    // Редактируемый модуль данных
    property DM: TDataModule2 read Fdm write SetDM;
    // Тип текущей таблици
    property IOType: TDMType read FIOType write SetIOType;
    // Прочитать параметры из DM
    function LoadParams(): Boolean;
    // Записать параметры в DM
    function SaveParams(): Boolean;
    // Выбрать таблицу для редактирования
    procedure SelectTable(Index: Integer);
    function SaveTableParams(AIndex: Integer): Boolean;
  end;

implementation

{$R *.DFM}

{ TfrSetDM }

procedure TfrSetDM.btAddFieldClick(Sender: TObject);
var
  sFieldIn: string;
  sFieldIn_Descr: string;
  sFieldOut: string;
  sFieldOut_Descr: string;
begin
  if lbTables.ItemIndex < 0 then Exit;
  sFieldIn := InputBox('Добавление полей', Format('Введите имя поля в локальной таблице "%s"', [GetTableNameIn]), '');
  if sFieldIn = '' then Exit;
  sFieldIn_Descr := InputBox('Добавление полей', 'Введите описание поля', 'Поле ' + sFieldIn);
  //if sFieldIn_Descr = '' then Exit;
  sFieldOut := InputBox('Добавление полей', Format('Введите имя поля во внешней таблице "%s"', [GetTableNameOut]), sFieldIn);
  if sFieldOut = '' then Exit;
  sFieldOut_Descr := InputBox('Добавление полей', 'Введите описание поля', sFieldIn_Descr);
  //if sFieldOut_Descr = '' then Exit;

  lbFieldsIn.Items.Add(sFieldIn);
  FFieldIn_Descr.Add(sFieldIn_Descr);
  lbFieldsOut.Items.Add(sFieldOut);
  FFieldOut_Descr.Add(sFieldOut_Descr);
end;

procedure TfrSetDM.btAddKeyFieldClick(Sender: TObject);
var
  sKeyFieldIn: string;
  sKeyFieldIn_Descr: string;
  sKeyFieldOut: string;
  sKeyFieldOut_Descr: string;
begin
  if lbTables.ItemIndex < 0 then Exit;
  sKeyFieldIn := InputBox('Добавление ключевых полей', Format('Введите имя ключевого поля для сравнения в локальной таблице "%s"', [GetTableNameIn]), '');
  if sKeyFieldIn = '' then Exit;
  sKeyFieldIn_Descr := InputBox('Добавление ключевых полей', 'Введите описание ключевого поля', 'Поле ' + sKeyFieldIn);
  //if sKeyFieldIn = '' then Exit;
  sKeyFieldOut := InputBox('Добавление ключевых полей', Format('Введите имя ключевого поля для сравнения во внешней таблице "%s"', [GetTableNameOut]), sKeyFieldIn);
  if sKeyFieldOut = '' then Exit;
  sKeyFieldOut_Descr := InputBox('Добавление ключевых полей', 'Введите описание ключевого поля', sKeyFieldIn_Descr);
  //if sKeyFieldIn = '' then Exit;
  lbKeyFieldsIn.Items.Add(sKeyFieldIn);
  FKeyFieldIn_Descr.Add(sKeyFieldIn_Descr);
  lbKeyFieldsOut.Items.Add(sKeyFieldOut);
  FKeyFieldOut_Descr.Add(sKeyFieldOut_Descr);
end;

procedure TfrSetDM.btAddTableClick(Sender: TObject);
var
  sName: string;
  sTableNameIn: string;
  sTableNameOut: string;
begin
  //if lbTables.ItemIndex < 0 then Exit;
  sName := InputBox('Добавление таблици', 'Введите название для таблици обновления', '');
  if sName = '' then Exit;
  sTableNameIn := InputBox('Добавление таблици', 'Введите имя таблици для обновления в локальной БД', '');
  if sTableNameIn = '' then Exit;
  sTableNameOut := InputBox('Добавление таблици', 'Введите имя таблици для обновления во внешней БД', '');
  if sTableNameOut = '' then Exit;
  if FLastItemIndex >= 0 then
    Self.SaveTableParams(FLastItemIndex);
  FLastItemIndex := -1;
  if FDM.AddTable(sName, sTableNameIn, sTableNameOut) then
    SelectTable(lbTables.Items.Add(sName));
end;

procedure TfrSetDM.btConnectionStringClick(Sender: TObject);
begin
  edConnectionString.Text := PromptDataSource(Self.Handle, edConnectionString.Text);
end;

procedure TfrSetDM.btDeleteFieldClick(Sender: TObject);
var
  I: Integer;
begin
  I := lbFieldsIn.ItemIndex;
  lbFieldsIn.Items.Delete(I);
  lbFieldsOut.Items.Delete(I);
end;

procedure TfrSetDM.btDeleteKeyFieldClick(Sender: TObject);
var
  I: Integer;
begin
  I := lbKeyFieldsIn.ItemIndex;
  lbKeyFieldsIn.Items.Delete(I);
  lbKeyFieldsOut.Items.Delete(I);
end;

procedure TfrSetDM.btDeleteTableClick(Sender: TObject);
begin
  FDM.DeleteTable(lbTables.ItemIndex);
  lbTables.Items.Delete(lbTables.ItemIndex);
end;

procedure TfrSetDM.btIOTypeClick(Sender: TObject);
begin
  if FIOType = High(TDMType) then
    SetIOType(Low(TDMType))
  else
    SetIOType(TDMType(Integer(FIOType) + 1));
end;

procedure TfrSetDM.ckbAutoEnabledClick(Sender: TObject);
begin
  if ckbAutoEnabled.Checked then
  begin
    edAutoTime.Enabled := True;
  end
  else
  begin
    edAutoTime.Enabled := False;
  end;
end;

procedure TfrSetDM.ckbEnabledClick(Sender: TObject);
begin
  SetEnabled(ckbEnabled.Checked);
end;

procedure TfrSetDM.Clear();
begin
  ckbEnabled.Caption := 'Использовать';
  ckbAutoEnabled.Caption := 'Обновнять автоматически с интервалом';
  Label1.Caption := 'секунд';
  lbConnectionString.Caption := 'Строка подключения';
  ckbOnlyNewRecords.Caption := 'Обновлять только новые записи';
  btConnectionString.Hint := 'Конструктор строки подключения';
  btAddTable.Hint := 'Добавить таблицу';
  btDeleteTable.Hint := 'Удалить таблицу';
  lbTableIn.Caption := 'Локальная таблица';
  lbTableOut.Caption := 'Внешняя таблица';
  btAddKeyField.Hint := 'Добавить ключевые поля для сравнения';
  btDeleteKeyField.Hint := 'Удалить ключевые поля для сравнения';
  btAddField.Hint := 'Добавить поля для обновления';
  btDeleteField.Hint := 'Удалить ключевые поля для обновления';
  lbTables.Hint := 'Список таблиц для обновления';
  Label2.Caption := 'Используемые режимы передачи данных';
  btLoad.Caption := 'Загрузить';
  btSave.Caption := 'Сохранить';
  lbFile.Caption := 'Файл настроек';
  btSetFile.Hint := 'Задать файл настроек';
  btAll.Caption := 'Все таблици';
  ckbFullUpdate.Caption := 'Обновить полностью';
  ckbFullUpdate.Hint := 'Очищает данные и полность перечитывает с источника';

  ckbEnabled.Checked := False;
  ckbAutoEnabled.Checked := False;
  edAutoTime.Value := 3600;
  ckbOnlyNewRecords.Checked := False;
  edConnectionString.Text := '';
  lbTables.Clear();
  ClearTable();
  FLastItemIndex := -1;
end;

procedure TfrSetDM.ClearTable();
begin
  edTableNameIn.Text := '';
  edTableNameOut.Text := '';
  lbKeyFieldsIn.Clear();
  lbKeyFieldsOut.Clear();
  lbFieldsIn.Clear();
  lbFieldsOut.Clear();

  FFieldIn_Descr.Clear();
  FFieldOut_Descr.Clear();
  FKeyFieldIn_Descr.Clear();
  FKeyFieldOut_Descr.Clear();
end;

constructor TfrSetDM.Create(AOwner: TComponent);
begin
  FLastItemIndex := -1;
  inherited Create(AOwner);
  FFieldIn_Descr := TStringList.Create();
  FFieldOut_Descr := TStringList.Create();
  FKeyFieldIn_Descr := TStringList.Create();
  FKeyFieldOut_Descr := TStringList.Create();
  edAutoTime := TSpinEdit.Create(Self);
  edAutoTime.Parent := Self;
  edAutoTime.Left := 240;
  edAutoTime.Top := 16;
  edAutoTime.Width := 65;
  edAutoTime.Height := 22;
  edAutoTime.Enabled := False;
  edAutoTime.MaxValue := 0;
  edAutoTime.MinValue := 0;
  edAutoTime.TabOrder := 2;
  edAutoTime.Value := 0;
end;

function TfrSetDM.GetTableNameIn(): string;
begin
  Result := edTableNameIn.Text;
end;

function TfrSetDM.GetTableNameOut(): string;
begin
  Result := edTableNameOut.Text;
end;

procedure TfrSetDM.lbTablesClick(Sender: TObject);
begin
  SelectTable(lbTables.ItemIndex);
end;

procedure TfrSetDM.lbTablesKeyPress(Sender: TObject; var Key: Char);
begin
  SelectTable(lbTables.ItemIndex);
end;

function TfrSetDM.LoadParams(): Boolean;
var
  I: Integer;
begin
  Result := False;
  Clear();
  if not(Assigned(FDM)) then Exit;
  ckbEnabled.Checked := FDM.Enabled;
  SetEnabled(FDM.Enabled);
  ckbAutoEnabled.Checked := FDM.AutoEnabled;
  edAutoTime.Value := FDM.AutoInterval;
  ckbOnlyNewRecords.Checked := FDM.OnlyNewRecords;
  edConnectionString.Text := FDM.ConectionString;
  ckbFullUpdate.Checked := FDM.FullUpdate;

  ckbExport.Checked := (dmtExport in FDM.DMType);
  ckbImport.Checked := (dmtImport in FDM.DMType);
  ckbSynchronize.Checked := (dmtSynchronize in FDM.DMType);

  for I := 0 to FDM.TableCount - 1 do
    lbTables.Items.Add(FDM.Tables[I].Title);
  if FDM.TableCount > 0 then
  begin
    lbTables.ItemIndex := 0;
    SelectTable(0);
  end;
  Result := True;
end;

procedure TfrSetDM.RefreshDM();
begin
end;

function TfrSetDM.SaveParams(): Boolean;
begin
  Result := False;
  if not(Assigned(FDM)) then Exit;
  SaveTableParams(FLastItemIndex);
  FDM.Enabled := ckbEnabled.Checked;
  FDM.AutoEnabled := ckbAutoEnabled.Checked;
  FDM.AutoInterval := edAutoTime.Value;
  FDM.OnlyNewRecords := ckbOnlyNewRecords.Checked;
  FDM.ConectionString := edConnectionString.Text;
  FDM.DMType := [];
  if ckbExport.Checked then FDM.DMType := FDM.DMType + [dmtExport];
  if ckbImport.Checked then FDM.DMType := FDM.DMType + [dmtImport];
  if ckbSynchronize.Checked then FDM.DMType := FDM.DMType + [dmtSynchronize];
  Result := True;
end;

function TfrSetDM.SaveTableParams(AIndex: Integer): Boolean;
var
  t: TTableDM;
begin
  Result := False;
  if (AIndex < 0) or (AIndex >= FDM.TableCount) then Exit;
  try
    t := FDM.Tables[AIndex];
    t.FieldsIn.Clear();
    t.FieldsOut.Clear();
    t.KeyFieldsIn.Clear();
    t.KeyFieldsOut.Clear();

    t.FieldsIn_Descr.Clear();
    t.FieldsOut_Descr.Clear();
    t.KeyFieldsIn_Descr.Clear();
    t.KeyFieldsOut_Descr.Clear();

    t.IOType := FIOType;
    t.FieldsIn.AddStrings(lbFieldsIn.Items);
    t.FieldsOut.AddStrings(lbFieldsOut.Items);
    t.KeyFieldsIn.AddStrings(lbKeyFieldsIn.Items);
    t.KeyFieldsOut.AddStrings(lbKeyFieldsOut.Items);

    t.FieldsIn_Descr.AddStrings(FFieldIn_Descr);
    t.FieldsOut_Descr.AddStrings(FFieldOut_Descr);
    t.KeyFieldsIn_Descr.AddStrings(FKeyFieldIn_Descr);
    t.KeyFieldsOut_Descr.AddStrings(FKeyFieldOut_Descr);

    t.TableNameIn := edTableNameIn.Text;
    t.TableNameOut := edTableNameOut.Text;
  except
  end;
end;

procedure TfrSetDM.SelectTable(Index: Integer);
var
  t: TTableDM;
begin
  // Сохранение
  if FLastItemIndex >= 0 then
    SaveTableParams(FLastItemIndex);
  ClearTable();
  if not(Assigned(FDM)) then Exit;
  if (Index < 0) or (Index >= FDM.TableCount) then Exit;
  lbTables.ItemIndex := Index;
  FLastItemIndex := Index;
  t := FDM.Tables[Index];
  if not(Assigned(t)) then Exit;

  // Заполнение
  lbKeyFieldsIn.Items.AddStrings(t.KeyFieldsIn);
  lbKeyFieldsOut.Items.AddStrings(t.KeyFieldsOut);
  lbFieldsIn.Items.AddStrings(t.FieldsIn);
  lbFieldsOut.Items.AddStrings(t.FieldsOut);
  edTableNameIn.Text := t.TableNameIn;
  edTableNameOut.Text := t.TableNameOut;

  FFieldIn_Descr.AddStrings(t.FieldsIn_Descr);
  FFieldOut_Descr.AddStrings(t.FieldsOut_Descr);
  FKeyFieldIn_Descr.AddStrings(t.KeyFieldsIn_Descr);
  FKeyFieldOut_Descr.AddStrings(t.KeyFieldsOut_Descr);

  SetIOType(t.IOType);
end;

procedure TfrSetDM.SetDM(Value: TDataModule2);
begin
  FDM := Value;
  LoadParams();
  // Отключить автоматическое обновление
  {if Assigned(FDM) then
    FDM.AutoEnabled := False;}
end;

procedure TfrSetDM.SetEnabled(Value: Boolean);
begin
  edConnectionString.Enabled := Value;
  lbTables.Enabled := Value;
  if Value then
  begin
    // ...
  end
  else
  begin
    // ...
  end;
end;

procedure TfrSetDM.SetIOType(Value: TDMType);
begin
  FIOType := Value;
  case FIOType of
    dmtExport: ImageList.GetBitmap(2, btIOType.Glyph);
    dmtImport: ImageList.GetBitmap(3, btIOType.Glyph);
  else //dmSynchronize:
    ImageList.GetBitmap(4, btIOType.Glyph);
  end;
end;

procedure TfrSetDM.btLoadClick(Sender: TObject);

  procedure Load(const AFileName: WideString);
  var
    xd: TProfXmlDocument;
    OldName: WideString;
  begin
    xd := TProfXmlDocument.Create(AFileName);
    try
      // Загрузить все, кроме имени
      OldName := FDM.Name;
      FDM.ConfigureLoad(xd.GetDocumentElement());
      FDM.Name := OldName;
    finally
      xd.Free();
    end;
  end;

var
  od: TOpenDialog;
begin
  if not(Assigned(FDM)) then Exit;
  if edFile.Text = '' then
  begin
    od := TOpenDialog.Create(Self);
    if od.Execute() then
    begin
      Load(od.FileName);
    end;
    od.Free();
  end
  else
    Load(edFile.Text);
  LoadParams();
end;

procedure TfrSetDM.btRefreshSqlClick(Sender: TObject);
var
  I: Integer;
  AFieldsOut: TStringList;
begin
  edSqlInsert.Text := TTableDm.QueryInsert(edTableNameOut.Text, lbFieldsOut.Items, '%InFieldValues%');
  AFieldsOut := TStringList.Create();
  AFieldsOut.AddStrings(lbFieldsOut.Items);
  for I := 0 to AFieldsOut.Count - 1 do
    AFieldsOut.Values[AFieldsOut.Strings[I]] := '%FieldValue['+IntToStr(I)+']%';
  edSqlUpdate.Text := TTableDm.QueryUpdate(edTableNameOut.Text, AFieldsOut, '%Where%');
  AFieldsOut.Free();
end;

procedure TfrSetDM.btSaveClick(Sender: TObject);

  procedure Save(const AFileName: WideString);
  var
    xd: TProfXmlDocument;
  begin
    xd := TProfXmlDocument.Create(AFileName);
    FDM.ConfigureSave(xd.DocumentElement);
    AXmlDocument_SaveToFileP(AXmlDocument(xd), '');
    xd.Free();
  end;

var
  sd: TSaveDialog;
begin
  if not(Assigned(FDM)) then Exit;
  if edFile.Text = '' then
  begin
    sd := TSaveDialog.Create(Self);
    if sd.Execute() then
    begin
      // Сохранить изменения на форме
      SaveTableParams(lbTables.ItemIndex);
      // Сохранить в файл
      Save(sd.FileName);
    end;
    sd.Free();
  end
  else
    Save(edFile.Text);
end;

procedure TfrSetDM.btSetFileClick(Sender: TObject);
var
  sd: TSaveDialog;
begin
  sd := TSaveDialog.Create(Self);
  if sd.Execute then
    edFile.Text := sd.FileName;
  sd.Free();
end;

procedure TfrSetDM.lbKeyFieldsInDblClick(Sender: TObject);
begin
  lbKeyFieldsIn.Items[lbKeyFieldsIn.ItemIndex] := InputBox('Изменение имени поля', 'Введите новое имя поля в локальной БД', lbKeyFieldsIn.Items[lbKeyFieldsIn.ItemIndex]);
  FKeyFieldIn_Descr[lbKeyFieldsIn.ItemIndex] := InputBox('Изменение мени поля', 'Введите описание поля', FKeyFieldIn_Descr[lbKeyFieldsIn.ItemIndex]);
end;

procedure TfrSetDM.lbKeyFieldsOutDblClick(Sender: TObject);
begin
  lbKeyFieldsOut.Items[lbKeyFieldsOut.ItemIndex] := InputBox('Изменение имени поля', 'Введите новое имя поля во внешней БД', lbKeyFieldsOut.Items[lbKeyFieldsOut.ItemIndex]);
  FKeyFieldOut_Descr[lbKeyFieldsOut.ItemIndex] := InputBox('Изменение мени поля', 'Введите описание поля', FKeyFieldOut_Descr[lbKeyFieldsOut.ItemIndex]);
end;

procedure TfrSetDM.lbFieldsInDblClick(Sender: TObject);
begin
  lbFieldsIn.Items[lbFieldsIn.ItemIndex] := InputBox('Изменение имени поля', 'Введите новое имя поля в локальной БД', lbFieldsIn.Items[lbFieldsIn.ItemIndex]);
  FFieldIn_Descr[lbFieldsIn.ItemIndex] := InputBox('Изменение мени поля', 'Введите описание поля', FFieldIn_Descr[lbFieldsIn.ItemIndex]);
end;

procedure TfrSetDM.lbFieldsOutDblClick(Sender: TObject);
begin
  lbFieldsOut.Items[lbFieldsOut.ItemIndex] := InputBox('Изменение имени поля', 'Введите новое имя поля во внешней БД', lbFieldsOut.Items[lbFieldsOut.ItemIndex]);
  FFieldOut_Descr[lbFieldsOut.ItemIndex] := InputBox('Изменение мени поля', 'Введите описание поля', FFieldOut_Descr[lbFieldsOut.ItemIndex]);
end;

procedure TfrSetDM.lbTablesDblClick(Sender: TObject);
var
  t: TTableDM;
  I: Integer;
  oldItemIndex: Integer;
begin
  t := FDM.Tables[lbTables.ItemIndex];
  if Assigned(t) then
    t.Title := InputBox('Изменение имени элемента обмена', 'Введите новое имя элемента обмена', t.Title);
  // Refresh
  oldItemIndex := lbTables.ItemIndex;
  lbTables.Items.Clear();
  for I := 0 to FDM.TableCount - 1 do
    lbTables.Items.Add(FDM.Tables[I].Title);
  FLastItemIndex := -1;
  SelectTable(oldItemIndex);
end;

end.
