{**
@Abstract AUi Workbench
@Author Prof1983 <prof1983@ya.ru>
@Created 26.08.2009
@LastMod 20.02.2013
}
unit AUiWorkbenchMain;

{define AStdCall}

interface

uses
  ABase, AUiControlsA, AUiMain, AUiMainWindow, AUiBase, AUiPageControl;

{** Creates a new tab in the main window of the program
    @return 0 - error, else identifier new page }
function AUiWorkbench_AddPage(const Name, Text: AString_Type): AControl; {$ifdef AStdCall}stdcall;{$endif}

{** Creates a new tab in the main window of the program
    @return 0 - error, else identifier new page }
function AUiWorkbench_AddPageP(const Name, Text: APascalString): AControl;

{** Finalize workbench }
function AUiWorkbench_Fin(): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Initialize workbench }
function AUiWorkbench_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Set OnChange event listener }
function AUiWorkbench_SetOnChange(OnChange: ACallbackProc): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

var
  FInitialized: Boolean;
  FPageControl: AControl;

// --- AUiWorkbench ---

function AUiWorkbench_AddPage(const Name, Text: AString_Type): AControl;
begin
  Result := AUiPageControl_AddPage(FPageControl, Name, Text);
end;

function AUiWorkbench_AddPageP(const Name, Text: APascalString): AControl;
begin
  Result := AUiPageControl_AddPageP(FPageControl, Name, Text);
end;

function AUiWorkbench_Fin(): AError;
begin
  FInitialized := False;
  Result := 0;
end;

function AUiWorkbench_Init(): AError;
begin
  if FInitialized then
  begin
    Result := 0;
    Exit;
  end;

  if (AUi_Init() < 0) then
  begin
    Result := -2;
    Exit;
  end;

  try
    FPageControl := AUiPageControl_New(AUiMainWindow_GetMainContainer());
    FInitialized := True;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiWorkbench_SetOnChange(OnChange: ACallbackProc): AError;
begin
  if FInitialized then
    AUiControl_SetOnChange(FPageControl, OnChange);
  Result := 0;
end;

end.
 