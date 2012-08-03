{**
@Astract AUi consts
@Author Prof1983 <prof1983@ya.ru>
@Created 30.07.2012
@LastMod 30.07.2012
}
unit AUiConsts;

{$I A.inc}

{$IFDEF FPC}
  {$DEFINE LangEN}
{$ENDIF}

interface

{$IFDEF LangEN}
  {$I 'AUi.en.inc'}
{$ELSE}
  {$IFDEF DELPHI_XE_UP}
    {$I 'AUi.ru.utf8.inc'}
  {$ELSE}
    {$I 'AUi.ru.win1251.inc'}
  {$ENDIF}
{$ENDIF}

implementation

end.
 