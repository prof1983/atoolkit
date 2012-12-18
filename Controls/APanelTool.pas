{**
Abstract APanelTool
@Author Prof1983 <prof1983@ya.ru>
@Created 14.10.2006
@LastMod 18.12.2012
}
unit APanelTool;

interface

uses
  Classes, ExtCtrls,
  ALogNodeImpl, ALogNodeIntf, ATypes;

type
  TPanelTool = class(TPanel, IALogNode2)
  protected
    FLogNode: IALogNode2;
    property LogNode: IALogNode2 read FLogNode implements IALogNode2;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    procedure Hide(); safecall;
    procedure Show(); safecall;
    function ToLogA(AGroup: EnumGroupMessage; AType: EnumTypeMessage; const AStrMsg: WideString): Integer; safecall;
  end;

implementation

{ TPanelTool }

constructor TPanelTool.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLogNode := TALogNode.Create2(0, 0, '', 0);
end;

destructor TPanelTool.Destroy();
begin
  FLogNode := nil;
  inherited Destroy();
end;

procedure TPanelTool.Hide();
begin
end;

procedure TPanelTool.Show();
begin
end;

function TPanelTool.ToLogA(AGroup: GroupMessageEnum; AType: TypeMessageEnum; const AStrMsg: WideString): Integer;
begin
  Self.Height := Self.Height + 1;
end;

end.
