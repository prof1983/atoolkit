{**
@abstract AUi PageControl
@author Prof1983 <prof1983@ya.ru>
@created 27.02.2012
@lastmod 19.07.2012
}
unit AUiPageControl;

interface

uses
  ComCtrls, Controls,
  ABase, AUiBase, AUiData;

{ Создает новую вкладку. Возврашает:
  0 - если произошла ошибка, иначе идентификатор новой вкладки (если операция прошла успешно) }
function UI_PageControl_AddPage(PageControl: AControl; const Name, Text: APascalString): AControl;

function UI_PageControl_New(Parent: AControl): AControl;

implementation

function UI_PageControl_AddPage(PageControl: AControl; const Name, Text: APascalString): AControl;
var
  O: TObject;
  TabSheet: TTabSheet;
begin
  O := AUIData.GetObject(PageControl);
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
end;

function UI_PageControl_New(Parent: AControl): AControl;
var
  O: TObject;
  PageControl: TPageControl;
  I: Integer;
  Obj: Integer;
begin
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
end;

end.
 