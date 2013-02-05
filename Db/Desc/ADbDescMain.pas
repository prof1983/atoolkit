{**
@Author Prof1983 <prof1983@ya.ru>
@Created 15.09.2006
@LastMod 05.02.2013
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
 