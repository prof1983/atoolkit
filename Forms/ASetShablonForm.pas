{**
@Abstract(Форма настроек)
@Author(Prof1983 prof1983@ya.ru)
@Created(05.04.2006)
@LastMod(02.05.2012)
@Version(0.5)

Элементы должны иметь уникальные имена
}
unit ASetShablonForm;

interface

uses
  ActnList, Classes, ComCtrls, Controls, Dialogs, ExtCtrls, Forms, Graphics, Menus,
  Messages, StdCtrls, SysUtils, Windows, ToolWin, Buttons, ImgList,
  ATypes; {unStdWinDialog;}

type //** Видимые кнопки
  TVisibleButton = (vbApply, vbDefault);
  TVisibleButtonSet = set of TVisibleButton;

type //** Тип картинки из Images
  TImageType = (
    iGray,       // Серый
    iBlue,       // Синий
    iGreen,      // Зеленый
    iFuchsia,    // Фиолетовый
    iRed,        // Красный
    iView,       // Просмотр
    iError,      // Ошибка
    iInformation,// Информация
    iRefresh,    // Обновить
    iWarning,    // Предупреждение
    iDoor,       // Дверь (выход)
    iDoor_,      // Дверь (выход) (неактивная)
    iCancel,     // Отмена
    iCancel_,    // Отмена (неактивная)
    iFind,       // Поиск
    iFind_,      // Поиск (неактивная)
    iButton,     // Круглая кнопка
    iButton_,    // Круглая кнопка (неактивная)
    iVideo,      // Видео
    iVideo_,     // Видео (неактивная)
    iAdd,        // Добавить
    iDelete,     // Удалить
    iLetter,     // Письмо
    iVideo2,     // Видео2
    iSetup,      // Настройки
    iSeach,      // Поиск
    iNone        // Нет картинки
    );

type
  TPopupClick = function (Sender: TObject; const ACommandText, ANodeText: WideString; ATag: Integer): WordBool;

type
  TfmSetShablon = class(TForm)
    plButtons: TPanel;
    btCancel: TButton;
    tvSettingMain: TTreeView;
    spMain: TSplitter;
    lbDescription: TLabel;
    btApply: TButton;
    btDefault: TButton;
    pmTree: TPopupMenu;
    btOk: TButton;
    tbMain: TToolBar;
    Images: TImageList;
    ActionList1: TActionList;
    acAdd: TAction;
    acDelete: TAction;
    procedure btOkClick(Sender: TObject);
    procedure tvSettingMainClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure plButtonsResize(Sender: TObject);
    procedure btApplyClick(Sender: TObject);
    procedure btDefaultClick(Sender: TObject);
    procedure tvSettingMainDblClick(Sender: TObject);
    procedure tvSettingMainContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
  private
    FItems: array of record
      Description: WideString;
      //Node: TTreeNode;
      Text: WideString;
      Frame: TFrame;
      PopupMenu: TPopupMenu;
    end;
    FOnAddToLog: TProfAddToLog;
    FOnPopupClick: TPopupClick;
    function GetVisibleButtonSet(): TVisibleButtonSet;
    procedure SetVisibleButtonSet(Value: TVisibleButtonSet);
    procedure PopupOnClick(Sender: TObject);
  protected
    function AddItem(const AName, ADescription: WideString; AParentNode: TTreeNode = nil; APopupMenu: TPopupMenu = nil; AFrame: TFrame = nil): TTreeNode; overload;
    function AddItem(ANode: TTreeNode; AFrame: TFrame; const ADescription: WideString = ''; APopupMenu: TPopupMenu = nil): Integer; overload;
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
    function DoCommand(const ACommandText, ANodeText: WideString; ATag: Integer): WordBool; virtual;
    procedure DoCreate(); override;
    // Двойное нажатие
    function DoDblClick(const ANodeName: WideString): WordBool; virtual;
    // Установить значения по умолчанию
    procedure DoDefault(); virtual;
    procedure DoDestroy(); override;
    function DoLoad(): WordBool; virtual;
    function DoSave(): WordBool; virtual;
    // Обрабатывает событие: выбран элемент. Возвращает True, если все Ok
    function DoSelect(const ANodeText: WideString): WordBool; virtual;
    function GetNodeByName(const AName: WideString): TTreeNode;
  public
    // Добавить событие в PopupMenu и кнопку на ToolBar. Возвращает ID команды.
    function AddAction(ATitle: WideString; AOnExecute: TNotifyEvent; AImage: TImageType): Integer;
    // Добавить команду в PopupMenu
    function AddCommand(const ACommandText: WideString; ATag: Integer; AImage: TImageType = iNone): TMenuItem;
    // Удалить все ноды
    procedure Clear();
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    function LoadParams(): WordBool;
    property OnAddToLog: TProfAddToLog read FOnAddToLog write FOnAddToLog;
    property OnPupupClick: TPopupClick read FOnPopupClick write FOnPopupClick;
    // Сохранить значения
    function SaveParams(): WordBool;
    // Видимые кнопки
    property VisibleButtonSet: TVisibleButtonSet read GetVisibleButtonSet write SetVisibleButtonSet;
  end;

implementation

{$R *.DFM}

// TfmSetShablon ---------------------------------------------------------------
// -----------------------------------------------------------------------------
function TfmSetShablon.AddAction(ATitle: WideString; AOnExecute: TNotifyEvent; AImage: TImageType): Integer;
var
  Action: TAction;
  //bt: TSpeedButton;
  bt: TToolButton;
  i: Integer;
  mi: TMenuItem;
begin
  // Узнаем самый большой Tag Action и прибавляем +1
  Result := 0;
  for i := 0 to ActionList1.ActionCount - 1 do
    if ActionList1.Actions[i].Tag > Result then
      Result := ActionList1.Actions[i].Tag;
  Result := Result + 1;

  Action := TAction.Create(Self);
  Action.OnExecute := AOnExecute;
  Action.Caption := ATitle;
  Action.Tag := Result;
  Action.Enabled := True;
  Action.Hint := ATitle;
  if AImage <> iNone then
    Action.ImageIndex := Integer(AImage)
  else
    Action.ImageIndex := -1;
  Action.Visible := True;
  ActionList1.UpdateAction(Action);

  mi := TMenuItem.Create(pmTree);
  mi.Action := Action;
  pmTree.Items.Add(mi);

  bt := TToolButton.Create(tbMain);
  bt.Parent := tbMain;
  bt.Action := Action;

  tbMain.Visible := True;
  AddToLog(lgGeneral, ltInformation, 'Добавлен элемент управления "%s" ID=%d ButtonCount=%d', [ATitle, Result, tbMain.ButtonCount]);
end;

// -----------------------------------------------------------------------------
function TfmSetShablon.AddCommand(const ACommandText: WideString; ATag: Integer; AImage: TImageType = iNone): TMenuItem;
var
  bt: TSpeedButton;
begin
  Result := TMenuItem.Create(pmTree);
  Result.Caption := ACommandText;
  Result.OnClick := PopupOnClick;
  Result.Tag := ATag;
  pmTree.Items.Add(Result);

  bt := TSpeedButton.Create(Self);
  bt.Parent := tbMain;
  bt.Hint := ACommandText;
  bt.OnClick := PopupOnClick;
  bt.Visible := True;
  bt.ShowHint := True;
  bt.Tag := ATag;
  if AImage < iNone then
    Images.GetBitmap(Integer(AImage), bt.Glyph);
  tbMain.Visible := True;
end;

// -----------------------------------------------------------------------------
function TfmSetShablon.AddItem(const AName, ADescription: WideString; AParentNode: TTreeNode = nil; APopupMenu: TPopupMenu = nil; AFrame: TFrame = nil): TTreeNode;
begin
  // Проверка
  if Assigned(GetNodeByName(AName)) then
  begin
    AddToLog(lgGeneral, ltError, 'Уже есть элемент с именем "%s"', [AName]);
    Result := nil;
    Exit;
  end;
  // Создание
  Result := tvSettingMain.Items.AddChild(AParentNode, AName);
  // Добавление
  AddItem(Result, AFrame, ADescription, APopupMenu);
end;

// -----------------------------------------------------------------------------
function TfmSetShablon.AddItem(ANode: TTreeNode; AFrame: TFrame; const ADescription: WideString = ''; APopupMenu: TPopupMenu = nil): Integer;
begin
  Result := Length(FItems);
  SetLength(FItems, Result + 1);
  FItems[Result].Description := ADescription;
  //FItems[Result].Node := ANode;
  FItems[Result].Text := ANode.Text;
  FItems[Result].Frame := AFrame;
  FItems[Result].PopupMenu := APopupMenu;
end;

// -----------------------------------------------------------------------------
function TfmSetShablon.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := -1;
  if Assigned(FOnAddToLog) then
  try
    Result := FOnAddToLog(AGroup, AType, AStrMsg, AParams);
  except
  end;
end;

// -----------------------------------------------------------------------------
procedure TfmSetShablon.btApplyClick(Sender: TObject);
begin
  SaveParams();
end;

// -----------------------------------------------------------------------------
procedure TfmSetShablon.btOkClick(Sender: TObject);
begin
  SaveParams();
end;

// -----------------------------------------------------------------------------
procedure TfmSetShablon.btDefaultClick(Sender: TObject);
begin
  DoDefault();
end;

// -----------------------------------------------------------------------------
procedure TfmSetShablon.Clear();
var
  I: Integer;
begin
  tvSettingMain.Items.Clear();
  for I := 0 to High(FItems) do
  try
    if Assigned(FItems[I].Frame) then
      FItems[I].Frame.Free();
  except
  end;
  SetLength(FItems, 0);
end;

// -----------------------------------------------------------------------------
constructor TfmSetShablon.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

// -----------------------------------------------------------------------------
destructor TfmSetShablon.Destroy();
begin
  Clear();
  inherited Destroy();
end;

// -----------------------------------------------------------------------------
function TfmSetShablon.LoadParams(): WordBool;
begin
  Result := DoLoad();
end;

// -----------------------------------------------------------------------------
function TfmSetShablon.DoCommand(const ACommandText, ANodeText: WideString; ATag: Integer): WordBool;
begin
  Result := False;
  if Assigned(FOnPopupClick) then
  try
    Result := FOnPopupClick(nil, ACommandText, ANodeText, ATag);
  except
  end;
end;

// -----------------------------------------------------------------------------
procedure TfmSetShablon.DoCreate();
begin
  inherited DoCreate();
  tbMain.Visible := False;
  lbDescription.Caption := '';
  //pnMain.Align := alClient;
  //pnMain.Visible := False;
  VisibleButtonSet := [];
end;

// -----------------------------------------------------------------------------
function TfmSetShablon.DoDblClick(const ANodeName: WideString): WordBool;
begin
  Result := False;
end;

// -----------------------------------------------------------------------------
procedure TfmSetShablon.DoDefault();
begin
end;

// -----------------------------------------------------------------------------
procedure TfmSetShablon.DoDestroy();
begin
  inherited DoDestroy();
end;

// -----------------------------------------------------------------------------
function TfmSetShablon.DoLoad(): WordBool;
begin
  Result := False;
end;

// -----------------------------------------------------------------------------
function TfmSetShablon.DoSave(): WordBool;
begin
  Result := False;
end;

// -----------------------------------------------------------------------------
function TfmSetShablon.DoSelect(const ANodeText: WideString): WordBool;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to High(FItems) do
    if Assigned(tvSettingMain.Selected) then
      if (FItems[I].Text = ANodeText) then
      begin
        if Assigned(FItems[I].Frame) then
          FItems[I].Frame.Visible := True
        else
          lbDescription.Caption := FItems[I].Description;
        Result := True;
        Exit;
      end;
end;

// -----------------------------------------------------------------------------
procedure TfmSetShablon.FormCreate(Sender: TObject);
begin
  //DoCreate();
  btCancel.Caption := 'Отмена';
  //tbMain.Visible := False;
end;

// -----------------------------------------------------------------------------
procedure TfmSetShablon.FormDestroy(Sender: TObject);
begin
  //DoDestroy();
end;

// -----------------------------------------------------------------------------
function TfmSetShablon.GetNodeByName(const AName: WideString): TTreeNode;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to tvSettingMain.Items.Count - 1 do
    if tvSettingMain.Items.Item[I].Text = AName then
    begin
      Result := tvSettingMain.Items.Item[I];
      Exit;
    end;
end;

// -----------------------------------------------------------------------------
function TfmSetShablon.GetVisibleButtonSet(): TVisibleButtonSet;
begin
  if btApply.Visible then Result := [vbApply];
  if btDefault.Visible then Result := Result + [vbDefault];
end;

// -----------------------------------------------------------------------------
procedure TfmSetShablon.plButtonsResize(Sender: TObject);
var
  c: Integer;
  i: Integer;
begin
  c := 3;  //2+1 btOk+btCancel+1
  if btApply.Visible then Inc(c);
  if btDefault.Visible then Inc(c);
  i := plButtons.Width div c;

  btOk.Left := i;
  btCancel.Left := i * 2;
  btApply.Left := i * 3;
  if btApply.Visible then
    btDefault.Left := i * 4;
end;

// -----------------------------------------------------------------------------
procedure TfmSetShablon.PopupOnClick(Sender: TObject);
var
  S: string;
begin
  if not(Assigned(tvSettingMain.Selected)) then Exit;
  if Sender is TMenuItem then
    S := TMenuItem(Sender).Caption
  else if Sender is TSpeedButton then
    S := TSpeedButton(Sender).Hint;
  DoCommand(S, tvSettingMain.Selected.Text, TComponent(Sender).Tag);
end;

// -----------------------------------------------------------------------------
function TfmSetShablon.SaveParams(): WordBool;
{var
  I: Integer;}
begin
  {for I := 0 to High(FItems) do
    if Assigned(FItems[I].Frame) then
      FItems[I].Frame.Save();}
  Result := DoSave();
end;

// -----------------------------------------------------------------------------
procedure TfmSetShablon.SetVisibleButtonSet(Value: TVisibleButtonSet);
begin
  btApply.Visible := (vbApply in Value);
  btDefault.Visible := (vbDefault in Value);
  plButtonsResize(Self);
end;

// -----------------------------------------------------------------------------
procedure TfmSetShablon.tvSettingMainClick(Sender: TObject);
var
  I: Integer;
begin
  lbDescription.Caption := '';
  for I := 0 to High(FItems) do
    if Assigned(FItems[I].Frame) then
      FItems[I].Frame.Visible := False;

  if not(Assigned(tvSettingMain.Selected)) or not(DoSelect(tvSettingMain.Selected.Text)) then
    if Assigned(tvSettingMain.Selected) then
      lbDescription.Caption := tvSettingMain.Selected.Text;
end;

// -----------------------------------------------------------------------------
procedure TfmSetShablon.tvSettingMainContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  //ShowInfo(Handle, '', 'ContextPopup MousePos: X=%d Y=%d Handled=%s', [MousePos.X, MousePos.Y, BoolToStr(Handled, True)]);
end;

// -----------------------------------------------------------------------------
procedure TfmSetShablon.tvSettingMainDblClick(Sender: TObject);
begin
  if not(Assigned(tvSettingMain.Selected)) or not(DoDblClick(tvSettingMain.Selected.Text)) then
    if Assigned(tvSettingMain.Selected) then
      lbDescription.Caption := tvSettingMain.Selected.Text;
end;

end.
