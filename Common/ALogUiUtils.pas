{**
@Abstract At log util functions
@Author Prof1983 <prof1983@ya.ru>
@Created 09.06.2012
@LastMod 04.02.2013
}
unit ALogUiUtils;

interface

uses
  Graphics,
  ALogTypes, ATypes;

function GetLogTypeColor(ALogType: TLogTypeMessage): TLogTypeMessageColor;

implementation

function GetLogTypeColor(ALogType: TLogTypeMessage): TLogTypeMessageColor;
begin
  case ALogType of
    ltNone: Result := ltNoneColor;
    ltError: Result := ltErrorColor;
    ltWarning: Result := ltWarningColor;
    ltInformation: Result := ltInformationColor;
  else
    Result := ltNoneColor;
  end;
end;

end.
