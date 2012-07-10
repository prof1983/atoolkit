{**
@Abstract(AUiWorkbench)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.08.2007)
@LastMod(10.07.2012)
@Version(0.5)
}
unit AUiWorkbench2007;

interface

uses
  Forms, SysUtils,
  ABase, AModuleImpl, AAbstractModuleInformation, ANode1,
  AUiWorkbenchForm;

const
  AUiWorkbench_Name = 'Workbench';
  AUiWorkbench_SId = 'ui.workbench';

type
  TMasWorkbench = class(TAbstractModule)
  private
    FWorkbenchForm: TWorkbenchForm;
  public
    function Initialize(): AError; override;
    function Finalize(): AError; override;
    function Start(): Integer; override;
    function Stop(): Integer; override;
    procedure ProcessCommand(Sender, Receiver, Command: Integer; Params: INode);
  public
    constructor Create();
  end;

implementation

{ TMasWorkbench }

constructor TMasWorkbench.Create();
begin
  FLocalName := AUiWorkbench_Name;

  FInformation := TAbstractModuleInformation.Create();
  FInformation.ID := AUiWorkbench_SId;
  FInformation.Name := AUiWorkbench_Name;
  FInformation.Description := 'Модуль главного окна программы';
  FInformation.Author := '';
  FInformation.Copyright := '';
  FInformation.Version := 3;
  FInformation.VersionString := '0.5';

  inherited Create();
end;

function TMasWorkbench.Finalize(): AError;
begin
  FWorkbenchForm.Free();
  FWorkbenchForm := nil;
  Result := 0;
end;

function TMasWorkbench.Initialize(): AError;
var
  ExePath: APascalString;
  ResourcePath: APascalString;
begin
  //Application.CreateForm(TWorkbenchForm, FWorkbenchForm);
  FWorkbenchForm := TWorkbenchForm.Create(nil);
  ExePath := ExtractFilePath(ParamStr(0));
  ResourcePath := ExpandFileName(ExePath + '..\Resources\');
  FWorkbenchForm.SetPersonageFileName(ResourcePath + 'Assistant-64x64.bmp');
  FWorkbenchForm.Init();
  Result := 0;
end;

procedure TMasWorkbench.ProcessCommand(Sender, Receiver, Command: Integer; Params: INode);
begin
  // ...
end;

function TMasWorkbench.Start(): Integer;
begin
  FWorkbenchForm.Show();
  FWorkbenchForm.Refresh();
  Result := 0;
end;

function TMasWorkbench.Stop(): Integer;
begin
  FWorkbenchForm.Hide();
  Result := 0;
end;

end.
