{**
@Abstract ACore
@Author Prof1983 <prof1983@ya.ru>
@Created 30.10.2009
@LastMod 25.02.2013
}
unit ACore;

{define Static}

interface

uses
  ABase, ALibraries;

{$ifdef Static}

function ACore_Boot(): AError; stdcall;
function ACore_Fin(): AError; stdcall;
function ACore_Init(): AError; stdcall;
function ACore_Run(): AError; stdcall;

{$else}

type
  ACore_Boot_Proc = AProc;
  ACore_Fin_Proc = AProc;
  ACore_Init_Proc = AProc;
  ACore_Run_Proc = AProc;

var
  ACore_Boot: ACore_Boot_Proc;
  ACore_Fin: ACore_Fin_Proc;
  ACore_Init: ACore_Init_Proc;
  ACore_Run: ACore_Run_Proc;

// --- CoreLib ---

function ACoreLib_Close(): AError;

function ACoreLib_GetLib(): ALibrary;

function ACoreLib_Open(const CoreLibName: APascalString): AError;

{$endif Static}

implementation

{$ifdef Static}

const
  ACoreLibName = 'ACore32.dll';

function ACore_Boot(): AError; external ACoreLibName;
function ACore_Fin(): AError; external ACoreLibName;
function ACore_Init(): AError; external ACoreLibName;
function ACore_Run(): AError; external ACoreLibName;

{$else} // Static

const
  ACoreLibNameDef = 'ACore32.dll';

var
  FLib: ALibrary;

{ CoreLib }

function ACoreLib_Close(): AError;
begin
  if (FLib <> 0) then
  begin
    ALibrary_Close(FLib);
    FLib := 0;
  end;
  Result := 0;
end;

function ACoreLib_GetLib(): ALibrary;
begin
  Result := FLib;
end;

function ACoreLib_Open(const CoreLibName: APascalString): AError;
begin
  if (CoreLibName = '') then
    FLib := ALibrary_OpenP(ACoreLibNameDef, 0)
  else
    FLib := ALibrary_OpenP(CoreLibName, 0);
  if (FLib = 0) then
  begin
    Result := -1;
    Exit;
  end;
  Result := -2;
  if not(ALibrary_GetSymbolP(FLib, 'ACore_Boot', Addr(ACore_Boot))) then Exit;
  if not(ALibrary_GetSymbolP(FLib, 'ACore_Fin', Addr(ACore_Fin))) then Exit;
  if not(ALibrary_GetSymbolP(FLib, 'ACore_Init', Addr(ACore_Init))) then Exit;
  if not(ALibrary_GetSymbolP(FLib, 'ACore_Run', Addr(ACore_Run))) then Exit;
  Result := 0;
end;

{$endif Static}

end.
