{**
@Abstract AErrorTypes
@Author Prof1983 <prof1983@ya.ru>
@Created 22.09.2005
@LastMod 17.12.2012

Структура типа TError:
 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0
 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+---+---+-------+---------------+---------------+---------------+
|Sev|Pls|Place2 |               |    Function   |   Errror      |
+---+---+-------+---------------+---------------+---------------+}
{2бита - Sev - Тип ошибки: Info/Warning/Error/FatalError - severity (серьезность)
 2бита - Place - Место ошибки:
 |-0- Не известно
 |-1-SoftwareLocal - внутрення ошибка программы/модуля (eError - $90000000)
 |  4бита - Place2 - Расположение места ошибки
 |  1: I/O
 |    8бит
 |    1: File
 |      8бит - Function - Где произошла ошибка
 |      1: FileOpen
 |      2: FileClose
 |      3: FileRead
 |        1: Size=0
 |      4: FileWrite
 |        1: Size=0
 |      5: FileSize
 |-2-Software - ошибка, связанная с вызовом внешних функций
 |  4бита - Plase2 - какая Dll
 |-3-Hardware - ошибки оборудования
}
unit AErrorTypes;

interface

uses
  ABase, ABaseUtils3, ATypes;

type
  TErrorSeverity = type UInt32;
  {2бита - Sev - Тип ошибки: severity (серьезность)
   0 - Info
   1 - Warning
   2 - Error
   3 - FatalError
  }
  TErrorPlace = type UInt32; {2бита - Place - Место ошибки}
  {0 - Не известно
   1 - SoftwareLocal - внутрення ошибка программы/модуля (eError - $90000000)
   2 - Software - ошибка, связанная с вызовом внешних функций
   3 - Hardware - ошибки в работе оборудования
  }
  TErrorPlace2SoftLocal = type UInt32; {4бита - Plase2 - Расположение места ошибки}
  {1 - I/O - Ошибка ввода/вывода
  }
  TErrorPlaceApl = type UInt32; {8 бит. Приложение, в котором возникла ошибка}
  {0-не известно
   1-Cgi.Files
   2-KB
  }
  TErrorPlaceApl1Func = type UInt32; {8 бит. Функция, в которой возникла ошибка в программе Cgi.Files}
  {0-не известно
   1-ReferenceSet
  }
  TErrorPlaceApl1Finc1Error = type UInt32; {8 бит. Ошибка в Cgi.Files.ReferenceSet}
  {0-нет ошибки/не известно
   1-ошибка чтения из файла
   2-Type <> 3. Запись не ссылка.
   3-Ошибка записи в файл
  }
  TErrorPlaceApl2Func1Error = type UInt32; {8 бит. Ошибка в KB}
  {3-ошибка при закрытии
  }
  
type
  TErrorA = record
    Sev: TErrorSeverity;
    Place: TErrorPlace;
    Place2: TErrorPlace2SoftLocal;
    Apl: TErrorPlaceApl;
    Func: TErrorPlaceApl1Func;
    Er: TErrorPlaceApl1Finc1Error;
  end;

const
  ER_           = $C0000000; {Биты 31 и 30}
  ER_Info       = $00000000;
  ER_Warning    = $40000000; {Бит 30}
  ER_Error      = $80000000; {Бит 31}
  ER_FatalError = $C0000000; {Бит 30 и 31}

  ER_Place_              = $30000000;
  ER_Place_Uncnown       = $00000000;
  ER_Place_SoftwareLocal = $10000000;
  ER_Place_Software      = $20000000;
  ER_Place_Hardware      = $30000000;

  ER_Place2_             = $0F000000;
  ER_Place2_IO           = $01000000;
  ER_Place2_AR           = $02000000;

  ER_Place3_             = $00FF0000;

  ER_Func_               = $0000FF00;
  ER_Convert             = $00000100;
  ER_Wnd                 = $00000200;

  ER_AR                  = ER_Place_SoftwareLocal + ER_Place2_AR;
  ER_AR_PlaceDll         = $00010000;
  ER_AR_PlacePlugin      = $00020000;
  ER_AR_Dll              = ER_AR + ER_AR_PlaceDll;
  ER_AR_Plugin           = ER_AR + ER_AR_PlacePlugin;
  ER_AR_FuncClearAgents  = $00001100;
  ER_AR_FuncClearEvents  = $00001200;
  ER_AR_FuncClearPlugins = $00001400;
  ER_AR_FuncClearSources = $00001800;
  ER_AR_FuncSearchAgents = $00002100;
  ER_AR_FuncSearchEvents = $00002200;
  ER_AR_FuncSearchPlugins= $00002400;
  ER_AR_FuncSearchSources= $00002800;
  ER_AR_ClearAgents      = ER_AR_Dll + ER_AR_FuncClearAgents;
  ER_AR_ClearEvents      = ER_AR_Dll + ER_AR_FuncClearEvents;
  ER_AR_ClearPlugins     = ER_AR_Dll + ER_AR_FuncClearPlugins;
  ER_AR_ClearSources     = ER_AR_Dll + ER_AR_FuncClearSources;
  ER_AR_SearchAgents     = ER_AR_Dll + ER_AR_FuncSearchAgents;
  ER_AR_SearchEvents     = ER_AR_Dll + ER_AR_FuncSearchEvents;
  ER_AR_SearchPlugins    = ER_AR_Dll + ER_AR_FuncSearchPlugins;
  ER_AR_SearchSources    = ER_AR_Dll + ER_AR_FuncSearchSources;

  //Ко всем следующим ошибкам надо добавлять {+ER_AR_Dll or +ER_AR_Plugin}
  ER_AR_Info             = $00000100;
  ER_AR_Load             = $00000200;
  ER_AR_UnLoad           = $00000300;

  ER_AR_GetAgentInfo     = $00000400;
  ER_AR_GetCountAgents   = $00000500;
  {ER_AR_GetCountConnects = $00000600;}
  ER_AR_GetCountEvents   = $00000700;
  ER_AR_GetCountPlugins  = $00000800;
  ER_AR_GetCountSources  = $00000900;
  ER_AR_GetEventInfo     = $00000A00;
  ER_AR_GetPluginInfo    = $00000B00;
  ER_AR_GetSourceInfo    = $00000C00;

  ER_AR_Agent            = $00001000;
  ER_AR_Source           = $00002000;
  ER_AR_Event            = $00003000;
  ER_AR_Freim            = $00004000;
  ER_AR_Connect          = $00005000;
  ER_AR_Data             = $00006000;
  ER_AR_DataRead         = $00007000;
  ER_AR_DataWrite        = $00008000;

  ER_AR_AgentAdd         = ER_AR_Agent + $00000100;
  ER_AR_AgentClose       = ER_AR_Agent + $00000200;
  ER_AR_AgentDelete      = ER_AR_Agent + $00000300;
  ER_AR_AgentOpen        = ER_AR_Agent + $00000400;

  ER_AR_ConnectAdd       = ER_AR_Connect + $00000100;
  ER_AR_ConnectDelete    = ER_AR_Connect + $00000200;
  ER_AR_ConnectGet       = ER_AR_Connect + $00000300;

  ER_AR_EventConnect     = ER_AR_Event + $00000100;
  ER_AR_EventDisconect   = ER_AR_Event + $00000200;

  ER_AR_DataClear        = ER_AR_Data + $00000100;
  ER_AR_DataGetDataSize  = ER_AR_Data + $00000200;
  ER_AR_DataGetDataType  = ER_AR_Data + $00000300;

  ER_AR_DataReadBool     = ER_AR_DataRead + $00000100;
  ER_AR_DataReadFloat32  = ER_AR_DataRead + $00000200;
  ER_AR_DataReadFloat64  = ER_AR_DataRead + $00000300;
  ER_AR_DataReadInt08    = ER_AR_DataRead + $00000400;
  ER_AR_DataReadInt16    = ER_AR_DataRead + $00000500;
  ER_AR_DataReadInt32    = ER_AR_DataRead + $00000600;
  ER_AR_DataReadInt64    = ER_AR_DataRead + $00000700;
  ER_AR_DataReadUInt08   = ER_AR_DataRead + $00000800;
  ER_AR_DataReadUInt16   = ER_AR_DataRead + $00000900;
  ER_AR_DataReadUInt32   = ER_AR_DataRead + $00000A00;
  ER_AR_DataReadUInt64   = ER_AR_DataRead + $00000B00;

  ER_AR_DataWriteBool    = ER_AR_DataWrite + $00000100;
  ER_AR_DataWriteFloat32 = ER_AR_DataWrite + $00000200;
  ER_AR_DataWriteFloat64 = ER_AR_DataWrite + $00000300;
  ER_AR_DataWriteInt08   = ER_AR_DataWrite + $00000400;
  ER_AR_DataWriteInt16   = ER_AR_DataWrite + $00000500;
  ER_AR_DataWriteInt32   = ER_AR_DataWrite + $00000600;
  ER_AR_DataWriteInt64   = ER_AR_DataWrite + $00000700;
  ER_AR_DataWriteUInt08  = ER_AR_DataWrite + $00000800;
  ER_AR_DataWriteUInt16  = ER_AR_DataWrite + $00000900;
  ER_AR_DataWriteUInt32  = ER_AR_DataWrite + $00000A00;
  ER_AR_DataWriteUInt64  = ER_AR_DataWrite + $00000B00;

  ER_AR_FreimGetCountConnects  = ER_AR_Freim + $00000100;
  ER_AR_FreimGetDataSize       = ER_AR_Freim + $00000200;
  ER_AR_FreimGetDateTimeCreate = ER_AR_Freim + $00000300;
  ER_AR_FreimGetSource         = ER_AR_Freim + $00000400;
  ER_AR_FreimGetType           = ER_AR_Freim + $00000500;
  ER_AR_FreimSetSource         = ER_AR_Freim + $00000600;
  ER_AR_FreimSetType           = ER_AR_Freim + $00000700;

  ER_AR_SourceAdd        = ER_AR_Source + $00000100;
  ER_AR_SourceClose      = ER_AR_Source + $00000200;
  ER_AR_SourceDelete     = ER_AR_Source + $00000300;
  ER_AR_SourceOpen       = ER_AR_Source + $00000400;

const
  sER_Error             = 'Ошибка';
  sER_FatalError        = 'Критическая ошибка';
  sER_Info              = 'Info';
  sER_Ok                = 'Ok';
  sER_Warning           = 'Внимание';

  sER_Place_SoftwareLocal = 'SoftwareLocal';
  sER_Place_Software    = 'Software';
  sER_Place_Hardware    = 'Hardware';

  sER_AR                = 'AR';
  sER_AR_Dll            = sER_AR + '.Dll';
  sER_AR_Plugin         = sER_AR + '.Plugin';
  sER_AR_Info           = 'Info';
  sER_AR_Load           = 'Load';
  sER_AR_UnLoad         = 'UnLoad';

  sER_AR_ClearAgents      = 'ClearAgents';
  sER_AR_ClearEvents      = 'ClearEvents';
  sER_AR_ClearPlugins     = 'ClearPlugins';
  sER_AR_ClearSources     = 'ClearSources';
  sER_AR_SearchAgents     = 'SearchAgents';
  sER_AR_SearchEvents     = 'SearchEvents';
  sER_AR_SearchPlugins    = 'SearchPlugins';
  sER_AR_SearchSources    = 'SearchSources';

  sER_AR_GetAgentInfo     = 'GetAgentInfo';
  sER_AR_GetCountAgents   = 'GetCountAgents';
  {sER_AR_GetCountConnects = 'GetCountConnects';}
  sER_AR_GetCountEvents   = 'GetCountEvents';
  sER_AR_GetCountPlugins  = 'GetCountPlugins';
  sER_AR_GetCountSources  = 'GetCountSources';
  sER_AR_GetEventInfo     = 'GetEventInfo';
  sER_AR_GetPluginInfo    = 'GetPluginInfo';
  sER_AR_GetSourceInfo    = 'GetSourceInfo';

  sER_AR_Agent            = 'Agent';
  sER_AR_Source           = 'Source';
  sER_AR_Event            = 'Event';
  sER_AR_Freim            = 'Freim';
  sER_AR_Connect          = 'Connect';
  sER_AR_Data             = 'Data';
  sER_AR_DataRead         = 'DataRead';
  sER_AR_DataWrite        = 'DataWrite';

  sER_AR_AgentAdd         = sER_AR_Agent + '.Add';
  sER_AR_AgentClose       = sER_AR_Agent + '.Close';
  sER_AR_AgentDelete      = sER_AR_Agent + '.Delete';
  sER_AR_AgentOpen        = sER_AR_Agent + '.Open';

  sER_AR_ConnectAdd       = sER_AR_Connect + '.Add';
  sER_AR_ConnectDelete    = sER_AR_Connect + '.Delete';
  sER_AR_ConnectGet       = sER_AR_Connect + '.Get';

  sER_AR_EventConnect     = sER_AR_Event + '.Connect';
  sER_AR_EventDisconect   = sER_AR_Event + '.Disconnect';

  sER_AR_DataClear        = sER_AR_Data + '.Clear';
  sER_AR_DataGetDataSize  = sER_AR_Data + '.GetDataSize';
  sER_AR_DataGetDataType  = sER_AR_Data + '.GetDataType';

  sER_AR_DataReadBool     = sER_AR_DataRead + 'Bool';
  sER_AR_DataReadFloat32  = sER_AR_DataRead + 'Float32';
  sER_AR_DataReadFloat64  = sER_AR_DataRead + 'Float64';
  sER_AR_DataReadInt08    = sER_AR_DataRead + 'Int08';
  sER_AR_DataReadInt16    = sER_AR_DataRead + 'Int16';
  sER_AR_DataReadInt32    = sER_AR_DataRead + 'Int32';
  sER_AR_DataReadInt64    = sER_AR_DataRead + 'Int64';
  sER_AR_DataReadUInt08   = sER_AR_DataRead + 'UInt08';
  sER_AR_DataReadUInt16   = sER_AR_DataRead + 'UInt16';
  sER_AR_DataReadUInt32   = sER_AR_DataRead + 'UInt32';
  sER_AR_DataReadUInt64   = sER_AR_DataRead + 'UInt64';

  sER_AR_DataWriteBool    = sER_AR_DataWrite + 'Bool';
  sER_AR_DataWriteFloat32 = sER_AR_DataWrite + 'Float32';
  sER_AR_DataWriteFloat64 = sER_AR_DataWrite + 'Float64';
  sER_AR_DataWriteInt08   = sER_AR_DataWrite + 'Int08';
  sER_AR_DataWriteInt16   = sER_AR_DataWrite + 'Int16';
  sER_AR_DataWriteInt32   = sER_AR_DataWrite + 'Int32';
  sER_AR_DataWriteInt64   = sER_AR_DataWrite + 'Int64';
  sER_AR_DataWriteUInt08  = sER_AR_DataWrite + 'UInt08';
  sER_AR_DataWriteUInt16  = sER_AR_DataWrite + 'UInt16';
  sER_AR_DataWriteUInt32  = sER_AR_DataWrite + 'UInt32';
  sER_AR_DataWriteUInt64  = sER_AR_DataWrite + 'UInt64';

  sER_AR_FreimGetCountConnects  = sER_AR_Freim + '.GetCountConnects';
  sER_AR_FreimGetDataSize       = sER_AR_Freim + '.GetDataSize';
  sER_AR_FreimGetDateTimeCreate = sER_AR_Freim + '.GetDateTimeCreate';
  sER_AR_FreimGetSource         = sER_AR_Freim + '.GetSource';
  sER_AR_FreimGetType           = sER_AR_Freim + '.GetType';
  sER_AR_FreimSetSource         = sER_AR_Freim + '.SetSource';
  sER_AR_FreimSetType           = sER_AR_Freim + '.SetType';

  sER_AR_SourceAdd        = sER_AR_Source + '.Add';
  sER_AR_SourceClose      = sER_AR_Source + '.Close';
  sER_AR_SourceDelete     = sER_AR_Source + '.Delete';
  sER_AR_SourceOpen       = sER_AR_Source + '.Open';

function cErrorAToError(E: TErrorA): AError;
function cErrorAToStr(const E: TErrorA): String;
procedure cErrorToErrorA(Er: AError; var E: TErrorA);
function cErrorToStr(Er: AError): String;
function cErrorToStr2(Er: AError): String;

function ErrorToStr(Er: AError): String;

implementation

function StandartErrorARDll(Er: AError; var S: String): Boolean; forward;
function StandartErrorARPlugin(Er: AError; var S: String): Boolean; forward;
function StandartErrorSoftLocal(Er: AError; var S: String): Boolean; forward;

function StandartError(Er: AError; var S: String): Boolean;
begin
  Result := False;
  case (Er and ER_Place_) of
    ER_Place_SoftwareLocal: Result := StandartErrorSoftLocal(Er, S);
  end;
end;

function StandartErrorAR(Er: AError; var S: String): Boolean;
begin
  Result := False;
  case (Er and ER_Place3_) of
    ER_AR_PlaceDll: Result := StandartErrorARDll(Er, S);
    ER_AR_PlacePlugin: Result := StandartErrorARPlugin(Er, S);
  end;
end;

function StandartErrorARDll(Er: AError; var S: String): Boolean;
begin
  Result := True;
  case (Er and ER_Func_) of
    ER_AR_Info: S := sER_AR_Dll + sER_AR_Info;
    ER_AR_Load: S := sER_AR_Dll + sER_AR_Load;
    ER_AR_UnLoad: S := sER_AR_Dll + sER_AR_UnLoad;
    ER_AR_FuncClearAgents: S := sER_AR_Dll + sER_AR_ClearAgents;
    ER_AR_FuncClearEvents: S := sER_AR_Dll + sER_AR_ClearEvents;
    ER_AR_FuncClearPlugins: S := sER_AR_Dll + sER_AR_ClearPlugins;
    ER_AR_FuncClearSources: S := sER_AR_Dll + sER_AR_ClearSources;
    ER_AR_FuncSearchAgents: S := sER_AR_Dll + sER_AR_SearchAgents;
    ER_AR_FuncSearchEvents: S := sER_AR_Dll + sER_AR_SearchEvents;
    ER_AR_FuncSearchPlugins: S := sER_AR_Dll + sER_AR_SearchPlugins;
    ER_AR_FuncSearchSources: S := sER_AR_Dll + sER_AR_SearchSources;
  else
    Result := False;
  end;
end;

function StandartErrorARPlugin(Er: AError; var S: String): Boolean;
begin
  Result := True;
  case (Er and ER_Func_) of
    ER_AR_Info: S := sER_AR_Plugin + sER_AR_Info;
    ER_AR_Load: S := sER_AR_Plugin + sER_AR_Load;
    ER_AR_UnLoad: S := sER_AR_Plugin + sER_AR_UnLoad;
    ER_AR_FuncClearAgents: S := sER_AR_Plugin + sER_AR_ClearAgents;
    ER_AR_FuncClearEvents: S := sER_AR_Plugin + sER_AR_ClearEvents;
    ER_AR_FuncClearPlugins: S := sER_AR_Plugin + sER_AR_ClearPlugins;
    ER_AR_FuncClearSources: S := sER_AR_Plugin + sER_AR_ClearSources;
    ER_AR_FuncSearchAgents: S := sER_AR_Plugin + sER_AR_SearchAgents;
    ER_AR_FuncSearchEvents: S := sER_AR_Plugin + sER_AR_SearchEvents;
    ER_AR_FuncSearchPlugins: S := sER_AR_Plugin + sER_AR_SearchPlugins;
    ER_AR_FuncSearchSources: S := sER_AR_Plugin + sER_AR_SearchSources;
  else
    Result := False;
  end;
end;

function StandartErrorSoftLocal(Er: AError; var S: String): Boolean;
begin
  Result := False;
  case (Er and ER_Place2_) of
    ER_Place2_AR: Result := StandartErrorAR(Er, S);
  end;
end;

function _eUncnown(const E: TErrorA): String;
begin
  Result := '-Place2:'+cUInt32ToStr(E.Place2)+'-Apl:'+cUInt32ToStr(E.Apl)+'-Func:'+cUInt32ToStr(E.Func)+'-Er:'+cUInt32ToStr(E.Er);
end;

function _eHard(const E: TErrorA): String;
begin
  Result := '-Hard-'+_eUncnown(E);
end;

function _eSoft(const E: TErrorA): String;
begin
  Result := '-Soft-'+_eUncnown(E);
end;

function _eSoftLocal(const E: TErrorA): String;
begin
  case E.Place2 of
    1: Result := '-Cgi.Files'+_eUncnown(E);
    2: Result := '-KB.dll'+_eUncnown(E);
  else
    Result := _eUncnown(E);
  end;
end;

(*function eIO(Sev: TErrorSeverity = 2): TError;
var
  E: TErrorA;
begin
  E.Sev := Sev;
  E.Place := 1;
  E.Place2 := 0;
  E.Apl := 0;
  E.Func := 0;
  E.Er := 0;
  Result := cErrorAToError(E);
end;

function eKB(Sev: TErrorSeverity = 2; Er: TErrorPlaceApl2Func1Error = 0): TError;
var
  E: TErrorA;
begin
  E.Sev := Sev;
  E.Place := 1;
  E.Place2 := 1;
  E.Apl := 2;
  E.Func := 0;
  E.Er := Er;
  Result := cErrorAToError(E);
end;

function eMath(Sev: TErrorSeverity = 2): TError;
var
  E: TErrorA;
begin
  E.Sev := Sev;
  E.Place := 1;
  E.Place2 := 0;
  E.Apl := 0;
  E.Func := 0;
  E.Er := 0;
  Result := cErrorAToError(E);
end;

function eMem: TError;
var
  E: TErrorA;
begin
  E.Sev := 2;
  E.Place := 1;
  E.Place2 := 0;
  E.Apl := 0;
  E.Func := 0;
  E.Er := 0;
  Result := cErrorAToError(E);
end;

function eParam: TError;
var
  E: TErrorA;
begin
  E.Sev := 2;
  E.Place := 1;
  E.Place2 := 0;
  E.Apl := 0;
  E.Func := 0;
  E.Er := 0;
  Result := cErrorAToError(E);
end;

function ePChar: TError;
var
  E: TErrorA;
begin
  E.Sev := 2;
  E.Place := 1;
  E.Place2 := 0;
  E.Apl := 0;
  E.Func := 0;
  E.Er := 0;
  Result := cErrorAToError(E);
end;

function eReg: TError;
var
  E: TErrorA;
begin
  E.Sev := 2;
  E.Place := 1;
  E.Place2 := 0;
  E.Apl := 0;
  E.Func := 0;
  E.Er := 0;
  Result := cErrorAToError(E);
end;

function eSoftwareLocal(E: TErrorA): TError;
begin
  E.Place := 1;
  E.Place2 := 1;
  Result := cErrorAToError(E);
end;

function eStr: TError;
var
  E: TErrorA;
begin
  E.Sev := 2;
  E.Place := 1;
  E.Place2 := 0;
  E.Apl := 0;
  E.Func := 0;
  E.Er := 0;
  Result := cErrorAToError(E);
end;

function eThread: TError;
var
  E: TErrorA;
begin
  E.Sev := 2;
  E.Place := 1;
  E.Place2 := 0;
  E.Apl := 0;
  E.Func := 0;
  E.Er := 0;
  Result := cErrorAToError(E);
end;

function eWnd: TError;
var
  E: TErrorA;
begin
  E.Sev := 2;
  E.Place := 1;
  E.Place2 := 0;
  E.Apl := 0;
  E.Func := 0;
  E.Er := 0;
  Result := cErrorAToError(E);
end;*)

{function eCgiFiles(Sev: TErrorSeverity; Func: TErrorPlaceApl1Func; Er: TErrorPlaceApl1Finc1Error): TError;
var
  E: TErrorA;
begin
  E.Sev := Sev;
  E.Place := 0;
  E.Place2 := 0;
  E.Apl := 1;
  E.Func := 1;
  E.Er := Er;
  Result := eSoftwareLocal(E);
end;

function eCgiFilesReferenceSet(Sev: TErrorSeverity; Er: TErrorPlaceApl1Finc1Error): TError;
begin
  Result := eCgiFiles(Er, 1, Er);
end;}

function cErrorAToError(E: TErrorA): AError;
begin
  Result := (E.Sev shl 30) or
            (E.Place shl 30 shr 2) or
            (E.Place2 shl 28 shr 4) or
            (E.Apl shl 24 shr 8) or
            (E.Func shl 24 shr 16) or
            (E.Er shl 24 shr 24);
end;

function cErrorAToStr(const E: TErrorA): String;
begin
  if (E.Sev = 0) and (E.Place = 0) and (E.Place2 = 0) and (E.Apl = 0) and (E.Func = 0) and (E.Er = 0) then begin Result := 'Ok'; Exit; end;
  case E.Sev of
    0: Result := SEr_Info;
    1: Result := SEr_Warning;
    2: Result := SEr_Error;
  else
    Result := SEr_FatalError;
  end;
  case (E.Place) of
    {0: strAdd(Result, '-Uncnown');}
    1: Result := Result + '-SoftwareLocal'+_eSoftLocal(E);
    2: Result := Result + '-Software' + _eSoft(E);
    3: Result := Result + '-Hardware' + _eHard(E);
  else
    strAdd(Result, '-Uncnown'+_eUncnown(E));
  end;
end;

procedure cErrorToErrorA(Er: AError; var E: TErrorA);
begin
  E.Sev := Er shr 30;
  E.Place := Er shl 2 shr 30;
  E.Place2 := Er shl 4 shr 28;
  E.Apl := Er shl 8 shr 24;
  E.Func := Er shl 16 shr 24;
  E.Er := Er shl 24 shr 24;
end;

function cErrorToStr(Er: AError): String;
begin
  case Er and ER_ of
    ER_Info: if Er = 0 then Result := 'Ok' else Result := SEr_Info + '(' + cUInt32ToStr(Er) + ')';
    ER_Warning: Result := sER_Warning;
    ER_Error: Result := sER_Error;
  else
    Result := sER_FatalError;
  end;
  {if Er = 0 then Result := SEr_Ok else Result := cUInt32ToStr(Er);
  ErrorUMyBaseConvert := 0;}
end;

function cErrorToStr2(Er: AError): String;
var
  S: String;
begin
  Result := cErrorToStr(Er);

  if (Er and $3FFFFFFF = 0) then Exit;

  if StandartError(Er, S) then begin
    Result := Result + ' in ' + S;
    Exit;
  end;

  case (Er and ER_Place_) of
    ER_Place_SoftwareLocal: Result := Result + '.' + sER_Place_SoftwareLocal + '(' + cInt32ToStr(Er and $00FFFFFF) + ')';
    ER_Place_Software: Result := Result + '.' + sER_Place_Software + '(' + cInt32ToStr(Er and $00FFFFFF) + ')';
    ER_Place_Hardware: Result := Result + '.' + sER_Place_Hardware + '(' + cInt32ToStr(Er and $00FFFFFF) + ')';
  else {ER_Place_Uncnown}
    Result := Result + '(' + cInt32ToStr(Er and $00FFFFFF) + ')';
  end;

  (*case (Er and ER_Place_) of {Info}
    0: Result := 'Ok';
    $11010301: Result := 'Info-SoftwareLocal-IO-File-ioFileRead: Параметр Size = 0';
    $11010401: Result := 'Info-SoftwareLocal-IO-File-ioFileWrite: Параметр Size = 0';
  else
    Result := 'Info(' + cUInt032ToStr(Er) + ')';
  end;
  case (Er and $3FFF0000) of {Warning}
      $12010000: Result := 'Warning-SoftwareLocal-Конвертация типов (модуль UMyBaseConvert)-UInt032ToStr-Значение превышает 2^31';
  else
      Result := 'Внимание(' + cUInt032ToStr(Er and $3FFFFFFF) + ')';
  end;
  case (Er and $3FFFFFFF) of {Error}
      $11010501: Result := 'Error-SoftwareLocal-IO-File-ioFileSize: GetLastError <> 0';
      $21010500: Result := 'Error-Software-IO-File-GetFileSize: Uncnown';
  else
      {case (Er and $FFFF) of}
  end;*)
end;

function ErrorToStr(Er: AError): String;
begin
  Result := cErrorToStr(Er);
end;

end.
