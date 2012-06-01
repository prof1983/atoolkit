{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(10.06.2009)
@LastMod(03.05.2011)
@Version(0.5)
}
unit fMessage;

interface

uses
  {$IFDEF FPC}LResources,{$ENDIF}
  Classes, ComCtrls, Controls, ExtCtrls, Forms, Graphics, Messages, StdCtrls, SysUtils;

type
  TMessFrm = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
  end;

function MessFrm_Create(const Text: string): Integer;
procedure MessFrm_Free(Window: Integer);
procedure MessFrm_StepIt(Window: Integer);

implementation

{$IFNDEF FPC}
  {$R *.DFM}
{$ENDIF}

function MessFrm_Create(const Text: string): Integer;
var
  MessFrm: TMessFrm;
begin
  MessFrm := TMessFrm.Create(nil);
  MessFrm.Label1.Caption := Text;
  MessFrm.Show;
  Application.ProcessMessages;
  Result := Integer(MessFrm);
end;

procedure MessFrm_Free(Window: Integer);
begin
  TMessFrm(Window).Free;
end;

procedure MessFrm_StepIt(Window: Integer);
begin
  TMessFrm(Window).ProgressBar1.StepIt;
end;

initialization
{$IFDEF FPC}
  {$I fMessage.lrs}
{$ENDIF}
end.
