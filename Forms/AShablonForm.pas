{**
@Abstract Пустая форма с картинками. Шаблон для создания форм в не визуальном режиме
@Author Prof1983 <prof1983@ya.ru>
@Created 17.03.2006
@LastMod 12.11.2012
}
unit AShablonForm;

interface

uses
  Classes, Controls, Forms, ImgList;

type // Шаблон для создания форм в не визуальном режиме
  TfmShablon = class(TForm)
    RunImages: TImageList;
  protected
    procedure DoResize(Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
  end;

const // Константы номеров стандартных картинок в RunImages
  IndexGrayBox    = 0;
  IndexBlueBox    = 1;
  IndexGreenBox   = 2;
  IndexFuchsiaBox = 3; // Фиолетовый
  IndexRedBox     = 4;

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
