{**
@Abstract(TreeView которое может отбражать структуру XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.12.2005)
@LastMod(05.05.2012)
@Version(0.5)

0.0.0.3 - 22.12.2005 - XmlS, Mode, TProfTreeViewMode
0.0.0.2 - 27.10.2005 - AddXmlNode
0.0.0.1 - 21.10.2005
}
unit ATreeView2006;

interface

uses
  Classes, ComCtrls, Controls,
  AXml2007;

type
  TProfTreeViewMode = (
    tvOnlyNodes,   {Отображать только ноды, имеющих потомков}
    tvAll,         {Отображать все ноды}
    tvFull         {Отображать все ноды и их значения}
    );

type
  TProfXmlNode = TProfXmlNode1;

type
  TProfTreeView = class(TTreeView)
  private
    FMode: TProfTreeViewMode;
    FXml: TProfXmlNode1;
    FXmlS: String;
    procedure SetMode(Value: TProfTreeViewMode);
    procedure SetXml(Value: TProfXmlNode);
    procedure SetXmlS(Value: String);
  public
    procedure AddXmlNode(ParentNode: TTreeNode; XmlNode: TProfXmlNode);
    constructor Create(AOwner: TWinControl);
    property Mode: TProfTreeViewMode read FMode write SetMode;
    procedure Refresh; virtual;
    property Xml: TProfXmlNode read FXml write SetXml;
    property XmlS: String read FXmlS write SetXmlS;
  end;

implementation

{ TProfTreeView }

procedure TProfTreeView.AddXmlNode(ParentNode: TTreeNode; XmlNode: TProfXmlNode);
var
  Count: Int32;
  I: Int32;
  Node: TProfXmlNode;
begin
  if not(Assigned(ParentNode)) then Exit;
  Count := XmlNode.Collection.Count; //XmlNode.GetCountNodes;
  for I := 0 to Count - 1 do begin
    Node := XmlNode.Collection.Nodes[I]; //XmlNode.GetNode(I);
    case FMode of
      tvOnlyNodes:
        if (Node.Collection.Count > 0) then //if (Node.GetCountNodes > 0) then
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

constructor TProfTreeView.Create(AOwner: TWinControl);
begin
  inherited Create(AOwner);
  Parent := AOwner;
  FMode := tvOnlyNodes;
end;

procedure TProfTreeView.Refresh;
begin
  Items.Clear;
  if not(Assigned(FXml)) then Exit;
  AddXmlNode(Self.Items.Add(nil, FXml.NodeName), FXml);
end;

procedure TProfTreeView.SetMode(Value: TProfTreeViewMode);
begin
  FMode := Value;
  Refresh;
end;

procedure TProfTreeView.SetXml(Value: TProfXmlNode);
begin
  FXml := Value;
  Refresh;
end;

procedure TProfTreeView.SetXmlS(Value: String);
begin
  FXmlS := Value;
  if not(Assigned(FXml)) then FXml := TProfXmlNode.Create(nil);
  FXml.Xml := Value;
  Refresh;
end;

end.
