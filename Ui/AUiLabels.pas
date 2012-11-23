{**
@Abstract AUiLabel
@Author Prof1983 <prof1983@ya.ru>
@Created 05.09.2012
@LastMod 14.11.2012
}
unit AUiLabels;

{$define AStdCall}

interface

uses
  Classes, Controls, StdCtrls,
  ABase,
  AUiBase, AUiData;

type
  AUiAlignment = type AInt;
const
  uitaLeftJustify = $0000;
  uitaRightJustify = $0001;
  uitaCenter = $0002;
  uitlTop = $0000;
  uitlCenter = $0100;
  uitlBottom = $0200;

// --- AUiLabel ---

{** Создает новый элемент текстового вывода }
function AUiLabel_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiLabel_SetAlignment(Control: AControl; Value: AUiAlignment): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiLabel_SetAutoSize(Control: AControl; Value: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiLabel_SetWordWrap(Control: AControl; Value: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

// --- AUi_Label ---

function AUi_Label_New(Parent: AControl): AControl; stdcall; deprecated; // Use AUiLabel_New()

// --- UI_Label ---

function UI_Label_New(Parent: AControl): AControl; stdcall; deprecated; // Use AUiLabel_New()

procedure UI_Label_SetFont(TextLabel: AControl; const FontName: APascalString;
    FontSize: AInteger); stdcall; {$IFNDEF A02}deprecated;{$ENDIF}

implementation

// --- AUiLabel ---

function AUiLabel_New(Parent: AControl): AControl;
var
  L: TLabel;
begin
  try
    L := TLabel.Create(TWinControl(Parent));
    L.Parent := TWinControl(Parent);
    Result := AddObject(L);
  except
    Result := 0;
  end;
end;

function AUiLabel_SetAlignment(Control: AControl; Value: AUiAlignment): AError;
var
  A: TAlignment;
  L: TTextLayout;
  Obj: TObject;
begin
  try
    if (Value and uitaLeftJustify <> 0) then
      A := taLeftJustify
    else if (Value and uitaRightJustify <> 0) then
      A := taRightJustify
    else if (Value and uitaCenter <> 0) then
      A := taCenter
    else
    begin
      Result := -2;
      Exit;
    end;

    if (Value and uitlTop <> 0) then
      L := tlTop
    else if (Value and uitlCenter <> 0) then
      L := tlCenter
    else if (Value and uitlBottom <> 0) then
      L := tlBottom
    else
    begin
      Result := -3;
      Exit;
    end;

    Obj := GetObject(Control);
    if not(Assigned(Obj)) then
    begin
      Result := -3;
      Exit;
    end;

    if (Obj is TLabel) then
    begin
      TLabel(Obj).Alignment := A;
      TLabel(Obj).Layout := L;
    end;

    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiLabel_SetAutoSize(Control: AControl; Value: ABoolean): AError;
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

    if (Obj is TLabel) then
      TLabel(Obj).AutoSize := Value;

    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiLabel_SetWordWrap(Control: AControl; Value: ABoolean): AError;
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

    if (Obj is TLabel) then
      TLabel(Obj).WordWrap := Value;

    Result := 0;
  except
    Result := -1;
  end;
end;

// --- AUi_Label ---

function AUi_Label_New(Parent: AControl): AControl;
begin
  Result := AUiLabel_New(Parent);
end;

// --- UI_Label ---

function UI_Label_New(Parent: AControl): AControl; stdcall;
begin
  Result := AUiLabel_New(Parent);
end;

procedure UI_Label_SetFont(TextLabel: AControl; const FontName: APascalString; FontSize: AInteger); stdcall;
begin
  TLabel(TextLabel).Font.Name := FontName;
  TLabel(TextLabel).Font.Size := FontSize;
end;

end.
