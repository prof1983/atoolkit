{**
@Abstract AUi Splash
@Author Prof1983 <prof1983@ya.ru>
@Created 08.12.2009
@LastMod 23.04.2013
}
unit AUiSplash;

interface

uses
  ABase,
  AUiSplashMain;

// ----

function Init(): AError; stdcall; deprecated; // Use AUiSplash_Init()
function Done(): AError; stdcall; deprecated; // Use AUiSplash_Fin()

procedure Hide; stdcall;
procedure Sleep; stdcall;
function StepIt(const Text: APascalString): AInteger; stdcall;

implementation

{ Public }

function Done(): AError; stdcall;
begin
  try
    Result := AUiSplash_Fin();
  except
    Result := -1;
  end;
end;

procedure Hide; stdcall;
begin
  AUiSplash_Hide();
end;

function Init(): AError; stdcall;
begin
  try
    Result := AUiSplash_Init();
  except
    Result := -1;
  end;
end;

procedure Sleep; stdcall;
begin
  AUiSplash_Sleep();
end;

function StepIt(const Text: APascalString): AInteger; stdcall;
begin
  Result := AUiSplash_StepItP(Text);
end;

end.
 
