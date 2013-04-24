{**
@Abstract APlugins base consts and types
@Author Prof1983 <prof1983@ya.ru>
@Created 26.07.2012
@LastMod 24.04.2013
}
unit APluginsBase;

interface

uses
  ABase;

const
  APlugins_Name = 'APlugins';
  APlugins_Uid = $09041001;

type
  TCheckPluginProc = function(Lib: ALibrary): ABool; stdcall;

implementation

end.
 