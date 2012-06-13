{**
@Abstract(Показывать Log в окне)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.10.2005)
@LastMod(13.06.2012)
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
    procedure AddMsg(const AMsg: WideString); override;
    procedure AddStr(const AStr: WideString); override;
    function ConfigureLoad2(AConfig: IXmlNode = nil): WordBool; virtual;
    function ConfigureSave2(AConfig: IXmlNode = nil): WordBool; virtual;
    constructor Create(AConfig: IXmlNode = nil);
    function Finalize(): TProfError; override;
    procedure Free(); virtual;
    //** Показать
    procedure Show(); override;
    function NewNode(AType: TLogTypeMessage; const APrefix: WideString; AParent: Integer = 0; AId: Integer = 0): TALogNode2; override;
    //** Скрыть
    procedure Hide(); override;
    //** Добавить сообщение
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; override;
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override;
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer; override;
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
  if Assigned(FConfigFormLog) then
    Result := FConfigFormLog.ConfigureLoad()
  else
    Result := False;
end;

function TLogForm.ConfigureSave2(AConfig: IXmlNode = nil): WordBool;
begin
  if Assigned(FConfigFormLog) then
    Result := FConfigFormLog.ConfigureSave()
  else
    Result := False;
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
  Result := TALogNode2.Create(ALogDocument2(Self), AParent, APrefix, Id);
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
