{**
@Author Prof1983 <prof1983@ya.ru>
@Created 29.03.2013
@LastMod 04.04.2013
}
unit AUiReportWin;

interface

uses
  ABase,
  AUiBase;

// --- AUiReportWin ---

function ReportWin_NewP(const Text: APascalString): AWindow;

{** Displays a modal window with the report }
function ReportWin_ShowReportP(const Text: APascalString; Font: AFont; Width, Height: AInt): AError;

implementation

uses
  Classes,
  ComCtrls,
  Controls,
  Dialogs,
  ExtCtrls,
  Forms,
  Graphics,
  Menus,
  Messages,
  RichEdit,
  StdCtrls,
  Windows,
  Printers,
  AUtilsMain;

const
  RulerAdj = 4/3;
  GutterWid = 6;

const
  cReportFont = 'Font';

type
  TReportWin = record
    Form: TForm;
    MainMenu: TMainMenu;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    FilePrintItem: TMenuItem;
    FileExitItem: TMenuItem;
    EditUndoItem: TMenuItem;
    EditCutItem: TMenuItem;
    EditCopyItem: TMenuItem;
    EditPasteItem: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Ruler: TPanel;
    FontDialog1: TFontDialog;
    FirstInd: TLabel;
    LeftInd: TLabel;
    RulerLine: TBevel;
    RightInd: TLabel;
    N5: TMenuItem;
    miEditFont: TMenuItem;
    StatusBar: TStatusBar;
    Serv: TMenuItem;
    PagesMenuItem: TMenuItem;
    DelimerMenuItem: TMenuItem;
    FilePrinItemStr: TMenuItem;
    ToolBar: TToolBar;
    OpenButton: TToolButton;
    SaveButton: TToolButton;
    PrintButton: TToolButton;
    ToolButton5: TToolButton;
    UndoButton: TToolButton;
    CutButton: TToolButton;
    CopyButton: TToolButton;
    PasteButton: TToolButton;
    ToolButton10: TToolButton;
    FontName: TComboBox;
    ToolButton11: TToolButton;
    FontSize: TEdit;
    UpDown1: TUpDown;
    BoldButton: TToolButton;
    ItalicButton: TToolButton;
    UnderlineButton: TToolButton;
    ToolButton16: TToolButton;
    LeftAlign: TToolButton;
    CenterAlign: TToolButton;
    RightAlign: TToolButton;
    ToolButton20: TToolButton;
    BulletsButton: TToolButton;
    ToolbarImages: TImageList;

    Editor: TRichEdit;
    PrintDialog: TPrintDialog;
    RichEditRGV: TRichEdit;

    FFileName: string;
    FUpdating: Boolean;
    FDragOfs: Integer;
    FDragging: Boolean;
    FClipboardOwner: HWnd;
    {
    procedure SelectionChange(Sender: TObject);
    procedure FileNew(Sender: TObject);
    procedure FileOpen(Sender: TObject);
    procedure FileSave(Sender: TObject);
    procedure FileSaveAs(Sender: TObject);
    procedure FilePrint(Sender: TObject);
    procedure FileExit(Sender: TObject);
    procedure EditUndo(Sender: TObject);
    procedure EditCut(Sender: TObject);
    procedure EditCopy(Sender: TObject);
    procedure EditPaste(Sender: TObject);
    procedure SelectFont(Sender: TObject);
    procedure RulerResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure BoldButtonClick(Sender: TObject);
    procedure ItalicButtonClick(Sender: TObject);
    procedure FontSizeChange(Sender: TObject);
    procedure AlignButtonClick(Sender: TObject);
    procedure FontNameChange(Sender: TObject);
    procedure UnderlineButtonClick(Sender: TObject);
    procedure BulletsButtonClick(Sender: TObject);
    procedure RulerItemMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure RulerItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FirstIndMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LeftIndMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure RightIndMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure RichEditChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PagesMenuItemClick(Sender: TObject);
    procedure DelimerMenuItemClick(Sender: TObject);
    procedure FilePrinItemStrClick(Sender: TObject);

    function GetCurrText: TTextAttributes;
    procedure GetFontNames;
    procedure SetFileName(const Value: string);
    procedure CheckFileSave;
    procedure SetupRuler;
    procedure SetEditRect;
    procedure UpdateCursorPos;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure WMChangeCBChain(var Msg: TWMChangeCBChain); message WM_CHANGECBCHAIN;
    procedure WMDrawClipboard(var Msg: TWMDrawClipboard); message WM_DRAWCLIPBOARD;
    procedure PerformFileOpen(const AFileName: string);
    procedure SetModified(Value: Boolean);

    procedure DoCreate; override;

    procedure AddLine(const Text: string);
    procedure Clear;
    procedure LoadConfiguration(Config: AConfig);
    procedure SaveConfiguration(Config: AConfig);
    procedure SelectAllText;
    procedure SetInitialDir(const Value: string);
    }
  end;

// --- Forward ---

function _ReportWin_FileSave(var Win: TReportWin): AError; forward;
function _ReportWin_FileSaveAs(var Win: TReportWin): AError; forward;
function _ReportWin_GetCurrText(const Win: TReportWin): TTextAttributes; forward;
function _ReportWin_GetFontNames(const Win: TReportWin): AError; forward;
function _ReportWin_LeftIndMouseUp(var Win: TReportWin): AError; forward;
function _ReportWin_PerformFileOpen(var Win: TReportWin; const FileName: string): AError; forward;
function _ReportWin_RichEditChange(const Win: TReportWin): AError; forward;
function _ReportWin_SelectionChange(var Win: TReportWin): AError; forward;
function _ReportWin_SetEditRect(const Win: TReportWin): AError; forward;
function _ReportWin_SetFileName(var Win: TReportWin; const Value: string): AError; forward;
function _ReportWin_SetModified(const Win: TReportWin; Value: ABool): AError; forward;
function _ReportWin_SetupRuler(const Win: TReportWin): AError; forward;
function _ReportWin_UpdateCursorPos(const Win: TReportWin): AError; forward;

// --- Private ---

function _EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;

function _ReportWin_AddLine(const Win: TReportWin; const Text: string): AError;
begin
  Win.Editor.Lines.Add(Text);
  Result := 0;
end;

function _ReportWin_AlignButtonClick(const Win: TReportWin; Sender: TControl): AError;
begin
  if Win.FUpdating then
  begin
    Result := 1;
    Exit;
  end;
  Win.Editor.Paragraph.Alignment := TAlignment(Sender.Tag);
  Result := 0;
end;

function _ReportWin_BoldButtonClick(const Win: TReportWin): AError;
var
  CurrText: TTextAttributes;
begin
  Result := 0;
  if Win.FUpdating then Exit;
  CurrText := _ReportWin_GetCurrText(Win);
  if Win.BoldButton.Down then
    CurrText.Style := CurrText.Style + [fsBold]
  else
    CurrText.Style := CurrText.Style - [fsBold];
end;

function _ReportWin_BulletsButtonClick(const Win: TReportWin): AError;
begin
  if Win.FUpdating then
  begin
    Result := 1;
    Exit;
  end;
  Win.Editor.Paragraph.Numbering := TNumberingStyle(Win.BulletsButton.Down);
  Result := 0;
end;

function _ReportWin_CheckFileSave(var Win: TReportWin): AError;
var
  SaveResp: Integer;
begin
  Result := 0;
  if not(Win.Editor.Modified) then Exit;
  SaveResp := MessageDlg(AUtils_FormatStrStrP('Save %s?', Win.FFileName),
    mtConfirmation, mbYesNoCancel, 0);
  if (SaveResp = idYes) then
    _ReportWin_FileSave(Win);
end;

function _ReportWin_Clear(const Win: TReportWin): AError;
begin
  Win.Editor.Clear();
  Result := 0;
end;

function _ReportWin_DelimerMenuItemClick(const Win: TReportWin): AError;
{var
  Buffer: PChar;
  Size: Integer;}
begin
  {
  Clipboard.Clear;
  Clipboard.AsText := #12 + '~' + #13#10;
  Size := Length(Clipboard.AsText);
  Inc(Size);
  GetMem(Buffer, Size);
  Buffer := #12 + '~' + #13#10;
  Editor.SetSelTextBuf(Buffer);
  Clipboard.AsText := 'Стр.' + #13#10;
  Size := Length(Clipboard.AsText);
  Inc(Size);
  GetMem(Buffer, Size);
  Buffer := 'Стр.' + #13#10;
  Editor.SetSelTextBuf(Buffer);
  }
  Result := -1;
end;

function _ReportWin_EditCopy(const Win: TReportWin): AError;
begin
  Win.Editor.CopyToClipboard();
  Result := 0;
end;

function _ReportWin_EditCut(const Win: TReportWin): AError;
begin
  Win.Editor.CutToClipboard();
  Result := 0;
end;

function _ReportWin_EditPaste(const Win: TReportWin): AError;
begin
  Win.Editor.PasteFromClipboard();
  Result := 0;
end;

function _ReportWin_EditUndo(const Win: TReportWin): AError;
begin
  if Win.Editor.HandleAllocated then
    SendMessage(Win.Editor.Handle, EM_UNDO, 0, 0);
  Result := 0;
end;

function _ReportWin_FileExit(const Win: TReportWin): AError;
begin
  Win.Form.Close();
  Result := 0;
end;

function _ReportWin_FileNew(var Win: TReportWin): AError;
begin
  _ReportWin_CheckFileSave(Win);
  _ReportWin_SetFileName(Win, 'Report1.rtf');
  Win.Editor.Lines.Clear();
  Win.Editor.Modified := False;
  _ReportWin_SetModified(Win, False);
  Result := 0;
end;

function _ReportWin_FileOpen(var Win: TReportWin): AError;
begin
  _ReportWin_CheckFileSave(Win);
  if Win.OpenDialog.Execute() then
  begin
    _ReportWin_PerformFileOpen(Win, Win.OpenDialog.FileName);
    Win.Editor.ReadOnly := ofReadOnly in Win.OpenDialog.Options;
  end;
  Result := 0;
end;

function _ReportWin_FilePrint(const Win: TReportWin): AError;
begin
  if Win.PrintDialog.Execute() then
    Win.Editor.Print(Win.FFileName);
  Result := 0;
end;

function _ReportWin_FilePrinItemStrClick(const Win: TReportWin): AError;
var
  PrintText: TextFile;
  Line: Integer;
  ss: Char;
begin
  if Win.PrintDialog.Execute() then
  begin
    AssignPrn(PrintText);
    Rewrite(PrintText);
    Printer.Canvas.Font := Win.Editor.Font;
    Writeln(PrintText, ' ');
    for Line := 0 to Win.Editor.Lines.Count - 1 do
    begin
      ss := Copy(Win.Editor.Lines[Line],1,1)[1];
      if (ss = '#') then
      begin
        WriteLn(PrintText, ' ');
        WriteLn(PrintText, #12);
        WriteLn(PrintText, ' ');
      end;
      WriteLn(PrintText, '      ', Win.Editor.Lines[Line]);
    end;
    System.Close(PrintText);
  end;
  Result := 0;
end;

function _ReportWin_FileSave(var Win: TReportWin): AError;
begin
  if (Win.FFileName = 'Untitled') then
    _ReportWin_FileSaveAs(Win)
  else
  begin
    Win.Editor.Lines.SaveToFile(Win.FFileName);
    Win.Editor.Modified := False;
    _ReportWin_SetModified(Win, False);
  end;
  Result := 0;
end;

function _ReportWin_FileSaveAs(var Win: TReportWin): AError;
var
  S: APascalString;
begin
  if Win.SaveDialog.Execute() then
    Win.SaveDialog.FileName := AUtils_ChangeFileExtP(Win.SaveDialog.FileName, '.rtf');
  if AUtils_FileExistsP(Win.SaveDialog.FileName) then
  begin
    S := AUtils_FormatStrStrP('File exists. Rewrite %s?', Win.SaveDialog.FileName);
    if (MessageDlg(S, mtConfirmation, mbYesNoCancel, 0) <> idYes) then
    begin
      Result := 1;
      Exit;
    end;
  end;
  Win.Editor.Lines.SaveToFile(Win.SaveDialog.FileName);
  _ReportWin_SetFileName(Win, Win.SaveDialog.FileName);
  Win.Editor.Modified := False;
  _ReportWin_SetModified(Win, False);
  Result := 0;
end;

function _ReportWin_FirstIndMouseUp(var Win: TReportWin): AError;
begin
  Win.FDragging := False;
  Win.Editor.Paragraph.FirstIndent := Trunc((Win.FirstInd.Left+Win.FDragOfs-GutterWid) / RulerAdj);
  _ReportWin_LeftIndMouseUp(Win);
  Result := 0;
end;

function _ReportWin_FontNameChange(const Win: TReportWin; Sender: TObject): AError;
var
  CurrText: TTextAttributes;
begin
  if Win.FUpdating then
  begin
    Result := 1;
    Exit;
  end;
  CurrText := _ReportWin_GetCurrText(Win);
  CurrText.Name := Win.FontName.Items[Win.FontName.ItemIndex];
  Win.Editor.Font.Name := CurrText.Name;
  Result := 0;
end;

function _ReportWin_FontSizeChange(const Win: TReportWin): AError;
var
  CurrText: TTextAttributes;
begin
  if Win.FUpdating then
  begin
    Result := 1;
    Exit;
  end;
  CurrText := _ReportWin_GetCurrText(Win);
  CurrText.Size := AUtils_StrToIntP(Win.FontSize.Text);
  Win.Editor.Font.Size := CurrText.Size;
  Result := 0;
end;

function _ReportWin_FormDestroy(const Win: TReportWin): AError;
begin
  // remove ourselves from the viewer chain
  ChangeClipboardChain(Win.Form.Handle, Win.FClipboardOwner);
  Result := 0;
end;

function _ReportWin_FormPaint(const Win: TReportWin): AError;
begin
  _ReportWin_SetEditRect(Win);
  Result := 0;
end;

function _ReportWin_FormResize(var Win: TReportWin): AError;
begin
  _ReportWin_SetEditRect(Win);
  _ReportWin_SelectionChange(Win);
  Result := 0;
end;

function _ReportWin_FormShow(const Win: TReportWin): AError;
begin
  _ReportWin_UpdateCursorPos(Win);
  _ReportWin_RichEditChange(Win);
  Win.Editor.SetFocus;
  Result := 0;
end;

function _ReportWin_GetCurrText(const Win: TReportWin): TTextAttributes;
begin
  if (Win.Editor.SelLength > 0) then
    Result := Win.Editor.SelAttributes
  else
    Result := Win.Editor.DefAttributes;
end;

function _ReportWin_GetFontNames(const Win: TReportWin): AError;
var
  DC: HDC;
begin
  DC := GetDC(0);
  EnumFonts(DC, nil, @_EnumFontsProc, Pointer(Win.FontName.Items));
  ReleaseDC(0, DC);
  Win.FontName.Sorted := True;
  Result := 0;
end;

procedure _ReportWin_Init(var Win: TReportWin);
begin
  Win.PrintDialog := TPrintDialog.Create(Win.Form);
  Win.PrintDialog.Options := [poPageNums, poSelection, poWarning];

  Win.Editor := TRichEdit.Create(Win.Form);
  Win.Editor.Parent := Win.Form;
  Win.Editor.Left := 0;
  Win.Editor.Top := 55;
  Win.Editor.Width := 853;
  Win.Editor.Height := 618;
  Win.Editor.HelpContext := 400;
  Win.Editor.Align := alClient;
  Win.Editor.Font.Charset := RUSSIAN_CHARSET;
  Win.Editor.Font.Color := clBlack;
  Win.Editor.Font.Height := -15;
  Win.Editor.Font.Name := 'Courier New';
  Win.Editor.Font.Style := [];
  Win.Editor.ParentFont := False;
  Win.Editor.ScrollBars := ssBoth;
  Win.Editor.TabOrder := 1;
  Win.Editor.WantTabs := True;
  {
  Win.Editor.OnChange := RichEditChange;
  Win.Editor.OnSelectionChange := SelectionChange;
  }

  Win.RichEditRGV := TRichEdit.Create(Win.Form);
  Win.RichEditRGV.Parent := Win.Form;
  Win.RichEditRGV.Left := 920;
  Win.RichEditRGV.Top := 72;
  Win.RichEditRGV.Width := 1;
  Win.RichEditRGV.Height := 1;
  Win.RichEditRGV.TabOrder := 4;
  Win.RichEditRGV.Visible := False;

  Win.Form.ActiveControl := Win.Editor;

  _ReportWin_SetFileName(Win, 'Report1.rtf');
  _ReportWin_GetFontNames(Win);
  _ReportWin_SetupRuler(Win);
  _ReportWin_SelectionChange(Win);
  Win.FClipboardOwner := SetClipboardViewer(Win.Form.Handle);
  Win.Editor.Modified := False;

  Win.Form.Left := 10;
  Win.Form.Top := 10;
  Win.Form.Width := 300;
  Win.Form.Height := 300;
end;

function _ReportWin_ItalicButtonClick(const Win: TReportWin): AError;
var
  CurrText: TTextAttributes;
begin
  if Win.FUpdating then
  begin
    Result := 1;
    Exit;
  end;
  CurrText := _ReportWin_GetCurrText(Win);
  if Win.ItalicButton.Down then
    CurrText.Style := CurrText.Style + [fsItalic]
  else
    CurrText.Style := CurrText.Style - [fsItalic];
  Result := 0;
end;

function _ReportWin_LeftIndMouseUp(var Win: TReportWin): AError;
begin
  Win.FDragging := False;
  Win.Editor.Paragraph.LeftIndent := Trunc((Win.LeftInd.Left+Win.FDragOfs-GutterWid) / RulerAdj) -
      Win.Editor.Paragraph.FirstIndent;
  _ReportWin_SelectionChange(Win);
  Result := 0;
end;

{
function _ReportWin_LoadConfiguration(const Win: TReportWin; Config: AConfig): AError;
begin
  Form_LoadConfig(Self, Config);
  Editor.Font.Name := ASettings_ReadStringDefP(Config, Self.Name+'\'+cReportFont, 'Name', 'Courier New Cyr');
  Editor.Font.Size := ASettings_ReadIntegerDefP(Config, Self.Name+'\'+cReportFont, 'Size', 10);
  Result := 0;
end;
}

function _ReportWin_New(var Win: TReportWin; const Text: APascalString; Font: TFont;
    Width, Height: AInt): AError;
begin
  try
    Win.Form := TForm.Create(nil);;
    _ReportWin_Init(Win);
    Win.Editor.Clear();
    Win.Editor.Text := Text;
    if Assigned(Font) then
      Win.Editor.Font.Assign(Font);
    if (Width > 0) then
      Win.Form.Width := Width;
    if (Height > 0) then
      Win.Form.Height := Height;
    Result := 0;
  except
    Result := -1;
  end;
end;

function _ReportWin_PagesMenuItemClick(const Win: TReportWin): AError;
{var
  ic: Integer;
  jc: Integer;
  Sh: array[1..4] of string[100];
  UprStroka: string[4];
  UprSimv: string[2];
  Tablica: Boolean;
  NomStran: Integer;
  MaxStrok: Integer;
  VysotaStran: Integer;}
begin
  {
  Status.KoefPech := 2.5;
  VysotaStran := 297;
  MaxStrok := Round((VysotaStran-30)/(Editor.Font.Size/Status.KoefPech));
  Tablica := False;
  NomStran := 1;
  jc := -1;
  ic := 0;
  while (jc <= Editor.Lines.Count) do
  begin
    jc := jc+1;
    ic := ic+1;
    UprSimv := Copy(Editor.Lines[jc+1],1,1);
    UprStroka := Copy(Editor.Lines[jc],1,4);
    if UprSimv = #12 then
    begin
      ic:=-1;
      NomStran:=NomStran+1;
    end;
    if UprStroka='----' then
    begin
      Tablica:=not Tablica;
      if Tablica then
      begin
        Sh[1]:=Editor.Lines[jc];
        Sh[2]:=Editor.Lines[jc+1];
        Sh[3]:=Editor.Lines[jc+2];
        Sh[4]:=Editor.Lines[jc+3];
      end;
      if not Tablica then
      begin
      end;
    end;

    if UprStroka='Стр.' then
    begin
      Stroka := 'Стр.' + TVentUtils.ComprStr(format('%4d',[NomStran]));
      Editor.Lines[jc] := (Stroka);
    end;

    if ((ic=MaxStrok) and (UprStroka<>'----')) then
    begin
      if Tablica then
      begin
        Editor.Lines.Insert(jc,Sh[1]);
        jc := jc+1;
      end;
      Editor.Lines.Insert(jc,#12);
      jc := jc+1;
      NomStran := NomStran+1;
      Stroka := 'Стр.' + TVentUtils.ComprStr(format('%4d',[NomStran]));
      Editor.Lines.Insert(jc,Stroka);
      jc := jc+1;
      if Tablica then
      begin
        Editor.Lines.Insert(jc,Sh[1]);
        jc:=jc+1;
        Editor.Lines.Insert(jc,Sh[2]);
        jc:=jc+1;
        Editor.Lines.Insert(jc,Sh[3]);
        jc:=jc+1;
        Editor.Lines.Insert(jc,Sh[4]);
        jc:=jc+1;
        Tablica:=True;
        ic:=6;
      end;
    end;
  end;
  }
  Result := -1;
end;

function _ReportWin_PerformFileOpen(var Win: TReportWin; const FileName: string): AError;
begin
  Win.Editor.Lines.LoadFromFile(FileName);
  _ReportWin_SetFileName(Win, FileName);
  Win.Editor.SetFocus();
  Win.Editor.Modified := False;
  _ReportWin_SetModified(Win, False);
  Result := 0;
end;

function _ReportWin_RichEditChange(const Win: TReportWin): AError;
begin
  _ReportWin_SetModified(Win, Win.Editor.Modified);
  Win.UndoButton.Enabled := SendMessage(Win.Editor.Handle, EM_CANUNDO, 0, 0) <> 0;
  Win.EditUndoItem.Enabled := Win.UndoButton.Enabled;
  Result := 0;
end;

function _ReportWin_RightIndMouseUp(var Win: TReportWin): AError;
begin
  Win.FDragging := False;
  Win.Editor.Paragraph.RightIndent := Trunc((Win.Ruler.ClientWidth-Win.RightInd.Left+Win.FDragOfs-2) / RulerAdj)-2*GutterWid;
  _ReportWin_SelectionChange(Win);
  Result := 0;
end;

function _ReportWin_RulerItemMouseDown(var Win: TReportWin; Sender: TObject; X: AInt): AError;
begin
  Win.FDragOfs := (TLabel(Sender).Width div 2);
  TLabel(Sender).Left := TLabel(Sender).Left+X-Win.FDragOfs;
  Win.FDragging := True;
  Result := 0;
end;

function _ReportWin_RulerItemMouseMove(const Win: TReportWin; Sender: TObject; X: AInt): AError;
begin
  if Win.FDragging then
    TLabel(Sender).Left :=  TLabel(Sender).Left+X-Win.FDragOfs;
  Result := 0;
end;

function _ReportWin_RulerResize(const Win: TReportWin): AError;
begin
  Win.RulerLine.Width := Win.Ruler.ClientWidth - (Win.RulerLine.Left*2);
  Result := 0;
end;

{
function _ReportWin_SaveConfiguration(Win: TReportWin; Config: AConfig): AError;
begin
  Form_SaveConfig(Self, Config);
  ASettings_WriteStringP(Config, Self.Name+'\'+cReportFont, 'Name', Editor.Font.Name);
  ASettings_WriteIntegerP(Config, Self.Name+'\'+cReportFont, 'Size', Editor.Font.Size);
  Result := 0;
end;
}

function _ReportWin_SelectionChange(var Win: TReportWin): AError;
begin
  try
    Win.FUpdating := True;
    Win.FirstInd.Left := Trunc(Win.Editor.Paragraph.FirstIndent*RulerAdj)-4+GutterWid;
    Win.LeftInd.Left := Trunc((Win.Editor.Paragraph.LeftIndent+Win.Editor.Paragraph.FirstIndent)*RulerAdj)-4+GutterWid;
    Win.RightInd.Left := Win.Ruler.ClientWidth-6-Trunc((Win.Editor.Paragraph.RightIndent+GutterWid)*RulerAdj);
    Win.BoldButton.Down := fsBold in Win.Editor.SelAttributes.Style;
    Win.ItalicButton.Down := fsItalic in Win.Editor.SelAttributes.Style;
    Win.UnderlineButton.Down := fsUnderline in Win.Editor.SelAttributes.Style;
    Win.BulletsButton.Down := Boolean(Win.Editor.Paragraph.Numbering);
    Win.FontSize.Text := AUtils_IntToStrP(Win.Editor.SelAttributes.Size);
    Win.FontName.Text := Win.Editor.SelAttributes.Name;
    case Ord(Win.Editor.Paragraph.Alignment) of
      0: Win.LeftAlign.Down := True;
      1: Win.RightAlign.Down := True;
      2: Win.CenterAlign.Down := True;
    end;
    _ReportWin_UpdateCursorPos(Win);
  finally
    Win.FUpdating := False;
  end;
  Result := 0;
end;

function _ReportWin_SetEditRect(const Win: TReportWin): AError;
var
  R: TRect;
begin
  R := Rect(GutterWid, 0, Win.Editor.ClientWidth - GutterWid, Win.Editor.ClientHeight);
  SendMessage(Win.Form.Handle, EM_SETRECT, 0, Longint(@R));
  Result := 0;
end;

function _ReportWin_SetFileName(var Win: TReportWin; const Value: string): AError;
begin
  Win.FFileName := Value;
  Win.Form.Caption := AUtils_FormatStrStrP('Report - %s', AUtils_ExtractFileNameP(Value));
  Result := 0;
end;

function _ReportWin_SetInitialDir(const Win: TReportWin; const Value: string): AError;
begin
  Win.OpenDialog.InitialDir := Value;
  Win.SaveDialog.InitialDir := Value;
  Result := 0;
end;

function _ReportWin_SetModified(const Win: TReportWin; Value: ABool): AError;
begin
  if Value then
    Win.StatusBar.Panels[1].Text := 'Modified'
  else
    Win.StatusBar.Panels[1].Text := '';
  Result := 0;
end;

function _ReportWin_SetupRuler(const Win: TReportWin): AError;
var
  I: Integer;
  S: String;
begin
  SetLength(S, 201);
  I := 1;
  while (I < 200) do
  begin
    S[I] := #9;
    S[I+1] := '|';
    Inc(I, 2);
  end;
  Win.Ruler.Caption := S;
  Result := 0;
end;

function _ReportWin_SelectAllText(const Win: TReportWin): AError;
var
  Size: Integer;
  Buffer: PChar;
begin
  Size := Win.Editor.GetTextLen();
  Inc(Size);
  GetMem(Buffer, Size);
  Win.Editor.GetTextBuf(Buffer, Size);
  Win.RicheditRGV.SetSelTextBuf(Buffer);
  FreeMem(Buffer, Size);
  Result := 0;
end;

function _ReportWin_SelectFont(const Win: TReportWin): AError;
begin
  Win.FontDialog1.Font.Assign(Win.Editor.SelAttributes);
  if Win.FontDialog1.Execute then
    _ReportWin_GetCurrText(Win).Assign(Win.FontDialog1.Font);
  Win.Editor.SetFocus();
  Win.Editor.Font := Win.FontDialog1.Font;
  Result := 0;
end;

function _ReportWin_UnderlineButtonClick(const Win: TReportWin): AError;
var
  CurrText: TTextAttributes;
begin
  if Win.FUpdating then
  begin
    Result := 1;
    Exit;
  end;
  CurrText := _ReportWin_GetCurrText(Win);
  if Win.UnderlineButton.Down then
    CurrText.Style := CurrText.Style + [fsUnderline]
  else
    CurrText.Style := CurrText.Style - [fsUnderline];
  Result := 0;
end;

function _ReportWin_UpdateCursorPos(const Win: TReportWin): AError;
var
  CharPos: TPoint;
begin
  CharPos.Y := SendMessage(Win.Editor.Handle, EM_EXLINEFROMCHAR, 0, Win.Editor.SelStart);
  CharPos.X := (Win.Editor.SelStart - SendMessage(Win.Editor.Handle, EM_LINEINDEX, CharPos.Y, 0));
  Inc(CharPos.Y);
  Inc(CharPos.X);
  Win.StatusBar.Panels[0].Text := 'Line: ' + AUtils_FormatIntP(CharPos.Y, 3) +
      '   Col: ' + AUtils_FormatIntP(CharPos.X, 3);

  // update the status of the cut and copy command
  Win.CopyButton.Enabled := (Win.Editor.SelLength > 0);
  Win.EditCopyItem.Enabled := Win.CopyButton.Enabled;
  Win.CutButton.Enabled := Win.CopyButton.Enabled;
  Win.EditCutItem.Enabled := Win.CopyButton.Enabled;

  Result := 0;
end;

procedure _ReportWin_WMChangeCBChain(Win: TReportWin; var Msg: TWMChangeCBChain);
begin
  if (Msg.Remove = Win.FClipboardOwner) then
    Win.FClipboardOwner := Msg.Next
  else
    SendMessage(Win.FClipboardOwner, WM_CHANGECBCHAIN, Msg.Remove, Msg.Next);
  Msg.Result := 0;
end;

procedure _ReportWin_WMDrawClipboard(const Win: TReportWin; var Msg: TWMDrawClipboard);
begin
  SendMessage(Win.FClipboardOwner, WM_DRAWCLIPBOARD, 0, 0);
  Msg.Result := 0;
end;

procedure _ReportWin_WMDropFiles(const Win: TReportWin; var Msg: TWMDropFiles);
//var
//  CFileName: array[0..MAX_PATH] of Char;
begin
{
  try
    if DragQueryFile(Msg.Drop, 0, CFileName, MAX_PATH) > 0 then
    begin
      CheckFileSave;
//      PerformFileOpen(CFileName);
      Msg.Result := 0;
    end;
  finally
    DragFinish(Msg.Drop);
  end;
}
end;

// --- ReportWin ---

function ReportWin_NewP(const Text: APascalString): AWindow;
var
  W: ^TReportWin;
begin
  GetMem(W, SizeOf(TReportWin));
  _ReportWin_New(W^, Text, nil, 0, 0);
  Result := AWindow(W^.Form);
end;

function ReportWin_ShowReportP(const Text: APascalString; Font: AFont; Width, Height: AInt): AError;
var
  Win: TReportWin;
begin
  if (_ReportWin_New(Win, Text, TFont(Font), 0, 0) < 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    Win.Form.ShowModal();
  finally
    Win.Form.Free();
  end;
  Result := 0;
end;

end.
