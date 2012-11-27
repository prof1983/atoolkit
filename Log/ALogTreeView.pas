{**
@Abstract Работа с Log. Классы для отображения собщений программы окне в виде дерева
@Author Prof1983 <prof1983@ya.ru>
@Created 19.10.2006
@LastMod 27.11.2012

Работа с Log. Классы для записи собщений программы в БД или файл или отображения в окне Log
}
unit ALogTreeView;

interface

uses
  ComCtrls, SysUtils,
  ABase, ALogDocumentImpl, ATypes;

type
  TLogTreeView = class(TALogDocument)
  private
    FTreeView: TTreeView;
  public
    function AddMsg(const Msg: WideString): AInt; override;
    function AddStr(const Str: WideString): AInt; override;
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: WideString): AInteger; override;
  public
    constructor Create(ATreeView: TTreeView; const AName: WideString = '');
  end;

implementation

{ TLogTreeView }

function TLogTreeView.AddMsg(const Msg: WideString): AInt;
begin
  AddToLog(lgNone, ltNone, Msg);
end;

function TLogTreeView.AddStr(const Str: WideString): AInt;
begin
  AddToLog(lgNone, ltNone, Str);
end;

function TLogTreeView.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
  const StrMsg: WideString): AInteger;
begin
  Result := 0;
  if Assigned(FTreeView) then
  begin
    FTreeView.Items.AddChild(nil, StrMsg);
    Result := 1;
  end;
end;

constructor TLogTreeView.Create(ATreeView: TTreeView; const AName: WideString = '');
begin
  inherited Create(lTreeView, AName);
  FTreeView := ATreeView;
end;

end.
