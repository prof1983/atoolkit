{**
@abstract(Пустая форма с картинками. Шаблон для создания форм в не визуальном режиме)
@author(Prof1983 prof1983@ya.ru)
@created(17.03.2006)
@lastmod(24.02.2012)
@version(0.55)
}
unit fShablon;

interface

uses
  Classes, Controls, Forms, ImgList,
  AFormImpl;

type //** Шаблон для создания форм в не визуальном режиме
  TfmShablon = class(TProfForm)
    RunImages: TImageList;
  protected
      //** Срабатывает при изменении размеров
    procedure DoResize(Sender: TObject); virtual;
  public
      //** Конструктор
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
