{**
@Abstract(Окно вывода сообщений программы в виде дерева)
@Author(Prof1983 prof1983@ya.ru)
@Created(13.10.2005)
@LastMod(27.06.2012)
@Version(0.5)
}
unit ALogFormTree2007;

interface

uses
  Classes, ComCtrls, Controls, Dialogs, ExtCtrls, Forms, Graphics, ImgList,
  Menus, Messages, StdCtrls, SysUtils, Windows,
  ALogShablonForm2006, ATypes,
  fShablon;

type //** Окно вывода сообщений программы в виде дерева
  TFormLog = class(TfmLogShablon)
      //** Очистить содержимое
    procedure NClearClick(Sender: TObject);
  private
    //FImages: TCustomImageList;
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
    procedure AddMsg(const AMsg: WideString); //override; safecall;
    procedure AddStr(const AStr: WideString); //override; safecall;
      //** Добавляет сообщение
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; override;
      //** Добавляет сообщение
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override;
      //** Добавляет сообщение
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer; override;
    property TreeView: TTreeView read FTreeView;
  end;

const
  LOG_IMAGE_INDEX: array[TLogTypeMessage] of Integer = (IndexGreenBox, IndexRedBox, IndexFuchsiaBox, -1, -1, -1);

implementation

{ TFormLog }

function TFormLog.AddNode(AType: TLogTypeMessage; AId, AParentId: Integer; const AStr: WideString): TTreeNode;

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
  FNodes[I].Node.ImageIndex := LOG_IMAGE_INDEX[AType];
end;

procedure TFormLog.AddMsg(const AMsg: WideString);
var
  tmpStr: WideString;
begin
  if AMsg = '-' then
    tmpStr := '----------------------------------------------------------------'
  else if AMsg = '=' then
    tmpStr := '================================================================'
  else
    tmpStr := AMsg;

  AddStr(FormatDateTime('nn:ss:zzzz', Now) + ' ' + tmpStr);
end;

procedure TFormLog.AddStr(const AStr: WideString);
var
  tmpStr: WideString;
begin
  if AStr = '-' then
    tmpStr := '----------------------------------------------------------------'
  else if AStr = '=' then
    tmpStr := '================================================================'
  else
    tmpStr := AStr;

  FTreeView.Items.Add(nil, tmpStr);
end;

procedure TFormLog.CommandKeyPress(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 13) and not(ssCtrl in Shift) then
  begin
    if FMemoCommand.Text = '' then Exit;
    AddToLog(lgNone, ltInformation, 'Команда "%s"', [FMemoCommand.Text]);
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

procedure TFormLog.DoCreate();
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

function TFormLog.GetOnCommand(): TProcMessageStr;
begin
  Result := FOnCommand;
end;

procedure TFormLog.NClearClick(Sender: TObject);
begin
  FTreeView.Items.Clear;
  SetLength(FNodes, 0);
end;

procedure TFormLog.SetOnCommand(Value: TProcMessageStr);
begin
  FOnCommand := Value;
  FMemoCommand.Visible := Assigned(Value);
end;

function TFormLog.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString; AParams: array of const): Integer;
var
  S: string;
begin
  try
    S := Format(AStrMsg, AParams);
  except
    S := AStrMsg;
  end;
  Result := ToLogA(AGroup, AType, S);
end;

function TFormLog.ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
var
  S: string;
begin
  S := '[' + CHR_LOG_TYPE_MESSAGE[AType] + '] ' +
     CHR_LOG_GROUP_MESSAGE[AGroup] + ': ' +
     AStrMsg;
  AddNode(AType, 0, 0, S);
  Result := 1;
end;

function TFormLog.ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage; const AStrMsg: WideString): Integer;
begin
  AddToLog(TLogGroupMessage(AGroup), TLogTypeMessage(AType), AStrMsg, []);
  Result := 1;
end;

end.
