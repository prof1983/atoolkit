{**
@Abstract Показывать Log в окне
@Author Prof1983 <prof1983@ya.ru>
@Created 22.10.2005
@LastMod 18.12.2012
}
unit ALogDocumentFormObj;

interface

uses
  ComCtrls, SysUtils, XmlIntf,
  ABase,
  AConfigFormUtils,
  ALogDocumentObj,
  ALogDocumentUtils,
  ALogFormTree,
  ALogGlobals,
  ALogNodeUtils,
  ATypes;

type //** Показывать Log в окне
  TALogFormDocument = class(TALogDocumentObject)
  protected
    FFormLog: TALogTreeForm;
    FConfigFormLog: TConfigForm;
  public
    function AddMsg(const AMsg: WideString): Integer; override;
    function AddStr(const AStr: WideString): Integer; override;
    {** Добавляет сообщение }
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: APascalString): AInt; override;
    {** Добавляет сообщение }
    function AddToLogW(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: WideString): AInt; override;
    function ConfigureLoad(AConfig: IXmlNode = nil): WordBool; deprecated; // Delete
    function ConfigureLoad2(AConfig: IXmlNode = nil): WordBool; virtual;
    function ConfigureSave(AConfig: IXmlNode = nil): WordBool; deprecated; // Delete
    function ConfigureSave2(AConfig: IXmlNode = nil): WordBool; virtual;
    function Finalize(): AError; override;
    function NewNode(LogType: TLogTypeMessage; const Prefix: WideString;
        Parent: AInt = 0; Id: AInt = 0): ALogNode; override;
    {** Скрывает окно }
    procedure Hide(); virtual;
    {** Показывает окно }
    procedure Show(); virtual;
    {** Добавляет сообщение }
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; virtual;
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; virtual;
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer; virtual;
  public
    constructor Create(AConfig: IXmlNode = nil);
    procedure Free(); virtual;
  public
    property FormLog: TALogTreeForm read FFormLog write FFormLog;
  end;

  //TLogForm = TALogFormDocument;

implementation

{ TALogFormDocument }

function TALogFormDocument.AddMsg(const AMsg: WideString): Integer;
begin
  FFormLog.AddMsg(AMsg);
  Result := 0;
end;

function TALogFormDocument.AddStr(const AStr: WideString): Integer;
begin
  FFormLog.AddStr(AStr);
  Result := 0;
end;

function TALogFormDocument.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
  const StrMsg: APascalString): AInt;
begin
  Result := FFormLog.AddToLog(LogGroup, LogType, StrMsg);
end;

function TALogFormDocument.AddToLogW(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
  const StrMsg: WideString): AInt;
begin
  Result := AddToLog(LogGroup, LogType, StrMsg);
end;

function TALogFormDocument.ConfigureLoad(AConfig: IXmlNode): WordBool;
begin
  Result := ConfigureLoad2(AConfig);
end;

function TALogFormDocument.ConfigureLoad2(AConfig: IXmlNode = nil): WordBool;
begin
  if Assigned(FConfigFormLog) then
    Result := FConfigFormLog.ConfigureLoad()
  else
    Result := False;
end;

function TALogFormDocument.ConfigureSave(AConfig: IXmlNode): WordBool;
begin
  Result := ConfigureSave2(AConfig);
end;

function TALogFormDocument.ConfigureSave2(AConfig: IXmlNode = nil): WordBool;
begin
  if Assigned(FConfigFormLog) then
    Result := FConfigFormLog.ConfigureSave()
  else
    Result := False;
end;

constructor TALogFormDocument.Create(AConfig: IXmlNode);
begin
  inherited Create();
  FLogType := lWindow;
  FFormLog := TALogTreeForm.Create(nil);

  if Assigned(AConfig) then
  begin
    FConfigFormLog := TConfigForm.Create(nil{AConfig}, FFormLog);
  end;
end;

function TALogFormDocument.Finalize(): AError;
begin
  Result := inherited Finalize();
  FFormLog.Hide();
end;

procedure TALogFormDocument.Free();
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

procedure TALogFormDocument.Hide();
begin
  if Assigned(FFormLog) then FFormLog.Hide();
end;

function TALogFormDocument.NewNode(LogType: TLogTypeMessage; const Prefix: WideString; Parent, Id: AInt): ALogNode;
var
  Node: ALogNode;
begin
  if (Id = 0) then
    Id := GetFreeId();
  FFormLog.AddNode(LogType, Id, Parent, Prefix);

  Node := ALogNode_New(ALogDocument(Self), Parent, Prefix, Id);
  Result := ALogDocument_AddNode(ALogDocument(Self), Node);
  Result := Node;
end;

procedure TALogFormDocument.Show();
begin
  if Assigned(FFormLog) then FFormLog.Show();
end;

function TALogFormDocument.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := AddToLog(AGroup, AType, Format(AStrMsg, AParams));
end;

function TALogFormDocument.ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  Result := AddToLog(AGroup, AType, AStrMsg);
end;

function TALogFormDocument.ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  Result := FFormLog.ToLogE(AGroup, AType, AStrMsg);
end;

end.
