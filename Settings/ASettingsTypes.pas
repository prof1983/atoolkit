{**
@Abstract ASettings types
@Author Prof1983 <prof1983@ya.ru>
@Created 01.04.2013
@LastMod 02.04.2013
}
unit ASettingsTypes;

interface

uses
  SysUtils,
  ABase,
  ABaseTypes,
  AObjects;

type
  ASettings = AInt; // = AConfig;

type
  ASettings_Interface = record
    Close: function(Settings: ASettings): AError;
    DeleteKey: function(Settings: ASettings; const Section, Name: AString_Type): AError;
    DeleteSection: function(Settings: ASettings; const Section: AString_Type): AError;
    ReadBool: function(Settings: ASettings; const Section, Name: AString_Type; out Value: ABool): AError;
    ReadDateTime: function(Settings: ASettings; const Section, Name: AString_Type; out Value: TDateTime): AError;
    ReadFloat: function(Settings: ASettings; const Section, Name: AString_Type; out Value: AFloat): AError;
    ReadInt: function(Settings: ASettings; const Section, Name: AString_Type; out Value: AInt): AError;
    ReadSection: function(Settings: ASettings; const Section: AString_Type; Strings: AStringList): AError;
    ReadString: function(Settings: ASettings; const Section, Name: AString_Type; out Value: AString_Type): AError;
    WriteBool: function(Settings: ASettings; const Section, Name: AString_Type; Value: ABool): AError;
    WriteDateTime: function(Settings: ASettings; const Section, Name: AString_Type; Value: TDateTime): AError;
    WriteFloat: function(Settings: ASettings; const Section, Name: AString_Type; Value: AFloat): AError;
    WriteInt: function(Settings: ASettings; const Section, Name: AString_Type; Value: AInt): AError;
    WriteString: function(Settings: ASettings; const Section, Name, Value: AString_Type): AError;
  end;

type
  ASettings_Type = record
    Base: AObject_Type;
    Control: ASettings_Interface;
    FormatSettings: TFormatSettings;
  end;

type
  PSettings = ^ASettings_Type;

implementation

end.
