{**
@Abstract AUi splitter
@Author Prof1983 <prof1983@ya.ru>
@Created 12.11.2012
@LastMod 22.11.2012
}
unit AUiSplitter;

interface

uses
  Controls, ExtCtrls,
  AUiBase, AUiData;

// --- Splitter ---

{** Создает динамический разделитель
    @param SplitterType 0 - HSplitter (Align=alTop); 1 - VSplitter (Align=alLeft);
        2 - HSplitter (Align=alBottom); 3 - VSplitter (Align=alRight) }
function AUiSplitter_New(Parent: AControl; SplitterType: AUiSplitterType): AControl; stdcall;

// --- AUi_Splitter ---

{ SplitterType
    0 - HSplitter (Align=alTop)
    1 - VSplitter (Align=alLeft)
    2 - HSplitter (Align=alBottom)
    3 - VSplitter (Align=alRight) }
function AUi_Splitter_New(Parent: AControl; SplitterType: AUISplitterType): AControl; stdcall;

{ SplitterType
    0 - HSplitter (Align=alTop)
    1 - VSplitter (Align=alLeft)
    2 - HSplitter (Align=alBottom)
    3 - VSplitter (Align=alRight) }
function UI_Splitter_New(Parent: AControl; SplitterType: AUiSplitterType): AControl; stdcall; deprecated; // Use AUiSplitter_New()

implementation

{ Splitter }

function AUiSplitter_New(Parent: AControl; SplitterType: AUiSplitterType): AControl;
var
  O: TObject;
  Splitter: TSplitter;
begin
  try
    O := AUiData.GetObject(Parent);
    if Assigned(O) and (O is TWinControl) then
    begin
      Splitter := TSplitter.Create(TWinControl(O));
      Splitter.Parent := TWinControl(O);
      Splitter.Left := 200;
      case SplitterType of
        AUISplitter_HSplitter: Splitter.Align := alTop;
        AUISplitter_VSplitter: Splitter.Align := alLeft;
        AUISplitter_HSplitterBottom: Splitter.Align := alBottom;
        AUISplitter_VSplitterRight: Splitter.Align := alRight;
      end;
      Result := AddObject(Splitter);
    end
    else
      Result := 0;
  except
    Result := 0;
  end;
end;

// --- AUi_Splitter ---

function AUi_Splitter_New(Parent: AControl; SplitterType: AUISplitterType): AControl;
begin
  try
    Result := AUiSplitter_New(Parent, SplitterType);
  except
    Result := 0;
  end;
end;

{ UI_Splitter }

function UI_Splitter_New(Parent: AControl; SplitterType: AUiSplitterType): AControl;
begin
  Result := AUiSplitter_New(Parent, SplitterType);
end;

end.
