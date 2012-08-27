{**
@Abstract APlugins export functions
@Author Prof1983 <prof1983@ya.ru>
@Created 02.08.2011
@LastMod 27.08.2012
}
unit APluginsExp;

interface

uses
  APluginsMain;

exports
  //APlugins_AddPlugin name 'APlugins_AddPlugin',
  APlugins_AddPluginA name 'APlugins_AddPluginA',
  APlugins_Clear name 'APlugins_Clear',
  APlugins_GetCount name 'APlugins_GetCount',
  APlugins_Delete name 'APlugins_Delete',
  //APlugins.Find02 name 'APlugins_Find',
  APlugins_FindA name 'APlugins_FindA';

implementation

end.
 