{**
@Author Prof1983 <prof1983@ya.ru>
@Created 22.10.2005
@LastMod 05.02.2013
}
unit ALogDocumentForm;

interface

uses
  ComCtrls, XmlIntf,
  ABase,
  AConfigFormUtils, ALogDocumentImpl, ALogFormTree, ALogGlobals,
  ALogNodeImpl, ALogNodeIntf, ATypes;

type
  TLogForm = class(TALogDocument)
  private
    FFormLog: TALogTreeForm;
    FConfigFormLog: TConfigForm;
  public
    function AddMsg(const AMsg: WideString): Integer; override;
    function AddStr(const AStr: WideString): Integer; override;
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; override; {safecall;}
    constructor Create();
    function Finalize(): AError; override;
    procedure Free(); {override;}
    procedure Hide(); override;
    function NewNode(LogType: TLogTypeMessage; const Prefix: WideString;
        Parent: AInteger = 0; Id: AInteger = 0): ALogNode; override;
    procedure Show(); override;
  public
    property FormLog: TALogTreeForm read FFormLog write FFormLog;
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

constructor TLogForm.Create();
begin
  inherited Create(lWindow);
  FFormLog := TALogTreeForm.Create(nil);
end;

function TLogForm.Finalize(): AError;
begin
  Result := 0;
  FFormLog.Hide();
end;

procedure TLogForm.Free();
begin
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
    Parent, Id: AInteger): ALogNode;
var
  LogNode: TALogNode;
begin
  if (Id = 0) then
    Id := GetFreeId();
  FFormLog.AddNode(LogType, Id, Parent, Prefix);

  LogNode := TALogNode.Create(Self, Prefix, Id);
  AddNode(LogNode);
  Result := LogNode.GetSelf();
end;

procedure TLogForm.Show();
begin
  if Assigned(FFormLog) then FFormLog.Show();
end;

end.
