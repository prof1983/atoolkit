{**
@Abstract Работа с Log. Классы для записи собщений программы в БД или файл или отображения в окне Log
@Author Prof1983 <prof1983@ya.ru>
@Created 16.08.2005
@LastMod 28.11.2012
}
unit ALogDocumentImpl;

{$ifdef NoLogImpl}
  {$message Error 'Do not use this file'}
{$endif}

interface

uses
  ABase, ALogDocumentIntf, ALogDocumentObj, ALogNodeImpl,
  ANodeIntf, ATypes;

type //** Документ работы с Log
  TALogDocument = class(TALogNode, IALogDocument)
  protected
    FLogDocument: TALogDocumentObject;
    FConfig: IProfNode;
    {
    FDocumentElement: TALogNode;
    FLogType: TLogType;
    FOnCommand: TProcMessageStr;
    FNodes: array of TALogNode;
    }
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
    function OpenDocument(): AError; safecall;
  public // IALogDocument
    function GetDocumentElement(): ALogNode;
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
    function Finalize(): AError; virtual;
      //** Инициализировать
    function Initialize(): AError; virtual;
  public
    function AddNode(ANode: TALogNode): Boolean;
    function GetFreeId(): Integer;
    function GetNodeById(Id: Integer): ALogNode; virtual;
    function GetSelf(): ALogDocument;
    function NewNode(LogType: TLogTypeMessage; const Msg: WideString; Parent: Integer = 0; Id: Integer = 0): ALogNode; virtual;
  public
    constructor Create(ALogType: TLogType; AName: WideString = ''; AParent: TALogDocument = nil);
    constructor Create2(ALogType: TLogType; AName: WideString = ''; AParent: ALogDocument = 0);
  published
    property Config: IProfNode read FConfig write FConfig;
    property LogDoc: TALogDocumentObject read FLogDocument;
    {
      //** Тип лог-документа
    property LogType: TLogType read GetLogType;
    property OnCommand: TProcMessageStr read GetOnCommand write SetOnCommand;
    }
  end;

  TLogDocument = TALogDocument;

implementation

{ TLogDocument }

function TALogDocument.AddNode(ANode: TALogNode): Boolean;
begin
  Result := (FLogDocument.AddNode(ANode.GetSelf) >= 0);
end;

function TALogDocument.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  Result := FLogDocument.AddToLog(AGroup, AType, AStrMsg);
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
  FLogDocument := TALogDocumentObject.Create();
  FLogDocument.SetLogType(ALogType);
end;

constructor TALogDocument.Create2(ALogType: TLogType; AName: WideString = ''; AParent: ALogDocument = 0);
begin
  inherited Create2(AParent, 0, AName, 0);
  FLogDocument := TALogDocumentObject.Create();
  FLogDocument.SetLogType(ALogType);
end;

function TALogDocument.Finalize(): AError;
begin
  Result := 0;
end;

function TALogDocument.GetDocumentElement(): ALogNode;
begin
  Result := FLogDocument.GetDocumentElement();
end;

function TALogDocument.GetFreeId(): Integer;
begin
  Result := FLogDocument.GetFreeId();
end;

function TALogDocument.GetNodeById(Id: Integer): ALogNode;
begin
  Result := FLogDocument.GetNodeById(Id);
end;

function TALogDocument.GetSelf(): ALogDocument;
begin
  Result := ALogDocument(Self);
end;

function TALogDocument.GetIsOpened(): WordBool;
begin
  Result := True;
end;

function TALogDocument.Initialize(): AError;
begin
  Result := 0;
end;

function TALogDocument.NewNode(LogType: TLogTypeMessage; const Msg: WideString;
    Parent: Integer = 0; Id: Integer = 0): ALogNode;
begin
  Result := FLogDocument.NewNode(LogType, Msg, Parent, Id);
end;

function TALogDocument.OpenDocument(): AError;
begin
  Result := 0;
end;

procedure TALogDocument.SetOnCommand(Value: TProcMessageStr);
begin
  FLogDocument.SetOnCommand(Value);
end;

end.
