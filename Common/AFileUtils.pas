{**
@Abstract UMyFile
@Author Prof1983 <prof1983@ya.ru>
@Created ?
@LastMod 04.02.2013
}
unit AFileUtils;

interface

uses
  SysUtils;

function IoPathNow(): string;

implementation

function IoPathNow(): string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

end.
