{**
@Abstract(Диалоговые окна с ожиданием)
@Author(Prof1983 prof1983@ya.ru)
@Created(18.05.2006)
@LastMod(10.05.2012)
@Version(0.5)

После истечения указаного времени окно закрывается
Увеличение счетчика времени сделано по таймеру для того, чтобы
в случае тормозов программы окошко показывалось дольше
}
unit ADialogs;

interface

uses
  Classes, Controls, Dialogs, ExtCtrls, Forms, Graphics, Messages, StdCtrls, SysUtils, Windows,
  fDialog;

type
  TfmWaitDialog = class(TfmDialogMemo)
  private
    FElapsedTime: Integer;
    FWaitTime: Integer;
    function GetWaitTime(): Integer;
    procedure SetWaitTime(Value: Integer);
    procedure tmMainTimer(Sender: TObject);
  protected
    tmMain: TTimer;
    procedure DoCancel(); override;
    procedure DoCreate(); override;
    procedure DoDestroy(); override;
    procedure DoOK(); override;
    procedure DoShow(); override;
  public
    property ElapsedTime: Integer read FElapsedTime write FElapsedTime;
    property WaitTime: Integer read GetWaitTime write SetWaitTime;
  end;

// Закрывает окно диалога
procedure DoneWaitDialog();

// Возвращает True, если окно открыто
function IsRunWaitDialog(): Boolean;

{ Показвает стандартное окно об ошибке
  AWindow:   хендл родительского окна или 0
  ACaption:  заголовок окна
  AMsgText:  текст сообщения
  AParam:    параметры для форматирования текста сообщения (функция Format) }
function ShowErrorWait(AWindow: THandle; const ACaption, AMsgText: WideString; const AParam: array of const; AWaitTime: Integer = 10000; AModal: Boolean = True): Integer;

{ Показвает стандартное окно информации
  AWindow:   хендл родительского окна или 0
  ACaption:  заголовок окна
  AText:     текст сообщения }
function ShowInfo(AWindow: THandle; const ACaption, AText: WideString; AModal: WordBool = True): Integer;

{ Показвает стандартное окно информации
  AWindow:   хендл родительского окна или 0
  ACaption:  заголовок окна
  AMsgText:  текст сообщения
  AParam:    параметры для форматирования текста сообщения (функция Format) }
function ShowInfoWait(AWindow: THandle; const ACaption, AMsgText: WideString; const AParam: array of const; AWaitTime: Integer = 10000; AModal: Boolean = True): Integer;

{ Показвает стандартное окно с кнопками ДА/НЕТ
  AWindow:   хендл родительского окна или 0
  ACaption:  заголовок окна
  AMsgText:  текст сообщения
  AParam:    параметры для форматирования текста сообщения (функция Format)
  Result:    True если пользователь ответил ДА }
function ShowQueryYesNoWait(AWindow: THandle; const ACaption, AMsgText: WideString; const AParam: array of const; AWaitTime: Integer = 10000; AModal: Boolean = True): boolean;

{ Показвает стандартное окно предупреждение
  AWindow:   хендл родительского окна или 0
  ACaption:  заголовок окна
  AMsgText:  текст сообщения
  AParam:    параметры для форматирования текста сообщения (функция Format) }
function ShowWarningWait(AWindow: THandle; const ACaption, AMsgText: WideString; const AParam: array of const; AWaitTime: Integer = 10000; AModal: Boolean = True): Integer;

implementation

var
  fmWaitDialog: TfmWaitDialog;

// --- Public ---

procedure DoneWaitDialog();
begin
  if Assigned(fmWaitDialog) then
  try
    fmWaitDialog.Free();
  finally
    fmWaitDialog := nil;
  end;
end;

function IsRunWaitDialog(): Boolean;
begin
  Result := Assigned(fmWaitDialog);
  Application.ProcessMessages();
end;

function ShowErrorWait(AWindow: THandle; const ACaption, AMsgText: WideString; const AParam: array of const; AWaitTime: Integer = 10000; AModal: Boolean = True): Integer;
var
  fm: TfmWaitDialog;
begin
  fm := TfmWaitDialog.CreateParented(AWindow);
  try
    fm.Caption := ACaption;
    fm.mmMsg.Color := $000080; //clRed
    fm.mmMsg.Text := Format(AMsgText, AParam);
    fm.WaitTime := AWaitTime;
    if AModal then
      Result := fm.ShowModal()
    else
    begin
      fm.Show();
      Result := 0;
    end;
  finally
    DoneWaitDialog();
  end;
end;

function ShowInfo(AWindow: THandle; const ACaption, AText: WideString; AModal: WordBool = True): Integer;
var
  fm: TfmWaitDialog;
begin
  fm := TfmWaitDialog.CreateParented(AWindow);
  try
    fm.Caption := ACaption;
    fm.mmMsg.Color := $008000; // clGreen //clWindow;
    fm.mmMsg.Text := AText; //Format(AMsgText, AParam);
    fm.mmMsg.Font.Name := 'Courier New';
    fm.WaitTime := 100000; //AWaitTime;
    if AModal then
      Result := fm.ShowModal()
    else
    begin
      fm.Show();
      Result := 0;
    end;
  finally
    fm.Free();
  end;
end;

function ShowInfoWait(AWindow: THandle; const ACaption, AMsgText: WideString; const AParam: array of const; AWaitTime: Integer = 10000; AModal: Boolean = True): Integer;
var
  fm: TfmWaitDialog;
begin
  fm := TfmWaitDialog.CreateParented(AWindow);
  try
    fm.Caption := ACaption;
    fm.mmMsg.Color := $008000; // clGreen //clWindow;
    fm.mmMsg.Text := Format(AMsgText, AParam);
    fm.WaitTime := AWaitTime;
    if AModal then
      Result := fm.ShowModal()
    else
    begin
      fm.Show();
      Result := 0;
    end;
  finally
    fm.Free();
  end;
end;

function ShowQueryYesNoWait(AWindow: THandle; const ACaption, AMsgText: WideString; const AParam: array of const; AWaitTime: Integer = 10000; AModal: Boolean = True): boolean;
var
  fm: TfmWaitDialog;
begin
  Result := True;
  fm := TfmWaitDialog.CreateParented(AWindow);
  try
    fm.Caption := ACaption;
    fm.mmMsg.Text := Format(AMsgText, AParam);
    fm.WaitTime := AWaitTime;
    if AModal then
      Result := (fm.ShowModal() = mrOk)
    else
      fm.Show();
    //Result := (fm.ShowModal() = mrOk);
  finally
    if AModal then
      DoneWaitDialog();
  end;
end;

function ShowWarningWait(AWindow: THandle; const ACaption, AMsgText: WideString; const AParam: array of const; AWaitTime: Integer = 10000; AModal: Boolean = True): Integer;
var
  fm: TfmWaitDialog;
begin
  fm := TfmWaitDialog.CreateParented(AWindow);
  try
    fm.Caption := ACaption;
    fm.mmMsg.Color := $008080; // clYellow;
    fm.mmMsg.Text := Format(AMsgText, AParam);
    fm.WaitTime := AWaitTime;
    if AModal then
      Result := fm.ShowModal()
    else
    begin
      fm.Show();
      Result := 0;
    end;
  finally
    DoneWaitDialog();
  end;
end;

{ TfmWaitDialog }

procedure TfmWaitDialog.DoCancel();
begin
  if not(fsModal in FormState) then
  begin
    tmMain.Enabled := False;
    DoneWaitDialog();
  end;
end;

procedure TfmWaitDialog.DoCreate();
begin
  inherited DoCreate();
  tmMain := TTimer.Create(Self);
  tmMain.Interval := 3000;
  tmMain.Enabled := False;
  tmMain.OnTimer := tmMainTimer;

  fmWaitDialog := Self;
end;

procedure TfmWaitDialog.DoDestroy();
begin
  fmWaitDialog := nil;
end;

procedure TfmWaitDialog.DoOk();
begin
  if not(fsModal in FormState) then
  begin
    tmMain.Enabled := False;
    DoneWaitDialog();
  end;
end;

procedure TfmWaitDialog.DoShow();
begin
  FElapsedTime := 0;
  tmMain.Enabled := True;
end;

function TfmWaitDialog.GetWaitTime(): Integer;
begin
  Result := FWaitTime;
end;

procedure TfmWaitDialog.SetWaitTime(Value: Integer);
begin
  FWaitTime := Value;
end;

procedure TfmWaitDialog.tmMainTimer(Sender: TObject);
begin
  FElapsedTime := FElapsedTime + Integer(tmMain.Interval);
  if FElapsedTime > FWaitTime then
  begin
    tmMain.Enabled := False;
    if (fsModal in FormState) then
      ModalResult := mrOk
    else
      DoneWaitDialog();
  end
  else
    btOk.Caption := 'Ok ('+IntToStr((FWaitTime - FElapsedTime) div 1000) + ')';
end;

end.
