{**
@Abstract(Настройка работы с видео)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.04.2006)
@LastMod(10.07.2012)
@Version(0.5)
}
unit ASetVideoImportFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls,
  AUiSpin;

type
  TfrSetVideoImport = class(TFrame)
    ckbSaveImage: TCheckBox;
    procedure FormCreate(Sender: TObject);
  private
    function GetIsSaveImage(): Boolean;
    procedure SetIsSaveImage(Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    property IsSaveImage: Boolean read GetIsSaveImage write SetIsSaveImage;
    procedure Save(); //override;
  end;

implementation

{$R *.DFM}

{ TfrSetVideo }

constructor TfrSetVideoImport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TfrSetVideoImport.Save();
begin
  //Settings.SaveImage := ckbSaveImage.Checked;
  //Settings.SaveParams();
end;

procedure TfrSetVideoImport.FormCreate(Sender: TObject);
begin
  {ckbSaveImage.Checked := Settings.SaveImage;
  // Приборы.Видеонаблюдение
  try
    //SaveImage.DataField := cSetting_SaveImage;
    //IsVideo.DataField := cSetting_IsVideo;
    //VideoDeviceEdit.DataField := cSetting_VideoDeviceIndex;
    //VideoFreqEdit.DataField := cSetting_VideoFreq;
  except
  end;}
end;

function TfrSetVideoImport.GetIsSaveImage(): Boolean;
begin
  Result := ckbSaveImage.Checked;
end;

procedure TfrSetVideoImport.SetIsSaveImage(Value: Boolean);
begin
  ckbSaveImage.Checked := Value;
end;

end.
 