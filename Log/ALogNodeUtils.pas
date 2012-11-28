{**
@Abstract ALogNode functions
@Author Prof1983 <prof1983@ya.ru>
@Created 06.07.2012
@LastMod 28.11.2012
}
unit ALogNodeUtils;

interface

uses
  ABase, ATypes;

function ALogNode_AddToLog(LogNode: ALogNode; LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: APascalString): AInt;

function ALogNode_AddStr(LogNode: ALogNode; const Str: APascalString): AInt;

function ALogNode_Free(LogNode: ALogNode): AError;

function ALogNode_New(LogDoc: ALogDocument; ParentNodeId: AInt;
    const LogPrefix: APascalString; Id: AInt): ALogNode;

function ALogNode_SetOnAddToLog(LogNode: ALogNode; OnAddToLog: TAddToLogProc): AError;

function ALogNode_Show(LogNode: ALogNode): AError;

implementation

uses
  ALogNodeImpl;

function ALogNode_AddToLog(LogNode: ALogNode; LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: APascalString): AInt;
var
  N: TALogNodeObject;
begin
  if (LogNode = 0) then
  begin
    Result := -2;
    Exit;
  end;
  if (TObject(LogNode) is TALogNode) then
    N := TALogNode(LogNode).LogNode
  else if (TObject(LogNode) is TALogNodeObject) then
    N := TALogNodeObject(LogNode)
  else
  begin
    Result := -3;
    Exit;
  end;
  try
    Result := N.AddToLog(LogGroup, LogType, StrMsg);
  except
    Result := -1;
  end;
end;

function ALogNode_AddStr(LogNode: ALogNode; const Str: APascalString): AInt;
var
  N: TALogNodeObject;
begin
  if (LogNode = 0) then
  begin
    Result := -2;
    Exit;
  end;
  if (TObject(LogNode) is TALogNode) then
    N := TALogNode(LogNode).LogNode
  else if (TObject(LogNode) is TALogNodeObject) then
    N := TALogNodeObject(LogNode)
  else
  begin
    Result := -3;
    Exit;
  end;
  try
    N.AddStr(Str);
  except
    Result := -1;
  end;
end;

function ALogNode_Free(LogNode: ALogNode): AError;
begin
  try
    if (TObject(LogNode) is TALogNode) then
      IInterface(TALogNode(LogNode))._Release()
    else if (TObject(LogNode) is TALogNodeObject) then
      TALogNodeObject(LogNode).Free();
    Result := 0;
  except
    Result := -1;
  end;
end;

function ALogNode_New(LogDoc: ALogDocument; ParentNodeId: AInt;
    const LogPrefix: APascalString; Id: AInt): ALogNode;
begin
  Result := ALogNode(TALogNodeObject.Create(LogDoc, ParentNodeId, LogPrefix, Id));
end;

function ALogNode_SetOnAddToLog(LogNode: ALogNode; OnAddToLog: TAddToLogProc): AError;
var
  N: TALogNodeObject;
begin
  if (LogNode = 0) then
  begin
    Result := -2;
    Exit;
  end;
  if (TObject(LogNode) is TALogNode) then
    N := TALogNode(LogNode).LogNode
  else if (TObject(LogNode) is TALogNodeObject) then
    N := TALogNodeObject(LogNode)
  else
  begin
    Result := -3;
    Exit;
  end;
  N.OnAddToLog := OnAddToLog;
end;

function ALogNode_Show(LogNode: ALogNode): AError;
begin
  if (LogNode = 0) then
  begin
    Result := -2;
    Exit;
  end;
  if not(TObject(LogNode) is TALogNode) then
  begin
    Result := -3;
    Exit;
  end;
  try
    TALogNode(LogNode).Show();
    Result := 0;
  except
    Result := -1;
  end;
end;

end.
