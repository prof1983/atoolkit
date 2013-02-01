{**
@Abstract ACore
@Author Prof1983 <prof1983@ya.ru>
@Created 30.10.2009
@LastMod 30.01.2013
}
unit ACore;

{define Static}

interface

uses
  ABase, ALibraries;

{$ifdef Static}

function Core_Boot(): Integer; stdcall;
function Core_Init(): Integer; stdcall;
function Core_Fin(): Integer; stdcall;
function Core_Run(): Integer; stdcall;

{$else}

type
  A_Core_Boot_Proc = AProc;
  A_Core_Fin_Proc = AProc;
  A_Core_Init_Proc = AProc;
  A_Core_Run_Proc = AProc;

var
  Core_Boot: A_Core_Boot_Proc;
  Core_Fin: A_Core_Fin_Proc;
  Core_Init: A_Core_Init_Proc;
  Core_Run: A_Core_Run_Proc;

procedure CoreLib_Close;

function CoreLib_GetLib(): ALibrary;

function CoreLib_Open(const CoreLibName: string): AInteger;

{$endif Static}

implementation

{$ifdef Static}

const
  ACoreLibName = 'ACore32.dll';

function Core_Boot; external ACoreLibName;
function Core_Fin; external ACoreLibName;
function Core_Init; external ACoreLibName;
function Core_Run; external ACoreLibName;

{$else} // Static

const
  ACoreLibNameDef = 'ACore32.dll';

var
  FLib: ALibrary;

{ CoreLib }

procedure CoreLib_Close();
begin
  if (FLib <> 0) then
  begin
    ALibrary_Close(FLib);
    FLib := 0;
  end;
end;

function CoreLib_GetLib(): ALibrary;
begin
  Result := FLib;
end;

function CoreLib_Open(const CoreLibName: string): Integer;
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
  if not(ALibrary_GetSymbolP(FLib, 'Core_Boot', Addr(Core_Boot))) then Exit;
  if not(ALibrary_GetSymbolP(FLib, 'Core_Fin', Addr(Core_Fin))) then Exit;
  if not(ALibrary_GetSymbolP(FLib, 'Core_Init', Addr(Core_Init))) then Exit;
  if not(ALibrary_GetSymbolP(FLib, 'Core_Run', Addr(Core_Run))) then Exit;
  Result := 0;
end;

{$endif Static}

end.
