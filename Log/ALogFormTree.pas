{**
@Abstract(Окно вывода сообщений программы в виде дерева)
@Author(Prof1983 prof1983@ya.ru)
@Created(13.10.2005)
@LastMod(04.07.2012)
@Version(0.5)
}
unit ALogFormTree;

interface

uses
  Classes, ComCtrls, Controls, ExtCtrls, Forms, StdCtrls, SysUtils,
  ALogShablon, ATypes,
  fShablon;

type //** Окно вывода сообщений программы в виде дерева
  TProfLogTreeForm = class(TfmLogShablon)
    //** Очистить содержимое
    procedure NClearClick(Sender: TObject);
  private
    FMemoCommand: TMemo;
    FNodes: array of record
      ID: Integer;
      Node: TTreeNode;
    end;
    FOnCommand: TProcMessageStr;
    FProgressPanel: TPanel;
    FTreeView: TTreeView;
    procedure CommandKeyPress(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    procedure DoCreate(); override;
    function GetOnCommand(): TProcMessageStr; override;
    procedure SetOnCommand(Value: TProcMessageStr); override;
  public
    //** Добавить Node
    function AddNode(AType: TLogTypeMessage; AId, AParentId: Integer; const AStr: WideString): TTreeNode;
    //** Добавить сообщение
    procedure AddMsg(const AMsg: WideString); //override; safecall;
    //** Добавить строку
    procedure AddStr(const AStr: WideString); //override; safecall;
    //** Добавить лог-сообщение
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; override; {safecall;}
  public
    property TreeView: TTreeView read FTreeView;
  end;

implementation

const
  LOG_DELIMER1 = '----------------------------------------------------------------';
  LOG_DELIMER2 = '================================================================';

function GetLogImageIndex(LogType: TLogTypeMessage): Integer;
begin
  case LogType of
    ltInformation: Result := IndexGreenBox;
    ltWarning: Result := IndexFuchsiaBox;
    ltError: Result := IndexRedBox;
  else
    Result := -1;
  end;
end;

{ TFormLog }

function TProfLogTreeForm.AddNode(AType: TLogTypeMessage; AId, AParentId: Integer; const AStr: WideString): TTreeNode;

  procedure Add();
  var
    I: Integer;
    tmpStr: WideString;
  begin
    tmpStr := FormatDateTime('nn:ss:zzzz', Now) + ' ' + AStr;
    if AParentId = 0 then
    begin
      //AddMsg(AStr)
      Result := FTreeView.Items.AddFirst(nil, tmpStr);
    end
    else
    begin
      for I := 0 to High(FNodes) do if FNodes[I].Id = AParentId then
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

procedure TProfLogTreeForm.AddMsg(const AMsg: WideString);
var
  tmpStr: WideString;
begin
  if AMsg = '-' then
    tmpStr := LOG_DELIMER1
  else if AMsg = '=' then
    tmpStr := LOG_DELIMER2
  else
    tmpStr := AMsg;

  AddStr(FormatDateTime('nn:ss:zzzz', Now) + ' ' + tmpStr);
end;

procedure TProfLogTreeForm.AddStr(const AStr: WideString);
var
  tmpStr: WideString;
begin
  if AStr = '-' then
    tmpStr := LOG_DELIMER1
  else if AStr = '=' then
    tmpStr := LOG_DELIMER2
  else
    tmpStr := AStr;

  FTreeView.Items.Add(nil, tmpStr);
end;

function TProfLogTreeForm.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
var
  s: string;
begin
  //S := '[' + CHR_LOG_TYPE_MESSAGE[AType] + '] ' +
  //   CHR_LOG_GROUP_MESSAGE[AGroup] + ': ' + AStrMsg;
  s := AStrMsg;
  AddNode(AType, 0, 0, s);
  Result := 1;
end;

procedure TProfLogTreeForm.CommandKeyPress(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 13) and not(ssCtrl in Shift) then
  begin
    if FMemoCommand.Text = '' then Exit;
    AddToLog(lgNone, ltInformation, 'Команда "'+FMemoCommand.Text+'"');
    if Assigned(FOnCommand) then
    try
      {// Разбор строки
      if FMemoCommand.Text[1] <> '<' then
        c := '<' + FMemoCommand.Text + ' />'
      else
        c := FMemoCommand.Text;
      GetNameAndAttributes(...);}

      FOnCommand(FMemoCommand.Text);
    except
    end;
  end;
end;

procedure TProfLogTreeForm.DoCreate();
begin
  inherited DoCreate();
  Top := Screen.Height - 200;
  Height := 170;
  Left := 0;
  Width := Screen.Width;

  Caption := 'Сообщения программы';

  FProgressPanel := TPanel.Create(Self);
  FProgressPanel.Parent := Self;
  FProgressPanel.Align := alLeft;
  FProgressPanel.Width := 20;
  FProgressPanel.Visible := False;

  FMemoCommand := TMemo.Create(Self);
  FMemoCommand.Parent := Self;
  FMemoCommand.Align := alBottom;
  FMemoCommand.Height := 17;
  FMemoCommand.OnKeyDown := CommandKeyPress;
  FMemoCommand.Visible := False;

  if not(Assigned(FTreeView)) then FTreeView := TTreeView.Create(Self);
  FTreeView.Parent := Self;
  FTreeView.Align := alClient;
  FTreeView.Images := RunImages;
  FTreeView.PopupMenu := PopupMenu;
end;

function TProfLogTreeForm.GetOnCommand(): TProcMessageStr;
begin
  Result := FOnCommand;
end;

procedure TProfLogTreeForm.NClearClick(Sender: TObject);
begin
  FTreeView.Items.Clear;
  SetLength(FNodes, 0);
end;

procedure TProfLogTreeForm.SetOnCommand(Value: TProcMessageStr);
begin
  FOnCommand := Value;
  FMemoCommand.Visible := Assigned(Value);
end;

end.
