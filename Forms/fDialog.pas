{**
@Abstract(Форма для создания диалогов)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.08.2006)
@LastMod(02.05.2012)
@Version(0.5)
}
unit fDialog;

interface

uses
  Classes, Controls, Graphics, ExtCtrls, StdCtrls,
  fShablon;

type
  //** @abstract(Форма для создания диалогов)
  TfmDialog = class(TfmShablon)
  private
  protected
    btOk: TButton;
    btCancel: TButton;
    pnButtons: TPanel;
    //** Срабатывает при нажатии "Отмена"
    procedure DoCancel(); virtual;
    //** Срабатывает при создании
    procedure DoCreate(); override;
    //** Срабатывает при нажатии "OK"
    procedure DoOK(); virtual;
    //** Срабатывает при изменении размеров
    procedure DoResize(Sender: TObject); override;
  public
  end;

type
  //** @abstract(Форма диалога с Memo)
  TfmDialogMemo = class(TfmDialog)
  protected
    FmmMsg: TMemo;
    //** Срабатывает при создании
    procedure DoCreate(); override;
  public
    property mmMsg: TMemo read FmmMsg;
    //** Добавить сообщение
    procedure AddMsg(const AMsg: WideString);
  end;

type
  //** @abstract(Форма диалога с Memo вывода сообщений и с Memo ввода сообщений)
  TfmDialogMemoInput = class(TfmDialogMemo)
  protected
    FmemInput: TMemo;
    //** Срабатывает при создании
    procedure DoCreate(); override;
  public
  end;

implementation

{ TfmDialog }

procedure TfmDialog.DoCancel();
begin
end;

procedure TfmDialog.DoCreate();
begin
  inherited DoCreate();
  pnButtons := TPanel.Create(Self);
  pnButtons.Parent := Self;
  pnButtons.Align := alBottom;
  pnButtons.Height := 40;

  btOk := TButton.Create(Self);
  btOk.Parent := pnButtons;
  btOk.Caption := 'Ok';
  btOk.Left := 50;
  btOk.Top := 10;
  btOk.ModalResult := mrOk;

  btCancel := TButton.Create(Self);
  btCancel.Parent := pnButtons;
  btCancel.Caption := 'Отмена';
  btCancel.Left := 150;
  btCancel.Top := 10;
  btCancel.ModalResult := mrCancel;
end;

procedure TfmDialog.DoOK();
begin
end;

procedure TfmDialog.DoResize(Sender: TObject);
var
  w: Integer;
begin
  inherited DoResize(Sender);

  // Расположить кнопочки по центру
  w := btOk.Width + btCancel.Width;
  w := (Width - w) div 3;
  btOk.Left := w;
  btCancel.Left := 2 * w + btOk.Width;
end;

{ TfmDialogMemo }

procedure TfmDialogMemo.AddMsg(const AMsg: WideString);
begin
  if AMsg = '-' then
    FmmMsg.Lines.Add('--------------------------------')
  else if AMsg = '=' then
    FmmMsg.Lines.Add('================================')
  else
    FmmMsg.Lines.Add(AMsg);
end;

procedure TfmDialogMemo.DoCreate();
begin
  inherited DoCreate();
  Caption := 'Диалог';
  FmmMsg := TMemo.Create(Self);
  FmmMsg.Parent := Self;
  FmmMsg.Align := alClient;
end;

{ TfmDialogMemoInput }

procedure TfmDialogMemoInput.DoCreate();
begin
  inherited DoCreate();

  Self.FmmMsg.Align := alTop;
  Self.FmmMsg.Height := 100;
  Self.FmmMsg.Color := clLtGray;

  FmemInput := TMemo.Create(Self);
  FmemInput.Parent := Self;
  FmemInput.Top := 150;
  FMemInput.Align := alClient;
end;

end.
