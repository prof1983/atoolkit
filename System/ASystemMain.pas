{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(27.09.2011)
@LastMod(27.09.2011)
@Version(0.5)
}
unit ASystemMain;

interface

uses
  ABase, ABaseTypes, ASystemData;

function System_ShowMessage(const Msg: AWideString): ADialogBoxCommands;
function System_ShowMessageEx(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands;

implementation

function System_ShowMessage(const Msg: AWideString): ADialogBoxCommands;
begin
  Result := System_ShowMessageEx(Msg, FTitle, MB_OK);
end;

function System_ShowMessageEx(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands;
begin
  if Assigned(FOnShowMessage) then
    Result := FOnShowMessage(Text, Caption, Flags)
  else
    Result := 0;
end;

end.
 