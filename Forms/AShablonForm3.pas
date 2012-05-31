{**
@Abstract(Пустая форма с картинками. Шаблон для создания форм в не визуальном режиме)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.03.2006)
@LastMod(26.04.2012)
@Version(0.5)
}
unit AShablonForm3;

interface

uses
  Classes, Controls, Forms, ImgList,
  AFormImpl;

type
  TProfShablon3 = class(TProfForm3)
    RunImages: TImageList;
  protected
    //** Срабатывает при изменении размеров
    procedure DoResize(Sender: TObject); virtual;
  public
    //** Конструктор
    constructor Create(AOwner: TComponent); override;
  end;

const // Константы номеров стандартных картинок в RunImages --------------------
  IndexGrayBox    = 0;
  IndexBlueBox    = 1;
  IndexGreenBox   = 2;
  IndexFuchsiaBox = 3; // Фиолетовый
  IndexRedBox     = 4;

implementation

{$R *.dfm}

{ TProfShablon }

constructor TProfShablon3.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OnResize := DoResize;
end;

procedure TProfShablon3.DoResize(Sender: TObject);
begin
end;

end.
