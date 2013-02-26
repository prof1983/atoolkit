{**
@Abstract AUiPlus
@Author Prof1983 <prof1983@ya.ru>
@Created 18.05.2011
@LastMod 26.07.2012
}
unit AUiPlus;

interface

uses
  Classes,
  Controls,
  ABase,
  AUiBase;

type // Classes.TShiftState
  AUIShiftState = AInteger;
const
  uissShift = $00000001;
  uissAlt = $00000002;
  uissCtrl = $00000004;
  uissLeft = $00000008;
  uissRight = $00000010;
  uissMiddle = $00000020;
  uissDouble = $00000040;

function MouseButtonToInt(Value: TMouseButton): AMouseButton;
function ShiftStateFromInt(Value: AUIShiftState): TShiftState;
function ShiftStateToInt(Value: TShiftState): AUIShiftState;

implementation

function MouseButtonToInt(Value: TMouseButton): AMouseButton;
begin
  Result := AMouseButton(Value);
end;

function ShiftStateFromInt(Value: AUIShiftState): TShiftState;
begin
  Result := [];
  if (Value and uissShift = uissShift) then
    Result := Result + [ssShift];
  if (Value and uissAlt = uissAlt) then
    Result := Result + [ssAlt];
  if (Value and uissCtrl = uissCtrl) then
    Result := Result + [ssCtrl];
  if (Value and uissLeft = uissLeft) then
    Result := Result + [ssLeft];
  if (Value and uissRight = uissRight) then
    Result := Result + [ssRight];
  if (Value and uissMiddle = uissMiddle) then
    Result := Result + [ssMiddle];
  if (Value and uissDouble = uissDouble) then
    Result := Result + [ssDouble];
end;

function ShiftStateToInt(Value: TShiftState): AUIShiftState;
begin
  Result := 0;
  if (ssShift in Value) then
    Result := Result or uissShift;
  if (ssAlt in Value) then
    Result := Result or uissAlt;
  if (ssCtrl in Value) then
    Result := Result or uissCtrl;
  if (ssLeft in Value) then
    Result := Result or uissLeft;
  if (ssRight in Value) then
    Result := Result or uissRight;
  if (ssMiddle in Value) then
    Result := Result or uissMiddle;
  if (ssDouble in Value) then
    Result := Result or uissDouble;
end;

end.
 