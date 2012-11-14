{**
@Abstract Форма редактирования задания
@Author Prof1983 <prof1983@ya.ru>
@Created 06.07.2007
@LastMod 14.11.2012
}
unit ATaskForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,
  ATaskObj;

type //** @abstract(Форма редактирования задания)
  TTaskForm = class(TForm)
    TitleLabel: TLabel;
    TitleEdit: TEdit;
    CommentLabel: TLabel;
    CommentMemo: TMemo;
    OKBitBtn: TBitBtn;
    CancelBitBtn: TBitBtn;
    procedure OKBitBtnClick(Sender: TObject);
  private
    FTask: TATask;
    procedure SetTask(Value: TATask);
  public
    //** Задание
    property Task: TATask read FTask write SetTask;
  end;

implementation

{$R *.dfm}

{ TTaskForm }

procedure TTaskForm.OKBitBtnClick(Sender: TObject);
begin
  if Assigned(FTask) then
  begin
    FTask.Title := TitleEdit.Text;
    FTask.Comment := CommentMemo.Text;
  end;
end;

procedure TTaskForm.SetTask(Value: TATask);
begin
  FTask := Value;
  TitleEdit.Text := FTask.Title;
  CommentMemo.Text := FTask.Comment;
end;

end.
