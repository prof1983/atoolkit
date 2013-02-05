{**
@Author Prof1983 <prof1983@ya.ru>
@Created 06.04.2006
@LastMod 05.02.2013
}
unit ADbConsts;

interface

resourcestring
  qInsertDefault = 'INSERT INTO %TableName% (%FieldNames%) VALUES (%FieldValues%)';
  qUpdateDefault = 'UPDATE %TableName% %FieldsSet% WHERE %Where%';

const
  config_AutoEnabled      = 'AutoEnabled';
  config_AutoInterval     = 'AutoInterval';
  config_ConnectionString = 'ConnectionString';
  config_Description      = 'Description';
  config_DMType           = 'DMType';
  config_Enabled          = 'Enabled';
  config_Name             = 'Name';
  config_OnlyNewRecords   = 'OnlyNewRecords';
  config_Tables           = 'Tables';
  config_Table            = 'Table';

implementation

end.
 