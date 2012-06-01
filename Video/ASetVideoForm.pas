{**
@Abstract(Настройка видео)
@Author(Prof1983 prof1983@ya.ru)
@Created(05.04.2006)
@LastMod(05.05.2012)
@Version(0.5)
}
unit ASetVideoForm;

interface

uses
  Classes, ComCtrls, Controls, Forms,
  ASetInspectorFrame, ASetShablonForm, ASetVideoCaptureFrame, ASetVideoChanelFrame,
  ASetVideoClientFrame, ASetVideoImportFrame, AVideoGlobals;

type
  TfmSetVideo = class(TfmSetShablon)
  private
    frCapture: TfrSetVideoCapture;
    frChanel: TfrSetVideoChanel;
    frClient: TfrSetVideoClient;
    frImport: TfrSetVideoImport;
    frInspector: TfrSetInspector;
    FVideo: TVideoSources;
    procedure SetVideo(Value: TVideoSources);
  protected
    procedure DoCreate(); override;
    function DoSave(): WordBool; override;
  public
    constructor Create(AOwner: TComponent); override;
      //** Объект работы с видеоисточниками (должен задаваться сразу после создания)
    property Video: TVideoSources write SetVideo;
  end;

implementation

{ TfmSetVideo }

constructor TfmSetVideo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TfmSetVideo.DoCreate();
var
  tn: TTreeNode;
  tnChanels: TTreeNode;
  tnSources: TTreeNode;
begin
  Caption := 'Настройка видеозахвата';

  // Видео
  tn := tvSettingMain.Items.AddChild(nil, 'Видео');
  try
    frImport := TfrSetVideoImport.Create(Self);
    frImport.Parent := Self;
    frImport.Align := alClient;
    frImport.Visible := True;
    AddItem(tn, frImport);
  except
  end;

  // Видео.Источники
  tnSources := tvSettingMain.Items.AddChild(tn, 'Источники');
  AddItem(tnSources, nil);

  // Видео.Источники.Capture
  try
    frCapture := TfrSetVideoCapture.Create(Self);
    frCapture.Parent := Self;
    frCapture.Align := alClient;
    frCapture.Visible := False;
    AddItem(tvSettingMain.Items.AddChild(tnSources, 'Capture'), frCapture);
  except
  end;

  // Видео.Источники.Инспектор+
  try
    frInspector := TfrSetInspector.Create(Self);
    frInspector.Init();
    frInspector.Parent := Self;
    frInspector.Align := alClient;
    frInspector.Visible := False;
    AddItem(tvSettingMain.Items.AddChild(tnSources, 'Инспектор'), frInspector);
  except
  end;

  try
    frClient := TfrSetVideoClient.Create(Self);
    frClient.Init();
    frClient.Parent := Self;
    frClient.Align := alClient;
    frClient.Visible := False;
    frClient.Video_Enabled := False;
    AddItem(tvSettingMain.Items.AddChild(tnSources, 'Видеосервер'), frClient);
  except
  end;

  // Видео.Каналы
  try
    frChanel := TfrSetVideoChanel.Create(Self);
    frChanel.Parent := Self;
    frChanel.Align := alClient;
    frChanel.Visible := False;
    tnChanels := tvSettingMain.Items.AddChild(tn, 'Каналы');
    AddItem(tnChanels, frChanel);
  except
  end;
  inherited DoCreate();
end;

function TfmSetVideo.DoSave(): WordBool;
begin
  inherited DoSave();
  if Assigned(frCapture) then
  begin
    //frCapture.Save();
    // ...
  end;
  if Assigned(frChanel) then frChanel.Save();
  if Assigned(frClient) then
  begin
    //Settings.VideoClient_Enabled := frClient.Video_Enabled;
    //frClient.Save();
  end;
  if Assigned(frImport) then frImport.Save();
  if Assigned(frInspector) then frInspector.Save();
  //Result := Settings.SaveParams();
  Result := False;
  // ...
end;

procedure TfmSetVideo.SetVideo(Value: TVideoSources);
begin
  FVideo := Value;
  frChanel.Video := Value;
end;

end.
