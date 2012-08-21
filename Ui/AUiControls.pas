{**
@Abstract AUi controls
@Author Prof1983 <prof1983@ya.ru>
@Created 10.08.2011
@LastMod 21.08.2012
}
unit AUiControls;

interface

uses
  Buttons, Classes, {$IFNDEF FPC}ComCtrls,{$ENDIF} Controls, ExtCtrls, Forms, Graphics, Menus, StdCtrls,
  ABase, AUiBase, AUiData;

// --- AUiControl ---

function AUiControl_Free(Control: AControl): AError;

{ @param FontName - (const) }
function AUiControl_SetFont1A(Control: AControl; FontName: AStr;
    FontSize: AInt): AError;

function AUiControl_SetFont1P(Control: AControl; const FontName: APascalString;
    FontSize: AInteger): AError;

procedure AUiControl_SetFont1P_Old(Control: AControl; const FontName: APascalString;
    FontSize: AInteger);

function AUiControl_SetFont2P(Control: AControl; const FontName: APascalString;
    FontSize: AInteger; FontColor: AColor): AError;

function AUiControl_SetTextP(Control: AControl; const Value: APascalString): AError;

// --- UI_Control ---

procedure UI_Control_Free(Control: AControl); stdcall; {deprecated;}

procedure UI_Control_FreeAndNil(var Control: AControl); stdcall; {deprecated;}

function UI_Control_GetColor(Control: AControl): AColor; stdcall; {deprecated;}

function UI_Control_GetEnabled(Control: AControl): ABoolean; stdcall; {deprecated;}

function UI_Control_GetHeight(Control: AControl): AInteger; stdcall; {deprecated;}

function UI_Control_GetHint(Control: AControl): APascalString; stdcall; {deprecated;}

function UI_Control_GetName(Control: AControl): APascalString; stdcall; {deprecated;}

function UI_Control_GetMenu(Control: AControl): AMenu;

function UI_Control_GetPosition(Control: AControl; out Left, Top: AInteger): AError;

function UI_Control_GetText(Control: AControl): APascalString; stdcall; {deprecated;}

function UI_Control_GetVisible(Control: AControl): ABoolean; stdcall; {deprecated;}

function UI_Control_GetWidth(Control: AControl): AInteger; stdcall; {deprecated;}

//** Задает присоединение элемента.
procedure UI_Control_SetAlign(Control: AControl; Align: TUIAlign);

procedure UI_Control_SetClientSize(Control: AControl; ClientWidth, ClientHeight: AInteger); stdcall; {deprecated;}

//** Задает цвет элемента.
procedure UI_Control_SetColor(Control: AControl; Color: AColor);
//procedure UI_Control_SetColor(Control: AControl; Color: AColor); stdcall; deprecated; // Use AUiControl_SetColor()

procedure UI_Control_SetEnabled(Control: AControl; Value: ABoolean); stdcall; {deprecated;}

function UI_Control_SetFocus(Control: AControl): ABoolean; stdcall; {deprecated;}

//** Задает шрифт.
procedure UI_Control_SetFont1(Control: AControl; const FontName: APascalString; FontSize: AInteger);
//procedure UI_Control_SetFont1(Control: AControl; const FontName: APascalString; FontSize: AInteger); stdcall; deprecated; // Use Control_SetFont1()

// Если FontColor = 1, то цвет не изменяется
procedure UI_Control_SetFont2(Control: AControl; const FontName: APascalString; FontSize: AInteger; FontColor: AColor); stdcall; {deprecated;}

procedure UI_Control_SetHeight(Control: AControl; Value: AInteger);
//function UI_Control_SetHeight(Control: AControl; Value: AInteger): AInteger; stdcall; deprecated; // Use AUiControl_SetHeight()

procedure UI_Control_SetHint(Control: AControl; const Value: APascalString);
//procedure UI_Control_SetHint(Control: AControl; const Value: APascalString); stdcall; deprecated; // Use AUiControl_SetHint()

procedure UI_Control_SetName(Control: AControl; const Value: APascalString);
//procedure UI_Control_SetName(Control: AControl; const Value: APascalString); stdcall; deprecated; // Use AUiControl_SetName()

procedure UI_Control_SetOnChange(Control: AControl; OnChange: ACallbackProc02); stdcall; deprecated; // Use AUiControl_SetOnChange02()

procedure UI_Control_SetOnChange2(Control: AControl; OnChange: ACallbackProc02; Obj: AInteger = 0); stdcall; deprecated; // Use AUiControl_SetOnChangeEx()

function UI_Control_SetOnClick(Control: AControl; Value: ACallbackProc): AError;

function UI_Control_SetOnClick02(Control: AControl; Value: ACallbackProc02): AError;
//procedure UI_Control_SetOnClick02(Control: AControl; Value: ACallbackProc02); stdcall; deprecated; // Use AUiControl_SetOnClick()

function UI_Control_SetOnClick03(Control: AControl; Value: ACallbackProc03): AError;

//** Задает расположение элемента.
function UI_Control_SetPosition(Control: AControl; Left, Top: AInteger): AError;
//procedure UI_Control_SetPosition(Control: AControl; Left, Top: AInteger); stdcall; deprecated; // Use AUiControl_SetPosition()

//** Задает внешний размер элемента.
function UI_Control_SetSize(Control: AControl; Width, Height: Integer): AError;
//procedure UI_Control_SetSize(Control: AControl; Width, Height: AInteger); stdcall; deprecated; // Use AUiControl_SetSize()

procedure UI_Control_SetText(Control: AControl; const Value: AWideString); stdcall; deprecated; // Use AUiControl_SetTextP()

//** Задает текст элемента.
function UI_Control_SetTextP(Control: AControl; const Value: APascalString): AError;

procedure UI_Control_SetVisible(Control: AControl; Value: ABoolean);
//procedure UI_Control_SetVisible(Control: AControl; Value: ABoolean); stdcall; deprecated; // Use AUiControl_SetVisible()

function UI_Control_SetWidth(Control: AControl; Value: AInteger): AInteger;
//function UI_Control_SetWidth(Control: AControl; Value: AInteger): AInteger; stdcall; deprecated; // Use AUiControl_SetWidth()

implementation

// --- AUiControl ---

function AUiControl_Free(Control: AControl): AError;
begin
  try
    if (Control <> 0) then
      TObject(Control).Free;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiControl_FreeAndNil(var Control: AControl): AError;
var
  Res: AError;
begin
  Res := AUiControl_Free(Control);
  Control := 0;
  Result := Res;
end;

function AUiControl_GetColor(Control: AControl): AColor;
begin
  try
    if (TObject(Control) is TLabel) then
      Result := TLabel(Control).Color
    else if (TObject(Control) is TPanel) then
      Result := TPanel(Control).Color
    else if (TObject(Control) is TForm) then
      Result := TForm(Control).Color
    else
      Result := $000000;
  except
    Result := $000000;
  end;
end;

function AUiControl_GetEnabled(Control: AControl): ABoolean;
begin
  try
    if (TObject(Control) is TControl) then
      Result := TControl(Control).Enabled
    else if (TObject(Control) is TMenuItem) then
      Result := TMenuItem(Control).Enabled
    else
      Result := False;
  except
    Result := False;
  end;
end;

function AUiControl_GetHeight(Control: AControl): AInt;
begin
  try
    Result := TControl(Control).Height;
  except
    Result := 0;
  end;
end;

function AUiControl_GetHintP(Control: AControl): APascalString;
begin
  try
    if (TObject(Control) is TControl) then
      Result := TControl(Control).Hint
    else if (TObject(Control) is TMenuItem) then
      Result := TMenuItem(Control).Hint
    else
      Result := '';
  except
    Result := '';
  end;
end;

function AUiControl_GetMenu(Control: AControl): AMenu;
var
  C: TControl;
begin
  try
    C := TControl(Control);
    if not(Assigned(C)) then
    begin
      Result := 0;
      Exit;
    end;
    if (C is TFrame) then
    begin
      Result := 0;
      Exit;
    end
    else if (C is TForm) then
    begin
      Result := AMenu(TForm(C).Menu);
      Exit;
    end;
    Result := 0;
  except
    Result := 0;
  end;
end;

function AUiControl_GetNameP(Control: AControl): APascalString;
begin
  try
    if (TObject(Control) is TComponent) then
      Result := TComponent(Control).Name
    else
      Result := '';
  except
    Result := '';
  end;
end;

function AUiControl_GetTextP(Control: AControl): APascalString; 
begin
  try
    if (TObject(Control) is TForm) then
      Result := TForm(Control).Caption
    else if (TObject(Control) is TMenuItem) then
      Result := TMenuItem(Control).Caption
    else if (TObject(Control) is TEdit) then
      Result := TEdit(Control).Text
    else
      Result := '';
  except
    Result := '';
  end;
end;

function AUiControl_GetVisible(Control: AControl): ABoolean;
begin
  try
    if (TObject(Control) is TControl) then
      Result := TControl(Control).Visible
    else if (TObject(Control) is TMenuItem) then
      Result := TMenuItem(Control).Visible
    else
      Result := False;
  except
    Result := False;
  end;
end;

function AUiControl_GetWidth(Control: AControl): AInt;
begin
  try
    Result := TControl(Control).Width;
  except
    Result := 0;
  end;
end;

function AUiControl_SetAlign(Control: AControl; Align: TUiAlign): AError;
begin
  try
    if (TObject(Control) is TControl) then
      TControl(Control).Align := TAlign(Align);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiControl_SetClientSize(Control: AControl; ClientWidth, ClientHeight: AInt): AError;
begin
  try
    TWinControl(Control).ClientWidth := ClientWidth;
    TWinControl(Control).ClientHeight := ClientHeight;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiControl_SetColor(Control: AControl; Color: AColor): AError;
begin
  try
    if (TObject(Control) is TComboBox) then
      TComboBox(Control).Color := Color
    else if (TObject(Control) is TLabel) then
    begin
      TLabel(Control).Color := Color;
      (*if (Color = clBlack) then
        TLabel(Control).Font.Color := clWhite //UI_Control_SetFont(ColorLineTipV, '', 0, $FFFFFF{clWhite})
      else
        TLabel(Control).Font.Color := clBlack; //UI_Control_SetFont(ColorLineTipV, '', 0, $000000{clBlack}); *)
    end
    else if (TObject(Control) is TPanel) then
      TPanel(Control).Color := Color
    else if (TObject(Control) is TForm) then
      TForm(Control).Color := Color;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiControl_SetEnabled(Control: AControl; Value: ABoolean): AError;
begin
  try
    if (TObject(Control) is TControl) then
      TControl(Control).Enabled := Value
    else if (TObject(Control) is TMenuItem) then
      TMenuItem(Control).Enabled := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiControl_SetFocus(Control: AControl): ABoolean;
begin
  try
    if not(TObject(Control) is TWinControl) then
    begin
      Result := False;
    end;
    TWinControl(Control).SetFocus();
    Result := True;
  except
    Result := False;
  end;
end;

function AUiControl_SetFont1A(Control: AControl; FontName: AStr; FontSize: AInt): AError;
begin
  try
    Result := AUi_Control_SetFont1P(Control, AnsiString(FontName), FontSize);
  except
    Result := -1;
  end;
end;

function AUiControl_SetFont1P(Control: AControl; const FontName: APascalString;
    FontSize: AInteger): AError;
begin
  try
    if (TObject(Control) is TLabel) then
    begin
      if (FontName <> '') then
        TLabel(Control).Font.Name := FontName;
      if (FontSize <> 0) then
        TLabel(Control).Font.Size := FontSize;
    end;
    Result := 0;
  except
    Result := -1;
  end;
end;

procedure AUiControl_SetFont1P_Old(Control: AControl; const FontName: APascalString;
    FontSize: AInteger);
begin
  AUiControl_SetFont1P(Control, FontName, FontSize);
end;

function AUiControl_SetFont2P(Control: AControl; const FontName: APascalString;
    FontSize: AInteger; FontColor: AColor): AError;
begin
  try
    if (TObject(Control) is TLabel) then
    begin
      if (FontName <> '') then
        TLabel(Control).Font.Name := FontName;
      if (FontSize <> 0) then
        TLabel(Control).Font.Size := FontSize;
      if (FontColor <> 1) then
        TLabel(Control).Font.Color := FontColor;
    end;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiControl_SetHeight(Control: AControl; Value: AInt): AInt;
begin
  try
    TControl(Control).Height := Value;
    Result := Value;
  except
    Result := -1;
  end;
end;

function AUiControl_SetHintP(Control: AControl; const Value: APascalString): AError;
begin
  try
    if (TObject(Control) is TControl) then
      TControl(Control).Hint := Value
    else if (TObject(Control) is TMenuItem) then
      TMenuItem(Control).Hint := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiControl_SetNameP(Control: AControl; const Value: APascalString): AError;
begin
  try
    if (TObject(Control) is TControl) then
      TControl(Control).Name := Value
    else if (TObject(Control) is TMenuItem) then
      TMenuItem(Control).Name := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiControl_SetTextP(Control: AControl; const Value: APascalString): AError;
begin
  try
    Result := UI_Control_SetTextP(Control, Value);
  except
    Result := -1;
  end;
end;

// --- UI_Control ---

procedure UI_Control_Free(Control: AControl); stdcall;
begin
  AUiControl_Free(Control);
end;

procedure UI_Control_FreeAndNil(var Control: AControl); stdcall;
begin
  AUiControl_FreeAndNil(Control);
end;

function UI_Control_GetColor(Control: AControl): AColor; stdcall;
begin
  Result := AUiControl_GetColor(Control);
end;

function UI_Control_GetEnabled(Control: AControl): ABoolean; stdcall;
begin
  Result := AUiControl_GetEnabled(Control);
end;

function UI_Control_GetHeight(Control: AControl): AInteger; stdcall;
begin
  Result := AUiControl_GetHeight(Control);
end;

function UI_Control_GetHint(Control: AControl): APascalString; stdcall;
begin
  Result := AUiControl_GetHintP(Control);
end;

function UI_Control_GetMenu(Control: AControl): AMenu;
begin
  Result := AUiControl_GetMenu(Control);
end;

function UI_Control_GetName(Control: AControl): APascalString; stdcall;
begin
  Result := AUiControl_GetNameP(Control);
end;

function UI_Control_GetPosition(Control: AControl; out Left, Top: AInteger): AError;
var
  //O: TObject;
  C: TControl;
begin
  xxx
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

function UI_Control_GetText(Control: AControl): APascalString; stdcall;
begin
  Result := AUiControl_GetTextP(Control);
end;

function UI_Control_GetVisible(Control: AControl): ABoolean; stdcall;
begin
  Result := AUiControl_GetVisible(Control);
end;

function UI_Control_GetWidth(Control: AControl): AInteger; stdcall;
begin
  Result := AUiControl_GetWidth(Control);
end;

procedure UI_Control_SetAlign(Control: AControl; Align: TUIAlign);
begin
  AUiControl_SetAlign(Control, Align);
end;

procedure UI_Control_SetClientSize(Control: AControl; ClientWidth, ClientHeight: AInteger); stdcall;
begin
  AUiControl_SetClientSize(Control, ClientWidth, ClientHeight);
end;

procedure UI_Control_SetColor(Control: AControl; Color: AColor);
begin
  AUiControl_SetColor(Control, Color);
end;

procedure UI_Control_SetEnabled(Control: AControl; Value: ABoolean); stdcall;
begin
  AUiControl_SetEnabled(Control, Value);
end;

function UI_Control_SetFocus(Control: AControl): ABoolean; stdcall;
begin
  Result := AUiControl_SetFocus(Control);
end;

procedure UI_Control_SetFont1(Control: AControl; const FontName: APascalString; FontSize: AInteger);
begin
  AUiControl_SetFont1P(Control, FontName, FontSize);
end;

procedure UI_Control_SetFont2(Control: AControl; const FontName: APascalString; FontSize: AInteger; FontColor: AColor); stdcall;
begin
  AUiControl_SetFont2P(Control, FontName, FontSize, FontColor);
end;

function UI_Control_SetHeight(Control: AControl; Value: AInteger): AInteger; stdcall;
begin
  Result := AUiControl_SetHeight(Control, Value);
end;

procedure UI_Control_SetHeight02(Control: AControl; Value: AInteger);
begin
  Result := AUiControl_SetHeight(Control, Value);
end;

procedure UI_Control_SetHint(Control: AControl; const Value: APascalString);
begin
  Result := AUiControl_SetHint(Control, Value);
end;

procedure UI_Control_SetName(Control: AControl; const Value: APascalString);
begin
  Result := AUiControl_SetNameP(Control, Value);
end;

(*
procedure UI_Control_SetOnChange(Control: AControl; OnChange: ACallbackProc02); stdcall;
begin
  AUIControlsA.UI_Control_SetOnChange02(Control, OnChange);
end;

procedure UI_Control_SetOnChange2(Control: AControl; OnChange: ACallbackProc02; Obj: AInteger); stdcall;
begin
  AUIControlsA.UI_Control_SetOnChangeEx02(Control, OnChange, Obj);
end;

function UI_Control_SetOnClick(Control: AControl; Value: ACallbackProc): AError;
begin
  {$IFDEF A01}
    Result := UI_Control_SetOnClick02(Control, Value);
  {$ELSE}
    {$IFDEF A02}
    Result := UI_Control_SetOnClick02(Control, Value);
    {$ELSE}
    Result := UI_Control_SetOnClick03(Control, Value);
    {$ENDIF A02}
  {$ENDIF}
end;
*)

{procedure UI_Control_SetOnClick02(Control: AControl; Value: ACallbackProc02); stdcall;
begin
  AUIControls.UI_Control_SetOnClick02(Control, Value);
end;}
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

procedure UI_Control_SetPosition02(Control: AControl; Left, Top: Integer); stdcall;
begin
  AUIControls.UI_Control_SetPosition(Control, Left, Top);
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

procedure UI_Control_SetSize02(Control: AControl; Width, Height: Integer); stdcall;
begin
  AUIControls.UI_Control_SetSize(Control, Width, Height);
end;

procedure UI_Control_SetText(Control: AControl; const Value: AWideString); stdcall;
begin
  AUIControls.UI_Control_SetTextP(Control, Value);
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
 