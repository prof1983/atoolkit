{**
@Abstract(Работа с Log. Классы для отображения собщений программы окне в виде дерева)
@Author(Prof1983 prof1983@ya.ru)
@Created(19.10.2006)
@LastMod(03.07.2012)
@Version(0.5)

Работа с Log. Классы для записи собщений программы в БД или файл или
отображения в окне Log
TLogNode - нод логирования - элемент дерева логирования
Delphi 5, 7, 2005
}
unit ALogTreeView;

interface

uses
  ComCtrls, SysUtils,
  ALogDocumentImpl, ATypes;

type
  TLogTreeView = class(TALogDocument)
  private
    FTreeView: TTreeView;
  public
    procedure AddMsg(const Msg: WideString); override;
    procedure AddStr(const Str: WideString); override;
    function AddToLog2(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Boolean; override;
    constructor Create(ATreeView: TTreeView; const AName: WideString = '');
    function ToLogA(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override;
    function ToLogE(LogGroup: EnumGroupMessage; LogType: EnumTypeMessage;
        const StrMsg: WideString): Integer; override;
  end;

implementation

{ TLogTreeView }

procedure TLogTreeView.AddMsg(const Msg: WideString);
begin
  ToLogA(lgNone, ltNone, Msg);
end;

procedure TLogTreeView.AddStr(const Str: WideString);
begin
  ToLogA(lgNone, ltNone, Str);
end;

function TLogTreeView.AddToLog2(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const AStrMsg: string; AParams: array of const): Boolean;
begin
  Result := (ToLogA(LogGroup, LogType, Format(AStrMsg, AParams)) >= 0);
end;

constructor TLogTreeView.Create(ATreeView: TTreeView; const AName: WideString = '');
begin
  inherited Create(lTreeView, AName);
  FTreeView := ATreeView;
end;

function TLogTreeView.ToLogA(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  Result := 0;
  if Assigned(FTreeView) then
  begin
    FTreeView.Items.AddChild(nil, AStrMsg);
    Result := 1;
  end;
end;

function TLogTreeView.ToLogE(LogGroup: EnumGroupMessage; LogType: EnumTypeMessage;
    const StrMsg: WideString): Integer;
begin
  Result := ToLogA(lgNone, ltNone, StrMsg);
end;

end.
