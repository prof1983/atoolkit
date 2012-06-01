{**
@Abstract(SimpleLogForm)
@Author(Prof1983 prof1983@ya.ru)
@Created(04.06.2007)
@LastMod(18.05.2012)
@Version(0.5)
}
unit fSimpleLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfmLog = class(TForm)
    reLog: TRichEdit;
  public
    function AddMsg(Msg: WideString): Integer;
  end;

implementation

{$R *.dfm}

{ TfmLog }

function TfmLog.AddMsg(Msg: WideString): Integer;
begin
  Result := reLog.Lines.Add(Msg);
end;

end.
