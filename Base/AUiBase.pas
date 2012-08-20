{**
@Abstract User Interface base types and consts
@Author Prof1983 <prof1983@ya.ru>
@Created 25.10.2008
@LastMod 20.08.2012
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

//type // = Controls.TMouseButton
//  AUIMouseButton = (mbLeft, mbRight, mbMiddle);

implementation

end.
