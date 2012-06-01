﻿{**
@Abstract(Форма отображения свойств)
@Author(Prof1983 prof1983@ya.ru)
@Created(12.10.2005)
@LastMod(18.05.2012)
@Version(0.5)
}
unit fProperties20061013;

{DEFINE USENL}

interface

uses
  Classes, Controls, ComCtrls, Dialogs, ExtCtrls, Graphics, Grids, Forms,
  Messages, SysUtils, ValEdit, Variants, Windows,
  {$IFDEF USENL}NLStatusBar, NLXmlTreeView,{$ENDIF}
  fProfShablon, AForm2007, ATreeView, ATypes;

type
  TfmProperties = class(TfmProfShablon)
  private
    FTreeView: TCustomTreeView;
    FSplitter: TSplitter;
    FStatusBar: TStatusBar;
    FValueListEditor: TValueListEditor;
    procedure ValueListEditorClick(Sender: TObject);
  protected
    procedure DoClick(ARow: Integer); virtual;
    procedure DoCreate(); override;
  public
    function Initialize(): WordBool; override;
    property TreeView: TCustomTreeView read FTreeView write FTreeView;
    property Splitter: TSplitter read FSplitter write FSplitter;
    property StatusBar: TStatusBar read FStatusBar write FStatusBar;
    property ValueListEditor: TValueListEditor read FValueListEditor write FValueListEditor;
  end;

implementation

{ TfmProperties }

procedure TfmProperties.DoClick(ARow: Integer);
begin
end;

procedure TfmProperties.DoCreate();
begin
  inherited DoCreate();
  Self.Caption := 'Properties';
end;

function TfmProperties.Initialize(): WordBool;
begin
  AddToLog(lgGeneral, ltInformation, 'TfmProperties.Initialize', []);
  Result := inherited Initialize();
  if not(Result) then Exit;

  if not(Assigned(FTreeView)) then
  begin
    {$IFDEF USENL}
    FTreeView := TNLXmlTreeView.Create(Self);
    {$ELSE}
    FTreeView := TProfTreeView.Create(Self);
    {$ENDIF}
    FTreeView.Parent := Self;
    FTreeView.Align := alLeft;
  end;

  if not(Assigned(FSplitter)) then
  begin
    FSplitter := TSplitter.Create(Self);
    FSplitter.Parent := Self;
    FSplitter.Left := FTreeView.Width + 10;
    FSplitter.Align := alLeft;
  end;

  if not(Assigned(FStatusBar)) then
  begin
    {$IFDEF USENL}
    FStatusBar := TNLStatusBar.Create(Self);
    {$ELSE}
    FStatusBar := TStatusBar.Create(Self);
    {$ENDIF}
    FStatusBar.Parent := Self;
  end;

  if not(Assigned(FValueListEditor)) then
  begin
    FValueListEditor := TValueListEditor.Create(Self);
    FValueListEditor.Parent := Self;
    FValueListEditor.Align := alClient;
    FValueListEditor.OnClick := ValueListEditorClick;
  end;
end;

procedure TfmProperties.ValueListEditorClick(Sender: TObject);
begin
  DoClick(FValueListEditor.Row);
end;

end.
