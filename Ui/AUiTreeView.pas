{**
@Abstract AUi TreeView
@Author Prof1983 <prof1983@ya.ru>
@Created 01.11.2011
@LastMod 19.11.2012
}
unit AUiTreeView;

{$define AStdCall}

interface

uses
  ComCtrls, Controls, AStrings,
  ABase, AUiBase, AUiData;

// --- AUiTreeView ---

function AUiTreeView_AddItem(TreeView: AControl; Parent: ATreeNode; const Text: AString_Type): ATreeNode; {$ifdef AStdCall}stdcall;{$endif}

function AUiTreeView_AddItemP(TreeView: AControl; Parent: ATreeNode; const Text: APascalString): ATreeNode; {$ifdef AStdCall}stdcall;{$endif}

function AUiTreeView_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

// ----

function UI_TreeView_AddItem(TreeView: AControl; Parent: ATreeNode; Text: APascalString): ATreeNode; deprecated; // Use AUiTreeView_AddItemP()

function UI_TreeView_New(Parent: AControl): AControl; deprecated; // Use AUiTreeView_New()

implementation

function AUiTreeView_AddItem(TreeView: AControl; Parent: ATreeNode; const Text: AString_Type): ATreeNode;
begin
  Result := AUiTreeView_AddItemP(TreeView, Parent, AString_ToPascalString(Text));
end;

function AUiTreeView_AddItemP(TreeView: AControl; Parent: ATreeNode; const Text: APascalString): ATreeNode;
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

{ UI_TreeView }

function UI_TreeView_AddItem(TreeView: AControl; Parent: ATreeNode; Text: APascalString): ATreeNode;
begin
  Result := AUiTreeView_AddItemP(TreeView, Parent, Text);
end;

function UI_TreeView_New(Parent: AControl): AControl;
begin
  Result := AUiTreeView_New(Parent);
end;

end.
 