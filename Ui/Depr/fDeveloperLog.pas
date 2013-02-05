{**
@Abstract(Главная форма для проектирования c логированием)
@Author(Prof1983 prof1983@ya.ru)
@Created(24.10.2006)
@LastMod(02.05.2012)
@Version(0.5)
}
unit fDeveloperLog;

interface

uses
  ALogControl,
  fDeveloper;

type //** @abstract(Главная форма для проектирования c логированием)
  TfmDeveloperLog = class(TfmDeveloperD)
  protected
      //** Контрол вывода логов
    FLogControl: TProfLogControl;
  protected
      //** Срабатывает при создании
    procedure DoCreate(); override;
  public
      //** Контрол вывода логов
    property LogControl: TProfLogControl read FLogControl;
  end;

implementation

{ TfmDeveloperLog }

procedure TfmDeveloperLog.DoCreate();
begin
  inherited DoCreate();

  FLogControl := TProfLogControl.Create(tsLogs);
  FLogControl.Initialize();
end;

end.
