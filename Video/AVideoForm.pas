{**
@Abstract(Окно просмотра видео)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.05.2005)
@LastMod(04.05.2012)
@Version(0.5)
}
unit AVideoForm;

interface

uses
  AShablonForm;

type //** Окно просмотра видео
  TfmVideo = class(TfmShablon)
  protected
    procedure DoCreate(); override;
  end;

implementation

{ TfmVideo }

procedure TfmVideo.DoCreate();
begin
  inherited DoCreate();
  Height := 200;
  Width := 200;
  Left := 200;
  Top := 200;
end;

end.
