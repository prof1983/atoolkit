{**
@Abstract(Контрол вывода лог-сообщений в RichEdit)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.03.2007)
@LastMod(27.06.2012)
@Version(0.5)
}
unit ALogRichEditControl;

interface

uses
  ComCtrls, Graphics,
  ALogGlobals, ALogNodeIntf, ALogUiUtils, ANodeImpl, ATypes;

type //** Контрол вывода лог-сообщений в RichEdit
  TProfLogRichEditControl = class(TProfNode, IProfLogNode)
  private
    FController: TRichEdit;
    FDelimer1: WideString;
    FDelimer2: WideString;
  public
    procedure AfterConstruction(); override;
  public
    {** Добавить сообщение
      @returns(Возвращает номер добавленого сообщения или 0)
    }
    function AddMsg(const AMsg: WideString): Integer; safecall;
    function AddMsgA(const AMsg: WideString; const APrefix: WideString = ''): Integer; safecall;
    {** Добавить строку
      @returns(Возвращает номер добавленой строки или 0)
    }
    function AddStr(const AStr: WideString): Integer; safecall;
    {** Добавить лог-сообщение
      @returns(Возвращает номер добавленого лог-сообщения или 0)
    }
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override; {safecall;}
    //** Не используется
    procedure Hide(); safecall;
    //** Не используется
    procedure Show(); safecall;
  public
    //** RichEdit для вывода лог-сообщений
    property Controller: TRichEdit read FController write FController;
    property Delimer1: WideString read FDelimer1 write FDelimer1;
    property Delimer2: WideString read FDelimer2 write FDelimer2;
  end;
  TProfLogRichEditControl3 = TProfLogRichEditControl;
  TLogRichEditControl = TProfLogRichEditControl;

implementation

{ TProfLogRichEditControl }

function TProfLogRichEditControl.AddMsg(const AMsg: WideString): Integer;
begin
  if AMsg = '-' then
    Result := AddStr(FDelimer1)
  else if AMsg = '=' then
    Result := AddStr(FDelimer2)
  else
    Result := AddStr(AMsg);
end;

function TProfLogRichEditControl.AddMsgA(const AMsg, APrefix: WideString): Integer;
begin
  if AMsg = '-' then
    Result := AddStr(APrefix + FDelimer1)
  else if AMsg = '=' then
    Result := AddStr(APrefix + FDelimer2)
  else
    Result := AddStr(APrefix + AMsg);
end;

function TProfLogRichEditControl.AddStr(const AStr: WideString): Integer;
begin
  if Assigned(FController) then
  try
    Result := FController.Lines.Add(AStr);
  except
  end;
end;

function TProfLogRichEditControl.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
var
  tmpColor: TColor;
begin
  tmpColor := FController.SelAttributes.Color;
  FController.SelAttributes.Color := GetLogTypeColor(AType);
  Result := AddMsg(AStrMsg);
  FController.SelAttributes.Color := tmpColor;
end;

procedure TProfLogRichEditControl.AfterConstruction();
begin
  inherited;
  FDelimer1 := '----------------------------------------------------------';
  FDelimer2 := '==========================================================';
end;

procedure TProfLogRichEditControl.Hide();
begin
end;

procedure TProfLogRichEditControl.Show();
begin
end;

end.
