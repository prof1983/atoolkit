{**
@Abstract(AUiWorkbench)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.08.2009)
@LastMod(22.05.2012)
@Version(0.5)
}
unit AUiWorkbench;

interface

uses
  ABase, ARuntime, AUi, AUiBase;

function Init(): AError; stdcall;
function Done(): AError; stdcall;

function Init03(): AInteger; stdcall;
function Done03(): AInteger; stdcall;

function AddPageP(const Name, Text: APascalString): AControl; stdcall;

{ Создает новую вкладку в главном окне программы. Возврашает:
  0 - если произошла ошибка, иначе идентификатор новой вкладки (если операция прошла успешно) }
function UIWorkbench_AddPage(const Name, Text: APascalString): AControl; stdcall;
procedure UIWorkbench_SetOnChange(OnChange: ACallbackProc); stdcall;

var
  FInitialized: Boolean;

implementation

var
  FPageControl: AControl;

{ Public }

function AddPageP(const Name, Text: APascalString): AControl; stdcall;
begin
  Result := UIWorkbench_AddPage(Name, Text);
end;

function Done(): AError; stdcall;
begin
  FInitialized := False;
  Result := 0;
end;

function Done03(): AInteger; stdcall;
begin
  Result := Done();
end;

function Init(): AError; stdcall;
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

  FPageControl := AUI.PageControl_New(UI_MainWindow_GetMainContainer);
  FInitialized := True;
  Result := 0;
end;

function Init03(): AInteger; stdcall;
begin
  Result := Init();
end;

{ UIWorkbench }

function UIWorkbench_AddPage(const Name, Text: APascalString): AControl; stdcall;
begin
  Result := AUI.PageControl_AddPage(FPageControl, Name, Text);
end;

procedure UIWorkbench_SetOnChange(OnChange: ACallbackProc); stdcall;
begin
  if FInitialized then
    AUI.Control_SetOnChange(FPageControl, OnChange);
end;

end.
