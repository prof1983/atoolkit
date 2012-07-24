{**
@Abstract APlugins export functions
@Author Prof1983 <prof1983@ya.ru>
@Created 02.08.2011
@LastMod 24.07.2012
}
unit APluginsExp;

interface

uses
  APlugins;

exports
  APlugins.AddPlugin name 'APlugins_AddPlugin',
  APlugins.Clear name 'APlugins_Clear',
  APlugins.GetCount name 'APlugins_Count',
  APlugins.Delete name 'APlugins_Delete',
  APlugins.Find02 name 'APlugins_Find';

implementation

end.
 