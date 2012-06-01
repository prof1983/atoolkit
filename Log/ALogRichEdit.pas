{**
@Abstract(Лог-журнал для вывода лог-сообщений в RichEdit)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.06.2007)
@LastMod(25.04.2012)
@Version(0.5)

История версий
0.0.1.0 - 06.07.2007 - AIRichEditLog -> RichEditLog
0.0.0.3 - 03.07.2007
0.0.0.2 - 24.06.2007
0.0.0.1 - 23.06.2007
}
unit ALogRichEdit;

interface

uses
  ComCtrls, Graphics,
  ALogJournal;

type //** @abstract(Лог-журнал для вывода лог-сообщений в RichEdit)
  TRichEditLog = class(TLogJournal)
  private
    //** Компонент для вывода сообщений
    FRichEdit: TRichEdit;
  public
    //** Функция добавления лог-сообщения
    function AddToLog(Msg: WideString): Integer; override;
  public
    //** Компонент для вывода сообщений
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
