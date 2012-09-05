{**
@Abstract User Interface exports
@Author Prof1983 <prof1983@ya.ru>
@Created 28.04.2011
@LastMod 05.09.2012
}
unit AUiExp;

interface

uses
  AUi, AUiControls, AUiDialogs, AUiEdit, AUiGrids, AUiInit, AUiMain, AUiMenus, AUiSpinEdit;

exports
  //A_UI_ApplicationHandle,
  //A_UI_HideOnClose,
  AUi_CreateMainForm,
  AUi_GetMainMenuItem,
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
  AUi_SetProgramState,
  AUi_ShellExecute,
  AUi_ShellExecuteA,
  AUi_ShowHelp,
  AUi_Shutdown,

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

  AUI.Label_New name 'A_UI_Label_New',

  UI_ListBox_Add name 'A_UI_ListBox_Add',
  UI_ListBox_Clear name 'A_UI_ListBox_Clear',

  AUI.MainToolBar name 'A_UI_MainToolBar',
  UI_MainTrayIcon name 'A_UI_MainTrayIcon',
  AUI.MainWindow name 'A_UI_MainWindow',
  AUI.MainWindow_AddMenuItem name 'A_UI_MainWindow_AddMenuItem',
  AUI.MainWindow_AddMenuItem2 name 'A_UI_MainWindow_AddMenuItem2',
  AUI.MainWindow_Set name 'A_UI_MainWindow_Set',

  AUiMenu_AddItem0,
  AUiMenu_AddItem1,
  AUiMenu_AddItem2,
  AUiMenu_AddItem3,
  AUiMenu_GetItems,
  AUiMenu_New,

  AUI.PageControl_AddPage name 'A_UI_PageControl_AddPage',
  AUI.PageControl_New name 'A_UI_PageControl_New',
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
