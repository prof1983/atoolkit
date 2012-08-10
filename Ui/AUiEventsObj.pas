{**
@Abstract AUi events object
@Author Prof1983 <prof1983@ya.ru>
@Created 28.06.2011
@LastMod 10.08.2012
}
unit AUiEventsObj;

interface

uses
  Db,
  ABase, ASystem,
  AUiBase, AUiData;

{ Classes }

type
  TUI_ = class
  public
    procedure ButtonClick(Sender: TObject);
    procedure CalendarChange(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure ListBoxClick(Sender: TObject);
    procedure MainFormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MenuItemClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
  end;

var
  UI_: TUI_;

implementation

uses
  AUiMainWindow;

{ TUI_ }

procedure TUI_.ButtonClick(Sender: TObject);
var
  i: Integer;
begin
  i := FindButton(AControl(Sender));
  if (i >= 0) then
  begin
    if Assigned(FButtons[i].OnClick02) then
      FButtons[i].OnClick02(FButtons[i].Button, Integer(Sender));
    if Assigned(FButtons[i].OnClick03) then
      FButtons[i].OnClick03(FButtons[i].Button, Integer(Sender));
  end;
end;

procedure TUI_.CalendarChange(Sender: TObject);
var
  i: Integer;
begin
  i := FindCalendar(AControl(Sender));
  if (i >= 0) then
  begin
    if Assigned(FCalendars[i].OnChange02) then
      FCalendars[i].OnChange02(FCalendars[i].OnChangeObj, Integer(Sender));
    if Assigned(FCalendars[i].OnChange03) then
      FCalendars[i].OnChange03(FCalendars[i].OnChangeObj, Integer(Sender));
  end;
end;

procedure TUI_.DataSourceDataChange(Sender: TObject; Field: TField);
var
  I: Integer;
begin
  I := FindDataSource(PADataSource(Sender));
  if (I >= 0) then
  begin
    if Assigned(FDataSources[I].OnDataChange02) then
      FDataSources[I].OnDataChange02(Integer(Sender), Integer(Field));
    if Assigned(FDataSources[I].OnDataChange03) then
      FDataSources[I].OnDataChange03(Integer(Sender), Integer(Field));
  end;
end;

procedure TUI_.ListBoxClick(Sender: TObject);
var
  I: Integer;
begin
  I := FindListBox(AControl(Sender));
  if (I >= 0) then
  begin
    if Assigned(FListBoxs[I].OnClick02) then
      FListBoxs[I].OnClick02(AInteger(Sender), 0);
    if Assigned(FListBoxs[I].OnClick03) then
      FListBoxs[I].OnClick03(AInteger(Sender), 0);
  end;
end;

procedure TUI_.MainFormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if FHideOnClose then
  begin
    //CanClose := ARuntime.IsShutdown;
    CanClose := ASystem.GetIsShutdown;
    if not(CanClose) then
      FIsShowApp := False; //UI_IsShowApp_Set(False);
  end
  else
    _MainWindow_Shutdown; //UI_Shutdown;
end;

procedure TUI_.MenuItemClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to High(FMenuItems) do
  begin
    if (FMenuItems[I].MenuItem = Integer(Sender)) then
    begin
      if Assigned(FMenuItems[I].OnClick02) then
        FMenuItems[I].OnClick02(FMenuItems[I].MenuItem, 0{Integer(Sender)});
      if Assigned(FMenuItems[I].OnClick03) then
        FMenuItems[I].OnClick03(FMenuItems[I].MenuItem, 0{Integer(Sender)});
      Exit;
    end;
  end;
end;

procedure TUI_.PageControlChange(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to High(FPageControls) do
  begin
    if (FPageControls[I].PageControl = AControl(Sender)) then
    begin
      if Assigned(FPageControls[I].OnChange02) then
        FPageControls[I].OnChange02(AControl(FPageControls[I].PageControl), 0);
      if Assigned(FPageControls[I].OnChange03) then
        FPageControls[I].OnChange03(AControl(FPageControls[I].PageControl), 0);
    end;
  end;
end;

end.
 