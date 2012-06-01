{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(10.08.2011)
@LastMod(25.10.2011)
@Version(0.5)
}
unit AUiControls;

interface

uses
  Buttons, {$IFNDEF FPC}ComCtrls,{$ENDIF} Controls, Forms, Menus, StdCtrls,
  ABase, AUiBase, AUiData;

function UI_Control_GetPosition(Control: AControl; out Left, Top: AInteger): AError;
function UI_Control_SetAlign(Control: AControl; Align: TUIAlign): AError;
procedure UI_Control_SetHint(Control: AControl; const Value: APascalString);
procedure UI_Control_SetName(Control: AControl; const Value: APascalString);
function UI_Control_SetOnClick02(Control: AControl; Value: ACallbackProc02): AError;
function UI_Control_SetOnClick03(Control: AControl; Value: ACallbackProc03): AError;
function UI_Control_SetPosition(Control: AControl; Left, Top: AInteger): AError;
function UI_Control_SetSize(Control: AControl; Width, Height: Integer): AError;
function UI_Control_SetTextP(Control: AControl; const Value: APascalString): AError;
procedure UI_Control_SetVisible(Control: AControl; Value: ABoolean);
function UI_Control_SetWidth(Control: AControl; Value: AInteger): AInteger;

implementation

function UI_Control_GetPosition(Control: AControl; out Left, Top: AInteger): AError;
var
  //O: TObject;
  C: TControl;
begin
  C := TControl(Control);
  Left := C.Left;
  Top := C.Top;
  {O := GetObject(Control);
  if Assigned(O) and (O is TControl) then
  begin
    C := TControl(O);
    Left := C.Left;
    Top := C.Top;
  end;}
  Result := 0;
end;

function UI_Control_SetAlign(Control: AControl; Align: TUIAlign): AError;
begin
  if (TObject(Control) is TControl) then
    TControl(Control).Align := TAlign(Align);
  Result := 0;
end;

procedure UI_Control_SetHint(Control: AControl; const Value: APascalString);
begin
  if (TObject(Control) is TControl) then
    TControl(Control).Hint := Value
  else if (TObject(Control) is TMenuItem) then
    TMenuItem(Control).Hint := Value;
end;

procedure UI_Control_SetName(Control: AControl; const Value: APascalString);
begin
  if (TObject(Control) is TControl) then
    TControl(Control).Name := Value
  else if (TObject(Control) is TMenuItem) then
    TMenuItem(Control).Name := Value;
end;

function UI_Control_SetOnClick02(Control: AControl; Value: ACallbackProc02): AError;
var
  I: Integer;
begin
  if (TObject(Control) is TBitBtn) then
  begin
    I := FindButton(Control);
    if (I >= 0) then
      FButtons[I].OnClick02 := Value;
  end
  else if (TObject(Control) is TMenuItem) then
  begin
    I := FindMenuItem(Control);
    if (I >= 0) then
      FMenuItems[I].OnClick02 := Value;
  end
  else if (TObject(Control) is TListBox) then
  begin
    I := FindListBox(Control);
    if (I >= 0) then
      FListBoxs[I].OnClick02 := Value;
  end;
  Result := 0;
end;

function UI_Control_SetOnClick03(Control: AControl; Value: ACallbackProc03): AError;
var
  I: Integer;
begin
  if (TObject(Control) is TBitBtn) then
  begin
    I := FindButton(Control);
    if (I >= 0) then
      FButtons[I].OnClick03 := Value;
  end
  else if (TObject(Control) is TMenuItem) then
  begin
    I := FindMenuItem(Control);
    if (I >= 0) then
      FMenuItems[I].OnClick03 := Value;
  end
  else if (TObject(Control) is TListBox) then
  begin
    I := FindListBox(Control);
    if (I >= 0) then
      FListBoxs[I].OnClick03 := Value;
  end;
  Result := 0;
end;

function UI_Control_SetPosition(Control: AControl; Left, Top: AInteger): AError;
var
  O: TObject;
  C: TControl;
begin
  O := GetObject(Control);
  if Assigned(O) and (O is TControl) then
  begin
    C := TControl(O);
    C.Left := Left;
    C.Top := Top;
  end;
  Result := 0;
end;

function UI_Control_SetSize(Control: AControl; Width, Height: Integer): AError;
var
  O: TObject;
  C: TControl;
begin
  O := GetObject(Control);
  if Assigned(O) and (O is TControl) then
  begin
    C := TControl(O);
    C.Width := Width;
    C.Height := Height;
  end;
  Result := 0;
end;

function UI_Control_SetTextP(Control: AControl; const Value: APascalString): AError;
var
  obj: TObject;
begin
  obj := GetObject(Control);
  if not(Assigned(obj)) then
  begin
    Result := -1;
    Exit;
  end;
  if (obj is TControl) then
  begin
    if (obj is TForm) then
      TForm(obj).Caption := Value
    else if (obj is TLabel) then
      TLabel(obj).Caption := Value
    else if (obj is TEdit) then
      TEdit(obj).Text := Value
    else if (obj is TButton) then
      TButton(obj).Caption := Value
    else if (obj is TBitBtn) then
      TBitBtn(obj).Caption := Value
    else if (obj is TMemo) then
      TMemo(obj).Text := Value
    {$IFNDEF FPC}
    else if (obj is TRichEdit) then
      TRichEdit(obj).Text := Value;
    {$ENDIF}
  end
  else if (obj is TMenuItem) then
    TMenuItem(obj).Caption := Value;
  Result := 0;
end;

procedure UI_Control_SetVisible(Control: AControl; Value: ABoolean);
var
  O: TObject;
begin
  O := AUIData.GetObject(Control);
  if Assigned(O) and (O is TControl) then
  begin
    TControl(O).Visible := Value;
    if (O is TForm) then
      TControl(O).BringToFront;
    Exit;
  end;
  if (TObject(Control) is TMenuItem) then
    TMenuItem(Control).Visible := Value;
end;

function UI_Control_SetWidth(Control: AControl; Value: AInteger): AInteger;
begin
  TControl(Control).Width := Value;
  Result := Value;
end;

end.
 