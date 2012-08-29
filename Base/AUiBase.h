/*  AUi
    Author Prof1983 <prof1983@ya.ru>
    Created 29.08.2012
    LastMod 29.08.2012 */

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

typedef int AUiBoxType;
/*
const
  AUIBoxTypeNone = 0;
  AUIBoxTypeH = 1;
  AUIBoxTypeV = 2;
*/

typedef int AUiWindowFlags;
/*
const
  AUIWindowCreateMenu = $00010000;
  AUIWindowCreateToolBar = $00020000;
  AUIWindowCreateButtonsPanel = $00040000;
*/
typedef AMessageBoxFlags AUiWindowButtons;

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

/*
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
  AUiProgramState = AInteger;
const
  AUiProgramState_Default = 0;
  AUiProgramState_None = 1;
  AUiProgramState_HourGlass = 11;

type
  AUISplitterType = type AInteger;
const
  AUISplitter_HSplitter = 0;       //(Align=alTop)
  AUISplitter_VSplitter = 1;       //(Align=alLeft)
  AUISplitter_HSplitterBottom = 2; //(Align=alBottom)
  AUISplitter_VSplitterRight = 3;  //(Align=alRight)
*/
