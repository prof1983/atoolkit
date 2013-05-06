/*
Author Prof1983 <prof1983@ya.ru>
Created 29.08.2012
*/

#include "ABase2.h"

#define AUi_Uid 0x08102501

typedef AInt AControl;
//typedef AInt ADataSource;
typedef AInt ADialog;
typedef AInt AFont;
typedef AInt AMenu;
typedef AInt AMenuItem;
typedef AInt AReport;
typedef AInt AToolMenu;
typedef AInt ATrayIcon;
typedef AInt AWindow;

typedef AControl ABox;
typedef AControl AButton;
typedef AControl ATreeNode;

typedef AInt AUiAlign;
/*
(uiAlignNone, uiAlignTop, uiAlignBottom, uiAlignLeft, uiAlignRight, uiAlignClient, uiAlignCustom);
const
  UI_Align_None = 0;
  UI_Align_Top = 1;
  UI_Align_Bottom = 2;
  UI_Align_Left = 3;
  UI_Align_Right = 4;
  UI_Align_Client = 5;
  UI_Align_Custom = 6;
*/


typedef AInt AUiAlignment;
/*
const
  AUiAlignment_LeftJustify = $0000;
  AUiAlignment_RightJustify = $0001;
  AUiAlignment_HCenter = $0002;
  // --- TTextLayout ---
  AUiAlignment_Top = $0000;
  AUiAlignment_VCenter = $0100;
  AUiAlignment_Bottom = $0200;
*/

typedef AInt AUiAnchors;
/*
const
  AUiAnchors_Left = $01;
  AUiAnchors_Top = $02;
  AUiAnchors_Right = $04;
  AUiAnchors_Bottom = $08;
*/

typedef AInt AUiBevel;
/*
const
  AUiBevel_InnerNone = $01;
  AUiBevel_InnerLowered = $02;
  AUiBevel_InnerRaised = $03;
  AUiBevel_InnerSpace = $04;
  AUiBevel_OuterNone = $0100;
  AUiBevel_OuterLowered = $0200;
  AUiBevel_OuterRaised = $0300;
  AUiBevel_OuterSpace = $0400;
*/

typedef AInt AUiBorderStyle;
/*
const
  AUiBorderStyle_None = 0;
  AUiBorderStyle_Single = 1;
  AUiBorderStyle_Sizeable = 2;
  AUiBorderStyle_Dialog = 3;
  AUiBorderStyle_ToolWindow = 4;
  AUiBorderStyle_SizeToolWin = 5;
*/

typedef int AUiBoxType;
/*
const
  AUIBoxTypeNone = 0;
  AUIBoxTypeH = 1;
  AUIBoxTypeV = 2;
*/

typedef AInt AUiButtonKind;
/*
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
*/

typedef AInt AUiFontStyle;
/*
const
  AUiFontStyle_Bold = $0001;
  AUiFontStyle_Italic = $0002;
  AUiFontStyle_Underline = $0004;
  AUiFontStyle_StrikeOut = $0008;
*/

typedef AInt AUiProgramState;
/*
const
  AUiProgramState_Default = 0;
  AUiProgramState_None = 1;
  AUiProgramState_HourGlass = 11;
*/

typedef AInt AUiScrollStyle;
/*
const
  AUiScrollStyle_None = 0;
  AUiScrollStyle_Horizontal = 1;
  AUiScrollStyle_Vertical = 2;
  AUiScrollStyle_Both = 3;
*/

typedef AInt AUiSplitterType;
/*
const
  AUiSplitter_HSplitter = 0;       //(Align=alTop)
  AUiSplitter_VSplitter = 1;       //(Align=alLeft)
  AUiSplitter_HSplitterBottom = 2; //(Align=alBottom)
  AUiSplitter_VSplitterRight = 3;  //(Align=alRight)
*/

typedef AMessageBoxFlags AUiWindowButtons;

typedef AInt AUiWindowFlags;
/*
const
  AUIWindowCreateMenu = $00010000;
  AUIWindowCreateToolBar = $00020000;
  AUIWindowCreateButtonsPanel = $00040000;
*/

typedef AInt AUiWindowPosition;
/*
const
  AUiWindowPosition_Designed = 0;
  AUiWindowPosition_Default = 1;
  AUiWindowPosition_DefaultPosOnly = 2;
  AUiWindowPosition_DefaultSizeOnly = 3;
  AUiWindowPosition_ScreenCenter = 4;
  AUiWindowPosition_DesktopCenter = 5;
  AUiWindowPosition_MainFormCenter = 6;
  AUiWindowPosition_OwnerFormCenter = 7;
*/
