{**
@Abstract ASystem prepare function
@Author Prof1983 <prof1983@ya.ru>
@Created 01.08.2011
@LastMod 29.01.2013
}
unit ASystemPrepare;

interface

uses
  {$IFNDEF UNIX}Windows,{$ENDIF}
  ABase, ABaseUtils, ASystemData, ASystemUtils;

procedure System_Prepare(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, Comments, DataPath, ConfigPath: APascalString);

implementation

{ Private }

function TryStrToVersion(const S: APascalString; out Version: AVersion): ABoolean;
begin
  // ...
  Result := False;
end;

{ Public }

procedure System_Prepare(const Title, ProgramName: APascalString; ProgramVersion: AVersion;
    const ProductName: APascalString; ProductVersion: AVersion;
    const CompanyName, Copyright, Url, Description, Comments, DataPath, ConfigPath: APascalString);
{$IFNDEF UNIX}
type
  arrc = array[0..$ffff] of Char;
var
  Wnd: DWORD;
  InfoSize: DWORD;
  VersionInfo: Pointer;

  function ReadVer(BlockName: string): AnsiString;
  var
    st: ShortString;
    p: ^arrc; // absolute VersionInfo
    Size: DWORD;
  begin
    if (VerQueryValue(VersionInfo, PChar(BlockName), Pointer(p), Size)) and (Size > 1) then
    begin
      SetLength(st, Size);
      st := Copy(p^,1,Size);
      Result := st;
    end
    else
      Result := '';
  end;
{$ENDIF}

var
  S: AnsiString;
begin
  if FIsPrepare then Exit;

  FComments := Comments;
  FCompanyName := CompanyName;
  FCopyright := Copyright;
  FDescription := Description;
  FProductName := ProductName;
  FProductVersion := ProductVersion;
  FProductVersionStr := ABaseUtils.VersionToStr3(ProductVersion);
  FProgramName := ProgramName;
  FProgramVersion := ProgramVersion;
  FProgramVersionStr := ABaseUtils.VersionToStr(ProgramVersion);
  FTitle := Title;
  FUrl := Url;

  FExeFileName := System.ParamStr(0);
  ExtractFileNameAndPathW(FExeFileName, FExeName, FExePath);

  FDataPath := NormalizePath2(DataPath);
  FConfigPath := NormalizePath2(ConfigPath);

  if (FProgramName = '') then
  begin
    // Set default ProgramName
    if (Length(FExeName) > 4) and (Copy(FExeName, Length(FExeName) - 4, 4) = '.exe') then
      FProgramName := Copy(FExeName, 1, Length(FExeName) - 4)
    else
      FProgramName := FExeName;
  end;

  if (FTitle = '') then
    FTitle := FProgramName;

  {$IFNDEF UNIX}
  InfoSize := GetFileVersionInfoSize(PChar(System.Paramstr(0)), Wnd);
  if (InfoSize <> 0) then
  begin
    GetMem(VersionInfo, InfoSize);
    try
      if GetFileVersionInfo(PChar(System.Paramstr(0)), Wnd, InfoSize, VersionInfo) then
      begin
        S := ReadVer('\StringFileInfo\041904E3\ProductName');
        if (S <> '') then FProductName := S;
        S := ReadVer('\StringFileInfo\041904E3\ProductVersion');
        if (S <> '') then
        begin
          FProductVersionStr := S;
          TryStrToVersion(S, FProductVersion);
        end;
        S := ReadVer('\StringFileInfo\041904E3\InternalName');
        if (S <> '') then FProgramName := S;
        S := ReadVer('\StringFileInfo\041904E3\FileVersion');
        if (S <> '') then
        begin
          FProgramVersionStr := S;
          TryStrToVersion(S, FProgramVersion);
        end;
        S := ReadVer('\StringFileInfo\041904E3\LegalCopyright');
        if (S <> '') then FCopyright := S;
        S := ReadVer('\StringFileInfo\041904E3\CompanyName');
        if (S <> '') then FCompanyName := S;
        S := ReadVer('\StringFileInfo\041904E3\FileDescription');
        if (S <> '') then FDescription := S;
        //S := ReadVer('\StringFileInfo\041904E3\OriginalFilename');
        //if (S <> '') then Memo.Lines.Add('File name: '+S);
        S := ReadVer('\StringFileInfo\041904E3\Comments');
        if (S <> '') then FComments := S;
      end;
    finally
      FreeMem(VersionInfo);
    end;
  end;
  {$ENDIF}

  FIsPrepare := True;
end;

end.
 