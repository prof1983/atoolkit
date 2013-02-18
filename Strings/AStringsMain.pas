{**
@Abstract AStrings
@Author Prof1983 <prof1983@ya.ru>
@Created 24.05.2011
@LastMod 18.02.2013
}
unit AStringsMain;

interface

uses
  ABase;

// --- AStrings ---

function AStrings_Fin(): AError; stdcall;

function AStrings_Init(): AError; stdcall;

implementation

// --- AStrings ---

function AStrings_Fin(): AError;
begin
  Result := 0;
end;

function AStrings_Init(): AError;
begin
  Result := 0;
end;

end.
