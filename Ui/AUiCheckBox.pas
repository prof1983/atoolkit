{**
@Author Prof1983 <prof1983@ya.ru>
@Created 09.01.2013
@LastMod 09.01.2013
}
unit AUiCheckBox;

{$define AStdCall}

interface

uses
  Controls,
  StdCtrls,
  ABase,
  AUiBase,
  AUiData;

function AUiCheckBox_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

implementation

function AUiCheckBox_New(Parent: AControl): AControl;
var
  CheckBox: TCheckBox;
begin
  if not(TObject(Parent) is TWinControl) then
  begin
    Result := 0;
    Exit;
  end;
  try
    CheckBox := TCheckBox.Create(nil);
    CheckBox.Parent := TWinControl(Parent);
    Result := AUiData.AddObject(CheckBox);
  except
    Result := 0;
  end;
end;

end.
 