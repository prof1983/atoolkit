{**
@Abstract ALogNode functions
@Author Prof1983 <prof1983@ya.ru>
@Created 06.07.2012
@LastMod 17.12.2012
}
unit ALogNodeUtils;

{$ifndef NoLogImpl}
  {$define UseLogImpl}
{$endif}

interface

uses
  ABase, ATypes;

function ALogNode_AddToLogP(LogNode: ALogNode; LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: APascalString): AInt;

function ALogNode_AddStrP(LogNode: ALogNode; const Str: APascalString): AInt;

function ALogNode_Free(LogNode: ALogNode): AError;

function ALogNode_GetId(LogNode: ALogNode): AInt; {$ifdef AStdCall}stdcall;{$endif}

function ALogNode_New(LogDoc: ALogDocument; ParentNodeId: AInt;
    const LogPrefix: APascalString; Id: AInt): ALogNode;

function ALogNode_SetOnAddToLog(LogNode: ALogNode; OnAddToLog: TAddToLogProc): AError;

function ALogNode_Show(LogNode: ALogNode): AError;

implementation

uses
  ALogDocumentUtils, {$ifdef UseLogImpl}ALogNodeImpl,{$endif} ALogNodeObj;

function ALogNode_AddToLogP(LogNode: ALogNode; LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: APascalString): AInt;
var
  N: TALogNodeObject;
begin
  if (LogNode = 0) then
  begin
    Result := -2;
    Exit;
  end;
  if (TObject(LogNode) is TALogNodeObject) then
    N := TALogNodeObject(LogNode)
  {$ifdef UseLogImpl}
  else if (TObject(LogNode) is TALogNode) then
    N := TALogNode(LogNode).LogNode
  {$endif}
  else
  begin
    Result := -3;
    Exit;
  end;
  try
    Result := -1;

    if Assigned(N.FLogNode.OnAddToLog) then
    try
      Result := N.FLogNode.OnAddToLog(LogGroup, LogType, StrMsg);
    except
    end;

    if (N.FLogNode.LogDoc <> 0) then
      Result := ALogDocument_AddToLogP(N.FLogNode.LogDoc, LogGroup, LogType, StrMsg);

    if (N.FLogNode.Parent <> 0) then
    try
      Result := TALogNodeObject(N.FLogNode.Parent).AddToLog(LogGroup, LogType, StrMsg);
    except
    end;
  except
    Result := -1;
  end;
end;

function ALogNode_AddStrP(LogNode: ALogNode; const Str: APascalString): AInt;
begin
  Result := ALogNode_AddToLogP(LogNode, lgNone, ltNone, Str);
end;

function ALogNode_Free(LogNode: ALogNode): AError;
begin
  try
    {$ifdef UseLogImpl}
    if (TObject(LogNode) is TALogNode) then
      IInterface(TALogNode(LogNode))._Release()
    else
    {$endif}
    if (TObject(LogNode) is TALogNodeObject) then
      TALogNodeObject(LogNode).Free();
    Result := 0;
  except
    Result := -1;
  end;
end;

function ALogNode_GetId(LogNode: ALogNode): AInt;
begin
  if (LogNode = 0) then
  begin
    Result := 0;
    Exit;
  end;
  if not(TObject(LogNode) is TALogNodeObject) then
  begin
    Result := 0;
    Exit;
  end;
  try
    Result := TALogNodeObject(LogNode).GetId();
  except
    Result := 0;
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
  if (TObject(LogNode) is TALogNodeObject) then
    N := TALogNodeObject(LogNode)
  {$ifdef UseLogImpl}
  else if (TObject(LogNode) is TALogNode) then
    N := TALogNode(LogNode).LogNode
  {$endif}
  else
  begin
    Result := -3;
    Exit;
  end;
  try
    N.FLogNode.OnAddToLog := OnAddToLog;
    Result := 0;
  except
    Result := -1;
  end;
end;

function ALogNode_Show(LogNode: ALogNode): AError;
begin
  {$ifdef UseLogImpl}
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
  {$else}
  Result := 0;
  {$endif}
end;

end.
