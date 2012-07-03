{**
@Abstract(Работа с Log. Классы для записи собщений программы в БД или файл или отображения в окне Log)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.08.2005)
@LastMod(03.07.2012)
@Version(0.5)
}
unit ALogDocumentImpl;

interface

uses
  Graphics, SysUtils, XmlIntf,
  ADocumentImpl, ALogDocumentIntf, ALogNodeImpl, ALogNodeIntf, AMessageConst, ANodeIntf, ATypes;

type //** Документ работы с Log
  TALogDocument = class(TALogNode, IProfLogDocument, ILogDocument)
  protected
    FAddToLog: TProcAddToLog;
    FConfig: IProfNode;
    FLogType: TLogType;
    FOnCommand: TProcMessageStr;
    FNodes: array of TALogNode;
  protected
    procedure SetOnCommand(Value: TProcMessageStr); virtual;
  public // IProfDocument
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
    function GetDocumentElement(): IALogNode2; safecall;
  public
    {**
      Добавить лог-сообщение
      @returns(Возвращает номер добавленого лог-сообщения или 0)
    }
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override;
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Boolean; override;
  public
      //** Загрузить конфигурации
    function ConfigureLoad(): WordBool; virtual;
      //** Сохранить конфигурации
    function ConfigureSave(): WordBool; virtual;
      //** Финализировать
    function Finalize(): TProfError; virtual;
      //** Инициализировать
    function Initialize(): TProfError; virtual;
  public
    function AddNode(ANode: TALogNode): Boolean;
    function GetFreeId(): Integer;
    function GetNodeById(Id: Integer): TALogNode; virtual;
    function NewNode(LogType: TLogTypeMessage; const Msg: WideString; Parent: Integer = 0; Id: Integer = 0): TALogNode; virtual;
  public
    constructor Create(ALogType: TLogType; AName: WideString = ''; AParent: TALogDocument = nil);
    constructor Create2(ALogType: TLogType; AName: WideString = ''; AParent: ALogDocument2 = 0);
  published
    property Config: IProfNode read FConfig write FConfig;
      //** Тип лог-документа
    property LogType: TLogType read FLogType;
    property OnAddToLog: TProcAddToLog read FAddToLog write FAddToLog;
    property OnCommand: TProcMessageStr read FOnCommand write SetOnCommand;
  end;

  TLogDocument = TALogDocument;

type //** Документ работы с Log
  TProfLogDocument3 = class(TALogDocument{TProfDocument}, IProfLogDocument)
  private
    FConfig: IProfNode;
    FOnCommand: TProcMessageStr;
  protected
    FLogType: TLogType;
  protected
    function GetDocumentElement(): IALogNode2; safecall;
    procedure SetOnCommand(Value: TProcMessageStr); virtual;
  public
    {**
      Добавить лог-сообщение
        @returns(Возвращает номер добавленого лог-сообщения или 0)
    }
    {function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override;}
  public
      //** Финализировать
    function Finalize(): TProfError; virtual;
      //** Инициализировать
    function Initialize(): TProfError; virtual;
  public
    property Config: IProfNode read FConfig write FConfig;
      //** Тип лог-документа
    property LogType: TLogType read FLogType;
    property OnCommand: TProcMessageStr read FOnCommand write SetOnCommand;
  end;

implementation

{ TLogDocument }

function TALogDocument.AddNode(ANode: TALogNode): Boolean;
var
  I: Integer;
begin
  I := Length(FNodes);
  SetLength(FNodes, I + 1);
  FNodes[I] := ANode;
  Result := True;
end;

function TALogDocument.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  if Assigned(FAddToLog) then
    Result := FAddToLog(AGroup, AType, AStrMsg)
  else
    Result := 0;
end;

function TALogDocument.AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: string; AParams: array of const): Boolean;
var
  S: WideString;
begin
  try
    S := Format(AStrMsg, AParams);
  except
    S := AStrMsg;
  end;

  if Assigned(FAddToLog) then
    Result := (FAddToLog(AGroup, AType, S) >= 0)
  else
    Result := False;
end;

procedure TALogDocument.CloseDocument();
begin
end;

function TALogDocument.ConfigureLoad(): WordBool;
begin
  Result := Assigned(FConfig);
end;

function TALogDocument.ConfigureSave(): WordBool;
begin
  Result := Assigned(FConfig);
end;

constructor TALogDocument.Create(ALogType: TLogType; AName: WideString = ''; AParent: TLogDocument = nil);
begin
  inherited Create(AParent, AName, 0);
end;

constructor TALogDocument.Create2(ALogType: TLogType; AName: WideString = ''; AParent: ALogDocument2 = 0);
begin
  inherited Create2(AParent, 0, AName, 0);
end;

function TALogDocument.Finalize(): TProfError;
begin
  Result := 0;
end;

function TALogDocument.GetDocumentElement(): IALogNode2;
begin
  Result := Self;
end;

function TALogDocument.GetFreeId(): Integer;
begin
  Result := Length(FNodes) + 1;
end;

function TALogDocument.GetNodeById(Id: Integer): TALogNode;
var
  I: Integer;
begin
  for I := 0 to High(FNodes) do
  begin
    if (FNodes[I].Id = Id) then
    begin
      Result := FNodes[I];
      Exit;
    end;
  end;
  Result := nil;
end;

function TALogDocument.GetIsOpened(): WordBool;
begin
  Result := True;
end;

function TALogDocument.Initialize(): TProfError;
begin
  Result := 0;
end;

function TALogDocument.NewNode(LogType: TLogTypeMessage; const Msg: WideString;
    Parent: Integer = 0; Id: Integer = 0): TALogNode;
var
  S: string;
begin
  DateTimeToString(S, 'dd.mm.yyyy hh:mm:ss', Now);
  S := S + ' ' + Msg;
  if (Id = 0) then
    Id := GetFreeId;
  Result := TALogNode.Create2(ALogDocument2(Self), Parent, S, Id);
  AddNode(Result);
end;

function TALogDocument.OpenDocument(): TProfError;
begin
  Result := 0;
end;

procedure TALogDocument.SetOnCommand(Value: TProcMessageStr);
begin
  FOnCommand := Value;
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

function TProfLogDocument3.GetDocumentElement(): IALogNode2;
begin
  Result := nil;
  // ...
end;

function TProfLogDocument3.Initialize(): TProfError;
begin
  Result := 0;
end;

procedure TProfLogDocument3.SetOnCommand(Value: TProcMessageStr);
begin
  FOnCommand := Value;
end;

end.
