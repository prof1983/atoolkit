{**
@abstract AStrings implementation
@author Prof1983 <prof1983@ya.ru>
@created 20.07.2012
@lastmod 20.07.2012
}
unit AStringsImpl;

interface

uses
  Classes,
  ABase, ACollectionsBase, AStringsIntf;

type
  TAStrings = class(TInterfacedObject, IAStrings)
  private
    FItems: array of WideString;
    FStringList: TStringList;
  protected
    function Get_Count(): Integer;
    function Get_Name(Index: Integer): WideString;
    function Get_String(Index: Integer): WideString;
    function Get_Value(const Name: WideString): WideString;
  public
    function GetCount(): Integer;
    function GetName(Index: Integer): WideString;
    function GetNameByIndex(Index: Integer): WideString;
    function GetString(Index: Integer): WideString;
    function GetStrings(): AStringList;
    function GetStringList(): TStringList;
    function GetValue(const Name: WideString): WideString;
  public
    function Add(S: WideString): Integer;
    procedure Clear();
  public
    constructor Create();
  public
    property Count: Integer read Get_Count;
    property Names[Index: Integer]: WideString read GetName;
    property Strings[Index: Integer]: WideString read GetString;
    property Values[const Name: WideString]: WideString read GetValue;
  end;

implementation

{ TAStrings }

function TAStrings.Add(S: WideString): Integer;
begin
  if Assigned(FStringList) then
    Result := FStringList.Add(S)
  else
  begin
    Result := Length(FItems);
    SetLength(FItems, Result + 1);
    FItems[Result] := S;
  end;
end;

procedure TAStrings.Clear();
begin
  if Assigned(FStringList) then
    FStringList.Clear()
  else
    SetLength(FItems, 0);
end;

constructor TAStrings.Create();
begin
  inherited Create();
  FStringList := TStringList.Create();
end;

function TAStrings.GetCount(): Integer;
begin
  if Assigned(FStringList) then
    Result := FStringList.Count
  else
    Result := Length(FItems);
end;

function TAStrings.GetName(Index: Integer): WideString;
begin
  if Assigned(FStringList) then
    FStringList.Names[Index]
  else
  begin
    if (Index >= 0) and (Index < Length(FItems)) then
      Result := GetNameByIndex(Index)
    else
      Result := '';
  end;
end;

function TAStrings.GetNameByIndex(Index: Integer): WideString;
var
  I: Integer;
begin
  if Assigned(FStringList) then
    Result := FStringList.Names[Index]
  else
  begin
    I := Pos('=', FItems[Index]);
    if (I > 0) then
      Result := Copy(FItems[Index], 1, I - 1)
    else
      Result := FItems[Index];
  end;
end;

function TAStrings.GetString(Index: Integer): WideString;
begin
  if Assigned(FStringList) then
    Result := FStringList.Strings[Index]
  else
  begin
    if (Index >= 0) and (Index < Length(FItems)) then
      Result := FItems[Index]
    else
      Result := '';
  end;
end;

function TAStrings.GetStringList(): TStringList;
begin
  Result := FStringList;
end;

function TAStrings.GetStrings(): AStringList;
begin
  Result := AStringList(FStringList);
end;

function TAStrings.GetValue(const Name: WideString): WideString;
var
  I: Integer;
  P: Integer;
begin
  if Assigned(FStringList) then
    Result := FStringList.Values[Name]
  else
  begin
    for I := 0 to High(FItems) do
    begin
      if (GetNameByIndex(I) = Name) then
      begin
        P := Pos('=', FItems[I]);
        if (P > 0) then
          Result := Copy(FItems[I], P + 1, Length(FItems[I]))
        else
          Result := '';
        Exit;
      end;
    end;
    Result := '';
  end;
end;

function TAStrings.Get_Count(): Integer;
begin
  Result := GetCount();
end;

function TAStrings.Get_Name(Index: Integer): WideString;
begin
  Result := GetName(Index);
end;

function TAStrings.Get_String(Index: Integer): WideString;
begin
  Result := GetString(Index);
end;

function TAStrings.Get_Value(const Name: WideString): WideString;
begin
  Result := GetValue(Name);
end;

end.
