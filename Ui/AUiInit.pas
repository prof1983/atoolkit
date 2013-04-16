{**
@Abstract AUi
@Author Prof1983 <prof1983@ya.ru>
@Created 03.09.2012
@LastMod 16.04.2013
}
unit AUiInit;

{$I A.inc}
{$I Defines.inc}
{$define AStdCall}

interface

uses
  ABase, ASystemMain,
  AUiConsts,
  AUiData,
  AUiDialogsEx2,
  AUiMenus,
  AUiTrayIcon;

// --- AUi ---

function AUi_InitMainTrayIcon(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_InitMenus(): AError; {$ifdef AStdCall}stdcall;{$endif}

// --- UI ---

function UI_InitMainMenu(): AInteger; stdcall;

function UI_InitMainTrayIcon(): AInteger; stdcall; deprecated; // Use AUi_InitMainTrayIcon()

procedure UI_InitMenus(); stdcall; deprecated; // Use AUi_InitMenus()

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
  miFile := AUiMenus.Ui_MenuItem_Add(miMain, 'File', miFileText, nil, 0, 100, 0);

  {$IFDEF A01}
    AUiMenus.Ui_MenuItem_Add(miFile, 'Exit', miExitText, miExitClick02, 0, 10000, 0);
  {$ELSE}
    {$IFDEF A02}
    AUiMenus.Ui_MenuItem_Add(miFile, 'Exit', miExitText, miExitClick02, 0, 10000, 0);
    {$ELSE}
    AUiMenus.Ui_MenuItem_Add(miFile, 'Exit', miExitText, miExitClick, 0, 10000, 0);
    {$ENDIF A02}
  {$ENDIF A01}

  miHelp := AUiMenus.Ui_MenuItem_Add(miMain, 'Help', miHelpText, nil, 0, 1000, 0);

  {$IFDEF A01}
    AUiMenus.Ui_MenuItem_Add(miHelp, 'About', miAboutText, miAboutClick1, 0, 1000, 0);
  {$ELSE}
    {$IFDEF A02}
    AUiMenus.Ui_MenuItem_Add(miHelp, 'About', miAboutText, miAboutClick1, 0, 1000, 0);
    {$ELSE}
    AUiMenus.Ui_MenuItem_Add(miHelp, 'About', miAboutText, miAboutClick, 0, 1000, 0);
    {$ENDIF A02}
  {$ENDIF A01}

  Result := 0;
end;

// --- UI ---

function UI_InitMainMenu(): AInteger;
begin
  Result := 0;
end;

function UI_InitMainTrayIcon(): AInteger;
begin
  Result := AUi_InitMainTrayIcon();
end;

procedure UI_InitMenus();
begin
  AUi_InitMenus();
end;

end.
