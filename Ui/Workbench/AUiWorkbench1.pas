{**
@Abstract AUi Workbench
@Author Prof1983 <prof1983@ya.ru>
@Created 26.08.2009
@LastMod 25.07.2012
}
unit AUIWorkbench;

interface

uses
  ABase, ARuntime, AUi, AUiBase;

{** Creates a new tab in the main window of the program
    @return 0 - error, else identifier new page }
function AUiWorkbench_AddPageP(const Name, Text: APascalString): AControl; stdcall;

{** Creates a new tab in the main window of the program
    @return 0 - error, else identifier new page }
function AUiWorkbench_AddPageWS(const Name, Text: AWideString): AControl; stdcall;

{** Finalize workbench }
function AUiWorkbench_Fin(): AError; stdcall;

{** Initialize workbench }
function AUiWorkbench_Init(): AError; stdcall;

{** Set OnChange event listener }
function AUiWorkbench_SetOnChange(OnChange: ACallbackProc): AError; stdcall;

// ----

function Init(): AError; stdcall; deprecated; // Use AUiWorkbench_Init()

function Done(): AError; stdcall; deprecated; // Use AUiWorkbench_Fin()

{** Creates a new tab in the main window of the program
    @return 0 - error, else identifier new page }
function AddPageP(const Name, Text: APascalString): AControl; stdcall; deprecated; // Use AUiWorkbench_AddPageP()

{** Creates a new tab in the main window of the program
    @return 0 - error, else identifier new page }
function AddPageWS(const Name, Text: AWideString): AControl; stdcall; deprecated; // Use AUiWorkbench_AddPageWS()

implementation

var
  FInitialized: Boolean;
  FPageControl: AControl;

// --- AUiWorkbench ---

function AUiWorkbench_AddPageP(const Name, Text: APascalString): AControl;
begin
  Result := AUI.PageControl_AddPageWS(FPageControl, Name, Text);
end;

function AUiWorkbench_AddPageWS(const Name, Text: AWideString): AControl;
begin
  try
    Result := AUiWorkbench_AddPageP(Name, Text);
  except
    Result := 0;
  end;
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

  if (AUI.Init() < 0) then
  begin
    Result := -2;
    Exit;
  end;

  try
    FPageControl := AUI.PageControl_New(AUI.MainWindow_GetMainContainer());
    FInitialized := True;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiWorkbench_SetOnChange(OnChange: ACallbackProc): AError;
begin
  if FInitialized then
    AUI.Control_SetOnChange(FPageControl, OnChange);
  Result := 0;
end;

{ Public }

function AddPageP(const Name, Text: APascalString): AControl; stdcall;
begin
  try
    Result := AUiWorkbench_AddPageP(Name, Text);
  except
    Result := 0;
  end;
end;

function AddPageWS(const Name, Text: AWideString): AControl; stdcall;
begin
  try
    Result := AUiWorkbench_AddPageWS(Name, Text);
  except
    Result := 0;
  end;
end;

function Done(): AError; stdcall;
begin
  try
    Result := AUiWorkbench_Fin();
  except
    Result := -1;
  end;
end;

function Init(): AError; stdcall;
begin
  try
    Result := AUiWorkbench_Init();
  except
    Result := -1;
  end;
end;

end.
