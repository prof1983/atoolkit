{**
@Abstract AUiLabel extended functions
@Author Prof1983 <prof1983@ya.ru>
@Created 14.11.2012
@LastMod 19.02.2013
}
unit AUiLabelsEx;

{define AStdCall}

interface

uses
  ABase,
  AUiBase, AUiLabels, AUiTextView;

// --- AUiLabel ---

{** ������� ����� ������� ���������� ������
    @param Typ - 0-Label; 1-Memo }
function AUiLabel_New2(Parent: AControl; Typ: AInt): AControl; {$ifdef AStdCall}stdcall;{$endif}

implementation

// --- AUiLabel ---

function AUiLabel_New2(Parent: AControl; Typ: AInt): AControl;
begin
  if (Typ = 0) then
    Result := AUiLabel_New(Parent)
  else if (Typ = 1) then
    Result := AUiTextView_New(Parent, 0)
  else
    Result := 0;
end;

end.
