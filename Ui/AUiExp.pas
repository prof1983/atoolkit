{**
@Abstract User Interface exports
@Author Prof1983 <prof1983@ya.ru>
@Created 28.04.2011
@LastMod 27.08.2012
}
unit AUiExp;

interface

uses
  AUi;

exports
  //A_UI_ApplicationHandle,
  //A_UI_HideOnClose,
  UI_InitMainTrayIcon name 'A_UI_InitMainTrayIcon',
  AUI.InitMenus name 'A_UI_InitMenus',
  UI_GetIsShowApp name 'A_UI_GetIsShowApp',
  UI_SetIsShowApp name 'A_UI_SetIsShowApp',
  AUI.SetOnMainFormCreate name 'A_UI_SetOnMainFormCreate',
  UI_ProcessMessages name 'A_UI_ProcessMessages',
  UI_Run name 'A_UI_Run',
  UI_SetHideOnClose name 'A_UI_SetHideOnClose',
  AUI.ShowHelp name 'A_UI_ShowHelp',
  UI_Shutdown name 'A_UI_Shutdown',

  AUI.Control_Free name 'A_UI_Control_Free',
  AUI.Control_GetEnabled name 'A_UI_Control_GetEnabled',
  AUI.Control_GetHintWS name 'A_UI_Control_GetHintWS',
  AUI.Control_GetNameWS name 'A_UI_Control_GetNameWS',
  AUI.Control_GetVisible name 'A_UI_Control_GetVisible',
  AUI.Control_SetAlign name 'A_UI_Control_SetAlign',
  AUI.Control_SetEnabled name 'A_UI_Control_SetEnabled',
  AUI.Control_SetHintWS name 'A_UI_Control_SetHintWS',
  AUI.Control_SetNameWS name 'A_UI_Control_SetNameWS',
  AUI.Control_SetPosition name 'A_UI_Control_SetPosition',
  AUI.Control_SetSize name 'A_UI_Control_SetSize',
  AUI.Control_SetTextWS name 'A_UI_Control_SetTextWS',
  AUI.Control_SetVisible name 'A_UI_Control_SetVisible',
  AUI.Dialog_About name 'A_UI_Dialog_About',
  AUI.Dialog_Calendar name 'A_UI_Dialog_Calendar',
  AUI.Dialog_ErrorWS name 'A_UI_Dialog_ErrorWS',
  AUI.Dialog_DateFilter name 'A_UI_Dialog_DateFilter',
  AUI.Dialog_InputBox1WS name 'A_UI_Dialog_InputBox1WS',
  AUI.Dialog_InputBox2WS name 'A_UI_Dialog_InputBox2WS',
  AUI.Dialog_InputBox3WS name 'A_UI_Dialog_InputBox3WS',
  AUI.Dialog_LoginWS name 'A_UI_Dialog_LoginWS',
  AUI.Dialog_MessageWS name 'A_UI_Dialog_MessageWS',
  AUI.Dialog_OpenFileWS name 'A_UI_Dialog_OpenFileWS',
  AUI.Edit_CheckDate name 'A_UI_Edit_CheckDate',
  AUI.Edit_CheckFloat name 'A_UI_Edit_CheckFloat',
  AUI.Edit_CheckInt name 'A_UI_Edit_CheckInt',
  AUI.Edit_New name 'A_UI_Edit_New',
  AUI.Grid_RestoreColPropsWS name 'A_UI_Grid_RestoreColPropsWS',
  UI_Grid_SaveColProps name 'A_UI_Grid_SaveColProps',
  UI_Grid_SetColumnWidth name 'A_UI_Grid_SetColumnWidth',
  UI_Grid_SetColumnWidthA name 'A_UI_Grid_SetColumnWidthA',
  UI_Grid_SetDataSource name 'A_UI_Grid_SetDataSource',
  AUI.Label_New name 'A_UI_Label_New',
  UI_ListBox_Add name 'A_UI_ListBox_Add',
  UI_ListBox_Clear name 'A_UI_ListBox_Clear',
  AUI.MainToolBar name 'A_UI_MainToolBar',
  UI_MainTrayIcon name 'A_UI_MainTrayIcon',
  AUI.MainWindow name 'A_UI_MainWindow',
  AUI.MainWindow_AddMenuItem name 'A_UI_MainWindow_AddMenuItem',
  AUI.MainWindow_AddMenuItem2 name 'A_UI_MainWindow_AddMenuItem2',
  AUI.MainWindow_Set name 'A_UI_MainWindow_Set',
  AUI.Menu_GetItems name 'A_UI_Menu_GetItems',
  AUI.Menu_AddItem2WS name 'A_UI_MenuItem_Add',
  AUI.Menu_AddItem3 name 'A_UI_MenuItem_Add2',
  AUI.PageControl_AddPage name 'A_UI_PageControl_AddPage',
  AUI.PageControl_New name 'A_UI_PageControl_New',
  UI_SpinButton_New name 'A_UI_SpinButton_New',
  UI_SpinEdit_New name 'A_UI_SpinEdit_New',
  UI_SpinEdit_NewA name 'A_UI_SpinEdit_NewA',
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
