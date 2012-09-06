{**
@Abstract User Interface exports
@Author Prof1983 <prof1983@ya.ru>
@Created 28.04.2011
@LastMod 05.09.2012
}
unit AUiExp;

interface

uses
  AUi, AUiBox, AUiCalendar, AUiComboBox, AUiControls, AUiDialogs, AUiEdit,
  AUiGrids, AUiImages, AUiInit, AUiLabels, AUiListBox,
  AUiMain, AUiMainWindow, AUiMainWindow2, AUiMenus, AUiPageControl, AUiSpinEdit;

exports
  //A_UI_ApplicationHandle,
  //A_UI_HideOnClose,
  AUi_CreateMainForm,
  AUi_GetMainMenuItem,
  AUi_GetMainToolBar,
  AUi_GetMainTrayIcon,
  AUi_GetMainWindow,
  AUi_Init,
  AUi_InitMainTrayIcon,
  AUi_InitMenus,
  //UI_GetIsShowApp name 'A_UI_GetIsShowApp',
  //UI_SetIsShowApp name 'A_UI_SetIsShowApp',
  //AUI.SetOnMainFormCreate name 'A_UI_SetOnMainFormCreate',
  //UI_ProcessMessages name 'A_UI_ProcessMessages',
  AUi_Run,
  AUi_SetHideOnClose,
  AUi_SetMainToolBar,
  AUi_SetProgramState,
  AUi_SetMainWindow,
  AUi_SetMainWindow2,
  AUi_ShellExecute,
  AUi_ShellExecuteA,
  AUi_ShowHelp,
  AUi_Shutdown,

  AUiBox_New,

  AUiCalendar_GetDate,
  AUiCalendar_New,
  AUiCalendar_SetMonth,

  AUiComboBox_Add,
  AUiComboBox_AddA,
  AUiComboBox_GetItemIndex,
  AUiComboBox_New,
  AUiComboBox_New2,
  AUiComboBox_SetItemIndex,

  AUiControl_Free,
  AUiControl_FreeAndNil,
  AUiControl_GetColor,
  AUiControl_GetEnabled,
  AUiControl_GetHeight,
  AUiControl_GetHint,
  AUiControl_GetHintA,
  AUiControl_GetName,
  AUiControl_GetNameA,
  AUiControl_GetVisible,
  AUiControl_SetAlign,
  AUiControl_SetClientSize,
  AUiControl_SetColor,
  AUiControl_SetEnabled,
  AUiControl_SetFocus,
  AUiControl_SetFont1A,
  AUiControl_SetHeight,
  AUiControl_SetHint,
  AUiControl_SetHintA,
  AUiControl_SetName,
  AUiControl_SetNameA,
  AUiControl_SetOnClick,
  AUiControl_SetPosition,
  AUiControl_SetSize,
  AUiControl_SetText,
  AUiControl_SetTextA,
  AUiControl_SetVisible,
  AUiControl_SetWidth,

  AUi_ExecuteAboutDialog,
  AUi_ExecuteCalendarDialog,
  AUi_ExecuteColorDialog,
  AUi_ExecuteDateFilterDialog,
  AUi_ExecuteErrorDialog,
  AUi_ExecuteErrorDialogA,
  AUi_ExecuteFontDialog,
  AUi_ExecuteFontDialogA,
  AUi_ExecuteInputBox1,
  AUi_ExecuteInputBox1A,
  AUi_ExecuteInputBox2,
  AUi_ExecuteInputBox2A,

  AUiEdit_CheckDate,
  AUiEdit_CheckFloat,
  AUiEdit_CheckInt,
  AUiEdit_New,
  AUiEdit_NewEx,

  AUiGrid_Clear,
  AUiGrid_Clear2,
  AUiGrid_DeleteRow,
  AUiGrid_DeleteRow2,
  AUiGrid_FindInt,
  AUiGrid_New,
  AUiGrid_RestoreColProps,
  AUiGrid_RestoreColPropsA,
  AUiGrid_RowDown,
  AUiGrid_RowUp,
  AUiGrid_SaveColProps,
  AUiGrid_SaveColPropsA,
  AUiGrid_SetColumnWidth,
  AUiGrid_SetColumnWidth2,
  AUiGrid_SetDataSource,
  AUiGrid_SetRowCount,

  AUiImage_LoadFromFile,
  AUiImage_LoadFromFileA,
  AUiImage_New,

  AUiLabel_New,

  AUiListBox_Add,
  AUiListBox_Clear,
  AUiListBox_DeleteItem,
  AUiListBox_GetCount,
  AUiListBox_GetItem,
  AUiListBox_GetItemIndex,
  AUiListBox_New,
  AUiListBox_New2,
  AUiListBox_SetItem,
  AUiListBox_SetItemIndex,

  AUiMainWindow_AddMenuItem,
  AUiMainWindow_AddMenuItemA,
  AUiMainWindow_GetLeftContainer,
  AUiMainWindow_GetMainContainer,
  AUiMainWindow_GetRightContainer,

  AUiMenu_AddItem0,
  AUiMenu_AddItem1,
  AUiMenu_AddItem2,
  AUiMenu_AddItem3,
  AUiMenu_GetItems,
  AUiMenu_New,

  AUiPageControl_AddPage,
  AUiPageControl_AddPageA,
  AUiPageControl_New,

  UI_SpinButton_New name 'A_UI_SpinButton_New',

  AUiSpinEdit_New,
  AUiSpinEdit_NewEx,

  UI_Splitter_New name 'A_UI_Splitter_New',
  AUI.ToolBar_AddButtonWS name 'A_UI_ToolBar_AddButtonWS',
  AUI.TreeView_New name 'A_UI_TreeView_New',
  UI_WaitWin_New name 'A_UI_WaitWin_New',
  AUI.WaitWin_StepBy name 'A_UI_WaitWin_StepBy',
  AUI.Window_Free name 'A_UI_Window_Free',
  AUI.Window_GetMenu name 'A_UI_Window_GetMenu',
  AUI.Window_LoadConfig name 'A_UI_Window_LoadConfig',
  AUI.Window_New name 'A_UI_Window_New',
  AUI.Window_SaveConfig name 'A_UI_Window_SaveConfig';

implementation

end.
