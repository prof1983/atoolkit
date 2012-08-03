{**
@Abstract AData base consts and types
@Author Prof1983 <prof1983@ya.ru>
@Created 24.08.2011
@LastMod 19.07.2012
}
unit ADataBase;

interface

type
  AWideString = WideString;

type
  ADataConnection = type Integer; // IADatabase
  //ADatabase = type Integer; // IADatabase

type
  ADataStructure = type Integer; // IADatabaseStructure
  //ADatabaseStructure = type Integer; // IADatabaseStructure

type
  // Описания таблицы
  ATableStructure = type Integer; // IATableStructure

type
  ADataDriver = type Integer; // ^ADataDriverRec
  //ADataDriver = ^ADataDriverRec; //type Integer; // IADataDriver

type
  ADataSet = type Integer; // ^TDataSet

implementation

end.
 