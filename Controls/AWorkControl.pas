{**
@Abstract Контрол для получения новостей о работе
@Author Prof1983 <prof1983@ya.ru>
@Created 12.04.2007
@LastMod 17.12.2012
}
unit AWorkControl;

interface

uses
  ComCtrls,
  AControlImpl;

type //** Контрол для получения новостей о работе
  TWorkControl = class(TAControl)
  private
    //reOut: TRichEdit;
  private
    //** Список проектов
    //FProjects: TProfXmlDocument;
    //** Настройки программы
    //FSettings: TWorkSettings;
    //** Список сайтов
    //FSites: TProfXmlDocument;
  public
    procedure DoCreate(); override; safecall;
  end;

implementation

{ TWorkControl }

procedure TWorkControl.DoCreate();
begin
  // Создаем объек работы со списком сайтов
  {FSites := TProfXmlDocument.Create();
  FSites.FileName := FSettings.SiteListFileName;
  if FSites.Open() = 1 then
  begin
    FSites.WriteString('Weblancer', 'http://weblancer.net/');
    FSites.WriteString('Rabota.ru', 'http://rabota.ru/');
  end;}

  // Создаем список проектов
  {FProjects := TProfXmlDocument.Create();
  FProjects.FileName := FSettings.ProjectListFileName;
  FProjects.Open();}
end;

end.
