{**
@Abstract(Первая форма при запуске системы)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.08.2007)
@LastMod(10.07.2012)
@Version(0.5)

При создании формы создается таймер, который проверяет
прорисовку окна с заданной периодичностью.
Если окно прорисовалось, то таймер уничтожается, происходит запуск
события OnStartTime.
После выполнения события OnStartTime стартовая форма закрывается после
заданного периода ожидания.

История изменений:
0.0.2.3 - 25.08.2007 - StayOnTop
0.0.2.2 - 21.08.2007
0.0.2.1 - 15.08.2007
0.0.2.0 - 14.08.2007 - Переименован fMain -> fStart
}
unit AUiSplashForm;

interface

uses
  Classes, ComCtrls, Controls, Dialogs, ExtCtrls, Graphics, Forms, IniFiles,
  StdCtrls, SysUtils;

type
  TStartForm = class(TForm)
    LogRichEdit: TRichEdit;
    Panel1: TPanel;
    Image1: TImage;
    procedure FormPaint(Sender: TObject);
  private
    FIsPainted: Boolean;
    FOnStartTime: TNotifyEvent;
    FTimer: TTimer;
    procedure DoTimer(Sender: TObject);
  public
    procedure DoCreate(); override;
    procedure DoDestroy(); override;
    class function AddToLog(Msg: WideString): Integer;
    property OnStartTime: TNotifyEvent read FOnStartTime write FOnStartTime;
  end;

implementation

{$R *.dfm}

var
  StartForm: TStartForm;

{ TStartForm }

class function TStartForm.AddToLog(Msg: WideString): Integer;
begin
  Result := 0;
  if Assigned(StartForm) then
  try
    Result := StartForm.LogRichEdit.Lines.Add(Msg);
  except
  end;
  Application.ProcessMessages();
end;

procedure TStartForm.DoCreate();
begin
  StartForm := Self;

  Panel1.Top := 2;
  Panel1.Left := 2;
  Panel1.Width := Width - 4;

  LogRichEdit.Top := Panel1.Height + 4;
  LogRichEdit.Left := 2;
  LogRichEdit.Width := Width - 4;
  LogRichEdit.Height := Height - LogRichEdit.Top - 2;

  FTimer := TTimer.Create(Self);
  FTimer.Interval := 100;
  FTimer.OnTimer := DoTimer;
  FTimer.Enabled := True;
end;

procedure TStartForm.DoDestroy();
begin
  StartForm := nil;
  inherited;
end;

procedure TStartForm.DoTimer(Sender: TObject);
var
  FStartLoad: TDateTime;
begin
  if FIsPainted then
  begin
    FTimer.Enabled := False;
    FTimer.Free();
    FTimer := nil;

    FStartLoad := Now();

    if Assigned(FOnStartTime) then
    try
      FOnStartTime(Self);
    except
    end;

    while (Now() - FStartLoad < 1/24/60/60) do
    begin
      Application.ProcessMessages();
      Sleep(50);
    end;

    Hide();
  end;
end;

procedure TStartForm.FormPaint(Sender: TObject);
begin
  FIsPainted := True;
end;

end.
