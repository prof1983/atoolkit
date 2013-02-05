{**
@Author Prof1983 <prof1983@ya.ru>
@Created 17.03.2006
@LastMod 05.02.2013
}
unit fShablon;

// TODO: Use AShablonForm.pas

interface

uses
  Classes, Controls, Forms, ImgList,
  AFormObj;

type
  TfmShablon = class(TAFormObject)
    RunImages: TImageList;
  protected
    procedure DoResize(Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.dfm}

{ TfmShablon }

constructor TfmShablon.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OnResize := DoResize;
end;

procedure TfmShablon.DoResize(Sender: TObject);
begin
end;

end.
