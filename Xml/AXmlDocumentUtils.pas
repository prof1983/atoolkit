{**
@Abstract(AXmlDucument functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(28.06.2012)
@LastMod(28.06.2012)
@Version(0.5)
}
unit AXmlDocumentUtils;

interface

type
  AProfXmlDocument1 = type Integer; // TProfXmlDocument1

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

function AXmlDocument_SaveToFile1(Document: AProfXmlDocument1; const FileName: APascalString): AError;
begin
  if not(TObject(Document) is TProfXmlDocument1) then
  begin
    Result := -2;
    Exit;
  end;
  if ProfXmlDocument_SaveToFile1(TProfXmlDocument1, FileName) then
    Result := 0
  else
    Result := -3;
end;

end.
