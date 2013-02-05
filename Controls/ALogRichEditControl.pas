{**
@Author Prof1983 <prof1983@ya.ru>
@Created 07.03.2007
@LastMod 05.02.2012
}
unit ALogRichEditControl;

interface

uses
  ComCtrls, Graphics,
  ALogGlobals, ALogNodeImpl, ALogUiUtils, ATypes;

type
  TALogRichEditControl = class(TALogNode)
  private
    FController: TRichEdit;
    FDelimer1: WideString;
    FDelimer2: WideString;
  public
    procedure AfterConstruction(); override;
  public
    {** Add string
        @return String num or 0 }
    function AddMsg(const AMsg: WideString): Integer;
    function AddMsgA(const AMsg: WideString; const APrefix: WideString = ''): Integer; safecall;
    {** Add string
        @return String num or 0 }
    function AddStr(const AStr: WideString): Integer;
    {** Add mesage to log
        @return Log message num or 0 }
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override;
  public
    constructor Create();
  public
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

end.
