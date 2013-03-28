{**
@Abstract AUiEdit
@Author Prof1983 <prof1983@ya.ru>
@Created 14.01.2010
@LastMod 28.03.2013
}
unit AUiEdit;

interface

{define AStdCall}
{define NoSpin}

{$ifndef NoSpin}
  {$define UseSpin}
{$endif}

uses
  Controls, StdCtrls,
  ABase,
  AUtilsMain,
  AUiBase, AUiButtons, AUiControls, AUiData;

// --- AUiEdit ---

function AUiEdit_CheckDate(Edit: AControl; out Value: TDateTime): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiEdit_CheckFloat(Edit: AControl; out Value: AFloat): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiEdit_CheckFloat32(Edit: AControl; out Value: AFloat32): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiEdit_CheckFloat64(Edit: AControl; out Value: AFloat64): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Переводит текст в Int. Если ошибка, то переходит на этот компонент и возвращает False. }
function AUiEdit_CheckInt(Edit: AControl; out Value: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Создает новый элемент TEdit }
function AUiEdit_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

{** Создает новый элемент TEdit
    @param EditType
      0 - TEdit
      1 - TEdit + Button
      3 - TSpinEdit
}
function AUiEdit_NewEx(Parent: AControl; EditType: AInt; OnClick: ACallbackProc;
    Left, Top, Width: AInt): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiEdit_SetPasswordChar(Edit: AControl; Value: AChar): AError; {$ifdef AStdCall}stdcall;{$endif}

// ---

function Edit_CheckDate(Edit: TCustomEdit{TMaskEdit}; out Value: TDateTime): ABool;
function Edit_CheckFloat(Edit: TCustomEdit; out Value: Double): ABool;
function Edit_CheckFloat32(Edit: TCustomEdit; out Value: AFloat32): ABool;
function Edit_CheckFloat64(Edit: TCustomEdit; out Value: AFloat64): ABool;
function Edit_CheckInt(Edit: TCustomEdit; out Value: AInt): ABool;

implementation

{$ifdef UseSpin}
uses
  AUiSpinEdit;
{$endif}

// --- AUiEdit ---

function AUiEdit_CheckDate(Edit: AControl{TMaskEdit}; out Value: TDateTime): AError;
begin
  try
    if Edit_CheckDate(TCustomEdit(Edit), Value) then
      Result := 0
    else
      Result := 1;
  except
    Result := -1;
  end;
end;

function AUiEdit_CheckFloat(Edit: AControl; out Value: AFloat): AError;
begin
  try
    if Edit_CheckFloat(TCustomEdit(Edit), Value) then
      Result := 0
    else
      Result := 1;
  except
    Result := -1;
  end;
end;

function AUiEdit_CheckFloat32(Edit: AControl; out Value: AFloat32): AError;
begin
  try
    if Edit_CheckFloat32(TCustomEdit(Edit), Value) then
      Result := 0
    else
      Result := 1;
  except
    Result := -1;
  end;
end;

function AUiEdit_CheckFloat64(Edit: AControl; out Value: AFloat64): AError;
begin
  try
    if Edit_CheckFloat64(TCustomEdit(Edit), Value) then
      Result := 0
    else
      Result := 1;
  except
    Result := -1;
  end;
end;

function AUiEdit_CheckInt(Edit: AControl; out Value: AInt): AError;
begin
  try
    if Edit_CheckInt(TCustomEdit(Edit), Value) then
      Result := 0
    else
      Result := 1;
  except
    Result := -1;
  end;
end;

function AUiEdit_New(Parent: AControl): AControl;
begin
  try
    Result := AUiEdit_NewEx(Parent, 0, nil, 0, 0, 100);
  except
    Result := 0;
  end;
end;

function AUiEdit_NewEx(Parent: AControl; EditType: AInt; OnClick: ACallbackProc;
    Left, Top, Width: AInt): AControl;
var
  Edit: TEdit;
  Button: AControl;
begin
  try
    case EditType of
      0: // TEdit
        begin
          Edit := TEdit.Create(TWinControl(Parent));
          Edit.Parent := TWinControl(Parent);
          Edit.Left := Left;
          Edit.Top := Top;
          Edit.Width := Width;
          Result := AddObject(Edit);
        end;
      1: // TEdit + Button
        begin
          Edit := TEdit.Create(TWinControl(Parent));
          Edit.Parent := TWinControl(Parent);
          Edit.Left := Left;
          Edit.Top := Top;
          Edit.Width := Width;
          Result := AddObject(Edit);

          Button := AUiButton_New(Parent);
          AUiControl_SetPosition(Button, Left + Width - 20, Top + 2);
          AUiControl_SetSize(Button, 18, 18);
          AUiControl_SetTextP(Button, '...');
          AUiControl_SetOnClick(Button, OnClick);
        end;
      {$ifdef UseSpin}
      3:
        begin
          Result := AUiSpinEdit_New(Parent);
          if (Result = 0) then Exit;
          AUiControl_SetPosition(Result, Left, Top);
          AUiControl_SetWidth(Result, Width);
        end
      {$endif}
    else
      Result := 0;
    end;
  except
    Result := 0;
  end;
end;

function AUiEdit_SetPasswordChar(Edit: AControl; Value: AChar): AError;
begin
  try
    TEdit(Edit).PasswordChar := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

{ Edit }

function Edit_CheckDate(Edit: TCustomEdit; out Value: TDateTime): ABool;
begin
  Value := 0;
  if (Edit.Text <> '') and (Edit.Text <> '  .  .  ') then
  begin
    Result := AUtils_TryStrToDateP(Edit.Text, Value);
    if not(Result) then
    begin
      Edit.SelectAll;
      Edit.SetFocus;
    end;
  end;
  Result := True;
end;

function Edit_CheckFloat(Edit: TCustomEdit; out Value: Double): ABool;
begin
  if (Edit.Text <> '') then
  begin
    if not(AUtils_TryStrToFloat64P(Edit.Text, Value)) then
    begin
      Edit.SetFocus;
      Edit.SelectAll;
      Result := False;
      Exit;
    end;
  end
  else
    Value := 0;
  Result := True;
end;

function Edit_CheckFloat32(Edit: TCustomEdit; out Value: AFloat32): ABool;
var
  V: Double;
begin
  Result := Edit_CheckFloat(Edit, V);
  if Result then
    Value := V;
end;

function Edit_CheckFloat64(Edit: TCustomEdit; out Value: AFloat64): ABool;
begin
  Result := Edit_CheckFloat(Edit, Value);
end;

function Edit_CheckInt(Edit: TCustomEdit; out Value: AInt): ABool;
begin
  if (Edit.Text <> '') then
  begin
    if not(AUtils_TryStrToIntP(Edit.Text, Value)) then
    begin
      Edit.SetFocus;
      Edit.SelectAll;
      Result := False;
      Exit;
    end;
  end
  else
    Value := 0;
  Result := True;
end;

end.
 
