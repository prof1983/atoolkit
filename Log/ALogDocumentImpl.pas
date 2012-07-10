{**
@Abstract(Работа с Log. Классы для записи собщений программы в БД или файл или отображения в окне Log)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.08.2005)
@LastMod(10.07.2012)
@Version(0.5)
}
unit ALogDocumentImpl;

interface

uses
  Graphics, SysUtils, XmlIntf,
  ADocumentImpl, ALogDocumentIntf, ALogNodeImpl, ALogNodeIntf, AMessageConst, ANodeIntf, ATypes;

type //** Документ работы с Log
  TALogDocument = class(TALogNode, IALogDocument)
  protected
    //FAddToLog: TAddToLogProc;
    FConfig: IProfNode;
    FDocumentElement: TALogNode;
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
  public // IALogDocument
    function GetDocumentElement(): ALogNode;
    function GetDocumentElement2(): IALogNode2;
  public
    {**
      Добавить лог-сообщение
      @returns(Возвращает номер добавленого лог-сообщения или 0)
    }
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override;
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
    function GetSelf(): ALogDocument;
    function NewNode(LogType: TLogTypeMessage; const Msg: WideString; Parent: Integer = 0; Id: Integer = 0): TALogNode; virtual;
  public
    constructor Create(ALogType: TLogType; AName: WideString = ''; AParent: TALogDocument = nil);
    constructor Create2(ALogType: TLogType; AName: WideString = ''; AParent: ALogDocument2 = 0);
  published
    property Config: IProfNode read FConfig write FConfig;
      //** Тип лог-документа
    property LogType: TLogType read FLogType;
    property OnAddToLog: TAddToLogProc read FOnAddToLog write FOnAddToLog;
    property OnCommand: TProcMessageStr read FOnCommand write SetOnCommand;
  end;

  TLogDocument = TALogDocument;

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
  if Assigned(FOnAddToLog) then
    Result := FOnAddToLog(AGroup, AType, AStrMsg)
  else
    Result := 0;
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
  FDocumentElement := Self;
  //inherited Create(lNone);
end;

constructor TALogDocument.Create2(ALogType: TLogType; AName: WideString = ''; AParent: ALogDocument2 = 0);
begin
  inherited Create2(AParent, 0, AName, 0);
  FDocumentElement := Self;
end;

function TALogDocument.Finalize(): TProfError;
begin
  FDocumentElement := nil;
  Result := 0;
end;

function TALogDocument.GetDocumentElement(): ALogNode;
begin
  Result := Self.FDocumentElement.GetSelf();
end;

function TALogDocument.GetDocumentElement2(): IALogNode2;
begin
  Result := FDocumentElement;
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

function TALogDocument.GetSelf(): ALogDocument;
begin
  Result := ALogDocument(Self);
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

end.
