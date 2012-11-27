{**
@Abstract AXmlDucument functions
@Author Prof1983 <prof1983@ya.ru>
@Created 28.06.2012
@LastMod 27.11.2012
}
unit AXmlDocumentUtils;

{$define AStdCall}

interface

uses
  ABase, AXmlNodeUtils;

function AXmlDocument_CloseDocument(XmlDocument: AXmlDocument): AError; {$ifdef AStdCall}stdcall;{$endif}

function AXmlDocument_Free(XmlDocument: AXmlDocument): AError; {$ifdef AStdCall}stdcall;{$endif}

function AXmlDocument_GetDocumentElement(XmlDocument: AXmlDocument): AProfXmlNode; {$ifdef AStdCall}stdcall;{$endif}

function AXmlDocument_Initialize(XmlDocument: AXmlDocument): AError; {$ifdef AStdCall}stdcall;{$endif}

function AXmlDocument_LoadFromString(XmlDocument: AXmlDocument; const S: APascalString): AError; deprecated; // Use AXmlDocument_LoadFromStringP()

function AXmlDocument_LoadFromStringP(XmlDocument: AXmlDocument; const S: APascalString): AError;

function AXmlDocument_New(): AXmlDocument; {$ifdef AStdCall}stdcall;{$endif}

function AXmlDocument_SaveToFile1(Document: AProfXmlDocument1; const FileName: APascalString): AError; deprecated; // Use AXmlDocument_SaveToFileP()

function AXmlDocument_SaveToFileP(Document: AProfXmlDocument1; const FileName: APascalString): AError;

implementation

uses
  AXmlDocumentImpl;

// --- Private ---

function ProfXmlDocument_SaveToFile(Document: TProfXmlDocument; const FileName: WideString): WordBool;
var
  F: TextFile;
  TmpFileName: WideString;
  S: WideString;
begin
  Result := False;
  try
    if (FileName = '') then
      TmpFileName := Document.FFileName
    else
      TmpFileName := FileName;

    if Assigned(Document.FDocument) and Document.FDocument.Active then
    begin
      try
        Document.FDocument.SaveToFile(TmpFileName);
        Result := True;
      except
        Result := False;
      end;
      Exit;
    end;

    Document.SaveToString(S);

    AssignFile(F, TmpFileName);
    {$I-}
    Rewrite(F);
    WriteLn(F, String(S));
    CloseFile(F);
    {$I+}
    Result := (IOResult = 0);
  except
  end;
end;

// --- AXmlDocument ---

function AXmlDocument_CloseDocument(XmlDocument: AXmlDocument): AError;
begin
  if (TObject(XmlDocument) is TProfXmlDocument) then
  begin
    TProfXmlDocument(XmlDocument).CloseDocument();
    Result := 0;
  end
  else
    Result := -2;
end;

function AXmlDocument_Free(XmlDocument: AXmlDocument): AError;
begin
  if (TObject(XmlDocument) is TProfXmlDocument) then
  begin
    TProfXmlDocument(XmlDocument).Free();
    Result := 0;
  end
  else
    Result := -2;
end;

function AXmlDocument_GetDocumentElement(XmlDocument: AXmlDocument): AProfXmlNode;
var
  D: TProfXmlDocument;
begin
  if (TObject(XmlDocument) is TProfXmlDocument) then
  begin
    D := TProfXmlDocument(XmlDocument);
    if (D.FDocumentElement = 0) then
    begin
      if not(Assigned(D.FDocument)) then
      begin
        Result := 0;
        Exit;
      end;
      D.FDocumentElement := AXmlNode_New2(D.FDocument.DocumentElement)
    end;
    Result := D.FDocumentElement;
  end
  else
    Result := 0;
end;

function AXmlDocument_Initialize(XmlDocument: AXmlDocument): AError;
begin
  if (TObject(XmlDocument) is TProfXmlDocument) then
  begin
    TProfXmlDocument(XmlDocument).Initialize();
    Result := 0;
  end
  else
    Result := -2;
end;

function AXmlDocument_LoadFromString(XmlDocument: AXmlDocument; const S: APascalString): AError;
begin
  Result := AXmlDocument_LoadFromStringP(XmlDocument, S);
end;

function AXmlDocument_LoadFromStringP(XmlDocument: AXmlDocument; const S: APascalString): AError;
begin
  if (TObject(XmlDocument) is TProfXmlDocument) then
  begin
    if TProfXmlDocument(XmlDocument).LoadFromString(S) then
      Result := 0
    else
      Result := -1;
  end
  else
    Result := -2;
end;

function AXmlDocument_New(): AXmlDocument;
begin
  Result := AXmlDocument(TProfXmlDocument.Create());
end;

function AXmlDocument_SaveToFile1(Document: AProfXmlDocument1; const FileName: APascalString): AError;
begin
  Result := AXmlDocument_SaveToFileP(Document, FileName);
end;

function AXmlDocument_SaveToFileP(Document: AProfXmlDocument1; const FileName: APascalString): AError;
begin
  if not(TObject(Document) is TProfXmlDocument) then
  begin
    Result := -2;
    Exit;
  end;
  if ProfXmlDocument_SaveToFile(TProfXmlDocument(Document), FileName) then
    Result := 0
  else
    Result := -3;
end;

end.
