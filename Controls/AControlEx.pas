{**
@Author Prof1983 <prof1983@ya.ru>
@Created 08.11.2006
@LastMod 04.02.2013
}
unit AControlEx;

interface

uses
  Controls,
  AObjectEx;

type
  TProfControlEx = class(TProfObjectEx)
  protected
    FControl: TWinControl;
  public
    property Control: TWinControl read FControl write FControl;
  end;

implementation

end.
