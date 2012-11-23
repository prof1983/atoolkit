{**
@Abstract Пустая форма с картинками. Шаблон для создания форм в не визуальном режиме
@Author Prof1983 <prof1983@ya.ru>
@Created 17.03.2006
@LastMod 12.11.2012
}
unit fShablon;

interface

uses
  Classes, Controls, Forms, ImgList,
  AFormObj{AFormImpl};

type //** Шаблон для создания форм в не визуальном режиме
  TfmShablon = class(TAFormObject{TProfForm})
    RunImages: TImageList;
  protected
      //** Срабатывает при изменении размеров
    procedure DoResize(Sender: TObject); virtual;
  public
      //** Конструктор
    constructor Create(AOwner: TComponent); override;
  end;

  //TProfShablon3 = TfmShablon;

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
