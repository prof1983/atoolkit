{**
@Abstract User Interface
@Author Prof1983 <prof1983@ya.ru>
@Created 25.10.2008
@LastMod 27.12.2012
}
unit AUi;

{$I A.inc}
{$I Defines.inc}

{$IFDEF FPC}
  {$mode delphi}{$h+}
{$ENDIF}

{$IFDEF OLDMAINFORM2}
  {$DEFINE OLDMAINFORM}
{$ENDIF}

{$IFNDEF NoEvents}
  {$DEFINE USE_EVENTS}
{$ENDIF}

{$IFNDEF NoRuntime}
  {$DEFINE USE_RUNTIME}
{$ENDIF}

{$IFNDEF NoSettings}
  {$DEFINE USE_SETTINGS}
{$ENDIF}

interface

uses
  ABase, ABaseTypes,
  {$IFDEF USE_RUNTIME}ARuntime,{$ENDIF}
  {$IFDEF USE_SETTINGS}ASettings,{$ENDIF}
  AStrings, ASystem,
  AUiBase, AUiBox, AUiButtons, AUiCalendar, AUiControls, AUiControlsA,
  AUiData,
  AUiDataSource,
  AUiDialogs,
  AUiEdit,
  AUiEvents,
  AUiEventsObj,
  AUiForm,
  AUiGrids,
  AUiImages, AUiInit, AUiLabels, AUiListBox, AUiMain, AUiMainWindow, AUiMainWindow2, AUiMenus,
  AUiPageControl, AUiProgressBar, AUiPropertyBox, AUiReports, AUiSpin, AUiSplitter,
  AUiTextView, AUiToolBar, AUiToolMenu, AUiTrayIcon, AUiTreeView,
  AUiWaitWin, AUiWindows, AUiWindowSettings;

// --- Procs ---

function Init(): AError; stdcall;
function Done(): AError; stdcall;

function InitMainTrayIcon(): AError; stdcall;

function InitMenus(): AError; stdcall;

procedure InitMenus02(); stdcall;

{ Box }

{**
  Создает новую панель.
  BoxType
    0 - Simple
    1 - HBox
    2 - VBox
}
function Box_New(Parent: AControl; BoxType: AInteger): AControl; stdcall;

function Button_New(Parent: AControl): AButton; stdcall;
function Button_SetKind(Button: AButton; Kind: TAUIButtonKind): AError; stdcall;

function Calendar_New(Parent: AControl): AControl; stdcall;
function Calendar_GetDate(Calendar: AControl): TDateTime; stdcall;
function Calendar_SetMonth(Calendar: AControl; Value: AInteger): AError; stdcall;

//** Освобождает память занятую элементом.
function Control_Free(Control: AControl): AError; stdcall;

function Control_GetColor(Control: AControl): AColor; stdcall;
function Control_GetEnabled(Control: AControl): ABoolean; stdcall;
function Control_GetHeight(Control: AControl): AInteger; stdcall;
function Control_GetHintP(Control: AControl): APascalString; stdcall;
function Control_GetHintWS(Control: AControl): AWideString; stdcall;

function Control_GetMenu(Control: AControl): AMenu; stdcall;

function Control_GetNameP(Control: AControl): APascalString; stdcall;
function Control_GetNameWS(Control: AControl): AWideString; stdcall;
function Control_GetTextP(Control: AControl): APascalString; stdcall;
function Control_GetVisible(Control: AControl): ABoolean; stdcall;
function Control_GetWidth(Control: AControl): AInteger; stdcall;

//** Задает присоединение элемента.
function Control_SetAlign(Control: AControl; Align: TUIAlign): AError; stdcall;

//** Задает присоединение элемента.
procedure Control_SetAlign02(Control: AControl; Align: TUIAlign); stdcall;

//** Задает внутренний размер элемента.
function Control_SetClientSize(Control: AControl; ClientWidth, ClientHeight: AInteger): AError; stdcall;

//** Задает цвет элемента.
function Control_SetColor(Control: AControl; Color: AColor): AError; stdcall;

//** Задает цвет элемента.
procedure Control_SetColor02(Control: AControl; Color: AColor); stdcall;

function Control_SetEnabled(Control: AControl; Value: ABoolean): AError; stdcall;
function Control_SetFocus(Control: AControl): ABoolean; stdcall;

//** Задает шрифт.
function Control_SetFont1A(Control: AControl; {const} FontName: PAnsiChar; FontSize: AInteger): AError; stdcall;

//** Задает шрифт.
function Control_SetFont1P(Control: AControl; const FontName: APascalString; FontSize: AInteger): AError; stdcall;

function Control_SetFont2P(Control: AControl; const FontName: APascalString; FontSize: AInteger; FontColor: AColor): AError; stdcall;
function Control_SetHeight(Control: AControl; Value: AInteger): AInteger; stdcall;
procedure Control_SetHint02(Control: AControl; const Value: APascalString); stdcall;
function Control_SetHintP(Control: AControl; const Value: APascalString): AError; stdcall;
function Control_SetHintWS(Control: AControl; const Value: AWideString): AError; stdcall;
procedure Control_SetName02(Control: AControl; const Value: APascalString); stdcall;
function Control_SetNameP(Control: AControl; const Value: APascalString): AError; stdcall;
function Control_SetNameWS(Control: AControl; const Value: AWideString): AError; stdcall;
function Control_SetOnChange(Control: AControl; OnChange: ACallbackProc): AError; stdcall;
procedure Control_SetOnChange02(Control: AControl; OnChange: ACallbackProc02); stdcall;
function Control_SetOnChangeEx(Control: AControl; OnChange: ACallbackProc03; Obj: AInteger): AError; stdcall;
function Control_SetOnClick(Control: AControl; Value: ACallbackProc): AError; stdcall;
procedure Control_SetOnClick02(Control: AControl; Value: ACallbackProc02); stdcall;

//** Задает расположение элемента.
function Control_SetPosition(Control: AControl; Left, Top: AInteger): AError; stdcall;

procedure Control_SetPosition02(Control: AControl; Left, Top: Integer); stdcall;

//** Задает внешний размер элемента.
function Control_SetSize(Control: AControl; Width, Height: Integer): AError; stdcall;

procedure Control_SetSize02(Control: AControl; Width, Height: Integer); stdcall;

//** Задает текст элемента.
procedure Control_SetText02(Control: AControl; const Value: AWideString); stdcall;

//** Задает текст элемента.
function Control_SetTextP(Control: AControl; const Value: APascalString): AError; stdcall;

//** Задает текст элемента.
function Control_SetTextWS(Control: AControl; const Value: AWideString): AError; stdcall;

//** Задает видимость элемента.
function Control_SetVisible(Control: AControl; Value: ABoolean): AError; stdcall;

//** Задает видимость элемента.
procedure Control_SetVisible02(Control: AControl; Value: ABoolean); stdcall;

function Control_SetWidth(Control: AControl; Value: AInteger): AInteger; stdcall;

function DataSource_New(): PADataSource; stdcall;
procedure DataSource_SetOnDataChange02(DataSource: PADataSource; OnDataChange: ACallbackProc02); stdcall;

{ Dialog }

function Dialog_About: AError; stdcall;

function Dialog_About_New(): AWindow; stdcall;

function Dialog_About_Init(AboutDialog: AWindow): AError; stdcall;

function Dialog_AddButtonP(Win: AWindow; Left, Width: AInteger; const Text: APascalString;
    OnClick: ACallbackProc): AControl; stdcall;

function Dialog_AddButtonWS(Win: AWindow; Left, Width: AInteger; const Text: AWideString;
    OnClick: ACallbackProc): AControl; stdcall;

function Dialog_Calendar(var Date: TDateTime; CenterX, CenterY: AInteger): ABoolean; stdcall;

function Dialog_Color(var Color: AColor): ABoolean; stdcall;

function Dialog_DateFilter(var Group: Integer; var DateBegin, DateEnd: TDateTime): Boolean; stdcall;

function Dialog_ErrorP(const Caption, UserMessage, ExceptMessage: APascalString): AError; stdcall;

function Dialog_ErrorWS(const Caption, UserMessage, ExceptMessage: AWideString): AError; stdcall;

function Dialog_FontP(var FontName: APascalString; var FontSize: AInteger; FontColor: AColor): ABoolean; stdcall;

//** Возвращает окно.
function Dialog_GetWindow(Dialog: ADialog): AWindow; stdcall;

function Dialog_InputBox1P(const Text: APascalString; var Value: APascalString): Boolean; stdcall;

function Dialog_InputBox1WS(const Text: AWideString; var Value: AWideString): ABoolean; stdcall;

function Dialog_InputBox2P(const Caption, Text1, Text2: APascalString; var Value1, Value2: APascalString): ABoolean; stdcall;

function Dialog_InputBox2WS(const Caption, Text1, Text2: AWideString; var Value1, Value2: AWideString): ABoolean; stdcall;

function Dialog_InputBox3P(const Caption, Text: APascalString; var Value: APascalString): Boolean; stdcall;

function Dialog_InputBox3WS(const Caption, Text: AWideString; var Value: AWideString): ABoolean; stdcall;

function Dialog_LoginP(var UserName, Password: APascalString; IsSave: ABoolean): ABoolean; stdcall;

function Dialog_LoginWS(var UserName, Password: AWideString; IsSave: ABoolean): ABoolean; stdcall;

function Dialog_MessageDlgWS(const Msg: AWideString; MsgDlgType: AInteger; Flags: AMessageBoxFlags): AInteger; stdcall;

function Dialog_MessageP(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

function Dialog_MessageWS(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

//** Создает новый диалог.
function Dialog_New(Buttons: AUIWindowButtons): ADialog; stdcall;

function Dialog_OpenFileWS(const InitialDir, Filter, Title: AWideString; var FileName: AWideString): ABoolean; stdcall;

// Отображает окно выбора и настройки печати.
function Dialog_PrinterSetup(): AError; stdcall;

function Dialog_SelectDirectoryP(var Directory: APascalString): ABoolean; stdcall;

{ Edit }

function Edit_CheckDate(Edit: AControl; out Value: TDateTime): ABoolean; stdcall;

function Edit_CheckFloat(Edit: AControl; out Value: Double): ABoolean; stdcall;

function Edit_CheckFloat32(Edit: AControl; out Value: AFloat32): ABoolean;

function Edit_CheckFloat64(Edit: AControl; out Value: AFloat64): ABoolean;

// Переводит текст в Int. Если ошибка, то переходит на этот компонент и возвращает False.
function Edit_CheckInt(Edit: AControl; out Value: AInteger): ABoolean; stdcall;

// Создает новый элемент TEdit.
function Edit_New(Parent: AControl): AControl; stdcall;

{**
  Создает новый элемент TEdit.
  EditType
    0 - TEdit
    1 - TEdit + Button
    3 - TSpinEdit
}
function Edit_New02(Parent: AControl; EditType: AInteger; OnClick: ACallbackProc02;
    Left, Top, Width: AInteger): AControl; stdcall;

{**
  Создает новый элемент TEdit.
  EditType
    0 - TEdit
    1 - TEdit + Button
    3 - TSpinEdit
}
function Edit_NewA(Parent: AControl; EditType: AInteger; OnClick: ACallbackProc;
    Left, Top, Width: AInteger): AControl; stdcall;

{ Grid }

// Производит очистку таблицы. Пока работает только для TStringGrid.
function Grid_Clear(Grid: AControl): AError; stdcall;

// Производит очистку таблицы. Пока работает только для TStringGrid.
function Grid_ClearA(Grid: AControl; FixedRows: AInteger): AError; stdcall;

//** Удаляет указанную строку.
function Grid_DeleteRow2(Grid: AControl; Row: AInteger): AError; stdcall;

function Grid_SetColumnWidth(Grid: AControl; ColumnIndex, Width, Persent, MinWidth: AInteger): AError; stdcall;

procedure Grid_SetColumnWidth02(Grid: AControl; ColumnIndex, Width, Persent, MinWidth: AInteger); stdcall;

function Grid_SetColumnWidth2(Grid: AControl; ColumnIndex, Width, Persent, MinWidth, MaxWidth: AInteger): AError; stdcall;

procedure Grid_SetColumnWidthA(Grid: AControl; ColumnIndex, Width, Persent, MinWidth, MaxWidth: AInteger); stdcall;

// Производит поиск значения в заданной колонке. Работает пока только для TStringGrid.
function Grid_FindInt(Grid: AControl; Col, Value: AInteger): AInteger; stdcall;

{ GridType
    0 - StringGrid
    1 - DBGrid }
function Grid_New(Parent: AControl; GridType: AInteger): AControl; stdcall;

// Восстанавливает колоноки DBGrid или StringGrid.
function Grid_RestoreColPropsWS(Grid: AControl; Config: AConfig; const Key: AWideString; Delimer: AWideChar = '\'): AError; stdcall;

// Восстанавливает колоноки DBGrid или StringGrid.
procedure Grid_RestoreColPropsWS02(Grid: AControl; Config: AConfig; const Key: AWideString; Delimer: AWideChar = '\'); stdcall;

// Удаляет строчку. Работает пока только для TStringGrid.
function Grid_RowDelete(Grid: AControl): AError; stdcall;

// Перемещает строчку ниже. Работает пока только для TStringGrid.
function Grid_RowDown(Grid: AControl): AError; stdcall;

// Перемещает строчку выше. Работает пока только для TStringGrid.
function Grid_RowUp(Grid: AControl): AError; stdcall;

// Сохраняет колоноки DBGrid или StringGrid.
function Grid_SaveColPropsWS(Grid: AControl; Config: AConfig; const Key: AWideString; Delimer: AWideChar = '\'): AError; stdcall;

// Сохраняет колоноки DBGrid или StringGrid.
procedure Grid_SaveColPropsWS02(Grid: AControl; Config: AConfig; const Key: AWideString; Delimer: AWideChar = '\'); stdcall;

function Grid_SetDataSource(Grid: AControl; Value: PADataSource): AError; stdcall;

procedure Grid_SetDataSource02(Grid: AControl; Value: PADataSource); stdcall;

// Задает кол-во строк в таблице. Работает пока только для TStringGrid.
function Grid_SetRowCount(Grid: AControl; Count: AInteger): AError; stdcall;

{ Image }

//** Загружает изображение из файла.
function Image_LoadFromFileWS(Image: AControl; const FileName: AWideString): AError; stdcall;

//** Создает новый элемент-изображение.
function Image_New(Parent: AControl): AControl; stdcall;

{ Label }

//** Создает новый элемент тестового вывода.
function Label_New(Parent: AControl): AControl; stdcall;

// --- ListBox ---

//** Добавляет строку в список.
function ListBox_AddP(ListBox: AControl; const Text: APascalString): AInteger; stdcall;

//** Добавляет строку в список.
function ListBox_AddWS(ListBox: AControl; const Text: AWideString): AInteger; stdcall;

//** Создает новый элемент ListBox.
function ListBox_New(Parent: AControl): AControl; stdcall;

{ MainToolBar }

function MainToolBar(): AControl; stdcall;

procedure MainToolBar_Set(ToolBar: AControl); stdcall;

{ MainWindow }

//** Возвращает идентификатор главного окна программы.
function MainWindow(): AWindow; stdcall;

//** Добавляет пункт меню в главное окно.
function MainWindow_AddMenuItem(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc; ImageID, Weight: Integer): AMenuItem; stdcall;

//** Добавляет пункт меню в главное окно.
function MainWindow_AddMenuItem02(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc02; ImageID, Weight: AInteger): AMenuItem; stdcall;

//** Добавляет пункт меню в главное окно.
function MainWindow_AddMenuItem03WS(const ParentItemName, Name, Text: AWideString;
    OnClick: ACallbackProc03; ImageId, Weight: AInteger): AMenuItem; stdcall;

//** Добавляет пункт меню в главное окно.
function MainWindow_AddMenuItem2(const ParentItemName, Name, Text: AString_Type;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AMenuItem; stdcall;

//** Добавляет пункт меню в главное окно.
function MainWindow_AddMenuItem2WS(const ParentItemName, Name, Text: AWideString;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AMenuItem; stdcall;

//** Добавляет пункт меню в главное окно.
function MainWindow_AddMenuItem2WS02(const ParentItemName, Name, Text: AWideString;
    OnClick: ACallbackProc02; ImageId, Weight: AInteger): AMenuItem; stdcall;

function MainWindow_GetLeftContainer(): AControl; stdcall;

//** Возврящает основной контейнер UI.
function MainWindow_GetMainContainer(): AControl; stdcall;

function MainWindow_GetRightContainer(): AControl; stdcall;

procedure MainWindow_Set(Value: AWindow); stdcall;

procedure MainWindow_SetA(Value: AWindow; ToolBar, StatusBar: AControl; Config: AConfig); stdcall;

{ Menu }

function MenuItem_Clear(MenuItem: AMenuItem): AError; stdcall;

function MenuItem_FindByName(MenuItem: AMenuItem; const Name: APascalString): AMenuItem; stdcall;

function MenuItem_SetChecked(MenuItem: AMenuItem; Checked: ABoolean): AError; stdcall;

//** Добавляет пункт меню.
function Menu_AddItem0(Parent: AMenuItem; MenuItem: AMenuItem; Weight: AInteger): AMenuItem; stdcall;

//** Добавляет пункт меню.
function Menu_AddItem1(Menu: AMenu; const Name, Text: AString_Type;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AMenuItem; stdcall;

//** Добавляет пункт меню.
function Menu_AddItem1P(Menu: AMenu; const Name, Text: APascalString;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AMenuItem; stdcall;

//** Добавляет пункт меню.
function Menu_AddItem2(Parent: AMenuItem; const Name, Text: AString_Type;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AMenuItem; stdcall;

//** Добавляет пункт меню.
function Menu_AddItem2P(Parent: AMenuItem; const Name, Text: APascalString;
    OnClick: ACallbackProc; ImageID, Weight: Integer): AMenuItem; stdcall;

//** Добавляет пункт меню.
function Menu_AddItem2WS(Parent: AMenuItem; const Name, Text: AWideString;
    OnClick: ACallbackProc; ImageId, Weight: Integer): AMenuItem; stdcall;

//** Добавляет пункт меню.
function Menu_AddItem2WS02(Parent: AMenuItem; const Name, Text: AWideString;
    OnClick: ACallbackProc02; ImageID, Weight: Integer): AMenuItem; stdcall;

//** Добавляет пункт меню.
function Menu_AddItem2WS03(Parent: AMenuItem; const Name, Text: AWideString;
    OnClick: ACallbackProc03; ImageID, Weight: AInteger): AMenuItem; stdcall;

//** Добавляет пункт меню.
function Menu_AddItem3(Parent: AMenuItem; MenuItem: AMenuItem; Weight: AInteger): AMenuItem; stdcall; deprecated; { Use Menu_AddItem0() }

//** Добавляет пункт меню.
function Menu_AddItem3WS(Parent: AMenuItem; const Name, Text: AWideString;
    OnClick: ACallbackProc; ImageID, Weight, Tag: Integer): AMenuItem; stdcall;

//** Добавляет пункт меню.
function Menu_AddItem3WS03(Parent: AMenuItem; const Name, Text: AWideString;
    OnClick: ACallbackProc03; ImageID, Weight, Tag: Integer): AMenuItem; stdcall;

function Menu_GetItems(Menu: AMenu): AMenuItem; stdcall;

function Menu_New(MenuType: AInteger): AMenu; stdcall;

{ PageControl }

{ Создает новую вкладку. Возврашает:
  0 - если произошла ошибка, иначе идентификатор новой вкладки (если операция прошла успешно) }
function PageControl_AddPage(PageControl: AControl; const Name, Text: APascalString): AControl; stdcall;

{ Создает новую вкладку. Возврашает:
  0 - если произошла ошибка, иначе идентификатор новой вкладки (если операция прошла успешно) }
function PageControl_AddPageWS(PageControl: AControl; const Name, Text: AWideString): AControl; stdcall;

function PageControl_New(Parent: AControl): AControl; stdcall;

{ ProgressBar }

//** Создает новый элемент отображения процесса.
function ProgressBar_New(Parent: AControl; Max: AInteger): AControl; stdcall;

//** Увеличивает значение прогресса на один шаг.
function ProgressBar_StepIt(ProgressBar: AControl): AInteger; stdcall;

{ Report }

function Report_New(Parent: AControl): AReport; stdcall;

{ ReportWin }

function ReportWin_New(): AWindow; stdcall;

{ Создает новое окно отчета.
  ReportWinType - Тип окна отчета: 0-TReportForm; 1-SimpleReport }
function ReportWin_New2P(ReportWinType: AInteger; const Text: APascalString): AWindow; stdcall;

{ Создает новое окно отчета.
  ReportWinType - Тип окна отчета: 0-TReportForm; 1-SimpleReport }
function ReportWin_New2WS(ReportWinType: AInteger; const Text: AWideString): AWindow; stdcall;

{ Создает новое окно отчета.
  ReportWinType - Тип окна отчета: 0-TReportForm; 1-SimpleReport }
function ReportWin_NewWS(ReportWinType: AInteger; const Text: AWideString): AWindow; stdcall;

// Отображает модальное окно с отчетом.
function ReportWin_ShowReportP(const Text: APascalString; Font: AFont): AError; stdcall;

{ --- TextView --- }

//** Добавляет строку в элемент TextView.
function TextView_AddLineWS(TextView: AControl; const Text: AWideString): AInteger; stdcall;

{**
  Создает новый элемент редактирования текста
  ViewType
    0 - TMemo
    1 - RichEdit
}
function TextView_New(Parent: AControl; ViewType: AInteger): AControl; stdcall;

//** Устанавливает значение параметра "Только чтение".
function TextView_SetReadOnly(TextView: AControl; ReadOnly: ABoolean): AError; stdcall;

//** Устанавливает значение параметра "Только чтение".
procedure TextView_SetReadOnly02(TextView: AControl; ReadOnly: ABoolean); stdcall;

{**
  Указывает какие ползунки отображать.
  ScrollBars
    0 - ssNone
    1 - ssHorizontal
    2 - ssVertical
    3 - ssBoth
}
function TextView_SetScrollBars(TextView: AControl; ScrollBars: AInteger): AError; stdcall;

{**
  Указывает какие ползунки отображать.
  ScrollBars
    0 - ssNone
    1 - ssHorizontal
    2 - ssVertical
    3 - ssBoth
}
procedure TextView_SetScrollBars02(TextView: AControl; ScrollBars: AInteger); stdcall;

//** Задает параметр "переносить по словам".
function TextView_SetWordWrap(TextView: AControl; Value: ABoolean): AError; stdcall;

//** Задает параметр "переносить по словам".
procedure TextView_SetWordWrap02(TextView: AControl; Value: ABoolean); stdcall;

{ --- ToolBar --- }

function ToolBar_AddButtonWS(ToolBar: AControl; const Name, Text, Hint: AWideString;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AButton; stdcall;

function ToolBar_AddButtonWS02(ToolBar: AControl; const Name, Text, Hint: AWideString;
    OnClick: ACallbackProc02; ImageId, Weight: AInteger): AButton; stdcall;

function ToolBar_AddButtonWS03(ToolBar: AControl; const Name, Text, Hint: AWideString;
    OnClick: ACallbackProc03; ImageId, Weight: AInteger): AButton; stdcall;

function ToolBar_New(Parent: AControl): AControl; stdcall;

// --- ToolMenu ---

function ToolMenu_AddButtonWS(ToolMenu: AToolMenu; const Name, Text, Hint: AWideString;
    OnClick: ACallbackProc03; ImageId, Weight: AInteger): AButton; stdcall;

function ToolMenu_AddNewItemWS(Parent: AToolMenu; const Name, Text: AWideString;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AToolMenu; stdcall;

function ToolMenu_AddNewSubMenu(Parent: AToolMenu; const Name, Text: AString_Type;
    ImageId, Weight: AInteger): AToolMenu; stdcall;

function ToolMenu_AddNewSubMenuWS(Parent: AToolMenu; const Name, Text: AWideString;
    ImageId, Weight: AInteger): AToolMenu; stdcall;

function ToolMenu_GetSubMenuWS(Parent: AToolMenu; const Name, Text: AWideString;
    ImageId, Weight: AInteger): AToolMenu; stdcall;

function ToolMenu_New(Parent: AControl): AToolMenu; stdcall;

// --- TreeView ---

//** Добавляет элемент в TreeView.
function TreeView_AddItemWS(TreeView: AControl; Parent: ATreeNode; Text: AWideString): ATreeNode; stdcall;

//** Создает новый элемент TreeView.
function TreeView_New(Parent: AControl): AControl; stdcall;

// --- Splitter ---

{**
  Создает динамический разделитель.
  SplitterType
    0 - HSplitter (Align=alTop)
    1 - VSplitter (Align=alLeft)
    2 - HSplitter (Align=alBottom)
    3 - VSplitter (Align=alRight)
}
function Splitter_New(Parent: AControl; SplitterType: AUISplitterType): AControl; stdcall;

{ WaitWin }

function WaitWin_NewWS(const Caption, Text: AWideString; MaxPosition: Integer): AWindow; stdcall;
function WaitWin_SetMaxPosition(WaitWin: AWindow; MaxPosition: AInteger): AError; stdcall;
function WaitWin_SetPosition(WaitWin: AWindow; Position: AInteger): AError; stdcall;
function WaitWin_SetTextWS(Window: AWindow; const Text: AWideString): AError; stdcall;
function WaitWin_StepBy(Window: AWindow; Step: AInteger): AInteger; stdcall;

{ Window }

// Добавляет окно (только VCL)
function Window_Add(Window: AWindow): AError; stdcall;

//** Освобождает окно.
procedure Window_Free(Window: AWindow); stdcall;

// Возвращает главное меню указанного окна
function Window_GetMenu(Window: AWindow): AMenu; stdcall;

{$IFDEF USE_SETTINGS}
function Window_LoadConfig(Window: AWindow; Config: AConfig): ABoolean; stdcall;

function Window_LoadConfig2WS(Window: AWindow; Config: AConfig; const ConfigKey: AWideString): ABoolean; stdcall;
{$ENDIF USE_SETTINGS}

//** Создает новое окно.
function Window_New(): AControl; stdcall;

{$IFDEF USE_SETTINGS}
function Window_SaveConfig(Window: AWindow; Config: AConfig): ABoolean; stdcall;

function Window_SaveConfig2WS(Window: AWindow; Config: AConfig; const ConfigKey: AWideString): ABoolean; stdcall;
{$ENDIF USE_SETTINGS}

//** Задает стиль окантовки окна.
function Window_SetBorderStyle(Window: AWindow; BorderStyle: AInteger): AError; stdcall;

//** Задает стить окантовки окна.
procedure Window_SetBorderStyle02(Window: AWindow; BorderStyle: AInteger); stdcall;

//** Задает стиль окна.
function Window_SetFormStyle(Window: AWindow; FormStyle: AInteger): AError; stdcall;

{** Задает стиль окна }
procedure Window_SetFormStyle02(Window: AWindow; FormStyle: AInteger); stdcall;

//** Задает позицию окна.
function Window_SetPosition(Window: AWindow; Position: AInteger): AError; stdcall;

{ State = TWindowState
  0 - wsNormal
  1 - wsMinimized
  2 - wsMaximized }
function Window_SetState(Window: AWindow; State: AInteger): AError; stdcall;

//** Показывает окно модально.
function Window_ShowModal(Window: AWindow): ABoolean; stdcall;

{ UI }

// Заглушка. Реальная функция находится в .\Modules\AUI.pas.
function UI_Boot(): AError;

{ Testing }

function SetAboutMemoDefaultSize(Width, Height: AInteger): AError; stdcall;

function SetOnAboutClick(Value: AProc): AError; stdcall;

procedure SetOnMainFormCreate(Value: AProc); stdcall;

procedure SetOnMainFormCreate02(Value: AProc02); stdcall;

function SetProgramState(State: AUiProgramState): AError; stdcall;

//** Отображает справочную информацию.
function ShowHelp(): AError; stdcall;

//** Отображает справочную информацию.
procedure ShowHelp02(); stdcall;

//** Отображает справочную информацию.
function ShowHelp2WS(const FileName: AWideString): AError; stdcall;

function Shutdown(): AError; stdcall;

procedure Shutdown02(); stdcall;

{ Protected }

function Done04(): AError; stdcall;

{$IFDEF USE_EVENTS}
//** Присоединяет к событию OnDone.
function OnDone_Connect(Proc: ACallbackProc): AInteger; stdcall;

//** Отсоединяет от события OnDone.
function OnDone_Disconnect(Proc: ACallbackProc): AInteger; stdcall;
{$ENDIF}

function ProcessMessages(): AError; stdcall;

procedure ProcessMessages02(); stdcall;

implementation

(*
uses
  //LResources,
  {$IFDEF UNIX}
    {$IFDEF UseCThreads}
    cthreads,
    {$ENDIF}
  {$ENDIF}
  {$IFDEF FPC}Interfaces,{$ELSE}Mask,{$ENDIF}
  Buttons, Classes, Controls, ComCtrls, Db, DbGrids, ExtCtrls, Forms, Graphics, Grids, Menus, StdCtrls, SysUtils,
  {$IFDEF MSWINDOWS}ShellApi, Windows,{$ENDIF}
  {$IFDEF MSWINDOWS}
  fError, fInputDialog, fLogin, fMessage, fPasswordDialog, fWait,
  {$ENDIF}
  {$IFNDEF FPC}fCalendar, fDateFilter,{$ENDIF}
  {$IFDEF OLDMAINFORM}fMain,{$ENDIF}
  fAbout;
*)

{ Events }

procedure DoMainFormCreate; stdcall;
begin
  AUi_CreateMainForm();
end;

procedure DoShowError(const Caption, UserMessage, ExceptMessage: AWideString); stdcall;
begin
  AUi_ExecuteErrorDialogP(Caption, UserMessage, ExceptMessage);
end;

function DoShowMessage(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;
begin
  Result := AUi_ExecuteMessageDialog1P(Text, Caption, Flags);
end;

{ Module }

function Done: AError; stdcall;
begin
  Result := AUi_Fin();
end;

function Done04(): AError; stdcall;
begin
  Result := Done();
end;

function Init(): AError; stdcall;
begin
  Result := AUi_Init();
end;

function InitMainTrayIcon(): AError; stdcall;
begin
  Result := AUi_InitMainTrayIcon();
end;

function InitMenus: AError; stdcall;
begin
  Result := AUi_InitMenus();
end;

procedure InitMenus02(); stdcall;
begin
  AUi_InitMenus();
end;

{$IFDEF USE_EVENTS}
function OnDone_Connect(Proc: ACallbackProc): AInteger; stdcall;
begin
  Result := AUi_OnDone_Connect(Proc);
end;
{$ENDIF}

{$IFDEF USE_EVENTS}
function OnDone_Disconnect(Proc: ACallbackProc): AInteger; stdcall;
begin
  Result := AUi_OnDone_Disconnect(Proc);
end;
{$ENDIF}

function ProcessMessages(): AError; stdcall;
begin
  Result := AUi_ProcessMessages();
end;

procedure ProcessMessages02(); stdcall;
begin
  AUi_ProcessMessages();
end;

function SetAboutMemoDefaultSize(Width, Height: AInteger): AError;
begin
  UiAboutWinMemoWidthDefault := Width;
  UiAboutWinMemoHeightDefault := Height;
  Result := 0;
end;

function SetOnAboutClick(Value: AProc): AError;
begin
  UiAboutClick := Value;
  Result := 0;
end;

procedure SetOnMainFormCreate(Value: AProc); stdcall;
begin
  AUi_SetOnMainFormCreate(Value);
end;

procedure SetOnMainFormCreate02(Value: AProc02); stdcall;
begin
  {$IFDEF A02}
  FOnMainFormCreate := Value;
  {$ENDIF A02}
end;

function SetProgramState(State: AUiProgramState): AError;
begin
  Result := AUi_SetProgramState(State);
end;

function ShowHelp(): AError; stdcall;
begin
  Result := AUi_ShowHelp();
end;

procedure ShowHelp02(); stdcall;
begin
  AUi_ShowHelp();
end;

function ShowHelp2WS(const FileName: AWideString): AError; stdcall;
begin
  Result := AUi_ShowHelp2WS(FileName);
end;

function Shutdown(): AError; stdcall;
begin
  Result := AUi_Shutdown();
end;

procedure Shutdown02(); stdcall;
begin
  AUi_Shutdown();
end;

{ Box }

function Box_New(Parent: AControl; BoxType: AInteger): AControl; stdcall;
begin
  Result := AUiBox_New(Parent, BoxType);
end;

{ Button }

function Button_New(Parent: AControl): AButton; stdcall;
begin
  Result := AUiButton_New(Parent);
end;

function Button_SetKind(Button: AButton; Kind: TAUIButtonKind): AError; stdcall;
begin
  Result := AUiButton_SetKind(Button, Kind);
end;

{ Calendar }

function Calendar_GetDate(Calendar: AControl): TDateTime; stdcall;
begin
  Result := AUiCalendar_GetDate(Calendar);
end;

function Calendar_New(Parent: AControl): AControl; stdcall;
begin
  Result := AUiCalendar_New(Parent);
end;

function Calendar_SetMonth(Calendar: AControl; Value: AInteger): AError; stdcall;
begin
  Result := AUiCalendar_SetMonth(Calendar, Value);
end;

{ Control }

function Control_Free(Control: AControl): AError; stdcall;
begin
  Result := AUiControl_Free(Control);
end;

function Control_GetColor(Control: AControl): AColor; stdcall;
begin
  Result := AUiControl_GetColor(Control);
end;

function Control_GetEnabled(Control: AControl): ABoolean; stdcall;
begin
  Result := AUiControl_GetEnabled(Control);
end;

function Control_GetHeight(Control: AControl): AInteger; stdcall;
begin
  Result := AUiControl_GetHeight(Control);
end;

function Control_GetHintP(Control: AControl): APascalString; stdcall;
begin
  Result := AUiControl_GetHintP(Control);
end;

function Control_GetHintWS(Control: AControl): AWideString; stdcall;
begin
  Result := AUiControl_GetHintP(Control);
end;

function Control_GetMenu(Control: AControl): AMenu; stdcall;
begin
  Result := AUiControl_GetMenu(Control);
end;

function Control_GetNameP(Control: AControl): APascalString; stdcall;
begin
  Result := AUiControl_GetNameP(Control);
end;

function Control_GetNameWS(Control: AControl): AWideString; stdcall;
begin
  Result := AUiControl_GetNameP(Control);
end;

function Control_GetTextP(Control: AControl): APascalString; stdcall;
begin
  Result := AUiControl_GetTextP(Control);
end;

function Control_GetVisible(Control: AControl): ABoolean; stdcall;
begin
  Result := AUiControl_GetVisible(Control);
end;

function Control_GetWidth(Control: AControl): AInteger; stdcall;
begin
  Result := AUiControl_GetWidth(Control);
end;

function Control_SetAlign(Control: AControl; Align: TUIAlign): AError; stdcall;
begin
  Result := AUiControl_SetAlign(Control, Align);
end;

procedure Control_SetAlign02(Control: AControl; Align: TUIAlign); stdcall;
begin
  AUiControl_SetAlign(Control, Align);
end;

function Control_SetClientSize(Control: AControl; ClientWidth, ClientHeight: AInteger): AError; stdcall;
begin
  Result := AUiControl_SetClientSize(Control, ClientWidth, ClientHeight);
end;

function Control_SetColor(Control: AControl; Color: AColor): AError; stdcall;
begin
  Result := AUiControl_SetColor(Control, Color);
end;

procedure Control_SetColor02(Control: AControl; Color: AColor); stdcall;
begin
  AUiControl_SetColor(Control, Color);
end;

function Control_SetEnabled(Control: AControl; Value: ABoolean): AError; stdcall;
begin
  Result := AUiControl_SetEnabled(Control, Value);
end;

function Control_SetFocus(Control: AControl): ABoolean; stdcall;
begin
  Result := AUiControl_SetFocus(Control);
end;

function Control_SetFont1A(Control: AControl; {const} FontName: AStr; FontSize: AInt): AError;
begin
  Result := AUiControl_SetFont1A(Control, FontName, FontSize);
end;

function Control_SetFont1P(Control: AControl; const FontName: APascalString; FontSize: AInteger): AError; stdcall;
begin
  Result := AUiControl_SetFont1P(Control, FontName, FontSize);
end;

function Control_SetFont2P(Control: AControl; const FontName: APascalString; FontSize: AInteger; FontColor: AColor): AError; stdcall;
begin
  Result := AUiControl_SetFont2P(Control, FontName, FontSize, FontColor);
end;

function Control_SetHeight(Control: AControl; Value: AInteger): AInteger; stdcall;
begin
  Result := AUiControl_SetHeight(Control, Value);
end;

procedure Control_SetHint02(Control: AControl; const Value: APascalString); stdcall;
begin
  AUiControl_SetHintP(Control, Value);
end;

function Control_SetHintP(Control: AControl; const Value: APascalString): AError; stdcall;
begin
  Result := AUiControl_SetHintP(Control, Value);
end;

function Control_SetHintWS(Control: AControl; const Value: AWideString): AError; stdcall;
begin
  Result := AUiControl_SetHintP(Control, Value);
end;

procedure Control_SetName02(Control: AControl; const Value: APascalString); stdcall;
begin
  AUiControl_SetNameP(Control, Value);
end;

function Control_SetNameP(Control: AControl; const Value: APascalString): AError; stdcall;
begin
  Result := AUiControl_SetNameP(Control, Value);
end;

function Control_SetNameWS(Control: AControl; const Value: AWideString): AError; stdcall;
begin
  Result := AUiControl_SetNameP(Control, Value);
end;

function Control_SetOnChange(Control: AControl; OnChange: ACallbackProc): AError; stdcall;
begin
  Result := AUiControl_SetOnChange(Control, OnChange);
end;

procedure Control_SetOnChange02(Control: AControl; OnChange: ACallbackProc02); stdcall;
begin
  AUiControl_SetOnChange02(Control, OnChange);
end;

function Control_SetOnChangeEx(Control: AControl; OnChange: ACallbackProc03; Obj: AInteger): AError; stdcall;
begin
  Result := AUiControl_SetOnChangeEx03(Control, OnChange, Obj);
end;

function Control_SetOnClick(Control: AControl; Value: ACallbackProc): AError; stdcall;
begin
  Result := AUiControl_SetOnClick(Control, Value);
end;

procedure Control_SetOnClick02(Control: AControl; Value: ACallbackProc02); stdcall;
begin
  AUiControl_SetOnClick02(Control, Value);
end;

function Control_SetPosition(Control: AControl; Left, Top: AInteger): AError; stdcall;
begin
  Result := AUiControl_SetPosition(Control, Left, Top);
end;

procedure Control_SetPosition02(Control: AControl; Left, Top: Integer); stdcall;
begin
  AUiControl_SetPosition(Control, Left, Top);
end;

function Control_SetSize(Control: AControl; Width, Height: Integer): AError; stdcall;
begin
  Result := AUiControl_SetSize(Control, Width, Height);
end;

procedure Control_SetSize02(Control: AControl; Width, Height: Integer); stdcall;
begin
  AUiControl_SetSize(Control, Width, Height);
end;

procedure Control_SetText02(Control: AControl; const Value: AWideString); stdcall;
begin
  AUiControl_SetTextP(Control, Value);
end;

function Control_SetTextP(Control: AControl; const Value: APascalString): AError; stdcall;
begin
  Result := AUiControl_SetTextP(Control, Value);
end;

function Control_SetTextWS(Control: AControl; const Value: AWideString): AError; stdcall;
begin
  Result := AUiControl_SetTextP(Control, Value);
end;

function Control_SetVisible(Control: AControl; Value: ABoolean): AError; stdcall;
begin
  Result := AUiControl_SetVisible(Control, Value);
end;

procedure Control_SetVisible02(Control: AControl; Value: ABoolean); stdcall;
begin
  AUiControl_SetVisible(Control, Value);
end;

function Control_SetWidth(Control: AControl; Value: AInteger): AInteger; stdcall;
begin
  Result := AUiControl_SetWidth(Control, Value);
end;

{ DataSource }

function DataSource_New(): PADataSource; stdcall;
begin
  try
    Result := UI_DataSource_New;
  except
    Result := 0;
  end;
end;

procedure DataSource_SetOnDataChange02(DataSource: PADataSource; OnDataChange: ACallbackProc02); stdcall;
var
  I: Integer;
begin
  try
    I := FindDataSource(DataSource);
    if (I >= 0) then
    begin
      FDataSources[I].OnDataChange02 := OnDataChange;
    end;
  except
  end;
end;

{ Dialog }

function Dialog_About: AError; stdcall;
begin
  Result := AUi_ExecuteAboutDialog();
end;

function Dialog_About_New(): AWindow;
begin
  Result := AUi_NewAboutDialog();
end;

function Dialog_About_Init(AboutDialog: AWindow): AError;
begin
  Result := AUi_InitAboutDialog1(AboutDialog);
end;

function Dialog_AddButtonP(Win: AWindow; Left, Width: AInteger; const Text: APascalString;
    OnClick: ACallbackProc): AControl; stdcall;
begin
  Result := AUiDialog_AddButtonP(Win, Left, Width, Text, OnClick);
end;

function Dialog_AddButtonWS(Win: AWindow; Left, Width: AInteger; const Text: AWideString;
    OnClick: ACallbackProc): AControl; stdcall;
begin
  Result := AUiDialog_AddButtonP(Win, Left, Width, Text, OnClick);
end;

function Dialog_Calendar(var Date: TDateTime; CenterX, CenterY: AInteger): ABoolean; stdcall;
begin
  Result := AUi_ExecuteCalendarDialog(Date, CenterX, CenterY);
end;

function Dialog_Color(var Color: AColor): ABoolean; stdcall;
begin
  Result := AUi_ExecuteColorDialog(Color);
end;

function Dialog_DateFilter(var Group: Integer; var DateBegin, DateEnd: TDateTime): Boolean; stdcall;
begin
  Result := AUi_ExecuteDateFilterDialog(Group, DateBegin, DateEnd);
end;

function Dialog_ErrorP(const Caption, UserMessage, ExceptMessage: APascalString): AError; stdcall;
begin
  Result := AUi_ExecuteErrorDialogP(Caption, UserMessage, ExceptMessage);
end;

function Dialog_ErrorWS(const Caption, UserMessage, ExceptMessage: AWideString): AError; stdcall;
begin
  Result := AUi_ExecuteErrorDialogP(Caption, UserMessage, ExceptMessage);
end;

function Dialog_FontP(var FontName: APascalString; var FontSize: AInteger; FontColor: AColor): ABoolean; stdcall;
begin
  Result := AUi_ExecuteFontDialogP(FontName, FontSize, FontColor);
end;

function Dialog_GetWindow(Dialog: ADialog): AWindow; stdcall;
begin
  Result := AUiDialog_GetWindow(Dialog);
end;

function Dialog_InputBox1P(const Text: APascalString; var Value: APascalString): ABoolean; stdcall;
begin
  Result := AUi_ExecuteInputBox1P(Text, Value);
end;

function Dialog_InputBox1WS(const Text: AWideString; var Value: AWideString): ABoolean; stdcall;
var
  S: APascalString;
begin
  try
    S := Value;
    Result := AUi_ExecuteInputBox1P(Text, S);
    Value := S;
  except
    Result := False;
  end;
end;

function Dialog_InputBox2P(const Caption, Text1, Text2: APascalString; var Value1, Value2: APascalString): ABoolean; stdcall;
begin
  Result := AUi_ExecuteInputBox2P(Caption, Text1, Text2, Value1, Value2);
end;

function Dialog_InputBox2WS(const Caption, Text1, Text2: AWideString; var Value1, Value2: AWideString): ABoolean; stdcall;
var
  S1: APascalString;
  S2: APascalString;
begin
  try
    S1 := Value1;
    S2 := Value2;
    Result := AUi_ExecuteInputBox2P(Caption, Text1, Text2, S1, S2);
    Value1 := S1;
    Value2 := S2;
  except
    Result := False;
  end;
end;

function Dialog_InputBox3P(const Caption, Text: APascalString; var Value: APascalString): ABoolean; stdcall;
begin
  Result := AUi_ExecuteInputBox3P(Caption, Text, Value);
end;

function Dialog_InputBox3WS(const Caption, Text: AWideString; var Value: AWideString): ABoolean; stdcall;
var
  S: APascalString;
begin
  try
    S := Value;
    Result := AUi_ExecuteInputBox3P(Caption, Text, S);
    Value := S;
  except
    Result := False;
  end;
end;

function Dialog_LoginP(var UserName, Password: APascalString; IsSave: ABoolean): ABoolean; stdcall;
begin
  Result := AUi_ExecuteLoginDialogP(UserName, Password, IsSave);
end;

function Dialog_LoginWS(var UserName, Password: AWideString; IsSave: ABoolean): ABoolean; stdcall;
var
  UserNameStr: APascalString;
  PasswordStr: APascalString;
begin
  try
    UserNameStr := UserName;
    PasswordStr := Password;
    Result := AUi_ExecuteLoginDialogP(UserNameStr, PasswordStr, IsSave);
    UserName := UserNameStr;
    Password := PasswordStr;
  except
    Result := False;
  end;
end;

function Dialog_MessageDlgWS(const Msg: AWideString; MsgDlgType: AInteger; Flags: AMessageBoxFlags): AInteger; stdcall;
begin
  Result := AUi_ExecuteMessageDialog2P(Msg, MsgDlgType, Flags);
end;

function Dialog_MessageP(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;
begin
  Result := AUi_ExecuteMessageDialog1P(Text, Caption, Flags);
end;

function Dialog_MessageWS(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;
begin
  Result := AUi_ExecuteMessageDialog1P(Text, Caption, Flags);
end;

function Dialog_New(Buttons: AUIWindowButtons): ADialog; stdcall;
begin
  Result := AUi_NewDialog(Buttons);
end;

function Dialog_OpenFileWS(const InitialDir, Filter, Title: AWideString; var FileName: AWideString): ABoolean; stdcall;
var
  S: APascalString;
begin
  try
    S := FileName;
    Result := AUi_ExecuteOpenFileDialogP(InitialDir, Filter, Title, S);
    FileName := S;
  except
    Result := False;
  end;
end;

function Dialog_PrinterSetup(): AError; stdcall;
begin
  Result := AUi_ExecutePrinterSetupDialog();
end;

function Dialog_SelectDirectoryP(var Directory: APascalString): ABoolean; stdcall;
begin
  Result := AUi_ExecuteSelectDirectoryDialogP(Directory);
end;

{ Edit }

function Edit_CheckDate(Edit: AControl{TMaskEdit}; out Value: TDateTime): ABoolean; stdcall;
begin
  Result := (AUiEdit_CheckDate(Edit, Value) = 0);
end;

function Edit_CheckFloat(Edit: AControl; out Value: Double): ABoolean; stdcall;
begin
  Result := (AUiEdit_CheckFloat64(Edit, Value) = 0);
end;

function Edit_CheckFloat32(Edit: AControl; out Value: AFloat32): ABoolean;
begin
  Result := (AUiEdit_CheckFloat32(Edit, Value) = 0);
end;

function Edit_CheckFloat64(Edit: AControl; out Value: AFloat64): ABoolean;
begin
  Result := (AUiEdit_CheckFloat64(Edit, Value) = 0);
end;

function Edit_CheckInt(Edit: AControl; out Value: AInteger): ABoolean; stdcall;
begin
  Result := (AUiEdit_CheckInt(Edit, Value) = 0);
end;

function Edit_New(Parent: AControl): AControl; stdcall;
begin
  Result := AUiEdit_New(Parent);
end;

function Edit_New02(Parent: AControl; EditType: AInteger; OnClick: ACallbackProc02;
    Left, Top, Width: AInteger): AControl; stdcall;
begin
  Result := AUiEdit_New02(Parent, EditType, OnClick, Left, Top, Width);
end;

function Edit_NewA(Parent: AControl; EditType: AInteger; OnClick: ACallbackProc;
    Left, Top, Width: AInteger): AControl; stdcall;
begin
  Result := AUiEdit_NewEx(Parent, EditType, OnClick, Left, Top, Width);
end;

{ Grid }

function Grid_Clear(Grid: AControl): AError; stdcall;
begin
  Result := AUiGrid_Clear(Grid);
end;

function Grid_ClearA(Grid: AControl; FixedRows: AInteger): AError; stdcall;
begin
  Result := AUiGrid_Clear2(Grid, FixedRows);
end;

function Grid_DeleteRow2(Grid: AControl; Row: AInteger): AError; stdcall;
begin
  Result := AUiGrid_DeleteRow2(Grid, Row);
end;

function Grid_FindInt(Grid: AControl; Col, Value: AInteger): AInteger; stdcall;
begin
  Result := AUiGrid_FindInt(Grid, Col, Value);
end;

function Grid_New(Parent: AControl; GridType: AInteger): AControl; stdcall;
begin
  Result := AUiGrid_New(Parent, GridType);
end;

function Grid_RestoreColPropsWS(Grid: AControl; Config: AConfig; const Key: AWideString; Delimer: AWideChar): AError; stdcall;
begin
  Result := AUiGrid_RestoreColPropsWS(Grid, Config, Key, Delimer);
end;

procedure Grid_RestoreColPropsWS02(Grid: AControl; Config: AConfig; const Key: AWideString; Delimer: AWideChar); stdcall;
begin
  AUiGrid_RestoreColPropsWS(Grid, Config, Key, Delimer);
end;

function Grid_RowDelete(Grid: AControl): AError; stdcall;
begin
  Result := AUiGrid_DeleteRow(Grid);
end;

function Grid_RowDown(Grid: AControl): AError; stdcall;
begin
  Result := AUiGrid_RowDown(Grid);
end;

function Grid_RowUp(Grid: AControl): AError; stdcall;
begin
  Result := AUiGrid_RowUp(Grid);
end;

function Grid_SaveColPropsWS(Grid: AControl; Config: AConfig; const Key: AWideString; Delimer: AWideChar): AError; stdcall;
begin
  Result := AUiGrid_SaveColPropsWS(Grid, Config, Key, Delimer);
end;

procedure Grid_SaveColPropsWS02(Grid: AControl; Config: AConfig; const Key: AWideString; Delimer: AWideChar); stdcall;
begin
  AUiGrid_SaveColPropsWS(Grid, Config, Key, Delimer);
end;

function Grid_SetColumnWidth(Grid: AControl; ColumnIndex, Width, Persent, MinWidth: AInteger): AError; stdcall;
begin
  Result := AUiGrid_SetColumnWidth(Grid, ColumnIndex, Width, Persent, MinWidth);
end;

procedure Grid_SetColumnWidth02(Grid: AControl; ColumnIndex, Width, Persent, MinWidth: AInteger); stdcall;
begin
  AUiGrid_SetColumnWidth(Grid, ColumnIndex, Width, Persent, MinWidth);
end;

function Grid_SetColumnWidth2(Grid: AControl; ColumnIndex, Width, Persent, MinWidth, MaxWidth: AInteger): AError; stdcall;
begin
  Result := AUiGrid_SetColumnWidth2(Grid, ColumnIndex, Width, Persent, MinWidth, MaxWidth)
end;

procedure Grid_SetColumnWidthA(Grid: AControl; ColumnIndex, Width, Persent, MinWidth, MaxWidth: AInteger); stdcall;
begin
  AUiGrid_SetColumnWidth2(Grid, ColumnIndex, Width, Persent, MinWidth, MaxWidth);
end;

function Grid_SetDataSource(Grid: AControl; Value: PADataSource): AError; stdcall;
begin
  Result := AUiGrid_SetDataSource(Grid, Value);
end;

procedure Grid_SetDataSource02(Grid: AControl; Value: PADataSource); stdcall;
begin
  AUiGrid_SetDataSource(Grid, Value);
end;

function Grid_SetRowCount(Grid: AControl; Count: AInteger): AError; stdcall;
begin
  Result := AUiGrid_SetRowCount(Grid, Count);
end;

{ Image }

function Image_LoadFromFileWS(Image: AControl; const FileName: AWideString): AError; stdcall;
begin
  Result := AUiImage_LoadFromFileP(Image, FileName);
end;

function Image_New(Parent: AControl): AControl; stdcall;
begin
  Result := AUiImage_New(Parent);
end;

{ Label }

function Label_New(Parent: AControl): AControl; stdcall;
begin
  Result := AUiLabel_New(Parent);
end;

// --- ListBox ---

function ListBox_AddP(ListBox: AControl; const Text: APascalString): AInteger; stdcall;
begin
  Result := AUiListBox_AddP(ListBox, Text);
end;

function ListBox_AddWS(ListBox: AControl; const Text: AWideString): AInteger; stdcall;
begin
  Result := AUiListBox_AddP(ListBox, Text);
end;

function ListBox_New(Parent: AControl): AControl; stdcall;
begin
  Result := AUiListBox_New(Parent);
end;

{ MainToolBar }

function MainToolBar: AControl; stdcall;
begin
  Result := AUi_GetMainToolBar();
end;

procedure MainToolBar_Set(ToolBar: AControl); stdcall;
begin
  AUi_SetMainToolBar(ToolBar);
end;

{ MainWindow }

function MainWindow: AWindow; stdcall;
begin
  Result := AUi_GetMainWindow();
end;

function MainWindow_AddMenuItem(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc; ImageID, Weight: Integer): AMenuItem; stdcall;
begin
  Result := AUiMainWindow_AddMenuItemP(ParentItemName, Name, Text, OnClick, ImageId, Weight);
end;

function MainWindow_AddMenuItem02(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc02; ImageID, Weight: AInteger): AMenuItem; stdcall;
begin
  Result := AUiMainWindow_AddMenuItem02P(ParentItemName, Name, Text, OnClick, ImageId, Weight);
end;

function MainWindow_AddMenuItem03WS(const ParentItemName, Name, Text: AWideString;
    OnClick: ACallbackProc03; ImageId, Weight: AInteger): AMenuItem; stdcall;
begin
  Result := AUiMainWindow_AddMenuItem03P(ParentItemName, Name, Text, OnClick, ImageId, Weight);
end;

function MainWindow_AddMenuItem2(const ParentItemName, Name, Text: AString_Type;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AMenuItem; stdcall;
begin
  Result := AUiMainWindow_AddMenuItem(ParentItemName, Name, Text, OnClick, ImageId, Weight);
end;

function MainWindow_AddMenuItem2WS(const ParentItemName, Name, Text: AWideString;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AMenuItem; stdcall;
begin
  Result := AUiMainWindow_AddMenuItemP(ParentItemName, Name, Text, OnClick, ImageId, Weight);
end;

function MainWindow_AddMenuItem2WS02(const ParentItemName, Name, Text: AWideString;
    OnClick: ACallbackProc02; ImageId, Weight: AInteger): AMenuItem; stdcall;
begin
  Result := AUiMainWindow_AddMenuItem02P(ParentItemName, Name, Text, OnClick, ImageId, Weight);
end;

function MainWindow_GetLeftContainer(): AControl; stdcall;
begin
  Result := AUiMainWindow_GetLeftContainer();
end;

function MainWindow_GetMainContainer(): AControl; stdcall;
begin
  Result := AUiMainWindow_GetMainContainer();
end;

function MainWindow_GetRightContainer(): AControl; stdcall;
begin
  Result := AUiMainWindow_GetRightContainer();
end;

procedure MainWindow_Set(Value: AWindow); stdcall;
begin
  AUi_SetMainWindow(Value);
end;

procedure MainWindow_SetA(Value: AWindow; ToolBar, StatusBar: AControl; Config: AConfig); stdcall;
begin
  AUi_SetMainWindow2(Value, ToolBar, StatusBar, Config);
end;

// --- MenuItem ---

function MenuItem_Clear(MenuItem: AMenuItem): AError; stdcall;
begin
  Result := AUiMenu_Clear(MenuItem);
end;

function MenuItem_FindByName(MenuItem: AMenuItem; const Name: APascalString): AMenuItem; stdcall;
begin
  Result := AUiMenu_FindItemByNameP(MenuItem, Name);
end;

function MenuItem_SetChecked(MenuItem: AMenuItem; Checked: ABoolean): AError; stdcall;
begin
  Result := AUiMenu_SetChecked(MenuItem, Checked);
end;

// --- Menu ---

function Menu_AddItem0(Parent: AMenuItem; MenuItem: AMenuItem; Weight: AInteger): AMenuItem; stdcall;
begin
  Result := AUiMenu_AddItem0(Parent, MenuItem, Weight)
end;

function Menu_AddItem1(Menu: AMenu; const Name, Text: AString_Type;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AMenuItem; stdcall;
begin
  Result := AUiMenu_AddItem1(Menu, Name, Text, OnClick, ImageId, Weight);
end;

function Menu_AddItem1P(Menu: AMenu; const Name, Text: APascalString;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AMenuItem; stdcall;
begin
  Result := AUiMenu_AddItem1P(Menu, Name, Text, OnClick, ImageId, Weight);
end;

function Menu_AddItem2(Parent: AMenuItem; const Name, Text: AString_Type;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AMenuItem; stdcall;
begin
  Result := AUiMenu_AddItem2(Parent, Name, Text, OnClick, ImageId, Weight);
end;

function Menu_AddItem2P(Parent: AMenuItem; const Name, Text: APascalString;
    OnClick: ACallbackProc; ImageID, Weight: Integer): AMenuItem; stdcall;
begin
  Result := AUiMenu_AddItem2P(Parent, Name, Text, OnClick, ImageId, Weight);
end;

function Menu_AddItem2WS(Parent: AMenuItem; const Name, Text: AWideString;
    OnClick: ACallbackProc; ImageId, Weight: Integer): AMenuItem; stdcall;
begin
  Result := AUiMenu_AddItem2WS(Parent, Name, Text, OnClick, ImageId, Weight);
end;

function Menu_AddItem2WS02(Parent: AMenuItem; const Name, Text: AWideString;
    OnClick: ACallbackProc02; ImageID, Weight: Integer): AMenuItem; stdcall;
begin
  Result := AUiMenu_AddItem2WS02(Parent, Name, Text, OnClick, ImageId, Weight);
end;

function Menu_AddItem2WS03(Parent: AMenuItem; const Name, Text: AWideString;
    OnClick: ACallbackProc03; ImageID, Weight: AInteger): AMenuItem; stdcall;
begin
  Result := AUiMenu_AddItem2WS03(Parent, Name, Text, OnClick, ImageId, Weight);
end;

function Menu_AddItem3(Parent: AMenuItem; MenuItem: AMenuItem; Weight: AInteger): AMenuItem; stdcall;
begin
  Result := AUiMenu_AddItem3(Parent, MenuItem, Weight);
end;

function Menu_AddItem3WS(Parent: AMenuItem; const Name, Text: AWideString;
    OnClick: ACallbackProc; ImageID, Weight, Tag: Integer): AMenuItem; stdcall;
begin
  Result := AUiMenu_AddItem3WS(Parent, Name, Text, OnClick, ImageId, Weight, Tag);
end;

function Menu_AddItem3WS03(Parent: AMenuItem; const Name, Text: AWideString;
    OnClick: ACallbackProc03; ImageID, Weight, Tag: Integer): AMenuItem; stdcall;
begin
  Result := AUiMenu_AddItem3WS03(Parent, Name, Text, OnClick, ImageId, Weight, Tag);
end;

function Menu_GetItems(Menu: AMenu): AMenuItem; stdcall;
begin
  Result := AUiMenu_GetItems(Menu);
end;

function Menu_New(MenuType: AInteger): AMenu; stdcall;
begin
  Result := AUiMenu_New(MenuType);
end;

{ PageControl }

function PageControl_AddPage(PageControl: AControl; const Name, Text: APascalString): AControl; stdcall;
begin
  Result := AUiPageControl_AddPageP(PageControl, Name, Text);
end;

function PageControl_AddPageWS(PageControl: AControl; const Name, Text: AWideString): AControl; stdcall;
begin
  Result := AUiPageControl_AddPageP(PageControl, Name, Text);
end;

function PageControl_New(Parent: AControl): AControl; stdcall;
begin
  Result := AUiPageControl_New(Parent);
end;

{ ProgressBar }

function ProgressBar_New(Parent: AControl; Max: AInteger): AControl; stdcall;
begin
  Result := AUiProgressBar_New(Parent, Max);
end;

function ProgressBar_StepIt(ProgressBar: AControl): AInteger; stdcall;
begin
  Result := AUiProgressBar_StepIt(ProgressBar);
end;

{ Report }

function Report_New(Parent: AControl): AReport; stdcall;
begin
  Result := AUiReport_New(Parent);
end;

{ ReportWin }

function ReportWin_New(): AWindow; stdcall;
begin
  Result := AUiReportWin_New();
end;

function ReportWin_New2P(ReportWinType: AInteger; const Text: APascalString): AWindow; stdcall;
begin
  Result := AUiReportWin_New2P(ReportWinType, Text);
end;

function ReportWin_New2WS(ReportWinType: AInteger; const Text: AWideString): AWindow; stdcall;
begin
  Result := AUiReportWin_New2P(ReportWinType, Text);
end;

function ReportWin_NewWS(ReportWinType: AInteger; const Text: AWideString): AWindow; stdcall;
begin
  Result := AUiReportWin_New2P(ReportWinType, Text);
end;

function ReportWin_ShowReportP(const Text: APascalString; Font: AFont): AError; stdcall;
begin
  Result := AUiReportWin_ShowReportP(Text, Font);
end;

{ TextView }

function TextView_AddLineWS(TextView: AControl; const Text: AWideString): AInteger; stdcall;
begin
  Result := AUiTextView_AddLineP(TextView, Text);
end;

function TextView_New(Parent: AControl; ViewType: AInteger): AControl; stdcall;
begin
  Result := AUiTextView_New(Parent, ViewType);
end;

function TextView_SetReadOnly(TextView: AControl; ReadOnly: ABoolean): AError; stdcall;
begin
  Result := AUiTextView_SetReadOnly(TextView, ReadOnly);
end;

procedure TextView_SetReadOnly02(TextView: AControl; ReadOnly: ABoolean); stdcall;
begin
  AUiTextView_SetReadOnly(TextView, ReadOnly);
end;

function TextView_SetScrollBars(TextView: AControl; ScrollBars: AInteger): AError; stdcall;
begin
  Result := AUiTextView_SetScrollBars(TextView, ScrollBars);
end;

procedure TextView_SetScrollBars02(TextView: AControl; ScrollBars: AInteger); stdcall;
begin
  AUiTextView_SetScrollBars(TextView, ScrollBars);
end;

function TextView_SetWordWrap(TextView: AControl; Value: ABoolean): AError; stdcall;
begin
  Result := AUiTextView_SetWordWrap(TextView, Value);
end;

procedure TextView_SetWordWrap02(TextView: AControl; Value: ABoolean); stdcall;
begin
  AUiTextView_SetWordWrap(TextView, Value);
end;

{ ToolBar }

function ToolBar_AddButtonWS(ToolBar: AControl; const Name, Text, Hint: AWideString;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AButton; stdcall;
begin
  Result := AUiToolBar_AddButtonP(ToolBar, Name, Text, Hint, OnClick, ImageId, Weight);
end;

function ToolBar_AddButtonWS02(ToolBar: AControl; const Name, Text, Hint: AWideString;
    OnClick: ACallbackProc02; ImageId, Weight: AInteger): AButton; stdcall;
begin
  try
    Result := AUIToolBar.UI_ToolBar_AddButton02(ToolBar, Name, Text, Hint, OnClick, ImageId, Weight);
  except
    Result := 0;
  end;
end;

function ToolBar_AddButtonWS03(ToolBar: AControl; const Name, Text, Hint: AWideString;
    OnClick: ACallbackProc03; ImageId, Weight: AInteger): AButton; stdcall;
begin
  try
    Result := AUIToolBar.UI_ToolBar_AddButton03(ToolBar, Name, Text, Hint, OnClick, ImageId, Weight);
  except
    Result := 0;
  end;
end;

function ToolBar_New(Parent: AControl): AControl; stdcall;
begin
  Result := AUiToolBar_New(Parent);
end;

// --- ToolMenu ---

function ToolMenu_AddButtonWS(ToolMenu: AToolMenu; const Name, Text, Hint: AWideString;
    OnClick: ACallbackProc03; ImageId, Weight: AInteger): AButton; stdcall;
begin
  Result := AUiToolBar_AddButtonP(ToolMenu, Name, Text, Hint, OnClick, ImageId, Weight);
end;

function ToolMenu_AddNewItemWS(Parent: AToolMenu; const Name, Text: AWideString;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AToolMenu; stdcall;
begin
  Result := AUiToolMenu_AddNewItemP(Parent, Name, Text, OnClick, ImageId, Weight);
end;

function ToolMenu_AddNewSubMenu(Parent: AToolMenu; const Name, Text: AString_Type;
    ImageId, Weight: AInteger): AToolMenu; stdcall;
begin
  Result := AUiToolMenu_AddNewSubMenu(Parent, Name, Text, ImageId, Weight);
end;

function ToolMenu_AddNewSubMenuWS(Parent: AToolMenu; const Name, Text: AWideString;
    ImageId, Weight: AInteger): AToolMenu; stdcall;
begin
  Result := AUiToolMenu_AddNewSubMenuP(Parent, Name, Text, ImageId, Weight);
end;

function ToolMenu_GetSubMenuWS(Parent: AToolMenu; const Name, Text: AWideString;
    ImageId, Weight: AInteger): AToolMenu; stdcall;
begin
  Result := AUiToolMenu_GetSubMenuP(Parent, Name, Text, ImageId, Weight);
end;

function ToolMenu_New(Parent: AControl): AToolMenu; stdcall;
begin
  Result := AUiToolMenu_New(Parent);
end;

{ TreeView }

function TreeView_AddItemWS(TreeView: AControl; Parent: ATreeNode; Text: AWideString): ATreeNode; stdcall;
begin
  try
    Result := AUiTreeView_AddItemP(TreeView, Parent, Text);
  except
    Result := 0;
  end;
end;

function TreeView_New(Parent: AControl): AControl; stdcall;
begin
  try
    Result := AUiTreeView_New(Parent);
  except
    Result := 0;
  end;
end;

{ Splitter }

function Splitter_New(Parent: AControl; SplitterType: AUISplitterType): AControl; stdcall;
begin
  Result := AUiSplitter_New(Parent, SplitterType);
end;

{ UI Public }

function UI_Boot(): AError;
begin
  Result := 0;
end;

{ WaitWin }

function WaitWin_NewWS(const Caption, Text: AWideString; MaxPosition: Integer): AWindow; stdcall;
begin
  Result := AUiWaitWin_NewP(Caption, Text, MaxPosition);
end;

function WaitWin_SetMaxPosition(WaitWin: AWindow; MaxPosition: AInteger): AError; stdcall;
begin
  Result := AUiWaitWin_SetMaxPosition(WaitWin, MaxPosition);
end;

function WaitWin_SetPosition(WaitWin: AWindow; Position: AInteger): AError; stdcall;
begin
  Result := AUiWaitWin_SetPosition(WaitWin, Position);
end;

function WaitWin_SetTextWS(Window: AWindow; const Text: AWideString): AError; stdcall;
begin
  Result := AUiWaitWin_SetTextP(Window, Text);
end;

function WaitWin_StepBy(Window: AWindow; Step: AInteger): AInteger; stdcall;
begin
  Result := AUiWaitWin_StepBy(Window, Step);
end;

{ Window }

function Window_Add(Window: AWindow): AError; stdcall;
begin
  Result := AUiWindow_Add(Window);
end;

procedure Window_Free(Window: AWindow); stdcall;
begin
  AUiWindow_Free(Window);
end;

function Window_GetMenu(Window: AWindow): AMenu; stdcall;
begin
  Result := AUiWindow_GetMenu(Window);
end;

{$IFDEF USE_SETTINGS}
function Window_LoadConfig(Window: AWindow; Config: AConfig): ABoolean; stdcall;
begin
  Result := (AUiWindow_LoadConfig(Window, Config) = 0);
end;
{$ENDIF}

{$IFDEF USE_SETTINGS}
function Window_LoadConfig2WS(Window: AWindow; Config: AConfig; const ConfigKey: AWideString): ABoolean; stdcall;
begin
  Result := (AUiWindow_LoadConfig2P(Window, Config, ConfigKey) = 0);
end;
{$ENDIF}

function Window_New(): AControl; stdcall;
begin
  Result := AUiWindow_New();
end;

{$IFDEF USE_SETTINGS}
function Window_SaveConfig(Window: AWindow; Config: AConfig): ABoolean; stdcall;
begin
  Result := (AUiWindow_SaveConfig(Window, Config) = 0);
end;
{$ENDIF}

{$IFDEF USE_SETTINGS}
function Window_SaveConfig2WS(Window: AWindow; Config: AConfig; const ConfigKey: AWideString): ABoolean; stdcall;
begin
  Result := (AUiWindow_SaveConfig2P(Window, Config, ConfigKey) = 0);
end;
{$ENDIF}

function Window_SetBorderStyle(Window: AWindow; BorderStyle: AInteger): AError; stdcall;
begin
  Result := AUiWindow_SetBorderStyle(Window, BorderStyle);
end;

procedure Window_SetBorderStyle02(Window: AWindow; BorderStyle: AInteger); stdcall;
begin
  AUiWindow_SetBorderStyle(Window, BorderStyle);
end;

function Window_SetFormStyle(Window: AWindow; FormStyle: AInteger): AError; stdcall;
begin
  Result := AUiWindow_SetFormStyle(Window, FormStyle);
end;

procedure Window_SetFormStyle02(Window: AWindow; FormStyle: AInteger);
begin
  AUiWindow_SetFormStyle(Window, FormStyle);
end;

function Window_SetPosition(Window: AWindow; Position: AInteger): AError; stdcall;
begin
  Result := AUiWindow_SetPosition(Window, Position);
end;

procedure Window_SetPosition02(Window: AWindow; Position: AInt);
begin
  AUiWindow_SetPosition(Window, Position);
end;

function Window_SetState(Window: AWindow; State: AInteger): AError; stdcall;
begin
  Result := AUiWindow_SetState(Window, State);
end;

function Window_ShowModal(Window: AWindow): ABoolean; stdcall;
begin
  Result := AUiWindow_ShowModal(Window);
end;

end.
