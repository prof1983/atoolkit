{**
@Abstract(AXmlDucument functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(28.06.2012)
@LastMod(04.07.2012)
@Version(0.5)
}
unit AXmlDocumentUtils;

interface

uses
  ABase, AXmlNodeUtils;

function AXmlDocument_CloseDocument(XmlDocument: AXmlDocument): AError;

function AXmlDocument_Free(XmlDocument: AXmlDocument): AError;

function AXmlDocument_GetDocumentElement(XmlDocument: AXmlDocument): AProfXmlNode;

function AXmlDocument_Initialize(XmlDocument: AXmlDocument): AError;

function AXmlDocument_LoadFromString(XmlDocument: AXmlDocument; const S: APascalString): AError;

function AXmlDocument_New(): AXmlDocument;

function AXmlDocument_SaveToFile1(Document: AProfXmlDocument1; const FileName: APascalString): AError;

implementation

uses
  AXmlDocumentImpl;

// --- Private ---

function ProfXmlDocument_SaveToFile1(Document: TProfXmlDocument1; const AFileName: WideString): WordBool;
begin
  {try
    FDocument.SaveToFile(AFileName);
    Result := True;
  except
    on E: Exception do begin
      AddToLog(lgGeneral, ltError, err_SaveToFile, [AFileName, E.Message]);
      Result := False;
    end;
  end;}
  Result := False;
  try
    Document.SaveToFile(AFileName);
    Result := True;
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
  D1: TProfXmlDocument1;
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
      D.FDocumentElement := AXmlNode2_New(D.FDocument.DocumentElement)
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
  if not(TObject(Document) is TProfXmlDocument1) then
  begin
    Result := -2;
    Exit;
  end;
  if ProfXmlDocument_SaveToFile1(TProfXmlDocument1(Document), FileName) then
    Result := 0
  else
    Result := -3;
end;

end.
