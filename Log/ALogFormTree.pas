{**
@Abstract Окно вывода сообщений программы в виде дерева
@Author Prof1983 <prof1983@ya.ru>
@Created 13.10.2005
@LastMod 19.12.2012
}
unit ALogFormTree;

interface

uses
  Classes, ComCtrls, Controls, ExtCtrls, Forms, StdCtrls, SysUtils,
  ABase,
  ALogUtils,
  AShablonForm,
  ATypes;

type //** Окно вывода сообщений программы в виде дерева
  TALogTreeForm = class(TfmShablon)
    procedure NClearClick(Sender: TObject);
  protected
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
    function GetOnCommand(): TProcMessageStr; virtual;
    procedure SetOnCommand(Value: TProcMessageStr); virtual;
  public
    {** Добавляет сообщение }
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        StrMsg: APascalString): AInt; virtual;
    {** Добавляет Node }
    function AddNode(AType: TLogTypeMessage; AId, AParentId: Integer; const AStr: WideString): TTreeNode;
    {** Добавляет сообщение }
    procedure AddMsg(const AMsg: WideString);
    {** Добавляет строку }
    procedure AddStr(const AStr: WideString);
    {** Добавляет сообщение }
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; virtual; deprecated; // Use AddToLog()
    {** Добавляет сообщение }
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; virtual; deprecated; // Use AddToLog()
    {** Добавляет сообщение }
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer; virtual; deprecated; // Use AddToLog()
  public
    property TreeView: TTreeView read FTreeView;
  end;

implementation

const
  LOG_DELIMER1 = '----------------------------------------------------------------';
  LOG_DELIMER2 = '================================================================';

{ TALogTreeForm }

function TALogTreeForm.AddNode(AType: TLogTypeMessage; AId, AParentId: Integer; const AStr: WideString): TTreeNode;

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

procedure TALogTreeForm.AddMsg(const AMsg: WideString);
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

procedure TALogTreeForm.AddStr(const AStr: WideString);
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

function TALogTreeForm.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    StrMsg: APascalString): AInt;
var
  S: string;
begin
  S := '[' + CHR_LOG_TYPE_MESSAGE[LogType] + '] ' +
     CHR_LOG_GROUP_MESSAGE[LogGroup] + ': ' +
     StrMsg;
  AddNode(LogType, 0, 0, S);
  Result := 1;
end;

procedure TALogTreeForm.CommandKeyPress(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 13) and not(ssCtrl in Shift) then
  begin
    if FMemoCommand.Text = '' then Exit;
    AddToLog(lgNone, ltInformation, Format('Команда "%s"', [FMemoCommand.Text]));
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

procedure TALogTreeForm.DoCreate();
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

  //FImages := TCustomImageList.Create;
  if not(Assigned(FTreeView)) then FTreeView := TTreeView.Create(Self);
  FTreeView.Parent := Self;
  FTreeView.Align := alClient;
  FTreeView.Images := RunImages;
  FTreeView.PopupMenu := PopupMenu;
end;

function TALogTreeForm.GetOnCommand(): TProcMessageStr;
begin
  Result := FOnCommand;
end;

procedure TALogTreeForm.NClearClick(Sender: TObject);
begin
  FTreeView.Items.Clear;
  SetLength(FNodes, 0);
end;

procedure TALogTreeForm.SetOnCommand(Value: TProcMessageStr);
begin
  FOnCommand := Value;
  FMemoCommand.Visible := Assigned(Value);
end;

function TALogTreeForm.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString; AParams: array of const): Integer;
var
  S: string;
begin
  try
    S := Format(AStrMsg, AParams);
  except
    S := AStrMsg;
  end;
  Result := AddToLog(AGroup, AType, S);
end;

function TALogTreeForm.ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  Result := AddToLog(AGroup, AType, AStrMsg);
end;

function TALogTreeForm.ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage; const AStrMsg: WideString): Integer;
begin
  AddToLog(TLogGroupMessage(AGroup), TLogTypeMessage(AType), AStrMsg);
  Result := 1;
end;

end.
