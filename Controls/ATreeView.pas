{**
@Abstract TreeView can display the structure of XML
@Author Prof1983 <prof1983@ya.ru>
@Created 22.12.2005
@LastMod 05.02.2013

Uses
  @link ABase
  @link ANodeIntf
}
unit ATreeView;

interface

uses
  Classes, ComCtrls, Controls, XmlIntf,
  ABase,
  ANodeIntf,
  // --- 2006 ---
  AXmlNodeImpl;

type
  TProfTreeViewMode = (
    tvOnlyNodes,   //**< Show only nodes that have children
    tvAll,         //**< Display all of the nodes
    tvFull         //**< Display all of the nodes and their values
    );

  //TProfXmlNode = TProfXmlNode2;

type
    //** @abstract(TreeView can display the structure of XML)
  TProfTreeView = class(TCustomTreeView)
  protected
    FMode: TProfTreeViewMode;
    FXml: IProfNode;
    FXml2: IXmlNode;
    FXml2006: TProfXmlNode2;
    FXmlS: String;
  protected
    procedure SetMode(Value: TProfTreeViewMode);
    procedure SetXml(Value: IProfNode);
    procedure SetXml2(Value: IXmlNode);
    procedure SetXml2006(Value: TProfXmlNode2);
    procedure SetXmlS(Value: String);
  public
    procedure AddXmlNode(ParentNode: TTreeNode; XmlNode: IProfNode);
    procedure AddXmlNode2(ParentNode: TTreeNode; XmlNode: IXmlNode);
    procedure AddXmlNode2006(ParentNode: TTreeNode; XmlNode: TProfXmlNode2);
    procedure AddXmlNodeProf2(ParentNode: TTreeNode; XmlNode: IXmlNode); deprecated; // Use AddXmlNode2()
    procedure Refresh(); virtual;
  public
    constructor Create(AOwner: TWinControl);
  public
    property Mode: TProfTreeViewMode read FMode write SetMode;
    property Xml: IProfNode read FXml write SetXml;
    property Xml2: IXmlNode read FXml2 write SetXml2;
    property Xml2006: TProfXmlNode2 read FXml2006 write SetXml2006;
    property XmlS: String read FXmlS write SetXmlS;
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

procedure TProfTreeView.AddXmlNode2006(ParentNode: TTreeNode; XmlNode: TProfXmlNode2);
var
  Count: Int32;
  I: Int32;
  Node: TProfXmlNode2;
begin
  if not(Assigned(ParentNode)) then Exit;
  Count := XmlNode.GetCountNodes();
  for I := 0 to Count - 1 do
  begin
    Node := XmlNode.GetNode(I);
    case FMode of
      tvOnlyNodes:
        if (Node.GetCountNodes() > 0) then
        begin
          AddXmlNode(Items.AddChild(ParentNode, Node.NodeName), Node);
        end;
      tvAll:
        begin
          AddXmlNode(Items.AddChild(ParentNode, Node.NodeName), Node)
        end;
    else {tvFull}
      AddXmlNode(Items.AddChild(ParentNode, Node.NodeName + ' = ' + Node.AsString), Node);
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
  if (Assigned(FXml2006)) then
    AddXmlNode(Self.Items.Add(nil, FXml2006.NodeName), FXml2006);
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

procedure TProfTreeView.SetXml2006(Value: TProfXmlNode2);
begin
  FXml2006 := Value;
  Refresh();
end;

procedure TProfTreeView.SetXmlS(Value: String);
begin
  FXmlS := Value;
  if not(Assigned(FXml)) then
    FXml2006 := TProfXmlNode2.Create(nil);
  FXml2006.SetXml(Value);
  Refresh();
end;

end.
