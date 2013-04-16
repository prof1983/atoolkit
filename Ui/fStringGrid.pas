{**
@Abstract(StringGrid form)
@Author(Prof1983 prof1983@ya.ru)
@Created(24.06.2011)
@LastMod(24.06.2011)
}
unit fStringGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, Grids;

type
  TfmStringGrid = class(TForm)
    sgMain: TStringGrid;
    plButtons: TPanel;
    StatusBar1: TStatusBar;
  end;

implementation

{$R *.dfm}

end.
