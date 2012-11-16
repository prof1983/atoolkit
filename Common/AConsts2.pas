{**
@Abstract Global consts
@Author Prof1983 <prof1983@ya.ru>
@Created 06.10.2006
@LastMod 16.11.2012
}
unit AConsts2;

interface

const
  DIR_CONFIGS = 'Configs';
  DIR_DATA = 'Data';
  DIR_DATABASE = 'DataBase';
  DIR_LOGS = 'Logs';

const // File ext
  FILE_EXT_CONF = 'conf';
  FILE_EXT_CONFIG = FILE_EXT_CONF;
  FILE_EXT_INI = 'ini';
  FILE_EXT_LOG = 'log';
  FILE_EXT_POOL = 'pool';
  FILE_EXT_XML = 'xml';

const
  CR = #13;
  LF = #10;
  CRLF = #13 + #10;

const // Default dir name
  DEFAULT_DB_DIR = 'DataBase';
  DEFAULT_BIN_DIR = 'Bin';
  DEFAULT_MODULE_DIR = 'Modules';
  DEFAULT_LOGS_DIR = 'Logs';

const
  PROF_EMAIL_MAIN = 'prof1983@ya.ru';

const
  STR_BOOL: array[Boolean] of string =
    ('False', 'True');
  STR_BOOL_ENG: array[Boolean] of string =
    ('false', 'true');
  STR_MONTH_ENG: array[0..12]of string =
    ('none', 'January', 'February', 'March', 'April', 'May', 'June', 'July',
     'August', 'September', 'October', 'November', 'December');
  STR_DAYOFWEEK_ENG: array[0..7]of string =
    ('none', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday',
     'Saturday');

const // --- Result consts ---
  RESULT_OK = 0;
  RESULT_ERROR = -1;
  RESULT_XML_DOCUMENT_CREATE = 1;  // XML document is created (TProfXmlDocument.OpenDocument)
  RESULT_XML_DOCUMENT_NOTCREATE = -2; // XML document is not created (TProfXmlDocument.OpenDocument)

const // --- Time consts ---
  DateTimeDay = 1;
  DateTimeHour = DateTimeDay / 24;
  DateTimeMinute = DateTimeHour / 60;
  DateTimeSecond = DateTimeMinute / 60;

const //** @abstract(Для логирования всех ошибок)
  err_Exception_Str = '%s <%s.%s>.';

const
  cAboutCaption_en = 'About...';
  cCompanyName_en = 'Company: ';
  cDesctiption_en = 'Description: ';
  cProgramName_en = 'Program name: ';
  cProgramVersion_en = 'Version: ';
  cProductVersion_en = 'Product version: ';

{$I AConsts2.ru.win1251.inc}

const
  {$IFDEF FPC}
  cAboutCaption = cAboutCaption_en;
  cCompanyName = cCompanyName_en;
  cDesctiption = cDesctiption_en;
  cProgramName = cProgramName_en;
  cProgramVersion = cProgramVersion_en;
  cProductVersion = cProductVersion_en;
  {$ELSE}
  cAboutCaption = cAboutCaption_ru;
  cCompanyName = cCompanyName_ru;
  cDescription = cDescription_ru;
  cProgramName = cProgramName_ru;
  cProgramVersion = cProgramVersion_ru;
  cProductVersion = cProductVersion_ru;
  {$ENDIF}

implementation

end.
