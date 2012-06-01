{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(31.05.2011)
@LastMod(25.10.2011)
@Version(0.5)
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
  TAUIReport = record
    Parent: AControl;
    TextView: AControl;
    ToolsPanel: AControl;
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
  FListBoxs: array of TAUIListBox;
  FMenuItems: array of TAUIMenuItem;
  FObjects: array of TObject;
  FOnDone: AEvent;
  FOnMainFormCreate: AProc;
  FPageControls: array of record
    PageControl: AControl;
    OnChange02: ACallbackProc02;
    OnChange03: ACallbackProc03;
  end;
  FReports: array of TAUIReport;
  FIsShowApp: Boolean;
  FMainTrayIcon: AControl;
  FMainWindow: AWindow;
  FHideOnClose: Boolean;

var
  miMain: AInteger;
  miHelp: AInteger;
  miFile: AInteger;

function AddObject(Value: TObject): Integer;
function GetObject(Value: Integer): TObject;

function FindButton(Button: AControl): Integer;
function FindCalendar(Calendar: AControl): Integer;
function FindDataSource(DataSource: PADataSource): Integer;
function FindListBox(ListBox: AControl): Integer;
function FindMenuItem(MenuItem: AMenuItem): Integer;
function FindObject(Obj: TObject): Integer;
function FindPageControl(PageControl: AControl): Integer;

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
  i: Integer;
begin
  for i := 0 to High(FDataSources) do
  begin
    if (FDataSources[i].DataSource = DataSource) then
    begin
      Result := i;
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
 