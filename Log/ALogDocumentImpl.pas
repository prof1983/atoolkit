{**
@Abstract(Работа с Log. Классы для записи собщений программы в БД или файл или отображения в окне Log)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.08.2005)
@LastMod(27.04.2012)
@Version(0.5)
}
unit ALogDocumentImpl;

interface

uses
  {ComObj,} Graphics, SysUtils, XmlIntf,
  ADocumentImpl, ALogDocumentIntf, ALogNodeImpl, ALogNodeIntf, AMessageConst, ANodeIntf, ATypes;
  {ALogGlobals, AObjectImpl,}

type //** Документ работы с Log
  TLogDocument = class(TLogNode, IProfLogDocument, IProfLogNode)
  private
    FAddToLog: TProcAddToLog;
    FConfig: IProfNode;
    FLogType: TLogType;
    FOnCommand: TProcMessage;
  protected
    function GetNodeByID(ID: Integer): IProfLogNode; virtual;
    procedure SetOnCommand(Value: TProcMessage); virtual;
  public // IProfDocument2
    {**
      Открыт ли документ?
      Реализация метода IsOpened должна проверить соответствующие свойства
      Объекта для определения состояния документа.
    }
    function GetIsOpened(): WordBool; safecall;
    {**
      Закрыть документ
      Реализация метода Close() должна содержать действия по нейтрализации
      результатов работы метода Open().
    }
    procedure CloseDocument(); safecall;
    {**
      Открыть документ
      Реализация метода Open() должна содержать все необходимые действия для
      обеспечения корректной и безошибочной работы других методов документа.
      Этот метод запускается первым после создания экземпляра класса.
      @returns(Возврашает 0 в случае успешного выполнения;
        положительное число, если есть замечания;
        отрицательное число, если есть ошибки (открыть документ не удалось))
    }
    function OpenDocument(): TProfError; safecall;
  public // IProfLogDocument
    function GetDocumentElement(): IProfLogNode; safecall;
  public
    {**
      Добавить лог-сообщение
      @returns(Возвращает номер добавленого лог-сообщения или 0)
    }
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; override;
  public
      //** Загрузить конфигурации
    //function ConfigureLoad(AConfig: IProfNode = nil): WordBool; {override;} safecall;
      //** Сохранить конфигурации
    //function ConfigureSave(AConfig: IProfNode = nil): WordBool; {override;} safecall;
    constructor Create(ALogType: TLogType; AName: WideString = ''; AParent: TLogDocument = nil);
      //** Инициализировать
    function Initialize(): TProfError; virtual;
      //** Тип лог-документа
    function NewNode(AType: TLogTypeMessage; const APrefix: WideString; AParent: Integer = 0; AId: Integer = 0): IProfLogNode; virtual; safecall;
  published
    property Config: IProfNode read FConfig write FConfig;
    property LogType: TLogType read FLogType;
    property OnAddToLog: TProcAddToLog read FAddToLog write FAddToLog;
    property OnCommand: TProcMessage read FOnCommand write SetOnCommand;
  end;

type
  TLogDocument1 = class(TALogNode2, ILogDocument2)
  private
    FAddToLog: TAddToLog;
    FConfig: IProfNode;
    FLogType: TLogType;
    FOnCommand: TProfMessage;
  protected
    procedure SetOnCommand(Value: TProfMessage); virtual;
  public
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Boolean; override;
      // Загрузить конфигурации
    //function ConfigureLoad(AConfig: IXmlNode = nil): WordBool; override; safecall;
      // Сохранить конфигурации
    //function ConfigureSave(AConfig: IXmlNode = nil): WordBool; override; safecall;
    constructor Create(ALogType: TLogType; AName: WideString = ''; AParent: TLogDocument1 = nil);
    destructor Destroy(); override;
    // Финализировать
    function Finalize(): TProfError; override; //safecall;
    procedure Free(); override;
    function GetNodeByID(ID: Integer): TALogNode2; virtual;
    procedure Hide(); override; safecall;
    // Инициализировать
    function Initialize(): TProfError; override; //safecall;
    // Тип лог-документа
    function NewNode(AType: TLogTypeMessage; const APrefix: WideString; AParent: Integer = 0; AId: Integer = 0): TALogNode2; virtual;
    procedure Show(); override; safecall;
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer; override;
    //function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer; override;
  published
    property Config: IProfNode read FConfig write FConfig;
    property LogType: TLogType read FLogType;
    property OnAddToLog: TAddToLog read FAddToLog write FAddToLog;
    property OnCommand: TProfMessage read FOnCommand write SetOnCommand;
  end;

type //** Документ записи/обображения Log
  TLogDocumentA = class(TLogDocument)
  private
    FNodes: array of IProfLogNode;
  protected
    function GetNodeByID(ID: Integer): IProfLogNode; override;
  public
    function NewNode(AType: TLogTypeMessage; const AMsg: WideString; AParent: Integer = 0; AID: Integer = 0): IProfLogNode; override; safecall;
    function AddNode(ANode: IProfLogNode): Boolean;
    function GetFreeID(): Integer;
  end;

type // Документ записи/отображения Log
  TLogDocumentA1 = class(TLogDocument1)
  private
    FNodes: array of TALogNode2;
  public
    function GetNodeByID(ID: Integer): TALogNode2; override;
    function NewNode(AType: TLogTypeMessage; const AMsg: WideString; AParent: Integer = 0; AID: Integer = 0): TALogNode2; override;
    function AddNode(ANode: TALogNode2): Boolean;
    function GetFreeID(): Integer;
  end;

type //** Документ работы с Log
  TProfLogDocument3 = class(TProfDocument3, IProfLogDocument)
  private
    FConfig: IProfNode;
    FOnCommand: TProcMessage;
  protected
    FLogType: TLogType;
  protected
    function GetDocumentElement(): IProfLogNode; safecall;
    procedure SetOnCommand(Value: TProcMessage); virtual;
  public
    {**
      Добавить лог-сообщение
        @returns(Возвращает номер добавленого лог-сообщения или 0)
    }
    {function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override;}
  public
      //** Финализировать
    function Finalize(): TProfError; {override;} virtual; safecall;
      //** Инициализировать
    function Initialize(): TProfError; {override;} virtual; safecall;
  public
    property Config: IProfNode read FConfig write FConfig;
      //** Тип лог-документа
    property LogType: TLogType read FLogType;
    property OnCommand: TProcMessage read FOnCommand write SetOnCommand;
  end;

implementation

{ TLogDocument }

function TLogDocument.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  if Assigned(FAddToLog) then
    Result := FAddToLog(AGroup, AType, AStrMsg)
  else
    Result := 0;
end;

procedure TLogDocument.CloseDocument();
begin
end;

constructor TLogDocument.Create(ALogType: TLogType; AName: WideString = ''; AParent: TLogDocument = nil);
begin
  inherited Create(AParent, AName, 0);
end;

function TLogDocument.GetDocumentElement(): IProfLogNode;
begin
  Result := Self;
end;

function TLogDocument.GetIsOpened(): WordBool;
begin
  Result := True;
end;

function TLogDocument.GetNodeById(Id: Integer): IProfLogNode;
begin
  Result := nil;
end;

function TLogDocument.Initialize(): TProfError;
begin
  Result := 0;
end;

function TLogDocument.NewNode(AType: TLogTypeMessage; const APrefix: WideString; AParent: Integer = 0; AId: Integer = 0): IProfLogNode;
begin
  Result := nil;
end;

function TLogDocument.OpenDocument(): TProfError;
begin
  Result := 0;
end;

procedure TLogDocument.SetOnCommand(Value: TProcMessage);
begin
  FOnCommand := Value;
end;

{ TLogDocument1 }

function TLogDocument1.AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: string; AParams: array of const): Boolean;
begin
  if Assigned(FAddToLog) then
    Result := FAddToLog(AGroup, AType, AStrMsg, AParams)
  else
    Result := False;
end;

{function TLogDocument1.ConfigureLoad(AConfig: IXmlNode = nil): WordBool;
begin
  Result := inherited ConfigureLoad(AConfig);
end;}

{function TLogDocument1.ConfigureSave(AConfig: IXmlNode = nil): WordBool;
begin
  Result := inherited ConfigureSave(AConfig);
end;}

constructor TLogDocument1.Create(ALogType: TLogType; AName: WideString = ''; AParent: TLogDocument1 = nil);
begin
  inherited Create(AParent, 0, AName, 0);
end;

destructor TLogDocument1.Destroy();
begin
  inherited Destroy();
end;

function TLogDocument1.Finalize(): TProfError;
begin
  Result := 0;
end;

procedure TLogDocument1.Free();
begin
  inherited Free();
end;

function TLogDocument1.GetNodeById(Id: Integer): TALogNode2;
begin
  Result := nil;
end;

procedure TLogDocument1.Hide();
begin
end;

function TLogDocument1.Initialize(): TProfError;
begin
  Result := 0;
end;

function TLogDocument1.NewNode(AType: TLogTypeMessage; const APrefix: WideString; AParent: Integer = 0; AId: Integer = 0): TALogNode2;
begin
  Result := nil;
end;

procedure TLogDocument1.SetOnCommand(Value: TProfMessage);
begin
  FOnCommand := Value;
end;

procedure TLogDocument1.Show();
begin
end;

function TLogDocument1.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString; AParams: array of const): Integer;
var
  s: WideString;
begin
  try
    s := Format(AStrMsg, AParams);
  except
    s := AStrMsg;
  end;
  //Result := ToLogA(OLE_GROUP_MESSAGE[AGroup], OLE_TYPE_MESSAGE[AType], s);
  Result := ToLogA(AGroup, AType, s);
end;

{ TLogDocumentA }

function TLogDocumentA.AddNode(ANode: IProfLogNode): Boolean;
var
  I: Integer;
begin
  I := Length(FNodes);
  SetLength(FNodes, I + 1);
  FNodes[I] := ANode;
  Result := True;
end;

function TLogDocumentA.GetFreeId: Integer;
begin
  Result := Length(FNodes) + 1;
end;

function TLogDocumentA.GetNodeByID(ID: Integer): IProfLogNode;
var
  I: Integer;
begin
  for I := 0 to High(FNodes) do
    if FNodes[I].ID = ID then
    begin
      Result := FNodes[I];
      Exit;
    end;
  Result := nil;
end;

function TLogDocumentA.NewNode(AType: TLogTypeMessage; const AMsg: WideString; AParent: Integer = 0; AId: Integer = 0): IProfLogNode;
var
  S: string;
begin
  DateTimeToString(S, 'dd.mm.yyyy hh:mm:ss', Now);
  S := S + ' ' + AMsg;
  if AId = 0 then AId := GetFreeId;
  Result := TLogNode.Create(Self, S, AId);
  AddNode(Result);
end;

{ TLogDocumentA1 }

function TLogDocumentA1.AddNode(ANode: TALogNode2): Boolean;
var
  I: Integer;
begin
  I := Length(FNodes);
  SetLength(FNodes, I + 1);
  FNodes[I] := ANode;
  Result := True;
end;

function TLogDocumentA1.GetFreeId: Integer;
begin
  Result := Length(FNodes) + 1;
end;

function TLogDocumentA1.GetNodeById(Id: Integer): TALogNode2;
var
  I: Integer;
begin
  for I := 0 to High(FNodes) do if FNodes[I].Id = Id then
  begin
    Result := FNodes[I];
    Exit;
  end;
  Result := nil;
end;

function TLogDocumentA1.NewNode(AType: TLogTypeMessage; const AMsg: WideString; AParent: Integer = 0; AId: Integer = 0): TALogNode2;
var
  S: string;
begin
  DateTimeToString(S, 'dd.mm.yyyy hh:mm:ss', Now);
  S := S + ' ' + AMsg;
  if AId = 0 then AId := GetFreeId;
  Result := TALogNode2.Create(Self, AParent, S, AId);
  AddNode(Result);
end;

{ TProfLogDocument3 }

(*function TProfLogDocument3.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  {if Assigned(FAddToLog) then
    Result := FAddToLog(AGroup, AType, AStrMsg)
  else
    Result := 0;}
end;*)

function TProfLogDocument3.Finalize(): TProfError;
begin
  Result := 0;
end;

function TProfLogDocument3.GetDocumentElement(): IProfLogNode;
begin
  Result := nil;
  // ...
end;

function TProfLogDocument3.Initialize(): TProfError;
begin
  Result := 0;
end;

procedure TProfLogDocument3.SetOnCommand(Value: TProcMessage);
begin
  FOnCommand := Value;
end;

end.
