{**
@Abstract AStrings exports
@Author Prof1983 <prof1983@ya.ru>
@Created 01.09.2011
@LastMod 24.07.2012
}
unit AStringsExp;

interface

uses
  AStrings;

exports
  AString_Assign name 'AString_Assign',
  String_AssignA name 'AString_AssignA',
  String_AssignWS name 'AString_AssignWS',
  String_Copy name 'AString_Copy',
  String_CopyA name 'AString_CopyA',
  String_CopyW name 'AString_CopyWS',
  String_Free name 'AString_Free',
  String_Length name 'AString_Length',
  String_ToUtf8String name 'AString_ToUtf8String',
  String_ToWideString name 'AString_ToWideString';

implementation

end.
 