{**
@Abstract(Универсальный контрол)
@Author(Prof1983 prof1983@ya.ru)
@Created(08.11.2006)
@LastMod(26.04.2012)
@Version(0.5)
}
unit AControlImpl;

interface

uses
  Controls,
  AObjectImpl;

type //** Универсальный контрол
  TProfControl = class(TProfObject)
  protected
      //** Контрол
    FControl: TWinControl;
  public
      //** Контрол
    property Control: TWinControl read FControl write FControl;
  end;

implementation

end.
