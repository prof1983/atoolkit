{**
@Abstract(Описание труктуры таблиц)
@Author(Prof1983 prof1983@ya.ru)
@Created(15.09.2006)
@LastMod(27.04.2012)
@Version(0.5)
}
unit ADbDescMain;

interface

uses
  ADbDescFields, ADbDescTable, ADbTypes;

const
  TablesCount = 2;
  Tables: array[0..TablesCount - 1] of PTableRec = (
    @Table_DescField,
    @Table_DescTable
    //@Table_TABLE_JOIN
    );

const
  DescrDBMain: TDBMain = (
    dbTablesCount: TablesCount;
    dbTables: @Tables;
    dbViewsCount: 0; //1;
    dbViews: nil; //@ViewArr;
    );

implementation

end.
 