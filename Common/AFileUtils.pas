{**
@Abstract(UMyFile)
@Author(Prof1983 prof1983@ya.ru)
@Created(?)
@LastMod(25.04.2012)
@Version(0.5)
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
