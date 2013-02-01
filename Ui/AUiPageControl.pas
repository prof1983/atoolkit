{**
@Abstract AUi PageControl
@Author Prof1983 <prof1983@ya.ru>
@Created 27.02.2012
@LastMod 30.01.2013
}
unit AUiPageControl;

{define AStdCall}

interface

uses
  ComCtrls,
  Controls,
  ABase,
  AStringMain,
  AUiBase,
  AUiData;

// --- AUiPageControl ---

{** Создает новую вкладку
    @return 0 - если произошла ошибка, иначе идентификатор новой вкладки (если операция прошла успешно) }
function AUiPageControl_AddPage(PageControl: AControl; const Name, Text: AString_Type): AControl; {$ifdef AStdCall}stdcall;{$endif}

{** Создает новую вкладку
    @return 0 - если произошла ошибка, иначе идентификатор новой вкладки (если операция прошла успешно) }
function AUiPageControl_AddPageA(PageControl: AControl; Name, Text: AStr): AControl; {$ifdef AStdCall}stdcall;{$endif}

{** Создает новую вкладку
    @return 0 - если произошла ошибка, иначе идентификатор новой вкладки (если операция прошла успешно) }
function AUiPageControl_AddPageP(PageControl: AControl; const Name, Text: APascalString): AControl;

{** Создает новую вкладку
    @param Index - позиция вкладки
    @return 0 - если произошла ошибка, иначе идентификатор новой вкладки (если операция прошла успешно) }
function AUiPageControl_InsertPageP(PageControl: AControl; const Name, Text: APascalString; Index: AInt): AControl;

function AUiPageControl_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

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
begin
  Result := AUiPageControl_InsertPageP(PageControl, Name, Text, -1);
end;

function AUiPageControl_InsertPageP(PageControl: AControl; const Name, Text: APascalString; Index: AInt): AControl;
var
  O: TObject;
  TabSheet: TTabSheet;
begin
  try
    O := AUiData.GetObject(PageControl);
    if not(Assigned(O)) then
    begin
      Result := 0;
      Exit;
    end;
    if not(O is TPageControl) then
    begin
      Result := 0;
      Exit;
    end;
    TabSheet := TTabSheet.Create(TPageControl(O));
    TabSheet.PageControl := TPageControl(O);
    TabSheet.Name := Name;
    TabSheet.Caption := Text;
    if (Index >= 0) then
      TabSheet.PageIndex := Index;
    Result := AddObject(TabSheet);
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
      FPageControls[I].OnChange := nil;

      Result := Obj;
    end
    else
      Result := 0;
  except
    Result := 0
  end;
end;

end.
 