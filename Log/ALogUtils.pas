{**
@Author Prof1983 <prof1983@ya.ru>
@Created 19.12.2012
@LastMod 19.12.2012
}
unit ALogUtils;

interface

uses
  ABase,
  ATypes;

const // Константы номеров стандартных картинок в RunImages
  IndexGrayBox    = 0;
  IndexBlueBox    = 1;
  IndexGreenBox   = 2;
  IndexFuchsiaBox = 3; // Фиолетовый
  IndexRedBox     = 4;

function GetLogImageIndex(LogType: TLogTypeMessage): AInteger;

implementation

function GetLogImageIndex(LogType: TLogTypeMessage): AInteger;
begin
  case LogType of
    ltInformation: Result := IndexGreenBox;
    ltWarning: Result := IndexFuchsiaBox;
    ltError: Result := IndexRedBox;
  else
    Result := -1;
  end;
end;

end.
