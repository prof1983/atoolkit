{**
@Abstract AUi filter dialog win
@Author Prof1983 <prof1983@ya.ru>
@Created 30.01.2013
@LastMod 01.02.2013
}
unit AUiFilterDialog;

{define AStdCall}

interface

uses
  ComCtrls,
  Controls,
  ExtCtrls,
  Graphics,
  ABase,
  AUiControls,
  AUiBase,
  AUiLabels,
  AUiListBox,
  AUiTextView,
  AUiWindows;

function AUi_ExecuteDateFilterDialog(var Group: AInt; var DateBegin,
    DateEnd: TDateTime): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

implementation

type
  TFilterForm = class
    Window: AWindow;
    InfoMemo: AControl;
    RadioGroup: AControl;
    Label1: AControl;
    Label2: AControl;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    procedure RadioGroup1Click(Sender: TObject);
  end;

{ TFilterForm }

procedure TFilterForm.RadioGroup1Click(Sender: TObject);
begin
  if (AUiListBox_GetItemIndex(RadioGroup) = 3) then
  begin
    DateTimePicker1.Enabled := True;
    DateTimePicker2.Enabled := True;
  end
  else
  begin
    DateTimePicker1.Enabled := False;
    DateTimePicker2.Enabled := False;
  end
end;

function _CreateFilterForm(Window: AWindow): TFilterForm;
var
  FilterForm: TFilterForm;
begin
  FilterForm := TFilterForm.Create();
  AUiControl_SetClientSize(FilterForm.Window, 350, 156);
  AUiControl_SetPosition(FilterForm.Window, 200, 100);
  AUiControl_SetTextP(FilterForm.Window, 'Выбор диапазона фильтрации записей');

  FilterForm.Label1 := AUiLabel_New(FilterForm.Window);
  AUiControl_SetPosition(FilterForm.Label1, 176, 64);
  AUiControl_SetTextP(FilterForm.Label1, 'с');

  FilterForm.Label2 := AUiLabel_New(FilterForm.Window);
  AUiControl_SetPosition(FilterForm.Label2, 176, 88);
  AUiControl_SetTextP(FilterForm.Label2, 'по');

  FilterForm.InfoMemo := AUiTextView_New(FilterForm.Window, 0);
  AUiControl_SetPosition(FilterForm.InfoMemo, 0, 0);
  AUiControl_SetAlign(FilterForm.InfoMemo, uiAlignTop);
  AUiControl_SetColor(FilterForm.InfoMemo, clScrollBar);
  AUiTextView_AddLineP(FilterForm.InfoMemo, 'Выберите диапазон отображения записей.');
  AUiTextView_SetReadOnly(FilterForm.InfoMemo, True);

  FilterForm.RadioGroup := AUiListBox_New2(FilterForm.Window, 1);
  AUiControl_SetPosition(FilterForm.RadioGroup, 8, 48);
  AUiControl_SetSize(FilterForm.RadioGroup, 153, 89);
  AUiControl_SetTextP(FilterForm.RadioGroup, 'Показать записи');
  AUiListBox_AddP(FilterForm.RadioGroup, 'все');
  AUiListBox_AddP(FilterForm.RadioGroup, 'за год');
  AUiListBox_AddP(FilterForm.RadioGroup, 'за месяц');
  AUiListBox_AddP(FilterForm.RadioGroup, 'произвольно');
  AUiListBox_SetItemIndex(FilterForm.RadioGroup, 0);
  TRadioGroup(FilterForm.RadioGroup).OnClick := FilterForm.RadioGroup1Click;

  FilterForm.DateTimePicker1 := TDateTimePicker.Create(nil);
  FilterForm.DateTimePicker1.Parent := TWinControl(FilterForm.Window);
  FilterForm.DateTimePicker1.Left := 192;
  FilterForm.DateTimePicker1.Top := 56;
  FilterForm.DateTimePicker1.Width := 97;
  FilterForm.DateTimePicker1.Height := 21;
  FilterForm.DateTimePicker1.Date := 0;
  FilterForm.DateTimePicker1.Time := 0;
  FilterForm.DateTimePicker1.Enabled := False;

  FilterForm.DateTimePicker2 := TDateTimePicker.Create(nil);
  FilterForm.DateTimePicker2.Parent := TWinControl(FilterForm.Window);
  FilterForm.DateTimePicker2.Left := 192;
  FilterForm.DateTimePicker2.Top := 80;
  FilterForm.DateTimePicker2.Width := 97;
  FilterForm.DateTimePicker2.Height := 21;
  FilterForm.DateTimePicker2.Date := 0;
  FilterForm.DateTimePicker2.Time := 0;
  FilterForm.DateTimePicker2.Enabled := False;

  Result := FilterForm;
end;

// --- AUi ---

function AUi_ExecuteDateFilterDialog(var Group: AInt; var DateBegin, DateEnd: TDateTime): ABoolean;
{$IFNDEF FPC}
var
  FilterForm: TFilterForm;
{$ENDIF}
begin
  try
    {$IFNDEF FPC}
    FilterForm := TFilterForm.Create();
    try
      AUiListBox_SetItemIndex(FilterForm.RadioGroup, Group);
      FilterForm.DateTimePicker1.DateTime := DateBegin;
      FilterForm.DateTimePicker2.DateTime := DateEnd;
      Result := AUiWindow_ShowModal(FilterForm.Window);
      if Result then
      begin
        Group := AUiListBox_GetItemIndex(FilterForm.RadioGroup);
        DateBegin := FilterForm.DateTimePicker1.DateTime;
        DateEnd := FilterForm.DateTimePicker2.DateTime;
      end;
    finally
      FilterForm.Free();
    end;
    {$ENDIF}
  except
    Result := False;
  end;
end;

end.
