{**
@Abstract(Фреймовая форма настроек видеозахвата Inspector+)
@Author(Prof1983 prof1983@ya.ru)
@Created(28.09.2005)
@LastMod(05.05.2012)
@Version(0.5)
}
unit ASetInspectorFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, RxSpin, IniFiles,
  AConfig2007;

type
  TfrSetInspector = class(TFrame)
    lbChanelNumber: TLabel;
    EditPath: TEdit;
    lbChanelPicture: TLabel;
    lbCameraNum: TLabel;
    lbPicturePath: TLabel;
    EditIp: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lbIntervalPicture: TLabel;
    lbIntervalNumber: TLabel;
    ckbUse: TCheckBox;
    procedure ckbUseClick(Sender: TObject);
  public
    SpinEditNumberSourceId: TRxSpinEdit;
    SpinEditScreenShotSourceId: TRxSpinEdit;
    SpinEditScreenShotCamId: TRxSpinEdit;
    SpinEditId: TRxSpinEdit;
    SpinEditPort: TRxSpinEdit;
    SpinEditTimeScreenShot: TRxSpinEdit;
    SpinEditTimeTakeNumber: TRxSpinEdit;
  public
    function ConfigureLoadFrom(Config: TConfigNode1): Boolean;
    function ConfigureSaveTo(Config: TConfigNode1): Boolean;
    constructor Create(AOwner: TComponent); override;
    procedure Init();
    function GetNumberSourceId: Integer;
    function GetScreenShotCamId: Integer;
    function GetScreenShotSourceId: Integer;
    function GetScreenShotPath: string;
    function Save(): Boolean;
  end;

implementation

{$R *.DFM}

// Functions -------------------------------------------------------------------

function cFloat32ToInt32(Value: Real): Integer;
begin
  Result := Round(Value);
end;

function cFloat64ToInt32(F: Double): Integer;
begin
  Result := Round(F);
end;

{ TfrSetInspector }

procedure TfrSetInspector.ckbUseClick(Sender: TObject);
var
  Value: Boolean;
begin
  Value := ckbUse.Checked;
  EditIp.Enabled := Value;
  Label6.Enabled := Value;
  SpinEditId.Enabled := Value;
  Label7.Enabled := Value;
  SpinEditPort.Enabled := Value;
  Label8.Enabled := Value;
  SpinEditNumberSourceId.Enabled := Value;
  SpinEditScreenShotSourceId.Enabled := Value;
  lbChanelNumber.Enabled := Value;
  SpinEditScreenShotCamId.Enabled := Value;
  lbChanelPicture.Enabled := Value;
  lbCameraNum.Enabled := Value;
  EditPath.Enabled := Value;
  SpinEditTimeScreenShot.Enabled := Value;
  lbIntervalPicture.Enabled := Value;
  SpinEditTimeTakeNumber.Enabled := Value;
  lbIntervalNumber.Enabled := Value;
end;

function TfrSetInspector.ConfigureLoadFrom(Config: TConfigNode1): Boolean;
var
  I: Integer;
  S: WideString;
begin
  //AddToLog(lgNone, ltNone, 'Do: TFrameGetNumberSettings.ConfigureLoad', []);
  Result := True;
  if not(Assigned(Config)) then Exit;
  if Config.ReadInt32('NumberSourceId', I) then SpinEditNumberSourceId.Value := I;
  if Config.ReadInt32('ScreenShotCamId', I) then SpinEditScreenShotCamId.Value := I;
  if Config.ReadInt32('ScreenShotSourceId', I) then SpinEditScreenShotSourceId.Value := I;
  if Config.ReadString('Path', S) then EditPath.Text := S;
  if Config.ReadInt32('TimeScreenShot', I) then SpinEditTimeScreenShot.Value := I;
  if Config.ReadInt32('TimeTakeNumber', I) then SpinEditTimeTakeNumber.Value := I;

  if Config.ReadString('Ip', S) then EditIp.Text := S;
  if Config.ReadInt32('Id', I) then SpinEditId.Value := I;
  if Config.ReadInt32('Port', I) then SpinEditPort.Value := I;

  {if FConfig.NodeExist('SourceId') then SpinEditNumberSourceId.Value := FConfig.FindNode('SourceId').NodeValue;
  if FConfig.NodeExist('ShotCamId') then SpinEditScreenShotCamId.Value := FConfig.FindNode('ShotCamId').NodeValue;
  if FConfig.NodeExist('ShotSourceId') then SpinEditScreenShotSourceId.Value := FConfig.FindNode('ShotSourceId').NodeValue;
  if FConfig.NodeExist('Path') then EditPath.Text := FConfig.FindNode('Path').NodeValue;
  if FConfig.NodeExist('TimeScreenShot') then SpinEditTimeScreenShot.Value := FConfig.FindNode('TimeScreenShot').NodeValue;
  if FConfig.NodeExist('TimeTakeNumber') then SpinEditTimeTakeNumber.Value := FConfig.FindNode('TimeTakeNumber').NodeValue;
  if FConfig.NodeExist('Ip') then EditIp.Text := FConfig.FindNode('Ip').NodeValue;
  if FConfig.NodeExist('Id') then SpinEditId.Value := FConfig.FindNode('Id').NodeValue;
  if FConfig.NodeExist('Port') then SpinEditPort.Value := FConfig.FindNode('Port').NodeValue;}
end;

function TfrSetInspector.ConfigureSaveTo(Config: TConfigNode1): Boolean;
begin
  Result := False;
  //AddToLog(lgNone, ltNone, 'Do: TFrameGetNumberSettings.ConfigureSave', []);

  if not(Assigned(Config)) then begin
    //AddToLog(lgNone, ltError, 'TFrameGetNumberSettings.ConfigureSave: Config = nil', []);
    Exit;
  end;

  Config.WriteInt32('NumberSourceId', cFloat32ToInt32(SpinEditNumberSourceId.Value));
  Config.WriteInt32('ScreenShotCamId', cFloat32ToInt32(SpinEditScreenShotCamId.Value));
  Config.WriteInt32('ScreenShotSourceId', cFloat32ToInt32(SpinEditScreenShotSourceId.Value));
  Config.WriteString('Path', EditPath.Text);
  Config.WriteInt32('TimeScreenShot', cFloat32ToInt32(SpinEditTimeScreenShot.Value));
  Config.WriteInt32('TimeTakeNumber', cFloat32ToInt32(SpinEditTimeTakeNumber.Value));

  Config.WriteString('Ip', EditIp.Text);
  Config.WriteInt32('Id', cFloat32ToInt32(SpinEditId.Value));
  Config.WriteInt32('Port', cFloat32ToInt32(SpinEditPort.Value));

  {FConfig.GetNodeByName('NumberSourceId').NodeValue := cFloat32ToInt32(SpinEditNumberSourceId.Value);
  FConfig.GetNodeByName('ScreenShotCamId').NodeValue := cFloat32ToInt32(SpinEditScreenShotCamId.Value);
  FConfig.GetNodeByName('ScreenShotSourceId').NodeValue := cFloat32ToInt32(SpinEditScreenShotSourceId.Value);
  FConfig.GetNodeByName('Path').NodeValue := EditPath.Text;
  FConfig.GetNodeByName('TimeScreenShot').NodeValue := cFloat32ToInt32(SpinEditTimeScreenShot.Value);
  FConfig.GetNodeByName('TimeTakeNumber').NodeValue := cFloat32ToInt32(SpinEditTimeTakeNumber.Value);

  FConfig.GetNodeByName('Ip').NodeValue := EditIp.Text;
  FConfig.GetNodeByName('Id').NodeValue := cFloat32ToInt32(SpinEditId.Value);
  FConfig.GetNodeByName('Port').NodeValue := cFloat32ToInt32(SpinEditPort.Value);}
end;

constructor TfrSetInspector.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ckbUse.Caption := 'Использовать Инспектор+';
  lbChanelNumber.Caption := 'Канал получения номера';
  lbChanelPicture.Caption := 'Канал получения картинки';
  lbCameraNum.Caption := 'Номер камеры';
  lbPicturePath.Caption := 'Путь расположения картинок';
  lbIntervalPicture.Caption := 'Интервал между обновлениями картинок';
  lbIntervalNumber.Caption := 'Интервал запроса номера';
end;

function TfrSetInspector.GetNumberSourceId: Integer;
begin
  Result := Round(SpinEditNumberSourceId.Value);
end;

function TfrSetInspector.GetScreenShotCamId: Integer;
begin
  Result := Round(SpinEditScreenShotCamId.Value);
end;

function TfrSetInspector.GetScreenShotPath: String;
begin
  Result := EditPath.Text;
end;

function TfrSetInspector.GetScreenShotSourceId: Integer;
begin
  Result := Round(SpinEditScreenShotSourceId.Value);
end;

procedure TfrSetInspector.Init();
begin
  inherited;

  SpinEditNumberSourceId := TRxSpinEdit.Create(Self);
  SpinEditNumberSourceId.Parent := Self;
  SpinEditNumberSourceId.Left := 8;
  SpinEditNumberSourceId.Top := 114;
  SpinEditNumberSourceId.Width := 49;
  SpinEditNumberSourceId.Height := 21;
  SpinEditNumberSourceId.Value := 1.0;
  SpinEditNumberSourceId.Enabled := False;
  SpinEditNumberSourceId.TabOrder := 0;

  SpinEditScreenShotSourceId := TRxSpinEdit.Create(Self);
  SpinEditScreenShotSourceId.Parent := Self;
  SpinEditScreenShotSourceId.Left := 8;
  SpinEditScreenShotSourceId.Top := 136;
  SpinEditScreenShotSourceId.Width := 49;
  SpinEditScreenShotSourceId.Height := 21;
  SpinEditScreenShotSourceId.Value := 1.0;
  SpinEditScreenShotSourceId.Enabled := False;
  SpinEditScreenShotSourceId.TabOrder := 1;

  SpinEditScreenShotCamId := TRxSpinEdit.Create(Self);
  SpinEditScreenShotCamId.Parent := Self;
  SpinEditScreenShotCamId.Left := 8;
  SpinEditScreenShotCamId.Top := 160;
  SpinEditScreenShotCamId.Width := 49;
  SpinEditScreenShotCamId.Height := 21;
  SpinEditScreenShotCamId.Value := 1.0;
  SpinEditScreenShotCamId.Enabled := False;
  SpinEditScreenShotCamId.TabOrder := 2;

  SpinEditId := TRxSpinEdit.Create(Self);
  SpinEditId.Parent := Self;
  SpinEditId.Left := 8;
  SpinEditId.Top := 56;
  SpinEditId.Width := 57;
  SpinEditId.Height := 21;
  SpinEditId.Value := 2.0;
  SpinEditId.Enabled := False;
  SpinEditId.TabOrder := 4;

  SpinEditPort := TRxSpinEdit.Create(Self);
  SpinEditPort.Parent := Self;
  SpinEditPort.Left := 8;
  SpinEditPort.Top := 80;
  SpinEditPort.Width := 57;
  SpinEditPort.Height := 21;
  SpinEditPort.Value := 1030.0;
  SpinEditPort.Enabled := False;
  SpinEditPort.TabOrder := 5;

  SpinEditTimeScreenShot := TRxSpinEdit.Create(Self);
  SpinEditTimeScreenShot.Parent := Self;
  SpinEditTimeScreenShot.Left := 8;
  SpinEditTimeScreenShot.Top := 224;
  SpinEditTimeScreenShot.Width := 57;
  SpinEditTimeScreenShot.Height := 21;
  SpinEditTimeScreenShot.Value := 300.0;
  SpinEditTimeScreenShot.Enabled := False;
  SpinEditTimeScreenShot.TabOrder := 7;

  SpinEditTimeTakeNumber := TRxSpinEdit.Create(Self);
  SpinEditTimeTakeNumber.Parent := Self;
  SpinEditTimeTakeNumber.Left := 8;
  SpinEditTimeTakeNumber.Top := 248;
  SpinEditTimeTakeNumber.Width := 57;
  SpinEditTimeTakeNumber.Height := 21;
  SpinEditTimeTakeNumber.Value := 300.0;
  SpinEditTimeTakeNumber.Enabled := False;
  SpinEditTimeTakeNumber.TabOrder := 8;
end;

function TfrSetInspector.Save(): Boolean;
begin
  Result := False;
end;

end.
