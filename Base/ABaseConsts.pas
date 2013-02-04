{**
@Abstract Base consts
@Author Prof1983 <prof1983@ya.ru>
@Created 06.03.2008
@LastMod 23.07.2012
}
unit ABaseConsts;

interface

const
  STR_BOOL: array [Boolean] of string = ('False', 'True');
  STR_BOOL_FIB: array [Boolean] of string = ('''0''', '''1''');
  STR_BOOL_INT: array [Boolean] of string = ('0', '1');

const
  STR_BOOL_ENG: array [Boolean] of string = ('false', 'true');
  STR_MONTH_2: array [0..12] of string = ('00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12');
  STR_MONTH_ENG: array [0..12] of string =
    ('none', 'January', 'February', 'March', 'April', 'May', 'June', 'July',
     'August', 'September', 'October', 'November', 'December');
  STR_DAYOFWEEK_ENG: array [0..7] of string =
    ('none', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');

{$IFDEF DELPHI_XE_UP}
{$I ABaseConsts.ru.utf8.inc}
{$ELSE}
{$I ABaseConsts.ru.win1251.inc}
{$ENDIF DELPHI_XE_UP}

implementation

end.





