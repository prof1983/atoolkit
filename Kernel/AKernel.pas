{**
@Abstract(Микроядро)
@Author(Prof1983 prof1983@ya.ru)
@Created(12.03.2008)
@LastMod(05.07.2011)
@Version(0.5)

Задачи микроядра (Kernel):
- Создавать подпроцессы-обертки для модулей(компонент).
- Загружать модули из DLL файлов и создавать обертки для них.
-- Загружать модули ActiveX и содавать обертки для них.
}
unit AKernel;

// TODO: Переделать функционал.

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
    {**
      @abstract(Следующий идентификатор сообщения)
      Начинается с 1. При достижении максимального
      значения счетчик сбрасывается и нумерация начинается опять с 1.
    }
    property NextMessageID: TAMessageID read GetNextMessageID;
  public
    class function KernelIsWorking(): Integer;
  end;

//function AKernel_InitKernel(): Integer;
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

{function AKernel_InitKernel(): Integer;
begin
  if not(Assigned(Kernel)) then
  begin
    Kernel := TAKernel.Create();
    Result := Kernel.Initialize();
  end
  else
    Result := 0;
end;}
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
  // Уничтожаем все присоединенные модули
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

  {if Length(FModules) > 0 then
  begin

    //Result := FModules[0].RunMessageA(cmdCoreGetIsWorking, 0, nil);
    //if (Result = rFalse) then
    //  MessageBox(0, PChar('Kernel.IsWorking = False'), PChar('Assistant'), MB_OK);
  end
  else
    Result := rFalse;}
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
//var
//  m: TAModuleClient;
begin
  Result := 0;
  // Инициализируем - загружаем микроядро
  {m := LoadModule(AssistantCore32);
  if Assigned(m) then
  begin
    AddModule(m);
    Result := m.Initialize(midKernel);
  end;}
end;

class function TAKernel.KernelIsWorking(): Integer;
begin
  if Assigned(Kernel) then
    Result := Kernel.IsWorking
  else
    Result := rModuleNotInitialized;
end;

{function TAKernel.LoadModule(FileName: string): TAssistantPluginClient;
var
  hLibrary: Integer;
  procGetVersion: TAssistantGetVersionProc;
  procRunMessage: TAssistantRunMessageProc;
  ver: TAssistantVersion;
begin
  Result := nil;
  hLibrary := LoadLibrary(PChar(FileName));
  if (hLibrary > 32) then
  begin
    // Получаем адреса функций ядра
    procGetVersion := GetProcAddress(hLibrary, 'GetVersion');
    procRunMessage := GetProcAddress(hLibrary, 'RunMessage');

    // Проверяем адреса функций ядра
    if Assigned(Addr(procGetVersion)) and Assigned(Addr(procRunMessage)) then
    try
      // Проверяем версию ядра
      ver := procGetVersion();
      if (ver and AssistantVersionMask = AssistantPlatformVersion) then
      begin
        Result := TAssistantPluginClient.Create();
        Result.Handle := hLibrary;
        Result.GetVersionProc := procGetVersion;
        Result.RunMessageProc := procRunMessage;
      end;
    except
      FreeLibrary(hLibrary);
    end;
  end;
end;}

function TAKernel.LoadPlugin(PluginFileName: string): TAThreatedModule;
var
  HLibrary: Integer;
  Version: AVersion;
  Plugin: TAPluginClient;
  procGetVersion: TAGetVersionProc;
  procRunMessage: TAModuleRunMessageProc;
  procRunMessageC: TAComponentRunMessageProc;
begin
  //MessageBox(0, PChar(PluginFileName), 'LoadPlugin', MB_OK);
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
    //Plugin.ModuleID := GetNextModuleID();
  except
    FreeLibrary(HLibrary);
  end;
end;

end.
