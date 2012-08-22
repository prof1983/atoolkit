{**
@Abstract AUi data
@Author Prof1983 <prof1983@ya.ru>
@Created 31.05.2011
@LastMod 22.08.2012
}
unit AUiData;

interface

uses
  ABase, AUiBase;

{ Types }

type
  TAUICalendar = record
    Calendar: AControl;
    OnChange02: ACallbackProc02;
    OnChange03: ACallbackProc03;
    OnChangeObj: AInteger;
  end;

type
  TAUIDataSource = record
    DataSource: PADataSource;
    OnDataChange02: ACallbackProc02;
    OnDataChange03: ACallbackProc03;
  end;

type
  TAUIFrame = record
    Frame: AControl;
    Menu: AMenu;
  end;

type
  TAUIListBox = record
    ListBox: AControl;
    OnClick02: ACallbackProc02;
    OnClick03: ACallbackProc03;
  end;

type
  TAUIMenuItem = record
    Parent: Integer;
    MenuItem: AMenuItem;
    OnClick02: ACallbackProc02;
    OnClick03: ACallbackProc03;
    Weight: Integer;
  end;

type
  TAUIPageControl = record
    PageControl: AControl;
    OnChange02: ACallbackProc02;
    OnChange03: ACallbackProc03;
  end;

type
  TAUIReport = record
    Parent: AControl;
    TextView: AControl;
    ToolsPanel: AControl;
  end;

type
  TAUIToolMenu = record
    PageControl: AControl;
    Page: AControl; //TabSheet: TTabSheet;
    //CoolBar: AControl; //TCoolBar;
  end;

{ Varriables }

var
  FButtons: array of record
    Button: AControl;
    OnClick02: ACallbackProc02;
    OnClick03: ACallbackProc03;
  end;
  FCalendars: array of TAUICalendar;
  FDataSources: array of TAUIDataSource;
  FFrames: array of TAUIFrame;
  FListBoxs: array of TAUIListBox;
  FMenuItems: array of TAUIMenuItem;
  FObjects: array of TObject;
  FOnDone: AEvent;
  FOnMainFormCreate: AProc;
  FPageControls: array of TAUIPageControl;
  FReports: array of TAUIReport;
  FToolMenus: array of TAUIToolMenu;
  FIsShowApp: Boolean;
  FMainTrayIcon: AControl;
  FMainWindow: AWindow;
  FHideOnClose: Boolean;

var
  miMain: AInteger;
  miHelp: AInteger;
  miFile: AInteger;

var
  UiAboutClick: AProc;
  UiAboutWinMemoHeightDefault: Integer = 0;
  UiAboutWinMemoWidthDefault: Integer = 0;

function AddObject(Value: TObject): Integer;
function GetObject(Value: Integer): TObject;

function FindButton(Button: AControl): Integer;
function FindCalendar(Calendar: AControl): Integer;
function FindDataSource(DataSource: PADataSource): Integer;
function FindFrame(Frame: AControl): Integer;
function FindListBox(ListBox: AControl): Integer;
function FindMenuItem(MenuItem: AMenuItem): Integer;
function FindObject(Obj: TObject): Integer;
function FindPageControl(PageControl: AControl): Integer;
function FindToolMenu(ToolMenu: AToolMenu): Integer;
//function FindToolMenuByName(Parent: AToolMenu: const Name: string): Integer;

implementation

function AddObject(Value: TObject): Integer;
var
  I: Integer;
begin
  I := Length(FObjects);
  SetLength(FObjects, I + 1);
  FObjects[I] := Value;
  Result := Integer(Value);
end;

function FindButton(Button: AControl): Integer;
var
  I: Integer;
begin
  for I := 0 to High(FButtons) do
  begin
    if (FButtons[I].Button = Button) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function FindCalendar(Calendar: AControl): Integer;
var
  i: Integer;
begin
  for i := 0 to High(FCalendars) do
  begin
    if (FCalendars[i].Calendar = Calendar) then
    begin
      Result := i;
      Exit;
    end;
  end;
  Result := -1;
end;

function FindDataSource(DataSource: PADataSource): Integer;
var
  I: Integer;
begin
  for I := 0 to High(FDataSources) do
  begin
    if (FDataSources[I].DataSource = DataSource) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function FindFrame(Frame: AControl): Integer;
var
  I: Integer;
begin
  for I := 0 to High(FFrames) do
  begin
    if (FFrames[I].Frame = Frame) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function FindListBox(ListBox: AControl): Integer;
var
  I: Integer;
begin
  for I := 0 to High(FListBoxs) do
  begin
    if (FListBoxs[I].ListBox = ListBox) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function FindMenuItem(MenuItem: AMenuItem): Integer;
var
  I: Integer;
begin
  for I := 0 to High(FMenuItems) do
  begin
    if (FMenuItems[I].MenuItem = MenuItem) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function FindObject(Obj: TObject): Integer;
var
  I: Integer;
begin
  for I := 0 to High(FObjects) do
  begin
    if (FObjects[I] = Obj) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function FindPageControl(PageControl: AControl): Integer;
var
  I: Integer;
begin
  for I := 0 to High(FPageControls) do
  begin
    if (FPageControls[I].PageControl = PageControl) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function FindToolMenu(ToolMenu: AToolMenu): Integer;
var
  I: Integer;
begin
  for I := 0 to High(FToolMenus) do
  begin
    if (FToolMenus[I].Page = ToolMenu) or (FToolMenus[I].PageControl = ToolMenu) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function GetObject(Value: Integer): TObject;
var
  I: Integer;
begin
  for I := 0 to High(FObjects) do
  begin
    if (Integer(FObjects[I]) = Value) then
    begin
      Result := FObjects[I];
      Exit;
    end;
  end;
  Result := nil;
end;

end.
