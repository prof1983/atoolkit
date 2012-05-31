{**
@Abstract(Класс-потомок для форм с логированием и конфигурациями)
@Author(Prof1983 prof1983@ya.ru)
@Created(06.10.2005)
@LastMod(25.05.2012)
@Version(0.5)
}
unit AForm2007;

interface

uses
  Classes, Forms, SysUtils, XmlIntf,
  ALogNodeIntf, ATypes, AXmlUtils;

type //** @abstract(Класс-потомок для форм с логированием и конфигурациями)
  TProfForm = class(TForm)
  protected
    FConfig: IXmlNode;
    FConfigDocument: IXmlDocument;
    FInitialized: WordBool;
    FLog: ILogNode2;
    FLogPrefix: WideString;
    FOnAddToLog: TProfAddToLog;
  protected
    procedure DoDestroy(); override;
    function DoFinalize(): WordBool; virtual;
    function DoInitialize(): WordBool; virtual;
  protected
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean; virtual;
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer; virtual;
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; virtual;
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage; const AStrMsg: WideString): Integer; virtual;
  public
    property Config: IXmlNode read FConfig write FConfig;
    property ConfigDocument: IXmlDocument read FConfigDocument write FConfigDocument;
    function ConfigureLoad(): WordBool; virtual;
    function ConfigureLoad2(AConfig: IXmlNode = nil): WordBool; virtual; safecall;
    function ConfigureSave(): WordBool; virtual;
    function ConfigureSave2(AConfig: IXmlNode = nil): WordBool; virtual; safecall;
    function Finalize(): WordBool; virtual;
    procedure Free(); virtual;
    function Initialize(): WordBool; virtual;
    property Initialized: WordBool read FInitialized;
    property Log: ILogNode2 read FLog write FLog;
    property OnAddToLog: TProfAddToLog read FOnAddToLog write FOnAddToLog;
  end;

resourcestring // Сообщения ----------------------------------------------------
  stCreateOk           = 'Объект создан';

const // Состояние окна --------------------------------------------------------
  WINDOW_STATE: array[TWindowState] of string = ('Normal', 'Minimized', 'Maximized');

implementation

{ TProfForm }

function TProfForm.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
begin
  Result := (ToLog(AGroup, AType, AStrMsg, AParams) > 0);
end;

function TProfForm.ConfigureLoad(): WordBool;
begin
  Result := Assigned(FConfig);
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
  FLog := nil;
  Result := True;
end;

function TProfForm.DoInitialize(): WordBool;
begin
  Result := True;
end;

function TProfForm.Finalize(): WordBool;
begin
  Result := True;
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

  Result := ToLogA(AGroup, AType, S);

  if Assigned(FOnAddToLog) then
  try
    FOnAddToLog(AGroup, AType, AStrMsg, AParams);
  except
  end;
end;

function TProfForm.ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  Result := -1;
  if Assigned(FLog) then
  try
    Result := FLog.ToLogA(AGroup, AType, AStrMsg);
  except
  end;
end;

function TProfForm.ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage; const AStrMsg: WideString): Integer;
begin
  Result := -1;
  if Assigned(FLog) then
  try
    Result := FLog.ToLogE(AGroup, AType, AStrMsg);
  except
  end;
end;

end.
