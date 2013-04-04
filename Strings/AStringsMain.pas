{**
@Abstract AStrings
@Author Prof1983 <prof1983@ya.ru>
@Created 24.05.2011
@LastMod 04.04.2013
}
unit AStringsMain;

interface

uses
  ABase;

// --- AStrings ---

function AStrings_Fin(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AStrings_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

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
