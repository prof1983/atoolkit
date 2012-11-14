{**
@Abstract Некоторые часто используемые функции
@Author Prof1983 <prof1983@ya.ru>
@Created 13.03.2007
@LastMod 14.11.2012
}
unit AProgramUtils;

{$I A.inc}

interface

uses
  Windows,
  ABase, AConsts2, ATypes;

//** @abstract(Возвращает информацию о файле)
function GetProgramVersionInfo(const AFileName: AnsiString): TFileVersionInfoA;

function GetProgramVersionInfoStr(const FileName: AnsiString): APascalString;

implementation

function GetProgramVersionInfo(const AFileName: AnsiString): TFileVersionInfoA;
type
  arrc = array[0..$ffff] of AnsiChar;
var
  VersionInfo: Pointer;

  function Read(AName: AnsiString): ShortString;
  var
    Size: DWORD;
    p: ^arrc; // absolute VersionInfo
  begin
    if (VerQueryValueA(VersionInfo, PAnsiChar(AName), Pointer(p), Size)) and (Size > 1) then
    begin
      SetLength(Result, Size);
      Result := copy(p^, 1, Size);
    end
    else
      Result := '';
  end;

const
  SubBlockPrefix = {$IFDEF DELPHI_XE_UP}'\StringFileInfo\040904E4\'{$ELSE}'\StringFileInfo\041904E3\'{$ENDIF};
var
  Wnd: DWORD;
  InfoSize: DWORD;
begin
  Result.ProductName := '';
  Result.ProductVersion := '';
  Result.OriginalFileName := '';
  Result.InternalName := '';
  Result.FileVersion := '';
  Result.LegalCopyright := '';
  Result.CompanyName := '';
  Result.FileDescription := '';

  InfoSize := GetFileVersionInfoSizeA(PAnsiChar(AFileName), Wnd);
  if (InfoSize <> 0) then
  begin
    GetMem(VersionInfo, InfoSize);
    try
      if GetFileVersionInfoA(PAnsiChar(AFileName), Wnd, InfoSize, VersionInfo) then
      begin
        Result.ProductName := Read(SubBlockPrefix+'ProductName');
        Result.ProductVersion := Read(SubBlockPrefix+'ProductVersion');
        Result.OriginalFileName := Read(SubBlockPrefix+'OriginalFilename');
        Result.InternalName := Read(SubBlockPrefix+'InternalName');
        Result.FileVersion := Read(SubBlockPrefix+'FileVersion');
        Result.LegalCopyright := Read(SubBlockPrefix+'LegalCopyright');
        Result.CompanyName := Read(SubBlockPrefix+'CompanyName');
        Result.FileDescription := Read(SubBlockPrefix+'FileDescription');
      end;
    finally
      FreeMem(VersionInfo);
    end;
  end;
end;

function GetProgramVersionInfoStr(const FileName: AnsiString): APascalString;
var
  VersionInfo: TFileVersionInfoA;
  S: APascalString;
begin
  S := '';
  VersionInfo := GetProgramVersionInfo(ParamStr(0));

  S := S + VersionInfo.ProductName;
  if (Length(VersionInfo.ProductVersion) > 0) then
    S := S + ' ('+VersionInfo.ProductVersion+')'#13#10
  else
    S := S + #13#10;
  if (Length(VersionInfo.OriginalFileName) > 0) then
    S := S + cProgramName+VersionInfo.OriginalFileName+#13#10;
  if (Length(VersionInfo.InternalName) > 0) then
    S := S + VersionInfo.InternalName+#13#10;
  if (Length(VersionInfo.FileVersion) > 0) then
    S := S + cProgramVersion+VersionInfo.FileVersion+#13#10;
  if (Length(VersionInfo.LegalCopyright) > 0) then
    S := S + VersionInfo.LegalCopyright+#13#10;
  if (Length(VersionInfo.CompanyName) > 0) then
    S := S + cCompanyName+VersionInfo.CompanyName+#13#10;
  if (Length(VersionInfo.FileDescription) > 0) then
    S := S + cDescription+VersionInfo.FileDescription+#13#10;

  Result := S;
end;

end.
 