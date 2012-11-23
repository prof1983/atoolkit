{**
@Abstract Универсальный контрол
@Author Prof1983 <prof1983@ya.ru>
@Created 08.11.2006
@LastMod 13.11.2012
}
unit AControlImpl;

interface

uses
  Controls,
  AObjectImpl;

type //** Универсальный контрол
  TAControl = class(TAObject)
  protected
      //** Контрол
    FControl: TWinControl;
  public
      //** Контрол
    property Control: TWinControl read FControl write FControl;
  end;

  //TProfControl = TAControl;

implementation

end.
