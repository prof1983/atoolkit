{**
@Abstract Работа с Log. Классы для записи собщений программы в БД или файл или отображения в окне Log
@Author Prof1983 <prof1983@ya.ru>
@Created 16.08.2005
@LastMod 28.11.2012
}
unit ALogDocumentObj;

interface

uses
  Graphics, SysUtils, XmlIntf,
  ABase, ALogDocumentUtils, ALogNodeObj, AMessageConst, ATypes;

type //** Документ работы с Log
  TALogDocumentObject = class
  public
    FOnAddToLog: TAddToLogProc;
    FDocumentElement: TALogNodeObject;
    FLogType: TLogType;
    FOnCommand: TProcMessageStr;
    FNodes: array of ALogNode{TALogNodeObject};
  public
    function GetDocumentElement(): ALogNode;
    procedure SetOnCommand(Value: TProcMessageStr); virtual;
    procedure SetLogType(Value: TLogType);
  public
    {** Добавить сообщение
        @returns(Возвращает номер добавленого сообщения или 0) }
    function AddMsg(const Msg: WideString): AInt; virtual;
    {** Добавить строку
        @returns(Возвращает номер добавленой строки или 0) }
    function AddStr(const Str: WideString): AInt; virtual;
    {** Добавить лог-сообщение
        @returns(Возвращает номер добавленого лог-сообщения или 0) }
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: WideString): AInt; virtual;
  public
    {** Финализировать }
    function Finalize(): AError; virtual;
    {** Инициализировать }
    function Initialize(): AError; virtual;
  public
    function AddNode(Node: ALogNode): AError;
    function GetFreeId(): Integer;
    function GetNodeById(Id: AInt): ALogNode; virtual;
    function GetSelf(): ALogDocument;
    function NewNode(LogType: TLogTypeMessage; const Msg: WideString; Parent: AInt = 0; Id: AInt = 0): ALogNode; virtual;
  published
    {** Тип лог-документа }
    property LogType: TLogType read FLogType;
    property OnAddToLog: TAddToLogProc read FOnAddToLog write FOnAddToLog;
    property OnCommand: TProcMessageStr read FOnCommand write SetOnCommand;
  end;

implementation

{ TLogDocumentObject }

function TALogDocumentObject.AddMsg(const Msg: WideString): AInt;
begin
  Result := AddToLog(lgNone, ltNone, Msg);
end;

function TALogDocumentObject.AddNode(Node: ALogNode): AError;
begin
  Result := ALogDocument_AddNode(ALogDocument(Self), Node);
end;

function TALogDocumentObject.AddStr(const Str: WideString): AInt;
begin
  Result := AddMsg(Str);
end;

function TALogDocumentObject.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: WideString): AInt;
begin
  Result := ALogDocument_AddToLogP(ALogDocument(Self), LogGroup, LogType, StrMsg);
end;

function TALogDocumentObject.Finalize(): AError;
begin
  FDocumentElement := nil;
  Result := 0;
end;

function TALogDocumentObject.GetDocumentElement(): ALogNode;
begin
  Result := Self.FDocumentElement.GetSelf();
end;

function TALogDocumentObject.GetFreeId(): Integer;
begin
  Result := ALogDocument_GetFreeId(ALogDocument(Self));
end;

function TALogDocumentObject.GetNodeById(Id: AInt): ALogNode;
begin
  Result := ALogDocument_GetNodeById(ALogDocument(Self), Id);
end;

function TALogDocumentObject.GetSelf(): ALogDocument;
begin
  Result := ALogDocument(Self);
end;

function TALogDocumentObject.Initialize(): AError;
begin
  Result := 0;
end;

function TALogDocumentObject.NewNode(LogType: TLogTypeMessage; const Msg: WideString;
    Parent: Integer = 0; Id: Integer = 0): ALogNode;
begin
  Result := ALogDocument_NewNodeP(ALogDocument(Self), LogType, Msg, Parent, Id);
end;

procedure TALogDocumentObject.SetLogType(Value: TLogType);
begin
  FLogType := Value;
end;

procedure TALogDocumentObject.SetOnCommand(Value: TProcMessageStr);
begin
  FOnCommand := Value;
end;

end.
