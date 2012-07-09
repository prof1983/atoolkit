﻿{**
@Abstract(Класс-потомок для форм с логированием и конфигурациями)
@Author(Prof1983 prof1983@ya.ru)
@Created(06.10.2005)
@LastMod(09.07.2012)
@Version(0.5)
}
unit AForm2007;

interface

uses
  Classes, Forms, SysUtils, XmlIntf,
  ABase, AConfig2007, AConfigUtils, ALogGlobals, ALogNodeUtils, ATypes, AXmlUtils;

type //** @abstract(Класс-потомок для форм с логированием и конфигурациями)
  TProfForm = class(TForm)
  protected
    FConfig: AConfig;
    //FConfig1: TConfigNode1; - Use FConfig
    //FConfig2: IXmlNode; - Use FConfig
    FConfigDocument: IXmlDocument;
    FConfigDocument1: TConfigDocument1;
    FInitialized: WordBool;
    FLog: ALogNode{TALogNode}; //FLog: IALogNode2;
    FLogPrefix: WideString;
    FOnAddToLog: TAddToLogProc;
    //FOnAddToLog: TProfAddToLog;
    //FOnAddToLog: TAddToLog;
  protected
    procedure DoDestroy(); override;
    function DoFinalize(): WordBool; virtual;
    function DoInitialize(): WordBool; virtual;
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: APascalString): AInteger; virtual;
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean; virtual;
    function AddToLogW(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): AInteger;
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer; virtual;
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; virtual;
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage; const AStrMsg: WideString): Integer; virtual;
  public
    function ConfigureLoad(): WordBool; virtual;
    function ConfigureLoad1(): WordBool; virtual;
    function ConfigureLoad2(AConfig: IXmlNode = nil): WordBool; virtual; safecall;
    function ConfigureSave(): WordBool; virtual;
    function ConfigureSave1(): WordBool; virtual;
    function ConfigureSave2(AConfig: IXmlNode = nil): WordBool; virtual; safecall;
    function Finalize(): WordBool; virtual;
    function Initialize(): WordBool; virtual;
  public
    procedure Free(); virtual;
  public
    property Config: AConfig{IXmlNode} read FConfig write FConfig;
    //property Config1: TConfigNode1 read FConfig1 write FConfig1; - Use Config
    property ConfigDocument: IXmlDocument read FConfigDocument write FConfigDocument;
    property ConfigDocument1: TConfigDocument1 read FConfigDocument1 write FConfigDocument1;
    property Initialized: WordBool read FInitialized;
    property Log: ALogNode read FLog write FLog;
    property OnAddToLog: TAddToLogProc read FOnAddToLog write FOnAddToLog;
    //property OnAddToLog: TProfAddToLog read FOnAddToLog write FOnAddToLog;
    //property OnAddToLog: TAddToLog read FOnAddToLog write FOnAddToLog;
  end;

  TProfForm2006 = TProfForm;

resourcestring // Сообщения ----------------------------------------------------
  stCreateOk = 'Объект создан';

const // Состояние окна --------------------------------------------------------
  WINDOW_STATE: array[TWindowState] of string = ('Normal', 'Minimized', 'Maximized');

implementation

{ TProfForm }

function TProfForm.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: APascalString): AInteger;
begin
  Result := ALogNode_AddToLog(FLog, AGroup, AType, AStrMsg);
  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(AGroup, AType, AStrMsg);
  except
  end;
end;

function TProfForm.AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
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

function TProfForm.AddToLogW(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): AInteger;
begin
  Result := AddToLog(AGroup, AType, AStrMsg);
end;

function TProfForm.ConfigureLoad(): WordBool;
begin
  Result := (FConfig <> 0);
end;

function TProfForm.ConfigureLoad1(): WordBool;
var
  I: Integer;
  S: WideString;
begin
  if (FConfig = 0) then
  begin
    Result := False;
    Exit;
  end;
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
    Caption := S; // Заголовок окна
end;

function TProfForm.ConfigureLoad2(AConfig: IXmlNode): WordBool;
var
  I: Integer;
  S: WideString;
  tmpWindowState: TWindowState;
begin
  if not(Assigned(FConfig)) then
  begin
    Result := False;
    Exit;
  end;
  //if TProfXmlNode.ReadIntegerA(FConfig, 'WindowState', I) and (WindowState <> TWindowState(I)) then
  //  WindowState := TWindowState(I);

  //if TProfXmlNode.ReadIntegerA(FConfig, 'WindowState', I) then WindowState := TWindowState(I);
  tmpWindowState := TWindowState(ProfXmlNode_ReadInt32Def(FConfig, 'WindowState', Integer(wsNormal)));

  WindowState := wsNormal;

  //if tmpWindowState = wsNormal then
  begin
    if ProfXmlNode_ReadInt(FConfig, 'Left', I) then Left := I;
    if ProfXmlNode_ReadInt(FConfig, 'Top', I) then Top := I;
    if ProfXmlNode_ReadInt(FConfig, 'Width', I) then Width := I;
    if ProfXmlNode_ReadInt(FConfig, 'Height', I) then Height := I;
  end;
  if (WindowState <> tmpWindowState) then
    WindowState := tmpWindowState;

  if ProfXmlNode_ReadString(FConfig, 'Caption', S) then Caption := S; // Заголовок окна

//  WindowState := TWindowState(TProfXmlNode.ReadInt32Def(FConfig, 'WindowState', Integer(WindowState)));
//  Left := TProfXmlNode.ReadInt32Def(FConfig, 'Left', Left);
//  Top := TProfXmlNode.ReadInt32Def(FConfig, 'Top', Top);
//  Width := TProfXmlNode.ReadInt32Def(FConfig, 'Width', Width);
//  Height := TProfXmlNode.ReadInt32Def(FConfig, 'Height', Height);
//  Caption := TProfXmlNode.ReadStringDef(FConfig, 'Caption', Caption);
  Result := True;
end;

function TProfForm.ConfigureSave(): WordBool;
begin
  Result := Assigned(FConfig);
end;

function TProfForm.ConfigureSave1(): WordBool;
begin
  Result := Assigned(FConfig);
  if not(Result) then Exit;
  if (WindowState <> wsMaximized) then
  begin
    FConfig1.WriteInt32('Left', Left);
    FConfig1.WriteInt32('Top', Top);
    FConfig1.WriteInt32('Width', Width);
    FConfig1.WriteInt32('Height', Height);
  end;
  FConfig1.WriteInt32('WindowState', Integer(WindowState));
  FConfig1.WriteString('Caption', Caption); // Заголовок окна
end;

function TProfForm.ConfigureSave2(AConfig: IXmlNode): WordBool;
begin
  Result := Assigned(FConfig);
  if not(Result) then Exit;
  if WindowState <> wsMaximized then
  begin
    ProfXmlNode_WriteInt(FConfig, 'Left', Left);
    ProfXmlNode_WriteInt(FConfig, 'Top', Top);
    ProfXmlNode_WriteInt(FConfig, 'Width', Width);
    ProfXmlNode_WriteInt(FConfig, 'Height', Height);
  end;
  ProfXmlNode_WriteInt(FConfig, 'WindowState', Integer(WindowState));
  ProfXmlNode_WriteString(FConfig, 'Caption', Caption); // Заголовок окна
  ProfXmlNode_WriteBool(FConfig, 'Visible', Self.Visible);
end;

procedure TProfForm.DoDestroy();
begin
  DoFinalize();
  inherited DoDestroy();
end;

function TProfForm.DoFinalize(): WordBool;
begin
  FConfig := nil;
  FConfigDocument := nil;
  ALogNode_Free(FLog);
  FLog := 0;
  Result := True;
end;

function TProfForm.DoInitialize(): WordBool;
begin
  Result := True;
end;

function TProfForm.Finalize(): WordBool;
begin
  Result := DoFinalize();
end;

procedure TProfForm.Free();
begin
  inherited Free;
end;

function TProfForm.Initialize(): WordBool;
begin
  Result := DoInitialize();
end;

function TProfForm.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
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

function TProfForm.ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  Result := AddToLog(AGroup, AType, AStrMsg);
end;

function TProfForm.ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage; const AStrMsg: WideString): Integer;
begin
  Result := AddToLog(IntToLogGroupMessage(AGroup), IntToLogTypeMessage(AType), AStrMsg);
end;

end.
