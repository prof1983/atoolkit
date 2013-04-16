{**
@Abstract ABaseTypes
@Author Prof1983 <prof1983@ya.ru>
@Created 23.06.2011
@LastMod 16.04.2013
}
unit ABaseTypes;

interface

uses
  ABase;

type
  ADialogBoxCommands = type Integer;
const
  ID_OK = 1;
  ID_CANCEL = 2;
  ID_ABORT = 3;
  ID_RETRY = 4;
  ID_IGNORE = 5;
  ID_YES = 6;
  ID_NO = 7;
  ID_CLOSE = 8;
  ID_HELP = 9;
  ID_TRYAGAIN = 10;
  ID_CONTINUE = 11;

type
  AMessageBoxFlags = type Integer;
const
  AMessageBoxFlags_Ok = $00000000;
  AMessageBoxFlags_OkCancel = $00000001;
  AMessageBoxFlags_AbortRetryIgnore = $00000002;
  AMessageBoxFlags_YesNoCancel = $00000003;
  AMessageBoxFlags_YesNo = $00000004;
  AMessageBoxFlags_RetryCancel = $00000005;
  AMessageBoxFlags_ApplyOkCancel = $00000006;
  AMessageBoxFlags_1 = $00010001; // for MessageDlg: [mbYes, mbYesToAll, mbNo, mbCancel]
const
  AMessageBoxFlags_IconError = $00000010;       // MB_ICONHAND, MB_ICONSTOP
  AMessageBoxFlags_IconQuestion = $00000020;
  AMessageBoxFlags_IconWarning = $00000030;     // ICONEXCLAMATION
  AMessageBoxFlags_IconInformation = $00000040; // MB_ICONASTERISK
  AMessageBoxFlags_UserIcon = $00000080;
const
  MB_OK = AMessageBoxFlags_OK;
  MB_OKCANCEL = AMessageBoxFlags_OKCANCEL;
  MB_ABORTRETRYIGNORE = AMessageBoxFlags_ABORTRETRYIGNORE;
  MB_YESNOCANCEL = AMessageBoxFlags_YESNOCANCEL;
  MB_YESNO = AMessageBoxFlags_YESNO;
  MB_RETRYCANCEL = AMessageBoxFlags_RETRYCANCEL;
  MB_ApplyOkCancel = AMessageBoxFlags_ApplyOkCancel;
const
  MB_ICONERROR = AMessageBoxFlags_ICONERROR;
  MB_ICONQUESTION = AMessageBoxFlags_ICONQUESTION;
  MB_ICONWARNING = AMessageBoxFlags_ICONWARNING;
  MB_ICONINFORMATION = AMessageBoxFlags_ICONINFORMATION;
  MB_USERICON = AMessageBoxFlags_USERICON;

type
  ALogType = type AInt;
const
  ALogType_Error = $00000010;
  ALogType_Question = $00000020;
  ALogType_Warning = $00000030;
  ALogType_Information = $00000040;

type
  ALogFlags = type Integer;
const
  ALogFlags_IconMask = $000000F0;
  ALogFlags_IconError = ALogType_Error;
  ALogFlags_IconQuestion = ALogType_Question;
  ALogFlags_IconWarning = ALogType_Warning;
  ALogFlags_IconInformation = ALogType_Information;
  ALogFlags_IconUser = $00000080;
const
  ALogIconMask         = $000000F0;
  ALogIconError        = $00000010;
  ALogIconQuestion     = $00000020;
  ALogIconWarning      = $00000030;
  ALogIconInformation  = $00000040;
  ALogIconUser         = $00000080;
{const
  L_ICONERROR = ALogIconError;       // MB_ICONHAND, MB_ICONSTOP
  L_ICONQUESTION = ALogIconQuestion;
  L_ICONWARNING = ALogIconWarning;     // ICONEXCLAMATION
  L_ICONINFORMATION = ALogIconInformation; // MB_ICONASTERISK
  L_USERICON = ALogIconUser;}

type
  AAddToLogA_Proc = function(Msg: AStr; Flags: ALogFlags; Data: AInt): AInt; stdcall;
  AShowErrorA_Proc = function(Caption, UserMessage, ExceptMessage: AStr): AError; stdcall;
  AShowMessageA_Proc = function(Text, Caption: AStr; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

  // TAShowErrorProc
  TAShowErrorWSProc = procedure(const Caption, UserMessage, ExceptMessage: AWideString); stdcall;
  // TAShowMessageProc
  TAShowMessageWSProc = function(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;
  // TAddToLogProc
  TAddToLogWSProc = procedure(const Msg: AWideString; Flags: ALogFlags);

type
  TRealArray = array of Real;
  TIntArray = array of Integer;
  TLongIntArray = array of LongInt;
  TBoolArray = array of Boolean;

type
  ACollection = type AInt; // =TACollection
  AStream = type Integer; //TFileStream
  AStringList = type AInteger; // =TStringList

implementation

end.
 