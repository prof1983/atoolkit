{**
@Abstract(Работа с XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.10.2005)
@LastMod(29.06.2012)
@Version(0.5)
}
unit AXml3;

interface

uses
  AXmlDocumentImpl, AXmlNodeImpl;

type
  TProfXmlDocument = AXmlDocumentImpl.TProfXmlDocument;
  TProfXmlDocument3 = AXmlDocumentImpl.TProfXmlDocument;
  TProfXmlNode = TProfXmlNode4;
  TProfXmlNode3 = TProfXmlNode4;

//function ProfXmlDocument_SaveToFile3(Document: TProfXmlDocument3; const AFileName: WideString): WordBool;

implementation

{ Public }

(*
function ProfXmlDocument_SaveToFile3(Document: TProfXmlDocument3; const AFileName: WideString): WordBool;
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
    Document.FController.SaveToFile(AFileName);
    Result := True;
  except
  end;
end;
*)

end.
