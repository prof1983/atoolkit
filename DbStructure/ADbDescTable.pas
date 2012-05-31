{**
@Abstract(Описание структуры таблици DescTable)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.12.2005)
@LastMod(27.04.2012)
@Version(0.5)
}
unit ADbDescTable;

interface

uses
  ADbTypes;

const
  DescTableId = 'ID';
  DescTableTblName = 'TBL_NAME';
  DescTableTblDesc = 'TBL_DESC';

const // -----------------------------------------------------------------------
  DescTable = 'DescTable';
  FieldCount_DescTable = 3;
  Field_DescTable: array [0..FieldCount_DescTable-1] of TFieldRec =
    (
    (fldName: DescTableID;         fldType: ftAutoInc; fldSize: 0;   fldNotNull: True),
    (fldName: DescTableTblName;    fldType: ftString;  fldSize: 50;  fldNotNull: True),
    (fldName: DescTableTblDesc;    fldType: ftString;  fldSize: 100; fldNotNull: True)
    );

  IndexCount_DescTable = 2;
  Index_DescTable: array [0..IndexCount_DescTable-1] of TIndexRec =
    (
    (idxName: 'IDX_DescTable_ID';         idxField: DescTableID;        idxType: idxPrimary),
    (idxName: 'IDX_DescTable_Table_Name'; idxField: DescTableTblName;   idxType: idxUniqum)
    );

  Table_DescTable: TTableRec =
    (
      tblName:        DescTable;
      tblAccess:      tbRead;
      tblFieldsCount: FieldCount_DescTable;
      tblFields:      @Field_DescTable;
      tblIndexsCount: IndexCount_DescTable;
      tblIndexs:      @Index_DescTable;
    );

implementation

end.
