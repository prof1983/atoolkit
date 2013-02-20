{**
@Abstract AUi events object
@Author Prof1983 <prof1983@ya.ru>
@Created 28.06.2011
@LastMod 20.02.2013
}
unit AUiEventsObj;

interface

uses
  ABase,
  AUiBase, AUiData;

{ Classes }

type
  TUI_ = class
  public
    procedure ButtonClick(Sender: TObject);
    procedure CalendarChange(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
    procedure MenuItemClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
  end;

var
  UI_: TUI_;

implementation

{ TUI_ }

procedure TUI_.ButtonClick(Sender: TObject);
var
  I: Integer;
begin
  I := FindButton(AControl(Sender));
  if (I >= 0) then
  begin
    if Assigned(FButtons[I].OnClick) then
      FButtons[I].OnClick(FButtons[I].Button, Integer(Sender));
  end;
end;

procedure TUI_.CalendarChange(Sender: TObject);
var
  I: Integer;
begin
  I := FindCalendar(AControl(Sender));
  if (I >= 0) then
  begin
    if Assigned(FCalendars[I].OnChange) then
      FCalendars[I].OnChange(FCalendars[I].OnChangeObj, Integer(Sender));
  end;
end;

procedure TUI_.ListBoxClick(Sender: TObject);
var
  I: Integer;
begin
  I := FindListBox(AControl(Sender));
  if (I >= 0) then
  begin
    if Assigned(FListBoxs[I].OnClick) then
      FListBoxs[I].OnClick(AInteger(Sender), 0);
  end;
end;

procedure TUI_.MenuItemClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to High(FMenuItems) do
  begin
    if (FMenuItems[I].MenuItem = Integer(Sender)) then
    begin
      if Assigned(FMenuItems[I].OnClick) then
        FMenuItems[I].OnClick(FMenuItems[I].MenuItem, 0{Integer(Sender)});
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
      if Assigned(FPageControls[I].OnChange) then
        FPageControls[I].OnChange(AControl(FPageControls[I].PageControl), 0);
    end;
  end;
end;

end.
 