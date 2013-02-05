{**
@Author Prof1983 <prof1983@ya.ru>
@Created 01.09.2005
@LastMod 04.02.2013

See AStdWinDialog.txt
}
unit AStdWinDialog;

interface

uses
  Windows, ShlObj, SysUtils;

type
  {$Z4}
  TOpenFileEnum = (OFN_READONLY, OFN_OVERWRITEPROMPT,
                   OFN_HIDEREADONLY, OFN_NOCHANGEDIR, OFN_SHOWHELP,
                   OFN_ENABLEHOOK, OFN_ENABLETEMPLATE, OFN_ENABLETEMPLATEHANDLE,
                   OFN_NOVALIDATE, OFN_ALLOWMULTISELECT, OFN_EXTENSIONDIFFERENT,
                   OFN_PATHMUSTEXIST, OFN_FILEMUSTEXIST, OFN_CREATEPROMPT,
                   OFN_SHAREAWARE, OFN_NOREADONLYRETURN, OFN_NOTESTFILECREATE,
                   OFN_NONETWORKBUTTON, OFN_NOLONGNAMES, OFN_EXPLORER,
                   OFN_NODEREFERENCELINKS, OFN_LONGNAMES,
                   OFN_ENABLEINCLUDENOTIFY, OFN_ENABLESIZING);
  TOpenFileSet = set of TOpenFileEnum;

  POpenFilename = ^TOpenFilename;
  TOpenFilename = packed record
    lStructSize: LongWord;
    hWndOwner: HWND;
    hInstance: HINST;
    lpstrFilter: PAnsiChar;
    lpstrCustomFilter: PAnsiChar;
    nMaxCustFilter: LongWord;
    nFilterIndex: LongWord;
    lpstrFile: PAnsiChar;
    nMaxFile: LongWord;
    lpstrFileTitle: PAnsiChar;
    nMaxFileTitle: LongWord;
    lpstrInitialDir: PAnsiChar;
    lpstrTitle: PAnsiChar;
    Flags: TOpenFileSet;
    nFileOffset: Word;
    nFileExtension: Word;
    lpstrDefExt: PAnsiChar;
    lCustData: Longint;
    lpfnHook: function(Wnd: HWND; Msg: LongWord; wParam: Longint; lParam: Longint): LongWord stdcall;
    lpTemplateName: PAnsiChar;
    pvReserved: Pointer;
    dwReserved: LongWord;
    dwFlagsEx: LongWord;
  end;
  {$Z1}

procedure ShowError(AWindow: THandle; const ACaption: string; const AMsgText: string);

procedure ShowError1(AWindow: THandle; const ACaption: WideString; const AMsgText: WideString; const AParam: array of const);

procedure ShowWarning(AWindow: THandle; const ACaption: WideString; const AMsgText: WideString; const AParam: array of const);

procedure ShowInfo(AWindow: THandle; const ACaption: WideString; const AMsgText: WideString; const AParam: array of const);

function ShowQueryYesNo(AWindow: THandle; const ACaption: WideString; const AMsgText: WideString; const AParam: array of const): boolean;

function SelectDir(AWindow: THandle; const ACaption: string; const ARootDir: string; var ASelDir: string): boolean;

function ShowServerDialog(AWindow: THandle; var ASelHost: string): boolean;

function SelectFileDialog(var AOpenFile: TOpenFilename): Boolean;

implementation

const
  BIF_NEWDIALOGSTYLE = $40;

{ External }

function GetOpenFileName(var OpenFile: TOpenFilename): Bool; stdcall; external 'comdlg32.dll' name 'GetOpenFileNameA';
function CommDlgExtendedError(): LongWord; stdcall; external 'comdlg32.dll' name 'CommDlgExtendedError';

{ Public }

function SelectFileDialog(var AOpenFile: TOpenFilename): Boolean;
begin
  AOpenFile.lStructSize := SizeOf(AOpenFile);
  Result := GetOpenFileName(AOpenFile);
end;

function SelectDir(AWindow: THandle; const ACaption: string; const ARootDir: string; var ASelDir: string): boolean;
type
  TParseDisplayName = function(pszPath: PAnsiChar; pbc: pointer; var pidl: PItemIDList; sfgaoIn: LongWord; var psfgaoOut: LongWord): LongInt; //stdcall; external 'shell32.dll' name 'SHParseDisplayName';
var
  tmpLongWord: LongWord;
  lpItemID: PItemIDList;
  BrowseInfo: TBrowseInfo;
  DisplayName: array [0..MAX_PATH] of char;
  TempPath: array [0..MAX_PATH] of char;
  tmpStrDir: WideString;

  h: THandle;
  SHParseDisplayName: TParseDisplayName;
begin
  Result := False;

  h := LoadLibrary('shell32.dll');
  if h < 32 then Exit;
  SHParseDisplayName := GetProcAddress(h, 'SHParseDisplayName');
  if Assigned(SHParseDisplayName) then
  begin
    FreeLibrary(h);

    FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
    BrowseInfo.hwndOwner := AWindow;
    BrowseInfo.pszDisplayName := @DisplayName;
    BrowseInfo.lpszTitle := PChar(ACaption);
    BrowseInfo.ulFlags := BIF_RETURNONLYFSDIRS;
    lpItemID := SHBrowseForFolder(BrowseInfo);
    if lpItemId <> nil then
    begin
      SHGetPathFromIDList(lpItemID, TempPath);
      ASelDir := TempPath;
      GlobalFreePtr(lpItemID);
      Result := True;
    end
    else
      ASelDir := '';

    Exit;
  end;

  FillChar(BrowseInfo, SizeOf(TBrowseInfo), #0);
  // General information
  BrowseInfo.hwndOwner := AWindow;
  BrowseInfo.pszDisplayName := @DisplayName;
  BrowseInfo.lpszTitle := PChar(ACaption);
  BrowseInfo.ulFlags := BIF_RETURNONLYFSDIRS;
  // Root directory
  tmpLongWord := SFGAO_FOLDER;
  tmpStrDir := ARootDir + #0;
  if (SHParseDisplayName(PAnsiChar(PWideChar(tmpStrDir)), nil, lpItemID, tmpLongWord, tmpLongWord) <> S_OK) then
    lpItemID := nil;
  BrowseInfo.pidlRoot := lpItemID;
  // Show dialog
  lpItemID := SHBrowseForFolder(BrowseInfo);
  if (lpItemId <> nil) then
    if SHGetPathFromIDList(lpItemID, TempPath) then
    begin
      ASelDir := TempPath;
      GlobalFreePtr(lpItemID);
      Result := True;
    end;
  FreeLibrary(h);
end;

function ShowServerDialog(AWindow: THandle; var ASelHost: string): boolean;
type
  TServerBrowseDialogA0 = function(AWnd: HWND; ABuffer: Pointer; ABufSize: LongWord): LongBool; stdcall;
var
  ServerBrowseDialogA0: TServerBrowseDialogA0;
  LANMAN_DLL: DWORD;
  Buffer: array [0..1024] of char;
  bLoadLib: Boolean;
begin
  ASelHost := '';
  bLoadLib := False;
  LANMAN_DLL := GetModuleHandle('NTLANMAN.DLL');
  if (LANMAN_DLL = 0) then
  begin
    LANMAN_DLL := LoadLibrary('NTLANMAN.DLL');
    bLoadLib := True;
  end;
  if (LANMAN_DLL <> 0) then
  begin
    @ServerBrowseDialogA0 := GetProcAddress(LANMAN_DLL, 'ServerBrowseDialogA0');
    DialogBox(HInstance, MAKEINTRESOURCE(101), AWindow, nil);
    ServerBrowseDialogA0(AWindow, @Buffer, 1024);
    if Buffer[0] = '\' then ASelHost := Copy(Buffer, 3, Length(Buffer));
    if bLoadLib then FreeLibrary(LANMAN_DLL);
  end;
  Result := (ASelHost <> '');
end;

function ShowQueryYesNo(AWindow: THandle; const ACaption: WideString; const AMsgText: WideString; const AParam: array of const): boolean;
begin
  try
    if (AWindow <> 0) then
      Result := (MessageBoxEx(AWindow, PChar(Format(AMsgText, AParam)), PChar(string(ACaption)), MB_ICONQUESTION or MB_YESNO or MB_APPLMODAL, $0419) = IDYES)
    else
      Result := (MessageBoxEx(0, PChar(Format(AMsgText, AParam)), PChar(string(ACaption)), MB_SERVICE_NOTIFICATION or MB_ICONQUESTION or MB_YESNO or MB_APPLMODAL, $0419) = IDYES);
  except
    Result := False;
  end;
end;

procedure ShowError(AWindow: THandle; const ACaption: string; const AMsgText: string);
begin
  try
    if (AWindow <> 0) then
      MessageBoxEx(AWindow, PChar(AMsgText), PChar(ACaption), MB_ICONERROR or MB_OK, $0419)
    else
      MessageBoxEx(0, PChar(AMsgText), PChar(ACaption), MB_SERVICE_NOTIFICATION or MB_ICONERROR or MB_OK, $0419);
  except
  end;
end;

procedure ShowError1(AWindow: THandle; const ACaption: WideString; const AMsgText: WideString; const AParam: array of const);
begin
  try
    if (AWindow <> 0) then
      MessageBoxEx(AWindow, PChar(Format(AMsgText, AParam)), PChar(string(ACaption)), MB_ICONERROR or MB_OK, $0419)
    else
      MessageBoxEx(0, PChar(Format(AMsgText, AParam)), PChar(string(ACaption)), MB_SERVICE_NOTIFICATION or MB_ICONERROR or MB_OK, $0419);
  except
  end;
end;

procedure ShowWarning(AWindow: THandle; const ACaption: WideString; const AMsgText: WideString; const AParam: array of const);
begin
  try
    if (AWindow <> 0) then
      MessageBoxEx(AWindow, PChar(Format(AMsgText, AParam)), PChar(string(ACaption)), MB_ICONWARNING or MB_OK, $0419)
    else
      MessageBoxEx(0, PChar(Format(AMsgText, AParam)), PChar(string(ACaption)), MB_SERVICE_NOTIFICATION or MB_ICONWARNING or MB_OK, $0419);
  except
  end;
end;

procedure ShowInfo(AWindow: THandle; const ACaption: WideString; const AMsgText: WideString; const AParam: array of const);
begin
  try
    if (AWindow <> 0) then
      MessageBoxEx(AWindow, PChar(Format(AMsgText, AParam)), PChar(string(ACaption)), MB_ICONINFORMATION or MB_OK, $0419)
    else
      MessageBoxEx(0, PChar(Format(AMsgText, AParam)), PChar(string(ACaption)), MB_SERVICE_NOTIFICATION or MB_ICONINFORMATION or MB_OK, $0419);
  except
  end;
end;

end.
