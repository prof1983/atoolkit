{**
@Abstract Форма отображения свойств
@Author Prof1983 <prof1983@ya.ru>
@Created 12.10.2005
@LastMod 17.12.2012
}
unit fProperties2006;

interface

uses
  Classes, Controls, ComCtrls, Dialogs, ExtCtrls, Graphics, Grids, Forms,
  Messages, SysUtils, ValEdit, Variants, Windows,
  NlStatusBar, NlXmlTreeView,
  ABase,
  ATypes,
  fProfShablon;

type
  TfmProperties = class(TfmProfShablon)
  private
    FTreeView: TCustomTreeView;
    FSplitter: TSplitter;
    FStatusBar: TNLStatusBar;
    FValueListEditor: TValueListEditor;
  public
    function Initialize(): AError; override;
  public
    property TreeView: TCustomTreeView read FTreeView write FTreeView;
    property Splitter: TSplitter read FSplitter write FSplitter;
    property StatusBar: TNLStatusBar read FStatusBar write FStatusBar;
    property ValueListEditor: TValueListEditor read FValueListEditor write FValueListEditor;
  end;

implementation

{ TfmProperties }

function TfmProperties.Initialize(): AError;
begin
  AddToLog(lgGeneral, ltInformation, 'TFormPropertys.Initialize');
  Result := inherited Initialize;
  if (Result < 0) then Exit;

  if not(Assigned(FTreeView)) then
  begin
    FTreeView := TNLXmlTreeView.Create(Self);
    FTreeView.Parent := Self;
  end;
  FTreeView.Align := alLeft;

  if not(Assigned(FSplitter)) then
  begin
    FSplitter := TSplitter.Create(Self);
    FSplitter.Parent := Self;
  end;
  FSplitter.Left := FTreeView.Width + 10;
  FSplitter.Align := alLeft;

  if not(Assigned(FStatusBar)) then
  begin
    FStatusBar := TNLStatusBar.Create(Self);
    FStatusBar.Parent := Self;
  end;
  FStatusBar.Parent := Self;

  if not(Assigned(FValueListEditor)) then
  begin
    FValueListEditor := TValueListEditor.Create(Self);
    FValueListEditor.Parent := Self;
  end;
  FValueListEditor.Align := alClient;
end;

end.

