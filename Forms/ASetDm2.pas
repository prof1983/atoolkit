{**
@Abstract(Настройки импорта/экспотра и синхронизации справочкиков БД)
@Author(Prof1983 prof1983@ya.ru)
@Created(01.08.2006)
@LastMod(02.05.2012)
@Version(0.5)
}
unit ASetDm2;

interface

uses
  Buttons, Classes, Controls, Dialogs, Forms, Graphics, Messages, StdCtrls, SysUtils, Windows,
  ADbDataModule2; 

type
  TfrSetDMReplica = class(TFrame)
    ckbEnabled: TCheckBox;
    lbActions: TListBox;
    btAdd: TSpeedButton;
    btDelete: TSpeedButton;
    btUp: TSpeedButton;
    btDown: TSpeedButton;
    procedure btAddClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure btDownClick(Sender: TObject);
    procedure btUpClick(Sender: TObject);
    procedure lbActionsDblClick(Sender: TObject);
  private
    FDM: TDataModule2;
    FImageList: TImageList;
    procedure SetDM(Value: TDataModule2);
  public
      //** Очистка окна
    procedure Clear();
      //** Модуль данных
    property DM: TDataModule2 read FDM write SetDM;
      //** Стандартные картинки
    property ImageList: TImageList read FImageList write FImageList;
      //** Записать параметры в DM
    function SaveParams(): Boolean;
      //** Прочитать настройки из DM
    procedure Refresh();
  end;

implementation

{$R *.DFM}

{ TfrSetDMReplica }

procedure TfrSetDMReplica.btAddClick(Sender: TObject);
var
  S: string;
begin
  S := InputBox('Добавление действия', 'Введите название действия', '');
  lbActions.Items.Add(S);
end;

procedure TfrSetDMReplica.btDeleteClick(Sender: TObject);
begin
  lbActions.Items.Delete(lbActions.ItemIndex);
end;

procedure TfrSetDMReplica.btDownClick(Sender: TObject);
begin
  if (lbActions.ItemIndex < lbActions.Items.Count - 1) then
    lbActions.Items.Move(lbActions.ItemIndex, lbActions.ItemIndex + 1);
end;

procedure TfrSetDMReplica.btUpClick(Sender: TObject);
begin
  if (lbActions.ItemIndex > 0) then
    lbActions.Items.Move(lbActions.ItemIndex, lbActions.ItemIndex - 1);
end;

procedure TfrSetDMReplica.Clear();
begin
  ckbEnabled.Caption := 'Включить';
end;

procedure TfrSetDMReplica.lbActionsDblClick(Sender: TObject);
begin
  lbActions.Items.Strings[lbActions.ItemIndex] := InputBox('Редактирование имени', 'Измените имя действия', lbActions.Items.Strings[lbActions.ItemIndex]);
end;

procedure TfrSetDMReplica.Refresh();
begin
  {if not(Assigned(FDM)) then Exit;
  try
    ckbEnabled.Checked := FDM.Enabled;
    lbActions.Items.AddStrings(TDMReplica(FDM).ReplicaActions);
  except
  end;}
end;

function TfrSetDMReplica.SaveParams(): Boolean;
begin
  {Result := Assigned(FDM);
  if not(Result) then Exit;
  try
    FDM.Enabled := ckbEnabled.Checked;
    TDMReplica(FDM).ReplicaActions.Clear();
    TDMReplica(FDM).ReplicaActions.AddStrings(lbActions.Items);
  except
  end;}
end;

procedure TfrSetDMReplica.SetDM(Value: TDataModule2);
begin
  FDM := Value;
  Refresh();
end;

end.
