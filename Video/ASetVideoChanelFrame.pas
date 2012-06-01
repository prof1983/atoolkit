{**
@Abstract(Настройка работы с видео)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.04.2006)
@LastMod(05.05.2012)
@Version(0.5)
}
unit ASetVideoChanelFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,
  AVideoGlobals;

type
  TfrSetVideoChanel = class(TFrame)
    ckbSave: TCheckBox;
    ckbEnabled: TCheckBox;
    lbSource: TLabel;
    cbSource: TComboBox;
    Label2: TLabel;
    cbChanel: TComboBox;
    lbNumCamera: TLabel;
    btAddChanel: TButton;
    procedure cbChanelChange(Sender: TObject);
    procedure btAddChanelClick(Sender: TObject);
  private
    edNumCamera: TSpinEdit;
    FLastItemIndex: Integer;
    FVideo: TVideoSources;
    function GetSourceIndex(): Integer;
    procedure SetVideo(Value: TVideoSources);
    procedure SaveChanel();
  public
    constructor Create(AOwner: TComponent); override;
    procedure Refresh();
    function Save(): Boolean;
    property SourceIndex: Integer read GetSourceIndex;
    property Video: TVideoSources write SetVideo;
  end;

implementation

{$R *.DFM}

{ TfrVideoChanelSetting }

procedure TfrSetVideoChanel.btAddChanelClick(Sender: TObject);
var
  Chanel: TVideoChanel; //TSetupVideoChanel;
begin
  //Chanel := (Settings.VideoChanels.Add() as TSetupVideoChanel);
  Chanel := FVideo.NewChanel();
  Refresh();
  cbChanel.ItemIndex := Chanel.Index;
  cbChanelChange(Self);
  //cbChanel.ItemIndex :=
end;

procedure TfrSetVideoChanel.cbChanelChange(Sender: TObject);
var
  Chanel: TVideoChanel; //TSetupVideoChanel;
begin
  SaveChanel();
  try
    //Chanel := (Settings.VideoChanels.ItemsByIndex[cbChanel.ItemIndex] as TSetupVideoChanel);
    Chanel := FVideo.Chanels[cbChanel.ItemIndex];
    if Assigned(Chanel) then
    begin
      ckbEnabled.Checked := Chanel.Enabled;
      edNumCamera.Value := Chanel.NumCamera;
      ckbSave.Checked := Chanel.Save;
      cbSource.ItemIndex := Chanel.Source_Index;
    end;
  except
  end;

  FLastItemIndex := cbChanel.ItemIndex;
end;

constructor TfrSetVideoChanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  edNumCamera := TSpinEdit.Create(Self);
  edNumCamera.Parent := Self;
  edNumCamera.Left := 60;
  edNumCamera.Top := 130;

  Refresh();
  FLastItemIndex := -1;
  cbChanel.ItemIndex := -1;
  //cbChanelChange(Self);
end;

function TfrSetVideoChanel.GetSourceIndex(): Integer;
begin
  Result := cbSource.ItemIndex;
end;

procedure TfrSetVideoChanel.Refresh();
var
  I: Integer;
begin
  cbChanel.Clear();
  if not(Assigned(FVideo)) then Exit;
  
              // Settings.VideoChanels.Count
  for I := 0 to FVideo.ChanelCount - 1 do
    cbChanel.Items.Add('Канал ' + IntToStr(I));
  //cbChanel.ItemIndex := 0;
  //FLastItemIndex := 0;
end;

function TfrSetVideoChanel.Save(): Boolean;
begin
  cbChanelChange(Self);
  // Сохранение в настройках
  //Result := Settings.SaveParams();
end;

procedure TfrSetVideoChanel.SaveChanel();
var
  Chanel: TVideoChanel; //TSetupVideoChanel;
begin
  if FLastItemIndex >= 0 then
  begin
    //Chanel := (Settings.VideoChanels.ItemsByIndex[FLastItemIndex] as TSetupVideoChanel);
    Chanel := FVideo.Chanels[FLastItemIndex];
    Chanel.Enabled := ckbEnabled.Checked;
    Chanel.NumCamera := edNumCamera.Value;
    Chanel.Save := ckbSave.Checked;
    Chanel.Source_Index := cbSource.ItemIndex;
  end;
end;

procedure TfrSetVideoChanel.SetVideo(Value: TVideoSources);
var
  Count: Integer;
  I: Integer;
begin
  cbSource.Clear();
  if not(Assigned(Value)) then Exit;
  Count := Value.SourceCount;
  for I := 0 to Count - 1 do
  begin
    cbSource.Items.Add(Value.Sources[I].Name);
  end;
end;

end.
