{**
@Abstract(Контрол сообщений с выводом в Memo)
@Author(Prof1983 prof1983@ya.ru)
@Created(28.10.2006)
@LastMod(26.04.2012)
@Version(0.5)
}
unit AMemoControl;

interface

uses
  Classes, Controls, StdCtrls,
  AControlImpl, ATypes;

type //** @abstract(Контрол сообщений с выводом в Memo)
  TProfMemoControl = class(TProfControl)
  private
    procedure memInputKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure memInputKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    memInput: TMemo;
    memMessages: TMemo;
  protected
    function SendMessage(const Msg: WideString): Integer; override; safecall;
  public
    function AddMessage(const Msg: WideString): Integer; override; safecall;
    function Initialize(): TProfError; override; //safecall;
    procedure LoadFromFile(const FileName: WideString);
  end;

implementation

{ TMessagesMemoControl }

function TProfMemoControl.AddMessage(const Msg: WideString): Integer;
begin
  Result := memMessages.Lines.Add('<-- ' + Msg);
end;

function TProfMemoControl.Initialize(): TProfError;
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

procedure TProfMemoControl.LoadFromFile(const FileName: WideString);
begin
  memMessages.Lines.LoadFromFile(FileName);
end;

procedure TProfMemoControl.memInputKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 13) and (memInput.Text <> '') then
  begin
    SendMessage(memInput.Text);
    memInput.Lines.Clear();
  end;
end;

procedure TProfMemoControl.memInputKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    memInput.Lines.Clear();
  end;
end;

function TProfMemoControl.SendMessage(const Msg: WideString): Integer;
begin
  inherited SendMessage(Msg);
  Result := memMessages.Lines.Add('--> ' + Msg);

  //memMessages.Lines.Insert(0, Msg);
  //Result := memMessages.Lines.Count;
end;

end.
