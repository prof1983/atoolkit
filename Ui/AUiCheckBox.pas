{**
@Author Prof1983 <prof1983@ya.ru>
@Created 09.01.2013
@LastMod 09.01.2013
}
unit AUiCheckBox;

{$define AStdCall}

interface

uses
  Classes,
  Controls,
  StdCtrls,
  ABase,
  AUiBase,
  AUiControls,
  AUiData;

function AUiCheckBox_Free(CheckBox: AControl): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiCheckBox_GetChecked(CheckBox: AControl): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUiCheckBox_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiCheckBox_NewEx(Parent: AControl; OnChange: ACallbackProc; Left, Top,
    Width: AInt): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiCheckBox_SetChecked(CheckBox: AControl; Value: ABool): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

type
  TAUiCheckBox = object
  public
    CheckBox: AControl;
    OnChange: ACallbackProc;
  public
    procedure DoClick(Sender: TObject);
    procedure DoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  end;

var
  FCheckBox: array of TAUiCheckBox;

// --- Private ---

procedure DeleteCheckBox(Index: Integer);
var
  I: Integer;
begin
  for I := Index to High(FCheckBox) - 1 do
  begin
    FCheckBox[I] := FCheckBox[I+1];
  end;
  SetLength(FCheckBox, High(FCheckBox));
end;

function FindCheckBox(CheckBox: AControl): Integer;
var
  I: Integer;
begin
  for I := 0 to High(FCheckBox) do
  begin
    if (FCheckBox[I].CheckBox = CheckBox) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function _New(Parent: AControl; OnChange: ACallbackProc): AInt;
var
  CheckBox: TCheckBox;
  I: Integer;
  Res: AControl;
begin
  try
    CheckBox := TCheckBox.Create(nil);
    CheckBox.Parent := TWinControl(Parent);
    Res := AUiData.AddObject(CheckBox);
    I := Length(FCheckBox);
    SetLength(FCheckBox, I + 1);
    FCheckBox[I].CheckBox := Res;
    FCheckBox[I].OnChange := OnChange;
    Result := I;
  except
    Result := -1;
  end;
end;

// --- AUiCheckBox ---

function AUiCheckBox_Free(CheckBox: AControl): AError;
var
  I: Integer;
begin
  try
    I := FindCheckBox(CheckBox);
    if (I > 0) then
      DeleteCheckBox(I);
  except
  end;
  Result := AUiControl_Free(CheckBox);
end;

function AUiCheckBox_GetChecked(CheckBox: AControl): ABool;
begin
  if not(TObject(CheckBox) is TCheckBox) then
  begin
    Result := False;
    Exit;
  end;
  try
    Result := TCheckBox(CheckBox).Checked;
  except
    Result := False;
  end;
end;

function AUiCheckBox_New(Parent: AControl): AControl;
var
  I: Integer;
begin
  if not(TObject(Parent) is TWinControl) then
  begin
    Result := 0;
    Exit;
  end;
  I := _New(Parent, nil);
  if (I < 0) then
  begin
    Result := 0;
    Exit;
  end;
  Result := FCheckBox[I].CheckBox;
end;

function AUiCheckBox_NewEx(Parent: AControl; OnChange: ACallbackProc; Left, Top,
    Width: AInt): AControl;
var
  I: Integer;
  Res: AControl;
begin
  if not(TObject(Parent) is TWinControl) then
  begin
    Result := 0;
    Exit;
  end;
  I := _New(Parent, OnChange);
  if (I < 0) then
  begin
    Result := 0;
    Exit;
  end;
  Res := FCheckBox[I].CheckBox;
  TCheckBox(Res).OnClick := FCheckBox[I].DoClick;
  TCheckBox(Res).OnKeyUp := FCheckBox[I].DoKeyUp;
  if (Res = 0) then
  begin
    Result := 0;
    Exit;
  end;
  AUiControl_SetPosition(Res, Left, Top);
  AUiControl_SetWidth(Res, Width);
  Result := Res;
end;

function AUiCheckBox_SetChecked(CheckBox: AControl; Value: ABool): AError;
begin
  try
    TCheckBox(CheckBox).Checked := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

{ TAUiCheckBox }

procedure TAUiCheckBox.DoClick(Sender: TObject);
begin
  if (Assigned(Self.OnChange)) then
    Self.OnChange(Self.CheckBox, 0);
end;

procedure TAUiCheckBox.DoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 32) and (Assigned(Self.OnChange)) then
    Self.OnChange(Self.CheckBox, 0);
end;

end.
 