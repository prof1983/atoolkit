{**
@Abstract AUi
@Author Prof1983 <prof1983@ya.ru>
@Created 03.09.2012
@LastMod 30.01.2013
}
unit AUiInit;

{$I A.inc}
{$I Defines.inc}

{define AStdCall}

interface

uses
  ABase,
  ASystemMain,
  AUiAboutDialog,
  AUiConsts,
  AUiData,
  AUiMenus,
  AUiTrayIcon;

// --- AUi ---

function AUi_InitMainTrayIcon(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_InitMenus(): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

// --- Events ---

function miAboutClick(Obj, Data: AInteger): AError; stdcall;
begin
  if Assigned(UiAboutClick) then
    UiAboutClick
  else
    AUi_ExecuteAboutDialog();
  Result := 0;
end;

procedure miAboutClick1(Obj, Data: AInteger); stdcall;
begin
  if Assigned(UiAboutClick) then
    UiAboutClick
  else
    AUi_ExecuteAboutDialog();
end;

function miExitClick(Obj, Data: AInteger): AError; stdcall;
begin
  {$IFDEF NoRuntimeEvents}
  AUi_Shutdown();
  {$ELSE}
  ASystem_Shutdown();
  {$ENDIF}
  Result := 0;
end;

procedure miExitClick02(Obj, Data: AInteger); stdcall;
begin
  {$IFDEF NoRuntimeEvents}
  AUi_Shutdown();
  {$ELSE}
  ASystem_Shutdown();
  {$ENDIF}
end;

// --- AUi ---

function AUi_InitMainTrayIcon(): AError;
begin
  {IFNDEF UNIX}
  if (FMainTrayIcon = 0) then
  try
    {$IFDEF FPC}
    FMainTrayIcon := AddObject(TAUiTrayIcon.Create(nil));
    {$ELSE}
    FMainTrayIcon := AddObject(TAUiTrayIcon.Create());
    {$ENDIF}
  except
    FMainTrayIcon := 0;
  end;
  {ENDIF}
  try
    if (FMainTrayIcon <> 0) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function AUi_InitMenus(): AError;
begin
  miFile := AUiMenu_AddItem1P(miMain, 'File', miFileText, nil, 0, 100);
  AUiMenu_AddItem1P(miFile, 'Exit', miExitText, miExitClick, 0, 10000);
  miHelp := AUiMenu_AddItem1P(miMain, 'Help', miHelpText, nil, 0, 1000);
  AUiMenu_AddItem1P(miHelp, 'About', miAboutText, miAboutClick, 0, 1000);
  Result := 0;
end;

end.
