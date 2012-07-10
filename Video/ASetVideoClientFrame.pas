{**
@Abstract(Настройка подключения к видеосерверу)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.04.2006)
@LastMod(10.07.2012)
@Version(0.5)
}
unit ASetVideoClientFrame;

interface

uses
  Classes, Controls, Dialogs, Forms, Graphics, Messages, StdCtrls, SysUtils, Windows,
  AUiSpin;

type
  TfrSetVideoClient = class(TFrame)
    ckbEnabled: TCheckBox;
    lbHost: TLabel;
    edHost: TEdit;
    lbPort: TLabel;
  private
    function GetVideo_Enabled(): Boolean;
    procedure SetVideo_Enabled(Value: Boolean);
  public
    edPort: TSpinEdit;
  public
    procedure Init();
  public
    property Video_Enabled: Boolean read GetVideo_Enabled write SetVideo_Enabled;
    //property Video_Host: string read GetVideo_Host write SetVideo_Host;
    //property Video_Port: Integer read GetVideo_Port write SetVideo_Port;
  end;

implementation

{$R *.DFM}

{ TfrSetVideoClient }

function TfrSetVideoClient.GetVideo_Enabled(): Boolean;
begin
  Result := ckbEnabled.Checked;
end;

procedure TfrSetVideoClient.Init;
begin
  edPort := TSpinEdit.Create(Self);
  edPort.Parent := Self;
  edPort.Left := 48;
  edPort.Top := 64;
  edPort.Width := 121;
  edPort.Height := 22;
  edPort.MaxValue := 0;
  edPort.MinValue := 0;
  edPort.TabOrder := 2;
  edPort.Value := 3000;
end;

procedure TfrSetVideoClient.SetVideo_Enabled(Value: Boolean);
begin
  ckbEnabled.Checked := Value;
end;

end.
