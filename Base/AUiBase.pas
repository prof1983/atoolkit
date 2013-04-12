{**
@Abstract User Interface base types and consts
@Author Prof1983 <prof1983@ya.ru>
@Created 25.10.2008
@LastMod 12.04.2013
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
  AIcon = type AInt; // Graphics.TIcon
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
  AUiBorderStyle = type AInt;
const
  AUiBorderStyle_None = 0;
  AUiBorderStyle_Single = 1;
  AUiBorderStyle_Sizeable = 2;
  AUiBorderStyle_Dialog = 3;
  AUiBorderStyle_ToolWindow = 4;
  AUiBorderStyle_SizeToolWin = 5;

type
  ABoxType = AInt;
const
  ABoxType_Simple = 0;
  ABoxType_HBox = 1;
  ABoxType_VBox = 2;
  ABoxType_GroupBox = 3;

type
  AMouseButton = type AInt;
const
  AMouseButton_Left = 0;
  AMouseButton_Right = 1;
  AMouseButton_Middle = 2;

type
  AShiftState = type AInt;
const
  AShiftState_Shift = $01;
  AShiftState_Alt = $02;
  AShiftState_Ctrl = $04;
  AShiftState_Left = $08;
  AShiftState_Right = $10;
  AShiftState_Middle = $20;
  AShiftState_Double = $40;

type
  AUiWindowFlags = type AInt;
const
  AUiWindowCreateMenu = $00010000;
  AUiWindowCreateToolBar = $00020000;
  AUiWindowCreateButtonsPanel = $00040000;
type
  AUiWindowButtons = type AMessageBoxFlags;

type
  AUiAlign = type AInt;
  //TUiAlign = AUiAlign;
const
  AUiAlign_None = 0;
  AUiAlign_Top = 1;
  AUiAlign_Bottom = 2;
  AUiAlign_Left = 3;
  AUiAlign_Right = 4;
  AUiAlign_Client = 5;
  AUiAlign_Custom = 6;
const
  uiAlignNone = AUiAlign_None;
  uiAlignTop = AUiAlign_Top;
  uiAlignBottom = AUiAlign_Bottom;
  uiAlignLeft = AUiAlign_Left;
  uiAlignRight = AUiAlign_Right;
  uiAlignClient = AUiAlign_Client;
  uiAlignCustom = AUiAlign_Custom;

type
  AUiAlignment = type AInt;
const
  AUiAlignment_LeftJustify = $0000;
  AUiAlignment_RightJustify = $0001;
  AUiAlignment_HCenter = $0002;
  // --- TTextLayout ---
  AUiAlignment_Top = $0000;
  AUiAlignment_VCenter = $0100;
  AUiAlignment_Bottom = $0200;
const
  uitaLeftJustify = AUiAlignment_LeftJustify;
  uitaRightJustify = AUiAlignment_RightJustify;
  uitaCenter = AUiAlignment_HCenter;
  uitlTop = AUiAlignment_Top;
  uitlCenter = AUiAlignment_VCenter;
  uitlBottom = AUiAlignment_Bottom;

type
  AUiAnchors = type AInt;
  //TUiAnchors = AUiAnchors;
const
  AUiAnchors_Left = $01;
  AUiAnchors_Top = $02;
  AUiAnchors_Right = $04;
  AUiAnchors_Bottom = $08;
const
  uiakLeft = AUiAnchors_Left;
  uiakTop = AUiAnchors_Top;
  uiakRight = AUiAnchors_Right;
  uiakBottom = AUiAnchors_Bottom;

type
  AUiBevel = type AInt;
const
  AUiBevel_InnerNone = $01;
  AUiBevel_InnerLowered = $02;
  AUiBevel_InnerRaised = $03;
  AUiBevel_InnerSpace = $04;
  AUiBevel_OuterNone = $0100;
  AUiBevel_OuterLowered = $0200;
  AUiBevel_OuterRaised = $0300;
  AUiBevel_OuterSpace = $0400;

type
  AUiButtonKind = type AInt;
  //TAUiButtonKind = AUiButtonKind;
const
  AUiButtonKind_Custom = 0;
  AUiButtonKind_Ok = 1;
  AUiButtonKind_Cancel = 2;
  AUiButtonKind_Help = 3;
  AUiButtonKind_Yes = 4;
  AUiButtonKind_No = 5;
  AUiButtonKind_Close = 6;
  AUiButtonKind_Abort = 7;
  AUiButtonKind_Retry = 8;
  AUiButtonKind_Ignore = 9;
  AUiButtonKind_All = 10;
const
  uibkCustom = AUiButtonKind_Custom;
  uibkOk = AUiButtonKind_Ok;
  uibkCancel = AUiButtonKind_Cancel;
  uibkHelp = AUiButtonKind_Help;
  uibkYes = AUiButtonKind_Yes;
  uibkNo = AUiButtonKind_No;
  uibkClose = AUiButtonKind_Close;
  uibkAbort = AUiButtonKind_Abort;
  uibkRetry = AUiButtonKind_Retry;
  uibkIgnore = AUiButtonKind_Ignore;
  uibkAll = AUiButtonKind_All;

type
  AUiFontStyle = AInt;
const
  AUiFontStyle_Bold = $0001;
  AUiFontStyle_Italic = $0002;
  AUiFontStyle_Underline = $0004;
  AUiFontStyle_StrikeOut = $0008;
const
  uifsBold = AUiFontStyle_Bold;
  uifsItalic = AUiFontStyle_Italic;
  uifsUnderline = AUiFontStyle_Underline;
  uifsStrikeOut = AUiFontStyle_StrikeOut;

type
  AUiProgramState = type AInt;
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
  AUiWindowPosition = type AInt;
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
