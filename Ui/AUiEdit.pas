{**
@Abstract AUiEdit
@Author Prof1983 <prof1983@ya.ru>
@Created 14.01.2010
@LastMod 25.12.2012
}
unit AUiEdit;

interface

{$define AStdCall}

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
function AUiEdit_CheckInt(Edit: AControl; out Value: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Создает новый элемент TEdit }
function AUiEdit_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

{** Создает новый элемент TEdit
    @param EditType
      0 - TEdit
      1 - TEdit + Button
      3 - TSpinEdit }
function AUiEdit_New02(Parent: AControl; EditType: AInteger; OnClick: ACallbackProc02;
    Left, Top, Width: AInteger): AControl; {$ifdef AStdCall}stdcall;{$endif}

{** Создает новый элемент TEdit
    @param EditType
      0 - TEdit
      1 - TEdit + Button
      3 - TSpinEdit
}
function AUiEdit_NewEx(Parent: AControl; EditType: AInteger; OnClick: ACallbackProc;
    Left, Top, Width: AInteger): AControl; {$ifdef AStdCall}stdcall;{$endif}

// ----

// Создает новый элемент TEdit
function A_UI_Edit_New(Parent: AControl): AControl; stdcall; deprecated; // Use AUiEdit_New()

// ---

function Edit_CheckDate(Edit: TCustomEdit{TMaskEdit}; out Value: TDateTime): ABoolean;
function Edit_CheckFloat(Edit: TCustomEdit; out Value: Double): ABoolean;
function Edit_CheckFloat32(Edit: TCustomEdit; out Value: AFloat32): ABoolean;
function Edit_CheckFloat64(Edit: TCustomEdit; out Value: AFloat64): ABoolean;
function Edit_CheckInt(Edit: TCustomEdit; out Value: AInteger): ABoolean;

function UI_Edit_CheckDate(Edit: AControl; out Value: TDateTime): ABoolean; stdcall;
function UI_Edit_CheckFloat(Edit: AControl; out Value: Double): ABoolean; stdcall;
function UI_Edit_CheckFloat32(Edit: AControl; out Value: AFloat32): ABoolean;
function UI_Edit_CheckFloat64(Edit: AControl; out Value: AFloat64): ABoolean;
// Переводит текст в Int. Если ошибка, то переходит на этот компонент и возвращает false.
function UI_Edit_CheckInt(Edit: AControl; out Value: AInteger): ABoolean; stdcall;
// Создает новый элемент TEdit.
function UI_Edit_New(Parent: AControl): AControl; stdcall;

{ Создает новый элемент TEdit.
  EditType
    0 - TEdit
    1 - TEdit + Button }
function UI_Edit_New02(Parent: AControl; EditType: AInteger; OnClick: ACallbackProc02;
    Left, Top, Width: AInteger): AControl; stdcall;

{ Создает новый элемент TEdit.
  EditType
    0 - TEdit
    1 - TEdit + Button }
function UI_Edit_NewA(Parent: AControl; EditType: AInteger; OnClick: ACallbackProc;
    Left, Top, Width: AInteger): AControl; stdcall;

implementation

uses
  AUiSpinEdit;

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

function AUiEdit_CheckInt(Edit: AControl; out Value: AInteger): AError;
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

function AUiEdit_New02(Parent: AControl; EditType: AInteger; OnClick: ACallbackProc02;
    Left, Top, Width: AInteger): AControl;
begin
  try
    if (EditType = 3) then
    begin
      Result := AUiSpinEdit_New(Parent);
      if (Result = 0) then Exit;
      AUIControls.UI_Control_SetPosition(Result, Left, Top);
      AUIControls.UI_Control_SetWidth(Result, Width);
    end
    else
      Result := UI_Edit_New02(Parent, EditType, OnClick, Left, Top, Width);
  except
    Result := 0;
  end;
end;

function AUiEdit_NewEx(Parent: AControl; EditType: AInteger; OnClick: ACallbackProc;
    Left, Top, Width: AInteger): AControl;
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
      3:
        begin
          Result := AUiSpinEdit_New(Parent);
          if (Result = 0) then Exit;
          AUiControl_SetPosition(Result, Left, Top);
          AUiControl_SetWidth(Result, Width);
        end
    else
      Result := 0;
    end;
  except
    Result := 0;
  end;
end;

{ A_UI_Edit }

function A_UI_Edit_New(Parent: AControl): AControl; stdcall;
begin
  Result := AUiEdit_New(Parent);
end;

{ Edit }

function Edit_CheckDate(Edit: TCustomEdit; out Value: TDateTime): ABoolean;
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

function Edit_CheckFloat(Edit: TCustomEdit; out Value: Double): ABoolean;
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

function Edit_CheckFloat32(Edit: TCustomEdit; out Value: AFloat32): ABoolean;
var
  V: Double;
begin
  Result := Edit_CheckFloat(Edit, V);
  if Result then
    Value := V;
end;

function Edit_CheckFloat64(Edit: TCustomEdit; out Value: AFloat64): ABoolean;
begin
  Result := Edit_CheckFloat(Edit, Value);
end;

function Edit_CheckInt(Edit: TCustomEdit; out Value: AInteger): ABoolean;
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

{ UI_Edit }

function UI_Edit_CheckDate(Edit: AControl{TMaskEdit}; out Value: TDateTime): ABoolean; stdcall;
begin
  Result := (AUiEdit_CheckDate(Edit, Value) = 0);
end;

function UI_Edit_CheckFloat(Edit: AControl; out Value: Double): ABoolean; stdcall;
begin
  Result := (AUiEdit_CheckFloat(Edit, Value) = 0);
end;

function UI_Edit_CheckFloat32(Edit: AControl; out Value: AFloat32): ABoolean;
begin
  Result := (AUiEdit_CheckFloat32(Edit, Value) = 0);
end;

function UI_Edit_CheckFloat64(Edit: AControl; out Value: AFloat64): ABoolean;
begin
  Result := (AUiEdit_CheckFloat64(Edit, Value) = 0);
end;

function UI_Edit_CheckInt(Edit: AControl; out Value: AInteger): ABoolean; stdcall;
begin
  Result := (AUiEdit_CheckInt(Edit, Value) = 0);
end;

function UI_Edit_New(Parent: AControl): AControl; stdcall;
begin
  Result := AUiEdit_NewEx(Parent, 0, nil, 0, 0, 100);
end;

function UI_Edit_New02(Parent: AControl; EditType: AInteger; OnClick: ACallbackProc02;
    Left, Top, Width: AInteger): AControl; stdcall;
var
  Edit: TEdit;
  Button: AControl;
begin
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
        AUiControl_SetOnClick02(Button, OnClick);
      end;
  else
    Result := 0;
  end;
end;

function UI_Edit_NewA(Parent: AControl; EditType: AInteger; OnClick: ACallbackProc;
    Left, Top, Width: AInteger): AControl; stdcall;
begin
  Result := AUiEdit_NewEx(Parent, EditType, OnClick, Left, Top, Width);
end;

end.
 
