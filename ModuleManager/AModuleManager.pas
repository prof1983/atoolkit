{**
@Abstract AModuleManager
@Author Prof1983 <prof1983@ya.ru>
@Created 20.08.2009
@LastMod 20.11.2012
}
unit AModuleManager;

interface

uses
  ABase, AModuleManagerMain;

function Init(): AError; stdcall;
function Done(): AError; stdcall;

function Init02(): AInteger; stdcall;
procedure Done02(); stdcall;

function ModuleManager_Init(): AError; deprecated; // Use AModuleManager_Init()
function ModuleManager_Done(): AError; deprecated; // Use AModuleManager_Fin()

implementation

{ ModuleManager }

function ModuleManager_Done(): AError;
begin
  Result := AModuleManager_Fin();
end;

function ModuleManager_Init(): AError;
begin
  Result := AModuleManager_Init();
end;

{ Public }

function Done(): AError; stdcall;
begin
  Result := ModuleManager_Done();
end;

procedure Done02(); stdcall;
begin
  AModuleManager_Fin();
end;

function Init(): AError; stdcall;
begin
  Result := AModuleManager_Init();
end;

function Init02(): AInteger; stdcall;
begin
  Result := AModuleManager_Init();
end;

end.
