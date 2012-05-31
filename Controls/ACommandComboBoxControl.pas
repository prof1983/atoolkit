{**
@Abstract(Класс управления для ComboBox ввода команд)
@Author(Prof1983 prof1983@ya.ru)
@Created(10.06.2007)
@LastMod(02.05.2012)
@Version(0.5)
}
unit ACommandComboBoxControl;

interface

uses
  Classes, StdCtrls;

type //** @abstract(Класс управления для ComboBox ввода команд)
  TCommandComboBoxControl = class
  private
    //** Элемент управления
    FControl: TComboBox;
    //** Событие, возникающее при вводе команды
    FOnCommand: TNotifyEvent;
    //** Обработчик события OnKeyDown
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    //** Обработчик события OnKeyUp
    procedure KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    //** Задает элемент управления
    procedure SetControl(Value: TComboBox);
  public
    //** Элемент управления
    property Control: TComboBox read FControl write SetControl;
    //** Событие, возникающее при вводе команды
    property OnCommand: TNotifyEvent read FOnCommand write FOnCommand;
  end;

implementation

{ TCommandComboBoxControl }

procedure TCommandComboBoxControl.KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    if Assigned(FOnCommand) then
    try
      FOnCommand(Self);
    except
    end;
end;

procedure TCommandComboBoxControl.KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    Control.Text := '';
end;

procedure TCommandComboBoxControl.SetControl(Value: TComboBox);
begin
  FControl := Value;
  if Assigned(FControl) then
  begin
    FControl.OnKeyDown := KeyDown;
    FControl.OnKeyUp := KeyUp;
  end;
end;

end.
