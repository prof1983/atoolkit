{**
@Abstract AUiSettings
@Author Prof1983 <prof1983@ya.ru>
@Created 13.03.2009
@LastMod 13.12.2012
}
unit AUiSettings;

interface

uses
  ABase,
  AUiBase,
  AUiSettingsBase, AUiSettingsMain;

// ----

function Init(): AError; stdcall; deprecated; // Use AUiSettings_Init()
function Done(): AError; stdcall; deprecated; // Use AUiSettings_Fin()

function Init03(): AInteger; stdcall;
function Done03(): AInteger; stdcall;

function MainSettingsWin(): AWindow; stdcall; deprecated; // Use AUiSettings_GetMainSettingsWin()

function NewItemWS(Parent: AUISettingsItem; const Text: APascalString): AUISettingsItem; stdcall; deprecated; // Use AUiSettings_NewItemWS()

function SettingsWin_New(): AWindow; stdcall; deprecated; // Use AUiSettings_NewSettingsWin()

procedure ShowSettingsWin(); stdcall; deprecated; // Use AUiSettings_ShowSettingsWin()

implementation

{ Public }

function Done(): AError; stdcall;
begin
  Result := AUiSettings_Fin();
end;

function Done03(): AInteger; stdcall;
begin
  Result := AUiSettings_Fin();
end;

function Init(): AError; stdcall;
begin
  Result := AUiSettings_Init();
end;

function Init03(): AInteger; stdcall;
begin
  Result := AUiSettings_Init();
end;

function MainSettingsWin(): AWindow; stdcall;
begin
  Result := AUiSettings_GetMainSettingsWin();
end;

function NewItemWS(Parent: AUISettingsItem; const Text: APascalString): AUISettingsItem; stdcall;
begin
  Result := AUiSettings_NewItemP(Parent, Text);
end;

function SettingsWin_New(): AWindow; stdcall;
begin
  Result := AUiSettings_NewSettingsWin();
end;

procedure ShowSettingsWin(); stdcall;
begin
  AUiSettings_ShowSettingsWin();
end;

end.
