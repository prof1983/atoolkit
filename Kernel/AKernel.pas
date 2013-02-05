{**
@Author Prof1983 <prof1983@ya.ru>
@Created 12.03.2008
@LastMod 05.02.2013
}
unit AKernel;

interface

uses
  SysUtils, Windows,
  ABase, ABaseUtils, AConsts, AKernelBase, AMessages, AModule, AModuleClient, APluginClient,
  AKernelRuntime, AThreatedModule;

type
  TAKernel = class
  private
    FNextMessageID: Integer;
    function GetIsWorking(): Integer;
    function GetNextMessageID(): Integer;
  public
    constructor Create();
    function Finalize(): Integer;
    function Initialize(): Integer;
    function LoadPlugin(PluginFileName: string): TAThreatedModule;
    property IsWorking: Integer read GetIsWorking;
    {** The next message ID
        Starts with 1. When you reach the maximum value of the counter is reset and the numbering starts again with 1. }
    property NextMessageID: TAMessageID read GetNextMessageID;
  public
    class function KernelIsWorking(): Integer;
  end;

function AKernel_InitKernelW(Version: AVersion; const ProgramName: WideString): Integer;
function AKernel_DoneKernel(): Integer;

var
  Kernel: TAKernel;

implementation

const
  AGetVersion = 'GetVersion';
  ARunMessage = 'RunMessage';
  ARunMessageC = 'RunMessageC';

{ AKernel }

function AKernel_DoneKernel(): Integer;
begin
  if Assigned(Kernel) then
  begin
    Result := Kernel.Finalize();
    Kernel.Free();
    Kernel := nil;
  end
  else
    Result := 0;
end;

function AKernel_InitKernelW(Version: AVersion; const ProgramName: WideString): Integer;
begin
  APlatformVersion := Version;
  APlatformName := ProgramName;
  if not(Assigned(Kernel)) then
  begin
    Kernel := TAKernel.Create();
    Result := Kernel.Initialize();
  end
  else
    Result := 0;
end;

{ TAKernel }

constructor TAKernel.Create();
begin
  inherited Create();
  Kernel := Self;
  InitializeRuntime();
end;

function TAKernel.Finalize(): Integer;
var
  c: Integer;
  i: Integer;
  m: TAAbstractModule;
begin
  MessageBox(0, 'Finalize', 'Kernel', MB_OK);
  Result := 0;
  c := Runtime.ModuleCount;
  for i := 0 to c - 1 do
  begin
    m := Runtime.ModuleByIndex[i];
    //Runtime.UnRegisterModule();
    if Assigned(m) then
    try
      MessageBox(0, PChar('FinalizeModule ' + IntToStr(m.ModuleID)), 'Kernel', MB_OK);
      //m.Terminate();
      m.Finalize();
      //Sleep(100);
      m.Free();
    except
    end;
    //m := nil;
  end;
  Runtime.Clear();
end;

function TAKernel.GetIsWorking(): Integer;
begin
  if Runtime.IsExit then
    Result := rFalse
  else
    Result := rTrue;
end;

function TAKernel.GetNextMessageID(): Integer;
begin
  Result := FNextMessageID;
  if (FNextMessageID = High(FNextMessageID)) then
    FNextMessageID := 1
  else
    Inc(FNextMessageID);
end;

function TAKernel.Initialize(): Integer;
begin
  Result := 0;
end;

class function TAKernel.KernelIsWorking(): Integer;
begin
  if Assigned(Kernel) then
    Result := Kernel.IsWorking
  else
    Result := rModuleNotInitialized;
end;

function TAKernel.LoadPlugin(PluginFileName: string): TAThreatedModule;
var
  HLibrary: Integer;
  Version: AVersion;
  Plugin: TAPluginClient;
  procGetVersion: TAGetVersionProc;
  procRunMessage: TAModuleRunMessageProc;
  procRunMessageC: TAComponentRunMessageProc;
begin
  Result := nil;
  HLibrary := LoadLibrary(PChar(PluginFileName));
  if (HLibrary > 32) then
  try
    procGetVersion := GetProcAddress(HLibrary, AGetVersion);
    procRunMessage := GetProcAddress(HLibrary, ARunMessage);
    procRunMessageC := GetProcAddress(HLibrary, ARunMessageC);
    if not(Assigned(Addr(procGetVersion)))
    or not(Assigned(Addr(procRunMessage))) then
    begin
      MessageBox(0, PChar(errLoadPlugin + ' ' + PluginFileName), PChar(stTitle), MB_OK or MB_ICONSTOP or MB_TASKMODAL);
      FreeLibrary(HLibrary);
      Exit;
    end;
    try
      Version := procGetVersion();
    except
      MessageBox(0, PChar(errLoadPlugin_GetVersion + ' ' + PluginFileName), PChar(stTitle), MB_OK or MB_ICONSTOP or MB_TASKMODAL);
      FreeLibrary(HLibrary);
      Exit;
    end;
    if (Version and AVersionMask <> APlatformVersion) then
    begin
      MessageBox(0,
        PChar(errLoadPlugin_Version +
          ' PluginFileName="' + PluginFileName + '"'+
          ', PluginVersion=' + VersionToStr(Version) +
          ', AssistantPlatformVersion=' + VersionToStr(APlatformVersion)),
        PChar(stTitle), MB_OK or MB_ICONSTOP or MB_TASKMODAL);
      FreeLibrary(HLibrary);
      Exit;
    end;

    Plugin := TAPluginClient.Create();
    Plugin.Handle := HLibrary;
    Plugin.GetVersionProc := procGetVersion;
    Plugin.RunMessageProc := procRunMessage;
    Plugin.RunMessageCProc := procRunMessageC;

    Result := TAThreatedModule.Create(Plugin);
    // Инициализируем и назначаем идентификатор
    Result.Initialize(Runtime.RegisterModule(Result), RuntimeRunMessage);
  except
    FreeLibrary(HLibrary);
  end;
end;

end.
