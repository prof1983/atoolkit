{**
@Abstract Работа с Log. Классы для записи собщений программы в БД или файл или отображения в окне Log
@Author Prof1983 <prof1983@ya.ru>
@Created 16.08.2005
@LastMod 27.11.2012
}
unit ALogDocumentObj;

interface

uses
  Graphics, SysUtils, XmlIntf,
  ABase, ALogNodeObj, AMessageConst, ATypes;

type //** Документ работы с Log
  TALogDocumentObject = class
  protected
    FOnAddToLog: TAddToLogProc;
    FDocumentElement: TALogNodeObject;
    FLogType: TLogType;
    FOnCommand: TProcMessageStr;
    FNodes: array of TALogNodeObject;
  public
    function GetDocumentElement(): ALogNode;
    procedure SetOnCommand(Value: TProcMessageStr); virtual;
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
    function AddNode(ANode: TALogNodeObject): Boolean;
    function GetFreeId(): Integer;
    function GetNodeById(Id: Integer): TALogNodeObject; virtual;
    function GetSelf(): ALogDocument;
    function NewNode(LogType: TLogTypeMessage; const Msg: WideString; Parent: Integer = 0; Id: Integer = 0): TALogNodeObject; virtual;
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

function TALogDocumentObject.AddNode(ANode: TALogNodeObject): Boolean;
var
  I: Integer;
begin
  I := Length(FNodes);
  SetLength(FNodes, I + 1);
  FNodes[I] := ANode;
  Result := True;
end;

function TALogDocumentObject.AddStr(const Str: WideString): AInt;
begin
  Result := AddMsg(Str);
end;

function TALogDocumentObject.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: WideString): AInt;
begin
  if Assigned(FOnAddToLog) then
    Result := FOnAddToLog(LogGroup, LogType, StrMsg)
  else
    Result := 0;
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
  Result := Length(FNodes) + 1;
end;

function TALogDocumentObject.GetNodeById(Id: Integer): TALogNodeObject;
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

function TALogDocumentObject.GetSelf(): ALogDocument;
begin
  Result := ALogDocument(Self);
end;

function TALogDocumentObject.Initialize(): AError;
begin
  Result := 0;
end;

function TALogDocumentObject.NewNode(LogType: TLogTypeMessage; const Msg: WideString;
    Parent: Integer = 0; Id: Integer = 0): TALogNodeObject;
var
  S: string;
begin
  DateTimeToString(S, 'dd.mm.yyyy hh:mm:ss', Now);
  S := S + ' ' + Msg;
  if (Id = 0) then
    Id := GetFreeId;
  Result := TALogNodeObject.Create(ALogDocument(Self), Parent, S, Id);
  AddNode(Result);
end;

procedure TALogDocumentObject.SetOnCommand(Value: TProcMessageStr);
begin
  FOnCommand := Value;
end;

end.
