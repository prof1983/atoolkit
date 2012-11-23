{**
@Abstract ACore
@Author Prof1983 <prof1983@ya.ru>
@Created 30.10.2009
@LastMod 22.11.2012
}
unit ACore;

{DEFINE A02}
{DEFINE STATIC}

{$IFNDEF A01}
  {$IFNDEF A02}
    {$IFNDEF A03}
      {$DEFINE A04}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

interface

uses
  ABase, ALibraries;

{$IFDEF STATIC}

function Core_Boot(const Title, ProgramName, Url, Description: WideString): Integer; stdcall; {deprecated}
function Core_BootA(const Title, ProgramName, ProgramVersion, ProductName, ProductVersion,
    CompanyName, Copyright, Url, Description: WideString): Integer; stdcall; {deprecated}
function Core_BootXml(Params: WideString): Integer; stdcall; {deprecated}
function Core_Init: Integer; stdcall;
function Core_Run: Integer; stdcall;
function Core_Done: Integer; stdcall;

{$ELSE}

type
{$IFDEF A01}
  A_Core_Boot_Proc = function(const Title, ProgramName, Url, Description: WideString): Integer; stdcall;
  A_Core_BootA_Proc = function(const Title, ProgramName, ProgramVersion, ProductName, ProductVersion,
      CompanyName, Copyright, Url, Description: WideString): Integer; stdcall;
  A_Core_Init_Proc = function(): Integer; stdcall;
  A_Core_Run_Proc = function(): Integer; stdcall;
  A_Core_Done_Proc = function(): Integer; stdcall;
{$ELSE} // A01
  {$IFDEF A02}
  ACore_Boot = function(const Title, ProgramName, Url, Description: WideString): Integer; stdcall; {deprecated}
  ACore_BootA = function(const Title, ProgramName, ProgramVersion, ProductName, ProductVersion,
    CompanyName, Copyright, Url, Description: WideString): Integer; stdcall; {deprecated}
  ACore_BootXml = function(Params: WideString): Integer; stdcall; {deprecated}
  ACore_Init = function: Integer; stdcall;
  ACore_Run = function: Integer; stdcall;
  ACore_Done = function: Integer; stdcall;
  {$ELSE} // A02
  A_Core_Boot_Proc = AProc;
  A_Core_Fin_Proc = AProc;
  A_Core_Init_Proc = AProc;
  A_Core_Run_Proc = AProc;
  A_Core_Done_Proc = AProc;
  //A_Core_Runtime_Proc = function: ARuntimeProcs; stdcall;
  {$ENDIF A02}
{$ENDIF A01}

var
{$IFDEF A01}
  Core_Boot: A_Core_Boot_Proc;
  Core_BootA: A_Core_BootA_Proc;
  Core_Init: A_Core_Init_Proc;
  Core_Run: A_Core_Run_Proc;
  Core_Done: A_Core_Done_Proc;
{$ELSE}
  {$IFDEF A02}
  Core_Boot: ACore_Boot;
  Core_BootA: ACore_BootA;
  Core_BootXml: ACore_BootXml;
  Core_Init: ACore_Init;
  Core_Run: ACore_Run;
  Core_Done: ACore_Done;
  {$ELSE}
  Core_Boot: A_Core_Boot_Proc;
  Core_Fin: A_Core_Fin_Proc;
  Core_Init: A_Core_Init_Proc;
  Core_Run: A_Core_Run_Proc;
  Core_Done: A_Core_Done_Proc;
  //Core_Runtime: A_Core_Runtime_Proc;
  {$ENDIF A02}
{$ENDIF A01}

procedure CoreLib_Close;

function CoreLib_GetLib(): ALibrary;

function CoreLib_Open(const CoreLibName: string): AInteger;

{$ENDIF STATIC}

implementation

{$IFDEF STATIC}

const
  ACoreLibName = {$IFDEF A01}'ACore01.dll'{$ELSE}'ACore02.dll'{$ENDIF};

function Core_Boot; external ACoreLibName;
function Core_BootA; external ACoreLibName;
function Core_BootXml; external ACoreLibName;
function Core_Fin; external ACoreLibName;
function Core_Init; external ACoreLibName;
function Core_Run; external ACoreLibName;
function Core_Done; external ACoreLibName;

{$ELSE} // STATIC

const
  ACoreLibNameDef = {$IFDEF A01}'ACore01.dll'{$ELSE}{$IFDEF A02}'ACore02.dll'{$ELSE}{$IFDEF A03}'ACore03.dll'{$ELSE}'ACore32.dll'{$ENDIF}{$ENDIF}{$ENDIF};

var
  FLib: ALibrary;

{ CoreLib }

procedure CoreLib_Close;
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
 {$IFDEF A01}
  if not(ALibrary_GetSymbol(FLib, 'Core_Boot', Addr(Core_Boot))) then Exit;
  if not(ALibrary_GetSymbol(FLib, 'Core_BootA', Addr(Core_BootA))) then Exit;
  if not(ALibrary_GetSymbol(FLib, 'Core_Init', Addr(Core_Init))) then Exit;
  if not(ALibrary_GetSymbol(FLib, 'Core_Run', Addr(Core_Run))) then Exit;
  if not(ALibrary_GetSymbol(FLib, 'Core_Done', Addr(Core_Done))) then Exit;
 {$ELSE} // A01
  {$IFDEF A02}
  if not(ALibrary_GetSymbol(FLib, 'Core_Boot', Addr(Core_Boot))) then Exit;
  if not(ALibrary_GetSymbol(FLib, 'Core_BootA', Addr(Core_BootA))) then Exit;
  if not(ALibrary_GetSymbol(FLib, 'Core_BootXml', Addr(Core_BootXml))) then Exit;
  if not(ALibrary_GetSymbol(FLib, 'Core_Init', Addr(Core_Init))) then Exit;
  if not(ALibrary_GetSymbol(FLib, 'Core_Run', Addr(Core_Run))) then Exit;
  if not(ALibrary_GetSymbol(FLib, 'Core_Done', Addr(Core_Done))) then Exit;
  {$ELSE} // A02
  if not(ALibrary_GetSymbolP(FLib, 'Core_Boot', Addr(Core_Boot))) then Exit;
  if not(ALibrary_GetSymbolP(FLib, 'Core_Fin', Addr(Core_Fin))) then Exit;
  if not(ALibrary_GetSymbolP(FLib, 'Core_Init', Addr(Core_Init))) then Exit;
  if not(ALibrary_GetSymbolP(FLib, 'Core_Run', Addr(Core_Run))) then Exit;
  if not(ALibrary_GetSymbolP(FLib, 'Core_Done', Addr(Core_Done))) then Exit;
  //if not(Library_GetSymbol(FLib, 'Core_Runtime', Addr(Core_Runtime))) then Exit;
  {$ENDIF A02}
 {$ENDIF A01}
  Result := 0;
end;

{$ENDIF STATIC}

end.
