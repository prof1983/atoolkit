{**
@Abstract(Работа с Log. Классы для записи собщений программы в БД или файл или отображения в окне Log)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.08.2005)
@LastMod(13.06.2012)
@Version(0.5)

TLogNode - нод логирования - элемент дерева логирования
Delphi 5, 7, 2005
}
unit ALogGlobals2006;

interface

uses
  ComObj, SysUtils,
  ALogDocumentIntf, ALogNodeIntf, AMessageConst, ATypes;

const
  int_lDocuments = 1;   // TLogDocuments - записывает сразу в несколько мест
  int_lFile      = 2;   // Записывать в файл
  int_lWindow    = 4;   // Показывать в окне
  int_lLogSystem = 8;   // Подключаться к сервису логирования AR_LogSystem
  int_lProgram   = 16;  // Выводить в лог программы (класс TProgram)
  int_lUnknown   = 32;  // Uncnown

type // Конфигурации документа логирования
  //TConfigLogDocument = IProfNode;
  TLogDocument = TALogDocument2;
  TLogNode = TALogNode2;

type // Документ записи/обображения Log
  TLogDocumentA = class(TLogDocument)
  private
    FNodes: array of TLogNode;
  public
    function GetNodeById(Id: Integer): TLogNode; override;
    function NewNode(AType: TLogTypeMessage; const AMsg: WideString; AParent: Integer = 0; AId: Integer = 0): TLogNode; override;
    function AddNode(ANode: TLogNode): Boolean;
    function GetFreeId(): Integer;
  end;

const // -----------------------------------------------------------------------
  OLE_MESSAGE_GROUP: array[TLogGroupMessage] of EnumGroupMessage = (
      elgNone, elgNetwork, elgSetup, elgGeneral, elgDataBase, elgKey, elgEquipment, elgAlgorithm, elgSystem, elgUser, elgAgent
    );
  OLE_MESSAGE_TYPE: array[TLogTypeMessage] of EnumTypeMessage = (eltNone, eltError, eltWarning, eltInformation);
  OLE_NODE_STATUS: array[TLogNodeStatus] of StatusNodeEnum = (elsNone, elsOk, elsCancel, elsError, elsWarning, elsInformation);
  INT_LOG_TYPE: array[TLogType] of Integer = (
      int_lDocuments, int_lFile, int_lWindow, int_lLogSystem, int_lProgram, int_lTreeView, int_lUnknown
    );

function IntToLogTypeSet(Value: Integer): TLogTypeSet;

implementation

// -----------------------------------------------------------------------------
function IntToLogTypeSet(Value: Integer): TLogTypeSet;
var
  tmp: TLogType;
begin
  Result := [];
  for tmp := Low(TLogType) to High(TLogType) do
    if (INT_LOG_TYPE[tmp] and Value = INT_LOG_TYPE[tmp]) then
      Result := Result + [tmp];
end;

{ TLogDocumentA }

function TLogDocumentA.AddNode(ANode: TLogNode): Boolean;
var
  I: Integer;
begin
  I := Length(FNodes);
  SetLength(FNodes, I + 1);
  FNodes[I] := ANode;
  Result := True;
end;

function TLogDocumentA.GetFreeId: Integer;
begin
  Result := Length(FNodes) + 1;
end;

function TLogDocumentA.GetNodeById(Id: Integer): TLogNode;
var
  I: Integer;
begin
  for I := 0 to High(FNodes) do if FNodes[I].Id = Id then
  begin
    Result := FNodes[I];
    Exit;
  end;
  Result := nil;
end;

function TLogDocumentA.NewNode(AType: TLogTypeMessage; const AMsg: WideString; AParent: Integer = 0; AId: Integer = 0): TLogNode;
var
  S: string;
begin
  DateTimeToString(S, 'dd.mm.yyyy hh:mm:ss', Now);
  S := S + ' ' + AMsg;
  if AId = 0 then AId := GetFreeId;
  Result := TLogNode.Create(Self, AParent, S, AId);
  AddNode(Result);
end;

end.
