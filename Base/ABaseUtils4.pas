{**
@Author Prof1983 <prof1983@ya.ru>
@Created 13.03.2007
@LastMod 04.02.2013
}
unit AUtils1;

interface

uses
  SysUtils, Windows, WinSock,
  ATypes;

function DecodeOleError(ACode: LongWord): string;

function GetCompName(): string;

{** Return version x.x.x.x }
function GetFileVersionString4(const AFileName: string): string;

{** Return string IP addres by host name }
function GetStrIPAddress(const AHostName: string): string;

{** Return string IP addres by host name }
function GetStrIPAddressA(const AHostName: AnsiString): string;

function GetWinVersion: TWinVersion;

implementation

function DecodeOleError(ACode: LongWord): string;
begin
  Result := '$' + IntToHex(ACode, 8);
  case ACode of
    $80030001: Result := Result + ' (Unable to perform requested operation)'; // STG_E_INVALIDFUNCTION
    $80030003: Result := Result + ' (The path could not be found)';
    $80030005: Result := Result + ' (Access Denied)';
    $80030009: Result := Result + ' (Invalid pointer error)';
    $800300FF: Result := Result + ' (Invalid flag error)';
    $80030050: Result := Result + ' (Already exists)';
    $80030057: Result := Result + ' (Invalid parameter error)';
    $800300FC: Result := Result + ' (The name is not valid)';
    $80030101: Result := Result + ' (The storage has been changed since the last commit)';  // STG_E_NOTCURRENT
    $80030102: Result := Result + ' (Attempted to use an object that has ceased to exist)'; // STG_E_REVERTED
  end;
end;

function GetCompName(): string;
var
  TmpPChar: array [0..512] of AnsiChar;
  S: AnsiString;
  Version: word;
  VerData: TWSAData;
begin
  Result := 'localhost';
  Version := MakeWord(2, 0);
  if (WSAStartup(Version, VerData) <> 0) then Exit;
  if (GetHostName(TmpPChar, SizeOf(TmpPChar)) = 0) then
  begin
    S := TmpPChar;
    Result := string(S);
  end;
  WSACleanup();
end;

function GetFileVersion(const FileName: string; var MS, LS: DWORD): boolean;
var
  Wnd,InfoSize,VerSize: DWORD;
  VersionInfo: Pointer;
  FileInfo: PVSFixedFileInfo;
begin
  Result := False;
  InfoSize := GetFileVersionInfoSize(PChar(FileName), Wnd);
  if (InfoSize <> 0) then
  begin
    GetMem(VersionInfo, InfoSize);
    if GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, VersionInfo) then
      if VerQueryValue(VersionInfo, '\', Pointer(FileInfo), VerSize) then
      begin
        MS := FileInfo^.dwFileVersionMS;
        LS := FileInfo^.dwFileVersionLS;
        Result := True;
      end;
    FreeMem(VersionInfo);
  end;
end;

function GetFileVersionString4(const AFileName: string): string;
var
  MS, LS: DWORD;
begin
  if GetFileVersion(AFileName, MS, LS) then
    Result := Format('%d.%d.%d.%d',[HiWord(MS), LoWord(MS), HiWord(LS), LoWord(LS)])
  else
    Result := '-.-.-.-';
end;

function GetStrIPAddress(const AHostName: string): string;
begin
  Result := GetStrIpAddressA(AnsiString(AHostName));
end;

function GetStrIPAddressA(const AHostName: AnsiString): string;
var
  HostEnt: PHostEnt;
  Addr: PAnsiChar;
  Version: word;
  VerData: TWSAData;
begin
  Result := string(AHostName);
  Version := MakeWord(2, 0);
  if (WSAStartup(Version, VerData) <> 0) then Exit;
  HostEnt := GetHostByName(PAnsiChar(AHostName));
  if Assigned(HostEnt) then
  begin
    if Assigned(HostEnt^.H_Addr_List) then
    begin
      Addr := HostEnt^.H_Addr_List^;
      if Assigned(Addr) then
        Result := Format('%d.%d.%d.%d', [byte(Addr[0]), byte(Addr[1]), byte(Addr[2]), byte(Addr[3])]);
    end;
  end;
  WSACleanup();
end;

function GetWinVersion(): TWinVersion;
var
  OSVersionInfo: TOSVersionInfo;
begin
  Result := wvUnknown;
  OSVersionInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  if GetVersionEx(OSVersionInfo) then
  begin
    case OSVersionInfo.DwMajorVersion of
      3: Result := wvNT3;
      4: case OSVersionInfo.DwMinorVersion of
           0: if (OSVersionInfo.dwPlatformId = VER_PLATFORM_WIN32_NT) then
                Result := wvNT4
              else
                Result := wv95;
           10: Result := wv98;
           90: Result := wvME;
         end;
      5: case OSVersionInfo.DwMinorVersion of
           0: Result := wvW2K;
           1: Result := wvXP;
           2: Result := wv2003;
         end;
    end;
  end;
end;

end.
