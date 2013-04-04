{**
@Abstract Модуль работы с базами и структурами данных
@Author Prof1983 <prof1983@ya.ru>
@Created 13.10.2008
@LastMod 04.04.2013
}
unit ADataTypes;

interface

uses
  ABase;

const
  ADataBdeGuid: TGuid = '{3A401EE1-A8DC-421F-9048-E8FC1CDC5EC1}';
  BdeDriverName: string = 'Bde';

const
  ADataFibGuid: TGuid = '{724541D0-31DD-4632-AAEC-BA52F3C3C3A9}';
  FibDriverName: string = 'Fib';

// --- Types ---------------------------------------------------------------------------------------

type
  TAFieldType = (
    aftUnknown  = 0,
    aftString   = 1,
    aftSmallInt = 2,
    aftInteger  = 3,
    aftInt64    = 4,
    aftNumeric  = 5,
    aftBoolean  = 6,
    aftFloat    = 7,
    aftDate     = 8,
    aftTime     = 9,
    aftDateTime = 10,
    aftAutoInc  = 11,
    aftBlob     = 12,
    aftMemo     = 13  // VARCHAR
    );

type // Тип индекса
  TAIndexType = (
    idxNotUniqum = 0,
    idxUniqum    = 1,
    idxPrimary   = 2
    );

type
  TAJoinType = (
    jtInner      = 0,
    jtLeftOuter  = 1,
    jtRightOuter = 2,
    jtOuter      = 3
    );

type // Тип доступа внешних пользователей
  TATableAccess = (
    tbNone      = 0,
    tbRead      = 1,
    tbWrite     = 2,
    tbReadWrite = 3
    );

// --- Structure ---

type
  AFieldStructure = type AInt;

type
  AIndexStructure = type AInt;

// --- Procs ---

type
  ADataDriverGetProc_Proc = function(ProcName: AStr): Pointer; stdcall;

implementation

end.
