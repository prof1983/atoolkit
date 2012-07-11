{**
@Abstract(TForm with Logging and Configurations)
@Author(Prof1983 prof1983@ya.ru)
@Created(06.10.2005)
@LastMod(11.07.2012)
@Version(0.5)
}
unit AFormObj;

interface

uses
  Classes, Forms, SysUtils, XmlIntf,
  ABase, AConfig2007, AConfigUtils, ALogGlobals, ALogNodeUtils, ATypes;

type
    //** TForm with Logging and Configurations
  TAFormObject = class(TForm)
  protected
    FConfig: AConfig;
    FConfigDocument1: TConfigDocument;
    FInitialized: WordBool;
    FLog: ALogNode;
    FLogPrefix: WideString;
    FOnAddToLog: TAddToLogProc;
  protected
    procedure DoDestroy(); override;
    function DoFinalize(): WordBool; virtual;
    function DoInitialize(): WordBool; virtual;
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
    function ConfigureLoad(): WordBool; virtual;
    function ConfigureLoad1(): WordBool; virtual; deprecated; // Use ConfigureLoad()
    function ConfigureSave(): WordBool; virtual;
    function ConfigureSave1(): WordBool; virtual; deprecated; // Use ConfigureSave()
    function Finalize(): WordBool; virtual;
    function Initialize(): WordBool; virtual;
  public
    procedure Free(); virtual;
  public
    property Config: AConfig read FConfig write FConfig;
    property ConfigDocument1: TConfigDocument read FConfigDocument1 write FConfigDocument1;
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
  Result := ALogNode_AddToLog(FLog, AGroup, AType, AStrMsg);
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
var
  I: Integer;
  S: APascalString;
  tmpWindowState: TWindowState;
begin
  if (FConfig = 0) then
  begin
    Result := False;
    Exit;
  end;

  tmpWindowState := TWindowState(AConfig_ReadInt32Def(FConfig, 'WindowState', Integer(wsNormal)));
  WindowState := wsNormal;

  if (AConfig_ReadInt32(FConfig, 'Left', I) >= 0) then
    Left := I;
  if (AConfig_ReadInt32(FConfig, 'Top', I) >= 0) then
    Top := I;
  if (AConfig_ReadInt32(FConfig, 'Width', I) >= 0) then
    Width := I;
  if (AConfig_ReadInt32(FConfig, 'Height', I) >= 0) then
    Height := I;
  if (AConfig_ReadInt32(FConfig, 'WindowState', I) >= 0) then
    WindowState := TWindowState(I);
  if (AConfig_ReadString(FConfig, 'Caption', S) >= 0) then
    Caption := S;

  if (WindowState <> tmpWindowState) then
    WindowState := tmpWindowState;

  Result := True;
end;

function TAFormObject.ConfigureLoad1(): WordBool;
begin
  Result := ConfigureLoad();
end;

{function TProfForm.ConfigureLoad2(AConfig: IXmlNode): WordBool;
var
  I: Integer;
  S: APascalString;
  tmpWindowState: TWindowState;
begin
  if (FConfig = 0) then
  begin
    Result := False;
    Exit;
  end;

  tmpWindowState := TWindowState(AConfig_ReadInt32Def(FConfig, 'WindowState', Integer(wsNormal)));
  WindowState := wsNormal;

  //if tmpWindowState = wsNormal then
  begin
    if (AConfig_ReadInt(FConfig, 'Left', I) >= 0) then
      Left := I;
    if (AConfig_ReadInt(FConfig, 'Top', I) >= 0) then
      Top := I;
    if (AConfig_ReadInt(FConfig, 'Width', I) >= 0) then
      Width := I;
    if (AConfig_ReadInt(FConfig, 'Height', I) >= 0) then
      Height := I;
  end;
  if (WindowState <> tmpWindowState) then
    WindowState := tmpWindowState;

  if (AConfig_ReadString(FConfig, 'Caption', S) >= 0) then
    Caption := S;

  Result := True;
end;}

function TAFormObject.ConfigureSave(): WordBool;
begin
  if (FConfig = 0) then
  begin
    Result := False;
    Exit;
  end;
  if (WindowState <> wsMaximized) then
  begin
    AConfig_WriteInt32(FConfig, 'Left', Left);
    AConfig_WriteInt32(FConfig, 'Top', Top);
    AConfig_WriteInt32(FConfig, 'Width', Width);
    AConfig_WriteInt32(FConfig, 'Height', Height);
  end;
  AConfig_WriteInt32(FConfig, 'WindowState', Integer(WindowState));
  AConfig_WriteString(FConfig, 'Caption', Caption);
  AConfig_WriteBool(FConfig, 'Visible', Self.Visible);
end;

function TAFormObject.ConfigureSave1(): WordBool;
begin
  Result := ConfigureSave();
end;

{function TProfForm.ConfigureSave2(AConfig: IXmlNode): WordBool;
begin
  if (FConfig = 0) then
  begin
    Result := False;
    Exit;
  end;
  if (WindowState <> wsMaximized) then
  begin
    AConfig_WriteInt(FConfig, 'Left', Left);
    AConfig_WriteInt(FConfig, 'Top', Top);
    AConfig_WriteInt(FConfig, 'Width', Width);
    AConfig_WriteInt(FConfig, 'Height', Height);
  end;
  AConfig_WriteInt(FConfig, 'WindowState', Integer(WindowState));
  AConfig_WriteString(FConfig, 'Caption', Caption);
  AConfig_WriteBool(FConfig, 'Visible', Self.Visible);
end;}

procedure TAFormObject.DoDestroy();
begin
  DoFinalize();
  inherited DoDestroy();
end;

function TAFormObject.DoFinalize(): WordBool;
begin
  AConfig_Free(FConfig);
  FConfig := 0;
  FConfigDocument1 := nil;
  ALogNode_Free(FLog);
  FLog := 0;
  Result := True;
end;

function TAFormObject.DoInitialize(): WordBool;
begin
  Result := True;
end;

function TAFormObject.Finalize(): WordBool;
begin
  Result := DoFinalize();
end;

procedure TAFormObject.Free();
begin
  inherited Free;
end;

function TAFormObject.Initialize(): WordBool;
begin
  Result := DoInitialize();
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
