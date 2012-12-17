{**
@Abstract TForm with Logging and Configurations
@Author Prof1983 <prof1983@ya.ru>
@Created 06.10.2005
@LastMod 17.12.2012
}
unit AFormObj;

interface

uses
  Classes, Forms, SysUtils, XmlIntf,
  ABase, AConfig2007, AConfigUtils, ALogGlobals, ALogNodeUtils, ATypes,
  AUiForm;

type
    //** TForm with Logging and Configurations
  TAFormObject = class(TForm)
  protected
    FConfig: AConfig;
    FConfigDocument1: ADocument;
    FInitialized: WordBool;
    FLog: ALogNode;
    FLogPrefix: WideString;
    FOnAddToLog: TAddToLogProc;
  protected
    procedure DoDestroy(); override;
    function DoFinalize(): WordBool; virtual;
    function DoInitialize(): WordBool; virtual;
  public
    function GetConfig(): AConfig;
  public
    procedure SetConfig(Value: AConfig);
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: APascalString): AInteger; virtual;
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Boolean; virtual;
    function AddToLogW(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): AInteger;
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; virtual;
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; virtual;
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer; virtual;
  public
    function ConfigureLoad(): WordBool; virtual; deprecated; // Use AUiForm.Form_LoadConfig()
    function ConfigureLoad2(FConfig: AConfig): AError; deprecated; // Use AUiForm.Form_LoadConfig()
    function ConfigureSave(): WordBool; virtual; deprecated; // Use AUiForm.Form_SaveConfig()
    function ConfigureSave2(FConfig: AConfig): AError; deprecated; // Use AUiForm.Form_SaveConfig()
    function Finalize(): AError; virtual;
    function Initialize(): AError; virtual;
  public
    procedure Free(); virtual;
  public
    property Config: AConfig read GetConfig write SetConfig;
    property ConfigDocument1: ADocument read FConfigDocument1 write FConfigDocument1;
    property Initialized: WordBool read FInitialized;
    property Log: ALogNode read FLog write FLog;
    property OnAddToLog: TAddToLogProc read FOnAddToLog write FOnAddToLog;
  end;

  //TProfForm = TAFormObject;

// --- Messages ---
{$IFDEF DELPHI_XE_UP}
{$I AForm.ru.utf8.inc}
{$ELSE}
{$I AForm.ru.win1251.inc}
{$ENDIF DELPHI_XE_UP}

const
    //** Window state
  WINDOW_STATE: array[TWindowState] of string = ('Normal', 'Minimized', 'Maximized');

implementation

{ TProfForm }

function TAFormObject.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: APascalString): AInteger;
begin
  Result := ALogNode_AddToLogP(FLog, AGroup, AType, AStrMsg);
  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(AGroup, AType, AStrMsg);
  except
  end;
end;

function TAFormObject.AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: string; AParams: array of const): Boolean;
var
  S: WideString;
begin
  try
    S := Format(AStrMsg, AParams);
  except
    S := AStrMsg;
  end;
  Result := (AddToLog(AGroup, AType, S) >= 0);
end;

function TAFormObject.AddToLogW(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString): AInteger;
begin
  Result := AddToLog(AGroup, AType, AStrMsg);
end;

function TAFormObject.ConfigureLoad(): WordBool;
begin
  Result := (ConfigureLoad2(FConfig) >= 0);
end;

function TAFormObject.ConfigureLoad2(FConfig: AConfig): AError;
begin
  Result := AUiForm.Form_LoadConfig(Self, FConfig);
end;

function TAFormObject.ConfigureSave(): WordBool;
begin
  Result := (ConfigureSave2(FConfig) >= 0);
end;

function TAFormObject.ConfigureSave2(FConfig: AConfig): AError;
begin
  Result := AUiForm.Form_SaveConfig(Self, FConfig);
end;

procedure TAFormObject.DoDestroy();
begin
  DoFinalize();
  inherited DoDestroy();
end;

function TAFormObject.DoFinalize(): WordBool;
begin
  AConfig_Free(FConfig);
  FConfig := 0;
  FConfigDocument1 := 0;
  ALogNode_Free(FLog);
  FLog := 0;
  Result := True;
end;

function TAFormObject.DoInitialize(): WordBool;
begin
  Result := True;
end;

function TAFormObject.Finalize(): AError;
begin
  if DoFinalize() then
    Result := 0
  else
    Result := -1;
end;

procedure TAFormObject.Free();
begin
  inherited Free;
end;

function TAFormObject.GetConfig(): AConfig;
begin
  Result := FConfig;
end;

function TAFormObject.Initialize(): AError;
begin
  if DoInitialize() then
    Result := 0
  else
    Result := -1;
end;

procedure TAFormObject.SetConfig(Value: AConfig);
begin
  FConfig := Value;
end;

function TAFormObject.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString; AParams: array of const): Integer;
var
  S: WideString;
begin
  try
    S := Format(AStrMsg, AParams);
  except
    S := AStrMsg;
  end;
  Result := AddToLog(AGroup, AType, S);
end;

function TAFormObject.ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  Result := AddToLog(AGroup, AType, AStrMsg);
end;

function TAFormObject.ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
    const AStrMsg: WideString): Integer;
begin
  Result := AddToLog(IntToLogGroupMessage(AGroup), IntToLogTypeMessage(AType), AStrMsg);
end;

end.
