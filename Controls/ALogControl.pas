{**
@Abstract Контрол для вывода сообщений программы в TreeView
@Author Prof1983 <prof1983@ya.ru>
@Created 24.10.2006
@LastMod 19.12.2012
}
unit ALogControl;

interface

uses
  ComCtrls, Controls, SysUtils,
  ABase,
  ALogDocumentImpl,
  ALogGlobals,
  ALogUtils,
  ATypes;

type //** Контрол для вывода сообщений программы в TreeView
  TProfLogControl = class(TLogDocument)
  private
    FControl: TWinControl;
    FNodes: array of record
      ID: Integer;
      Node: TTreeNode;
    end;
    FTreeView: TTreeView;
  public
    function AddNode(AType: TLogTypeMessage; AID, AParentID: Integer; const AStr: WideString): TTreeNode;
      //** Добавить лог-сообщение
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; override;
    constructor Create(AControl: TWinControl);
      //** Инициализировать
    function Initialize(): AError; override;
  end;

implementation

{ TLogControl }

function TProfLogControl.AddNode(AType: TLogTypeMessage; AID, AParentID: Integer; const AStr: WideString): TTreeNode;

  procedure Add();
  var
    I: Integer;
    tmpStr: WideString;
  begin
    tmpStr := FormatDateTime('nn:ss:zzzz', Now) + ' ' + AStr;
    if AParentId = 0 then
      Result := FTreeView.Items.AddFirst(nil, tmpStr)
    else
    begin
      for I := 0 to High(FNodes) do if FNodes[I].ID = AParentID then
      begin
        Result := FTreeView.Items.AddChildFirst(FNodes[I].Node, tmpStr);
        Exit;
      end;
      Result := FTreeView.Items.AddFirst(nil, tmpStr);
    end;
  end;

var
  I: Integer;
begin
  // Очистка
  if Length(FNodes) > 10000 then
  begin
    SetLength(FNodes, 0);
    FTreeView.Items.Clear();
  end;
  // Добавление новой записи
  I := Length(FNodes);
  SetLength(FNodes, I + 1);
  FNodes[I].Id := AId;
  Add();
  FNodes[I].Node := Result;
  FNodes[I].Node.ImageIndex := GetLogImageIndex(AType);
end;

function TProfLogControl.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
var
  S: string;
begin
  //S := '[' + CHR_LOG_TYPE_MESSAGE[AType] + '] ' +
  //   CHR_LOG_GROUP_MESSAGE[AGroup] + ': ' + AStrMsg;
  S := AStrMsg;
  AddNode(AType, 0, 0, S);
  Result := 1;
end;

constructor TProfLogControl.Create(AControl: TWinControl);
begin
  inherited Create(lTreeView);
  FControl := AControl;
end;

function TProfLogControl.Initialize(): AError;
begin
  Result := inherited Initialize();
  if not(Assigned(FTreeView)) then FTreeView := TTreeView.Create(FControl);
  FTreeView.Parent := FControl;
  FTreeView.Align := alClient;
  //FTreeView.Images := RunImages;
  //FTreeView.PopupMenu := PopupMenu;
end;

end.
