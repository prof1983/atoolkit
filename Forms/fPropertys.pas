{**
@Abstract(Форма отображения свойств)
@Author(Prof1983 prof1983@ya.ru)
@Created(12.10.2005)
@LastMod(11.07.2011)
@Version(0.5)
}
unit fPropertys;

interface

uses
  Classes, Controls, ComCtrls, Dialogs, ExtCtrls, Graphics, Grids, Forms,
  Messages, SysUtils, ValEdit, Variants, Windows,
  NlStatusBar, NlXmlTreeView,
  AFormObj, ATypes;

type
  TFormPropertys = class(TProfForm)
  private
    FTreeView: TCustomTreeView; //TNLXmlTreeView;
    FSplitter: TSplitter;
    FStatusBar: TNLStatusBar;
    FValueListEditor: TValueListEditor;
  public
    function ConfigureLoad: Boolean; virtual;
    function Initialize(): Boolean; //override;
    property TreeView: TCustomTreeView {TNLXmlTreeView} read FTreeView write FTreeView;
    property Splitter: TSplitter read FSplitter write FSplitter;
    property StatusBar: TNLStatusBar read FStatusBar write FStatusBar;
    property ValueListEditor: TValueListEditor read FValueListEditor write FValueListEditor;
  end;

implementation

{$R *.dfm}

{ TFormPropertys }

function TFormPropertys.ConfigureLoad(): Boolean;
begin
  Result := inherited ConfigureLoad;
end;

function TFormPropertys.Initialize(): Boolean;
begin
  AddToLog(lgGeneral, ltInformation, 'TFormPropertys.Initialize');
  Result := inherited Initialize;
  if not(Result) then Exit;

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

