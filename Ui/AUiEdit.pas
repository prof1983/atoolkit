{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(14.01.2010)
@LastMod(26.10.2011)
@Version(0.5)
}
unit AUiEdit;

{$IFDEF FPC}
  {$DEFINE A02}
{$ENDIF}

{$IFDEF A02}{$DEFINE A02UP}{$ENDIF}
{$IFDEF A03}{$DEFINE A02UP}{$ENDIF}

interface

uses
  Controls, StdCtrls,
  ABase, {$IFDEF A0}AUtils0{$ELSE}AUtils{$ENDIF},
  AUiBase, AUiButton, AUiControls, AUiData;

{
function A_UI_Edit_CheckDate(Edit: AControl; out Value: TDateTime): ABoolean; stdcall;
function A_UI_Edit_CheckFloat(Edit: AControl; out Value: Double): ABoolean; stdcall;
// Переводит текст в Int. Если ошибка, то переходит на этот компонент и возвращает false.
function A_UI_Edit_CheckInt(Edit: AControl; out Value: AInteger): ABoolean; stdcall;
}
// Создает новый элемент TEdit
function A_UI_Edit_New(Parent: AControl): AControl; stdcall;
{ EditType
    0 - TEdit
    1 - TEdit + Button }
function A_UI_Edit_NewA(Parent: AControl; EditType: AInteger; OnClick: ACallbackProc; Left, Top, Width: AInteger): AControl; stdcall;

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
function UI_Edit_NewA(Parent: AControl; EditType: AInteger; OnClick: ACallbackProc; Left, Top, Width: AInteger): AControl; stdcall;

implementation

{uses
  AUI;}

{ A_UI_Edit }

(*
function A_UI_Edit_CheckDate(Edit: AControl{TMaskEdit}; out Value: TDateTime): ABoolean; stdcall;
begin
  Result := Edit_CheckDate(TCustomEdit(Edit), Value);
end;

function A_UI_Edit_CheckFloat(Edit: AControl; out Value: Double): ABoolean; stdcall;
begin
  Result := Edit_CheckFloat(TCustomEdit(Edit), Value);
end;

function A_UI_Edit_CheckInt(Edit: AControl; out Value: AInteger): ABoolean; stdcall;
begin
  Result := Edit_CheckInt(TCustomEdit(Edit), Value);
end;
*)

function A_UI_Edit_New(Parent: AControl): AControl; stdcall;
begin
  Result := UI_Edit_NewA(Parent, 0, nil, 0, 0, 100);
end;

function A_UI_Edit_NewA(Parent: AControl; EditType: AInteger; OnClick: ACallbackProc; Left, Top, Width: AInteger): AControl; stdcall;
var
  //ComboBox: TComboBox;
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

        Button := UI_Button_New(Parent);
        UI_Control_SetPosition(Button, Left + Width - 20, Top + 2);
        UI_Control_SetSize(Button, 18, 18);
        UI_Control_SetTextP(Button, '...');
        UI_Control_SetOnClick03(Button, OnClick);
      end;
  else
    Result := 0;
  end;
end;

{ Edit }

function Edit_CheckDate(Edit: TCustomEdit; out Value: TDateTime): ABoolean;
begin
  Value := 0;
  if (Edit.Text <> '') and (Edit.Text <> '  .  .  ') then
  begin
    Result := AUtils.TryStrToDateWS(Edit.Text, Value);
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
    if not(AUtils.TryStrToFloat64WS(Edit.Text, Value)) then
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
    if not(AUtils.TryStrToIntWS(Edit.Text, Value)) then
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
  Result := Edit_CheckDate(TCustomEdit(Edit), Value);
end;

function UI_Edit_CheckFloat(Edit: AControl; out Value: Double): ABoolean; stdcall;
begin
  Result := Edit_CheckFloat(TCustomEdit(Edit), Value);
end;

function UI_Edit_CheckFloat32(Edit: AControl; out Value: AFloat32): ABoolean;
begin
  Result := Edit_CheckFloat32(TCustomEdit(Edit), Value);
end;

function UI_Edit_CheckFloat64(Edit: AControl; out Value: AFloat64): ABoolean;
begin
  Result := Edit_CheckFloat64(TCustomEdit(Edit), Value);
end;

function UI_Edit_CheckInt(Edit: AControl; out Value: AInteger): ABoolean; stdcall;
begin
  Result := Edit_CheckInt(TCustomEdit(Edit), Value);
end;

function UI_Edit_New(Parent: AControl): AControl; stdcall;
begin
  Result := UI_Edit_NewA(Parent, 0, nil, 0, 0, 100);
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

        Button := UI_Button_New(Parent);
        UI_Control_SetPosition(Button, Left + Width - 20, Top + 2);
        UI_Control_SetSize(Button, 18, 18);
        UI_Control_SetTextP(Button, '...');
        UI_Control_SetOnClick02(Button, OnClick);
      end;
  else
    Result := 0;
  end;
end;

function UI_Edit_NewA(Parent: AControl; EditType: AInteger; OnClick: ACallbackProc; Left, Top, Width: AInteger): AControl; stdcall;
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

        Button := UI_Button_New(Parent);
        UI_Control_SetPosition(Button, Left + Width - 20, Top + 2);
        UI_Control_SetSize(Button, 18, 18);
        UI_Control_SetTextP(Button, '...');
        UI_Control_SetOnClick03(Button, OnClick);
      end;
  else
    Result := 0;
  end;
end;

end.
 
