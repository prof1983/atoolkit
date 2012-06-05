{**
@Abstract(ACore)
@Author(Prof1983 prof1983@yandex.ru)
@Created(30.10.2009)
@LastMod(12.04.2012)
@Version(0.5)
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
{$IFDEF A01}
{$ELSE}
  {$IFDEF A02}
  {$ELSE}
  ARuntime0,
  {$ENDIF A02}
{$ENDIF A01}
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
  Core_Init: A_Core_Init_Proc;
  Core_Run: A_Core_Run_Proc;
  Core_Done: A_Core_Done_Proc;
  //Core_Runtime: A_Core_Runtime_Proc;
  {$ENDIF A02}
{$ENDIF A01}

function CoreLib_Open(const CoreLibName: string): AInteger;
procedure CoreLib_Close;

{$ENDIF STATIC}

implementation

{$IFDEF STATIC}

const
  ACoreLibName = {$IFDEF A01}'ACore01.dll'{$ELSE}'ACore02.dll'{$ENDIF};

function Core_Boot; external ACoreLibName;
function Core_BootA; external ACoreLibName;
function Core_BootXml; external ACoreLibName;
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
    Library_Close(FLib);
    FLib := 0;
  end;
end;

function CoreLib_Open(const CoreLibName: string): Integer;
begin
  if (CoreLibName = '') then
    FLib := Library_Open(ACoreLibNameDef, 0)
  else
    FLib := Library_Open(CoreLibName, 0);
  if (FLib = 0) then
  begin
    Result := -1;
    Exit;
  end;
  Result := -2;
 {$IFDEF A01}
  if not(Library_GetSymbol(FLib, 'Core_Boot', Addr(Core_Boot))) then Exit;
  if not(Library_GetSymbol(FLib, 'Core_BootA', Addr(Core_BootA))) then Exit;
  if not(Library_GetSymbol(FLib, 'Core_Init', Addr(Core_Init))) then Exit;
  if not(Library_GetSymbol(FLib, 'Core_Run', Addr(Core_Run))) then Exit;
  if not(Library_GetSymbol(FLib, 'Core_Done', Addr(Core_Done))) then Exit;
 {$ELSE} // A01
  {$IFDEF A02}
  if not(Library_GetSymbol(FLib, 'Core_Boot', Addr(Core_Boot))) then Exit;
  if not(Library_GetSymbol(FLib, 'Core_BootA', Addr(Core_BootA))) then Exit;
  if not(Library_GetSymbol(FLib, 'Core_BootXml', Addr(Core_BootXml))) then Exit;
  if not(Library_GetSymbol(FLib, 'Core_Init', Addr(Core_Init))) then Exit;
  if not(Library_GetSymbol(FLib, 'Core_Run', Addr(Core_Run))) then Exit;
  if not(Library_GetSymbol(FLib, 'Core_Done', Addr(Core_Done))) then Exit;
  {$ELSE} // A02
  if not(Library_GetSymbol(FLib, 'Core_Boot', Addr(Core_Boot))) then Exit;
  if not(Library_GetSymbol(FLib, 'Core_Init', Addr(Core_Init))) then Exit;
  if not(Library_GetSymbol(FLib, 'Core_Run', Addr(Core_Run))) then Exit;
  if not(Library_GetSymbol(FLib, 'Core_Done', Addr(Core_Done))) then Exit;
  //if not(Library_GetSymbol(FLib, 'Core_Runtime', Addr(Core_Runtime))) then Exit;
  {$ENDIF A02}
 {$ENDIF A01}
  Result := 0;
end;

{$ENDIF STATIC}

end.
