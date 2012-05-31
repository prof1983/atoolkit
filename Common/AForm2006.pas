{**
@Abstract(Класс-потомок для форм с логированием и конфигурациями)
@Автор(Prof1983 prof1983@ya.ru)
@Created(06.10.2005)
@LastMod(28.04.2012)
@Version(0.5)

30.09.2006 - Добавил CLR
}
unit AForm2006;

interface

uses
  Classes, Forms, SysUtils,
  ABase, AConfig2007, ALogGlobals2007, ATypes;

type
  TProfForm = class(TForm)
  protected
    FConfig: {IXmlNode}TConfigNode1;
    FConfigDocument: TConfigDocument1;
    FInitialized: WordBool;
    FLog: TLogNode;
    FLogPrefix: WideString;
    FOnAddToLog: TAddToLog;
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: APascalString): AInteger; virtual;
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean; virtual;
    function AddToLogW(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): AInteger; virtual;
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer; virtual;
  public
    property Config: {IXmlNode}TConfigNode1 read FConfig write FConfig;
    property ConfigDocument: TConfigDocument1 read FConfigDocument write FConfigDocument;
    function ConfigureLoad(): WordBool; virtual;
    function ConfigureSave(): WordBool; virtual;
    function Finalize(): WordBool; virtual;
    function Initialize(): WordBool; virtual;
    property Initialized: WordBool read FInitialized;
    property Log: TLogNode read FLog write FLog;
    property OnAddToLog: TAddToLog read FOnAddToLog write FOnAddToLog;
  end;

resourcestring // Сообщения ----------------------------------------------------
  stCreateOk = 'Объект создан';

implementation

{ TProfForm }

function TProfForm.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: APascalString): AInteger;
begin
  Result := 0;
  if Assigned(FLog) then
  try
    Result := FLog.AddToLog(AGroup, AType, AStrMsg);
  except
  end;
  if Assigned(FOnAddToLog) then
  try
    FOnAddToLog(AGroup, AType, AStrMsg, []);
  except
  end;
end;

function TProfForm.AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
begin
  Result := False;
  if Assigned(FLog) then
  try
    Result := (FLog.AddToLog(AGroup, AType, Format(AStrMsg, AParams)) = 0);
  except
  end;
  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(AGroup, AType, AStrMsg, AParams);
  except
  end;
end;

function TProfForm.AddToLogW(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): AInteger;
begin
  Result := AddToLog(AGroup, AType, AStrMsg);
end;

function TProfForm.ConfigureLoad(): WordBool;
var
  I: Integer;
  S: WideString;
begin
  Result := Assigned(FConfig);
  if not(Result) then Exit;
  if FConfig.ReadInt32('Left', I) then Left := I;
  if FConfig.ReadInt32('Top', I) then Top := I;
  if FConfig.ReadInt32('Width', I) then Width := I;
  if FConfig.ReadInt32('Height', I) then Height := I;
  if Config.ReadInt32('WindowState', I) then WindowState := TWindowState(I);
  if Config.ReadString('Caption', S) then Caption := S; // Заголовок окна
end;

function TProfForm.ConfigureSave(): WordBool;
begin
  Result := Assigned(FConfig);
  if not(Result) then Exit;
  if WindowState <> wsMaximized then
  begin
    FConfig.WriteInt32('Left', Left);
    FConfig.WriteInt32('Top', Top);
    FConfig.WriteInt32('Width', Width);
    FConfig.WriteInt32('Height', Height);
  end;
  FConfig.WriteInt32('WindowState', Integer(WindowState));
  FConfig.WriteString('Caption', Caption); // Заголовок окна
end;

function TProfForm.Finalize(): WordBool;
begin
  Result := True;
end;

function TProfForm.Initialize(): WordBool;
begin
  Result := True;
end;

function TProfForm.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := -1;
  if Assigned(FLog) then
  try
    Result := FLog.ToLog(AGroup, AType, AStrMsg, AParams);
  except
  end
  else
  begin
    Result := 1;
    AddToLog2(AGroup, AType, AStrMsg, AParams);
  end;
end;

end.
