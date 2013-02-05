{**
@Author Prof1983 <prof1983@ya.ru>
@Created 23.06.2007
@LastMod 05.02.2013
}
unit ALogRichEdit;

interface

uses
  ComCtrls, Graphics,
  ALogJournal;

type
  TRichEditLog = class(TLogJournal)
  private
    FRichEdit: TRichEdit;
  public
    function AddToLog(Msg: WideString): Integer; override;
  public
    property RichEdit: TRichEdit read FRichEdit write FRichEdit;
  end;

implementation

{ TRichEditLog }

const
  INFORMATION = '#information';
  WARNING = '#warning';
  ERROR = '#error';

function TRichEditLog.AddToLog(Msg: WideString): Integer;
var
  tmp: string;
begin
  Result := 0;
  if Length(Msg) = 0 then Exit;

  tmp := Msg;
  if tmp[1] = '#' then
  begin
    if Copy(tmp, 1, Length(INFORMATION)) = INFORMATION then
    begin
      FRichEdit.Font.Color := clGreen;
      Delete(tmp, 1, Length(INFORMATION) + 1);
    end
    else if Copy(Msg, 1, Length(WARNING)) = WARNING then
    begin
      FRichEdit.Font.Color := clBlue;
      Delete(tmp, 1, Length(WARNING) + 1);
    end
    else if Copy(Msg, 1, Length(ERROR)) = ERROR then
    begin
      FRichEdit.Font.Color := clRed;
      Delete(tmp, 1, Length(ERROR) + 1);
    end;
  end;

  try
    Result := FRichEdit.Lines.Add(tmp);
  except
  end;
end;

end.
