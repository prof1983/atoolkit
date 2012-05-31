{**
@Abstract(Настройка импорта и экспорта данных)
@Author(Prof1983 prof1983@ya.ru)
@Created(05.04.2006)
@LastMod(02.05.2012)
@Version(0.5)
}
unit ASetDmForm;

interface

uses
  Classes, ComCtrls, Controls, Dialogs, Forms, Menus,
  ADbDataModule2, ADbDataModules, ADbTypes, ASetDm, ASetDm2, ASetShablonForm;

type // Настройка экспорта данных
  TfmSetExport = class(TfmSetShablon)
  private
    FDataModules: TDataModules;
    fr: TfrSetDM;
    FSetFrame2: TfrSetDMReplica;
    procedure actDelete(Sender: TObject);
    procedure actNew(Sender: TObject);
    procedure Refresh();
    procedure SetDataModules(Value: TDataModules);
  protected
    function DoCommand(const ACommandText, ANodeText: WideString; ATag: Integer): WordBool; override;
    procedure DoCreate(); override;
    function DoDblClick(const ANodeName: WideString): WordBool; override;
    function DoSave(): WordBool; override;
    function DoSelect(const ANodeText: WideString): WordBool; override;
  public
    constructor Create(AOwner: TComponent); override;
    property DataModules: TDataModules read FDataModules write SetDataModules;
  end;

implementation

{ TfmSetExport }

procedure TfmSetExport.actDelete(Sender: TObject);
var
  n: TTreeNode;
  s: string;
begin
  n := Self.tvSettingMain.Selected;
  if not(Assigned(n)) then Exit;
  s := n.Text;
  DataModules.DeleteDataModule(s);
  Refresh();
end;

procedure TfmSetExport.actNew(Sender: TObject);
begin
  DataModules.NewDataModule();
  Refresh();
end;

constructor TfmSetExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TfmSetExport.DoCommand(const ACommandText, ANodeText: WideString; ATag: Integer): WordBool;
begin
  Result := True;
  case ATag of
    1: actNew(Self);    // Новый модуль обмена данными
    2: actDelete(Self); // Удалить модуль обмена данными
  else
    Result := inherited DoCommand(ACommandText, ANodeText, ATag);
  end;
end;

procedure TfmSetExport.DoCreate();
begin
  fr := TfrSetDM.Create(Self);
  fr.Parent := Self;
  fr.Align := alClient;
  fr.Visible := False;

  FSetFrame2 := TfrSetDMReplica.Create(Self);
  FSetFrame2.Parent := Self;
  FSetFrame2.Align := alClient;
  FSetFrame2.Visible := False;

  Width := 550;
  Height := 450;

  Caption := 'Настройка импорта и экспорта данных';

  AddAction('Новый', actNew, iAdd);
  AddAction('Удалить', actDelete, iDelete);

  DoSelect('');
  inherited DoCreate();
end;

function TfmSetExport.DoDblClick(const ANodeName: WideString): WordBool;
var
  dm: TDataModule2;
begin
  dm := FDataModules.DataModuleByName[ANodeName];
  if Assigned(dm) then
  begin
    dm.Name := InputBox('Имя модуля обмена данными', 'Введите новое имя модуля обмена данными', dm.Name);
    tvSettingMain.Selected.Text := dm.Name;
  end
  else
    DoDblClick(ANodeName);
  Result := True;
end;

function TfmSetExport.DoSave(): WordBool;
begin
  inherited DoSave();
  fr.SaveParams();
  Result := FDataModules.ConfigureSave();
end;

function TfmSetExport.DoSelect(const ANodeText: WideString): WordBool;
var
  dm: TDataModule2;
begin
  Result := False;
  // Считывание настроек с фрейма
  fr.SaveParams();
  FSetFrame2.SaveParams();

  fr.Visible := False;
  FSetFrame2.Visible := False;
  if not(Assigned(FDataModules)) then Exit;
  dm := FDataModules.DataModuleByName[ANodeText];
  if Assigned(dm) then
  begin
    if (dmtExport in dm.DMType) or (dmtImport in dm.DMType) or (dmtSynchronize in dm.DMType) then
    begin
      fr.DM := dm;
      fr.Visible := True;
    end
    else
    begin
      FSetFrame2.DM := dm;
      FSetFrame2.Visible := True;
    end;
  end;
end;

procedure TfmSetExport.Refresh();
var
  I: Integer;
begin
  Self.Clear();
  if not(Assigned(FDataModules)) then Exit;

  // Модули обмена данными
  for I := 0 to FDataModules.DataModulesCount - 1 do
  begin
    AddItem(tvSettingMain.Items.AddChild(nil, FDataModules.DataModules[I].Name), nil, FDataModules.DataModules[I].Description);
  end;
end;

procedure TfmSetExport.SetDataModules(Value: TDataModules);
begin
  FDataModules := Value;
  Refresh();
end;

end.
