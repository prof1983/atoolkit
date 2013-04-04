{**
@Abstract Report building RichEdit form
@Author Prof1983 <prof1983@ya.ru>
@Created 10.11.2008
@LastMod 30.01.2013
}
unit fReport;

interface

uses
  {$IFDEF FPC}LResources,{$ENDIF}
  Buttons, Classes, ClipBrd, ComCtrls, Controls, Dialogs, ExtCtrls, Forms, Graphics, ImgList,
  Menus, Messages, Printers, RichEdit, StdCtrls, SysUtils, ToolWin, Windows,
  ABase,
  ASettingsMain,
  AUiForm;

type
  TReportForm = class(TForm)
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
  public
    {$IFNDEF FPC}
    Editor: TRichEdit;
    PrintDialog: TPrintDialog;
    RichEditRGV: TRichEdit;
    {$ENDIF}
  private
    FFileName: string;
    FUpdating: Boolean;
    FDragOfs: Integer;
    FDragging: Boolean;
    FClipboardOwner: HWnd;
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
  protected
    procedure DoCreate; override;
  public
    procedure AddLine(const Text: string);
    procedure Clear;
    procedure LoadConfiguration(Config: AConfig);
    procedure SaveConfiguration(Config: AConfig);
    procedure SelectAllText;
    procedure SetInitialDir(const Value: string);
  end;

{** Displays a modal window with the report }
procedure ShowReport(const Text: string; Font: TFont); deprecated; // Use AUiReports.UI_ReportWin_ShowReport()

implementation

const
  RulerAdj = 4/3;
  GutterWid = 6;

const
  cReportFont = 'Font';

{$IFNDEF FPC}
  {$R *.DFM}
{$ENDIF}

{ Procedures }

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;

procedure ShowReport(const Text: string; Font: TFont);
var
  Form: TReportForm;
begin
  Form := TReportForm.Create(nil);
  try
    Form.Editor.Clear;
    Form.Editor.Text := Text;
    if Assigned(Font) then
      Form.Editor.Font.Assign(Font);
    Form.ShowModal;
  finally
    Form.Free;
  end;
end;

{ TReportForm }

procedure TReportForm.AddLine(const Text: string);
begin
  Editor.Lines.Add(Text);
end;

procedure TReportForm.CheckFileSave;
var
  SaveResp: Integer;
begin
  if not Editor.Modified then Exit;
  SaveResp := MessageDlg(Format('Save %s?', [FFileName]),
    mtConfirmation, mbYesNoCancel, 0);
  case SaveResp of
    idYes: FileSave(Self);
    idNo: {Nothing};
    idCancel: Abort;
  end;
end;

procedure TReportForm.Clear;
begin
  Editor.Clear;
end;

procedure TReportForm.DoCreate;
begin
  inherited DoCreate;

  {$IFNDEF FPC}
  PrintDialog := TPrintDialog.Create(Self);
  PrintDialog.Options := [poPageNums, poSelection, poWarning];
  //PrintDialog.Left = 562;
  //PrintDialog.Top = 308;

  Editor := TRichEdit.Create(Self);
  Editor.Parent := Self;
  Editor.Left := 0;
  Editor.Top := 55;
  Editor.Width := 853;
  Editor.Height := 618;
  Editor.HelpContext := 400;
  Editor.Align := alClient;
  Editor.Font.Charset := RUSSIAN_CHARSET;
  Editor.Font.Color := clBlack;
  Editor.Font.Height := -15;
  Editor.Font.Name := 'Courier New';
  Editor.Font.Style := [];
  Editor.ParentFont := False;
  Editor.ScrollBars := ssBoth;
  Editor.TabOrder := 1;
  Editor.WantTabs := True;
  Editor.OnChange := RichEditChange;
  Editor.OnSelectionChange := SelectionChange;

  RichEditRGV := TRichEdit.Create(Self);
  RichEditRGV.Parent := Self;
  RichEditRGV.Left := 920;
  RichEditRGV.Top := 72;
  RichEditRGV.Width := 1;
  RichEditRGV.Height := 1;
  RichEditRGV.TabOrder := 4;
  RichEditRGV.Visible := False;

  ActiveControl := Editor;
  {$ENDIF}

  SetFileName('Report1.rtf');
  GetFontNames;
  SetupRuler;
  SelectionChange(Self);
  FClipboardOwner := SetClipboardViewer(Handle);
  Editor.Modified := False;

  Left := 10;
  Top := 10;
  Width := 300;
  Height := 300;
end;

procedure TReportForm.FileNew(Sender: TObject);
begin
  CheckFileSave;
  SetFileName('Report1.rtf');
  Editor.Lines.Clear;
  Editor.Modified := False;
  SetModified(False);
end;

function TReportForm.GetCurrText: TTextAttributes;
begin
  if (Editor.SelLength > 0) then
    Result := Editor.SelAttributes
  else
    Result := Editor.DefAttributes;
end;

procedure TReportForm.GetFontNames;
var
  DC: HDC;
begin
  DC := GetDC(0);
  EnumFonts(DC, nil, @EnumFontsProc, Pointer(FontName.Items));
  ReleaseDC(0, DC);
  FontName.Sorted := True;
end;

procedure TReportForm.SelectionChange(Sender: TObject);
begin
  with Editor.Paragraph do
  try
    FUpdating := True;
    FirstInd.Left := Trunc(FirstIndent*RulerAdj)-4+GutterWid;
    LeftInd.Left := Trunc((LeftIndent+FirstIndent)*RulerAdj)-4+GutterWid;
    RightInd.Left := Ruler.ClientWidth-6-Trunc((RightIndent+GutterWid)*RulerAdj);
    BoldButton.Down := fsBold in Editor.SelAttributes.Style;
    ItalicButton.Down := fsItalic in Editor.SelAttributes.Style;
    UnderlineButton.Down := fsUnderline in Editor.SelAttributes.Style;
    BulletsButton.Down := Boolean(Numbering);
    FontSize.Text := IntToStr(Editor.SelAttributes.Size);
    FontName.Text := Editor.SelAttributes.Name;
    case Ord(Alignment) of
      0: LeftAlign.Down := True;
      1: RightAlign.Down := True;
      2: CenterAlign.Down := True;
    end;
    UpdateCursorPos;
  finally
    FUpdating := False;
  end;
end;

procedure TReportForm.SetFileName(const Value: string);
begin
  FFileName := Value;
  Caption := Format('%s - %s', ['Report ', ExtractFileName(Value)]);
end;

procedure TReportForm.SetupRuler;
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
  Ruler.Caption := S;
end;

procedure TReportForm.SetEditRect;
var
  R: TRect;
begin
  R := Rect(GutterWid, 0, Editor.ClientWidth-GutterWid, Editor.ClientHeight);
  SendMessage(Handle, EM_SETRECT, 0, Longint(@R));
end;

procedure TReportForm.PerformFileOpen(const AFileName: string);
begin
  //CheckFileSave;
  Editor.Lines.LoadFromFile(AFileName);
  SetFileName(AFileName);
  Editor.SetFocus;
  Editor.Modified := False;
  SetModified(False);
end;

procedure TReportForm.FileOpen(Sender: TObject);
begin
  CheckFileSave;
  if OpenDialog.Execute then
  begin
    PerformFileOpen(OpenDialog.FileName);
    Editor.ReadOnly := ofReadOnly in OpenDialog.Options;
  end;
end;

procedure TReportForm.FileSave(Sender: TObject);
begin
  if FFileName = 'Untitled' then
    FileSaveAs(Sender)
  else
  begin
    Editor.Lines.SaveToFile(FFileName);
    Editor.Modified := False;
    SetModified(False);
  end;
end;

procedure TReportForm.FileSaveAs(Sender: TObject);
begin
  if SaveDialog.Execute then
    SaveDialog.FileName:=ChangeFileExt(SaveDialog.FileName,'.rtf');
  if FileExists(SaveDialog.FileName) then
    if MessageDlg(Format('File exists. Rewrite %s?', [SaveDialog.FileName]), mtConfirmation, mbYesNoCancel, 0) <> idYes then Exit;
  Editor.Lines.SaveToFile(SaveDialog.FileName);
  SetFileName(SaveDialog.FileName);
  Editor.Modified := False;
  SetModified(False);
end;

procedure TReportForm.FilePrint(Sender: TObject);
begin
  {Editor.PageRect.Top:=Status.Kolstolb;
  Editor.PageRect.Bottom:=20;}
  if PrintDialog.Execute then
    Editor.Print(FFileName);
end;

procedure TReportForm.FileExit(Sender: TObject);
begin
  Close;
end;

procedure TReportForm.EditUndo(Sender: TObject);
begin
  with Editor do
    if HandleAllocated then SendMessage(Handle, EM_UNDO, 0, 0);
end;

procedure TReportForm.EditCut(Sender: TObject);
begin
  Editor.CutToClipboard;
end;

procedure TReportForm.EditCopy(Sender: TObject);
begin
  Editor.CopyToClipboard;
end;

procedure TReportForm.EditPaste(Sender: TObject);
begin
  Editor.PasteFromClipboard;
end;

procedure TReportForm.SelectFont(Sender: TObject);
begin
  FontDialog1.Font.Assign(Editor.SelAttributes);
  if FontDialog1.Execute then
    GetCurrText.Assign(FontDialog1.Font);
  Editor.SetFocus;
  Editor.Font := FontDialog1.Font;
end;

procedure TReportForm.RulerResize(Sender: TObject);
begin
  RulerLine.Width := Ruler.ClientWidth - (RulerLine.Left*2);
end;

procedure TReportForm.FormResize(Sender: TObject);
begin
  SetEditRect();
  SelectionChange(Sender);
end;

procedure TReportForm.FormPaint(Sender: TObject);
begin
  SetEditRect();
end;

procedure TReportForm.BoldButtonClick(Sender: TObject);
var
  CurrText: TTextAttributes;
begin
  if FUpdating then Exit;
  CurrText := GetCurrText;
  if BoldButton.Down then
    CurrText.Style := CurrText.Style + [fsBold]
  else
    CurrText.Style := CurrText.Style - [fsBold];
end;

procedure TReportForm.ItalicButtonClick(Sender: TObject);
var
  CurrText: TTextAttributes;
begin
  if FUpdating then Exit;
  CurrText := GetCurrText;
  if ItalicButton.Down then
    CurrText.Style := CurrText.Style + [fsItalic]
  else
    CurrText.Style := CurrText.Style - [fsItalic];
end;

procedure TReportForm.FontSizeChange(Sender: TObject);
var
  CurrText: TTextAttributes;
begin
  if FUpdating then Exit;
  CurrText := GetCurrText;
  CurrText.Size := StrToInt(FontSize.Text);
  Editor.Font.Size := CurrText.Size;
end;

procedure TReportForm.AlignButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  Editor.Paragraph.Alignment := TAlignment(TControl(Sender).Tag);
end;

procedure TReportForm.FontNameChange(Sender: TObject);
var
  CurrText: TTextAttributes;
begin
  if FUpdating then Exit;
  CurrText := GetCurrText;
  CurrText.Name := FontName.Items[FontName.ItemIndex];
  Editor.Font.Name := CurrText.Name;
end;

procedure TReportForm.UnderlineButtonClick(Sender: TObject);
var
  CurrText: TTextAttributes;
begin
  if FUpdating then Exit;
  CurrText := GetCurrText;
  if UnderlineButton.Down then
    CurrText.Style := CurrText.Style + [fsUnderline]
  else
    CurrText.Style := CurrText.Style - [fsUnderline];
end;

procedure TReportForm.BulletsButtonClick(Sender: TObject);
begin
  if FUpdating then Exit;
  Editor.Paragraph.Numbering := TNumberingStyle(BulletsButton.Down);
end;

{ Ruler Indent Dragging }

procedure TReportForm.RulerItemMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragOfs := (TLabel(Sender).Width div 2);
  TLabel(Sender).Left := TLabel(Sender).Left+X-FDragOfs;
  FDragging := True;
end;

procedure TReportForm.RulerItemMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if FDragging then
    TLabel(Sender).Left :=  TLabel(Sender).Left+X-FDragOfs
end;

procedure TReportForm.FirstIndMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragging := False;
  Editor.Paragraph.FirstIndent := Trunc((FirstInd.Left+FDragOfs-GutterWid) / RulerAdj);
  LeftIndMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TReportForm.LeftIndMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragging := False;
  Editor.Paragraph.LeftIndent := Trunc((LeftInd.Left+FDragOfs-GutterWid) / RulerAdj)-Editor.Paragraph.FirstIndent;
  SelectionChange(Sender);
end;

procedure TReportForm.RightIndMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragging := False;
  Editor.Paragraph.RightIndent := Trunc((Ruler.ClientWidth-RightInd.Left+FDragOfs-2) / RulerAdj)-2*GutterWid;
  SelectionChange(Sender);
end;

procedure TReportForm.UpdateCursorPos;
var
  CharPos: TPoint;
begin
  CharPos.Y := SendMessage(Editor.Handle, EM_EXLINEFROMCHAR, 0, Editor.SelStart);
  CharPos.X := (Editor.SelStart - SendMessage(Editor.Handle, EM_LINEINDEX, CharPos.Y, 0));
  Inc(CharPos.Y);
  Inc(CharPos.X);
  StatusBar.Panels[0].Text := Format('Line: %3d   Col: %3d', [CharPos.Y, CharPos.X]);

  // update the status of the cut and copy command
  CopyButton.Enabled := Editor.SelLength > 0;
  EditCopyItem.Enabled := CopyButton.Enabled;
  CutButton.Enabled := CopyButton.Enabled;
  EditCutItem.Enabled := CopyButton.Enabled;
end;

procedure TReportForm.FormShow(Sender: TObject);
begin
  UpdateCursorPos;
  RichEditChange(nil);
  Editor.SetFocus;
end;

procedure TReportForm.WMDropFiles(var Msg: TWMDropFiles);
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

procedure TReportForm.RichEditChange(Sender: TObject);
begin
  SetModified(Editor.Modified);
  UndoButton.Enabled := SendMessage(Editor.Handle, EM_CANUNDO, 0, 0) <> 0;
  EditUndoItem.Enabled := UndoButton.Enabled;
end;

procedure TReportForm.SetModified(Value: Boolean);
begin
  if Value then StatusBar.Panels[1].Text := 'Modified'
  else StatusBar.Panels[1].Text := '';
end;

procedure TReportForm.WMChangeCBChain(var Msg: TWMChangeCBChain);
begin
  if Msg.Remove = FClipboardOwner then FClipboardOwner := Msg.Next
  else SendMessage(FClipboardOwner, WM_CHANGECBCHAIN, Msg.Remove, Msg.Next);
  Msg.Result := 0;
end;

procedure TReportForm.WMDrawClipboard(var Msg: TWMDrawClipboard);
begin
  SendMessage(FClipboardOwner, WM_DRAWCLIPBOARD, 0, 0);
  Msg.Result := 0;
end;

procedure TReportForm.FormDestroy(Sender: TObject);
begin
  // remove ourselves from the viewer chain
  ChangeClipboardChain(Handle, FClipboardOwner);
end;

procedure TReportForm.PagesMenuItemClick(Sender: TObject);
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
end;

procedure TReportForm.DelimerMenuItemClick(Sender: TObject);
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
end;

procedure TReportForm.FilePrinItemStrClick(Sender: TObject);
var
  PrintText: TextFile;
  line: Integer;
  ss: Char;
begin
  if PrintDialog.Execute then
  begin
    AssignPrn(PrintText);
    Rewrite(PrintText);
    Printer.Canvas.Font := Editor.Font;
    Writeln(PrintText,' ');
    for line := 0 to Editor.Lines.Count - 1 do
    begin
      ss := Copy(Editor.Lines[line],1,1)[1];
      if ss = '#' then
      begin
        Writeln(PrintText, ' ');
        Writeln(PrintText, #12);
        Writeln(PrintText, ' ');
      end;
      writeln(PrintText, '      ', Editor.Lines[line]);
    end;
    System.Close(PrintText);
  end;
end;

procedure TReportForm.LoadConfiguration(Config: AConfig);
begin
  Form_LoadConfig(Self, Config);
  Editor.Font.Name := ASettings_ReadStringDefP(Config, Self.Name+'\'+cReportFont, 'Name', 'Courier New Cyr');
  Editor.Font.Size := ASettings_ReadIntegerDefP(Config, Self.Name+'\'+cReportFont, 'Size', 10);
end;

procedure TReportForm.SaveConfiguration(Config: AConfig);
begin
  Form_SaveConfig(Self, Config);
  ASettings_WriteStringP(Config, Self.Name+'\'+cReportFont, 'Name', Editor.Font.Name);
  ASettings_WriteIntegerP(Config, Self.Name+'\'+cReportFont, 'Size', Editor.Font.Size);
end;

procedure TReportForm.SelectAllText;
var
  Size: Integer;
  Buffer: PChar;
begin
  Size := Editor.GetTextLen;
  Inc(Size);
  GetMem(Buffer, Size);
  Editor.GetTextBuf(Buffer,Size);
  RicheditRGV.SetSelTextBuf(Buffer);
  FreeMem(Buffer, Size);
end;

procedure TReportForm.SetInitialDir(const Value: string);
begin
  OpenDialog.InitialDir := Value;
  SaveDialog.InitialDir := Value;
end;

initialization
{$IFDEF FPC}
  {$I fReport.lrs}
{$ENDIF}
end.
