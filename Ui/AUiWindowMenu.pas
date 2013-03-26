{**
@Authpor Prof1983 <prof1983@ya.ru>
@Created 26.03.2013
@LastMod 26.03.2013
}
unit AUiWindowMenu;

interface

uses
  ABase,
  AUiBase;

function AUiWindow_SetMenu(Window: AWindow; Menu: AMenu): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

uses
  Forms,
  Menus;

function AUiWindow_SetMenu(Window: AWindow; Menu: AMenu): AError;
begin
  try
    TForm(Window).Menu := TMainMenu(Menu);
    Result := 0;
  except
    Result := -1;
  end;
end;

end.
