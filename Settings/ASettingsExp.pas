{**
@Abstract ASettings exports
@Author Prof1983 <prof1983@ya.ru>
@Created 31.05.2011
@LastMod 02.04.2013
}
unit ASettingsExp;

{$define ASettings_Old}

interface

uses
  ASettingsIni,
  ASettingsMain,
  ASettingsReg;

exports
  ASettings_Close,
  ASettings_DeleteKey,
  ASettings_DeleteKeyA,
  ASettings_DeleteSection,
  ASettings_DeleteSectionA,
  ASettings_Fin,
  {$ifdef ASettings_Old}
  ASettings_NewIniConfig,
  ASettings_NewIniConfigA,
  ASettings_NewRegConfig,
  ASettings_NewRegConfigA,
  {$endif}
  ASettings_NewIniSettings,
  ASettings_NewIniSettingsA,
  ASettings_NewRegSettings,
  ASettings_NewRegSettingsA,
  ASettings_ReadBoolDef,
  ASettings_ReadBoolDefA,
  ASettings_ReadDateTimeDef,
  ASettings_ReadDateTimeDefA,
  ASettings_ReadFloatDef,
  ASettings_ReadFloatDefA,
  ASettings_ReadIntDef,
  ASettings_ReadIntDefA,
  ASettings_ReadSection,
  ASettings_ReadSectionA,
  ASettings_ReadString,
  ASettings_ReadStringA,
  ASettings_ReadStringDef,
  ASettings_ReadStringDefA,
  ASettings_WriteBool,
  ASettings_WriteBoolA,
  ASettings_WriteDateTime,
  ASettings_WriteDateTimeA,
  ASettings_WriteFloat,
  ASettings_WriteFloatA,
  ASettings_WriteInt,
  ASettings_WriteIntA,
  ASettings_WriteString,
  ASettings_WriteStringA,

  ASettings_Close name 'AConfig_Close',
  ASettings_DeleteKey name 'AConfig_DeleteKey',
  ASettings_DeleteKeyA name 'AConfig_DeleteKeyA',
  ASettings_DeleteSection name 'AConfig_DeleteSection',
  ASettings_DeleteSectionA name 'AConfig_DeleteSectionA',
  ASettings_ReadBoolDef name 'AConfig_ReadBoolDef',
  ASettings_ReadBoolDefA name 'AConfig_ReadBoolDefA',
  ASettings_ReadDateTimeDef name 'AConfig_ReadDateTimeDef',
  ASettings_ReadDateTimeDefA name 'AConfig_ReadDateTimeDefA',
  ASettings_ReadFloatDef name 'AConfig_ReadFloatDef',
  ASettings_ReadFloatDefA name 'AConfig_ReadFloatDefA',
  ASettings_ReadIntDef name 'AConfig_ReadIntegerDef',
  ASettings_ReadIntDefA name 'AConfig_ReadIntegerDefA',
  ASettings_ReadSection name 'AConfig_ReadSection',
  ASettings_ReadSectionA name 'AConfig_ReadSectionA',
  ASettings_ReadString name 'AConfig_ReadString',
  ASettings_ReadStringA name 'AConfig_ReadStringA',
  ASettings_ReadStringDef name 'AConfig_ReadStringDef',
  ASettings_ReadStringDefA name 'AConfig_ReadStringDefA',
  ASettings_WriteBool name 'AConfig_WriteBool',
  ASettings_WriteBoolA name 'AConfig_WriteBoolA',
  ASettings_WriteDateTime name 'AConfig_WriteDateTime',
  ASettings_WriteDateTimeA name 'AConfig_WriteDateTimeA',
  ASettings_WriteFloat name 'AConfig_WriteFloat',
  ASettings_WriteFloatA name 'AConfig_WriteFloatA',
  ASettings_WriteInt name 'AConfig_WriteInteger',
  ASettings_WriteIntA name 'AConfig_WriteIntegerA',
  ASettings_WriteString name 'AConfig_WriteString',
  ASettings_WriteStringA name 'AConfig_WriteStringA';

implementation

end.
