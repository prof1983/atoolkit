{**
@Abstract(At Log types)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.06.2012)
@LastMod(09.06.2012)
@Version(0.5)
}
unit ALogTypes;

interface

uses
  Graphics;

type //** Тип сообщений для записи в лог файл
  TLogTypeMessageColor = Graphics.TColor;
const
    //** неизвестно или неопределено
  ltNoneColor = clBlack;
    //** ошибка
  ltErrorColor = clRed;
    //** предупреждение
  ltWarningColor = clYellow;
    //** сообщение
  ltInformationColor = clBlue;

implementation

end.
