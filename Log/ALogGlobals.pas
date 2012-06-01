{**
@Abstract(Работа с Log. Классы для записи собщений программы в БД или файл или отображения в окне Log)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.08.2005)
@LastMod(26.04.2012)
@Version(0.5)

15.02.2012 - Вынес классы TProfLogDocument в ProfLogDocumentImpl.pas
}
unit ALogGlobals;

interface

uses
  Graphics,
  ATypes;

type //** Тип сообщений для записи в лог файл
  TLogTypeMessageColor = Graphics.TColor;
const
    //** неизвестно или неопределено
  ltNoneColor        = clBlack;
    //** ошибка
  ltErrorColor       = clRed;
    //** предупреждение
  ltWarningColor     = clYellow;
    //** сообщение
  ltInformationColor = clBlue;

const // -----------------------------------------------------------------------
  OLE_MESSAGE_GROUP: array[TLogGroupMessage] of EnumGroupMessage = (
      elgNone, elgNetwork, elgSetup, elgGeneral, elgDataBase, elgKey, elgEquipment, elgAlgorithm, elgSystem, elgUser, elgAgent
    );
  OLE_MESSAGE_TYPE: array[TLogTypeMessage] of EnumTypeMessage = (
      eltNone, eltError, eltWarning, eltInformation
    );
  OLE_NODE_STATUS: array[TLogNodeStatus] of EnumNodeStatus = (
      elsNone, elsOk, elsCancel, elsError, elsWarning, elsInformation
    );
  INT_LOG_TYPE: array[TLogType] of Integer = (
      int_lDocuments, int_lFile, int_lWindow, int_lLogSystem, int_lProgram, int_lUnknown, int_lTreeView
    );

// --- Functions ---

function GetLogTypeColor(ALogType: TLogTypeMessage): TLogTypeMessageColor;
function GetLogTypeStr(AType: TLogTypeMessage; Prefix, Postfix: WideString): WideString;

function IntToLogGroupMessage(Value: EnumGroupMessage): TLogGroupMessage;
function IntToLogTypeMessage(Value: EnumLogTypeMessage): TLogTypeMessage;
function IntToLogTypeSet(Value: Integer): TLogTypeSet;

implementation

function GetLogTypeColor(ALogType: TLogTypeMessage): TLogTypeMessageColor;
begin
  case ALogType of
    ltNone: Result := ltNoneColor;
    ltError: Result := ltErrorColor;
    ltWarning: Result := ltWarningColor;
    ltInformation: Result := ltInformationColor;
  else
    Result := ltNoneColor;
  end;
end;

function GetLogTypeStr(AType: TLogTypeMessage; Prefix, Postfix: WideString): WideString;
begin
  if AType = ltInformation then
    Result := Prefix + 'INF' + Postfix
  else if AType = ltError then
    Result := Prefix + 'ERR' + Postfix
  else if AType = ltWarning then
    Result := Prefix + 'WARN' + Postfix;
end;

function IntToLogGroupMessage(Value: EnumGroupMessage): TLogGroupMessage;
var
  tmp: TLogGroupMessage;
begin
  Result := lgNone;
  for tmp := Low(TLogGroupMessage) to High(TLogGroupMessage) do
  begin
    if OLE_GROUP_MESSAGE[tmp] = Value then
    begin
      Result := tmp;
      Exit;
    end;
  end;
end;

function IntToLogTypeMessage(Value: EnumLogTypeMessage): TLogTypeMessage;
var
  tmp: TLogTypeMessage;
begin
  Result := ltNone;
  for tmp := Low(TLogTypeMessage) to High(TLogTypeMessage) do
  begin
    if OLE_TYPE_MESSAGE[tmp] = Value then
    begin
      Result := tmp;
      Exit;
    end;
  end;
end;

function IntToLogTypeSet(Value: Integer): TLogTypeSet;
var
  tmp: TLogType;
begin
  Result := [];
  for tmp := Low(TLogType) to High(TLogType) do
  begin
    if (INT_LOG_TYPE[tmp] and Value = INT_LOG_TYPE[tmp]) then
      Result := Result + [tmp];
  end;
end;

end.
