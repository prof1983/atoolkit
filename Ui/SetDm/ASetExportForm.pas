{**
@Abstract(Настройка импорта и экспорта данных)
@Author(Prof1983 prof1983@ya.ru)
@Created(05.04.2006)
@LastMod(02.05.2012)
@Version(0.5)
}
unit ASetExportForm;

interface

uses
  Classes, ComCtrls, Controls, Forms, Menus,
  ADbDataModule2, ADbDataModules, ASetDm, ASetShablonForm;

type // Настройка экспорта данных
  TfmSetExport = class(TfmSetShablon)
  private
    FDataModules: TDataModules;
    fr: TfrSetDM;
    pmExport: TPopupMenu;
    pmImport: TPopupMenu;
    pmSynchronize: TPopupMenu;
    tnExport: TTreeNode;
    tnImport: TTreeNode;
    tnSynchronize: TTreeNode;
    procedure SetDataModules(Value: TDataModules);
  protected
    function DoCommand(const ACommandText, ANodeText: WideString; ATag: Integer): WordBool; override;
    procedure DoCreate(); override;
    function DoSave(): WordBool; override;
    function DoSelect(const ANodeText: WideString): WordBool; override;
  public
    constructor Create(AOwner: TComponent); override;
    property DataModules: TDataModules read FDataModules write SetDataModules;
  end;

implementation

{ TfmSetExport }

constructor TfmSetExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TfmSetExport.DoCommand(const ACommandText, ANodeText: WideString; ATag: Integer): WordBool;
begin
  Result := True;
  if ACommandText = 'New' then
    DataModules.NewDataModule()
  else
    Result := inherited DoCommand(ACommandText, ANodeText, ATag);
end;

procedure TfmSetExport.DoCreate();
begin
  fr := TfrSetDM.Create(Self);
  fr.Parent := Self;
  fr.Align := alClient;

  Width := 550;
  Height := 450;

  Caption := 'Настройка импорта и экспорта данных';
  tnExport := tvSettingMain.Items.Add(nil, 'Экспорт');
  AddItem(tnExport, nil, 'Настройка экспорта данных');
  tnImport := tvSettingMain.Items.Add(nil, 'Импорт');
  AddItem(tnImport, nil, 'Настройка импорта данных');
  tnSynchronize := tvSettingMain.Items.Add(nil, 'Синхронизация');
  AddItem(tnImport, nil, 'Настройка синхронизации данных');

  pmExport := TPopupMenu.Create(Self);
  pmImport := TPopupMenu.Create(Self);
  pmSynchronize := TPopupMenu.Create(Self);

  AddCommand('New', 1);
  AddCommand('Delete', 2);

  {// Экспорт
  AddItem(tvSettingMain.Items.AddChild(tnExport, 'AR'), nil, 'Настройка экспорта в БД "AR"');

  // Импорт
  AddItem(tvSettingMain.Items.AddChild(tnImport, 'WinVesy'), nil, 'Настройка импорта составов из программы WinVesy');

  fr := TfrSetKazHrom.Create(Self);
  fr.Parent := Self;
  fr.Align := alClient;
  fr.Visible := False;

  AddItem(tvSettingMain.Items.AddChild(tnImport, 'AR'), nil, 'Настройка импорта из БД "AR"');}

  inherited DoCreate();
end;

function TfmSetExport.DoSave(): WordBool;
begin
  //frSetExport.Save();
  Result := inherited DoSave();
end;

function TfmSetExport.DoSelect(const ANodeText: WideString): WordBool;
var
  dm: TDataModule2;
begin
  Result := False;
  // Считывание настроек с фрейма
  fr.SaveParams();

  fr.Visible := False;
  if not(Assigned(FDataModules)) then Exit;
  dm := FDataModules.DataModuleByName[ANodeText];
  if not(Assigned(dm)) then Exit;

  fr.DM := dm;
  fr.Visible := True;
end;

procedure TfmSetExport.SetDataModules(Value: TDataModules);
var
  I: Integer;
begin
  FDataModules := Value;
  if not(Assigned(FDataModules)) then Exit;

  for I := 0 to FDataModules.dmExportCount - 1 do
  begin
    AddItem(tvSettingMain.Items.AddChild(tnExport, FDataModules.dmExport[I].Name), nil, FDataModules.dmExport[I].Description);
  end;

  for I := 0 to FDataModules.dmImportCount - 1 do
  begin
    AddItem(tvSettingMain.Items.AddChild(tnImport, FDataModules.dmImport[I].Name), nil, FDataModules.dmImport[I].Description);
  end;

  for I := 0 to FDataModules.dmSynchronizeCount - 1 do
  begin
    AddItem(tvSettingMain.Items.AddChild(tnSynchronize, FDataModules.dmSynchronize[I].Name), nil, FDataModules.dmSynchronize[I].Description);
  end;
end;

end.
