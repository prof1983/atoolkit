{**
@Abstract Splitter
@Author Prof1983 <prof1983@ya.ru>
@Created 13.11.2012
@LastMod 13.11.2012
}
unit ASplitterControl;

interface

uses
  Classes, Controls, ExtCtrls;

type
  //** @abstract(Полоска изменения размера элемента)
  TSplitterControl = class(TSplitter)
  private
    FControl: TControl;
  protected
    //** Срабатывает при двойном щелчке
    procedure DoDblClick(ASender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
  public
    property Control: TControl read FControl write FControl;
  end;

implementation

{ TSplitterControl }

constructor TSplitterControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.OnDblClick := DoDblClick;
end;

procedure TSplitterControl.DoDblClick(ASender: TObject);
begin
  if Assigned(FControl) then
    FControl.Visible := not(FControl.Visible);
end;

end.
