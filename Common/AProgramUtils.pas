{**
@Abstract(Некоторые часто используемые функции)
@Author(Prof1983 prof1983@ya.ru)
@Created(13.03.2007)
@LastMod(06.07.2012)
@Version(0.5)
}
unit AProgramUtils;

interface

uses
  Windows,
  ATypes;

//** @abstract(Возвращает информацию о файле)
function GetProgramVersionInfo(const AFileName: AnsiString): TFileVersionInfoA;

implementation

function GetProgramVersionInfo(const AFileName: AnsiString): TFileVersionInfoA;
type
  arrc = array[0..$ffff] of AnsiChar;
var
  Wnd, InfoSize, Size: DWORD;
  VersionInfo: Pointer;
  p: ^arrc; // absolute VersionInfo

  function Read(AName: AnsiString): ShortString;
  begin
    if (VerQueryValueA(VersionInfo, PAnsiChar(AName), Pointer(p), Size)) and (Size > 1) then
    begin
      SetLength(Result, Size);
      Result := copy(p^, 1, Size);
    end
    else
      Result := '';
  end;

begin
  Result.ProductName := '';
  Result.ProductVersion := '';
  Result.OriginalFileName := '';
  Result.InternalName := '';
  Result.FileVersion := '';
  Result.LegalCopyright := '';
  Result.CompanyName := '';
  Result.FileDescription := '';

  InfoSize := GetFileVersionInfoSizeA(PAnsiChar(AFileName{Paramstr(0)}), Wnd);
  if (InfoSize <> 0) then
  begin
    GetMem(VersionInfo, InfoSize);
    try
      if GetFileVersionInfoA(PAnsiChar(AFileName), Wnd, InfoSize, VersionInfo) then
      begin
        Result.ProductName := Read('\StringFileInfo\041904E3\ProductName');
        Result.ProductVersion := Read('\StringFileInfo\041904E3\ProductVersion');
        Result.OriginalFileName := Read('\StringFileInfo\041904E3\OriginalFilename');
        Result.InternalName := Read('\StringFileInfo\041904E3\InternalName');
        Result.FileVersion := Read('\StringFileInfo\041904E3\FileVersion');
        Result.LegalCopyright := Read('\StringFileInfo\041904E3\LegalCopyright');
        Result.CompanyName := Read('\StringFileInfo\041904E3\CompanyName');
        Result.FileDescription := Read('\StringFileInfo\041904E3\FileDescription');
      end;
    finally
      FreeMem(VersionInfo);
    end;
  end;
end;

end.
 