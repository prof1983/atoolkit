{**
@Abstract(Описание труктуры таблици DescField)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.12.2005)
@LastMod(27.04.2012)
@Version(0.5)
}
unit ADbDescFields;

interface

uses
  ADbTypes;

const
  Desc_ID = 'ID';
  Desc_ID_TABLE = 'ID_TABLE';
  Desc_TBL_NAME = 'TBL_NAME';
  Desc_FLD_NAME = 'FLD_NAME';
  Desc_FLD_DESC = 'FLD_DESC';
  Desc_FLD_SELECT = 'FLD_SELECT';
  Desc_FLD_SEARCH = 'FLD_SEARCH';
  Desc_FLD_SORT = 'FLD_SORT';
  Desc_FLD_PARAM = 'FLD_PARAM';
  Desc_FLD_REQUER = 'FLD_REQUER';
  Desc_FLD_TYPE = 'FLD_TYPE';
  Desc_FLD_VISIBLE = 'FLD_VISIBLE';

const // -----------------------------------------------------------------------
  DescField = 'DescField';
  FieldCount_DescField = 12;
  Field_DescField: array [0..FieldCount_DescField-1] of TFieldRec =
    (
    (fldName: Desc_ID;         fldDescription: 'ID';                            fldType: ftAutoInc;   fldSize: 0;   fldNotNull: True),
    (fldName: Desc_ID_TABLE;   fldDescription: 'ID таблицы';                    fldType: ftInteger;   fldSize: 0;   fldNotNull: True),
    (fldName: Desc_TBL_NAME;   fldDescription: 'Имя таблицы';                   fldType: ftString;    fldSize: 50;  fldNotNull: True),
    (fldName: Desc_FLD_NAME;   fldDescription: 'Название поля';                 fldType: ftString;    fldSize: 50;  fldNotNull: True),
    (fldName: Desc_FLD_DESC;   fldDescription: 'Описание поля';                 fldType: ftString;    fldSize: 100; fldNotNull: True),
    (fldName: Desc_FLD_SELECT; fldDescription: 'Разрешить выборку';             fldType: ftFixedChar; fldSize: 1;   fldNotNull: False),
    (fldName: Desc_FLD_SEARCH; fldDescription: 'Разрешить поиск';               fldType: ftFixedChar; fldSize: 1;   fldNotNull: False),
    (fldName: Desc_FLD_SORT;   fldDescription: 'Разрешить сортировку';          fldType: ftFixedChar; fldSize: 1;   fldNotNull: False),
    (fldName: Desc_FLD_PARAM;  fldDescription: 'Парамерты';                     fldType: ftFixedChar; fldSize: 1;   fldNotNull: False),
    (fldName: Desc_FLD_REQUER; fldDescription: 'Обязательно для заполнения';    fldType: ftFixedChar; fldSize: 1;   fldNotNull: False),
    (fldName: Desc_FLD_TYPE;   fldDescription: 'Тип поля';                      fldType: ftString;    fldSize: 60;  fldNotNull: False),
    (fldName: Desc_FLD_VISIBLE; fldDescription: 'Показывать это поле';          fldType: ftBoolean;   fldSize: 1;   fldNotNull: False)
    );

  IndexCount_DescField = 2;
  Index_DescField: array [0..IndexCount_DescField-1] of TIndexRec =
    (
    (idxName: 'IDX_DESC_FIELD_ID';     idxField: Desc_ID;                 idxType: idxPrimary),
    (idxName: 'IDX_DESC_FIELD_NAME';   idxField: Desc_ID_TABLE+', '+Desc_FLD_NAME; idxType: idxUniqum)
    );

  Table_DescField: TTableRec =
    (
      tblName:        DescField;
      tblAccess:      tbRead;
      tblFieldsCount: FieldCount_DescField;
      tblFields:      @Field_DescField;
      tblIndexsCount: IndexCount_DescField;
      tblIndexs:      @Index_DescField;
    );
// -----------------------------------------------------------------------------

implementation

end.
