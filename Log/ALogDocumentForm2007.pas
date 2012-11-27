{**
@Abstract Показывать Log в окне
@Author Prof1983 <prof1983@ya.ru>
@Created 22.10.2005
@LastMod 27.11.2012
}
unit ALogDocumentForm2007;

interface

uses
  ComCtrls, XmlIntf,
  AConfigFormUtils, ALogDocumentImpl, ALogFormTree2007, ALogNodeImpl, ATypes;

type //** Показывать Log в окне
  TLogForm = class(TALogDocument)
  private
    FFormLog: TFormLog;
    FConfigFormLog: TConfigForm;
    //procedure SetConfig(Value: TConfigForm);
  public
    function AddMsg(const AMsg: WideString): Integer; override;
    function AddStr(const AStr: WideString): Integer; override;
    function ConfigureLoad2(AConfig: IXmlNode = nil): WordBool; virtual;
    function ConfigureSave2(AConfig: IXmlNode = nil): WordBool; virtual;
    constructor Create(AConfig: IXmlNode = nil);
    function Finalize(): TProfError; override;
    procedure Free(); virtual;
    //** Показать
    procedure Show(); override;
    function NewNode(AType: TLogTypeMessage; const APrefix: WideString; AParent: Integer = 0; AId: Integer = 0): TALogNode; override;
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

function TLogForm.AddMsg(const AMsg: WideString): Integer;
begin
  FFormLog.AddMsg(AMsg);
  Result := 0;
end;

function TLogForm.AddStr(const AStr: WideString): Integer;
begin
  FFormLog.AddStr(AStr);
  Result := 0;
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

function TLogForm.NewNode(AType: TLogTypeMessage; const APrefix: WideString; AParent: Integer = 0; AId: Integer = 0): TALogNode;
var
  Id: Integer;
begin
  Id := GetFreeId;
  FFormLog.AddNode(AType, Id, AParent, APrefix);
  Result := TALogNode.Create2(ALogDocument(Self), AParent, APrefix, Id);
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
