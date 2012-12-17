{**
@Abstract Globals types
@Author Prof1983 <prof1983@ya.ru>
@Created 20.02.2007
@LastMod 17.12.2012
}
unit ATypes;

interface

uses
  ABase;

// --- Base types ---

// TODO: Use base types from ABase.pas
type
  {
  Char08 = Char;
  Char16 = WideChar;
  SByte = ShortInt;
  Float32 = AFloat32;
  Float64 = AFloat64;
  Int08 = ShortInt;
  Int16 = SmallInt;
  Int32 = AInt32;
  //Int64 = Int64;
  UInt08 = AUInt08;
  UInt16 = AUInt16;
  UInt32 = AUInt32;
  IntPtr = Int32;
  }
  UIntPtr = AUInt32;

{
type
  TProfError = ABase.AError;
  TError = ABase.AError;
const
  PROF_RESULT_OK          = 0;
const
  PROF_RESULT_FATAL_ERROR = $C0000000;
  PROF_RESULT_ERROR       = $80000000;
  PROF_RESULT_WARNING     = $40000000;
  PROF_RESULT_INFORMATION = $00000000;
}

type // from ABase2.pas
  TDateTime32 = AFloat32;
  TDateTime64 = AFloat64;
  THandle = UIntPtr;
  THandle32 = AUInt32;
  THandle64 = AUInt64;
  TId = UIntPtr;
  TId32 = AUInt32;
  TId64 = AUInt64;

type
  TProfStrings = array of WideString;

// --- Log types ---

type
  TLogTypeMessage = (
    ltNone,
    ltError,
    ltWarning,
    ltInformation,
    ltOk,
    ltCancel
  );

type
  TLogGroupMessage = (
    lgNone,
    lgNetwork,
    lgSetup,
    lgGeneral,
    lgDataBase,
    lgKey,
    lgEquipment,
    lgAlgorithm,
    lgSystem,
    lgUser,
    lgAgent
  );

const
  CHR_LOG_GROUP_MESSAGE: array[TLogGroupMessage] of string = (
      'Non', 'Net', 'Set', 'Gen', 'DB', 'Key', 'Equ', 'Alg', 'Sys', 'Usr', 'Agn'
    );
  CHR_LOG_TYPE_MESSAGE: array[TLogTypeMessage] of string = (
      'N', 'E', 'W', 'I', '+', '-'
    );

// --- Constants for enum Log ---

type
  GroupMessageEnum = Integer;
  EnumGroupMessage = GroupMessageEnum;
const
  elgNone      = $00000000;
  elgNetwork   = $00000001;
  elgSetup     = $00000002;
  elgGeneral   = $00000004;
  elgDataBase  = $00000008;
  elgKey       = $00000010;
  elgEquipment = $00000020;
  elgAlgorithm = $00000040;
  elgSystem    = $00000080;
  elgUser      = $00000100;
  elgAgent     = $00010000;

const
  OLE_GROUP_MESSAGE: array[TLogGroupMessage] of EnumGroupMessage = (
      elgNone, elgNetwork, elgSetup, elgGeneral, elgDataBase, elgKey, elgEquipment, elgAlgorithm, elgSystem, elgUser, elgAgent
    );

type
  EnumNodeStatus = Integer;
  StatusNodeEnum = EnumNodeStatus;
const
  elsNone    = $01;
  elsOK      = $02;
  elsCancel  = $04;
  elsError   = $08;
  elsWarning = $10;
  elsInformation = $20;

type
  TLogNodeStatus = (
    lsNone,
    lsOk,
    lsCancel,
    lsError,
    lsWarning,
    lsInformation
    );

type
  TLogType = (
    lNone,
    lDocuments,
    lFile,
    lWindow,
    lLogSystem,
    lProgram,
    lTreeView,
    lUnknown
    );
  TLogTypeSet = set of TLogType;

const
  int_lNone = $00;
  int_lDocuments = $01;
  int_lFile      = $02;
  int_lWindow    = $04;
  int_lLogSystem = $08;
  int_lProgram   = $10;
  int_lTreeView  = $20;
  int_lUnknown   = $40;

// --- Addon types ---

type
  {** Entity type }
  TProfEntityType = AId;
const
  ENTITY_TYPE_NONE          = $01;
  ENTITY_TYPE_UNKNOWN       = $02;
  ENTYTY_TYPE_LIST          = $03;
  ENTITY_TYPE_ATTRIBUTE     = $04;
  ENTITY_TYPE_ATTRIBUTES    = $05;
  ENTITY_TYPE_NODE          = $06;
  ENTITY_TYPE_NODES         = $07;
  ENTITY_TYPE_DOCUMENT      = $08;
  ENTITY_TYPE_DOCUMENTS     = $09;
  ENTITY_TYPE_LOG_NODE      = $0A;
  ENTITY_TYPE_LOG_DOCUMENT  = $0B;
  ENTITY_TYPE_LOG_DOCUMENTS = $0C;
  ENTITY_TYPE_CONFIG_NODE   = $0D;
  ENTITY_TYPE_CONFIG_NODES  = $0E;
  ENTITY_TYPE_CONFIG_DOCUMENT  = $0F;
  ENTITY_TYPE_CONFIG_DOCUMENTS = $10;

type
  TMessageType = (
    mtNone,   // No message. Use in konveer messages.
    mtComand, // Comand
    mtEvent,  // Event
    mtAnswer, // Result
    mtPing,   // Ping
    mtUncnown // Uncnown
    );
{
type
  TMessageType = Integer;
const
  mtNone    = $0001;
  mtUncnown = $0002;
  mtComand  = $0004;
  mtEvent   = $0008;
  mtAnswer  = $0010;
  mtPing    = $0020;
}

type // Constants for enum EnumTypeMessage -------------------------------------
  TypeMessageEnum = Integer;
  EnumTypeMessage = Integer;
  EnumLogTypeMessage = EnumTypeMessage;
const
  eltNone        = $00000000;
  eltError       = $00000001;
  eltWarning     = $00000002;
  eltInformation = $00000004;
  eltOk          = $00000010;
  eltCancel      = $00000020;

const
  OLE_TYPE_MESSAGE: array[TLogTypeMessage] of EnumTypeMessage = (
      eltNone, eltError, eltWarning, eltInformation, eltOk, eltCancel
    );

// ---

type
  TThreadState = Integer;
const
  tsStarted      = $0001;
  tsStarting     = $0002;
  tsTerminated   = $0004;
  tsTerminating  = $0008;
  tsPaused       = $0010;
  tsPausing      = $0020;
  tsStoped       = $0040;
  tsStoping      = $0080;
  tsUncnown      = $1000;

// ---
type
  TArrayByte = array of Byte;
  TArrayChar = array of Char;
  TArrayFloat32 = array of AFloat32;
  TArrayString = array of String;
// ---

// --- Function type ---

type
  // TODO: Delete TAddToLog
  TAddToLog = function (
                         AGroup: TLogGroupMessage;
                         AType: TLogTypeMessage;
                         const AStrMsg: string;
                         AParams: array of const
                       ): Boolean of object; {deprecated;}

  TProfAddToLog = function(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
      const AStrMsg: WideString; AParams: array of const): Integer of object;

  TAddToLogProc = function(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
      const AStrMsg: WideString): Integer of object;

  TAddToLogProcA = function(AGroup: TLogGroupMessage; AType: TLogTypeMessage; AStrMsg: AStr): AInt;

type
  TProcMessageX = function(Msg: AMessage): Integer of object;
  TProcMessageSafe = function(Msg: AMessage): Integer of object; safecall;
  TProcMessageStr = function(const AMsg: WideString): AInt of object;
  TProcMessageStrSafe = function(const AMsg: WideString): Integer of object; safecall;
  TProcMessageA = TProcMessageSafe;

type
  TProgressSafeProc = function(AID, AProgress: Integer; const AMsg: WideString): Integer of object; safecall;
  TProcProgress = TProgressSafeProc;

type
  TProfMessageRec = record
    FContent: WideString;
    FConversationID: WideString;
    FInReplyTo: WideString;
    FReceiverName: WideString;
    FReplyBy: TDateTime;
    FReplyWith: WideString;
    FSenderName: WideString;
    ConnectionId: UInt64;
    Ident: AInt32;
    Msg: WideString;
    MsgId: AUInt64;
    MsgName: WideString;
    MsgType: TMessageType;
    OwnerId: UInt64;
    Params: WideString{IProfXmlNode};
    //ParamsOld: TProfXmlNode1;
  end;

type
  TWinVersion = (wvUnknown, wv95, wv98, wvME, wvNT3, wvNT4, wvW2K, wvXP, wv2003);

const
  STR_WIN_VERSION: array[TWinVersion] of string = (
      'Uncnown',
      'Windows 95',
      'Windows 98',
      'Windows ME',
      'Windows NT3',
      'Windows NT4',
      'Windows 2000',
      'Windows XP',
      'Windows 2003');
  STR_GROUP_LOG_ENG: array[TLogGroupMessage] of string = (
      ' none     ',
      ' network  ',
      ' setup    ',
      ' general  ',
      ' database ',
      ' key      ',
      ' equipment',
      ' algorithm',
      ' system   ',
      ' user     ',
      ' lgAgent  ');
  STR_TYPE_LOG_ENG: array[TLogTypeMessage] of string = (
      ' none  ',
      ' error ',
      ' warn  ',
      ' info  ',
      ' ok    ',
      ' cancel');

// ----

type
  TFileVersionInfoA = record
    ProductName: AnsiString;
    ProductVersion: AnsiString;
    OriginalFileName: AnsiString;
    InternalName: AnsiString;
    FileVersion: AnsiString;
    LegalCopyright: AnsiString;
    CompanyName: AnsiString;
    FileDescription: AnsiString;
  end;

type //** Command params
  TSwitch = (sTest, sDebug, sSilent, sConsole, sInstall, sUnInstall, sStart, sStop, sNoSplash, sTeach, sDemo);
const
  STR_SWITCH: array[TSwitch] of string = ('TEST', 'DEBUG', 'SILENT', 'CONSOLE', 'INSTALL', 'UNINSTALL', 'START', 'STOP', 'NOSPLASH', 'TEACH', 'DEMO');

type
  ALogDocument = type AInt; // = TALogDocument or TALogDocumentObject
  ALogNode = type AInt; // = TALogNode or TALogNodeObject

// --- Entity ---

type
  AEntity_Type = record
    EntityType: TProfEntityType;
    Id: AId;
    LogPrefix: WideString;
    Name: WideString;
  end;

  ANamedEntity_Type = record
    Entity: AEntity_Type;
    Name: WideString;
  end;

  TDeleteSpaceOptions = (
    dsFirst,
    dsLast,
    dsRep
    );
  TDeleteSpaceOptionsSet = set of TDeleteSpaceOptions;

  TDeleteSpaceOption = TDeleteSpaceOptions;
  TDeleteSpaceOptionSet = TDeleteSpaceOptionsSet;

  TAttribute = record
    Name: WideString;
    Value: WideString;
  end;

  TAttributes = array of TAttribute;

implementation

end.
