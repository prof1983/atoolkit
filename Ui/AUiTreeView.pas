{**
@Abstract AUi TreeView
@Author Prof1983 <prof1983@ya.ru>
@Created 01.11.2011
@LastMod 30.01.2013
}
unit AUiTreeView;

{define AStdCall}

interface

uses
  ComCtrls,
  Controls,
  ABase,
  AStringMain,
  AUiBase,
  AUiData;

// --- AUiTreeView ---

function AUiTreeView_AddItem(TreeView: AControl; Parent: ATreeNode;
    const Text: AString_Type): ATreeNode; {$ifdef AStdCall}stdcall;{$endif}

function AUiTreeView_AddItemP(TreeView: AControl; Parent: ATreeNode;
    const Text: APascalString): ATreeNode;

function AUiTreeView_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

implementation

// --- AUiTreeView ---

function AUiTreeView_AddItem(TreeView: AControl; Parent: ATreeNode;
    const Text: AString_Type): ATreeNode;
begin
  Result := AUiTreeView_AddItemP(TreeView, Parent, AString_ToPascalString(Text));
end;

function AUiTreeView_AddItemP(TreeView: AControl; Parent: ATreeNode;
    const Text: APascalString): ATreeNode;
var
  tmpTreeView: TTreeView;
begin
  tmpTreeView := TTreeView(TreeView);
  Result := ATreeNode(tmpTreeView.Items.AddChild(TTreeNode(Parent), Text));
end;

function AUiTreeView_New(Parent: AControl): AControl;
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
 