{**
@Author Prof1983 <prof1983@ya.ru>
@Created 20.08.2009
@LastMod 05.02.2013
}
unit AModuleManager;

interface

uses
  ABase, AModuleManagerMain;

function Fin(): AError; stdcall;
function Init(): AError; stdcall;

implementation

{ Public }

function Fin(): AError;
begin
  Result := AModuleManager_Fin();
end;

function Init(): AError;
begin
  Result := AModuleManager_Init();
end;

end.
