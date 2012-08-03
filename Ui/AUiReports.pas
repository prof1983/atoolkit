{**
@Abstract AUiReports
@Author Prof1983 <prof1983@ya.ru>
@Created 10.08.2011
@LastMod 26.07.2012
}
unit AUiReports;

interface

uses
  Graphics, ABase, AUiBase{$IFNDEF FPC}, fReport, fSimpleReport{$ENDIF};

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
{$IFNDEF FPC}
var
  ReportForm: TReportForm;
  Form: TSimpleReportForm;
{$ENDIF}
begin
  if (ReportWinType = 0) then
  begin
    {$IFDEF FPC}
    Result := 0;
    {$ELSE}
    ReportForm := TReportForm.Create(nil);
    ReportForm.Editor.Text := Text;
    Result := AWindow(ReportForm);
    {$ENDIF}
  end
  else if (ReportWinType = 1) then
  begin
    {$IFDEF FPC}
    Result := 0;
    {$ELSE}
    Form := TSimpleReportForm.Create(nil);
    Form.Memo.Lines.Text := Text;
    Result := AWindow(Form);
    {$ENDIF}
  end
  else
    Result := 0;
end;

{function UI_ReportWin_Simple_New: AWindow;
begin
  Result := UI_ReportWin_NewA(1);
end;}

{$IFNDEF FPC}
procedure UI_ReportWin_ShowReport(const Text: APascalString; Font: TFont);
var
  Form: TReportForm;
begin
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
end;
{$ENDIF}

end.
 