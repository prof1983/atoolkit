{**
@Abstract Объект с логированием и конфигурациями
@Author Prof1983 <prof1983@ya.ru>
@Created 22.12.2005
@LastMod 13.11.2012
}
unit AObjectImpl2006;

interface

uses
  SysUtils,
  ABase, ALogNodeImpl, ALogNodeIntf, AObjectIntf, ATypes, AXmlNodeIntf;

type //** Объект с логированием и конфигурациями
  TAObject2006 = class(TInterfacedObject, IProfObject2006)
  protected
    FConfig: AProfXmlNode2;
    FInitialized: Boolean;
    FLog: ILogNode2;
    procedure SetInitialized(Value: Boolean);
  protected
    function Get_Config(): AProfXmlNode2; safecall;
    function Get_Log(): ILogNode2; safecall;
    procedure Set_Config(const Value: AProfXmlNode2); safecall;
    procedure Set_Log(const Value: ILogNode2); virtual; safecall;
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean; virtual;
    function AddToLog2(AMsg: WideString): TALogNode; virtual;
    function AssignedConfig(): Boolean;
    function CheckInitialized(): Boolean; virtual;
    function ConfigureLoad(): WordBool; virtual; safecall;
    function ConfigureSave(): WordBool; virtual; safecall;
    function Finalize(): WordBool; virtual; safecall;
    function Initialize(): WordBool; virtual; safecall;
  public
    constructor Create(AConfig: AProfXmlNode2 = 0; ALog: TALogNode = nil);
    procedure Free(); virtual;
  public
    property Initialized: Boolean read FInitialized write SetInitialized;
  end;

const // Сообщения -------------------------------------------------------------
  stAlreadyFinalize   = 'Уже финализировано';
  stAlreadyInitialize = 'Уже инициализировано';
  stNotAssignedConfig = 'Конфигурации не заданы';
  stNotInitialized     = 'Не инициализировано';

implementation

{ TProfObject }

function TAObject2006.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
begin
  if Assigned(FLog) then
    Result := (FLog.ToLogA(AGroup, AType, Format(AStrMsg, AParams)) >= 0)
  else
    Result := False;
end;

function TAObject2006.AddToLog2(AMsg: WideString): TALogNode;
begin
  if Assigned(FLog) then
  begin
    FLog.AddToLog(lgGeneral, ltInformation, AMsg);
    Result := nil;
  end
  else
    Result := nil;
end;

function TAObject2006.AssignedConfig: Boolean;
begin
  if (FConfig = 0) then
  begin
    AddToLog(lgGeneral, ltError, stNotAssignedConfig, []);
    Result := False;
    Exit;
  end;
  Result := True;
end;

function TAObject2006.CheckInitialized: Boolean;
begin
  Result := FInitialized;
  if not(Result) then
    AddToLog(lgGeneral, ltWarning, stNotInitialized, []);
end;

function TAObject2006.ConfigureLoad: WordBool;
begin
  Result := AssignedConfig;
end;

function TAObject2006.ConfigureSave: WordBool;
begin
  Result := AssignedConfig;
end;

constructor TAObject2006.Create(AConfig: AProfXmlNode2 = 0; ALog: TALogNode = nil);
begin
  inherited Create;
  FConfig := AConfig;
  FLog := ALog;
end;

function TAObject2006.Finalize: WordBool;
begin
  Result := False;
  if not(FInitialized) then begin
    AddToLog(lgGeneral, ltInformation, stAlreadyFinalize, []);
    Exit;
  end;
  Result := True;
  FInitialized := False;
end;

procedure TAObject2006.Free;
begin
  if FInitialized then
    Finalize;
  inherited Free;
end;

function TAObject2006.Get_Config(): AProfXmlNode2;
begin
  Result := FConfig;
end;

function TAObject2006.Get_Log(): ILogNode2;
begin
  Result := FLog;
end;

function TAObject2006.Initialize(): WordBool;
begin
  if FInitialized then begin
    AddToLog(lgGeneral, ltInformation, stAlreadyInitialize, []);
    Result := True;
    Exit;
  end;
  Result := True;
  FInitialized := True;
end;

procedure TAObject2006.SetInitialized(Value: Boolean);
begin
  if Value then
    Initialize
  else
    Finalize;
end;

procedure TAObject2006.Set_Config(const Value: AProfXmlNode2);
begin
  FConfig := Value;
end;

procedure TAObject2006.Set_Log(const Value: ILogNode2);
begin
  FLog := Value;
end;

end.
