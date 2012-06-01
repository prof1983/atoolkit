{**
@Abstract(Настройка видеозахвата)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.04.2006)
@LastMod(05.05.2012)
@Version(0.5)
}
unit ASetVideoCaptureFrame;

interface

uses
  DbCtrls, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Spin, StdCtrls, Mask;

type
  TfrSetVideoCapture = class(TFrame)
    lbVideoDevice: TLabel;
    lbVideoFreq: TLabel;
    lbQualty: TLabel;
    cbIsVideo: TCheckBox;
    edVideoDevice: TEdit;
    edVideoFreq: TEdit;
  private
    edJpegQualty: TSpinEdit;
    function GetJpegQuality(): Integer;
    function GetVideoDeviceIndex(): Integer;
    function GetVideoEnabled(): Boolean;
    function GetVideoFreq(): Integer;
    procedure SetJpegQuality(Value: Integer);
    procedure SetVideoDeviceIndex(Value: Integer);
    procedure SetVideoEnabled(Value: Boolean);
    procedure SetVideoFreq(Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    //procedure Save();
  published
    property JpegQuality: Integer read GetJpegQuality write SetJpegQuality;
    property VideoDeviceIndex: Integer read GetVideoDeviceIndex write SetVideoDeviceIndex;
    property VideoEnabled: Boolean read GetVideoEnabled write SetVideoEnabled;
    property VideoFreq: Integer read GetVideoFreq write SetVideoFreq;
  end;

implementation

{$R *.DFM}

{ TfrSetVideoCapture }

constructor TfrSetVideoCapture.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  edJpegQualty := TSpinEdit.Create(Self);
  edJpegQualty.Parent := Self;
  edJpegQualty.Left := 264;
  edJpegQualty.Top := 120;

  cbIsVideo.Caption := 'Использовать видеокамеру';
  lbVideoDevice.Caption := 'Номер карты видеозахвата';
  lbVideoFreq.Caption := 'Частота обновления видео (м.сек / кадр)';
  lbQualty.Caption := 'Качество сохраняемого изображения';

  {cbIsVideo.Checked := Settings.IsVideo;
  edVideoDevice.Text := IntToStr(Settings.VideoDeviceIndex);
  edVideoFreq.Text := IntToStr(Settings.VideoFreq);
  edJpegQualty.Value := RegSet.JpegQualty;}
end;

function TfrSetVideoCapture.GetJpegQuality(): Integer;
begin
  Result := edJpegQualty.Value;
end;

function TfrSetVideoCapture.GetVideoDeviceIndex(): Integer;
begin
  Result := StrToInt(edVideoDevice.Text);
end;

function TfrSetVideoCapture.GetVideoEnabled(): Boolean;
begin
  Result := cbIsVideo.Checked;
end;

function TfrSetVideoCapture.GetVideoFreq(): Integer;
begin
  Result := StrToInt(edVideoFreq.Text);
end;

procedure TfrSetVideoCapture.SetJpegQuality(Value: Integer);
begin
  edJpegQualty.Value := Value;
end;

procedure TfrSetVideoCapture.SetVideoDeviceIndex(Value: Integer);
begin
  edVideoDevice.Text := IntToStr(Value);
end;

procedure TfrSetVideoCapture.SetVideoEnabled(Value: Boolean);
begin
  cbIsVideo.Checked := Value;
end;

procedure TfrSetVideoCapture.SetVideoFreq(Value: Integer);
begin
  edVideoFreq.Text := IntToStr(Value);
end;

{procedure TfrSetVideoCapture.Save();
begin
  Settings.IsVideo := cbIsVideo.Checked;
  Settings.VideoDeviceIndex := StrToInt(edVideoDevice.Text);
  Settings.VideoFreq := StrToInt(edVideoFreq.Text);
  RegSet.JpegQualty := edJpegQualty.Value;
end;}

end.
