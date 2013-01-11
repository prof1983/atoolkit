{**
@Abstract AUi controls
@Author Prof1983 <prof1983@ya.ru>
@Created 10.08.2011
@LastMod 11.01.2013
}
unit AUiControls;

{$ifdef A04}{$define AStdCall}{$endif}

interface

uses
  Buttons, Classes, {$IFNDEF FPC}ComCtrls,{$ENDIF} Controls, ExtCtrls, Forms, Graphics, Menus, StdCtrls,
  ABase, AStrings,
  AUiBase, AUiData;

// --- AUiControl ---

function AUiControl_Free(Control: AControl): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_FreeAndNil(var Control: AControl): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetColor(Control: AControl): AColor; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetEnabled(Control: AControl): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetHeight(Control: AControl): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetHint(Control: AControl; out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetHintA(Control: AControl; Value: AStr; MaxLen: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetHintP(Control: AControl): APascalString; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetMenu(Control: AControl): AMenu; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetName(Control: AControl; out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetNameA(Control: AControl; Value: AStr; MaxLen: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetNameP(Control: AControl): APascalString; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetPosition(Control: AControl; out Left, Top: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetText(Control: AControl; out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetTextP(Control: AControl): APascalString; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetVisible(Control: AControl): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetWidth(Control: AControl): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetAlign(Control: AControl; Align: TUiAlign): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetAnchors(Control: AControl; Anchors: TUiAnchors): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetClientSize(Control: AControl; ClientWidth, ClientHeight: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetColor(Control: AControl; Color: AColor): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetEnabled(Control: AControl; Value: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetFocus(Control: AControl): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

{ @param FontName - (const) }
function AUiControl_SetFont1A(Control: AControl; FontName: AStr;
    FontSize: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetFont1P(Control: AControl; const FontName: APascalString;
    FontSize: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

procedure AUiControl_SetFont1P_Old(Control: AControl; const FontName: APascalString;
    FontSize: AInteger); {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetFont2P(Control: AControl; const FontName: APascalString;
    FontSize: AInteger; FontColor: AColor): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetFontSize(Control: AControl; Size: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetFontStyle(Control: AControl; FontStyle: AUiFontStyle): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetHeight(Control: AControl; Value: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetHint(Control: AControl; const Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetHintA(Control: AControl; Value: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetHintP(Control: AControl; const Value: APascalString): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetName(Control: AControl; const Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetNameA(Control: AControl; Value: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetNameP(Control: AControl; const Value: APascalString): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetOnClick(Control: AControl; Value: ACallbackProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetOnClick02(Control: AControl; Value: ACallbackProc02): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetOnClick03(Control: AControl; Value: ACallbackProc03): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetPosition(Control: AControl; Left, Top: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetSize(Control: AControl; Width, Height: Integer): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetTabStop(Control: AControl; Value: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetText(Control: AControl; const Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetTextA(Control: AControl; Value: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetTextP(Control: AControl; const Value: APascalString): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetVisible(Control: AControl; Value: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetWidth(Control: AControl; Value: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

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

function UI_Control_SetHeight(Control: AControl; Value: AInteger): AInteger; stdcall; deprecated; // Use AUiControl_SetHeight()

procedure UI_Control_SetHeight02(Control: AControl; Value: AInteger);

procedure UI_Control_SetHint(Control: AControl; const Value: APascalString);
//procedure UI_Control_SetHint(Control: AControl; const Value: APascalString); stdcall; deprecated; // Use AUiControl_SetHint()

procedure UI_Control_SetName(Control: AControl; const Value: APascalString);
//procedure UI_Control_SetName(Control: AControl; const Value: APascalString); stdcall; deprecated; // Use AUiControl_SetName()

//procedure UI_Control_SetOnChange(Control: AControl; OnChange: ACallbackProc02); stdcall; deprecated; // Use AUiControl_SetOnChange02()

//procedure UI_Control_SetOnChange2(Control: AControl; OnChange: ACallbackProc02; Obj: AInteger = 0); stdcall; deprecated; // Use AUiControl_SetOnChangeEx()

function UI_Control_SetOnClick(Control: AControl; Value: ACallbackProc): AError;

function UI_Control_SetOnClick02(Control: AControl; Value: ACallbackProc02): AError;
//procedure UI_Control_SetOnClick02(Control: AControl; Value: ACallbackProc02); stdcall; deprecated; // Use AUiControl_SetOnClick()

function UI_Control_SetOnClick03(Control: AControl; Value: ACallbackProc03): AError;

//** Задает расположение элемента.
function UI_Control_SetPosition(Control: AControl; Left, Top: AInteger): AError; deprecated; // Use AUiControl_SetPosition()

//** Задает внешний размер элемента.
function UI_Control_SetSize(Control: AControl; Width, Height: Integer): AError; deprecated; // Use AUiControl_SetSize()

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

function AUiControl_GetHint(Control: AControl; out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, AUiControl_GetHintP(Control));
end;

function AUiControl_GetHintA(Control: AControl; Value: AStr; MaxLen: AInt): AError;
var
  S: AnsiString;
begin
  try
    S := AUiControl_GetHintP(Control);
    if (Length(S) < MaxLen) then
    begin
      Move(S, Value, Length(S));
      Result := 0;
    end
    else
      Result := -2;
  except
    Result := -1;
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

function AUiControl_GetName(Control: AControl; out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, AUiControl_GetNameP(Control));
end;

function AUiControl_GetNameA(Control: AControl; Value: AStr; MaxLen: AInt): AError;
var
  S: AnsiString;
begin
  try
    S := AUiControl_GetNameP(Control);
    if (Length(S) < MaxLen) then
    begin
      Move(S, Value, Length(S));
      Result := 0;
    end
    else
      Result := -2;
  except
    Result := -1;
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

function AUiControl_GetPosition(Control: AControl; out Left, Top: AInteger): AError;
var
  //O: TObject;
  C: TControl;
begin
  try
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
  except
    Result := -1;
  end;
end;

function AUiControl_GetText(Control: AControl; out Value: AString_Type): AError;
begin
  Result := AString_AssignP(Value, AUiControl_GetTextP(Control));
end;

function AUiControl_GetTextP(Control: AControl): APascalString;
begin
  try
    if (TObject(Control) is TButton) then
      Result := TButton(Control).Caption
    else if (TObject(Control) is TComboBox) then
      Result := TComboBox(Control).Text
    else if (TObject(Control) is TForm) then
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

function AUiControl_SetAnchors(Control: AControl; Anchors: TUiAnchors): AError;
var
  A: TAnchors;
begin
  try
    if (uiakLeft and Anchors = uiakLeft) then
      A := A + [akLeft];
    if (uiakTop and Anchors = uiakTop) then
      A := A + [akTop];
    if (uiakRight and Anchors = uiakRight) then
      A := A + [akRight];
    if (uiakBottom and Anchors = uiakBottom) then
      A := A + [akBottom];

    if (TObject(Control) is TControl) then
      TControl(Control).Anchors := A;
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
    else if (TObject(Control) is TMemo) then
      TMemo(Control).Color := Color
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
      Exit;
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
    Result := AUiControl_SetFont1P(Control, AnsiString(FontName), FontSize);
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

function AUiControl_SetFontSize(Control: AControl; Size: AInt): AError;
begin
  try
    if (TObject(Control) is TLabel) then
      TLabel(Control).Font.Size := Size;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiControl_SetFontStyle(Control: AControl; FontStyle: AUiFontStyle): AError;
var
  S: TFontStyles;
begin
  try
    S := [];
    if (FontStyle and uifsBold <> 0) then
      S := S + [fsBold];
    if (FontStyle and uifsItalic <> 0) then
      S := S + [fsItalic];
    if (FontStyle and uifsUnderline <> 0) then
      S := S + [fsUnderline];
    if (FontStyle and uifsStrikeOut <> 0) then
      S := S + [fsStrikeOut];

    if (TObject(Control) is TLabel) then
      TLabel(Control).Font.Style := S;
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

function AUiControl_SetHint(Control: AControl; const Value: AString_Type): AError;
begin
  Result := AUiControl_SetHintP(Control, AString_ToPascalString(Value));
end;

function AUiControl_SetHintA(Control: AControl; Value: AStr): AError;
begin
  Result := AUiControl_SetHintP(Control, AnsiString(Value));
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

function AUiControl_SetName(Control: AControl; const Value: AString_Type): AError;
begin
  Result := AUiControl_SetNameP(Control, AString_ToPascalString(Value));
end;

function AUiControl_SetNameA(Control: AControl; Value: AStr): AError;
begin
  Result := AUiControl_SetNameP(Control, AnsiString(Value));
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

function AUiControl_SetOnClick(Control: AControl; Value: ACallbackProc): AError;
begin
  {$IFDEF A01}
    Result := AUiControl_SetOnClick02(Control, Value);
  {$ELSE}
    {$IFDEF A02}
    Result := AUiControl_SetOnClick02(Control, Value);
    {$ELSE}
    Result := AUiControl_SetOnClick03(Control, Value);
    {$ENDIF A02}
  {$ENDIF}
end;

function AUiControl_SetOnClick02(Control: AControl; Value: ACallbackProc02): AError;
var
  I: Integer;
begin
  try
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
  except
    Result := -1;
  end;
end;

function AUiControl_SetOnClick03(Control: AControl; Value: ACallbackProc03): AError;
var
  I: Integer;
begin
  try
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
  except
    Result := -1;
  end;
end;

function AUiControl_SetPosition(Control: AControl; Left, Top: AInteger): AError;
var
  O: TObject;
  C: TControl;
begin
  try
    O := GetObject(Control);
    if Assigned(O) and (O is TControl) then
    begin
      C := TControl(O);
      C.Left := Left;
      C.Top := Top;
    end;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiControl_SetSize(Control: AControl; Width, Height: Integer): AError;
var
  O: TObject;
  C: TControl;
begin
  try
    O := GetObject(Control);
    if Assigned(O) and (O is TControl) then
    begin
      C := TControl(O);
      C.Width := Width;
      C.Height := Height;
    end;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiControl_SetTabStop(Control: AControl; Value: ABoolean): AError;
var
  Obj: TObject;
begin
  try
    Obj := GetObject(Control);
    if not(Assigned(Obj)) then
    begin
      Result := -2;
      Exit;
    end;
    if (Obj is TWinControl) then
      TWinControl(Obj).TabStop := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiControl_SetText(Control: AControl; const Value: AString_Type): AError;
begin
  Result := AUiControl_SetTextP(Control, AString_ToPascalString(Value));
end;

function AUiControl_SetTextA(Control: AControl; Value: AStr): AError;
begin
  Result := AUiControl_SetTextP(Control, AnsiString(Value));
end;

function AUiControl_SetTextP(Control: AControl; const Value: APascalString): AError;
var
  Obj: TObject;
begin
  try
    Obj := GetObject(Control);
    if not(Assigned(Obj)) then
    begin
      Result := -1;
      Exit;
    end;
    if (Obj is TControl) then
    begin
      if (Obj is TBitBtn) then
        TBitBtn(Obj).Caption := Value
      else if (Obj is TButton) then
        TButton(Obj).Caption := Value
      else if (Obj is TCheckBox) then
        TCheckBox(Obj).Caption := Value
      else if (Obj is TComboBox) then
        TComboBox(Obj).Text := Value
      else if (Obj is TRadioGroup) then
        TRadioGroup(Obj).Caption := Value
      else if (Obj is TEdit) then
        TEdit(Obj).Text := Value
      else if (Obj is TForm) then
        TForm(Obj).Caption := Value
      else if (Obj is TLabel) then
        TLabel(Obj).Caption := Value
      else if (Obj is TMemo) then
        TMemo(Obj).Text := Value
      {$IFNDEF FPC}
      else if (Obj is TRichEdit) then
        TRichEdit(Obj).Text := Value
      {$ENDIF}
      else if (Obj is TTabSheet) then
        TTabSheet(Obj).Caption := Value;
    end
    else if (Obj is TMenuItem) then
      TMenuItem(Obj).Caption := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiControl_SetVisible(Control: AControl; Value: ABoolean): AError;
var
  O: TObject;
begin
  try
    O := AUiData.GetObject(Control);
    if Assigned(O) and (O is TControl) then
    begin
      TControl(O).Visible := Value;
      if (O is TForm) then
        TControl(O).BringToFront;
      Result := 0;
      Exit;
    end;
    if (TObject(Control) is TMenuItem) then
    begin
      TMenuItem(Control).Visible := Value;
      Result := 0;
      Exit;
    end;
    Result := -2;
  except
    Result := -1;
  end;
end;

function AUiControl_SetWidth(Control: AControl; Value: AInt): AInt;
begin
  try
    TControl(Control).Width := Value;
    Result := Value;
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
begin
  Result := AUiControl_GetPosition(Control, Left, Top);
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
  AUiControl_SetHeight(Control, Value);
end;

procedure UI_Control_SetHint(Control: AControl; const Value: APascalString);
begin
  AUiControl_SetHintP(Control, Value);
end;

procedure UI_Control_SetName(Control: AControl; const Value: APascalString);
begin
  AUiControl_SetNameP(Control, Value);
end;

function UI_Control_SetOnClick(Control: AControl; Value: ACallbackProc): AError;
begin
  Result := AUiControl_SetOnClick(Control, Value);
end;

{procedure UI_Control_SetOnClick02(Control: AControl; Value: ACallbackProc02); stdcall;
begin
  AUIControls.UI_Control_SetOnClick02(Control, Value);
end;}
function UI_Control_SetOnClick02(Control: AControl; Value: ACallbackProc02): AError;
begin
  Result := AUiControl_SetOnClick02(Control, Value);
end;

function UI_Control_SetOnClick03(Control: AControl; Value: ACallbackProc03): AError;
begin
  Result := AUiControl_SetOnClick03(Control, Value);
end;

function UI_Control_SetPosition(Control: AControl; Left, Top: AInteger): AError;
begin
  Result := AUiControl_SetPosition(Control, Left, Top);
end;

procedure UI_Control_SetPosition02(Control: AControl; Left, Top: Integer); stdcall;
begin
  AUiControl_SetPosition(Control, Left, Top);
end;

function UI_Control_SetSize(Control: AControl; Width, Height: Integer): AError;
begin
  Result := AUiControl_SetSize(Control, Width, Height);
end;

procedure UI_Control_SetSize02(Control: AControl; Width, Height: Integer); stdcall;
begin
  AUiControl_SetSize(Control, Width, Height);
end;

procedure UI_Control_SetText(Control: AControl; const Value: AWideString); stdcall;
begin
  AUiControl_SetTextP(Control, Value);
end;

function UI_Control_SetTextP(Control: AControl; const Value: APascalString): AError;
begin
  Result := AUiControl_SetTextP(Control, Value);
end;

procedure UI_Control_SetVisible(Control: AControl; Value: ABoolean);
begin
  AUiControl_SetVisible(Control, Value);
end;

function UI_Control_SetWidth(Control: AControl; Value: AInteger): AInteger;
begin
  Result := AUiControl_SetWidth(Control, Value);
end;

end.
 