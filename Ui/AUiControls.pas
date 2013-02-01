{**
@Abstract AUi controls
@Author Prof1983 <prof1983@ya.ru>
@Created 10.08.2011
@LastMod 29.01.2013
}
unit AUiControls;

{define AStdCall}

interface

uses
  Buttons, Classes, {$IFNDEF FPC}ComCtrls,{$ENDIF} Controls, ExtCtrls, Forms, Graphics, Menus, StdCtrls,
  ABase,
  AStringMain,
  AUiBase, AUiData;

// --- AUiControl ---

function AUiControl_Free(Control: AControl): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_FreeAndNil(var Control: AControl): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetClientHeight(Control: AControl): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetClientWidth(Control: AControl): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetColor(Control: AControl): AColor; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetEnabled(Control: AControl): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetHeight(Control: AControl): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetHint(Control: AControl; out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetHintA(Control: AControl; Value: AStr; MaxLen: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetHintP(Control: AControl): APascalString;

function AUiControl_GetMenu(Control: AControl): AMenu; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetName(Control: AControl; out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetNameA(Control: AControl; Value: AStr; MaxLen: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetNameP(Control: AControl): APascalString;

function AUiControl_GetPosition(Control: AControl; out Left, Top: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetText(Control: AControl; out Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetTextP(Control: AControl): APascalString;

function AUiControl_GetTop(Control: AControl): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetVisible(Control: AControl): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_GetWidth(Control: AControl): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetAlign(Control: AControl; Align: TUiAlign): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetAnchors(Control: AControl; Anchors: TUiAnchors): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetBevel(Control: AControl; Value: AUiBevel; Width: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetClientSize(Control: AControl; ClientWidth, ClientHeight: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetColor(Control: AControl; Color: AColor): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetCursor(Control: AControl; Value: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetEnabled(Control: AControl; Value: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetFocus(Control: AControl): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

{ @param FontName - (const) }
function AUiControl_SetFont1A(Control: AControl; FontName: AStr;
    FontSize: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetFont1P(Control: AControl; const FontName: APascalString;
    FontSize: AInteger): AError;

function AUiControl_SetFont2P(Control: AControl; const FontName: APascalString;
    FontSize: AInteger; FontColor: AColor): AError;

function AUiControl_SetFontColor(Control: AControl; Color: AColor): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetFontSize(Control: AControl; Size: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetFontStyle(Control: AControl; FontStyle: AUiFontStyle): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetHeight(Control: AControl; Value: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetHint(Control: AControl; const Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetHintA(Control: AControl; Value: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetHintP(Control: AControl; const Value: APascalString): AError;

function AUiControl_SetName(Control: AControl; const Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetNameA(Control: AControl; Value: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetNameP(Control: AControl; const Value: APascalString): AError;

function AUiControl_SetOnClick(Control: AControl; Value: ACallbackProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetPosition(Control: AControl; Left, Top: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetSize(Control: AControl; Width, Height: Integer): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetTabStop(Control: AControl; Value: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetText(Control: AControl; const Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetTextA(Control: AControl; Value: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetTextP(Control: AControl; const Value: APascalString): AError;

function AUiControl_SetTop(Control: AControl; Value: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetVisible(Control: AControl; Value: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_SetWidth(Control: AControl; Value: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUiControl_TextWidthP(Control: AControl; const S: APascalString): AInt;

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

function AUiControl_GetClientHeight(Control: AControl): AInt;
begin
  try
    Result := TWinControl(Control).ClientHeight;
  except
    Result := 0;
  end;
end;

function AUiControl_GetClientWidth(Control: AControl): AInt;
begin
  try
    Result := TWinControl(Control).ClientWidth;
  except
    Result := 0;
  end;
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
    if (TObject(Control) is TControl) then
      Result := TControl(Control).Height
    else
      Result := 0;
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

function AUiControl_GetTop(Control: AControl): AInt;
begin
  try
    if (TObject(Control) is TControl) then
      Result := TControl(Control).Top
    else
      Result := 0;
  except
    Result := 0;
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
    A := [];
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

function AUiControl_SetBevel(Control: AControl; Value: AUiBevel; Width: AInt): AError;
var
  V: AInt;
begin
  try
    V := Value and $00FF;
    if (V = AUiBevel_InnerNone) then
      TPanel(Control).BevelInner := bvNone
    else if (V = AUiBevel_InnerLowered) then
      TPanel(Control).BevelInner := bvLowered
    else if (V = AUiBevel_InnerRaised) then
      TPanel(Control).BevelInner := bvRaised
    else if (V = AUiBevel_InnerSpace) then
      TPanel(Control).BevelInner := bvSpace;

    V := Value and $FF00;
    if (V = AUiBevel_OuterNone) then
      TPanel(Control).BevelOuter := bvNone
    else if (V = AUiBevel_OuterLowered) then
      TPanel(Control).BevelOuter := bvLowered
    else if (V = AUiBevel_OuterRaised) then
      TPanel(Control).BevelOuter := bvRaised
    else if (V = AUiBevel_OuterSpace) then
      TPanel(Control).BevelOuter := bvSpace;

    if (Width >= 0) then
      TPanel(Control).BevelWidth := Width;

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

function AUiControl_SetCursor(Control: AControl; Value: AInt): AError;
begin
  try
    if (TObject(Control) is TControl) then
      TControl(Control).Cursor := TCursor(Value);
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
      if (FontSize > 0) then
        TLabel(Control).Font.Size := FontSize;
      if (FontSize < 0) then
        TLabel(Control).Font.Height := -FontSize;
    end;
    Result := 0;
  except
    Result := -1;
  end;
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

function AUiControl_SetFontColor(Control: AControl; Color: AColor): AError;
begin
  try
    if (TObject(Control) is TLabel) then
      TLabel(Control).Font.Color := Color;
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
var
  I: Integer;
begin
  try
    if (TObject(Control) is TBitBtn) then
    begin
      I := FindButton(Control);
      if (I >= 0) then
        FButtons[I].OnClick := Value;
    end
    else if (TObject(Control) is TMenuItem) then
    begin
      I := FindMenuItem(Control);
      if (I >= 0) then
        FMenuItems[I].OnClick := Value;
    end
    else if (TObject(Control) is TListBox) then
    begin
      I := FindListBox(Control);
      if (I >= 0) then
        FListBoxs[I].OnClick := Value;
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
      else if (Obj is TEdit) then
        TEdit(Obj).Text := Value
      else if (Obj is TForm) then
        TForm(Obj).Caption := Value
      else if (Obj is TGroupBox) then
        TGroupBox(Obj).Caption := Value
      else if (Obj is TLabel) then
        TLabel(Obj).Caption := Value
      else if (Obj is TMemo) then
        TMemo(Obj).Text := Value
      else if (Obj is TRadioGroup) then
        TRadioGroup(Obj).Caption := Value
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

function AUiControl_SetTop(Control: AControl; Value: AInt): AError;
begin
  try
    if (TObject(Control) is TControl) then
      TControl(Control).Top := Value;
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

function AUiControl_TextWidthP(Control: AControl; const S: APascalString): AInt;
var
  Canvas: TCanvas;
  Obj: TObject;
begin
  try
    Obj := AUiData.GetObject(Control);
    if (Obj is TCustomForm) then
      Canvas := TCustomForm(Obj).Canvas
    else if (Obj is TListBox) then
      Canvas := TListBox(Obj).Canvas
    else
    begin
      Result := 0;
      Exit;
    end;
    Result := Canvas.TextWidth(S);
  except
    Result := 0;
  end;
end;

end.
 