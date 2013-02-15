{**
@Abstract AUi splitter
@Author Prof1983 <prof1983@ya.ru>
@Created 12.11.2012
@LastMod 15.02.2013
}
unit AUiSplitter;

{define AStdCall}

interface

uses
  Controls, ExtCtrls,
  JvNetscapeSplitter,
  ABase,
  AUiBase, AUiData;

// --- AUiSplitter ---

{** Creates a dynamic separator
    @param SplitterType 0 - HSplitter (Align=alTop); 1 - VSplitter (Align=alLeft);
        2 - HSplitter (Align=alBottom); 3 - VSplitter (Align=alRight) }
function AUiSplitter_New(Parent: AControl; SplitterType: AUiSplitterType): AControl; {$ifdef AStdCall}stdcall;{$endif}

{** Creates a dynamic separator TJvNetscapeSplitter
    @param SplitterType 0 - HSplitter (Align=alTop); 1 - VSplitter (Align=alLeft);
        2 - HSplitter (Align=alBottom); 3 - VSplitter (Align=alRight) }
function AUiSplitter_NewJv(Parent: AControl; SplitterType: AUiSplitterType;
    OnMaximize, OnMinimize: ACallbackProc): AControl; {$ifdef AStdCall}stdcall;{$endif}

implementation

type
  TSplitterRec = class
  private
    Splitter: TJvNetscapeSplitter;
    Control: AControl;
    OnMaximize: ACallbackProc;
    OnMinimize: ACallbackProc;
    procedure DoMaximize(Sender: TObject);
    procedure DoMinimize(Sender: TObject);
  end;

var
  _Splitter: array of TSplitterRec;

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

function AUiSplitter_NewJv(Parent: AControl; SplitterType: AUiSplitterType;
    OnMaximize, OnMinimize: ACallbackProc): AControl;
var
  O: TObject;
  Splitter: TJvNetscapeSplitter;
  I: AInt;
begin
  try
    O := AUiData.GetObject(Parent);
    if not(Assigned(O)) then
    begin
      Result := 0;
      Exit;
    end;
    if not(O is TWinControl) then
    begin
      Result := 0;
      Exit;
    end;

    Splitter := TJvNetscapeSplitter.Create(TWinControl(O));
    Splitter.Parent := TWinControl(O);
    Splitter.Align := alNone;
    Splitter.ButtonWidth := 300;
    Splitter.Left := 500;
    Splitter.Top := 500;
    Splitter.Height := 10;
    Splitter.Width := 10;
    Splitter.MinSize := 1;
    Splitter.Maximized := False;
    Splitter.Minimized := False;
    case SplitterType of
      AUiSplitter_HSplitter: Splitter.Align := alTop;
      AUiSplitter_VSplitter: Splitter.Align := alLeft;
      AUiSplitter_HSplitterBottom: Splitter.Align := alBottom;
      AUiSplitter_VSplitterRight: Splitter.Align := alRight;
    end;
    Result := AddObject(Splitter);

    I := Length(_Splitter);
    SetLength(_Splitter, I + 1);
    _Splitter[I] := TSplitterRec.Create();
    _Splitter[I].Splitter := Splitter;
    _Splitter[I].Control := Result;
    _Splitter[I].OnMaximize := OnMaximize;
    _Splitter[I].OnMinimize := OnMinimize;

    Splitter.OnMaximize := _Splitter[I].DoMaximize;
    Splitter.OnMinimize := _Splitter[I].DoMinimize;
  except
    Result := 0;
  end;
end;

{ TSplitterRec }

procedure TSplitterRec.DoMaximize(Sender: TObject);
begin
  if Assigned(OnMaximize) then
    OnMaximize(Self.Control, 0);
end;

procedure TSplitterRec.DoMinimize(Sender: TObject);
begin
  if Assigned(OnMinimize) then
    OnMinimize(Self.Control, 0);
end;

end.
