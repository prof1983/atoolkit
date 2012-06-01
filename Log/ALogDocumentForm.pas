{**
@Abstract(Показывать Log в окне)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.10.2005)
@LastMod(03.05.2012)
@Version(0.5)
}
unit ALogDocumentForm;

interface

uses
  ComCtrls, XmlIntf,
  AConfigFormUtils, ALogDocumentImpl, ALogFormTree, ALogGlobals,
  ALogNodeImpl, ALogNodeIntf, ATypes;

type //** Показывать Log в окне
  TLogForm = class(TLogDocumentA)
  private
    FFormLog: TProfLogTreeForm;
    FConfigFormLog: TConfigForm;
    //procedure SetConfig(Value: TConfigForm);
  public
    function AddMsg(const AMsg: WideString): Integer; override; safecall;
    function AddStr(const AStr: WideString): Integer; override; safecall;
      //** Добавить сообщение
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; override; {safecall;}
    function ConfigureLoad(AConfig: IXmlNode{IXmlDomNode} = nil): WordBool; {override;} safecall;
    function ConfigureSave(AConfig: IXmlNode{IXmlDomNode} = nil): WordBool; {override;} safecall;
    constructor Create();
    function Finalize(): TProfError; {override;}
    procedure Free(); {override;}
      //** Показать
    procedure Show(); override; safecall;
    function NewNode(AType: TLogTypeMessage; const APrefix: WideString; AParent: Integer = 0; AId: Integer = 0): IProfLogNode; override; safecall;
      //** Скрыть
    procedure Hide(); override; safecall;
  public
    property FormLog: TProfLogTreeForm read FFormLog write FFormLog;
  end;

implementation

{ TLogForm }

function TLogForm.AddMsg(const AMsg: WideString): Integer;
begin
  FFormLog.AddMsg(AMsg);
end;

function TLogForm.AddStr(const AStr: WideString): Integer;
begin
  FFormLog.AddStr(AStr);
end;

function TLogForm.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  Result := FFormLog.AddToLog(AGroup, AType, AStrMsg);
end;

function TLogForm.ConfigureLoad(AConfig: IXmlNode{IXmlDomNode} = nil): WordBool;
begin
  //Result := inherited ConfigureLoad(AConfig);
  if Assigned(FConfigFormLog) then
    FConfigFormLog.ConfigureLoad();
end;

function TLogForm.ConfigureSave(AConfig: IXmlNode{IXmlDomNode} = nil): WordBool;
begin
  //Result := inherited ConfigureSave(AConfig);
  if Assigned(FConfigFormLog) then
    FConfigFormLog.ConfigureSave();
end;

constructor TLogForm.Create();
begin
  inherited Create(lWindow);
  FFormLog := TProfLogTreeForm.Create(nil);

  {if Assigned(AConfig) then
  begin
    FConfigFormLog := TConfigForm.Create(AConfig, FFormLog);
  end;}
end;

function TLogForm.Finalize(): TProfError;
begin
  Result := 0; //inherited Finalize();
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

function TLogForm.NewNode(AType: TLogTypeMessage; const APrefix: WideString; AParent: Integer = 0; AId: Integer = 0): IProfLogNode;
var
  Id: Integer;
begin
  Id := GetFreeId;
  FFormLog.AddNode(AType, Id, AParent, APrefix);
  Result := TLogNode.Create(Self, APrefix, Id);
  AddNode(Result);
end;

procedure TLogForm.Show();
begin
  if Assigned(FFormLog) then FFormLog.Show();
end;

end.
