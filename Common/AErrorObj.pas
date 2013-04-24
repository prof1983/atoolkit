{**
@Author Prof1983 <prof1983@ya.ru>
@Created 12.04.2013
@LastMod 24.04.2013
}
unit AErrorObj;

interface

uses
  ABase;

// --- AError ---

function AError_Free(Er: AError): AError; {$ifdef AStdCall}stdcall;{$endif}

function AError_GetMsgP(Er: AError): APascalString;

function AError_InsertLnP(Er: AError; const S: APascalString): AError;

function AError_InsertP(Er: AError; const S: APascalString): AError;

function AError_NewP(const Msg: APascalString): AError;

implementation

const
  EndLine = #13#10;

type
  AError_Type = record
    Time: TDateTime;
    Msg: APascalString;
  end;
  PError = ^AError_Type;

// --- AError ---

function AError_Free(Er: AError): AError;
begin
  if (Er >= -1000) and (Er <= 1000) then
  begin
    Result := -2;
    Exit;
  end;
  try
    FreeMem(PError(Er));
    Result := 0;
  except
    Result := -3;
  end;
end;

function AError_GetMsgP(Er: AError): APascalString;
begin
  if (Er >= -1000) and (Er <= 1000) then
  begin
    Result := '';
    Exit;
  end;
  try
    Result := PError(Er)^.Msg;
  except
    Result := '';
  end;
end;

function AError_InsertLnP(Er: AError; const S: APascalString): AError;
begin
  if (S = '') then
  begin
    Result := -3;
    Exit;
  end;
  Result := AError_InsertP(Er, EndLine + S);
end;

function AError_InsertP(Er: AError; const S: APascalString): AError;
begin
  if (Er >= -1000) and (Er <= 1000) then
  begin
    Result := -2;
    Exit;
  end;
  PError(Er)^.Msg := PError(Er)^.Msg + S;
  Result := 0;
end;

function AError_NewP(const Msg: APascalString): AError;
var
  P: PError;
begin
  try
    GetMem(P, SizeOf(AError_Type));
    Result := AError(P);
  except
    Result := -1;
  end;
end;

end.
