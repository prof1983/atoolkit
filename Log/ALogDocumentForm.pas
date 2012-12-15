{**
@Abstract Показывать Log в окне
@Author Prof1983 <prof1983@ya.ru>
@Created 22.10.2005
@LastMod 15.12.2012
}
unit ALogDocumentForm;

interface

uses
  ComCtrls, XmlIntf,
  AConfigFormUtils, ALogDocumentImpl, ALogFormTree, ALogGlobals,
  ALogNodeImpl, ALogNodeIntf, ATypes;

type //** Показывать Log в окне
  TLogForm = class(TALogDocument)
  private
    FFormLog: TProfLogTreeForm;
    FConfigFormLog: TConfigForm;
    //procedure SetConfig(Value: TConfigForm);
  public
    function AddMsg(const AMsg: WideString): Integer; override;
    function AddStr(const AStr: WideString): Integer; override;
      //** Добавить сообщение
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; override; {safecall;}
    function ConfigureLoad(AConfig: IXmlNode = nil): WordBool; deprecated; // Delete
    function ConfigureSave(AConfig: IXmlNode = nil): WordBool; deprecated; // Delete
    constructor Create();
    function Finalize(): AError; override;
    procedure Free(); {override;}
      //** Скрыть
    procedure Hide(); override;
    function NewNode(LogType: TLogTypeMessage; const Prefix: WideString;
        Parent: Integer = 0; Id: Integer = 0): TALogNode; override;
      //** Показать
    procedure Show(); override;
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

function TLogForm.Finalize(): AError;
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

function TLogForm.NewNode(LogType: TLogTypeMessage; const Prefix: WideString;
    Parent, Id: Integer): TALogNode;
begin
  if (Id = 0) then
    Id := GetFreeId();
  FFormLog.AddNode(LogType, Id, Parent, Prefix);
  Result := TALogNode.Create(Self, Prefix, Id);
  AddNode(Result);
end;

procedure TLogForm.Show();
begin
  if Assigned(FFormLog) then FFormLog.Show();
end;

end.
