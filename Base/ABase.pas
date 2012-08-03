{**
@abstract Base types and consts
@author Prof1983 <prof1983@ya.ru>
@created 06.03.2008
@lastmod 30.07.2012
}
unit ABase;

{$I A.inc}

{DEFINE A01}
{DEFINE A02}

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
  AChar = AnsiChar; // or UTF-32 (UCS4Char)
  AInt = Integer;
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
  AWideString = WideString;
  APascalString = {$IFDEF DELPHI_2010_UP}string{$ELSE}WideString{$ENDIF};

type
  { (4x4 = 16 bytes) }
  AString_Type_Old = packed record
    Str: AnsiString;
    Reserved01: AInteger;
    Reserved02: AInteger;
    Code: AInteger;
  end;

    // (4x4 = 16 bytes)
  AString_Type_4 = packed record
      //** UTF-8. Analog GString Points to the string's current \0-terminated value (gchar).
    Str: PAnsiChar;
      //** Length (count chars). Analog GString Current length (gsize)
    Len: AInteger;
      //** Allocated size in bytes. Analog GString allocated_len (gsize).
    AllocSize: ASize;
      //** Code: 0 - Unknown or AnsiString; 1 - PAnsiChar; 2 - UTF-8
    Code: AInteger;
  end;

  AString_Type = AString_Type_4;

type
  AStr = PAnsiChar;
  {$IFDEF A01}
  AString = AWideString;
  {$ELSE}
  AString  = ^AString_Type;
  {$ENDIF}

{
type
  // (for Win32 and Linux)
  AData = Pointer;
  // (for CLR and Java)
  //AData = TObject;
}

// --- ---

type
  AProc01 = procedure; stdcall;
  AProc02 = AProc01;
  AProc03 = function(): AInteger; stdcall;
  ACallbackProc01 = procedure(Obj, Data: AInteger); stdcall;
  ACallbackProc02 = ACallbackProc01;
  ACallbackProc03 = function(Obj, Data: AInteger): AError; stdcall;

type
  {$IFDEF A01}
    AProc = AProc01;
    ACallbackProc = ACallbackProc01;
  {$ELSE}
    {$IFDEF A02}
    AProc = AProc02;
    ANotifyProc = procedure(Sender: AInteger); stdcall;
    ACallbackProc = ACallbackProc02;
    {$ELSE}
    AProc = AProc03;
    ACallbackProc = ACallbackProc03;
    {$ENDIF}
  {$ENDIF}

type
  // = TAbstractSettings or TProfXmlNode1 or TProfXmlNode4
  AConfig = type AInteger;
  AEvent = type AInteger;       // = AEvent_Type^
  AColor = type AInteger;
  {$IFDEF A02}
  //AStrings = type AInteger; - Use ACollectionsBase.AStringList
  {$ENDIF A02}

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
  AXmlDocument = ADocument; // AXmlDocumentImpl.TProfXmlDocument or TProfXmlDocument1
  AProfXmlDocument = type AXmlDocument; // AXmlDocumentImpl.TProfXmlDocument
  AProfXmlDocument1 = type Integer; // TProfXmlDocument1
  AXmlNode = ANode; // TProfXmlNode or TProfXmlNode1 or TProfXmlNode2 or TANode
  AProfXmlNode = type AXmlNode; // AXmlNodeImpl.TProfXmlNode or TProfXmlNode2
  AProfXmlNode1 = type AProfXmlNode; // TProfXmlNode1
  AProfXmlNode2 = type AProfXmlNode; // TProfXmlNode2
  AProfXmlNodeA = type AInt; // IProfXmlNodeA
  AXmlNodeList = ANodeList; // =AXmlNodeList_Type.Id (TProfXmlNodeList) or TProfNodes3
  AConfigNode = AXmlNode; // =AXmlNode or AConfig

implementation

end.
