{
Author Prof1983 <prof1983@ya.ru>
Created 16.11.2012
LastMod 16.11.2012
}

// === ��������� ===============================================================

const // ��������� ���������� ����� --------------------------------------------
  STR_BOOL_RUS: array[Boolean] of string =
    ('���', '��');
  STR_MONTH_RUS: array[0..12]of string =
    ('����������', '������', '�������', '����', '������', '���', '����', '����',
     '������', '��������', '�������', '������', '�������');
  STR_DAYOFWEEK_RUS: array[0..7]of string =
    ('����������', '�����������', '�����������', '�������', '�����', '�������',
     '�������', '�������');

// === ��������� ===============================================================

resourcestring // ��������� ----------------------------------------------------
  sER_LogGroup_None      = '���������� ��� ������������';
  sER_LogGroup_NetWork   = '������ ����, �������, ��������� TCP/IP';
  sER_LogGroup_Setup     = '���������';
  sER_LogGroup_General   = '����� ����������';
  sER_LogGroup_DataBase  = '������ ���� ������';
  sER_LogGroup_Key       = '������ � ������ ������';
  sER_LogGroup_Equipment = '������ ������������������� ������������';
  sER_LogGroup_Algorithm = '������ �������������� ����������';
  sER_LogGroup_System    = '������ ������� Windows';
  sER_LogGroup_User      = '�������� ������������';
resourcestring
  sER_LogType_None        = '���������� ��� ������������';
  sER_LogType_Error       = '������';
  sER_LogType_Warning     = '��������������';
  sER_LogType_Information = '���������';
  sEr_LogType_Do          = '���������';
const // ����������� ��������� ----------------------------------------
  info_ConfigureLoad   = '������������ ���������';
  info_ConfigureSave   = '������������ ���������';
  stConfigureLoadOk    = '������������ ���������';
  stConfigureLoadError = '������������ �� ���������';
  stConfigureLoadStart = '�������� ������������';
  stConfigureSaveStart = '���������� ������������';
  stConfigureSaveOk    = '������������ ���������';
  stConfigureSaveError = '������������ �� ���������';
  stCreateOk           = '������ ������';
  stCreateOkA          = '������ "%s" ������';
  stFinalize           = '�����������';
  stFinalizeError      = '�� ��������������';
  stFinalizeOk         = '��������������';
  stFinalizeStart      = '�����������';
  stFreeOk             = '������ ���������';
  stInitialize         = '�������������';
  stInitializeError    = '������ ��� �������������';
  stInitializedA       = '������ "%s" ���������������';
  stInitializeOk       = '����������������';
  stInitialize_Error   = '������ ��� ������������� ������� "%s"';
  stInitialize_Ok      = '������ "%s" ���������������';
  stInitialize_Start   = '������������� ������ "%s"';
  stNotActive          = '�� �����������';
  stNotAssigned        = '"%s.%s" �� �����';
  stNotInitialized     = '�� ����������������';
  stNotOverride        = '������� �� ��������������';
  stNotOverrideA       = '������� "%s" �� ��������������';
  stNotOverrideB       = '������� �� �������������� "%s.%s"';
  stProgram            = '��������� ���������';

resourcestring // ��������� ----------------------------------------------------
  err_SaveToFile      = '������ ��� ���������� ����� "%s" "%s"';
  err_Xml_Load1       = '�� ������ ����������� ��� "?>" Line=%d';
  err_Xml_Load2       = '�� ����� ������� Line=%d';
  err_Xml_ReadNodes_1 = '�� ������� ����������� ������ ">"';

const
  cAboutCaption_ru = '� ���������';
  cCompanyName_ru = '��������: ';
  cDescription_ru = '��������: ';
  cProgramName_ru = '��� �����: ';
  cProgramVersion_ru = '������: ';
  cProductVersion_ru = '������ ��������: ';

