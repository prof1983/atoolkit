{**
@Abstract AUiReports
@Author Prof1983 <prof1983@ya.ru>
@Created 10.08.2011
@LastMod 13.12.2012
}
unit AUiReports;

{$I Defines.inc}

{$IFNDEF FPC}
  {$IFNDEF NoUiReports}
    {$DEFINE USE_REPORTS}
  {$ENDIF}
{$ENDIF}

interface

uses
  Graphics, ABase, AStrings,
  {$IFDEF USE_REPORTS}fReport, fSimpleReport,{$ENDIF}
  AUiBase, AUiBox, AUiControls, AUiData, AUiTextView;

// --- AUiReport ---

function AUiReport_New(Parent: AControl): AReport; {$ifdef AStdCall}stdcall;{$endif}

function AUiReport_SetText(Report: AReport; const Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiReport_SetTextP(Report: AReport; const Value: APascalString): AError; {$ifdef AStdCall}stdcall;{$endif}

// --- AUiReportWin ---

function AUiReportWin_New(): AWindow; {$ifdef AStdCall}stdcall;{$endif}

function AUiReportWin_New2P(ReportWinType: AInt; const Text: APascalString): AWindow; {$ifdef AStdCall}stdcall;{$endif}

function AUiReportWin_ShowReportP(const Text: APascalString; Font: AFont): AError; {$ifdef AStdCall}stdcall;{$endif}

// --- AUi_Report ---

function AUi_Report_New(Parent: AControl): AReport; stdcall; deprecated; // Use AUiReport_New()

procedure AUi_Report_SetText(Report: AReport; const Value: AString_Type); stdcall; deprecated; // Use AUiReport_SetText()

// --- UI_Report ---

function UI_Report_New(Parent: AControl): AReport; deprecated; // Use AUiReport_New()

procedure UI_Report_SetText(Report: AReport; const Value: APascalString); stdcall; deprecated; // Use AUiReport_SetText()

// --- UI_ReportWin ---

function UI_ReportWin_New(): AWindow; deprecated; // Use AUiReportWin_New()

{** Creates a new window of the report
    @param ReportWinType - Type of the report window: 0-TReportForm; 1-SimpleReport }
function UI_ReportWin_NewA(ReportWinType: AInteger; const Text: APascalString): AWindow; deprecated; // Use AUiReportWin_New2P()

{** Displays a modal window with the report }
procedure UI_ReportWin_ShowReport(const Text: APascalString; Font: TFont); deprecated; // Use AUiReportWin_ShowReportP()

implementation

// --- AUiReport ---

function AUiReport_New(Parent: AControl): AReport;
var
  I: Integer;
begin
  try
    I := Length(FReports);
    SetLength(FReports, I + 1);
    Result := I+1;
    FReports[I].Parent := Parent;
    FReports[I].ToolsPanel := AUiBox_New(Parent, 0);
    AUiControl_SetSize(FReports[I].ToolsPanel, 100, 25);
    AUiControl_SetAlign(FReports[I].ToolsPanel, uiAlignTop);
    FReports[I].TextView := AUiTextView_New(Parent, 1);
    AUiControl_SetAlign(FReports[I].TextView, uiAlignClient);
    AUiTextView_SetScrollBars(FReports[I].TextView, AUiScrollStyle_Both);
    AUiTextView_SetFontP(FReports[I].TextView, 'Courier New', 10);
    AUiTextView_SetReadOnly(FReports[I].TextView, True);
  except
    Result := 0;
  end;
end;

function AUiReport_SetText(Report: AReport; const Value: AString_Type): AError;
begin
  try
    Result := AUiReport_SetTextP(Report, AStrings.String_ToWideString(Value));
  except
    Result := -1;
  end;
end;

function AUiReport_SetTextP(Report: AReport; const Value: APascalString): AError;
begin
  try
    Result := AUiControl_SetTextP(FReports[Report-1].TextView, Value);
  except
    Result := -1;
  end;
end;

// --- AUiReportWin ---

function AUiReportWin_New(): AWindow;
begin
  try
    Result := AUiReportWin_New2P(0, '');
  except
    Result := 0;
  end;
end;

function AUiReportWin_New2P(ReportWinType: AInt; const Text: APascalString): AWindow;
{$IFDEF USE_REPORTS}
var
  ReportForm: TReportForm;
  Form: TSimpleReportForm;
{$ENDIF}
begin
  try
    if (ReportWinType = 0) then
    begin
      {$IFDEF USE_REPORTS}
      ReportForm := TReportForm.Create(nil);
      ReportForm.Editor.Text := Text;
      Result := AWindow(ReportForm);
      {$ELSE}
      Result := 0;
      {$ENDIF}
    end
    else if (ReportWinType = 1) then
    begin
      {$IFDEF USE_REPORTS}
      Form := TSimpleReportForm.Create(nil);
      Form.Memo.Lines.Text := Text;
      Result := AWindow(Form);
      {$ELSE}
      Result := 0;
      {$ENDIF}
    end
    else
      Result := 0;
  except
    Result := 0;
  end;
end;

function AUiReportWin_ShowReportP(const Text: APascalString; Font: AFont): AError;
{$IFDEF USE_REPORTS}
var
  Form: TReportForm;
{$ENDIF}
begin
  try
    {$IFDEF USE_REPORTS}
    Form := TReportForm.Create(nil);
    try
      Form.Editor.Clear();
      Form.Editor.Text := Text;
      if (Font <> 0) then
        Form.Editor.Font.Assign(TFont(Font));
      Form.ShowModal();
    finally
      Form.Free();
    end;
    {$ENDIF}
    Result := 0;
  except
    Result := -1;
  end;
end;

// --- AUi_Report ---

function AUi_Report_New(Parent: AControl): AReport;
begin
  Result := AUiReport_New(Parent);
end;

procedure AUi_Report_SetText(Report: AReport; const Value: AString_Type);
begin
  AUiReport_SetText(Report, Value);
end;

// --- UI_Report ---

function UI_Report_New(Parent: AControl): AReport;
begin
  Result := AUiReport_New(Parent);
end;

procedure UI_Report_SetText(Report: AReport; const Value: APascalString);
begin
  AUiReport_SetTextP(Report, Value);
end;

// --- UI_ReportWin ---

function UI_ReportWin_New(): AWindow;
begin
  Result := AUiReportWin_New();
end;

function UI_ReportWin_NewA(ReportWinType: AInteger; const Text: APascalString): AWindow;
begin
  Result := AUiReportWin_New2P(ReportWinType, Text);
end;

procedure UI_ReportWin_ShowReport(const Text: APascalString; Font: TFont);
begin
  AUiReportWin_ShowReportP(Text, AFont(Font));
end;

end.
 