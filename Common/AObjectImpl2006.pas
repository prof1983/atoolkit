{**
@Abstract(Объект с логированием и конфигурациями)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.12.2005)
@LastMod(02.07.2012)
@Version(0.5)
}
unit AObjectImpl2006;

interface

uses
  SysUtils,
  ALogGlobals2006, ALogNodeIntf, AObjectIntf2006, ATypes, AXmlNodeIntf;

type //** Объект с логированием и конфигурациями
  TProfObject = class(TInterfacedObject, IProfObject)
  protected
    FConfig: AProfXmlNode2{IProfXmlNode2006};
    FInitialized: Boolean;
    FLog: ILogNode2;
    procedure SetInitialized(Value: Boolean);
  protected
    function Get_Config(): AProfXmlNode2{IProfXmlNode2006}; safecall;
    function Get_Log: ILogNode2; safecall;
    procedure Set_Config(const Value: AProfXmlNode2{IProfXmlNode2006}); safecall;
    procedure Set_Log(const Value: ILogNode2); virtual; safecall;
    //function GetConfig: TConfigNode;
    //function GetLog: TLogNode;
    //procedure SetConfig(const Value: TConfigNode);
    //procedure SetLog(const Value: TLogNode); virtual;
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean; virtual;
    function AddToLog2(AMsg: WideString): TLogNode; virtual;
    //function AddToLogProf(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg, AParams: WideString; AParentId: Integer): Integer; virtual;
    function AssignedConfig: Boolean;
    function CheckInitialized: Boolean; virtual;
    function ConfigureLoad: WordBool; virtual; safecall;
    function ConfigureSave: WordBool; virtual; safecall;
    function Finalize: WordBool; virtual; safecall;
    function Initialize: WordBool; virtual; safecall;
  public
    constructor Create(AConfig: AProfXmlNode2{IProfXmlNode2006}{TConfigNode} = nil; ALog: TLogNode = nil);
    procedure Free; virtual;
  public
    //property Config: TConfigNode read GetConfig write SetConfig;
    //property Log: TLogNode read GetLog write SetLog;
    property Initialized: Boolean read FInitialized write SetInitialized;
  end;

const // Сообщения -------------------------------------------------------------
  stAlreadyFinalize   = 'Уже финализировано';
  stAlreadyInitialize = 'Уже инициализировано';
  stNotAssignedConfig = 'Конфигурации не заданы';
  stNotInitialized     = 'Не инициализировано';

implementation

{ TProfObject }

function TProfObject.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
begin
  if Assigned(FLog) then
    Result := (FLog.ToLogA(AGroup, AType, Format(AStrMsg, AParams)) >= 0)
  else
    Result := False;
end;

function TProfObject.AddToLog2(AMsg: WideString): TLogNode;
begin
  if Assigned(FLog) then
  begin
    FLog.ToLogA(lgGeneral, ltInformation, AMsg);
    Result := nil;
    //Result := FLog.AddToLog2(AMsg);
  end
  else
    Result := nil;
end;

{function TProfObject.AddToLogProf(AType: TTypeMessage; APlace: TPlaceMessage; AMsg, AParams: WideString): UInt32;
begin
  if Assigned(FLog) then begin
    FLog.AddToLogA(elgGeneral, eltInformation, AMsg, 0);
    Result := 0;
    //Result := FLog.AddToLogProf(AType, APlace, AMsg, AParams);
  end else
    Result := 0;
end;}

function TProfObject.AssignedConfig: Boolean;
begin
  Result := Assigned(FConfig);
  if not(Result) then
    AddToLog(lgGeneral, ltError, stNotAssignedConfig, []);
end;

function TProfObject.CheckInitialized: Boolean;
begin
  Result := FInitialized;
  if not(Result) then
    AddToLog(lgGeneral, ltWarning, stNotInitialized, []);
end;

function TProfObject.ConfigureLoad: WordBool;
begin
  Result := AssignedConfig;
end;

function TProfObject.ConfigureSave: WordBool;
begin
  Result := AssignedConfig;
end;

constructor TProfObject.Create(AConfig: AProfXmlNode2{IProfXmlNode2006}{TConfigNode} = nil; ALog: TLogNode = nil);
begin
  inherited Create;
  FConfig := AConfig;
  FLog := ALog;
end;

function TProfObject.Finalize: WordBool;
begin
  Result := False;
  if not(FInitialized) then begin
    AddToLog(lgGeneral, ltInformation, stAlreadyFinalize, []);
    Exit;
  end;
  Result := True;
  FInitialized := False;
end;

procedure TProfObject.Free;
begin
  if FInitialized then
    Finalize;

  {!!!}
  //Finalize;
  //ConfigureSave;
  {!!!}

  inherited Free;
end;

function TProfObject.Get_Config(): AProfXmlNode2{IProfXmlNode2006};
begin
  Result := FConfig;
end;

function TProfObject.Get_Log(): ILogNode2;
begin
  Result := FLog;
end;

{function TProfObject.GetConfig: TConfigNode;
begin
  Result := FConfig;
end;}

{function TProfObject.GetLog: TLogNode;
begin
  Result := FLog;
end;}

function TProfObject.Initialize: WordBool;
begin
  if FInitialized then begin
    AddToLog(lgGeneral, ltInformation, stAlreadyInitialize, []);
    Result := True;
    Exit;
  end;
  Result := True;
  FInitialized := True;
end;

procedure TProfObject.SetInitialized(Value: Boolean);
begin
  if Value then
    Initialize
  else
    Finalize;
end;

procedure TProfObject.Set_Config(const Value: AProfXmlNode2{IProfXmlNode2006});
begin
  FConfig := Value;
end;

procedure TProfObject.Set_Log(const Value: ILogNode2);
begin
  FLog := Value;
end;

{procedure TProfObject.SetConfig(const Value: TConfigNode);
begin
  FConfig := Value;
end;}

{procedure TProfObject.SetLog(const Value: TLogNode);
begin
  FLog := Value;
end;}

end.
