{**
Abstract(APanelTool)
@Author(Prof1983 prof1983@ya.ru)
@Created(14.10.2006)
@LastMod(03.07.2012)
@Version(0.5)
}
unit APanelTool;

interface

uses
  Classes, ExtCtrls,
  ALogNodeImpl, ALogNodeIntf, ATypes;

type
  TPanelTool = class(TPanel, ILogNode2)
  protected
    FLogNode: ILogNode2;
    property LogNode: ILogNode2 read FLogNode implements ILogNode2;
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
