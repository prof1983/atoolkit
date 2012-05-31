{**
@Abstract(Базовый класс ввода/вывода)
@Author(Prof1983 prof1983@ya.ru)
@Created(18.04.2004)
@LastMod(15.05.2012)
@Version(0.5)
}
unit AIoTypes;

interface

type //** Способ открытия файла
  TProfFileOpenMode = (
   Prof_fmUnknown,        // Попытаться открыть, если не получилось - создать
   Prof_fmCreate,         // создавать новый/перезаписывать
   Prof_fmOpenRead,       // открыть для чтения
   Prof_fmOpenWrite,      // открыть для записи
   Prof_fmOpenReadWrite   // открыть для чтения/записи
  );

type //** Откуда отсчитывать расстояние
  TStreamSeekMode = (
    Prof_soBeginning,
    Prof_soCurent,
    Prof_soEnd
  );

implementation

end.
