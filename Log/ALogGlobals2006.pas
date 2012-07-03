{**
@Abstract(Работа с Log. Классы для записи собщений программы в БД или файл или отображения в окне Log)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.08.2005)
@LastMod(03.07.2012)
@Version(0.5)

TLogNode - нод логирования - элемент дерева логирования
Delphi 5, 7, 2005
}
unit ALogGlobals2006;

interface

uses
  ALogDocumentImpl, ALogNodeImpl;

type // Конфигурации документа логирования
  //TConfigLogDocument = IProfNode;
  TLogDocument = TALogDocument2;
  //TLogNode = TALogNode;
  TLogDocumentA = ALogDocumentImpl.TLogDocumentA1;

implementation

end.
