{**
@Abstract(Обьект для хранения списка подключенных клиентов)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.04.2006)
@LastMod(10.05.2012)
@Version(0.5)
}
unit AConnectedAccount;

interface

uses
  Classes, SysUtils, Windows,
  ATypes;

type //** @abstract(Обьект для хранения списка подключенных клиентов)
  TProfConnectedAccount = class
  private
    FCSMain: TRTLCriticalSection;
    FList: TStringList;
    FOnAddToLog: TProcAddToLog;
    function GetCount(): integer;
  protected
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
  public
    constructor Create();
    destructor Destroy; override;
  public
      //** Добавить клиента к списку
    function Add(const AAccount: string): boolean;
      //** Удалить клиента из списка
    function Delete(const AAccount: string): boolean;
      //** Проверить что указанный клиент существует в списке
    function IsExists(const AAccount: string): boolean;
      //** Количество клиентов подключенных к модулю
    property Count: integer read GetCount;
    property OnAddToLog: TProcAddToLog read FOnAddToLog write FOnAddToLog;
  end;

implementation

resourcestring
  info_ConnectNewAccount      = 'К модулю подключился новый пользователь: "%s".';
  info_DisconnectAccount      = 'Пользователь отключился от модуля: "%s".';

{ TProfConnectedAccount }

function TProfConnectedAccount.Add(const AAccount: string): boolean;
var
  tmpIndex: Integer;
begin
  Result := True;
  EnterCriticalSection(FCSMain);
  try
    tmpIndex := FList.IndexOf(AAccount);
    if (tmpIndex >= 0) then
      FList.Objects[tmpIndex] := Pointer(Integer(FList.Objects[tmpIndex]) + 1)
    else
    begin
      tmpIndex := FList.Add(AAccount);
      FList.Objects[tmpIndex] := Pointer(1);
      AddToLog(lgNetwork, ltInformation, info_ConnectNewAccount); //, [AAccount]);
    end;
  finally
    LeaveCriticalSection(FCSMain);
  end;
end;

function TProfConnectedAccount.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  Result := -1;
  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(AGroup, AType, AStrMsg);
  except
  end;
end;

constructor TProfConnectedAccount.Create();
begin
  inherited Create();
  InitializeCriticalSection(FCSMain);
  FList := TStringList.Create();
end;

function TProfConnectedAccount.Delete(const AAccount: string): boolean;
var
  tmpIndex: Integer;
begin
  Result := False;
  EnterCriticalSection(FCSMain);
  try
    tmpIndex := FList.IndexOf(AAccount);
    if (tmpIndex >= 0) then
    begin
      FList.Objects[tmpIndex] := Pointer(Integer(FList.Objects[tmpIndex]) - 1);
      if (Integer(FList.Objects[tmpIndex]) = 0) then
      begin
        FList.Delete(tmpIndex);
        AddToLog(lgNetwork, ltInformation, info_DisconnectAccount); //[AAccount]);
        Result := True;
      end;
    end;
  finally
    LeaveCriticalSection(FCSMain);
  end;
end;

destructor TProfConnectedAccount.Destroy();
begin
  DeleteCriticalSection(FCSMain);
  FreeAndNil(FList);
  inherited;
end;

function TProfConnectedAccount.GetCount(): integer;
begin
  EnterCriticalSection(FCSMain);
  try
    Result := FList.Count;
  finally
    LeaveCriticalSection(FCSMain);
  end;
end;

function TProfConnectedAccount.IsExists(const AAccount: string): boolean;
begin
  EnterCriticalSection(FCSMain);
  try
    Result := (FList.IndexOf(AAccount) >= 0);
  finally
    LeaveCriticalSection(FCSMain);
  end;
end;

end.
