{**
@abstract AUi PropertyBox
@author Prof1983 <prof1983@ya.ru>
@created 24.08.2009
@lastmod 01.02.2013
}
unit AUiPropertyBox;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Controls,
  ExtCtrls,
  Forms,
  Graphics,
  StdCtrls,
  ABase,
  AStringMain,
  AUiBase;

type
  TPropertyBoxChangeProc = function(Sender: AControl; ItemIndex: Integer; const Value: string): Boolean;

// --- AUiPropertyBox ---

function AUiPropertyBox_Add(PropertyBox: AControl;
    const Caption: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUiPropertyBox_Add2(PropertyBox: AControl; const Caption, Text, Hint: AString_Type;
    EditWidth: AInteger): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUiPropertyBox_Add2P(PropertyBox: AControl; const Caption, Text, Hint: APascalString;
    EditWidth: AInt): AInt;

function AUiPropertyBox_Add3P(PropertyBox: AControl; const Caption, Text, Hint: APascalString;
    EditWidth: AInt; IsReadOnly: ABool): AInt;

function AUiPropertyBox_AddP(PropertyBox: AControl; const Caption: APascalString): AInt;

function AUiPropertyBox_GetUseBigFont(PropertyBox: AControl): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUiPropertyBox_Item_GetValue(PropertyBox: AControl; Index: AInt;
    out Value: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUiPropertyBox_Item_GetValueP(PropertyBox: AControl; Index: AInt): APascalString;

function AUiPropertyBox_Item_SetValue(PropertyBox: AControl; Index: AInt;
    const Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiPropertyBox_Item_SetValueP(PropertyBox: AControl; Index: AInt;
    const Value: APascalString): AError;

function AUiPropertyBox_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiPropertyBox_SetIsAppPoints(PropertyBox: AControl; Value: ABool): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiPropertyBox_SetOnChange(PropertyBox: AControl; OnChange: TPropertyBoxChangeProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiPropertyBox_SetTextP(PropertyBox: AControl; Index: AInt; const Value: APascalString): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiPropertyBox_SetUseBigFont(PropertyBox: AControl; Value: ABool): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

// --- Private ---

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
    function AddItem(EditBox: TEdit; TextBox: TLabel): Integer;
    function AddItem2(EditBox: TEdit; TextBox: TLabel; EditWidth: Integer): Integer;
    function AddNew(const Caption1: string): Integer;
    function AddNew2(const Caption1, Text1, Hint1: string; EditWidth: Integer; ReadOnly: Boolean = False): Integer;
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


type
  TPropertyBoxControl = class
  private
    FParent: TWinControl; // TScrollBox
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
  public
    function GetText(Index: Integer): string;
    function GetUseBigFont: Boolean;
    procedure SetText(Index: Integer; const Value: string);
    procedure SetUseBigFont(Value: Boolean);
  public
    function AddItem(EditBox: TEdit; TextBox: TLabel): Integer;
    function AddItem2(EditBox: TEdit; TextBox: TLabel; EditWidth: Integer): Integer;
    function AddNew(const Caption1: string): Integer;
    function AddNew2(const Caption1, Text1, Hint1: string; EditWidth: Integer; ReadOnly: Boolean = False): Integer;
    constructor Create(Parent: TWinControl);
    procedure Resizing();
  public
    property IsAddPoints: Boolean read FIsAddPoints write FIsAddPoints;
    property OnChange: TPropertyBoxChangeProc read FOnChange write FOnChange;
  end;

// --- AUiPropertyBox ---

function AUiPropertyBox_Add(PropertyBox: AControl; const Caption: AString_Type): AInt;
begin
  try
    Result := AUiPropertyBox_AddP(PropertyBox, AString_ToPascalString(Caption));
  except
    Result := 0;
  end;
end;

function AUiPropertyBox_Add2(PropertyBox: AControl; const Caption, Text, Hint: AString_Type;
    EditWidth: AInt): AInt;
begin
  try
    Result := AUiPropertyBox_Add2P(PropertyBox,
        AString_ToPascalString(Caption),
        AString_ToPascalString(Text),
        AString_ToPascalString(Hint),
        EditWidth);
  except
    Result := 0;
  end;
end;

function AUiPropertyBox_Add2P(PropertyBox: AControl; const Caption, Text, Hint: APascalString; EditWidth: AInt): AInt;
begin
  try
    Result := TPropertyBox1(PropertyBox).AddNew2(Caption, Text, Hint, EditWidth);
  except
    Result := 0;
  end;
end;

function AUiPropertyBox_Add3P(PropertyBox: AControl; const Caption, Text, Hint: APascalString;
    EditWidth: AInt; IsReadOnly: ABool): AInt;
begin
  try
    Result := TPropertyBox1(PropertyBox).AddNew2(Caption, Text, Hint, EditWidth, IsReadOnly);
  except
    Result := 0;
  end;
end;

function AUiPropertyBox_AddP(PropertyBox: AControl; const Caption: APascalString): AInt;
begin
  try
    Result := TPropertyBox1(PropertyBox).AddNew(Caption);
  except
    Result := 0;
  end;
end;

function AUiPropertyBox_GetUseBigFont(PropertyBox: AControl): ABool;
begin
  try
    Result := TPropertyBox1(PropertyBox).GetUseBigFont();
  except
    Result := False;
  end;
end;

function AUiPropertyBox_Item_GetValue(PropertyBox: AControl; Index: AInt;
    out Value: AString_Type): AInt;
begin
  try
    Result := AString_AssignP(Value, AUiPropertyBox_Item_GetValueP(PropertyBox, Index));
  except
    Result := 0;
  end;
end;

function AUiPropertyBox_Item_GetValueP(PropertyBox: AControl; Index: AInt): APascalString;
begin
  try
    Result := TPropertyBox1(PropertyBox).GetText(Index);
  except
    Result := '';
  end;
end;

function AUiPropertyBox_Item_SetValue(PropertyBox: AControl; Index: AInt;
    const Value: AString_Type): AError;
begin
  try
    Result := AUiPropertyBox_Item_SetValueP(PropertyBox, Index, AString_ToPascalString(Value));
  except
    Result := -1;
  end;
end;

function AUiPropertyBox_Item_SetValueP(PropertyBox: AControl; Index: AInt;
    const Value: APascalString): AError;
begin
  try
    TPropertyBox1(PropertyBox).SetText(Index, Value);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiPropertyBox_New(Parent: AControl): AControl;
begin
  try
    Result := AControl(TPropertyBox1.Create(TWinControl(Parent)));
  except
    Result := 0;
  end;
end;

function AUiPropertyBox_SetIsAppPoints(PropertyBox: AControl; Value: ABool): AError;
begin
  try
    TPropertyBox1(PropertyBox).IsAddPoints := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiPropertyBox_SetOnChange(PropertyBox: AControl; OnChange: TPropertyBoxChangeProc): AError;
begin
  try
    TPropertyBox1(PropertyBox).OnChange := OnChange;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiPropertyBox_SetTextP(PropertyBox: AControl; Index: AInt; const Value: APascalString): AError;
begin
  try
    TPropertyBox1(PropertyBox).SetText(Index, Value);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiPropertyBox_SetUseBigFont(PropertyBox: AControl; Value: ABool): AError;
begin
  try
    TPropertyBox1(PropertyBox).SetUseBigFont(Value);
    Result := 0;
  except
    Result := -1;
  end;
end;

{ TPropertyBox1 }

function TPropertyBox1.AddItem(EditBox: TEdit; TextBox: TLabel): Integer;
begin
  Result := AddItem2(EditBox, TextBox, 100);
end;

function TPropertyBox1.AddItem2(EditBox: TEdit; TextBox: TLabel; EditWidth: Integer): Integer;
var
  NextIndex: Integer;
begin
  if (EditBox.Parent <> Self) or (TextBox.Parent <> Self) then
  begin
    Result := -2;
    Exit;
  end;

  NextIndex := Length(FItems);

  EditBox.Left := Self.Width - EditWidth - 10;
  if FUseBigFont then
  begin
    EditBox.Top := NextIndex * 28 + 4;
    EditBox.Height := 20;
    EditBox.Font.Name := 'System';
    EditBox.Font.Size := 10;
  end
  else
  begin
    EditBox.Top := NextIndex * 16 + 4;
    EditBox.Height := 14;
    EditBox.Font.Name := 'System';
    EditBox.Font.Size := 10;
  end;
  EditBox.Width := EditWidth;
  EditBox.BorderStyle := bsNone;
  EditBox.Font.Style := [fsBold];
  //EditBox.Text := Text1;
  EditBox.Anchors := [akRight, akTop];
  EditBox.OnEnter := DoEditEnter;
  EditBox.OnExit := DoEditExit;
  //EditBox.ReadOnly := ReadOnly;
  if EditBox.ReadOnly then
    EditBox.Color := clBtnFace
  else
    EditBox.Color := clWindow;

  if FIsAddPoints then
  begin
    TextBox.Caption := TextBox.Caption +
        '..........................................................................................'+
        '..........................................................................................';
  end;

  TextBox.Left := 4;
  if FUseBigFont then
  begin
    TextBox.Top := NextIndex * 28 + 4;
    TextBox.Height := 20;
  end
  else
  begin
    TextBox.Top := NextIndex * 16 + 4;
    TextBox.Height := 16;
  end;
  //TextBox.Hint := Hint1;
  //TextBox.ShowHint := (Hint1 <> '');

  SetLength(FItems, NextIndex + 1);

  FItems[NextIndex].Edit := EditBox;
  FItems[NextIndex].EditLabel := TextBox;
  Result := NextIndex;
end;

function TPropertyBox1.AddNew(const Caption1: string): Integer;
begin
  Result := AddNew2(Caption1, '', '', 100);
end;

function TPropertyBox1.AddNew2(const Caption1, Text1, Hint1: string; EditWidth: Integer; ReadOnly: Boolean = False): Integer;
var
  Edit: TEdit;
  EditLabel: TLabel;
  NextIndex: Integer;
begin
  NextIndex := Length(FItems);

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

  SetLength(FItems, NextIndex + 1);

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
end;
{$ENDIF FPC}

procedure TPropertyBox1.SetText(Index: Integer; const Value: string);
begin
  if (Index >= 0) and (Index < Length(FItems)) then
    FItems[Index].Edit.Text := Value;
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

{ TPropertyBoxControl }

function TPropertyBoxControl.AddItem(EditBox: TEdit; TextBox: TLabel): Integer;
begin
  Result := AddItem2(EditBox, TextBox, EditBox.Width);
end;

function TPropertyBoxControl.AddItem2(EditBox: TEdit; TextBox: TLabel; EditWidth: Integer): Integer;
var
  NextIndex: Integer;
begin
  if (EditBox.Parent <> FParent) or (TextBox.Parent <> FParent) then
  begin
    Result := -2;
    Exit;
  end;

  NextIndex := Length(FItems);

  EditBox.Left := FParent.Width - EditWidth - 10;
  if FUseBigFont then
  begin
    EditBox.Top := NextIndex * 28 + 4;
    EditBox.Height := 20;
    EditBox.Font.Name := 'System';
    EditBox.Font.Size := 10;
  end
  else
  begin
    EditBox.Top := NextIndex * 16 + 4;
    EditBox.Height := 14;
    EditBox.Font.Name := 'System';
    EditBox.Font.Size := 10;
  end;
  EditBox.Width := EditWidth;
  EditBox.BorderStyle := bsNone;
  EditBox.Font.Style := [fsBold];
  //EditBox.Text := Text1;
  EditBox.Anchors := [akRight, akTop];
  EditBox.OnEnter := DoEditEnter;
  EditBox.OnExit := DoEditExit;
  //EditBox.ReadOnly := ReadOnly;
  if EditBox.ReadOnly then
    EditBox.Color := clBtnFace
  else
    EditBox.Color := clWindow;

  if FIsAddPoints then
  begin
    TextBox.Caption := TextBox.Caption +
        '..........................................................................................'+
        '..........................................................................................';
  end;

  TextBox.Left := 4;
  if FUseBigFont then
  begin
    TextBox.Top := NextIndex * 28 + 4;
    TextBox.Height := 20;
  end
  else
  begin
    TextBox.Top := NextIndex * 16 + 4;
    TextBox.Height := 16;
  end;
  //TextBox.Hint := Hint1;
  //TextBox.ShowHint := (Hint1 <> '');

  SetLength(FItems, NextIndex + 1);

  FItems[NextIndex].Edit := EditBox;
  FItems[NextIndex].EditLabel := TextBox;
  Result := NextIndex;
end;

function TPropertyBoxControl.AddNew(const Caption1: string): Integer;
begin
  Result := AddNew2(Caption1, '', '', 100);
end;

function TPropertyBoxControl.AddNew2(const Caption1, Text1, Hint1: string; EditWidth: Integer; ReadOnly: Boolean = False): Integer;
var
  Edit: TEdit;
  EditLabel: TLabel;
  NextIndex: Integer;
begin
  NextIndex := Length(FItems);

  Edit := TEdit.Create(FParent);
  Edit.Parent := FParent;
  Edit.Left := FParent.Width - EditWidth - 10;
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

  EditLabel := TLabel.Create(FParent);
  EditLabel.Parent := FParent;
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

  SetLength(FItems, NextIndex + 1);

  FItems[NextIndex].Edit := Edit;
  FItems[NextIndex].EditLabel := EditLabel;
  Result := NextIndex;
end;

constructor TPropertyBoxControl.Create(Parent: TWinControl);
begin
  FParent := Parent;
end;

procedure TPropertyBoxControl.DoEditEnter(Sender: TObject);
begin
  FTempValue := TEdit(Sender).Text;
end;

procedure TPropertyBoxControl.DoEditExit(Sender: TObject);
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

function TPropertyBoxControl.GetItemIndex(Edit: TEdit): Integer;
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

function TPropertyBoxControl.GetText(Index: Integer): string;
begin
  if (Index >= 0) and (Index < Length(FItems)) then
    Result := FItems[Index].Edit.Text
  else
    Result := '';
end;

function TPropertyBoxControl.GetUseBigFont(): Boolean;
begin
  Result := FUseBigFont;
end;

procedure TPropertyBoxControl.Resizing();
var
  I: Integer;
begin
  for I := 0 to High(FItems) do
    FItems[I].EditLabel.Width := FParent.Width - FItems[I].Edit.Width - 25;
end;

procedure TPropertyBoxControl.SetText(Index: Integer; const Value: string);
begin
  if (Index >= 0) and (Index < Length(FItems)) then
    FItems[Index].Edit.Text := Value;
end;

procedure TPropertyBoxControl.SetUseBigFont(Value: Boolean);
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
 
