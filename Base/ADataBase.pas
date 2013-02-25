{**
@Abstract AData base consts and types
@Author Prof1983 <prof1983@ya.ru>
@Created 24.08.2011
@LastMod 25.02.2013
}
unit ADataBase;

interface

uses
  ABase;

const
  AData_Name = 'AData';
  AData_Uid = $08101301;

type
  ADataConnection = type AInt;
  ADataDriver = type AInt;
  ADataModel = type AInt;
  ADataSet = ADataModel;
  ADataStructure = type AInt;
  ATableStructure = type AInt;

implementation

end.
 