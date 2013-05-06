{**
@Author Prof1983 <prof1983@ya.ru>
@Created 25.10.2008
}
unit AUiMod;

{$ifdef A02}
  {$define UseA0}
{$endif}

{$IFDEF FPC}
  {$mode delphi}{$h+}
{$ENDIF}

{$IFDEF OLDMAINFORM2}
  {$DEFINE OLDMAINFORM}
{$ENDIF}

{$IFDEF FPC}
  {$DEFINE LangEN}
{$ENDIF}

interface

// TODO: Перенести все функции в AUI
// TODO: Избавиться от AUIData

uses
  {$ifdef A02}
  ABase,
  ARuntimeBase,
  ASystem0,
  AUi,
  AUiProcs,
  AUiBase,
  AUiEdit;
  {$else}
  ABase, AEvents0, ARuntime0, ARuntimeBase, AStrings0, ASystem0,
  ASystemBase,
  AUI, AUIBase, AUIData, AUIProcs;
  {$endif}

// --- Procs ---

{$ifndef A02}

function A_UI_Image_New(Parent: AControl): AControl; stdcall;
function A_UI_Image_LoadFromFile(Image: AControl; const FileName: AString_Type): ABoolean; stdcall;

function A_UI_Label_New(Parent: AControl): AControl; stdcall;

function A_UI_ListBox_Add(ListBox: AControl; const Text: AString_Type): Integer; stdcall;
procedure A_UI_ListBox_Clear(ListBox: AControl); stdcall;
function A_UI_ListBox_New(Parent: AControl): AControl; stdcall;
{ Typ:
  0 - ListBox
  1 - RadioGroup }
function A_UI_ListBox_NewA(Parent: AControl; Typ: AInteger): AControl; stdcall;
function A_UI_ListBox_GetCount(ListBox: AControl): AInteger; stdcall;
function A_UI_ListBox_GetItem(ListBox: AControl; Index: AInteger; out Value: AString_Type): AInteger; stdcall;
function A_UI_ListBox_GetItemIndex(ListBox: AControl): AInteger; stdcall;
procedure A_UI_ListBox_SetItemIndex(ListBox: AControl; Index: AInteger); stdcall;
procedure A_UI_ListBox_DeleteItem(ListBox: AControl; Index: AInteger); stdcall;
procedure A_UI_ListBox_SetItem(ListBox: AControl; Index: AInteger; const Value: AString_Type); stdcall;

function A_UI_MainTrayIcon: ATrayIcon; stdcall;

function A_UI_MainWindow: AWindow; stdcall;
function A_UI_MainWindow_AddMenuItem(const ParentItemName, Name, Text: AString_Type; OnClick: ACallbackProc; ImageID, Weight: Integer): AMenuItem; stdcall;

function A_UI_PropertyBox_Add(PropertyBox: AControl; const Caption: AString_Type): Integer; stdcall;
function A_UI_PropertyBox_AddA(PropertyBox: AControl; const Caption, Text, Hint: AString_Type; EditWidth: AInteger): AInteger; stdcall;
function A_UI_PropertyBox_Item_GetValue(PropertyBox: AControl; Index: Integer; out Value: AString_Type): AInteger; stdcall;
procedure A_UI_PropertyBox_Item_SetValue(PropertyBox: AControl; Index: Integer; const Value: AString_Type); stdcall;
function A_UI_PropertyBox_New(Parent: AControl): AControl; stdcall;

function A_UI_SpinButton_New(Parent: AControl): AControl; stdcall;
function A_UI_SpinEdit_New(Parent: AControl): AControl; stdcall;
function A_UI_SpinEdit_NewA(Parent: AControl; Value, MinValue, MaxValue: AInteger): AControl; stdcall;

{ SplitterType
    0 - HSplitter (Align=alTop)
    1 - VSplitter (Align=alLeft)
    2 - HSplitter (Align=alBottom)
    3 - VSplitter (Align=alRight) }
function A_UI_Splitter_New(Parent: AControl; SplitterType: AUISplitterType): AControl; stdcall;

{$IFNDEF UNIX}
function A_UI_TrayIcon_GetMenuItems(TrayIcon: ATrayIcon): AMenuItem; stdcall;
{$ENDIF}

procedure A_UI_Window_Free(Window: AWindow); stdcall;
function A_UI_Window_LoadConfig2(Window: AWindow; Config: AConfig; const ConfigKey: AString_Type): ABoolean; stdcall;
function A_UI_Window_SaveConfig(Window: AWindow; Config: AConfig): ABoolean; stdcall;
function A_UI_Window_SaveConfig2(Window: AWindow; Config: AConfig; const ConfigKey: AString_Type): ABoolean; stdcall;
procedure A_UI_Window_SetPosition(Window: AWindow; Position: AInteger); stdcall;
function A_UI_Window_ShowModal(Window: AWindow): ABoolean; stdcall;

{ Reports }

function A_UI_Report_New(Parent: AControl): AReport; stdcall;

procedure A_UI_Report_SetText(Report: AReport; const Value: AString_Type); stdcall;

{ Testing }

procedure A_UI_SetHideOnClose(Value: ABoolean); stdcall;
function A_UI_Run: AInteger; stdcall;
function A_UI_MainMenuItem: AMenuItem; stdcall;

// Добавляет строку в элемент TextView
function A_UI_TextView_AddLine(TextView: AControl; const Text: AString_Type): AInteger; stdcall;

{ Создает новый элемент редактирования текста
  ViewType
    0 - TMemo
    1 - RichEdit }
function A_UI_TextView_New(Parent: AControl; ViewType: AInteger): AControl; stdcall;

procedure A_UI_TextView_SetFont(TextView: AControl; const FontName: AString_Type; FontSize: AInteger); stdcall;

procedure A_UI_TextView_SetReadOnly(TextView: AControl; ReadOnly: ABoolean); stdcall;

{ ScrollBars
    0 - ssNone
    1 - ssHorizontal
    2 - ssVertical
    3 - ssBoth }
procedure A_UI_TextView_SetScrollBars(TextView: AControl; ScrollBars: AInteger); stdcall;

procedure A_UI_TextView_SetWordWrap(TextView: AControl; Value: ABoolean); stdcall;

procedure A_UI_Window_FreeAndNil(var Window: AWindow); stdcall;
procedure A_UI_Window_SetBorderStyle(Window: AWindow; BorderStyle: AInteger); stdcall;
procedure A_UI_Window_SetFormStyle(Window: AWindow; FormStyle: AInteger); stdcall;

function A_UI_ShellExecute(const Operation, FileName, Parameters, Directory: AString_Type): AInteger; stdcall;

{$endif} // A02

{ Protected }

function UI_Boot(): AError; stdcall;

procedure UI_Done02(); stdcall;

function UI_Done03(): AInt; stdcall;

function UI_Done04(): AError; stdcall;

function UI_Init02(): AInt; stdcall;

function UI_Init03(): AInt; stdcall;

function UI_Init04(): AError; stdcall;

const
  UIProcs: AUIProcs_Type = (
    IsShowApp: UI_GetIsShowApp;                                     // 00
    InitMainTrayIcon: UI_InitMainTrayIcon;                          // 01
    InitMenus02: AUI.InitMenus02;                                   // 02
    ProcessMessages02: AUI.ProcessMessages02;                       // 03
    IsShowApp_Set: UI_SetIsShowApp;                                 // 04
    ShowHelp02: AUI.ShowHelp02;                                     // 05
    Shutdown02: AUI.Shutdown02;                                     // 06

    Box_New: AUI.Box_New;                                           // 07
    Button_New: AUI.Button_New;                                     // 08

    Control_Free: UI_Control_Free;                                  // 09
    Control_FreeAndNil: UI_Control_FreeAndNil;                      // 10
    Control_GetEnabled: AUI.Control_GetEnabled;                     // 11
    Control_GetHeight: AUI.Control_GetHeight;                       // 12
    Control_GetHintW: UI_Control_GetHint;                           // 13
    Control_GetNameW: UI_Control_GetName;                           // 14
    Control_GetTextW: UI_Control_GetText;                           // 15
    Control_GetVisible: AUI.Control_GetVisible;                     // 16
    Control_GetWidth: AUI.Control_GetWidth;                         // 17
    Control_SetAlign: AUI.Control_SetAlign02;                       // 18
    Control_SetClientSize: UI_Control_SetClientSize;                // 19
    Control_SetColor: AUI.Control_SetColor02;                       // 20
    Control_SetEnabled: UI_Control_SetEnabled;                      // 21
    Control_SetFocus: AUI.Control_SetFocus;                         // 22
    Control_SetHintW: AUI.Control_SetHint02;                        // 23
    Control_SetNameW: AUI.Control_SetName02;                        // 24
    Control_SetOnChange02: AUI.Control_SetOnChange02;               // 25
    Control_SetOnClick02: AUI.Control_SetOnClick02;                 // 26
    Control_SetPosition: AUI.Control_SetPosition02;                 // 27
    Control_SetSize: AUI.Control_SetSize02;                         // 28
    Control_SetTextWS: AUI.Control_SetText02;                       // 29
    Control_SetVisible: AUI.Control_SetVisible02;                   // 30
    Control_SetWidth: AUI.Control_SetWidth;                         // 31

    DataSource_New: UI_DataSource_New;                              // 32
    DataSource_SetOnDataChange02: AUI.DataSource_SetOnDataChange02; // 33

    Dialog_About: UI_Dialog_About;                                  // 34
    Dialog_Calendar: UI_Dialog_Calendar;                            // 35
    Dialog_Color: UI_Dialog_Color;                                  // 36
    Dialog_DateFilter: UI_Dialog_DateFilter;                        // 37
    Dialog_Error: UI_Dialog_Error;                                  // 38
    Dialog_Font: UI_Dialog_Font;                                    // 39
    Dialog_GetWindow: AUI.Dialog_GetWindow;                         // 40
    Dialog_InputBox: AUI.Dialog_InputBox1WS;                        // 41
    Dialog_InputBox2: AUI.Dialog_InputBox2WS;                       // 42
    Dialog_InputBoxA: AUI.Dialog_InputBox3WS;                       // 43
    Dialog_Login: UI_Dialog_Login;                                  // 44
    Dialog_Message: UI_Dialog_Message;                              // 45
    Dialog_New: AUI.Dialog_New;                                     // 46
    Dialog_OpenFile: UI_Dialog_OpenFile;                            // 47
    Dialog_OpenFileA: UI_Dialog_OpenFileA;                          // 48
    Dialog_SaveFile: UI_Dialog_SaveFile;                            // 49
    Dialog_SaveFileA: UI_Dialog_SaveFileA;                          // 50

    Edit_CheckDate: AUI.Edit_CheckDate;                             // 51
    Edit_CheckFloat: AUI.Edit_CheckFloat;                           // 52
    Edit_CheckInt: AUI.Edit_CheckInt;                               // 53
    Edit_New: AUI.Edit_New;                                         // 54
    Edit_NewA: AUI.Edit_New02;                                      // 55

    Grid_AddColumn: UI_Grid_AddColumn;                              // 56
    Grid_New: AUI.Grid_New;                                         // 57
    Grid_RestoreColProps: AUI.Grid_RestoreColPropsWS02;             // 58
    Grid_SaveColProps: AUI.Grid_SaveColPropsWS02;                   // 59
    Grid_SetColumnWidth: AUI.Grid_SetColumnWidth02;                 // 60
    Grid_SetColumnWidthA: AUI.Grid_SetColumnWidthA;                 // 61
    Grid_SetDataSource: AUI.Grid_SetDataSource02;                   // 62

    Image_New: UI_Image_New;                                        // 63
    Image_LoadFromFile: UI_Image_LoadFromFile;                      // 64

    Label_New: UI_Label_New;                                        // 65
    {$ifdef A02}Label_SetFont: UI_Label_SetFont{$else}Reserved66: 0{$endif}; // 66

    ListBox_Add: UI_ListBox_Add;                                    // 67
    ListBox_Clear: UI_ListBox_Clear;                                // 68
    ListBox_New: UI_ListBox_New;                                    // 69

    MainToolBar: AUI.MainToolBar;                                   // 70
    {$ifdef A02}MainToolBar_Set: AUI.MainToolBar_Set{$else}Reserved71: 0{$endif}; // 71

    MainTrayIcon: UI_MainTrayIcon;                                  // 72

    MainWindow: AUI.MainWindow;                                     // 73
    MainWindow_AddMenuItem02: AUI.MainWindow_AddMenuItem02;         // 74
    MainWindow_AddMenuItem2: AUI.MainWindow_AddMenuItem2WS02;       // 75
    MainWindow_GetLeftContainer: AUI.MainWindow_GetLeftContainer;   // 76
    MainWindow_GetMainContainer: AUI.MainWindow_GetMainContainer;   // 77
    MainWindow_GetRightContainer: AUI.MainWindow_GetRightContainer; // 78
    MainWindow_Set: AUI.MainWindow_Set;                             // 79

    Menu_GetItems: AUI.Menu_GetItems;                               // 80
    Menu_New: AUI.Menu_New;                                         // 81

    Menu_AddItem2WS02: AUI.Menu_AddItem2WS02;                       // 82
    Menu_AddItem3: AUI.Menu_AddItem3;                               // 83
    MenuItem_FindByName: AUI.MenuItem_FindByName;                   // 84

    PageControl_AddPageWS: AUI.PageControl_AddPageWS;               // 85
    PageControl_New: AUI.PageControl_New;                           // 86

    ProgressBar_New: AUI.ProgressBar_New;                           // 87
    ProgressBar_StepIt: AUI.ProgressBar_StepIt;                     // 88

    PropertyBox_Add: UI_PropertyBox_Add;                            // 89
    PropertyBox_AddA: UI_PropertyBox_AddA;                          // 90
    PropertyBox_Item_GetValue: UI_PropertyBox_Item_GetValue;        // 91
    PropertyBox_Item_SetValue: UI_PropertyBox_Item_SetValue;        // 92
    PropertyBox_New: UI_PropertyBox_New;                            // 93

    Splitter_New: UI_Splitter_New;                                  // 94

    TextView_AddLine: UI_TextView_AddLine;                          // 95
    TextView_New: UI_TextView_New;                                  // 96
    TextView_SetFont: UI_TextView_SetFont;                          // 97
    TextView_SetReadOnly: UI_TextView_SetReadOnly;                  // 98
    TextView_SetScrollBars: UI_TextView_SetScrollBars;              // 99
    TextView_SetWordWrap: UI_TextView_SetWordWrap;                  // 100

    ToolBar_AddButton: AUI.ToolBar_AddButtonWS02;                   // 101
    ToolBar_New: AUI.ToolBar_New;                                   // 102

    TrayIcon_GetMenuItems: UI_TrayIcon_GetMenuItems;                // 103

    TreeView_AddItemWS: AUI.TreeView_AddItemWS;                     // 104
    TreeView_New: AUI.TreeView_New;                                 // 105

    Window_Free: AUI.Window_Free;                                   // 106
    Window_GetMenu: AUI.Window_GetMenu;                             // 107
    Window_LoadConfig: AUI.Window_LoadConfig;                       // 108
    Window_LoadConfig2: UI_Window_LoadConfig2;                      // 109
    Window_New: AUI.Window_New;                                     // 110
    Window_SaveConfig: UI_Window_SaveConfig;                        // 111
    Window_SaveConfig2: UI_Window_SaveConfig2;                      // 112
    Window_SetBorderStyle02: AUI.Window_SetBorderStyle02;           // 113
    Window_SetFormStyle: UI_Window_SetFormStyle;                    // 114
    Window_SetPosition: UI_Window_SetPosition;                      // 115
    Window_ShowModal: UI_Window_ShowModal;                          // 116

    ReportWin_New: AUI.ReportWin_New;                               // 117
    WaitWin_NewWS: AUI.WaitWin_NewWS;                               // 118
    WaitWin_StepBy: AUI.WaitWin_StepBy;                             // 119
    SetOnMainFormCreate02: AUI.SetOnMainFormCreate02;               // 120
    MainWindow_SetA: AUI.MainWindow_SetA;                           // 121

    ReportWin_NewA: AUI.ReportWin_NewWS;                            // 122
    Calendar_GetDate: AUI.Calendar_GetDate;                         // 123
    Calendar_New: AUI.Calendar_New;                                 // 124
    Calendar_SetMonth: UI_Calendar_SetMonth;                        // 125
    Report_New: AUI.Report_New;                                     // 126
    Report_SetText: UI_Report_SetText;                              // 127
    InitMainMenu: UI_InitMainMenu;                                  // 128
    Control_SetFont1: UI_Control_SetFont1;                          // 129
    Control_SetFont2: UI_Control_SetFont2;                          // 130
    Dialog_About_New: UI_Dialog_About_New;                          // 131
    Dialog_AddButton: UI_Dialog_AddButton02;                        // 132
    OnDone_Connect: AUI.OnDone_Connect;                             // 133

    Init: UI_Init04;                                                // 134
    Done: UI_Done04;                                                // 135
    InitMenus: AUI.InitMenus;                                       // 136
    ProcessMessages: AUI.ProcessMessages;                           // 137
    ShowHelp: AUI.ShowHelp;                                         // 138
    Shutdown: AUI.Shutdown;                                         // 139
    Grid_ClearA: AUI.Grid_ClearA;                                   // 140
    Grid_Clear: AUI.Grid_Clear;                                     // 141
    Menu_AddItem2WS: AUI.Menu_AddItem2WS03;                         // 142
    Grid_FindInt: AUI.Grid_FindInt;                                 // 143

    {$ifndef A02}
    Control_SetOnChange: AUI.Control_SetOnChange;                   // 144
    Grid_DeleteRow2: AUI.Grid_DeleteRow2;                           // 145
    ShowHelp2WS: AUI.ShowHelp2WS;                                   // 146
    Window_SetBorderStyle: AUI.Window_SetBorderStyle;               // 147
    MainWindow_AddMenuItem: AUI.MainWindow_AddMenuItem03WS;         // 148
    OnDone_Disconnect03: AUI.OnDone_Disconnect;                     // 149
    Reserved150: 0;
    Reserved151: 0;
    Reserved152: 0;
    Reserved153: 0;
    Reserved154: 0;
    Reserved155: 0;
    Reserved156: 0;
    Reserved157: 0;
    Reserved158: 0;
    Reserved159: 0;

    Reserved160: 0;
    Reserved161: 0;
    Reserved162: 0;
    Reserved163: 0;
    Reserved164: 0;
    Reserved165: 0;
    Reserved166: 0;
    Reserved167: 0;
    Reserved168: 0;
    Reserved169: 0;
    Reserved170: 0;
    Reserved171: 0;
    Reserved172: 0;
    Reserved173: 0;
    Reserved174: 0;
    Reserved175: 0;

    Reserved176: 0;
    Reserved177: 0;
    Reserved178: 0;
    Reserved179: 0;
    Reserved180: 0;
    Reserved181: 0;
    Reserved182: 0;
    Reserved183: 0;
    Reserved184: 0;
    Reserved185: 0;
    Reserved186: 0;
    Reserved187: 0;
    Reserved188: 0;
    Reserved189: 0;
    Reserved190: 0;
    Reserved191: 0;

    Reserved192: 0;
    Reserved193: 0;
    Reserved194: 0;
    Reserved195: 0;
    Reserved196: 0;
    Reserved197: 0;
    Reserved198: 0;
    Reserved199: 0;
    Reserved200: 0;
    Reserved201: 0;
    Reserved202: 0;
    Reserved203: 0;
    Reserved204: 0;
    Reserved205: 0;
    Reserved206: 0;
    Reserved207: 0;

    Reserved208: 0;
    Reserved209: 0;
    Reserved210: 0;
    Reserved211: 0;
    Reserved212: 0;
    Reserved213: 0;
    Reserved214: 0;
    Reserved215: 0;
    Reserved216: 0;
    Reserved217: 0;
    Reserved218: 0;
    Reserved219: 0;
    Reserved220: 0;
    Reserved221: 0;
    Reserved222: 0;
    Reserved223: 0;

    Reserved224: 0;
    Reserved225: 0;
    Reserved226: 0;
    Reserved227: 0;
    Reserved228: 0;
    Reserved229: 0;
    Reserved230: 0;
    Reserved231: 0;
    Reserved232: 0;
    Reserved233: 0;
    Reserved234: 0;
    Reserved235: 0;
    Reserved236: 0;
    Reserved237: 0;
    Reserved238: 0;
    Reserved239: 0;

    Reserved240: 0;
    Reserved241: 0;
    Reserved242: 0;
    Reserved243: 0;
    Reserved244: 0;
    Reserved245: 0;
    Reserved246: 0;
    Reserved247: 0;
    Reserved248: 0;
    Reserved249: 0;
    Reserved250: 0;
    Reserved251: 0;
    Reserved252: 0;
    Reserved253: 0;
    Reserved254: 0;
    Reserved255: 0;
    {$endif} // A02
    );

implementation

{$IFDEF USEA0}
uses
  AUI0;
{$ENDIF USEA0}

const
  AUI_Version02 = $00020700;
  AUI_Version03 = $00030500;

const
  {$ifdef A02}
  Module: AModule02_Type = (
    Version: AUI_Version02;
    Init: UI_Init02;
    Done: UI_Done02;
    Name: AUI_Name02;
    Procs: Addr(UIProcs);
    Reserved1: 0;
    Reserved2: 0;
    Reserved3: 0;
    );
  {$else}
  Module: AModule03_Type = (
    Version: AUI_Version03;
    Uid: AUI_Uid;
    Name: AUI_Name03;
    Description: nil;
    Init: UI_Init03;
    Done: UI_Done03;
    Reserved06: 0;
    Procs: Addr(UIProcs);
    );
  {$endif}

{ Module }

function UI_Boot(): AError;
begin
  {$ifdef A02}
  Result := ARuntime.Module_Register02(Module);
  {$else}
  Result := ARuntime.Module_Register(Module);
  {$endif}
end;

procedure UI_Done02();
begin
  AUI.Done04();
end;

function UI_Done03(): AInt;
begin
  Result := AUI.Done();
end;

function UI_Done04(): AError;
begin
  Result := AUI.Done();
end;

function UI_Init02(): AInt;
begin
  Result := UI_Init04();
end;

function UI_Init03(): AInt;
begin
  Result := UI_Init04();
end;

function UI_Init04(): AError;
begin
  {$ifndef A02}
  if (FMainWindow <> 0) then
  begin
    Result := 0;
    Exit;
  end;

  if (ARuntime.Modules_InitByUid(ASystem_Uid) < 0) then
  begin
    Result := -1;
    Exit;
  end;
  {$endif}

  //FOnDone := AEvents.Event_NewW(0, nil);

  //ARuntime.Modules_InitByUid(ASystem_Uid);

  try
    Result := UI_Init();
  except
    Result := -1;
  end;
end;

{$ifndef A02}

{ UI Public }

function A_UI_Run: AInteger; stdcall;
begin
  try
    Result := UI_Run;
  except
    Result := -1;
  end;
end;

procedure A_UI_SetHideOnClose(Value: ABoolean); stdcall;
begin
  FHideOnClose := Value;
end;

function A_UI_ShellExecute(const Operation, FileName, Parameters, Directory: AString_Type): AInteger; stdcall;
begin
  try
    Result := UI_ShellExecute(
        AStrings.String_ToWideString(Operation),
        AStrings.String_ToWideString(FileName),
        AStrings.String_ToWideString(Parameters),
        AStrings.String_ToWideString(Directory));
  except
    Result := -1;
  end;
end;

{ Image }

function A_UI_Image_New(Parent: AControl): AControl; stdcall;
begin
  try
    Result := UI_Image_New(Parent);
  except
    Result := 0;
  end;
end;

function A_UI_Image_LoadFromFile(Image: AControl; const FileName: AString_Type): ABoolean; stdcall;
begin
  try
    Result := UI_Image_LoadFromFile(Image, AStrings.String_ToWideString(FileName));
  except
    Result := False;
  end;
end;

{ Label }

function A_UI_Label_New(Parent: AControl): AControl; stdcall;
begin
  try
    Result := UI_Label_New(Parent);
  except
    Result := 0;
  end;
end;

{ ListBox }

function A_UI_ListBox_Add(ListBox: AControl; const Text: AString_Type): Integer; stdcall;
begin
  try
    Result := UI_ListBox_Add(ListBox, AStrings.String_ToWideString(Text));
  except
    Result := -1;
  end;
end;

procedure A_UI_ListBox_Clear(ListBox: AControl); stdcall;
begin
  try
    UI_ListBox_Clear(ListBox);
  except
  end;
end;

procedure A_UI_ListBox_DeleteItem(ListBox: AControl; Index: AInteger); stdcall;
begin
  try
    UI_ListBox_DeleteItem(ListBox, Index);
  except
  end;
end;

function A_UI_ListBox_GetCount(ListBox: AControl): AInteger; stdcall;
begin
  try
    Result := UI_ListBox_GetCount(ListBox);
  except
    Result := 0;
  end;
end;

function A_UI_ListBox_GetItem(ListBox: AControl; Index: AInteger; out Value: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Value, UI_ListBox_GetItem(ListBox, Index));
  except
    Result := 0;
  end;
end;

function A_UI_ListBox_GetItemIndex(ListBox: AControl): AInteger; stdcall;
begin
  try
    Result := UI_ListBox_GetItemIndex(ListBox);
  except
    Result := 0;
  end;
end;

function A_UI_ListBox_New(Parent: AControl): AControl; stdcall;
begin
  Result := A_UI_ListBox_NewA(Parent, 0);
end;

function A_UI_ListBox_NewA(Parent: AControl; Typ: AInteger): AControl; stdcall;
begin
  try
    Result := UI_ListBox_NewA(Parent, Typ);
  except
    Result := 0;
  end;
end;

procedure A_UI_ListBox_SetItem(ListBox: AControl; Index: AInteger; const Value: AString_Type); stdcall;
begin
  try
    UI_ListBox_SetItem(ListBox, Index, AStrings.String_ToWideString(Value));
  except
  end;
end;

procedure A_UI_ListBox_SetItemIndex(ListBox: AControl; Index: AInteger); stdcall;
begin
  try
    UI_ListBox_SetItemIndex(ListBox, Index);
  except
  end;
end;

{ MainMenuItem }

function A_UI_MainMenuItem: AMenuItem; stdcall;
begin
  Result := miMain;
end;

{ MainTrayIcon }

function A_UI_MainTrayIcon: ATrayIcon;
begin
  Result := FMainTrayIcon;
end;

{ MainWindow }

function A_UI_MainWindow: AWindow; stdcall;
begin
  Result := FMainWindow;
end;

function A_UI_MainWindow_AddMenuItem(const ParentItemName, Name, Text: AString_Type;
    OnClick: ACallbackProc; ImageID, Weight: Integer): AMenuItem; stdcall;
begin
  Result := AUI.MainWindow_AddMenuItem2(ParentItemName, Name, Text, OnClick, ImageID, Weight);
end;

{ Menu }

{
function A_UI_Menu_GetItems(Menu: AMenu): AMenuItem; stdcall;
begin
  try
    Result := UI_Menu_GetItems(Menu);
  except
    Result := 0;
  end;
end;

function A_UI_Menu_New(MenuType: AInteger): AMenu; stdcall;
begin
  try
    Result := UI_Menu_New(MenuType);
  except
    Result := 0;
  end;
end;
}

{ MenuItem }

{
function A_UI_MenuItem_Add2(Parent: AMenuItem; MenuItem: AMenuItem; Weight: Integer): AMenuItem; stdcall;
begin
  try
    Result := UI_MenuItem_Add2(Parent, MenuItem, Weight);
  except
    Result := 0;
  end;
end;

function A_UI_MenuItem_FindByName(MenuItem: AMenuItem; const Name: AString_Type): AMenuItem; stdcall;
begin
  try
    Result := UI_MenuItem_FindByName(MenuItem, AStrings.String_ToWideString(Name));
  except
    Result := 0;
  end;
end;
}

{ Objects }

{
function A_UI_Object_Add(Value: AInteger): AInteger; stdcall;
begin
  try
    Result := UI_Object_Add(Value);
  except
    Result := 0;
  end;
end;
}

{ PageControl }

{
function A_UI_PageControl_AddPage(PageControl: AControl; const Name, Text: AString_Type): AControl; stdcall;
begin
  try
    Result := UI_PageControl_AddPage(PageControl, AStrings.String_ToWideString(Name), AStrings.String_ToWideString(Text));
  except
    Result := 0;
  end;
end;

function A_UI_PageControl_New(Parent: AControl): AControl; stdcall;
begin
  try
    Result := UI_PageControl_New(Parent);
  except
    Result := 0;
  end;
end;
}

{ ProgressBar }

{
function A_UI_ProgressBar_New(Parent: AControl; Max: AInteger): AControl; stdcall;
begin
  try
    Result := UI_ProgressBar_New(Parent, Max);
  except
    Result := 0;
  end;
end;

function A_UI_ProgressBar_StepIt(ProgressBar: AControl): AInteger; stdcall;
begin
  try
    Result := UI_ProgressBar_StepIt(ProgressBar);
  except
    Result := 0;
  end;
end;
}

{ PropertyBox }

function A_UI_PropertyBox_Add(PropertyBox: AControl; const Caption: AString_Type): Integer; stdcall;
begin
  try
    Result := UI_PropertyBox_Add(PropertyBox, AStrings.String_ToWideString(Caption));
  except
    Result := 0;
  end;
end;

function A_UI_PropertyBox_AddA(PropertyBox: AControl; const Caption, Text, Hint: AString_Type;
    EditWidth: AInteger): AInteger; stdcall;
begin
  try
    Result := UI_PropertyBox_AddA(PropertyBox,
        AStrings.String_ToWideString(Caption),
        AStrings.String_ToWideString(Text),
        AStrings.String_ToWideString(Hint),
        EditWidth);
  except
    Result := 0;
  end;
end;

function A_UI_PropertyBox_Item_GetValue(PropertyBox: AControl; Index: Integer; out Value: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Value, UI_PropertyBox_Item_GetValue(PropertyBox, Index));
  except
    Result := 0;
  end;
end;

procedure A_UI_PropertyBox_Item_SetValue(PropertyBox: AControl; Index: Integer; const Value: AString_Type); stdcall;
begin
  try
    UI_PropertyBox_Item_SetValue(PropertyBox, Index, AStrings.String_ToWideString(Value));
  except
  end;
end;

function A_UI_PropertyBox_New(Parent: AControl): AControl; stdcall;
begin
  try
    Result := UI_PropertyBox_New(Parent);
  except
    Result := 0;
  end;
end;

{ Report }

function A_UI_Report_New(Parent: AControl): AReport; stdcall;
begin
  try
    Result := UI_Report_New(Parent);
  except
    Result := 0;
  end;
end;

procedure A_UI_Report_SetText(Report: AReport; const Value: AString_Type); stdcall;
begin
  try
    UI_Report_SetText(Report, AStrings.String_ToWideString(Value));
  except
  end;
end;

{ SpinButton }

function A_UI_SpinButton_New(Parent: AControl): AControl; stdcall;
begin
  try
    Result := UI_SpinButton_New(Parent);
  except
    Result := 0;
  end;
end;

{ SpinEdit }

function A_UI_SpinEdit_New(Parent: AControl): AControl; stdcall;
begin
  try
    Result := UI_SpinEdit_New(Parent);
  except
    Result := 0;
  end;
end;

function A_UI_SpinEdit_NewA(Parent: AControl; Value, MinValue, MaxValue: AInteger): AControl; stdcall;
begin
  try
    Result := UI_SpinEdit_NewA(Parent, Value, MinValue, MaxValue);
  except
    Result := 0;
  end;
end;

{ Splitter }

function A_UI_Splitter_New(Parent: AControl; SplitterType: AUISplitterType): AControl; stdcall;
begin
  try
    Result := UI_Splitter_New(Parent, SplitterType);
  except
    Result := 0;
  end;
end;

{ TextView }

function A_UI_TextView_AddLine(TextView: AControl; const Text: AString_Type): AInteger; stdcall;
begin
  try
    Result := UI_TextView_AddLine(TextView, AStrings.String_ToWideString(Text));
  except
    Result := -1;
  end;
end;

function A_UI_TextView_New(Parent: AControl; ViewType: AInteger): AControl; stdcall;
begin
  try
    Result := UI_TextView_New(Parent, ViewType);
  except
    Result := 0;
  end;
end;

procedure A_UI_TextView_SetFont(TextView: AControl; const FontName: AString_Type; FontSize: AInteger); stdcall;
begin
  try
    UI_TextView_SetFont(TextView, AStrings.String_ToWideString(FontName), FontSize);
  except
  end;
end;

procedure A_UI_TextView_SetReadOnly(TextView: AControl; ReadOnly: ABoolean); stdcall;
begin
  try
    UI_TextView_SetReadOnly(TextView, ReadOnly);
  except
  end;
end;

procedure A_UI_TextView_SetScrollBars(TextView: AControl; ScrollBars: AInteger); stdcall;
begin
  try
    UI_TextView_SetScrollBars(TextView, ScrollBars);
  except
  end;
end;

procedure A_UI_TextView_SetWordWrap(TextView: AControl; Value: ABoolean); stdcall;
begin
  try
    UI_TextView_SetWordWrap(TextView, Value);
  except
  end;
end;

{ TrayIcon }

function A_UI_TrayIcon_GetMenuItems(TrayIcon: ATrayIcon): AMenuItem; stdcall;
begin
  try
    Result := UI_TrayIcon_GetMenuItems(TrayIcon);
  except
    Result := 0;
  end;
end;

{ Window }

procedure A_UI_Window_Free(Window: AWindow); stdcall;
begin
  AUI.Control_Free(Window);
end;

procedure A_UI_Window_FreeAndNil(var Window: AWindow); stdcall;
begin
  A_UI_Window_Free(Window);
  Window := 0;
end;

function A_UI_Window_LoadConfig2(Window: AWindow; Config: AConfig; const ConfigKey: AString_Type): ABoolean; stdcall;
begin
  try
    Result := UI_Window_LoadConfig2(Window, Config, AStrings.String_ToWideString(ConfigKey));
  except
    Result := False;
  end;
end;

function A_UI_Window_SaveConfig(Window: AWindow; Config: AConfig): ABoolean; stdcall;
begin
  try
    Result := UI_Window_SaveConfig(Window, Config);
  except
    Result := False;
  end;
end;

function A_UI_Window_SaveConfig2(Window: AWindow; Config: AConfig; const ConfigKey: AString_Type): ABoolean; stdcall;
begin
  try
    Result := UI_Window_SaveConfig2(Window, Config, AStrings.String_ToWideString(ConfigKey));
  except
    Result := False;
  end;
end;

procedure A_UI_Window_SetBorderStyle(Window: AWindow; BorderStyle: AInteger); stdcall;
begin
  try
    UI_Window_SetBorderStyle(Window, BorderStyle);
  except
  end;
end;

procedure A_UI_Window_SetFormStyle(Window: AWindow; FormStyle: AInteger); stdcall;
begin
  try
    UI_Window_SetFormStyle(Window, FormStyle);
  except
  end;
end;

procedure A_UI_Window_SetPosition(Window: AWindow; Position: AInteger); stdcall;
begin
  try
    UI_Window_SetPosition(Window, Position);
  except
  end;
end;

function A_UI_Window_ShowModal(Window: AWindow): ABoolean; stdcall;
begin
  try
    Result := UI_Window_ShowModal(Window);
  except
    Result := False;
  end;
end;

{$endif} // A02

initialization
  {$IFDEF USEA0}UI_SetProcs(UIProcs);{$ENDIF}
end.
