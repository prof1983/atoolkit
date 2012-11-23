{**
@Abstract Главная форма для проектирования
@Author Prof1983 <prof1983@ya.ru>
@Created 08.11.2006
@LastMod 13.11.2012
}
unit fDeveloper;

interface

uses
  Classes, ComCtrls, Controls, ExtCtrls, Forms, Menus, ValEdit,
  ABase, ANodeIntf, fAbout1, AShablonForm{fShablon};

type
  //** @abstract(Тип вкладки главной области)
  TabMainTypeEnum = Integer;

const
  tmNone    = $00000000;
  tmMemo    = $00000001;
  tmUncnown = $00008000;

type
  //** @abstract(Тип вкладки панели сообщений)
  TabMessageTypeEnum = Integer;

const
  tmsgNone     = $00000000;
  tmsgMessages = $00000001;
  tmsgLog      = $00000002;
  tmsgCommands = $00000004;
  tmsgTasks    = $00000008;
  tmsgUncnown  = $00008000;

type
  //** @abstract(Тип вкладки дерева объектов)
  TabTreeViewTypeEnum = Integer;

const
  ttvNone     = $00000000;
  ttvUncnown  = $00008000;

type
  //** @abstract(Тип вкладки списка свойств объекта)
  TabValueListTypeEnum = Integer;

const
  tvlNone     = $00000000;
  tvlUncnown  = $00008000;

type
  //** @abstract(Форма дизайнера с панелями и линейками)
  TfmDeveloper = class(TfmShablon)
  protected
    miHelp: TMenuItem;
    miHelpAbout: TMenuItem;
    miHelpHelp: TMenuItem;
    mmMain: TMainMenu;
    pbH1: TProgressBar;

    pnButtons: TPanel;
    pnMain: TPanel;
    pnMessages: TPanel;
    pnObjects: TPanel;
    pnTool: TPanel;

    sbMain: TStatusBar;

    spButtons: TSplitterControl;
    spMessages: TSplitterControl;
    spObjects: TSplitterControl;
    spTool: TSplitterControl;
    procedure miHelpAboutClick(Sender: TObject);
  protected
    //** Срабатывает при создании
    procedure DoCreate(); override;
    //** Срабытывает при уничтожении
    procedure DoDestroy(); override;
    //** Срабатывает при добавлении сообщения
    function DoMessage(const AMsg: WideString): Integer; override;
    //** Срабатывает при создании вкладки в главной области окна
    function DoTabMainAdd(ATabType: TabMainTypeEnum; const ACaption: WideString): TWinControl; virtual;
    //** Срабатывает при создании вкладки в области сообщений
    function DoTabMessageAdd(ATabType: TabMessageTypeEnum; const ACaption: WideString): TWinControl; virtual;
    //** Срабатывает при создании вкладки в области дерева объектов
    function DoTabTreeViewAdd(ATabType: TabTreeViewTypeEnum; const ACaption: WideString): TWinControl; virtual;
    //** Срабатывает при создании вкладки в области свойств
    function DoTabValueListAdd(ATabType: TabValueListTypeEnum; const ACaption: WideString): TWinControl; virtual;
  public
    //** Загрузить конфигурации
    function ConfigureLoad(AConfig: IProfNode = nil): AError; override;
    //** Сохранить конфигурации
    function ConfigureSave(AConfig: IProfNode = nil): AError; override;
  end;

type
  //** @abstract(Форма дизайнера с деревом и свойствами объектов)
  TfmDeveloperA = class(TfmDeveloper)
  protected
    spObjectsH: TSplitter;
    tvObjects: TTreeView;
    vleObjects: TValueListEditor;
  protected
    //** Срабатывает при создании
    procedure DoCreate(); override;
    //** Срабытывает при уничтожении
    procedure DoDestroy(); override;
    //** Срабатывает при создании вкладки в области свойств
    function DoTabValueListAdd(ATabType: TabValueListTypeEnum; const ACaption: WideString): TWinControl; override;
  public
    //** Загрузить конфигурации
    function ConfigureLoad(AConfig: IProfNode = nil): AError; override;
    //** Сохранить конфигурации
    function ConfigureSave(AConfig: IProfNode = nil): AError; override;
  end;

type
  //** @abstract(Форма дизайнера с вкладками)
  TfmDeveloperB = class(TfmDeveloperA)
  protected
    pcMain: TPageControl;
    //function GetSelectedMainTabSheet(): TTabSheet;
  protected
    //** Срабатывает при создании
    procedure DoCreate(); override;
    //** Срабатывает при создании вкладки в главной области окна
    function DoTabMainAdd(ATabType: TabMainTypeEnum; const ACaption: WideString): TWinControl; override;
  public
    // Текущая страница в центральной части формы
    //property SelectedMainTabSheet: TTabSheet read GetSelectedMainTabSheet;
  end;

type
  //** @abstract(Форма дизайнера с заполненым главным меню)
  TfmDeveloperC = class(TfmDeveloperB)
  protected
    miRun: TMenuItem;
    miRunRun: TMenuItem;
    miView: TMenuItem;
    miViewRefresh: TMenuItem;
  protected
    //** Срабатывает при создании
    procedure DoCreate(); override;
  end;

type
  //** @abstract(Форма дизайнера с панелью логирования, сообщений, команд)
  TfmDeveloperD = class(TfmDeveloperC)
  protected
    pcMessages: TPageControl;
    tsCommands: TTabSheet;
    tsLogs: TTabSheet;
    tsMessages: TTabSheet;
  protected
    //** Срабатывает при создании
    procedure DoCreate(); override;
    //** Срабатывает при создании вкладки в области сообщений
    function DoTabMessageAdd(ATabType: TabMessageTypeEnum; const ACaption: WideString): TWinControl; override;
  public
  end;

implementation

{ TfmDeveloper }

function TfmDeveloper.ConfigureLoad(AConfig: IProfNode): AError;
var
  tmpConfig: IProfNode;
  i: Integer;
begin
  if (inherited ConfigureLoad(AConfig) < 0) then
  begin
    Result := -1;
    Exit;
  end;
  if Assigned(AConfig) then
    tmpConfig := AConfig
  else
    tmpConfig := FConfig;

  {if TProfXmlNode.ReadIntegerA(tmpConfig, 'ObjectsWidth', i) then
    if i > 0 then
      pnObjects.Width := i
    else
      pnObjects.Visible := False;
  if TProfXmlNode.ReadIntegerA(tmpConfig, 'ToolWidth', i) then
    if i > 0 then
      pnTool.Width := i
    else
      pnTool.Visible := False;
  if TProfXmlNode.ReadIntegerA(tmpConfig, 'ButtonsHeight', i) then
    if i > 0 then
      pnButtons.Height := i
    else
      pnButtons.Visible := False;
  if TProfXmlNode.ReadIntegerA(tmpConfig, 'MessagesHeight', i) then
    if i > 0 then
      pnMessages.Height := i
    else
      pnMessages.Visible := False;}
end;

function TfmDeveloper.ConfigureSave(AConfig: IProfNode): AError;
var
  tmpConfig: IProfNode;
begin
  if (inherited ConfigureSave(AConfig) < 0) then
  begin
    Result := -1;
    Exit;
  end;
  if Assigned(AConfig) then
    tmpConfig := AConfig
  else
    tmpConfig := FConfig;

  {TProfXmlNode.WriteIntegerA(tmpConfig, 'ObjectsWidth', pnObjects.Width);
  TProfXmlNode.WriteIntegerA(tmpConfig, 'ToolWidth', pnTool.Width);
  TProfXmlNode.WriteIntegerA(tmpConfig, 'ButtonsHeight', pnButtons.Height);
  TProfXmlNode.WriteIntegerA(tmpConfig, 'MessagesHeight', pnMessages.Height);}
end;

procedure TfmDeveloper.DoCreate();
begin
  inherited DoCreate();

  Caption := 'Developer';
  Self.Left := 0;
  Self.Top := 0;
  Self.Height := 420;
  Self.Width := 640;

  pnButtons := TPanel.Create(Self);
  pnButtons.Parent := Self;
  pnButtons.Height := 30;
  pnButtons.Align := alTop;

  spButtons := TSplitterControl.Create(Self);
  spButtons.Control := pnButtons;
  spButtons.Parent := Self;
  spButtons.Align := alTop;

  pnMessages := TPanel.Create(Self);
  pnMessages.Parent := Self;
  pnMessages.Height := 70;
  pnMessages.Align := alBottom;

  spMessages := TSplitterControl.Create(Self);
  spMessages.Control := pnMessages;
  spMessages.Parent := Self;
  spMessages.Align := alBottom;

  pnObjects := TPanel.Create(Self);
  pnObjects.Parent := Self;
  pnObjects.Width := 100;
  pnObjects.Align := alLeft;

  spObjects := TSplitterControl.Create(Self);
  spObjects.Control := pnObjects;
  spObjects.Parent := Self;
  spObjects.Left := pnObjects.Width + 10;
  spObjects.Align := alLeft;

  pnTool := TPanel.Create(Self);
  pnTool.Parent := Self;
  pnTool.Width := 100;
  pnTool.Align := alRight;

  spTool := TSplitterControl.Create(Self);
  spTool.Control := pnTool;
  spTool.Parent := Self;
  spTool.Align := alRight;

  pnMain := TPanel.Create(Self);
  pnMain.Parent := Self;
  pnMain.Align := alClient;

  pbH1 := TProgressBar.Create(pnMain);
  pbH1.Parent := pnMain;
  pbH1.Align := alBottom;
  pbH1.Height := 6;
  pbH1.Smooth := True;
  pbH1.Max := 255;

  sbMain := TStatusBar.Create(Self);
  sbMain.Top := 2000;
  sbMain.Align := alBottom;

  mmMain := TMainMenu.Create(Self);
  Self.Menu := mmMain;

  miHelp := TMenuItem.Create(Self);
  miHelp.Caption := '?';
  mmMain.Items.Add(miHelp);

  miHelpHelp := TMenuItem.Create(Self);
  miHelpHelp.Caption := 'Помощь'; //'Help';
  miHelp.Add(miHelpHelp);

  miHelpAbout := TMenuItem.Create(Self);
  miHelpAbout.Caption := 'О программе...'; //'About';
  miHelp.Add(miHelpAbout);
  miHelpAbout.OnClick := miHelpAboutClick;
end;

procedure TfmDeveloper.DoDestroy();
begin
  // ...
  inherited DoDestroy();
end;

function TfmDeveloper.DoMessage(const AMsg: WideString): Integer;
begin
  // TODO: Сделать
end;

function TfmDeveloper.DoTabMainAdd(ATabType: TabMainTypeEnum; const ACaption: WideString): TWinControl;
begin
  Result := nil;
  // ...
end;

function TfmDeveloper.DoTabMessageAdd(ATabType: TabMessageTypeEnum; const ACaption: WideString): TWinControl;
begin
  Result := nil;
  // ...
end;

function TfmDeveloper.DoTabTreeViewAdd(ATabType: TabTreeViewTypeEnum; const ACaption: WideString): TWinControl;
begin
  Result := nil;
  // ...
end;

function TfmDeveloper.DoTabValueListAdd(ATabType: TabValueListTypeEnum; const ACaption: WideString): TWinControl;
begin
  Result := nil;
  // ...
end;

procedure TfmDeveloper.miHelpAboutClick(Sender: TObject);
var
  fm: TAboutForm;
begin
  fm := TAboutForm.Create(Self);
  try
    fm.Picture.Assign(Application.Icon);
    fm.ShowModal();
  finally
    fm.Free();
  end;
end;

{ TfmDeveloperA }

function TfmDeveloperA.ConfigureLoad(AConfig: IProfNode): AError;
var
  i: Integer;
  tmpConfig: IProfNode;
begin
  if (inherited ConfigureLoad(AConfig) < 0) then
  begin
    Result := -1;
    Exit;
  end;
  if Assigned(AConfig) then
    tmpConfig := AConfig
  else
    tmpConfig := FConfig;

  {if TProfXmlNode.ReadIntegerA(tmpConfig, 'ObjectTreeViewHeight', i) then tvObjects.Height := i;
  if TProfXmlNode.ReadIntegerA(tmpConfig, 'ObjectPropertyCol0Width', i) then vleObjects.ColWidths[0] := i;}
end;

function TfmDeveloperA.ConfigureSave(AConfig: IProfNode): AError;
var
  tmpConfig: IProfNode;
begin
  if (inherited ConfigureSave(AConfig) < 0) then
  begin
    Result := -1;
    Exit;
  end;
  if Assigned(AConfig) then
    tmpConfig := AConfig
  else
    tmpConfig := FConfig;

  {TProfXmlNode.WriteIntegerA(tmpConfig, 'ObjectTreeViewHeight', tvObjects.Height);
  TProfXmlNode.WriteIntegerA(tmpConfig, 'ObjectPropertyCol0Width', vleObjects.ColWidths[0]);}
end;

procedure TfmDeveloperA.DoCreate();
begin
  inherited DoCreate();

  tvObjects := TTreeView.Create(pnObjects);
  tvObjects.Parent := pnObjects;
  tvObjects.Height := pnObjects.Height div 2;
  tvObjects.Align := alTop;

  spObjectsH := TSplitter.Create(Self);
  spObjectsH.Parent := pnObjects;
  spObjectsH.Align := alTop;

  vleObjects := TValueListEditor.Create(pnObjects);
  vleObjects.Parent := pnObjects;
  vleObjects.Align := alClient;
end;

procedure TfmDeveloperA.DoDestroy();
begin
  // ...
  inherited DoDestroy();
end;

function TfmDeveloperA.DoTabValueListAdd(ATabType: TabValueListTypeEnum; const ACaption: WideString): TWinControl;
begin
  Result := nil;
  // ...
end;

{ TfmDeveloperB }

procedure TfmDeveloperB.DoCreate;
begin
  inherited DoCreate();

//  tcMain := TTabControl.Create(pnMain);
//  tcMain.Parent := pnMain;
//  tcMain.Align := alClient;

  pcMain := TPageControl.Create(pnMain);
  pcMain.Parent := pnMain;
  pcMain.Align := alClient;
end;

function TfmDeveloperB.DoTabMainAdd(ATabType: TabMainTypeEnum; const ACaption: WideString): TWinControl;
begin
  Result := TTabSheet.Create(Self);
  TTabSheet(Result).PageControl := pcMain;
  TTabSheet(Result).Caption := ACaption;
end;

{function TfmDeveloperB.GetSelectedMainTabSheet(): TTabSheet;
begin
  Result := Self.pcMain.ActivePage;
end;}

{ TfmDeveloperC }

procedure TfmDeveloperC.DoCreate();
begin
  inherited DoCreate();

  // Создаем меню -------------------------
  miView := TMenuItem.Create(Self);
  miView.Caption := 'Вид'; //'View';

  miViewRefresh := TMenuItem.Create(Self);
  miViewRefresh.Caption := 'Обновить'; //'Refresh';
  miView.Add(miViewRefresh);

  mmMain.Items.Insert(0, miView);

  miRun := TMenuItem.Create(Self);
  miRun.Caption := 'Выполнить'; //'Run';
  mmMain.Items.Insert(1, miRun);

  {miRunRun := TMenuItem.Create(Self);
  miRunRun.Caption := 'Run';
  miRun.Add(miRunRun);}
end;

{ TfmDeveloperD }

procedure TfmDeveloperD.DoCreate();
begin
  inherited DoCreate();

  pcMessages := TPageControl.Create(Self);
  pcMessages.Parent := pnMessages;
  pcMessages.Align := alClient;
  pcMessages.TabPosition := tpBottom;

  tsMessages := TTabSheet.Create(Self);
  tsMessages.PageControl := pcMessages;
  tsMessages.Caption := 'Сообщения'; //'Messages';

  tsLogs := TTabSheet.Create(Self);
  tsLogs.PageControl := pcMessages;
  tsLogs.Caption := 'Логи'; //'Logs';

  tsCommands := TTabSheet.Create(Self);
  tsCommands.PageControl := pcMessages;
  tsCommands.Caption := 'Команды'; //'Commands';
end;

function TfmDeveloperD.DoTabMessageAdd(ATabType: TabMessageTypeEnum; const ACaption: WideString): TWinControl;
begin
  Result := TTabSheet.Create(Self);
  TTabSheet(Result).PageControl := pcMessages;
  TTabSheet(Result).Caption := ACaption;
end;

end.
