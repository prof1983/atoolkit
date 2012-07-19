{**
@Abstract AUi Workbench
@Author Prof1983 <prof1983@ya.ru>
@Created 26.08.2009
@LastMod 19.07.2012
}
unit AUIWorkbench;

interface

uses
  ABase, ARuntime, AUi, AUiBase;

//** Инициализирует модуль.
function Init(): AError; stdcall;

function Done(): AError; stdcall;

{ Создает новую вкладку в главном окне программы. Возврашает:
  0 - если произошла ошибка, иначе идентификатор новой вкладки (если операция прошла успешно) }
function AddPageP(const Name, Text: APascalString): AControl; stdcall;

{ Создает новую вкладку в главном окне программы. Возврашает:
  0 - если произошла ошибка, иначе идентификатор новой вкладки (если операция прошла успешно) }
function AddPageWS(const Name, Text: AWideString): AControl; stdcall;


{ Создает новую вкладку в главном окне программы. Возврашает:
  0 - если произошла ошибка, иначе идентификатор новой вкладки (если операция прошла успешно) }
function UIWorkbench_AddPage(const Name, Text: APascalString): AControl; stdcall;

// Заглушка.
function UIWorkbench_Boot(): AError;

function UIWorkbench_Done(): AError; stdcall;

function UIWorkbench_Init(): AError; stdcall;

procedure UIWorkbench_SetOnChange(OnChange: ACallbackProc); stdcall;

implementation

var
  FInitialized: Boolean;
  FPageControl: AControl;

{ Public }

function AddPageP(const Name, Text: APascalString): AControl; stdcall;
begin
  try
    Result := UIWorkbench_AddPage(Name, Text);
  except
    Result := 0;
  end;
end;

function AddPageWS(const Name, Text: AWideString): AControl; stdcall;
begin
  try
    Result := UIWorkbench_AddPage(Name, Text);
  except
    Result := 0;
  end;
end;

function Done(): AError; stdcall;
begin
  try
    Result := UIWorkbench_Done();
  except
    Result := -1;
  end;
end;

function Init(): AError; stdcall;
begin
  try
    Result := UIWorkbench_Init();
  except
    Result := -1;
  end;
end;

{ UIWorkbench }

function UIWorkbench_AddPage(const Name, Text: APascalString): AControl; stdcall;
begin
  Result := AUI.PageControl_AddPageWS(FPageControl, Name, Text);
end;

function UIWorkbench_Boot(): AError;
begin
  Result := 0;
end;

function UIWorkbench_Done(): AError; stdcall;
begin
  FInitialized := False;
  Result := 0;
end;

function UIWorkbench_Init(): AError; stdcall;
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

  FPageControl := AUI.PageControl_New(AUI.MainWindow_GetMainContainer());
  FInitialized := True;
  Result := 0;
end;

procedure UIWorkbench_SetOnChange(OnChange: ACallbackProc); stdcall;
begin
  if FInitialized then
    AUI.Control_SetOnChange(FPageControl, OnChange);
end;

end.
