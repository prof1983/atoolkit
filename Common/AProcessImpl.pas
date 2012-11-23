{**
@Abstract Объект с логированием, конфигурациями и функциями Старт, Стоп и Пауза
@Author Prof1983 <prof1983@ya.ru>
@Created 22.12.2005
@LastMod 23.11.2012
}
unit AProcessImpl;

interface

uses
  ABase, AObjectImpl;

type //** Объект с логированием, конфигурациями и функциями Старт, Стоп и Пауза
  TProfProcess = class(TAObject)
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
    function Finalize(): AError; override;
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

function TProfProcess.Finalize(): AError;
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
