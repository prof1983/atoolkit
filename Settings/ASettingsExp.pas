{**
@Abstract ASettings exports
@Author Prof1983 <prof1983@ya.ru>
@Created 31.05.2011
@LastMod 24.07.2012
}
unit ASettingsExp;

interface

uses
  ASettings;

exports
  ASettings.Config_Close name 'AConfig_Close',
  ASettings.Config_DeleteKey name 'AConfig_DeleteKey',
  ASettings.Config_DeleteKeyA name 'AConfig_DeleteKeyA',
  ASettings.Config_DeleteKeyW name 'AConfig_DeleteKeyW',
  ASettings.Config_DeleteSection name 'AConfig_DeleteSection',
  ASettings.Config_DeleteSectionA name 'AConfig_DeleteSectionA',
  ASettings.Config_DeleteSectionW name 'AConfig_DeleteSectionW',
  ASettings.Config_ReadBoolDef name 'AConfig_ReadBoolDef',
  ASettings.Config_ReadBoolDefA name 'AConfig_ReadBoolDefA',
  ASettings.Config_ReadBoolDefW name 'AConfig_ReadBoolDefW',
  ASettings.Config_ReadIntegerDef name 'AConfig_ReadIntegerDef',
  ASettings.Config_ReadIntegerDefA name 'AConfig_ReadIntegerDefA',
  ASettings.Config_ReadIntegerDefW name 'AConfig_ReadIntegerDefW',
  ASettings.Config_ReadFloatDef name 'AConfig_ReadFloatDef',
  ASettings.Config_ReadFloatDefA name 'AConfig_ReadFloatDefA',
  ASettings.Config_ReadFloatDefW name 'AConfig_ReadFloatDefW',
  ASettings.Config_ReadSection name 'AConfig_ReadSection',
  ASettings.Config_ReadSectionA name 'AConfig_ReadSectionA',
  ASettings.Config_ReadSectionW name 'AConfig_ReadSectionW',
  ASettings.Config_ReadString name 'AConfig_ReadString',
  ASettings.Config_ReadStringA name 'AConfig_ReadStringA',
  ASettings.Config_ReadStringW name 'AConfig_ReadStringW',
  ASettings.Config_ReadStringDef name 'AConfig_ReadStringDef',
  ASettings.Config_ReadStringDefA name 'AConfig_ReadStringDefA',
  ASettings.Config_ReadStringDefW name 'AConfig_ReadStringDefW',
  ASettings.Config_ReadDateTimeDef name 'AConfig_ReadDateTimeDef',
  ASettings.Config_ReadDateTimeDefA name 'AConfig_ReadDateTimeDefA',
  ASettings.Config_ReadDateTimeDefW name 'AConfig_ReadDateTimeDefW',
  ASettings.Config_WriteBool name 'AConfig_WriteBool',
  ASettings.Config_WriteBoolA name 'AConfig_WriteBoolA',
  ASettings.Config_WriteBoolW name 'AConfig_WriteBoolW',
  ASettings.Config_WriteInteger name 'AConfig_WriteInteger',
  ASettings.Config_WriteIntegerA name 'AConfig_WriteIntegerA',
  ASettings.Config_WriteIntegerW name 'AConfig_WriteIntegerW',
  ASettings.Config_WriteFloat name 'AConfig_WriteFloat',
  ASettings.Config_WriteFloatA name 'AConfig_WriteFloatA',
  ASettings.Config_WriteFloatW name 'AConfig_WriteFloatW',
  ASettings.Config_WriteString name 'AConfig_WriteString',
  ASettings.Config_WriteStringA name 'AConfig_WriteStringA',
  ASettings.Config_WriteStringW name 'AConfig_WriteStringW',
  ASettings.Config_WriteDateTime name 'AConfig_WriteDateTime',
  ASettings.Config_WriteDateTimeA name 'AConfig_WriteDateTimeA',
  ASettings.Config_WriteDateTimeW name 'AConfig_WriteDateTimeW';

implementation

end.
