{**
@abstract ASystem exports
@author Prof1983 <prof1983@ya.ru>
@created 20.08.2007
@lastmod 16.11.2012
}
unit ASystemExp;

{$IFNDEF NoRuntimeEvents}
  {$DEFINE USE_EVENTS}
{$ENDIF NoRuntimeEvents}

interface

uses
  ASystem, ASystemMain;

exports
  ASystem_GetConfig,
  ASystem.GetCompanyName name 'ASystem_GetCompanyName',
  ASystem.GetCopyright name 'ASystem_GetCopyright',
  ASystem_GetDataDirectoryPath,
  ASystem.GetDescription name 'ASystem_GetDescription',
  ASystem_GetDirectoryPath,
  ASystem.GetExeName name 'ASystem_GetExeName',
  ASystem.GetExePath name 'ASystem_GetExePath',
  ASystem.GetProductName name 'ASystem_GetProductName',
  ASystem.GetProductVersion name 'ASystem_GetProductVersion',
  ASystem_GetProgramName,
  ASystem.GetProgramVersionWS name 'ASystem_GetProgramVersion',
  ASystem.GetTitle name 'ASystem_GetTitle',
  ASystem.GetUrl name 'ASystem_GetUrl',
  ASystem.GetResourceStringWS name 'ASystem_GetResourceString',
  {$IFDEF USE_EVENTS}
  ASystem.OnAfterRun_Connect name 'ASystem_OnAfterRun_Connect',
  ASystem.OnAfterRun_Disconnect name 'ASystem_OnAfterRun_Disconnect',
  ASystem.OnBeforeRun_Connect name 'ASystem_OnBeforeRun_Connect',
  ASystem.OnBeforeRun_Disconnect name 'ASystem_OnBeforeRun_Disconnect',
  {$ENDIF USE_EVENTS}
  ASystem.Prepare name 'ASystem_Prepare',
  ASystem.Prepare1 name 'ASystem_Prepare1',
  ASystem.Prepare2 name 'ASystem_Prepare2',
  ASystem.Prepare2A name 'ASystem_Prepare2A',
  ASystem.Prepare4A name 'ASystem_Prepare4A',
  ASystem.ProcessMessages02 name 'ASystem_ProcessMessages',
  Runtime_SetConfig name 'ASystem_SetConfig',
  ASystem.ShowError02 name 'ASystem_ShowError',
  ASystem.ShowMessage02 name 'ASystem_ShowMessage',
  ASystem.ShowMessageExWS name 'ASystem_ShowMessageA',
  ASystem.Shutdown name 'ASystem_Shutdown',
  ASystem.SetOnProcessMessages02 name 'ASystem_SetOnProcessMessages',
  ASystem.SetOnShowError name 'ASystem_SetOnShowError',
  ASystem.SetOnShowMessage name 'ASystem_SetOnShowMessage';

implementation

end.
 