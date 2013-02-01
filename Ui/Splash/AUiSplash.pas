{**
@Abstract AUi Splash
@Author Prof1983 <prof1983@ya.ru>
@Created 08.12.2009
@LastMod 31.01.2013
}
unit AUiSplash;

interface

uses
  ABase,
  AUiSplashMain;

// ---- Public ---

function Init(): AError; stdcall;

function Fin(): AError; stdcall;

function Hide(): AError; stdcall;

function Sleep(): AError; stdcall;

function StepIt(const Text: APascalString): AInteger; stdcall;

implementation

// --- Public ---

function Fin(): AError;
begin
  Result := AUiSplash_Fin();
end;

function Hide(): AError;
begin
  Result := AUiSplash_Hide();
end;

function Init(): AError;
begin
  Result := AUiSplash_Init();
end;

function Sleep(): AError;
begin
  Result := AUiSplash_Sleep();
end;

function StepIt(const Text: APascalString): AInteger;
begin
  Result := AUiSplash_StepItP(Text);
end;

end.
 
