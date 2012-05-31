{**
@Abstract(Объект с логированием, конфигурациями и функциями Старт, Стоп и Пауза)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.12.2005)
@LastMod(26.04.2012)
@Version(0.5)

История изменений:
0.1.0.0 - 14.07.2007
}
unit AProcessImpl;

interface

uses
  AObjectImpl, ATypes;

type //** Объект с логированием, конфигурациями и функциями Старт, Стоп и Пауза
  TProfProcess = class(TProfObject)
  protected
      //** Срабатывает при начале запуска
    function DoStart(): WordBool; virtual; safecall;
      //** Срабатывает после удачного запуска
    function DoStarted(): WordBool; virtual; safecall;
      //** Срабатывает при начале процедуры остановки
    function DoStop(AIsShutDown: WordBool): WordBool; virtual; safecall;
      //** Срабатывает при завершении процедуры остановки
    function DoStoped(AIsShutDown: WordBool): WordBool; virtual; safecall;
  public
    function Finalize(): TProfError; override;
    function Start(): WordBool; virtual;
    function Stop(): WordBool; virtual;
  end;

implementation

{ TProfProcess }

function TProfProcess.DoStart(): WordBool;
begin
  Result := True;
end;

function TProfProcess.DoStarted(): WordBool;
begin
  Result := True;
end;

function TProfProcess.DoStop(AIsShutDown: WordBool): WordBool;
begin
  Result := True;
end;

function TProfProcess.DoStoped(AIsShutDown: WordBool): WordBool;
begin
  Result := True;
end;

function TProfProcess.Finalize(): TProfError;
begin
  Stop();
  Result := inherited Finalize();
end;

function TProfProcess.Start(): WordBool;
begin
  Result := DoStart();
  if Result then
    Result := DoStarted();
end;

function TProfProcess.Stop(): WordBool;
begin
  Result := DoStop(False);
  if Result then
    Result := DoStoped(False);
end;

end.
