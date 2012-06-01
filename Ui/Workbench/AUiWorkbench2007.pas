{**
@Abstract(AUiWorkbench)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.08.2007)
@LastMod(25.05.2012)
@Version(0.5)
}
unit AUiWorkbench2007;

interface

uses
  ABase, AModuleImpl, AAbstractModuleInformation, ANode1,
  AUiWorkbenchForm;

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
  FLocalName := 'Workbench';

  FInformation := TAbstractModuleInformation.Create();
  FInformation.ID := 'ui.workbench';
  FInformation.Name := 'Workbench';
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
begin
  FWorkbenchForm := TWorkbenchForm.Create(nil);
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
