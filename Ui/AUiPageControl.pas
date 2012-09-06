{**
@Abstract AUi PageControl
@Author Prof1983 <prof1983@ya.ru>
@Created 27.02.2012
@LastMod 06.09.2012
}
unit AUiPageControl;

interface

uses
  ComCtrls, Controls,
  ABase, AStrings,
  AUiBase, AUiData;

// --- AUiPageControl ---

{** Создает новую вкладку
    @return 0 - если произошла ошибка, иначе идентификатор новой вкладки (если операция прошла успешно) }
function AUiPageControl_AddPage(PageControl: AControl; const Name, Text: AString_Type): AControl; stdcall;

{** Создает новую вкладку
    @return 0 - если произошла ошибка, иначе идентификатор новой вкладки (если операция прошла успешно) }
function AUiPageControl_AddPageA(PageControl: AControl; Name, Text: AStr): AControl; stdcall;

{** Создает новую вкладку
    @return 0 - если произошла ошибка, иначе идентификатор новой вкладки (если операция прошла успешно) }
function AUiPageControl_AddPageP(PageControl: AControl; const Name, Text: APascalString): AControl; stdcall;

function AUiPageControl_New(Parent: AControl): AControl; stdcall;

// --- UI_PageControl ---

{ Создает новую вкладку. Возврашает:
  0 - если произошла ошибка, иначе идентификатор новой вкладки (если операция прошла успешно) }
function UI_PageControl_AddPage(PageControl: AControl; const Name, Text: APascalString): AControl; stdcall; deprecated; // Use AUiPageControl_AddPageP()

function UI_PageControl_New(Parent: AControl): AControl; stdcall; deprecated; // Use AUiPageControl_New()

implementation

// --- AUiPageControl ---

function AUiPageControl_AddPage(PageControl: AControl; const Name, Text: AString_Type): AControl;
begin
  Result := AUiPageControl_AddPageP(PageControl, AString_ToPascalString(Name),
      AString_ToPascalString(Text));
end;

function AUiPageControl_AddPageA(PageControl: AControl; Name, Text: AStr): AControl;
begin
  Result := AUiPageControl_AddPageP(PageControl, AnsiString(Name), AnsiString(Text));
end;

function AUiPageControl_AddPageP(PageControl: AControl; const Name, Text: APascalString): AControl;
var
  O: TObject;
  TabSheet: TTabSheet;
begin
  try
    O := AUiData.GetObject(PageControl);
    if Assigned(O) and (O is TPageControl) then
    begin
      TabSheet := TTabSheet.Create(TPageControl(O));
      TabSheet.PageControl := TPageControl(O);
      TabSheet.Name := Name;
      TabSheet.Caption := Text;
      Result := AddObject(TabSheet);
    end
    else
      Result := 0;
  except
    Result := 0;
  end;
end;

function AUiPageControl_New(Parent: AControl): AControl;
var
  O: TObject;
  PageControl: TPageControl;
  I: Integer;
  Obj: Integer;
begin
  try
    O := AUIData.GetObject(Parent);
    if Assigned(O) and (O is TWinControl) then
    begin
      PageControl := TPageControl.Create(TWinControl(O));
      PageControl.Parent := TWinControl(O);
      PageControl.Align := alClient;
      Obj := AddObject(PageControl);

      I := Length(FPageControls);
      SetLength(FPageControls, I+1);
      FPageControls[I].PageControl := Obj;
      FPageControls[I].OnChange02 := nil;
      FPageControls[I].OnChange03 := nil;

      Result := Obj;
    end
    else
      Result := 0;
  except
    Result := 0
  end;
end;

// --- UI_PageControl ---

function UI_PageControl_AddPage(PageControl: AControl; const Name, Text: APascalString): AControl;
begin
  Result := AUiPageControl_AddPageP(PageControl, Name, Text);
end;

function UI_PageControl_New(Parent: AControl): AControl;
begin
  Result := AUiPageControl_New(Parent);
end;

end.
 