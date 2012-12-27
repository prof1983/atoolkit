{**
@Abstract AData base consts and types
@Author Prof1983 <prof1983@ya.ru>
@Created 24.08.2011
@LastMod 27.12.2012
}
unit ADataBase;

interface

uses
  ABase;

const
  AData_Name = 'AData';
  AData_Uid = $08101301;

type
  ADataConnection = type Integer; // IADatabase

type
  ADataStructure = type Integer; // IADatabaseStructure

type
  // Описания таблицы
  ATableStructure = type Integer; // IATableStructure

type
  ADataDriver = type Integer; // ^ADataDriverRec

type
  ADataModel = type AInt; // ADataModel_Type
  ADataSet = ADataModel; // ^TDataSet

implementation

end.
 