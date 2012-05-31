{**
@Abstract(TreeView которое может отбражать структуру XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.12.2005)
@LastMod(26.04.2012)
@Version(0.5)
}
unit ATreeView;

interface

uses
  Classes, ComCtrls, Controls, XmlIntf,
  ABase, ANodeIntf;

type
  TProfTreeViewMode = (
    tvOnlyNodes,   // Отображать только ноды, имеющих потомков
    tvAll,         // Отображать все ноды
    tvFull         // Отображать все ноды и их значения
    );

type //** @abstract(TreeView которое может отбражать структуру XML)
  TProfTreeView = class(TCustomTreeView)
  private
    FMode: TProfTreeViewMode;
    FXml: IProfNode;
    procedure SetMode(Value: TProfTreeViewMode);
    procedure SetXml(Value: IProfNode);
  public
    procedure AddXmlNode(ParentNode: TTreeNode; XmlNode: IProfNode);
    constructor Create(AOwner: TWinControl);
    property Mode: TProfTreeViewMode read FMode write SetMode;
    procedure Refresh(); virtual;
    property Xml: IProfNode read FXml write SetXml;
  end;

type
  TProfTreeView2006 = class(TCustomTreeView)
  private
    FMode: TProfTreeViewMode;
    FXml: IXmlNode{IProfXmlNode};
    //FXmlS: String;
    procedure SetMode(Value: TProfTreeViewMode);
    procedure SetXml(Value: IXmlNode{IProfXmlNode});
    //procedure SetXmlS(Value: String);
  public
    procedure AddXmlNode(ParentNode: TTreeNode; XmlNode: IXmlNode);
    procedure AddXmlNodeProf(ParentNode: TTreeNode; XmlNode: IXmlNode{IProfXmlNode});
    constructor Create(AOwner: TWinControl);
    property Mode: TProfTreeViewMode read FMode write SetMode;
    procedure Refresh(); virtual;
    property Xml: IXmlNode{IProfXmlNode} read FXml write SetXml;
    //property XmlS: String read FXmlS write SetXmlS;
  end;

implementation

{ TProfTreeView }

procedure TProfTreeView.AddXmlNode(ParentNode: TTreeNode; XmlNode: IProfNode);
var
  Count: Integer;
  I: Integer;
  Node: IProfNode;
begin
  if not(Assigned(ParentNode)) then Exit;
  Count := XmlNode.ChildNodes.Count; //.Collection.Count;
  {for I := 0 to Count - 1 do
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

constructor TProfTreeView.Create(AOwner: TWinControl);
begin
  inherited Create(AOwner);
  Parent := AOwner;
  FMode := tvOnlyNodes;
end;

procedure TProfTreeView.Refresh();
begin
  Items.Clear;
  if not(Assigned(FXml)) then Exit;
  AddXmlNode(Self.Items.Add(nil, FXml.Name), FXml);
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

{ TProfTreeView2006 }

procedure TProfTreeView2006.AddXmlNode(ParentNode: TTreeNode; XmlNode: IXmlNode);
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
        AddXmlNode(Items.AddChild(ParentNode, Node.NodeName), Node);
      end;
      tvAll: begin
        AddXmlNode(Items.AddChild(ParentNode, Node.NodeName), Node)
      end;
    else {tvFull}
      AddXmlNode(Items.AddChild(ParentNode, Node.NodeName + ' = ' + Node.Text), Node);
    end;
  end;
end;

procedure TProfTreeView2006.AddXmlNodeProf(ParentNode: TTreeNode; XmlNode: IXmlNode);
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
        AddXmlNode(Items.AddChild(ParentNode, Node.NodeName), Node);
      end;
      tvAll: begin
        AddXmlNode(Items.AddChild(ParentNode, Node.NodeName), Node)
      end;
    else {tvFull}
      AddXmlNode(Items.AddChild(ParentNode, Node.NodeName + ' = ' + Node.Text{AsString}), Node);
    end;
  end;
end;

constructor TProfTreeView2006.Create(AOwner: TWinControl);
begin
  inherited Create(AOwner);
  Parent := AOwner;
  FMode := tvOnlyNodes;
end;

procedure TProfTreeView2006.Refresh();
begin
  Items.Clear;
  if not(Assigned(FXml)) then Exit;
  AddXmlNode(Self.Items.Add(nil, FXml.NodeName), FXml);
end;

procedure TProfTreeView2006.SetMode(Value: TProfTreeViewMode);
begin
  FMode := Value;
  Refresh;
end;

procedure TProfTreeView2006.SetXml(Value: IXmlNode{IProfXmlNode});
begin
  FXml := Value;
  Refresh();
end;

{procedure TProfTreeView.SetXmlS(Value: String);
begin
  FXmlS := Value;
  if not(Assigned(FXml)) then FXml := TProfXmlNode.CreateA();
  FXml.Xml := Value;
  Refresh;
end;}

end.
