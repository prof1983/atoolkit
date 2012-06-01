{**
@Abstract(MailAgent - StartModule)
@Author(Prof1983 prof1983@ya.ru)
@Created(02.09.2007)
@LastMod(30.05.2012)
@Version(0.5)
}
unit AUiSplashModule;

interface

uses
  ExtCtrls, Forms, SysUtils,
  ABase, AModuleIntf, AMessageIntf, AAbstractModuleInformation, AModuleInformationIntf, ANode1,
  AUiSplashForm;

type
  TProcedure = procedure of object;

type
  TStartModule = class(TInterfacedObject, IProfModule)
  private
    FOnStart: TProcedure;
    FPlatformStarted: Boolean;
    FStartForm: TStartForm;
    FStartTime: TDateTime;
    FTimer: TTimer;
    procedure DoTimer(Sender: TObject);
  protected
    FInformation: TAbstractModuleInformation;
    FLocalID: Integer;
    FLocalName: WideString;
  protected // IModule
    function GetInformation(): IModuleInformation;
    function GetLocalID(): Integer;
    function GetLocalName(): WideString;
  public // IModule
    function Initialize(): AError;
    function Finalize(): AError;
    function Start(): Integer;
    function Stop(): Integer;
    function Pause(): Integer;
    procedure ProcessCommand(Sender, Receiver, Command: Integer; Params: INode);
      // Обработать сообщение
    function PushMessage(Msg: ISimpleMessage): Integer;
  public
    constructor Create();
    procedure Hide();
  public
    // Информация о модуле
    property Information: IModuleInformation read GetInformation;
    property OnStart: TProcedure read FOnStart write FOnStart;
    property PlatformStarted: Boolean read FPlatformStarted write FPlatformStarted;
    // Локальный идентификатор
    property LocalID: Integer read GetLocalID;
    // Локальное имя
    property LocalName: WideString read GetLocalName;
    property StartForm: TStartForm read FStartForm;
  end;

const // Команды
  Start_WaitCommand = 1;

implementation

{ TStartModule }

constructor TStartModule.Create();
begin
  FLocalName := 'Start';

  FInformation := TAbstractModuleInformation.Create();
  FInformation.ID := 'mas.platform.start';
  FInformation.Name := 'Start';
  FInformation.Description := '';
  FInformation.Author := '';
  FInformation.Copyright := '';
  FInformation.Version := 3;
  FInformation.VersionString := '0.0.0.3';
  FInformation.OtherInformation := '';

  inherited Create();
end;

procedure TStartModule.DoTimer(Sender: TObject);
begin
  FTimer.Enabled := False;
  FTimer.Free();
  FTimer := nil;

  Start();

  Hide();
end;

function TStartModule.Finalize(): AError;
begin
  Result := 0;
end;

function TStartModule.GetInformation(): IModuleInformation;
begin
  Result := FInformation;
end;

function TStartModule.GetLocalID: Integer;
begin
  Result := FLocalID;
end;

function TStartModule.GetLocalName: WideString;
begin
  Result := FLocalName;
end;

procedure TStartModule.Hide();
begin
  while (Now() - FStartTime < 1/24/60/60) do
  begin
    Application.ProcessMessages();
    Sleep(50);
  end;

  //FStartForm.AddToLog('test');
  FStartForm.Visible := False;
end;

function TStartModule.Initialize(): AError;
begin
  Application.CreateForm(TStartForm, FStartForm);
  if Assigned(FStartForm) then
    FStartTime := Now();

  // Создаем и запускаем таймер для запуска системы.
  // Таймер необходим, т.к. нужно дать возможность отобразить стартовое окно.
  FTimer := TTimer.Create(FStartForm);
  FTimer.Interval := 100;
  FTimer.OnTimer := DoTimer;
  FTimer.Enabled := True;

  Result := 0;
end;

function TStartModule.Pause: Integer;
begin
  Result := 0;
end;

procedure TStartModule.ProcessCommand(Sender, Receiver, Command: Integer; Params: INode);
begin
  // TODO: TStartModule.ProcessCommand
  // ...
end;

function TStartModule.PushMessage(Msg: ISimpleMessage): Integer;
begin
  Result := -1;
end;

function TStartModule.Start(): Integer;
begin
  if Assigned(FOnStart) then
    FOnStart();
  Result := 0;
end;

function TStartModule.Stop(): Integer;
begin
  Result := 0;
end;

end.
