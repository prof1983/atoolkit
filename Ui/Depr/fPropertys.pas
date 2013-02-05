{**
@Abstract Форма отображения свойств
@Author Prof1983 <prof1983@ya.ru>
@Created 12.10.2005
@LastMod 18.12.2012
}
unit fPropertys;

interface

uses
  Classes, Controls, ComCtrls, Dialogs, ExtCtrls, Graphics, Grids, Forms,
  Messages, SysUtils, ValEdit, Variants, Windows,
  NlStatusBar, NlXmlTreeView,
  ABase,
  AFormObj,
  ATypes;

type
  TFormPropertys = class(TAFormObject)
  private
    FTreeView: TCustomTreeView; //TNLXmlTreeView;
    FSplitter: TSplitter;
    FStatusBar: TNLStatusBar;
    FValueListEditor: TValueListEditor;
  public
    function Initialize(): AError; override;
  public
    property TreeView: TCustomTreeView {TNLXmlTreeView} read FTreeView write FTreeView;
    property Splitter: TSplitter read FSplitter write FSplitter;
    property StatusBar: TNLStatusBar read FStatusBar write FStatusBar;
    property ValueListEditor: TValueListEditor read FValueListEditor write FValueListEditor;
  end;

implementation

{$R *.dfm}

{ TFormPropertys }

function TFormPropertys.Initialize(): AError;
begin
  AddToLog(lgGeneral, ltInformation, 'TFormPropertys.Initialize');
  Result := inherited Initialize;
  if (Result < 0) then Exit;

  if not(Assigned(FTreeView)) then FTreeView := TNLXmlTreeView.Create(Self);
  FTreeView.Align := alLeft;

  if not(Assigned(FSplitter)) then FSplitter := TSplitter.Create(Self);
  FSplitter.Left := FTreeView.Width + 10;
  FSplitter.Align := alLeft;

  if not(Assigned(FStatusBar)) then FStatusBar := TNLStatusBar.Create(Self);
  FStatusBar.Parent := Self;

  if not(Assigned(FValueListEditor)) then FValueListEditor := TValueListEditor.Create(Self);
  FValueListEditor.Align := alClient;
end;

end.

