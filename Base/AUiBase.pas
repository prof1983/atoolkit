{**
@Abstract User Interface base types and consts
@Author Prof1983 <prof1983@ya.ru>
@Created 25.10.2008
@LastMod 15.01.2013
}
unit AUiBase;

interface

uses
  ABase, ABaseTypes;

const
  AUi_Name = 'AUi';
  AUi_Uid = $08102501;

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
  AUiAlignment = type AInt;
const
  uitaLeftJustify = $0000;
  uitaRightJustify = $0001;
  uitaCenter = $0002;
  uitlTop = $0000;
  uitlCenter = $0100;
  uitlBottom = $0200;

type
  TUiAnchors = AInt;
const
  uiakLeft = $01;
  uiakTop = $02;
  uiakRight = $04;
  uiakBottom = $08;

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
  AUiFontStyle = AInt;
const
  uifsBold = $0001;
  uifsItalic = $0002;
  uifsUnderline = $0004;
  uifsStrikeOut = $0008;

type
  AUiProgramState = AInteger;
const
  AUiProgramState_Default = 0;
  AUiProgramState_None = 1;
  AUiProgramState_HourGlass = 11;

type
  AUiScrollStyle = type AInteger;
const
  AUiScrollStyle_None = 0;
  AUiScrollStyle_Horizontal = 1;
  AUiScrollStyle_Vertical = 2;
  AUiScrollStyle_Both = 3;

type
  AUiSplitterType = type AInteger;
const
  AUiSplitter_HSplitter = 0;       //(Align=alTop)
  AUiSplitter_VSplitter = 1;       //(Align=alLeft)
  AUiSplitter_HSplitterBottom = 2; //(Align=alBottom)
  AUiSplitter_VSplitterRight = 3;  //(Align=alRight)

type
  AUiWindowPosition = AInt;
const
  AUiWindowPosition_Designed = 0;
  AUiWindowPosition_Default = 1;
  AUiWindowPosition_DefaultPosOnly = 2;
  AUiWindowPosition_DefaultSizeOnly = 3;
  AUiWindowPosition_ScreenCenter = 4;
  AUiWindowPosition_DesktopCenter = 5;
  AUiWindowPosition_MainFormCenter = 6;
  AUiWindowPosition_OwnerFormCenter = 7;

implementation

end.
