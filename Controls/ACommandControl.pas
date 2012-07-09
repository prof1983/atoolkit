{**
@Abstract(Контрол ввода команд)
@Author(Prof1983 prof1983@ya.ru)
@Created(01.04.2007)
@LastMod(09.07.2012)
@Version(0.5)
}
unit ACommandControl;

interface

uses
  Classes, Controls, StdCtrls,
  AControlImpl, ATypes;

type
  TCommandControl = class(TProfControl)
  private
    FInputMemo: TMemo;
    procedure DoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    function DoInitialize(): TProfError; override; safecall;
  public
    function AddMessage(const Msg: WideString): Integer; override;
  end;

implementation

{ TCommandControl }

function TCommandControl.AddMessage(const Msg: WideString): Integer;
begin
  Result := 0;
  // Ничего не делаем
end;

function TCommandControl.DoInitialize(): TProfError;
begin
  Result := inherited DoInitialize();
  FInputMemo := TMemo.Create(FControl);
  FInputMemo.Parent := FControl;
  FInputMemo.Align := alClient;
  FInputMemo.OnKeyUp := DoKeyUp;
end;

procedure TCommandControl.DoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  s: string;
begin
  if Key = 13 then
  begin
    s := FInputMemo.Text;
    if Length(s) <= 0 then Exit;
    if s[Length(s)] = #10 then Delete(s, Length(s), 1);
    if Length(s) <= 0 then Exit;
    if s[Length(s)] = #13 then Delete(s, Length(s), 1);
    if Length(s) <= 0 then Exit;

    // Вызываем событие OnMessage
    //DoMessage(s);
    FInputMemo.Clear();
  end;
end;

end.
