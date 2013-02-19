{**
@Abstract AUiLabel
@Author Prof1983 <prof1983@ya.ru>
@Created 05.09.2012
@LastMod 19.02.2013
}
unit AUiLabels;

{define AStdCall}

interface

uses
  Classes, Controls, StdCtrls,
  ABase,
  AUiBase, AUiData;

// --- AUiLabel ---

{** Создает новый элемент текстового вывода }
function AUiLabel_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiLabel_SetAlignment(Control: AControl; Value: AUiAlignment): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiLabel_SetAutoSize(Control: AControl; Value: ABool): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiLabel_SetFontP(TextLabel: AControl; const FontName: APascalString; FontSize: AInt): AError;

function AUiLabel_SetWordWrap(Control: AControl; Value: ABool): AError; {$ifdef AStdCall}stdcall;{$endif}

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

function AUiLabel_SetAutoSize(Control: AControl; Value: ABool): AError;
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

function AUiLabel_SetFontP(TextLabel: AControl; const FontName: APascalString; FontSize: AInt): AError;
begin
  try
    TLabel(TextLabel).Font.Name := FontName;
    TLabel(TextLabel).Font.Size := FontSize;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiLabel_SetWordWrap(Control: AControl; Value: ABool): AError;
var
  Obj: TObject;
  H: Integer;
  W: Integer;
begin
  try
    Obj := GetObject(Control);
    if not(Assigned(Obj)) then
    begin
      Result := -2;
      Exit;
    end;

    if (Obj is TLabel) then
    begin
      if (TLabel(Obj).Alignment = taCenter) or (TLabel(Obj).Layout = tlCenter) then
      begin
        H := TLabel(Obj).Height;
        W := TLabel(Obj).Width;
        TLabel(Obj).WordWrap := Value;
        TLabel(Obj).Height := H;
        TLabel(Obj).Width := W;
      end
      else
        TLabel(Obj).WordWrap := Value;
    end;

    Result := 0;
  except
    Result := -1;
  end;
end;

end.
