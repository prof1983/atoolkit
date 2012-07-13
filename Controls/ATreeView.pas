{**
@Abstract(TreeView can display the structure of XML)
@Author(Prof1983 <prof1983@ya.ru>)
@Created(22.12.2005)
@LastMod(13.07.2012)

Uses
  @link ABase
  @link ANodeIntf
}
unit ATreeView;

interface

uses
  Classes, ComCtrls, Controls, XmlIntf,
  ABase, ANodeIntf;

type
  TProfTreeViewMode = (
    tvOnlyNodes,   //**< Show only nodes that have children
    tvAll,         //**< Display all of the nodes
    tvFull         //**< Display all of the nodes and their values
    );

type
    //** @abstract(TreeView can display the structure of XML)
  TProfTreeView = class(TCustomTreeView)
  protected
    FMode: TProfTreeViewMode;
    FXml: IProfNode;
    FXml2: IXmlNode;
  protected
    procedure SetMode(Value: TProfTreeViewMode);
    procedure SetXml(Value: IProfNode);
    procedure SetXml2(Value: IXmlNode);
  public
    procedure AddXmlNode(ParentNode: TTreeNode; XmlNode: IProfNode);
    procedure AddXmlNode2(ParentNode: TTreeNode; XmlNode: IXmlNode);
    procedure AddXmlNodeProf2(ParentNode: TTreeNode; XmlNode: IXmlNode); deprecated; // Use AddXmlNode2()
    procedure Refresh(); virtual;
  public
    constructor Create(AOwner: TWinControl);
  public
    property Mode: TProfTreeViewMode read FMode write SetMode;
    property Xml: IProfNode read FXml write SetXml;
    property Xml2: IXmlNode read FXml2 write SetXml2;
  end;

implementation

{ TProfTreeView }

procedure TProfTreeView.AddXmlNode(ParentNode: TTreeNode; XmlNode: IProfNode);
{var
  Count: Integer;
  I: Integer;
  Node: IProfNode;}
begin
  {if not(Assigned(ParentNode)) then Exit;
  Count := XmlNode.ChildNodes.Count; //.Collection.Count;
  for I := 0 to Count - 1 do
  begin
    Node := XmlNode.Collection.Nodes[I];
    case FMode of
      tvOnlyNodes: if Node.Collection.Count > 0 then
      begin
        AddXmlNode(Items.AddChild(ParentNode, Node.NodeName), Node);
      end;
      tvAll: begin
        AddXmlNode(Items.AddChild(ParentNode, Node.NodeName), Node)
      end;
    else //tvFull
      AddXmlNode(Items.AddChild(ParentNode, Node.NodeName + ' = ' + TProfXmlNode.GetAsStringA(Node)), Node);
    end;
  end;}
end;

procedure TProfTreeView.AddXmlNode2(ParentNode: TTreeNode; XmlNode: IXmlNode);
var
  Count: AInt32;
  I: AInt32;
  Node: IXmlNode;
begin
  if not(Assigned(ParentNode)) then Exit;
  Count := XmlNode.Collection.Count;
  for I := 0 to Count - 1 do
  begin
    Node := XmlNode.Collection.Nodes[I];
    case FMode of
      tvOnlyNodes: if Node.Collection.Count > 0 then
      begin
        AddXmlNode2(Items.AddChild(ParentNode, Node.NodeName), Node);
      end;
      tvAll: begin
        AddXmlNode2(Items.AddChild(ParentNode, Node.NodeName), Node)
      end;
    else {tvFull}
      AddXmlNode2(Items.AddChild(ParentNode, Node.NodeName + ' = ' + Node.Text), Node);
    end;
  end;
end;

procedure TProfTreeView.AddXmlNodeProf2(ParentNode: TTreeNode; XmlNode: IXmlNode);
begin
  AddXmlNode2(ParentNode, XmlNode);
end;

constructor TProfTreeView.Create(AOwner: TWinControl);
begin
  inherited Create(AOwner);
  Parent := AOwner;
  FMode := tvOnlyNodes;
end;

procedure TProfTreeView.Refresh();
begin
  Items.Clear;
  if Assigned(FXml) then
    AddXmlNode(Self.Items.Add(nil, FXml.Name), FXml);
  if Assigned(FXml2) then
    AddXmlNode(Self.Items.Add(nil, FXml2.NodeName), FXml);
end;

procedure TProfTreeView.SetMode(Value: TProfTreeViewMode);
begin
  FMode := Value;
  Refresh;
end;

procedure TProfTreeView.SetXml(Value: IProfNode);
begin
  FXml := Value;
  Refresh();
end;

procedure TProfTreeView.SetXml2(Value: IXmlNode);
begin
  FXml2 := Value;
  Refresh();
end;

end.
