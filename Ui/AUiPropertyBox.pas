{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(24.08.2009)
@LastMod(29.06.2011)
@Version(0.5)
}
unit AUiPropertyBox;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Controls, ExtCtrls, Forms, Graphics, StdCtrls, AUIBase;

type
  TPropertyBoxChangeProc = function(Sender: AControl; ItemIndex: Integer; const Value: string): Boolean;

type
  TPropertyBox1 = class(TScrollBox)
  private
    FItems: array of record
      Edit: TEdit;
      EditLabel: TLabel;
    end;
    FIsAddPoints: Boolean;
    FOnChange: TPropertyBoxChangeProc;
    FTempValue: string;
    FUseBigFont: Boolean;
    procedure DoEditEnter(Sender: TObject);
    procedure DoEditExit(Sender: TObject);
    function GetItemIndex(Edit: TEdit): Integer;
  protected
    {$IFNDEF FPC}procedure Resizing(State: TWindowState); override;{$ENDIF}
  public
    function GetText(Index: Integer): string;
    function GetUseBigFont: Boolean;
    procedure SetText(Index: Integer; const Value: string);
    procedure SetUseBigFont(Value: Boolean);
  public
    function Add(const Caption1: string): Integer;
    function AddA(const Caption1, Text1, Hint1: string; EditWidth: Integer; ReadOnly: Boolean = False): Integer;
    constructor Create(Parent1: TWinControl);
  public
    property IsAddPoints: Boolean read FIsAddPoints write FIsAddPoints;
    property OnChange: TPropertyBoxChangeProc read FOnChange write FOnChange;
  end;

type
  TPropertyBox2 = class(TScrollBox)
  private
    FItems: array of TLabeledEdit;
  public
    function Add(const Caption1: string): TLabeledEdit;
    function AddItem(Item: TLabeledEdit): Integer;
    constructor Create(Parent1: TWinControl);
  end;

implementation

{ TPropertyBox }

function TPropertyBox1.Add(const Caption1: string): Integer;
begin
  Result := AddA(Caption1, '', '', 100);
end;

function TPropertyBox1.AddA(const Caption1, Text1, Hint1: string; EditWidth: Integer; ReadOnly: Boolean = False): Integer;
var
  Edit: TEdit;
  EditLabel: TLabel;
  NextIndex: Integer;
begin
  // Prof1983: 28.04.2011
  NextIndex := Length(FItems);

  // Prof1983: 19.04.2011
  {Result := Length(FItems);
  SetLength(FItems, Result + 1);}

  Edit := TEdit.Create(Self);
  Edit.Parent := Self;
  Edit.Left := Self.Width - EditWidth - 10;
  if FUseBigFont then
  begin
    Edit.Top := NextIndex * 28 + 4;
    Edit.Height := 20;
    Edit.Font.Name := 'System';
    Edit.Font.Size := 10;
  end
  else
  begin
    Edit.Top := NextIndex * 16 + 4;
    Edit.Height := 14;
    Edit.Font.Name := 'System';
    Edit.Font.Size := 10;
  end;
  Edit.Width := EditWidth;
  Edit.BorderStyle := bsNone;
  Edit.Font.Style := [fsBold];
  Edit.Text := Text1;
  Edit.Anchors := [akRight, akTop];
  Edit.OnEnter := DoEditEnter;
  Edit.OnExit := DoEditExit;
  Edit.ReadOnly := ReadOnly;
  if ReadOnly then
    Edit.Color := clBtnFace
  else
    Edit.Color := clWindow;

  EditLabel := TLabel.Create(Self);
  EditLabel.Parent := Self;
  if FIsAddPoints then
    EditLabel.Caption := Caption1 +
        '..........................................................................................'+
        '..........................................................................................'
  else
    EditLabel.Caption := Caption1;

  EditLabel.Left := 4;
  if FUseBigFont then
  begin
    EditLabel.Top := NextIndex * 28 + 4;
    EditLabel.Height := 20;
  end
  else
  begin
    EditLabel.Top := NextIndex * 16 + 4;
    EditLabel.Height := 16;
  end;
  EditLabel.Hint := Hint1;
  EditLabel.ShowHint := (Hint1 <> '');

  // Prof1983: 28.04.2011
  SetLength(FItems, NextIndex + 1);
  {Result := Length(FItems);
  SetLength(FItems, Result + 1);}

  FItems[NextIndex].Edit := Edit;
  FItems[NextIndex].EditLabel := EditLabel;
  Result := NextIndex;
end;

constructor TPropertyBox1.Create(Parent1: TWinControl);
begin
  inherited Create(Parent1);
  Self.Parent := Parent1;
end;

procedure TPropertyBox1.DoEditEnter(Sender: TObject);
begin
  FTempValue := TEdit(Sender).Text;
end;

procedure TPropertyBox1.DoEditExit(Sender: TObject);
begin
  if (TEdit(Sender).Text <> FTempValue) then
  begin
    if Assigned(FOnChange) then
    begin
      if not(FOnChange(AControl(Self), Self.GetItemIndex(TEdit(Sender)), TEdit(Sender).Text)) then
      begin
        TEdit(Sender).SelectAll;
        TEdit(Sender).SetFocus;
      end;
    end;
  end;
end;

function TPropertyBox1.GetItemIndex(Edit: TEdit): Integer;
var
  I: Integer;
begin
  for I := 0 to High(FItems) do
  begin
    if (FItems[I].Edit = Edit) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function TPropertyBox1.GetText(Index: Integer): string;
begin
  if (Index >= 0) and (Index < Length(FItems)) then
    Result := FItems[Index].Edit.Text
  else
    Result := '';
end;

function TPropertyBox1.GetUseBigFont: Boolean;
begin
  Result := FUseBigFont;
end;

{$IFNDEF FPC}
procedure TPropertyBox1.Resizing(State: TWindowState);
var
  I: Integer;
begin
  inherited;
  for I := 0 to High(FItems) do
    FItems[I].EditLabel.Width := Self.Width - FItems[I].Edit.Width - 25;
  // ...
end;
{$ENDIF UNIX}

procedure TPropertyBox1.SetText(Index: Integer; const Value: string);
begin
  if (Index >= 0) and (Index < Length(FItems)) then
    FItems[Index].Edit.Text := Value;
end;

{ TPropertyBox2 }

function TPropertyBox2.Add(const Caption1: string): TLabeledEdit;
begin
  Result := TLabeledEdit.Create(Self);
  Result.Width := 100;
  Result.EditLabel.Caption := Caption1;

  AddItem(Result);
end;

function TPropertyBox2.AddItem(Item: TLabeledEdit): Integer;
begin
  Result := Length(FItems);
  SetLength(FItems, Result + 1);
  FItems[Result] := Item;

  Item.Parent := Self;
  Item.Left := Self.Width - Item.Width - 10;
  Item.Top := Result * 16 + 4;
  Item.Height := 14;
  Item.LabelPosition := lpLeft;

  Item.BorderStyle := bsNone;
  Item.Font.Name := 'System';
  Item.Font.Size := 10;
  Item.Font.Style := [fsBold];
end;

constructor TPropertyBox2.Create(Parent1: TWinControl);
begin
  inherited Create(Parent1);
  Self.Parent := Parent1;
end;

procedure TPropertyBox1.SetUseBigFont(Value: Boolean);
var
  i: Integer;
  Edit: TEdit;
  EditLabel: TLabel;
begin
  if (FUseBigFont <> Value) then
  begin
    FUseBigFont := Value;
    for i := 0 to High(FItems) do
    begin
      Edit := FItems[i].Edit;
      if FUseBigFont then
      begin
        Edit.Top := i * 28 + 4;
        Edit.Height := 24;
        Edit.Font.Name := 'System';
        Edit.Font.Size := 10;
      end
      else
      begin
        Edit.Top := i * 16 + 4;
        Edit.Height := 14;
        Edit.Font.Name := 'System';
        Edit.Font.Size := 10;
      end;

      EditLabel := FItems[i].EditLabel;
      if FUseBigFont then
      begin
        EditLabel.Top := i * 28 + 4;
        EditLabel.Height := 24;
      end
      else
      begin
        EditLabel.Top := i * 16 + 4;
        EditLabel.Height := 16;
      end;
    end;
  end;
end;

end.
 
