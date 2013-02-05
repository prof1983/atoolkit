{**
@Author Prof1983 <prof1983@ya.ru>
@Created 08.11.2006
@LastMod 05.02.2013
}
unit AControlImpl;

interface

uses
  Controls,
  AObjectImpl;

type
  TAControl = class(TAObject)
  protected
    FControl: TWinControl;
  public
    property Control: TWinControl read FControl write FControl;
  end;

implementation

end.
