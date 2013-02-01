{**
@Abstract AUi splitter
@Author Prof1983 <prof1983@ya.ru>
@Created 12.11.2012
@LastMod 29.01.2013
}
unit AUiSplitter;

{define AStdCall}

interface

uses
  Controls, ExtCtrls,
  AUiBase, AUiData;

// --- AUiSplitter ---

{** Создает динамический разделитель
    @param SplitterType 0 - HSplitter (Align=alTop); 1 - VSplitter (Align=alLeft);
        2 - HSplitter (Align=alBottom); 3 - VSplitter (Align=alRight) }
function AUiSplitter_New(Parent: AControl; SplitterType: AUiSplitterType): AControl; {$ifdef AStdCall}stdcall;{$endif}

implementation

// --- AUiSplitter ---

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

end.
