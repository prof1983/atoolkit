{**
@Abstract(Контрол вывода лог-сообщений в RichEdit)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.03.2007)
@LastMod(05.07.2012)
@Version(0.5)
}
unit ALogRichEditControl;

interface

uses
  ComCtrls, Graphics,
  ALogGlobals, ALogNodeImpl, ALogUiUtils, ATypes;

type //** Контрол вывода лог-сообщений в RichEdit
  TALogRichEditControl = class(TALogNode)
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
    function AddMsg(const AMsg: WideString): Integer;
    function AddMsgA(const AMsg: WideString; const APrefix: WideString = ''): Integer; safecall;
    {** Добавить строку
      @returns(Возвращает номер добавленой строки или 0)
    }
    function AddStr(const AStr: WideString): Integer;
    {** Добавить лог-сообщение
      @returns(Возвращает номер добавленого лог-сообщения или 0)
    }
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override;
    //** Не используется
    procedure Hide();
    //** Не используется
    procedure Show();
  public
    constructor Create();
  public
    //** RichEdit для вывода лог-сообщений
    property Controller: TRichEdit read FController write FController;
    property Delimer1: WideString read FDelimer1 write FDelimer1;
    property Delimer2: WideString read FDelimer2 write FDelimer2;
  end;

implementation

{ TALogRichEditControl }

function TALogRichEditControl.AddMsg(const AMsg: WideString): Integer;
begin
  if AMsg = '-' then
    Result := AddStr(FDelimer1)
  else if AMsg = '=' then
    Result := AddStr(FDelimer2)
  else
    Result := AddStr(AMsg);
end;

function TALogRichEditControl.AddMsgA(const AMsg, APrefix: WideString): Integer;
begin
  if AMsg = '-' then
    Result := AddStr(APrefix + FDelimer1)
  else if AMsg = '=' then
    Result := AddStr(APrefix + FDelimer2)
  else
    Result := AddStr(APrefix + AMsg);
end;

function TALogRichEditControl.AddStr(const AStr: WideString): Integer;
begin
  if Assigned(FController) then
  try
    Result := FController.Lines.Add(AStr);
  except
  end;
end;

function TALogRichEditControl.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
var
  tmpColor: TColor;
begin
  tmpColor := FController.SelAttributes.Color;
  FController.SelAttributes.Color := GetLogTypeColor(AType);
  Result := AddMsg(AStrMsg);
  FController.SelAttributes.Color := tmpColor;
end;

procedure TALogRichEditControl.AfterConstruction();
begin
  inherited;
  FDelimer1 := '----------------------------------------------------------';
  FDelimer2 := '==========================================================';
end;

constructor TALogRichEditControl.Create();
begin
  inherited Create(nil, '', 0);
end;

procedure TALogRichEditControl.Hide();
begin
end;

procedure TALogRichEditControl.Show();
begin
end;

end.
