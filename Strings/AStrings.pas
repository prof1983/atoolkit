{**
@Abstract AStrings
@Author Prof1983 <prof1983@ya.ru>
@Created 24.05.2011
@LastMod 18.02.2013
}
unit AStrings;

interface

uses
  ABase,
  AStringsMain;

// ----

function Fin(): AError; stdcall;

function Init(): AError; stdcall;

implementation

{ Public }

function Fin(): AError;
begin
  Result := AStrings_Fin();
end;

function Init(): AError;
begin
  Result := AStrings_Init();
end;

end.
