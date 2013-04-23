{**
@Abstract User Interface
@Author Prof1983 <prof1983@ya.ru>
@Created 25.10.2008
@LastMod 23.04.2013
}
unit AUiMod;

interface

uses
  ABase,
  ARuntimeBase,
  ARuntimeMain,
  ASystemBase,
  AUiAboutDialog,
  AUiBase,
  AUiBox,
  AUiButtons,
  AUiCalendar,
  AUiCalendarDialog,
  AUiCheckBox,
  AUiComboBox,
  AUiControls,
  AUiControlsA,
  AUiDataSource,
  AUiDialogs,
  AUiDialogsEx1,
  AUiDialogsEx2,
  AUiEdit,
  AUiErrorDialog,
  AUiEvents,
  AUiFilterDialog,
  AUiGrids,
  AUiImages,
  AUiInit,
  AUiLabels,
  AUiLabelsEx,
  AUiListBox,
  AUiMain,
  AUiMainWindow,
  AUiMainWindow2,
  AUiMenus,
  AUiPageControl,
  AUiProgressBar,
  AUiPropertyBox,
  AUiReports,
  AUiSpin,
  AUiSpinEdit,
  AUiSplitter,
  AUiTextView,
  AUiToolBar,
  AUiToolMenu,
  AUiTrayIcon,
  AUiTreeView,
  AUiWaitWin,
  AUiWindows,
  AUiWindowSettings;

// --- AUi ---

function AUiMod_Boot(): AError; stdcall;

function AUiMod_Fin(): AError; stdcall;

function AUiMod_GetProc(ProcName: AStr): Pointer; stdcall;

function AUiMod_Init(): AError; stdcall;

implementation

const
  AUi_Version = $00060200;

const
  Module: AModule_Type = (
    Version: AUi_Version;
    Uid: AUi_Uid;
    Name: AUi_Name;
    Description: nil;
    Init: AUiMod_Init;
    Fin: AUiMod_Fin;
    GetProc: AUiMod_GetProc;
    Procs: nil;
    );

// --- AUi ---

function AUiMod_Boot(): AError;
begin
  Result := ARuntime_RegisterModule(Module);
end;

function AUiMod_Fin(): AError;
begin
  Result := AUi_Fin();
end;

function AUiMod_GetProc(ProcName: AStr): Pointer;
begin
  // --- Main ---
  if (ProcName = 'AUi_CreateMainForm') then
    Result := Addr(AUi_CreateMainForm)
  else if (ProcName = 'AUi_ExecuteAboutDialog') then
    Result := Addr(AUi_ExecuteAboutDialog)
  else if (ProcName = 'AUi_ExecuteCalendarDialog') then
    Result := Addr(AUi_ExecuteCalendarDialog)
  else if (ProcName = 'AUi_ExecuteColorDialog') then
    Result := Addr(AUi_ExecuteColorDialog)
  else if (ProcName = 'AUi_ExecuteDateFilterDialog') then
    Result := Addr(AUi_ExecuteDateFilterDialog)
  else if (ProcName = 'AUi_ExecuteErrorDialog') then
    Result := Addr(AUi_ExecuteErrorDialog)
  else if (ProcName = 'AUi_ExecuteErrorDialogA') then
    Result := Addr(AUi_ExecuteErrorDialogA)
  else if (ProcName = 'AUi_ExecuteFontDialog') then
    Result := Addr(AUi_ExecuteFontDialog)
  else if (ProcName = 'AUi_ExecuteFontDialogA') then
    Result := Addr(AUi_ExecuteFontDialogA)
  else if (ProcName = 'AUi_ExecuteInputBox1') then
    Result := Addr(AUi_ExecuteInputBox1)
  else if (ProcName = 'AUi_ExecuteInputBox1A') then
    Result := Addr(AUi_ExecuteInputBox1A)
  else if (ProcName = 'AUi_ExecuteInputBox2') then
    Result := Addr(AUi_ExecuteInputBox2)
  else if (ProcName = 'AUi_ExecuteInputBox2A') then
    Result := Addr(AUi_ExecuteInputBox2A)
  else if (ProcName = 'AUi_ExecuteLoginDialog') then
    Result := Addr(AUi_ExecuteLoginDialog)
  else if (ProcName = 'AUi_ExecuteMessageDialog1') then
    Result := Addr(AUi_ExecuteMessageDialog1)
  else if (ProcName = 'AUi_ExecuteMessageDialog1A') then
    Result := Addr(AUi_ExecuteMessageDialog1A)
  else if (ProcName = 'AUi_ExecuteOpenFileDialog') then
    Result := Addr(AUi_ExecuteOpenFileDialog)
  else if (ProcName = 'AUi_ExecutePrinterSetupDialog') then
    Result := Addr(AUi_ExecutePrinterSetupDialog)
  else if (ProcName = 'AUi_ExecuteSaveFileDialog1') then
    Result := Addr(AUi_ExecuteSaveFileDialog1)
  else if (ProcName = 'AUi_Fin') then
    Result := Addr(AUi_Fin)
  else if (ProcName = 'AUi_GetIsShowApp') then
    Result := Addr(AUi_GetIsShowApp)
  else if (ProcName = 'AUi_GetMainMenuItem') then
    Result := Addr(AUi_GetMainMenuItem)
  else if (ProcName = 'AUi_GetMainToolBar') then
    Result := Addr(AUi_GetMainToolBar)
  else if (ProcName = 'AUi_GetMainTrayIcon') then
    Result := Addr(AUi_GetMainTrayIcon)
  else if (ProcName = 'AUi_GetMainWindow') then
    Result := Addr(AUi_GetMainWindow)
  else if (ProcName = 'AUi_Init') then
    Result := Addr(AUi_Init)
  {
  else if (ProcName = 'AUi_InitAboutDialogWin2') then
    Result := Addr(AUi_InitAboutDialogWin2)
  }
  else if (ProcName = 'AUi_InitMainTrayIcon') then
    Result := Addr(AUi_InitMainTrayIcon)
  else if (ProcName = 'AUi_InitMenus') then
    Result := Addr(AUi_InitMenus)
  else if (ProcName = 'AUi_OnDone_Connect') then
    Result := Addr(AUi_OnDone_Connect)
  else if (ProcName = 'AUi_OnDone_Disconnect') then
    Result := Addr(AUi_OnDone_Disconnect)
  else if (ProcName = 'AUi_ProcessMessages') then
    Result := Addr(AUi_ProcessMessages)
  else if (ProcName = 'AUi_Run') then
    Result := Addr(AUi_Run)
  else if (ProcName = 'AUi_SetAboutMemoDefaultSize') then
    Result := Addr(AUi_SetAboutMemoDefaultSize)
  else if (ProcName = 'AUi_SetHideOnClose') then
    Result := Addr(AUi_SetHideOnClose)
  else if (ProcName = 'AUi_SetIsShowApp') then
    Result := Addr(AUi_SetIsShowApp)
  else if (ProcName = 'AUi_SetMainToolBar') then
    Result := Addr(AUi_SetMainToolBar)
  else if (ProcName = 'AUi_SetMainWindow') then
    Result := Addr(AUi_SetMainWindow)
  else if (ProcName = 'AUi_SetMainWindow2') then
    Result := Addr(AUi_SetMainWindow2)
  else if (ProcName = 'AUi_SetOnAboutClick') then
    Result := Addr(AUi_SetOnAboutClick)
  else if (ProcName = 'AUi_SetOnMainFormCreate') then
    Result := Addr(AUi_SetOnMainFormCreate)
  else if (ProcName = 'AUi_SetProgramState') then
    Result := Addr(AUi_SetProgramState)
  else if (ProcName = 'AUi_ShellExecute') then
    Result := Addr(AUi_ShellExecute)
  else if (ProcName = 'AUi_ShellExecuteA') then
    Result := Addr(AUi_ShellExecuteA)
  else if (ProcName = 'AUi_ShowHelp') then
    Result := Addr(AUi_ShowHelp)
  else if (ProcName = 'AUi_ShowHelp2') then
    Result := Addr(AUi_ShowHelp2)
  else if (ProcName = 'AUi_Shutdown') then
    Result := Addr(AUi_Shutdown)

  // --- AboutDialog ---
  {
  else if (ProcName = 'AUiAboutDialog_Init2') then
    Result := Addr(AUiAboutDialog_Init2)
  else if (ProcName = 'AUiAboutDialog_New') then
    Result := Addr(AUiAboutDialog_New)
  }

  // --- Box ---
  else if (ProcName = 'AUiBox_New') then
    Result := Addr(AUiBox_New)

  // --- Button ---
  else if (ProcName = 'AUiButton_New') then
    Result := Addr(AUiButton_New)
  else if (ProcName = 'AUiButton_SetKind') then
    Result := Addr(AUiButton_SetKind)

  // --- Calendar ---
  else if (ProcName = 'AUiCalendar_GetDate') then
    Result := Addr(AUiCalendar_GetDate)
  else if (ProcName = 'AUiCalendar_New') then
    Result := Addr(AUiCalendar_New)
  else if (ProcName = 'AUiCalendar_SetMonth') then
    Result := Addr(AUiCalendar_SetMonth)

  // --- CheckBox ---
  else if (ProcName = 'AUiCheckBox_Free') then
    Result := Addr(AUiCheckBox_Free)
  else if (ProcName = 'AUiCheckBox_GetChecked') then
    Result := Addr(AUiCheckBox_GetChecked)
  else if (ProcName = 'AUiCheckBox_New') then
    Result := Addr(AUiCheckBox_New)
  else if (ProcName = 'AUiCheckBox_NewEx') then
    Result := Addr(AUiCheckBox_NewEx)
  else if (ProcName = 'AUiCheckBox_SetChecked') then
    Result := Addr(AUiCheckBox_SetChecked)

  // --- ComboBox ---
  else if (ProcName = 'AUiComboBox_Add') then
    Result := Addr(AUiComboBox_Add)
  else if (ProcName = 'AUiComboBox_AddA') then
    Result := Addr(AUiComboBox_AddA)
  else if (ProcName = 'AUiComboBox_GetItemIndex') then
    Result := Addr(AUiComboBox_GetItemIndex)
  else if (ProcName = 'AUiComboBox_New') then
    Result := Addr(AUiComboBox_New)
  else if (ProcName = 'AUiComboBox_New2') then
    Result := Addr(AUiComboBox_New2)
  else if (ProcName = 'AUiComboBox_SetItemIndex') then
    Result := Addr(AUiComboBox_SetItemIndex)

  // --- Control ---
  else if (ProcName = 'AUiControl_Free') then
    Result := Addr(AUiControl_Free)
  else if (ProcName = 'AUiControl_FreeAndNil') then
    Result := Addr(AUiControl_FreeAndNil)
  else if (ProcName = 'AUiControl_GetClientHeight') then
    Result := Addr(AUiControl_GetClientHeight)
  else if (ProcName = 'AUiControl_GetClientWidth') then
    Result := Addr(AUiControl_GetClientWidth)
  else if (ProcName = 'AUiControl_GetColor') then
    Result := Addr(AUiControl_GetColor)
  else if (ProcName = 'AUiControl_GetEnabled') then
    Result := Addr(AUiControl_GetEnabled)
  else if (ProcName = 'AUiControl_GetHeight') then
    Result := Addr(AUiControl_GetHeight)
  else if (ProcName = 'AUiControl_GetHint') then
    Result := Addr(AUiControl_GetHint)
  else if (ProcName = 'AUiControl_GetHintA') then
    Result := Addr(AUiControl_GetHintA)
  else if (ProcName = 'AUiControl_GetMenu') then
    Result := Addr(AUiControl_GetMenu)
  else if (ProcName = 'AUiControl_GetName') then
    Result := Addr(AUiControl_GetName)
  else if (ProcName = 'AUiControl_GetNameA') then
    Result := Addr(AUiControl_GetNameA)
  else if (ProcName = 'AUiControl_GetPosition') then
    Result := Addr(AUiControl_GetPosition)
  else if (ProcName = 'AUiControl_GetText') then
    Result := Addr(AUiControl_GetText)
  else if (ProcName = 'AUiControl_GetTop') then
    Result := Addr(AUiControl_GetTop)
  else if (ProcName = 'AUiControl_GetVisible') then
    Result := Addr(AUiControl_GetVisible)
  else if (ProcName = 'AUiControl_GetWidth') then
    Result := Addr(AUiControl_GetWidth)
  else if (ProcName = 'AUiControl_SetAlign') then
    Result := Addr(AUiControl_SetAlign)
  else if (ProcName = 'AUiControl_SetAnchors') then
    Result := Addr(AUiControl_SetAnchors)
  else if (ProcName = 'AUiControl_SetBevel') then
    Result := Addr(AUiControl_SetBevel)
  else if (ProcName = 'AUiControl_SetClientSize') then
    Result := Addr(AUiControl_SetClientSize)
  else if (ProcName = 'AUiControl_SetColor') then
    Result := Addr(AUiControl_SetColor)
  else if (ProcName = 'AUiControl_SetCursor') then
    Result := Addr(AUiControl_SetCursor)
  else if (ProcName = 'AUiControl_SetEnabled') then
    Result := Addr(AUiControl_SetEnabled)
  else if (ProcName = 'AUiControl_SetFocus') then
    Result := Addr(AUiControl_SetFocus)
  else if (ProcName = 'AUiControl_SetFont1') then
    Result := Addr(AUiControl_SetFont1)
  else if (ProcName = 'AUiControl_SetFont1A') then
    Result := Addr(AUiControl_SetFont1A)
  else if (ProcName = 'AUiControl_SetFontColor') then
    Result := Addr(AUiControl_SetFontColor)
  else if (ProcName = 'AUiControl_SetFontSize') then
    Result := Addr(AUiControl_SetFontSize)
  else if (ProcName = 'AUiControl_SetFontStyle') then
    Result := Addr(AUiControl_SetFontStyle)
  else if (ProcName = 'AUiControl_SetHeight') then
    Result := Addr(AUiControl_SetHeight)
  else if (ProcName = 'AUiControl_SetHint') then
    Result := Addr(AUiControl_SetHint)
  else if (ProcName = 'AUiControl_SetHintA') then
    Result := Addr(AUiControl_SetHintA)
  else if (ProcName = 'AUiControl_SetName') then
    Result := Addr(AUiControl_SetName)
  else if (ProcName = 'AUiControl_SetNameA') then
    Result := Addr(AUiControl_SetNameA)
  else if (ProcName = 'AUiControl_SetOnChange') then
    Result := Addr(AUiControl_SetOnChange)
  else if (ProcName = 'AUiControl_SetOnChangeEx') then
    Result := Addr(AUiControl_SetOnChangeEx)
  else if (ProcName = 'AUiControl_SetOnClick') then
    Result := Addr(AUiControl_SetOnClick)
  else if (ProcName = 'AUiControl_SetPosition') then
    Result := Addr(AUiControl_SetPosition)
  else if (ProcName = 'AUiControl_SetSize') then
    Result := Addr(AUiControl_SetSize)
  else if (ProcName = 'AUiControl_SetTabStop') then
    Result := Addr(AUiControl_SetTabStop)
  else if (ProcName = 'AUiControl_SetText') then
    Result := Addr(AUiControl_SetText)
  else if (ProcName = 'AUiControl_SetTextA') then
    Result := Addr(AUiControl_SetTextA)
  else if (ProcName = 'AUiControl_SetTop') then
    Result := Addr(AUiControl_SetTop)
  else if (ProcName = 'AUiControl_SetVisible') then
    Result := Addr(AUiControl_SetVisible)
  else if (ProcName = 'AUiControl_SetWidth') then
    Result := Addr(AUiControl_SetWidth)

  // --- DataSource ---
  {
  else if (ProcName = 'AUiDataSource_New') then
    Result := Addr(AUiDataSource_New)
  else if (ProcName = 'AUiDataSource_SetOnDataChange') then
    Result := Addr(AUiDataSource_SetOnDataChange)
  }

  // --- AUiDialog ---
  {
  else if (ProcName = 'AUiDialog_AddButton1') then
    Result := Addr(AUiDialog_AddButton1)
  }
  else if (ProcName = 'AUiDialog_Free') then
    Result := Addr(AUiDialog_Free)
  {
  else if (ProcName = 'AUiDialog_GetButtonsBox') then
    Result := Addr(AUiDialog_GetButtonsBox)
  }
  else if (ProcName = 'AUiDialog_GetWindow') then
    Result := Addr(AUiDialog_GetWindow)
  else if (ProcName = 'AUiDialog_New') then
    Result := Addr(AUiDialog_New)
  else if (ProcName = 'AUiDialog_ShowModal') then
    Result := Addr(AUiDialog_ShowModal)

  // --- Edit ---
  else if (ProcName = 'AUiEdit_CheckDate') then
    Result := Addr(AUiEdit_CheckDate)
  else if (ProcName = 'AUiEdit_CheckFloat') then
    Result := Addr(AUiEdit_CheckFloat)
  else if (ProcName = 'AUiEdit_CheckFloat32') then
    Result := Addr(AUiEdit_CheckFloat32)
  else if (ProcName = 'AUiEdit_CheckFloat64') then
    Result := Addr(AUiEdit_CheckFloat64)
  else if (ProcName = 'AUiEdit_CheckInt') then
    Result := Addr(AUiEdit_CheckInt)
  else if (ProcName = 'AUiEdit_New') then
    Result := Addr(AUiEdit_New)
  else if (ProcName = 'AUiEdit_NewEx') then
    Result := Addr(AUiEdit_NewEx)

  // --- Grid ---
  {
  else if (ProcName = 'AUiGrid_AddColumn') then
    Result := Addr(AUiGrid_AddColumn)
  }
  else if (ProcName = 'AUiGrid_Clear') then
    Result := Addr(AUiGrid_Clear)
  else if (ProcName = 'AUiGrid_Clear2') then
    Result := Addr(AUiGrid_Clear2)
  else if (ProcName = 'AUiGrid_DeleteRow') then
    Result := Addr(AUiGrid_DeleteRow)
  else if (ProcName = 'AUiGrid_DeleteRow2') then
    Result := Addr(AUiGrid_DeleteRow2)
  else if (ProcName = 'AUiGrid_FindInt') then
    Result := Addr(AUiGrid_FindInt)
  else if (ProcName = 'AUiGrid_New') then
    Result := Addr(AUiGrid_New)
  else if (ProcName = 'AUiGrid_RestoreColProps') then
    Result := Addr(AUiGrid_RestoreColProps)
  else if (ProcName = 'AUiGrid_RestoreColPropsA') then
    Result := Addr(AUiGrid_RestoreColPropsA)
  else if (ProcName = 'AUiGrid_RowDown') then
    Result := Addr(AUiGrid_RowDown)
  else if (ProcName = 'AUiGrid_RowUp') then
    Result := Addr(AUiGrid_RowUp)
  else if (ProcName = 'AUiGrid_SaveColProps') then
    Result := Addr(AUiGrid_SaveColProps)
  else if (ProcName = 'AUiGrid_SaveColPropsA') then
    Result := Addr(AUiGrid_SaveColPropsA)
  else if (ProcName = 'AUiGrid_SetColumnWidth') then
    Result := Addr(AUiGrid_SetColumnWidth)
  else if (ProcName = 'AUiGrid_SetColumnWidth2') then
    Result := Addr(AUiGrid_SetColumnWidth2)
  else if (ProcName = 'AUiGrid_SetDataSource') then
    Result := Addr(AUiGrid_SetDataSource)
  else if (ProcName = 'AUiGrid_SetRowCount') then
    Result := Addr(AUiGrid_SetRowCount)

  // --- Image ---
  else if (ProcName = 'AUiImage_LoadFromFile') then
    Result := Addr(AUiImage_LoadFromFile)
  else if (ProcName = 'AUiImage_LoadFromFileA') then
    Result := Addr(AUiImage_LoadFromFileA)
  else if (ProcName = 'AUiImage_New') then
    Result := Addr(AUiImage_New)
  {
  else if (ProcName = 'AUiImage_SetCenter') then
    Result := Addr(AUiImage_SetCenter)
  else if (ProcName = 'AUiImage_SetTransparent') then
    Result := Addr(AUiImage_SetTransparent)
  }

  // --- Label ---
  else if (ProcName = 'AUiLabel_New') then
    Result := Addr(AUiLabel_New)
  else if (ProcName = 'AUiLabel_New2') then
    Result := Addr(AUiLabel_New2)
  else if (ProcName = 'AUiLabel_SetAlignment') then
    Result := Addr(AUiLabel_SetAlignment)
  else if (ProcName = 'AUiLabel_SetAutoSize') then
    Result := Addr(AUiLabel_SetAutoSize)
  else if (ProcName = 'AUiLabel_SetWordWrap') then
    Result := Addr(AUiLabel_SetWordWrap)

  // --- ListBox ---
  else if (ProcName = 'AUiListBox_Add') then
    Result := Addr(AUiListBox_Add)
  else if (ProcName = 'AUiListBox_Clear') then
    Result := Addr(AUiListBox_Clear)
  else if (ProcName = 'AUiListBox_DeleteItem') then
    Result := Addr(AUiListBox_DeleteItem)
  else if (ProcName = 'AUiListBox_GetCount') then
    Result := Addr(AUiListBox_GetCount)
  else if (ProcName = 'AUiListBox_GetItem') then
    Result := Addr(AUiListBox_GetItem)
  else if (ProcName = 'AUiListBox_GetItemIndex') then
    Result := Addr(AUiListBox_GetItemIndex)
  else if (ProcName = 'AUiListBox_New') then
    Result := Addr(AUiListBox_New)
  else if (ProcName = 'AUiListBox_New2') then
    Result := Addr(AUiListBox_New2)
  else if (ProcName = 'AUiListBox_SetChecked') then
    Result := Addr(AUiListBox_SetChecked)
  else if (ProcName = 'AUiListBox_SetItem') then
    Result := Addr(AUiListBox_SetItem)
  else if (ProcName = 'AUiListBox_SetItemHeight') then
    Result := Addr(AUiListBox_SetItemHeight)
  else if (ProcName = 'AUiListBox_SetItemIndex') then
    Result := Addr(AUiListBox_SetItemIndex)
  else if (ProcName = 'AUiListBox_SetOnDblClick') then
    Result := Addr(AUiListBox_SetOnDblClick)

  // --- MainWindow ---
  else if (ProcName = 'AUiMainWindow_AddMenuItem') then
    Result := Addr(AUiMainWindow_AddMenuItem)
  else if (ProcName = 'AUiMainWindow_AddMenuItemA') then
    Result := Addr(AUiMainWindow_AddMenuItemA)
  else if (ProcName = 'AUiMainWindow_GetLeftContainer') then
    Result := Addr(AUiMainWindow_GetLeftContainer)
  else if (ProcName = 'AUiMainWindow_GetMainContainer') then
    Result := Addr(AUiMainWindow_GetMainContainer)
  else if (ProcName = 'AUiMainWindow_GetRightContainer') then
    Result := Addr(AUiMainWindow_GetRightContainer)

  // --- Menu ---
  else if (ProcName = 'AUiMenu_AddItem0') then
    Result := Addr(AUiMenu_AddItem0)
  else if (ProcName = 'AUiMenu_AddItem1') then
    Result := Addr(AUiMenu_AddItem1)
  else if (ProcName = 'AUiMenu_AddItem2') then
    Result := Addr(AUiMenu_AddItem2)
  else if (ProcName = 'AUiMenu_AddItem3') then
    Result := Addr(AUiMenu_AddItem3)
  else if (ProcName = 'AUiMenu_Clear') then
    Result := Addr(AUiMenu_Clear)
  else if (ProcName = 'AUiMenu_FindItemByName') then
    Result := Addr(AUiMenu_FindItemByName)
  else if (ProcName = 'AUiMenu_GetItems') then
    Result := Addr(AUiMenu_GetItems)
  else if (ProcName = 'AUiMenu_New') then
    Result := Addr(AUiMenu_New)
  {
  else if (ProcName = 'AUiMenu_New2') then
    Result := Addr(AUiMenu_New2)
  }
  else if (ProcName = 'AUiMenu_SetChecked') then
    Result := Addr(AUiMenu_SetChecked)

  // --- PageControl ---
  else if (ProcName = 'AUiPageControl_AddPage') then
    Result := Addr(AUiPageControl_AddPage)
  else if (ProcName = 'AUiPageControl_AddPageA') then
    Result := Addr(AUiPageControl_AddPageA)
  else if (ProcName = 'AUiPageControl_New') then
    Result := Addr(AUiPageControl_New)

  // --- ProgressBar ---
  else if (ProcName = 'AUiProgressBar_New') then
    Result := Addr(AUiProgressBar_New)
  else if (ProcName = 'AUiProgressBar_SetMaxPosition') then
    Result := Addr(AUiProgressBar_SetMaxPosition)
  else if (ProcName = 'AUiProgressBar_SetPosition') then
    Result := Addr(AUiProgressBar_SetPosition)
  else if (ProcName = 'AUiProgressBar_StepBy') then
    Result := Addr(AUiProgressBar_StepBy)
  else if (ProcName = 'AUiProgressBar_StepIt') then
    Result := Addr(AUiProgressBar_StepIt)

  // --- PropertyBox ---
  else if (ProcName = 'AUiPropertyBox_Add') then
    Result := Addr(AUiPropertyBox_Add)
  else if (ProcName = 'AUiPropertyBox_Add2') then
    Result := Addr(AUiPropertyBox_Add2)
  {
  else if (ProcName = 'AUiPropertyBox_GetUseBigFont') then
    Result := Addr(AUiPropertyBox_GetUseBigFont)
  }
  else if (ProcName = 'AUiPropertyBox_Item_GetValue') then
    Result := Addr(AUiPropertyBox_Item_GetValue)
  else if (ProcName = 'AUiPropertyBox_Item_SetValue') then
    Result := Addr(AUiPropertyBox_Item_SetValue)
  else if (ProcName = 'AUiPropertyBox_New') then
    Result := Addr(AUiPropertyBox_New)
  {
  else if (ProcName = 'AUiPropertyBox_SetIsAppPoints') then
    Result := Addr(AUiPropertyBox_SetIsAppPoints)
  else if (ProcName = 'AUiPropertyBox_SetUseBigFont') then
    Result := Addr(AUiPropertyBox_SetUseBigFont)
  }

  // --- Report ---
  else if (ProcName = 'AUiReport_New') then
    Result := Addr(AUiReport_New)
  else if (ProcName = 'AUiReport_SetText') then
    Result := Addr(AUiReport_SetText)

  // --- ReportWin ---
  else if (ProcName = 'AUiReportWin_New') then
    Result := Addr(AUiReportWin_New)
  else if (ProcName = 'AUiReportWin_New2') then
    Result := Addr(AUiReportWin_New2)
  else if (ProcName = 'AUiReportWin_ShowReport') then
    Result := Addr(AUiReportWin_ShowReport)

  // --- SpinButton ---
  else if (ProcName = 'AUiSpinButton_New') then
    Result := Addr(AUiSpinButton_New)

  // --- SpinEdit ---
  else if (ProcName = 'AUiSpinEdit_GetValue') then
    Result := Addr(AUiSpinEdit_GetValue)
  else if (ProcName = 'AUiSpinEdit_New') then
    Result := Addr(AUiSpinEdit_New)
  else if (ProcName = 'AUiSpinEdit_NewEx') then
    Result := Addr(AUiSpinEdit_NewEx)
  else if (ProcName = 'AUiSpinEdit_SetValue') then
    Result := Addr(AUiSpinEdit_SetValue)

  // --- Splitter ---
  else if (ProcName = 'AUiSplitter_New') then
    Result := Addr(AUiSplitter_New)

  // --- TextView ---
  else if (ProcName = 'AUiTextView_AddLine') then
    Result := Addr(AUiTextView_AddLine)
  else if (ProcName = 'AUiTextView_New') then
    Result := Addr(AUiTextView_New)
  else if (ProcName = 'AUiTextView_SetFont') then
    Result := Addr(AUiTextView_SetFont)
  else if (ProcName = 'AUiTextView_SetReadOnly') then
    Result := Addr(AUiTextView_SetReadOnly)
  else if (ProcName = 'AUiTextView_SetScrollBars') then
    Result := Addr(AUiTextView_SetScrollBars)
  else if (ProcName = 'AUiTextView_SetWordWrap') then
    Result := Addr(AUiTextView_SetWordWrap)

  // --- ToolBar ---
  else if (ProcName = 'AUiToolBar_AddButton') then
    Result := Addr(AUiToolBar_AddButton)
  else if (ProcName = 'AUiToolBar_AddButton1') then
    Result := Addr(AUiToolBar_AddButton1)
  else if (ProcName = 'AUiToolBar_New') then
    Result := Addr(AUiToolBar_New)

  // --- ToolMenu ---
  else if (ProcName = 'AUiToolMenu_AddNewItem') then
    Result := Addr(AUiToolMenu_AddNewItem)
  else if (ProcName = 'AUiToolMenu_AddNewSubMenu') then
    Result := Addr(AUiToolMenu_AddNewSubMenu)
  else if (ProcName = 'AUiToolMenu_GetSubMenu') then
    Result := Addr(AUiToolMenu_GetSubMenu)
  else if (ProcName = 'AUiToolMenu_New') then
    Result := Addr(AUiToolMenu_New)

  // --- TrayIcon ---
  else if (ProcName = 'AUiTrayIcon_Free') then
    Result := Addr(AUiTrayIcon_Free)
  else if (ProcName = 'AUiTrayIcon_GetHint') then
    Result := Addr(AUiTrayIcon_GetHint)
  else if (ProcName = 'AUiTrayIcon_GetMenuItems') then
    Result := Addr(AUiTrayIcon_GetMenuItems)
  else if (ProcName = 'AUiTrayIcon_GetPopupMenu') then
    Result := Addr(AUiTrayIcon_GetPopupMenu)
  else if (ProcName = 'AUiTrayIcon_New') then
    Result := Addr(AUiTrayIcon_New)
  else if (ProcName = 'AUiTrayIcon_SetHint') then
    Result := Addr(AUiTrayIcon_SetHint)
  else if (ProcName = 'AUiTrayIcon_SetIcon') then
    Result := Addr(AUiTrayIcon_SetIcon)
  else if (ProcName = 'AUiTrayIcon_SetIsActive') then
    Result := Addr(AUiTrayIcon_SetIsActive)
  else if (ProcName = 'AUiTrayIcon_SetOnLeftClick') then
    Result := Addr(AUiTrayIcon_SetOnLeftClick)
  else if (ProcName = 'AUiTrayIcon_SetOnRightClick') then
    Result := Addr(AUiTrayIcon_SetOnRightClick)
  else if (ProcName = 'AUiTrayIcon_SetPopupMenu') then
    Result := Addr(AUiTrayIcon_SetPopupMenu)

  // --- TreeView ---
  else if (ProcName = 'AUiTreeView_AddItem') then
    Result := Addr(AUiTreeView_AddItem)
  else if (ProcName = 'AUiTreeView_New') then
    Result := Addr(AUiTreeView_New)

  // --- WaitWin ---
  else if (ProcName = 'AUiWaitWin_New') then
    Result := Addr(AUiWaitWin_New)
  else if (ProcName = 'AUiWaitWin_SetMaxPosition') then
    Result := Addr(AUiWaitWin_SetMaxPosition)
  else if (ProcName = 'AUiWaitWin_SetPosition') then
    Result := Addr(AUiWaitWin_SetPosition)
  else if (ProcName = 'AUiWaitWin_SetText') then
    Result := Addr(AUiWaitWin_SetText)
  else if (ProcName = 'AUiWaitWin_StepBy') then
    Result := Addr(AUiWaitWin_StepBy)

  // --- Window ---
  else if (ProcName = 'AUiWindow_Add') then
    Result := Addr(AUiWindow_Add)
  else if (ProcName = 'AUiWindow_Free') then
    Result := Addr(AUiWindow_Free)
  else if (ProcName = 'AUiWindow_FreeAndNil') then
    Result := Addr(AUiWindow_FreeAndNil)
  else if (ProcName = 'AUiWindow_GetMenu') then
    Result := Addr(AUiWindow_GetMenu)
  else if (ProcName = 'AUiWindow_LoadConfig') then
    Result := Addr(AUiWindow_LoadConfig)
  else if (ProcName = 'AUiWindow_LoadConfig2') then
    Result := Addr(AUiWindow_LoadConfig2)
  else if (ProcName = 'AUiWindow_New') then
    Result := Addr(AUiWindow_New)
  else if (ProcName = 'AUiWindow_SaveConfig') then
    Result := Addr(AUiWindow_SaveConfig)
  else if (ProcName = 'AUiWindow_SaveConfig2') then
    Result := Addr(AUiWindow_SaveConfig2)
  else if (ProcName = 'AUiWindow_SetBorderStyle') then
    Result := Addr(AUiWindow_SetBorderStyle)
  else if (ProcName = 'AUiWindow_SetFormStyle') then
    Result := Addr(AUiWindow_SetFormStyle)
  else if (ProcName = 'AUiWindow_SetPosition') then
    Result := Addr(AUiWindow_SetPosition)
  else if (ProcName = 'AUiWindow_SetState') then
    Result := Addr(AUiWindow_SetState)
  else if (ProcName = 'AUiWindow_ShowModal') then
    Result := Addr(AUiWindow_ShowModal)
  else if (ProcName = 'AUiWindow_ShowModal2') then
    Result := Addr(AUiWindow_ShowModal2)
  else
    Result := nil;
end;

function AUiMod_Init(): AError;
begin
  if (ARuntime_InitModuleByUid(ASystem_Uid) < 0) then
  begin
    Result := -1;
    Exit;
  end;

  //FOnDone := AEvents.Event_NewW(0, nil);

  Result := AUi_Init();
end;

end.
