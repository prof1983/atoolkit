{**
@Author Prof1983 <prof1983@ya.ru>
@Created 10.06.2007
@LastMod 05.02.2013
}
unit ACommandComboBoxControl;

interface

uses
  Classes, StdCtrls;

type
  TCommandComboBoxControl = class
  private
    FControl: TComboBox;
    FOnCommand: TNotifyEvent;
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SetControl(Value: TComboBox);
  public
    property Control: TComboBox read FControl write SetControl;
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
