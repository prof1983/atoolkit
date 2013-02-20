{**
@Abstract AUi Workbench
@Author Prof1983 <prof1983@ya.ru>
@Created 26.08.2009
@LastMod 20.02.2013
}
unit AUiWorkbench;

interface

uses
  ABase, AUiBase, AUiWorkbenchMain;

// ----

{** Creates a new tab in the main window of the program
    @return 0 - error, else identifier new page }
function AddPage(const Name, Text: AString_Type): AControl; stdcall;

{** Creates a new tab in the main window of the program
    @return 0 - error, else identifier new page }
function AddPageP(const Name, Text: APascalString): AControl;

{** Finalize workbench }
function Fin(): AError; stdcall;

{** Initialize workbench }
function Init(): AError; stdcall;

{** Set OnChange event listener }
function SetOnChange(OnChange: ACallbackProc): AError; stdcall;

implementation

// --- Public ---

function AddPage(const Name, Text: AString_Type): AControl;
begin
  Result := AUiWorkbench_AddPage(Name, Text);
end;

function AddPageP(const Name, Text: APascalString): AControl;
begin
  Result := AUiWorkbench_AddPageP(Name, Text);
end;

function Fin(): AError;
begin
  Result := AUiWorkbench_Fin();
end;

function Init(): AError;
begin
  Result := AUiWorkbench_Init();
end;

function SetOnChange(OnChange: ACallbackProc): AError;
begin
  Result := AUiWorkbench_SetOnChange(OnChange);
end;

end.
