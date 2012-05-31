{**
@Abstract(Главная форма для проектирования со списком элементов TreeView)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.04.2007)
@LastMod(26.04.2012)
@Version(0.5)
}
unit ADeveloperFormI;

interface

uses
  ComCtrls,
  ADeveloperForm3;

type
  TProfItem = class
  private
    FTreeNode: TTreeNode;
  public
    property TreeNode: TTreeNode read FTreeNode write FTreeNode;
  end;

type //** Главная форма для проектирования со списком элементов TreeView
  TDeveloperFormI = class(TfmDeveloperD)
  protected
    FItems: array of TProfItem;
  protected
    function GetTreeItemByNode(Node: TTreeNode): TProfItem;
      //** Создать новый элемент дерева
    function NewTreeItem(Parent: TProfItem; const Caption: WideString): TProfItem;
  end;

implementation

{ TDeveloperFormI }

function TDeveloperFormI.GetTreeItemByNode(Node: TTreeNode): TProfItem;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to High(FItems) do
    if FItems[i].TreeNode = Node then
    begin
      Result := FItems[i];
      Exit;
    end;
end;

function TDeveloperFormI.NewTreeItem(Parent: TProfItem; const Caption: WideString): TProfItem;
var
  ptn: TTreeNode;
  tn: TTreeNode;
  i: Integer;
begin
  if Assigned(Parent) then
    ptn := Parent.TreeNode
  else
    ptn := nil;
  //tn := tvObjects.Items.Add(ptn, Caption);
  tn := tvObjects.Items.AddChild(ptn, Caption);
  i := Length(FItems);
  SetLength(FItems, i + 1);
  FItems[i] := TProfItem.Create();
  FItems[i].TreeNode := tn;
  Result := FItems[i];
end;

end.
