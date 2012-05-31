{**
@Abstract(Класс для работы с динамическими библиотеками .dll)
@Author(Prof1983 prof1983@ya.ru)
@Created(02.10.2005)
@LastMod(03.05.2012)
@Version(0.5)
}
unit ALibraryObj;

interface

uses
  Windows,
  ATypes;

type
  TProfLibrary = class(TInterfacedObject)
  private
    FFileName: WideString;     // Имя файла .dll
    FHandle: HMODULE;          // Идентификатор
    FOnAddToLog: TProfAddToLog;
    function GetIsLoaded(): Boolean;
    procedure SetFileName(const AFileName: WideString);
  protected
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
  public
    constructor Create(AAddToLog: TProfAddToLog = nil);
    // Закрывает библиотеку
    function Finalize(): WordBool; virtual;
    procedure Free(); virtual;
    // Возвращает адрес функции
    {$IFNDEF VER170}
    function GetProcAddress(const AName: WideString): Pointer;
    {$ELSE}
    function GetProcAddress(const AName: WideString): IntPtr;
    {$ENDIF}
    // Идентификатор
    property Handle: HMODULE read FHandle;
    // Открывает библиотеку
    function Initialize(): WordBool; virtual;
    // True, если библиотека открыта
    property IsLoaded: Boolean read GetIsLoaded;
    // Открывает библиотеку
    function LoadLibrary(const AFileName: WideString): Boolean;
    property OnAddToLog: TProfAddToLog read FOnAddToLog write FOnAddToLog;
  published
    // Имя файла .dll
    property FileName: WideString read FFileName write SetFileName;
  end;

resourcestring // Сообщения ----------------------------------------------------
  stFinalize_Already   = 'Уже финализировано';
  stFinalize_Ok        = 'Финализировано';
  stFinalize_Start     = 'Финализация библиотеки Handle=%d';
  stInitialize_Already = 'Уже инициализировано <%s.%s>';
  stInitialize_Handle  = 'Ошибка при инициализации. Не правильное значение Handle=%d Error=%d <%s.%s>';
  stInitialize_Ok      = 'Инициализировано <%s.%s>';
  stInitialize_Start   = 'Инициализация библиотеки "%s" <%s.%s>';

implementation

{ TProfLibrary }

function TProfLibrary.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := -1;
  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(AGroup, AType, AStrMsg, AParams);
  except
  end;
end;

constructor TProfLibrary.Create(AAddToLog: TProfAddToLog = nil);
begin
  inherited Create();
  FHandle := 0;
  FOnAddToLog := AAddToLog;
end;

function TProfLibrary.Finalize(): WordBool;
begin
  AddToLog(lgGeneral, ltInformation, stFinalize_Start, [FHandle]);
  Result := True;
  if FHandle = 0 then
  begin
    AddToLog(lgGeneral, ltInformation, stFinalize_Already, []);
    Exit;
  end;
  try
    FreeLibrary(FHandle);
  except
  end;
  FHandle := 0;
  AddToLog(lgGeneral, ltInformation, stFinalize_Ok, []);
end;

procedure TProfLibrary.Free();
begin
  Finalize();
  inherited Free();
end;

function TProfLibrary.GetIsLoaded(): Boolean;
begin
  Result := (FHandle > 32);
end;

{$IFNDEF VER170}
function TProfLibrary.GetProcAddress(const AName: WideString): Pointer;
var
  P: PChar;
begin
  P := PChar(string(AName));
  Result := Windows.GetProcAddress(FHandle, P);
  if Assigned(Result) then
    AddToLog(lgGeneral, ltInformation, 'Адрес процедуры "%s" из модуля "%s" получен', [AName, FFileName])
  else
    AddToLog(lgGeneral, ltError, 'Адрес процедуры "%s" не получен. Модуль "%s"', [AName, FFileName]);
end;
{$ELSE}
function TProfLibrary.GetProcAddress(const AName: WideString): IntPtr;
begin
  Result := Windows.GetProcAddress(FHandle, AName);
end;
{$ENDIF}

function TProfLibrary.Initialize(): WordBool;
var
  Error: LongWord;
  P: PChar;
begin
  AddToLog(lgGeneral, ltInformation, stInitialize_Start, [FFileName, ClassName, 'Initialize']);
  if FHandle > 0 then
  begin
    AddToLog(lgGeneral, ltInformation, stInitialize_Already, [ClassName, 'Initialize']);
    Result := True;
    Exit;
  end;
  Result := False;
  if FFileName = '' then Exit;
  {$IFNDEF VER170}
  P := PChar(string(FFileName));
  FHandle := Windows.LoadLibrary(P);
  {$ELSE}
  FHandle := Windows.LoadLibrary(FFileName);
  {$ENDIF}
  if FHandle <= 32 then
  begin
    Error := GetLastError;
    AddToLog(lgGeneral, ltError, stInitialize_Handle, [FHandle, Error, ClassName, 'Initialize']);
    FHandle := 0;
    Exit;
  end;
  Result := True;
  AddToLog(lgGeneral, ltInformation, stInitialize_Ok, [ClassName, 'Initialize']);
end;

function TProfLibrary.LoadLibrary(const AFileName: WideString): Boolean;
begin
  FFileName := AFileName;
  Result := Initialize;
end;

procedure TProfLibrary.SetFileName(const AFileName: WideString);
begin
  if (FHandle > 0) then Exit;
  FFileName := AFileName;
end;

end.
