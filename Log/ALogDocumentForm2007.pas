{**
@Abstract(Показывать Log в окне)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.10.2005)
@LastMod(27.04.2012)
@Version(0.5)
}
unit ALogDocumentForm2007;

interface

uses
  ComCtrls, XmlIntf,
  AConfigForm2006, ALogDocumentImpl, ALogFormTree2007, ALogNodeImpl, ATypes;

type //** Показывать Log в окне
  TLogForm = class(TLogDocumentA1)
  private
    FFormLog: TFormLog;
    FConfigFormLog: TConfigForm;
    //procedure SetConfig(Value: TConfigForm);
  public
    procedure AddMsg(const AMsg: WideString); override; safecall;
    procedure AddStr(const AStr: WideString); override; safecall;
    function ConfigureLoad2(AConfig: IXmlNode = nil): WordBool; override; safecall;
    function ConfigureSave2(AConfig: IXmlNode = nil): WordBool; override; safecall;
    constructor Create(AConfig: IXmlNode = nil);
    function Finalize(): TProfError; override;
    procedure Free(); override;
    //** Показать
    procedure Show(); override; safecall;
    function NewNode(AType: TLogTypeMessage; const APrefix: WideString; AParent: Integer = 0; AId: Integer = 0): TALogNode2; override;
    //** Скрыть
    procedure Hide(); override; safecall;
    //** Добавить сообщение
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; override;
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override; safecall;
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer; override; safecall;
  public
    property FormLog: TFormLog read FFormLog write FFormLog;
  end;

implementation

{ TLogForm }

procedure TLogForm.AddMsg(const AMsg: WideString);
begin
  FFormLog.AddMsg(AMsg);
end;

procedure TLogForm.AddStr(const AStr: WideString);
begin
  FFormLog.AddStr(AStr);
end;

function TLogForm.ConfigureLoad2(AConfig: IXmlNode = nil): WordBool;
begin
  Result := inherited ConfigureLoad2(AConfig);
  if Assigned(FConfigFormLog) then
    FConfigFormLog.ConfigureLoad();
end;

function TLogForm.ConfigureSave2(AConfig: IXmlNode = nil): WordBool;
begin
  Result := inherited ConfigureSave2(AConfig);
  if Assigned(FConfigFormLog) then
    FConfigFormLog.ConfigureSave();
end;

constructor TLogForm.Create(AConfig: IXmlNode);
begin
  inherited Create(lWindow);
  FFormLog := TFormLog.Create(nil);

  if Assigned(AConfig) then
  begin
    FConfigFormLog := TConfigForm.Create(nil{AConfig}, FFormLog);
  end;
end;

function TLogForm.Finalize(): TProfError;
begin
  Result := inherited Finalize();
  FFormLog.Hide();
end;

procedure TLogForm.Free();
begin
  //FFormLog.Finalize;
  if Assigned(FFormLog) then
  try
    FFormLog.Free();
    FFormLog := nil;
  except
  end;
  inherited Free();
end;

procedure TLogForm.Hide();
begin
  if Assigned(FFormLog) then FFormLog.Hide();
end;

function TLogForm.NewNode(AType: TLogTypeMessage; const APrefix: WideString; AParent: Integer = 0; AId: Integer = 0): TALogNode2;
var
  Id: Integer;
begin
  Id := GetFreeId;
  FFormLog.AddNode(AType, Id, AParent, APrefix);
  Result := TALogNode2.Create(Self, AParent, APrefix, Id);
  AddNode(Result);
end;

procedure TLogForm.Show();
begin
  if Assigned(FFormLog) then FFormLog.Show();
end;

function TLogForm.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := FFormLog.ToLog(AGroup, AType, AStrMsg, AParams);
end;

function TLogForm.ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  Result := FFormLog.ToLogA(AGroup, AType, AStrMsg);
end;

function TLogForm.ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  Result := FFormLog.ToLogE(AGroup, AType, AStrMsg);
end;

end.
