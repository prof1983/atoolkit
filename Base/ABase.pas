{**
@Abstract Base types and consts
@Author Prof1983 <prof1983@ya.ru>
@Created 06.03.2008
@LastMod 11.04.2013
}
unit ABase;

{$I A.inc}

interface

type // Simple types
  AFloat32 = Single;
  AFloat64 = Double;
  AInt08 = ShortInt;
  AInt16 = SmallInt;
  AInt32 = LongInt;
  AInt64 = Int64;
  AUInt08 = Byte;
  AUInt16 = Word;
  AUInt32 = LongWord;
  AUInt64 = Int64;
  AWideChar = WideChar;

type // Simple types
  ABool = Boolean;
  AChar = AnsiChar;
  AInt = Integer;
  ARune = AInt32; // UTF-32 (UCS4Char)
  ASize = LongWord;

type
  ABoolean = ABool;
  AFloat = {$IFDEF AFloat32}AFloat32{$ELSE}AFloat64{$ENDIF};
  AInteger = AInt;
  AUInt = AUInt32;

type
  {** Version type }
  AVersion = type AInt;
  {** Version type
      Format: $AABBCCDD = AA.BB.CC.DD }
  AVersion32 = type AInt32;
  {** Version type
      Format: $AAAABBBBCCCCDDDD = AAAA.BBBB.CCCC.DDDD }
  AVersion64 = type AInt64;
const
    //** Version mask for checking
  AVersionMask = $FFFF0000;
  AVersionMask64 = $FFFFFFFF00000000;

type
  {**
    Function result type
    <0 - Error,
    0 - Ok,
    >0 - Information or Warnings
  }
  AError = type Integer;

// --- Array ---

type
  //AArray = ^AArray_Type;
  AArray_Type = packed record {4x4}
    Data: Pointer;
    Len: AInteger;
    AllocateLen: AInteger;
    Reserved03: AInteger;
  end;

// --- String ---

type
  {** String code: 0 - Unknown or AnsiString; 1 - PAnsiChar; 2 - UTF-8 }
  AStringCode = AInt;

const
  AStringCode_Unknown = 0;
  AStringCode_Ansi = 1;
  AStringCode_Utf8 = 2;

type
  AWideString = WideString;
  APascalString = {$IFDEF DELPHI_2010_UP}string{$ELSE}WideString{$ENDIF};

    // (4x4 = 16 bytes)
  AString_Type_4 = packed record
      //** UTF-8. Analog GString Points to the string's current \0-terminated value (gchar).
    Str: PAnsiChar;
      //** Length (count chars). Analog GString Current length (gsize)
    Len: AInteger;
      //** Allocated size in bytes. Analog GString allocated_len (gsize).
    AllocSize: ASize;
      //** Code: 0 - Unknown or AnsiString; 1 - PAnsiChar; 2 - UTF-8
    Code: AStringCode;
  end;

  AString_Type = AString_Type_4;

  AStr = PAnsiChar;
  AString  = AInt; // ^AString_Type;

{
type
  // (for Win32 and Linux)
  AData = Pointer;
  // (for CLR and Java)
  //AData = TObject;
}

// --- ---

type
  AProc = function(): AError; stdcall;
  ACallbackProc = function(Obj, Data: AInt): AError; stdcall;

type
  AObject = type AInt;
  ASettings = type AInt;
  AEvent = type AInt; // = AEvent_Type.Id
  AColor = type AInt;

  AConfig = ASettings;

type
  ALibrary = type AInteger;
  ALibraryFlags = type AInteger;

type
    //** Identifier
  AId = AInt64;
  TAId = AId;

  AMessage = type AInt; // = AMessage_Type*
  AMessage_Type = record
      {** Message identifier }
    MsgId: AInt;
      {** Message type }
    MsgType: AInt;
      {** Message data size }
    MsgDataSize: AInt;
    {**
      Message data (depends on the MsgType):
        ConversationID
        Content
        Encoding
        InReplyTo
        Language
        Ontology
        Protocol
        ReceiverName
        ReplyBy
        ReplyWith
        Performative
        PersistentID
        SenderName
    }
    MsgData: Pointer;
  end;

  ADocument = type AInt;
  ANode = type AInt; // =TANode
  ANodeList = type AInt; // =TProfNodes3

  AIterator = type AInt; // =TAEntityIterator (=IAIterator)

  AXmlNodeCollection = type AInt; // TProfXmlCollection
  AXmlNode = ANode; // TProfXmlNode or TProfXmlNode1 or TProfXmlNode2 or TANode
  AXmlNodeList = ANodeList; // =AXmlNodeList_Type.Id (TProfXmlNodeList) or TProfNodes3
  AConfigNode = AXmlNode; // =AXmlNode or AConfig

  //AXmlDocument = ADocument; // AXmlDocumentImpl.TProfXmlDocument
  //AProfXmlDocument = AXmlDocument; // deprecated
  //AProfXmlDocument1 = AXmlDocument; // deprecated
  //AProfXmlNode = type AXmlNode; // AXmlNodeImpl.TProfXmlNode or TProfXmlNode2
  //AProfXmlNode1 = type AProfXmlNode; // TProfXmlNode1
  //AProfXmlNode2 = type AProfXmlNode; // TProfXmlNode2
  //AProfXmlNodeA = type AInt; // IProfXmlNodeA

const
  AObjConst = $414F626A; // = 'AObj'

implementation

end.
