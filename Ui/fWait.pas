{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(02.10.2008)
@LastMod(08.09.2011)
@Version(0.5)
}
unit fWait;

interface

uses
  {$IFDEF FPC}LResources,{$ENDIF}
  Classes, ComCtrls, Controls, ExtCtrls, Forms, Graphics, Messages, StdCtrls, SysUtils;

type
  TWaitForm = class(TForm)
    lblText: TLabel;
    ProgressBar: TProgressBar;
  public
    procedure Init(const Caption, Text: string; MaxPosition: Integer = 0);
    procedure Step();
  end;

implementation

{$IFNDEF FPC}
  {$R *.DFM}
{$ENDIF}

{ TWaitForm }

procedure TWaitForm.Init(const Caption, Text: string; MaxPosition: Integer = 0);
begin
  Self.Caption := Caption;
  Self.lblText.Caption := Text;
  ProgressBar.Position := 0;
  if (MaxPosition <= 0) then
    ProgressBar.Visible := False
  else //if (MaxPosition > 0) then
    ProgressBar.Max := MaxPosition;
end;

procedure TWaitForm.Step();
begin
  ProgressBar.StepIt();
  Application.ProcessMessages();
end;

initialization
{$IFDEF FPC}
  {$I fWait.lrs}
{$ENDIF}
end.
