{**
@Abstract User Interface base types and consts
@Author Prof1983 <prof1983@ya.ru>
@Created 25.10.2008
@LastMod 19.07.2012

[+] 10.08.2011 - Добавил тип AFont.
[*] 28.06.2011 - Описание процедур и функций перенес в AUI0Procs.
}
unit AUiBase;

{DEFINE A02}
{DEFINE A03}

{$I A.inc}

{$IFDEF FPC}
  {$DEFINE LangEN}
{$ENDIF}

{$IFDEF A01} {$DEFINE A01_OR_02} {$ENDIF}
{$IFDEF A02} {$DEFINE A01_OR_02} {$ENDIF}

{$IFDEF A02} {$DEFINE A02UP} {$ENDIF}
{$IFDEF A03} {$DEFINE A02UP} {$ENDIF}

{
Object
|- Control
|   |- Box
|   |- Button
|   |- Calendar
|   |- ComboBox
|   |- Edit
|   |- Grid
|   |- Image
|   |- Label
|   |- ListBox
|   |- PageControl
|   |- ProgressBar
|   |- PropertyBox
|   |- Report
|   |- SpinEdit
|   |- Splitter
|   |- TextView
|   |- ToolBar
|   |- TreeView
|   \- Window
|- DataSource
|- MainWindow
|- MenuItem
|- Menu
|- TrayIcon
\- WaytWin

A_UI_Box_Type = TPanel
A_UI_Button_Type = TButton
A_UI_Calendar_Type = TCalendar
A_UI_ComboBox_Type = TComboBox
A_UI_Control_Type = TControl
A_UI_DataSource = TDataSource
}

interface

uses
  ABase, ABaseTypes;

// --- Types ---------------------------------------------------------------------------------------

type
  AControl = type Integer;
  AButton = type AControl;
  ABox = type AControl;
  AFont = type AInteger; // TFont
  AMenu = type AInteger;
  AMenuItem = type AControl;
  AToolMenu = type AInteger;
  ATrayIcon = type AInteger;
  ATreeNode = type AControl;
  AWindow = type AControl;
  AReport = type AInteger;
  ADialog = type AInteger;
type
  PADataSource = type AInteger;

type
  AUIBoxType = type AInteger;
const
  AUIBoxTypeNone = 0;
  AUIBoxTypeH = 1;
  AUIBoxTypeV = 2;

type
  AUIWindowFlags = type AInteger;
const
  AUIWindowCreateMenu = $00010000;
  AUIWindowCreateToolBar = $00020000;
  AUIWindowCreateButtonsPanel = $00040000;
type
  AUIWindowButtons = type AMessageBoxFlags;

type
  TUIAlign = (uiAlignNone, uiAlignTop, uiAlignBottom, uiAlignLeft, uiAlignRight, uiAlignClient, uiAlignCustom);
const
  UI_Align_None = 0;
  UI_Align_Top = 1;
  UI_Align_Bottom = 2;
  UI_Align_Left = 3;
  UI_Align_Right = 4;
  UI_Align_Client = 5;
  UI_Align_Custom = 6;

type
  TAUIButtonKind = (
    uibkCustom,
    uibkOK,
    uibkCancel,
    uibkHelp,
    uibkYes,
    uibkNo,
    uibkClose,
    uibkAbort,
    uibkRetry,
    uibkIgnore,
    uibkAll
    );

type
  AUISplitterType = type AInteger;
const
  AUISplitter_HSplitter = 0;       //(Align=alTop)
  AUISplitter_VSplitter = 1;       //(Align=alLeft)
  AUISplitter_HSplitterBottom = 2; //(Align=alBottom)
  AUISplitter_VSplitterRight = 3;  //(Align=alRight)

//type // = Controls.TMouseButton
//  AUIMouseButton = (mbLeft, mbRight, mbMiddle);

{$IFDEF LangEN}
  {$I 'AUi.en.inc'}
{$ELSE}
  {$IFDEF DELPHI_XE_UP}
    {$I 'AUi.ru.utf8.inc'}
  {$ELSE}
    {$I 'AUi.ru.win1251.inc'}
  {$ENDIF}
{$ENDIF}

implementation

end.
