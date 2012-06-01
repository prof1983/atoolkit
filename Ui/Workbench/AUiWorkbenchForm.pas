{**
@Abstract(Workbench form)
@Author(Prof1983 prof1983@ya.ru)
@Created(21.08.2007)
@LastMod(05.05.2012)
@Version(0.5)
}
unit AUiWorkbenchForm;

interface

uses
  ActnCtrls, ActnList, ActnMan, ActnMenus, Classes, ComCtrls, Controls, Dialogs,
  ExtCtrls, Forms, Graphics, Messages, SysUtils, ToolWin, Variants,
  Windows, XPStyleActnCtrls,
  AModuleInformationIntf, ARuntimeObj;

type
  TWorkbenchForm = class(TForm)
    MainPanel: TPanel;
    BottomToolPanel: TPanel;
    StatusBar1: TStatusBar;
    LeftToolPanel: TPanel;
    RightToolPanel: TPanel;
    BottomSplitter: TSplitter;
    LeftSplitter: TSplitter;
    RightSplitter: TSplitter;
    ActionManager1: TActionManager;
    ActionMainMenuBar1: TActionMainMenuBar;
    PersonageImage: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    BottomPageControl: TPageControl;
    LogTabSheet: TTabSheet;
    LogListView: TListView;
    LeftPageControl: TPageControl;
    AgentTabSheet: TTabSheet;
    AgentTreeView: TTreeView;
    ModulesTabSheet: TTabSheet;
    ModulesTreeView: TTreeView;
    RightPageControl: TPageControl;
    TasksTabSheet: TTabSheet;
    TasksTreeView: TTreeView;
  protected
    procedure DoCreate(); override;
  public
    procedure Refresh();
  end;

implementation

{$R *.dfm}

{ TWorkbenchForm }

procedure TWorkbenchForm.DoCreate();
var
  runtime: TARuntimeObject;
  FileName: string;
begin
  inherited DoCreate();

  FileName := ExtractFilePath(ParamStr(0)) + 'assistant.bmp';
  if FileExists(FileName) then
  try
    PersonageImage.Picture.LoadFromFile(FileName);
  except
  end;

  BottomPageControl := TPageControl.Create(Self);
  BottomPageControl.Parent := BottomToolPanel;
  BottomPageControl.Align := alClient;

  LogTabSheet := TTabSheet.Create(Self);
  LogTabSheet.Parent := BottomPageControl;
  LogTabSheet.PageControl := BottomPageControl;
  LogTabSheet.Caption := 'Logs';

  LogListView := TListView.Create(Self);
  LogListView.Parent := LogTabSheet;
  LogListView.Align := alClient;


  LeftPageControl := TPageControl.Create(Self);
  LeftPageControl.Parent := LeftToolPanel;
  LeftPageControl.Align := alClient;

  AgentTabSheet := TTabSheet.Create(Self);
  AgentTabSheet.Parent := LeftPageControl;
  AgentTabSheet.PageControl := LeftPageControl;
  AgentTabSheet.Caption := 'Агенты';

  AgentTreeView := TTreeView.Create(Self);
  AgentTreeView.Parent := AgentTabSheet;
  AgentTreeView.Align := alClient;

  ModulesTabSheet := TTabSheet.Create(Self);
  ModulesTabSheet.Parent := LeftPageControl;
  ModulesTabSheet.PageControl := LeftPageControl;
  ModulesTabSheet.Caption := 'Модули';

  ModulesTreeView := TTreeView.Create(Self);
  ModulesTreeView.Parent := ModulesTabSheet;
  ModulesTreeView.Align := alClient;


  RightPageControl := TPageControl.Create(Self);
  RightPageControl.Parent := RightToolPanel;
  RightPageControl.Align := alClient;

  TasksTabSheet := TTabSheet.Create(Self);
  TasksTabSheet.Parent := RightPageControl;
  TasksTabSheet.PageControl := RightPageControl;
  TasksTabSheet.Caption := 'Задачи';

  TasksTreeView := TTreeView.Create(Self);
  TasksTreeView.Parent := TasksTabSheet;
  TasksTreeView.Align := alClient;

  runtime := TARuntimeObject.GetInstance();
  if Assigned(runtime) then
  begin
    //variablesModule := IAssistantVariablesModule(runtime.Modules.ModuleByID['mas.platform.core.runtime.variables']);
  end;
end;

procedure TWorkbenchForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  runtime: TARuntimeObject;
begin
  runtime := TARuntimeObject.GetInstance();
  if not(Assigned(runtime)) then Exit;
  runtime.RunExitCommand();
end;

procedure TWorkbenchForm.Refresh();
var
  runtime: TARuntimeObject;
  c: Integer;
  i: Integer;
  mi: IModuleInformation;
  //m: IModule;
begin
  runtime := TARuntimeObject.GetInstance();
  if Assigned(runtime) then
  begin
    // RefreshModulesView
    ModulesTreeView.Items.Clear();
    c := runtime.Modules.ModuleCount;
    for i := 0 to c - 1 do
    begin
      mi := runtime.Modules.ModuleInformationByIndex[i];
      if Assigned(mi) then
        ModulesTreeView.Items.Add(nil, mi.ID);
    end;

    //RefreshAgentsView
    AgentTreeView.Items.Clear();
    c := runtime.Modules.ModuleCount;
    for i := 0 to c - 1 do
    begin
      //if (runtime.Modules.IsAgentByIndex(i)) then
      begin
        {m := runtime.Modules.ModuleByIndex[i];
        if Assigned(m) and (m is IAgent) then
        begin
          mi := m.Information;
          if Assigned(mi) then
            AgentTreeView.Items.Add(nil, mi.Name);
        end;}
      end;
    end;
  end;
end;

end.
