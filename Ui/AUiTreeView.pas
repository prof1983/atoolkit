{**
@Abstract AUi TreeView
@Author Prof1983 <prof1983@ya.ru>
@Created 01.11.2011
@LastMod 19.07.2012
}
unit AUiTreeView;

interface

uses
  ComCtrls, Controls, 
  ABase, AUiBase, AUiData;

function UI_TreeView_AddItem(TreeView: AControl; Parent: ATreeNode; Text: APascalString): ATreeNode;

function UI_TreeView_New(Parent: AControl): AControl;

implementation

{ UI_TreeView }

function UI_TreeView_AddItem(TreeView: AControl; Parent: ATreeNode; Text: APascalString): ATreeNode;
var
  tmpTreeView: TTreeView;
begin
  tmpTreeView := TTreeView(TreeView);
  Result := ATreeNode(tmpTreeView.Items.AddChild(TTreeNode(Parent), Text));
end;

function UI_TreeView_New(Parent: AControl): AControl;
var
  O: TObject;
  TreeView: TTreeView;
begin
  O := AUIData.GetObject(Parent);
  if Assigned(O) and (O is TWinControl) then
  begin
    TreeView := TTreeView.Create(TWinControl(O));
    TreeView.Parent := TWinControl(O);
    TreeView.Align := alLeft;
    Result := AddObject(TreeView);
  end
  else
    Result := 0;
end;

end.
 