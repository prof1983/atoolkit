{**
@Abstract AUiReports
@Author Prof1983 <prof1983@ya.ru>
@Created 10.08.2011
@LastMod 10.08.2012
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
  Graphics, ABase,
  {$IFDEF USE_REPORTS}fReport, fSimpleReport,{$ENDIF}
  AUiBase;

function UI_ReportWin_New: AWindow;
{** Creates a new window of the report
    @param ReportWinType - Type of the report window: 0-TReportForm; 1-SimpleReport }
function UI_ReportWin_NewA(ReportWinType: AInteger; const Text: APascalString): AWindow;
{** Displays a modal window with the report }
procedure UI_ReportWin_ShowReport(const Text: APascalString; Font: TFont);

implementation

{ ReportWin }

function UI_ReportWin_New: AWindow;
begin
  Result := UI_ReportWin_NewA(0, '');
end;

function UI_ReportWin_NewA(ReportWinType: AInteger; const Text: APascalString): AWindow;
{$IFDEF USE_REPORTS}
var
  ReportForm: TReportForm;
  Form: TSimpleReportForm;
{$ENDIF}
begin
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
end;

procedure UI_ReportWin_ShowReport(const Text: APascalString; Font: TFont);
{$IFDEF USE_REPORTS}
var
  Form: TReportForm;
{$ENDIF}
begin
  {$IFDEF USE_REPORTS}
  Form := TReportForm.Create(nil);
  try
    Form.Editor.Clear;
    Form.Editor.Text := Text;
    if Assigned(Font) then
      Form.Editor.Font.Assign(Font);
    Form.ShowModal;
  finally
    Form.Free;
  end;
  {$ENDIF}
end;

end.
 