{**
@Author Prof1983 <prof1983@ya.ru>
@Created 28.10.2006
@LastMod 05.02.2013
}
unit AMessagesMemoControl;

interface

uses
  Classes, Controls, StdCtrls,
  ABase,
  AMessagesControl, ATypes;

type
  TMessagesMemoControl = class(TMessagesControl)
  private
    procedure memInputKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure memInputKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    memInput: TMemo;
    memMessages: TMemo;
  protected
    function DoMessageAdd(const AMessage: WideString; AID: Integer): Integer; override;
  public
    function Initialize(): AError; override;
  end;

implementation

{ TMessagesMemoControl }

function TMessagesMemoControl.DoMessageAdd(const AMessage: WideString; AID: Integer): Integer;
begin
  Result := inherited DoMessageAdd(AMessage, AID);
  memMessages.Lines.Insert(0, AMessage);
end;

function TMessagesMemoControl.Initialize(): AError;
begin
  Result := inherited Initialize();
  memInput := TMemo.Create(FControl);
  memInput.Parent := FControl;
  memInput.Height := 20;
  memInput.Align := alBottom;
  memInput.OnKeyDown := memInputKeyDown;
  memInput.OnKeyUp := memInputKeyUp;

  memMessages := TMemo.Create(FControl);
  memMessages.Parent := FControl;
  memMessages.Align := alClient;
  memMessages.ScrollBars := ssVertical;
end;

procedure TMessagesMemoControl.memInputKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 13) and (memInput.Text <> '') then
  begin
    DoMessageAdd(memInput.Text, -1);
    memInput.Lines.Clear();
  end;
end;

procedure TMessagesMemoControl.memInputKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    memInput.Lines.Clear();
  end;
end;

end.
