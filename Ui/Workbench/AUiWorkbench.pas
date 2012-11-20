{**
@Abstract AUi Workbench
@Author Prof1983 <prof1983@ya.ru>
@Created 26.08.2009
@LastMod 20.11.2012
}
unit AUiWorkbench;

interface

uses
  ABase, ARuntime, AUi, AUiBase;

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
