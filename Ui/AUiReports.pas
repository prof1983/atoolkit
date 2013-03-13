{**
@Abstract AUiReports
@Author Prof1983 <prof1983@ya.ru>
@Created 10.08.2011
@LastMod 13.03.2013
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
  Graphics,
  ABase,
  AStringMain,
  {$IFDEF USE_REPORTS}fReport, fSimpleReport,{$ENDIF}
  AUiBase, AUiBox, AUiControls, AUiData, AUiTextView;

// --- AUiReport ---

function AUiReport_New(Parent: AControl): AReport; {$ifdef AStdCall}stdcall;{$endif}

function AUiReport_SetText(Report: AReport; const Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiReport_SetTextP(Report: AReport; const Value: APascalString): AError;

// --- AUiReportWin ---

function AUiReportWin_New(): AWindow; {$ifdef AStdCall}stdcall;{$endif}

function AUiReportWin_New2(ReportWinType: AInt; const Text: AString_Type): AWindow; {$ifdef AStdCall}stdcall;{$endif}

function AUiReportWin_New2P(ReportWinType: AInt; const Text: APascalString): AWindow;

function AUiReportWin_ShowReport(const Text: AString_Type; Font: AFont): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiReportWin_ShowReport2A(Text: AStr; Font: AFont; Width, Height: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiReportWin_ShowReport2P(const Text: APascalString; Font: AFont;
    Width, Height: AInt): AError;

function AUiReportWin_ShowReportP(const Text: APascalString; Font: AFont): AError;

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
    Result := AUiReport_SetTextP(Report, AString_ToPascalString(Value));
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

function AUiReportWin_New2(ReportWinType: AInt; const Text: AString_Type): AWindow;
begin
  Result := AUiReportWin_New2P(ReportWinType, AString_ToPascalString(Text));
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

function AUiReportWin_ShowReport(const Text: AString_Type; Font: AFont): AError;
begin
  Result := AUiReportWin_ShowReportP(AString_ToPascalString(Text), Font);
end;

function AUiReportWin_ShowReport2A(Text: AStr; Font: AFont; Width, Height: AInt): AError;
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
      Form.Editor.Lines.Text := AnsiString(Text);
      if (Font <> 0) then
        Form.Editor.Font.Assign(TFont(Font));
      if (Width > 0) then
        Form.Width := Width;
      if (Height > 0) then
        Form.Height := Height;
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

function AUiReportWin_ShowReport2P(const Text: APascalString; Font: AFont;
    Width, Height: AInt): AError;
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
      if (Width > 0) then
        Form.Width := Width;
      if (Height > 0) then
        Form.Height := Height;
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

function AUiReportWin_ShowReportP(const Text: APascalString; Font: AFont): AError;
begin
  Result := AUiReportWin_ShowReport2P(Text, Font, 600, 400);
end;

end.
 