{**
@Abstract(Клиент для DLL плагинов)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.03.2008)
@LastMod(04.07.2011)
@Version(0.5)
}
unit APluginClient;

interface

uses
  Windows,
  ABase, AModuleClient;

type
  //** @abstract(Возвращяет версию модуля)
  TAGetVersionProc = function(): AVersion; stdcall;

type
  TAPluginClient = class(TAModuleClient)
  private
    FHandle: Integer;
    FGetVersion: TAGetVersionProc;
  public
    destructor Destroy(); override;
  public
    property Handle: Integer read FHandle write FHandle;
    property GetVersionProc: TAGetVersionProc read FGetVersion write FGetVersion;
  end;

implementation

{ TAPluginClient }

destructor TAPluginClient.Destroy();
begin
  FreeLibrary(FHandle);
  inherited;
end;

end.
 