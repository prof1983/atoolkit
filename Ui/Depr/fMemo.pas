{**
@Abstract(Форма с Memo)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.01.2006)
@LastMod(02.05.2012)
@Version(0.5)
}
unit fMemo;

interface

uses
  Classes, Controls, Dialogs, Graphics, Forms, Messages, StdCtrls, SysUtils, Variants, Windows,
  AFormImpl;

type // Форма с Memo
  TfmMemo = class(TProfForm)
    Memo: TMemo;
  public
    function Add(const S: WideString): Integer;
  end;

implementation

{$R *.dfm}

{ TfmMemo }

function TfmMemo.Add(const S: WideString): Integer;
begin
  Result := Memo.Lines.Add(S);
end;

end.
