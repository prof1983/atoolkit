{**
@Abstract(Константы для модуля проверки структуры БД)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.04.2006)
@LastMod(27.04.2012)
@Version(0.5)
}
unit ADbCheckConst;

interface

uses
  ADbTypes;

const
  STR_JOIN_TYPE: array[TtblJoinType]of string =
    ('dajtInner', 'dajtLeftOuter', 'dajtRightOuter', 'dajtOuter');
  STR_FIELD_REPORT_TYPE: array[TfldType]of string =
    ('dtNotKnown', 'dtString', 'dtInteger', 'dtLongint', 'dtBoolean', 'dtDouble',
     'dtDouble', 'dtDate', 'dtTime', 'dtDateTime', 'dtLongint', 'dtBLOB', 'dtMemo',
     'dtGraphic', 'dtMemo', 'dtString', 'dtString');
  STR_FIELD_SQL_TYPE: array[TfldType]of string =
    ('varchar(50)', 'varchar', 'short', 'long', 'bit', 'double', 'currency',
     'date', 'time', 'datetime', 'counter', 'longbinary', 'longchar',
     'longbinary', 'longchar', 'char', 'char');

implementation

end.
