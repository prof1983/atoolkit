{**
@Author Prof1983 <prof1983@ya.ru>
@Created 28.11.2012
@LastMod 28.11.2012
}
unit ALogDocumentUtils;

interface

uses
  SysUtils,
  ABase, ATypes;

function ALogDocument_AddNode(LogDoc: ALogDocument; Node: ALogNode): AError;

function ALogDocument_AddToLogP(LogDoc: ALogDocument; LogGroup: TLogGroupMessage;
    LogType: TLogTypeMessage; const StrMsg: APascalString): AInt;

function ALogDocument_GetFreeId(LogDoc: ALogDocument): AInt;

function ALogDocument_GetNodeById(LogDoc: ALogDocument; Id: AInt): ALogNode;

function ALogDocument_NewNodeP(LogDoc: ALogDocument; LogType: TLogTypeMessage;
    const Msg: APascalString; Parent: AInt = 0; Id: AInt = 0): ALogNode;

implementation

uses
  ALogDocumentImpl, ALogDocumentObj, ALogNodeImpl, ALogNodeObj;

function ALogDocument_AddNode(LogDoc: ALogDocument; Node: ALogNode): AError;
var
  D: TALogDocumentObject;
  I: Integer;
begin
  if (TObject(LogDoc) is TALogDocument) then
    D := TALogDocument(LogDoc).LogDoc
  else if (TObject(LogDoc) is TALogDocumentObject) then
    D := TALogDocumentObject(LogDoc)
  else
  begin
    Result := -2;
    Exit;
  end;

  try
    I := Length(D.FNodes);
    SetLength(D.FNodes, I + 1);
    D.FNodes[I] := Node;
    Result := 0;
  except
    Result := -1;
  end;
end;

function ALogDocument_AddToLogP(LogDoc: ALogDocument; LogGroup: TLogGroupMessage;
    LogType: TLogTypeMessage; const StrMsg: APascalString): AInt;
var
  D: TALogDocumentObject;
begin
  if (TObject(LogDoc) is TALogDocument) then
    D := TALogDocument(LogDoc).LogDoc
  else if (TObject(LogDoc) is TALogDocumentObject) then
    D := TALogDocumentObject(LogDoc)
  else
  begin
    Result := 0;
    Exit;
  end;

  if Assigned(D.FOnAddToLog) then
    Result := D.FOnAddToLog(LogGroup, LogType, StrMsg)
  else
    Result := 0;
end;

function ALogDocument_GetFreeId(LogDoc: ALogDocument): AInt;
var
  D: TALogDocumentObject;
begin
  if (TObject(LogDoc) is TALogDocument) then
    D := TALogDocument(LogDoc).LogDoc
  else if (TObject(LogDoc) is TALogDocumentObject) then
    D := TALogDocumentObject(LogDoc)
  else
  begin
    Result := 0;
    Exit;
  end;

  Result := Length(D.FNodes) + 1;
end;

function ALogDocument_GetNodeById(LogDoc: ALogDocument; Id: AInt): ALogNode;
var
  D: TALogDocumentObject;
  I: Integer;
  N: TALogNodeObject;
begin
  if (TObject(LogDoc) is TALogDocument) then
    D := TALogDocument(LogDoc).LogDoc
  else if (TObject(LogDoc) is TALogDocumentObject) then
    D := TALogDocumentObject(LogDoc)
  else
  begin
    Result := 0;
    Exit;
  end;

  for I := 0 to High(D.FNodes) do
  begin
    if (TObject(D.FNodes[I]) is TALogNode) then
      N := TALogNode(D.FNodes[I]).LogNode
    else if (TObject(D.FNodes[I]) is TALogNodeObject) then
      N := TALogNodeObject(D.FNodes[I])
    else
      N := nil;

    if Assigned(N) and (N.Id = Id) then
    begin
      Result := ALogNode(N);
      Exit;
    end;
  end;
  Result := 0;
end;

function ALogDocument_NewNodeP(LogDoc: ALogDocument; LogType: TLogTypeMessage;
    const Msg: APascalString; Parent: AInt = 0; Id: AInt = 0): ALogNode;
var
  D: TALogDocumentObject;
  S: string;
  N: ALogNode;
begin
  if (TObject(LogDoc) is TALogDocument) then
    D := TALogDocument(LogDoc).LogDoc
  else if (TObject(LogDoc) is TALogDocumentObject) then
    D := TALogDocumentObject(LogDoc)
  else
  begin
    Result := 0;
    Exit;
  end;

  DateTimeToString(S, 'dd.mm.yyyy hh:mm:ss', Now);
  S := S + ' ' + Msg;
  if (Id = 0) then
    Id := D.GetFreeId;
  N := ALogNode(TALogNodeObject.Create(LogDoc, Parent, S, Id));
  ALogDocument_AddNode(LogDoc, N);
  Result := N;
end;

end.
