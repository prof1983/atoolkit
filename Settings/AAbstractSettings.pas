{**
@Abstract AAbstractSettings
@Author Prof1983 <prof1983@ya.ru>
@Created 06.03.2008
@LastMod 24.07.2012
}
unit AAbstractSettings;

{DEFINE USE_AUTILS}

interface

uses
  {$IFDEF USE_AUTILS}AUtils{$ELSE}SysUtils{$ENDIF},
  ABase, ABaseConsts, ACollectionsBase;

type
  TAbstractSettings = class
  private
    FFormatSettings: TFormatSettings;
  public
    procedure Close; virtual;
    function DeleteKey(const Section, Name: APascalString): ABoolean; virtual;
    function DeleteSection(const Section: APascalString): ABoolean; virtual;
    function ReadBool(const Section, Name: APascalString; DefValue: ABoolean): ABoolean; virtual;
    function ReadInteger(const Section, Name: APascalString; DefValue: AInteger): AInteger; virtual;
    function ReadFloat(const Section, Name: APascalString; DefValue: AFloat): AFloat; virtual;
    function ReadSection(const Section: APascalString; Strings: AStringList): ABoolean; virtual;
    function ReadString(const Section, Name, DefValue: APascalString; out Value: APascalString): AInteger; virtual;
    function ReadDateTime(const Section, Name: APascalString; DefValue: TDateTime): TDateTime; virtual;
    function WriteBool(const Section, Name: APascalString; Value: Boolean): ABoolean; virtual;
    function WriteInteger(const Section, Name: APascalString; Value: Integer): ABoolean; virtual;
    function WriteFloat(const Section, Name: APascalString; Value: AFloat): ABoolean; virtual;
    function WriteString(const Section, Name, Value: APascalString): ABoolean; virtual;
    function WriteDateTime(const Section, Name: APascalString; Value: TDateTime): ABoolean; virtual;
  public
    constructor Create;
  end;

(*
type
  TSettings = class(TAbstractSettings)
  private
    FRoot: TANode;
  protected
    function GetRoot(): IANode; override;
  public
    function DeleteKey(const Section, Name: AString): ABoolean; override;
    function DeleteSection(const Section: AString): ABoolean; override;
    function ReadString(const Section, Name, DefValue: AString): AString; override;
    function WriteString(const Section, Name, Value: AString): ABoolean; override;
  public
    constructor Create();
  public
    property Root: TANode read FRoot;
  end;
*)

implementation

{ TAbstractSettings }

procedure TAbstractSettings.Close;
begin
end;

constructor TAbstractSettings.Create;
begin
  inherited;
  {IFNDEF UNIX}
  {$IFDEF FPC}
  GetFormatSettings;
  FFormatSettings := DefaultFormatSettings;
  {$ELSE}
  GetLocaleFormatSettings(0, FFormatSettings);
  {$ENDIF}
  FFormatSettings.DecimalSeparator := '.';
  FFormatSettings.DateSeparator := '.';
  FFormatSettings.TimeSeparator := ':';
  FFormatSettings.ShortDateFormat := 'dd.MM.yyyy';
  FFormatSettings.ShortTimeFormat := 'h:mm:ss';
  FFormatSettings.LongTimeFormat := 'h:mm:ss.nnnn';
  {ENDIF}
end;

function TAbstractSettings.DeleteKey(const Section, Name: APascalString): ABoolean;
begin
  Result := False;
end;

function TAbstractSettings.DeleteSection(const Section: APascalString): ABoolean;
begin
  Result := False;
end;

function TAbstractSettings.ReadBool(const Section, Name: APascalString; DefValue: ABoolean): ABoolean;
var
  S: APascalString;
begin
  ReadString(Section, Name, '', S);
  if (S = STR_BOOL[True]) then
    Result := True
  else if (S = STR_BOOL[False]) then
    Result := False
  else
    Result := DefValue;
end;

function TAbstractSettings.ReadDateTime(const Section, Name: APascalString; DefValue: TDateTime): TDateTime;
var
  S: APascalString;
begin
  {IFNDEF UNIX}
  Result := DefValue;
  ReadString(Section, Name, '', S);
  if (S <> '') then
  begin
    {$IFDEF FPC}
    TryStrToDateTime(S, Result);
    {$ELSE}
    TryStrToDateTime(S, Result, FFormatSettings);
    {$ENDIF}
  end;
  {ENDIF}
end;

function TAbstractSettings.ReadFloat(const Section, Name: APascalString; DefValue: AFloat): AFloat;
var
  S: APascalString;
  R: Double;
begin
  Result := DefValue;
  ReadString(Section, Name, '', S);
  {$IFDEF USE_AUTILS}
  if (S <> '') then
    Utils_TryStrToFloat(S, Result);
  {$ELSE}
  if (S <> '') then
    if TryStrToFloat(S, R, FFormatSettings) then
      Result := R;
  {$ENDIF}
end;

function TAbstractSettings.ReadInteger(const Section, Name: APascalString; DefValue: AInteger): AInteger;
var
  S: APascalString;
begin
  Result := DefValue;
  ReadString(Section, Name, '', S);
  if (S <> '') then
    TryStrToInt(S, Result);
end;

function TAbstractSettings.ReadSection(const Section: APascalString; Strings: AStringList): ABoolean;
begin
  Result := False;
end;

function TAbstractSettings.ReadString(const Section, Name, DefValue: APascalString; out Value: APascalString): AInteger;
begin
  Value := DefValue;
  Result := 0;
end;

function TAbstractSettings.WriteBool(const Section, Name: APascalString; Value: ABoolean): ABoolean;
begin
  Result := WriteString(Section, Name, STR_BOOL[Value]);
end;

function TAbstractSettings.WriteDateTime(const Section, Name: APascalString; Value: TDateTime): ABoolean;
begin
  {IFDEF UNIX}
  //Result := False;
  {ELSE}
  {$IFDEF FPC}
  Result := WriteString(Section, Name, DateTimeToStr(Value));
  {$ELSE}
  Result := WriteString(Section, Name, DateTimeToStr(Value, FFormatSettings));
  {$ENDIF}
  {ENDIF}
end;

function TAbstractSettings.WriteFloat(const Section, Name: APascalString; Value: AFloat): ABoolean;
begin
  {$IFDEF UNIX}
  Result := False;
  {$ELSE}
  Result := WriteString(Section, Name, FloatToStr(Value, FFormatSettings));
  {$ENDIF}
end;

function TAbstractSettings.WriteInteger(const Section, Name: APascalString; Value: AInteger): ABoolean;
begin
  Result := WriteString(Section, Name, IntToStr(Value));
end;

function TAbstractSettings.WriteString(const Section, Name, Value: APascalString): ABoolean;
begin
  Result := False;
end;

{ TSettings }

(*
constructor TSettings.Create;
begin
  inherited;
  FRoot := TANode.Create();
end;

function TSettings.DeleteKey(const Section, Name: AString): ABoolean;
var
  node: IANode;
begin
  Result := False;
  node := FRoot.GetChildNodeByName(Section);
  if Assigned(node) then
    Result := node.DeleteAttribute(Name);
end;

function TSettings.DeleteSection(const Section: AString): ABoolean;
begin
  Result := FRoot.DeleteChildNode(Section);
end;

function TSettings.GetRoot: IANode;
begin
  Result := FRoot;
end;

function TSettings.ReadString(const Section, Name, DefValue: AString): AString;
var
  attr: IAAttribute;
  node: IANode;
begin
  Result := DefValue;
  node := FRoot.GetChildNodeByName(Section);
  if Assigned(node) then
  begin
    attr := node.GetAttributeByName(Name);
    if Assigned(attr) then
      Result := attr.AttributeValue;
  end;
end;

function TSettings.WriteString(const Section, Name, Value: AString): ABoolean;
var
  attr: IAAttribute;
  node: IANode;
begin
  node := FRoot.GetChildNodeByName(Section);
  if not(Assigned(node)) then
  begin
    node := TANode.Create();
    node.NodeName := Section;
    FRoot.AddChildNode(node);
  end;
  attr := node.GetAttributeByName(Name);
  if not(Assigned(attr)) then
  begin
    attr := TAAttribute.Create();
    attr.AttributeName := Name;
    node.AddAttribute(attr);
  end;
  attr.AttributeValue := Value;
  Result := True;
end;
*)

end.
