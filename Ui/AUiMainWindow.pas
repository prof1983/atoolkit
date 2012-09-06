{**
@Abstract AUiMainWindow
@Author Prof1983 <prof1983@ya.ru>
@Created 13.10.2008
@LastMod 06.09.2012
}
unit AUiMainWindow;

{$I Defines.inc}

{$IFNDEF NoSettings}
  {$DEFINE USE_SETTINGS}
{$ENDIF}

{$define AStdCall}

interface

uses
  Classes, ComCtrls, Controls, ExtCtrls, Forms, Graphics, Menus, StdCtrls, SysUtils, {$IFNDEF UNIX}Windows,{$ENDIF}
  ABase,
  {$IFDEF OLDMAINFORM}fMain,{$ENDIF}
  AUiBase, AUiBox, AUiControls, AUiData,
  {$IFDEF USE_SETTINGS}AUiForm,{$ENDIF}
  AUiMainWindowData, AUiToolBar;

type
  TMainWindowFormat = type Integer;
const
  MainWindowFormatCreateMenu = $00000001;
  MainWindowFormatCreateToolBar = $00000002;
  MainWindowFormatCreateStatusBar = $00000004;
  MainWindowFormatCreatePanels = $00000008;
  MainWindowFormatCreateAll = $000000FF;

// --- AUi ---

function AUi_SetMainWindow(Value: AWindow): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_SetMainWindow2(Value: AWindow; ToolBar, StatusBar: AControl;
    Config: AConfig): AError; {$ifdef AStdCall}stdcall;{$endif}

// --- AUiMainWindow ---

function AUiMainWindow_GetLeftContainer(): AControl; {$ifdef AStdCall}stdcall;{$endif}

{** Возврящает основной контейнер UI }
function AUiMainWindow_GetMainContainer(): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiMainWindow_GetRightContainer(): AControl; {$ifdef AStdCall}stdcall;{$endif}

// ---

function _MainWindow_GetLeftContainer: AControl;
function _MainWindow_GetMainContainer: AControl;
function _MainWindow_GetRightContainer: AControl;

procedure _MainWindow_LoadConfig(Config: AConfig);
procedure _MainWindow_SaveConfig(Config: AConfig);

procedure _MainWindow_Create(Form: TForm; Format: TMainWindowFormat; Config: AConfig);
procedure _MainWindow_Init;
procedure _MainWindow_Set(Value: AWindow); stdcall;
procedure _MainWindow_SetA(Window: AWindow; ToolBar, StatusBar: AControl; Config: AConfig);
procedure _MainWindow_Shutdown;
function _MainWindow_ToolBar: AControl;
procedure _MainWindow_ToolBar_Set(ToolBar: AControl);

{$IFDEF UNIX}
const
  miAboutCaption = 'About...';
  miHelpCaption = 'Help';
{$ELSE}
  {$IFDEF DELPHI_XE_UP}
    {$I AUi.ru.utf8.inc}
  {$ELSE}
    {$I AUi.ru.win1251.inc}
  {$ENDIF}
{$ENDIF}

var
  DefWindowState: AInteger{TWindowState};

implementation

uses
  AUi;

(*
const
  STR_DockOrientation: array[TDockOrientation] of AString = (
    'NoOrient',
    'Horizontal',
    'Vertical'
    {$IFDEF FPC},'Pages'{$ENDIF}
    );
*)

{
function StrToDockOrientation(S: WideString): TDockOrientation;
var
  I: TDockOrientation;
begin
  for I := Low(TDockOrientation) to High(TDockOrientation) do
    if (STR_DockOrientation[I] = S) then
    begin
      Result := I;
      Exit;
    end;
  Result := doNoOrient;
end;
}

// --- AUi ---

function AUi_SetMainWindow(Value: AWindow): AError;
begin
  _MainWindow_SetA(Value, 0, 0, 0);
  Result := 0;
end;

function AUi_SetMainWindow2(Value: AWindow; ToolBar, StatusBar: AControl; Config: AConfig): AError;
begin
  try
    if (Value = 0) then
      FMainWindow := 0
    else
    begin
      FMainWindow := AddObject(TForm(Value));
      if Assigned(TForm(Value).Menu) then
      begin
        {FMainMenu :=} AddObject(TForm(Value).Menu);
        miMain := AMenuItem(TForm(Value).Menu.Items);
      end;
      //FMainWindow := Value;

      _MainWindow_SetA(Value, ToolBar, StatusBar, Config);
    end;
    Result := 0;
  except
    Result := -1;
  end;
end;

// --- AUiMainWindow ---

function AUiMainWindow_GetLeftContainer(): AControl;
begin
  try
    Result := _MainWindow_GetLeftContainer();
  except
    Result := 0;
  end;
end;

function AUiMainWindow_GetMainContainer(): AControl;
begin
  try
    Result := _MainWindow_GetMainContainer();
  except
    Result := 0;
  end;
end;

function AUiMainWindow_GetRightContainer(): AControl;
begin
  try
    Result := _MainWindow_GetRightContainer();
  except
    Result := 0;
  end;
end;

{ MainWindow }

procedure _MainWindow_Create(Form: TForm; Format: TMainWindowFormat; Config: AConfig);
var
  MainStatusBar: TStatusBar;
  MainToolBar: AControl;
begin
  if (Format and MainWindowFormatCreateToolBar = MainWindowFormatCreateToolBar) then
  begin
    MainToolBar := AUIToolBar.UI_ToolBar_New(AWindow(Form));
    AUIControls.UI_Control_SetVisible(MainToolBar, False);
  end
  else
    MainToolBar := 0;

  if (Format and MainWindowFormatCreateStatusBar = MainWindowFormatCreateStatusBar) then
  begin
    MainStatusBar := TStatusBar.Create(Form);
    MainStatusBar.Parent := Form;
  end
  else
    MainStatusBar := nil;

  if (Format and MainWindowFormatCreatePanels = MainWindowFormatCreatePanels) then
  begin
    LeftPanel := TPanel(AUiBox_New(AWindow(Form),0));
    LeftPanel.Align := alLeft;
    LeftPanel.Width := 50;
    LeftPanel.DockSite := True;
    LeftPanel.DragMode := dmAutomatic;
    LeftPanel.Visible := False;

    LeftSplitter := TSplitter(UI_Splitter_New(AWindow(Form),0));
    LeftSplitter.Align := alLeft;
    LeftSplitter.Width := 3;
    LeftSplitter.Visible := False;

    BasePanel := TPanel(AUiBox_New(AWindow(Form),0));
    BasePanel.Align := alClient;
    BasePanel.BevelInner := bvNone;
    BasePanel.BevelOuter := bvNone;

      RightPanel := TPanel(AUiBox_New(AControl(BasePanel),0));
      RightPanel.Align := alRight;
      RightPanel.Width := 50;
      RightPanel.DockSite := True;
      RightPanel.DragMode := dmAutomatic;
      RightPanel.Visible := False;

      RightSplitter := TSplitter(UI_Splitter_New(AControl(BasePanel),0));
      RightSplitter.Align := alRight;
      RightSplitter.Width := 3;
      RightSplitter.Visible := False;

      MainPanel := TPanel(AUiBox_New(AControl(BasePanel),0));
      MainPanel.Align := alClient;
      MainPanel.BevelInner := bvNone;
      MainPanel.BevelOuter := bvNone;

        BottomPanel := TPanel(AUiBox_New(AControl(MainPanel),0));
        BottomPanel.Align := alBottom;
        BottomPanel.Height := 50;
        BottomPanel.DockSite := True;
        BottomPanel.DragMode := dmAutomatic;
        BottomPanel.Visible := False;

        BottomSplitter := TSplitter(UI_Splitter_New(AControl(MainPanel),0));
        BottomSplitter.Align := alBottom;
        BottomSplitter.Height := 3;
  end;

  if (Format and MainWindowFormatCreateMenu = MainWindowFormatCreateMenu) then
  begin
    MainMenu := TMainMenu.Create(Form);
    Form.Menu := MainMenu;
  end;
  AUI.MainWindow_SetA(AWindow(Form), MainToolBar, AControl(MainStatusBar), Config);
end;

function _MainWindow_GetLeftContainer: AControl;
begin
  Result := Integer(LeftPanel);
end;

function _MainWindow_GetMainContainer: AControl;
begin
  Result := Integer(MainPanel);
end;

function _MainWindow_GetRightContainer: AControl;
begin
  Result := Integer(RightPanel);
end;

procedure _MainWindow_Init;
begin
  if (FConfig <> 0) then
    _MainWindow_LoadConfig(FConfig);
end;

procedure _MainWindow_LoadConfig(Config: AConfig);

  (*
  function FindControlByTag(C: TWinControl; ControlTag: Integer): TWinControl;
  var
    I: Integer;
  begin
    for I := 0 to C.ControlCount - 1 do
    begin
      if (C.Controls[I] is TWinControl) and (C.Controls[I].Tag = ControlTag) then
      begin
        Result := TWinControl(C.Controls[I]);
        Exit;
      end;
    end;
    Result := nil;
  end;

  procedure ReadDockClient(C: TWinControl; Name: WideString; DockSite: TWinControl);
  var
    Client: TWinControl;
    TempTag: Integer;
    Rect: TRect;
    S: WideString;
  begin
    TempTag := Settings.ReadInteger(C.Name, Name, 0);
    if (TempTag = 0) then Exit;
    Client := FindControlByTag(C, TempTag);
    if not(Assigned(Client)) then
      Client := NewPanel(TempTag);

    TPanel(Client).Caption := IntToStr(TempTag);

    Rect.Left := Settings.ReadInteger(C.Name, Name+'_ClientRect_Left', 0);
    Rect.Top := Settings.ReadInteger(C.Name, Name+'_ClientRect_Top', 0) + 15;
    Rect.Right := Settings.ReadInteger(C.Name, Name+'_ClientRect_Right', 0);
    Rect.Bottom := Settings.ReadInteger(C.Name, Name+'_ClientRect_Bottom', 0) + 15;

    S := Settings.ReadString(C.Name, Name+'_ClientOrientation', '');
    if (S <> '') then
      Client.DockOrientation := StrToDockOrientation(S);

    Client.Dock(DockSite, Rect);
    if TPanel(DockSite).UseDockManager and Assigned(TPanel(DockSite).DockManager) then
    begin
      if (Client.DockOrientation = doHorizontal) then
        TPanel(DockSite).DockManager.InsertControl(Client, alRight, nil)
      else if (Client.DockOrientation = doVertical) then
        TPanel(DockSite).DockManager.InsertControl(Client, alBottom, nil)
      else
        TPanel(DockSite).DockManager.InsertControl(Client, alClient, nil)
    end;
  end;

  procedure ReadDockClients(Co: TWinControl; Name: WideString; DockSite: TWinControl);
  var
    C: Integer;
    I: Integer;
  begin
    C := Settings.ReadInteger(Co.Name, Name+'_DockClientCount', 0);
    for I := 0 to C - 1 do
      ReadDockClient(Co, Name+'_DockClient_'+IntToStr(I), DockSite);
  end;

  procedure ReadPanel(C: TWinControl; Name: WideString);
  var
    Client: TWinControl;
    TempTag: Integer;
    Rect: TRect;
    S: WideString;
  begin
    TempTag := Settings.ReadInteger(C.Name, Name, 0);
    if (TempTag = 0) then Exit;
    Client := FindControlByTag(C, TempTag);
    if Assigned(Client) then Exit;

    Client := NewPanel(TempTag);
    TPanel(Client).Caption := IntToStr(TempTag);

    Rect.Left := Settings.ReadInteger(C.Name, Name+'_ClientRect_Left', 0);
    Rect.Top := Settings.ReadInteger(C.Name, Name+'_ClientRect_Top', 0) + 15;
    Rect.Right := Settings.ReadInteger(C.Name, Name+'_ClientRect_Right', 0);
    Rect.Bottom := Settings.ReadInteger(C.Name, Name+'_ClientRect_Bottom', 0) + 15;

    {Client.Dock(DockSite, Rect);
    if TPanel(DockSite).UseDockManager and Assigned(TPanel(DockSite).DockManager) then
      TPanel(DockSite).DockManager.InsertControl(Client, alClient, nil);}

    S := Settings.ReadString(C.Name, Name+'_ClientOrientation', '');
    if (S <> '') then
      Client.DockOrientation := StrToDockOrientation(S);
  end;

  procedure ReadPanels(Co: TWinControl);
  var
    C: Integer;
    I: Integer;
  begin
    C := Settings.ReadInteger(Co.Name, 'PanelCount', 0);
    for I := 0 to C - 1 do
      ReadPanel(Co, 'Panel'+IntToStr(I));
  end;
  *)

var
  MainForm: TForm;
begin
  MainForm := TForm(FMainWindow);
  // UI_Window_LoadConfig(MainForm, Settings);
  //FNextTag := Settings.ReadInteger(FControl.Name, 'NextTag', 1);

  {$IFDEF USE_EVENTS}
  Form_LoadConfig4(MainForm, Config, MainForm.Name, DefWindowState);
  {$ENDIF}

  {$IFNDEF OLDMAINFORM}
  {
  LeftPanel.Width := Settings.ReadInteger(FControl.Name, 'LeftPanel_Width', 50);
  RightPanel.Width := Settings.ReadInteger(FControl.Name, 'RightPanel_Width', 50);
  BottomPanel.Height := Settings.ReadInteger(FControl.Name, 'BottomPanel_Height', 50);

  ReadPanels(MainForm);
  ReadDockClients(MainForm, 'LeftPanel', LeftPanel);
  ReadDockClients(MainForm, 'RightPanel', RightPanel);
  ReadDockClients(MainForm, 'BottomPanel', BottomPanel);
  }
  {$ENDIF}

  (*
  if Settings.ReadBool(FControl.Name, 'NoStandartBorderStyle', False) then
  begin
    FControl.BorderStyle := bsNone;
    ToolBar.Visible := False;
    StatusBar.Visible := False;
  end
  else
  begin
    if Assigned(BottomPanel) then
      BottomPanel.Visible := False;
    //TopPanel.Visible := False;
    //pnlHead.Height := 130;
    {
    if Assigned(ToolBar) then
      ToolBar.Color := DefaultWinColor;
    if Assigned(StatusBar) then
      StatusBar.Color := DefaultWinColor;
    }
  end;
  *)

  {for I := 0 to Self.ComponentCount - 1 do
  begin
    if (Self.Components[I] is TPanel) and (Self.Components[I].Tag > 0) then
    begin
      TPanel(Self.Components[I]).Dra
    end;
  end;}
end;

procedure _MainWindow_SaveConfig(Config: AConfig);

  (*
  procedure WriteDockClient(C: TWinControl; Name: WideString; Client: TControl);
  begin
    Settings.WriteInteger(C.Name, Name, Client.Tag);
    Settings.WriteInteger(C.Name, Name+'_ClientRect_Left', Client.ClientRect.Left);
    Settings.WriteInteger(C.Name, Name+'_ClientRect_Top', Client.ClientRect.Top);
    Settings.WriteInteger(C.Name, Name+'_ClientRect_Right', Client.ClientRect.Right);
    Settings.WriteInteger(C.Name, Name+'_ClientRect_Bottom', Client.ClientRect.Bottom);
    Settings.WriteInteger(C.Name, Name+'_UndockHeight', Client.UndockHeight);
    Settings.WriteInteger(C.Name, Name+'_UndockWidth', Client.UndockWidth);
    Settings.WriteString(C.Name, Name+'_ClientOrientation', STR_DockOrientation[Client.DockOrientation]);
  end;

  procedure WriteDockClients(Co: TWinControl; Name: WideString; DockSite: TWinControl);
  var
    C: Integer;
    I: Integer;
  begin
    if (DockSite.Align = alLeft) or (DockSite.Align = alRight) then
      Settings.WriteInteger(Co.Name, Name+'_Width', DockSite.Width)
    else if (DockSite.Align = alBottom) or (DockSite.Align = alTop) then
      Settings.WriteInteger(Co.Name, Name+'_Height', DockSite.Height);

    C := DockSite.DockClientCount;
    Settings.WriteInteger(Co.Name, Name+'_DockClientCount', C);
    for I := 0 to C - 1 do
      //WriteDockClient(Name+'_DockClient_'+IntToStr(I), DockSite.DockClients[I]);
      Settings.WriteInteger(Co.Name, Name+'_DockClient_'+IntToStr(I), DockSite.DockClients[I].Tag);
  end;

  procedure WritePanels(Co: TWinControl);
  var
    C: Integer;
    I: Integer;
    Component: TComponent;
  begin
    C := 0;
    for I := 0 to Co.ComponentCount - 1 do
    begin
      Component := Co.Components[I];
      if (Component is TPanel) and (Component.Tag > 0) then
      begin
        WriteDockClient(Co, 'Panel'+IntToStr(C), TControl(Component));
        Inc(C);
      end;
    end;
    Settings.WriteInteger(Co.Name, 'PanelCount', C);
  end;
  *)

begin
  //Settings.WriteInteger(FControl.Name, 'NextTag', FNextTag);
  {$IFDEF USE_EVENTS}
  AUI.Window_SaveConfig(FMainWindow, Config);
  {$ENDIF}

  {$IFNDEF OLDMAINFORM}
  {WritePanels(FControl);
  WriteDockClients(FControl, 'LeftPanel', LeftPanel);
  WriteDockClients(FControl, 'RightPanel', RightPanel);
  WriteDockClients(FControl, 'BottomPanel', BottomPanel);}
  {$ENDIF}
end;

procedure _MainWindow_Set(Value: AWindow); stdcall;
begin
  _MainWindow_SetA(Value, 0, 0, 0);
end;

procedure _MainWindow_SetA(Window: AWindow; ToolBar, StatusBar: AControl; Config: AConfig);
begin
  FMainWindow := Window;
  FConfig := Config;
  FStatusBar := StatusBar;
  FMainToolBar := ToolBar;
end;

(*procedure TAMainWindow.ShowAll;
begin
  if Assigned(FContain) then               // 2                 // 54
  begin
    FContain.SetAllocateSize(FControl.Width - 15, FControl.Height - 64);
    {$IFDEF MSWINDOWS}
    IAUIclPanel(FContain).Align := Integer(alClient);
    {$ENDIF}
  end;
end;*)

procedure _MainWindow_Shutdown;
var
  MainForm: TForm;
begin
  MainForm := TForm(FMainWindow);
  if not(Assigned(MainForm)) then
  begin
    FMainWindow := 0;
    Exit;
  end;

  //FControl.OnResize := nil;
  MainForm.OnCloseQuery := nil;

  if (FConfig <> 0) then
  begin
    _MainWindow_SaveConfig(FConfig);
    FConfig := 0;
  end;

  {IFNDEF A02}
  //MainForm.Close;
  {ENDIF}
  // Prof1983: 11.01.2010
  MainForm := nil;
  _MainWindow_Set(0);

  Application.Terminate;

  if (FMainWindow <> 0) then
  begin
    //TForm(FMainWindow).OnCloseQuery := nil;
    TForm(FMainWindow).Close;
    FMainWindow := 0;
    //Application.Terminate;
  end;
end;

function _MainWindow_ToolBar: AControl;
begin
  Result := FMainToolBar;
end;

procedure _MainWindow_ToolBar_Set(ToolBar: AControl);
begin
  FMainToolBar := ToolBar;
end;

(*function TAMainWindow.NewPanel(PanelTag: Integer): TPanel;
begin
  Result := TPanel.Create(FControl);
  Result.Parent := FControl;
  {$IFNDEF UNIX}
  Result.DragKind := dkDock;
  Result.DragMode := dmAutomatic;
  {$ENDIF}
  if (PanelTag > 0) then
    Result.Tag := PanelTag
  else
  begin
    Result.Tag := FNextTag;
    if (FNextTag = High(Integer)) then
      FNextTag := 1
    else
      Inc(FNextTag);
  end;

  Result.Caption := IntToStr(Result.Tag);
end;*)

end.
