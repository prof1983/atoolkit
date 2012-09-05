{**
@Abstract AUiLabel
@Author Prof1983 <prof1983@ya.ru>
@Created 05.09.2012
@LastMod 05.09.2012
}
unit AUiLabels;

{$define AStdCall}

interface

uses
  Controls, StdCtrls,
  ABase,
  AUiBase, AUiData;

// --- AUiLabel ---

{** Создает новый элемент тестового вывода }
function AUiLabel_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

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
