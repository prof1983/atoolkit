{**
@Abstract(Работа с файлом конфигураций и настроек)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.05.2005)
@LastMod(03.05.2012)
@Version(0.5)

0.0.0.3 - 25.02.2006 - Format
0.0.0.2 - 04.10.2005 - ReadFloat64, WriteFloat64
0.0.0.1 - 20.05.2005
}
unit AConfigObject2;

interface

uses
  AdoDb, IniFiles,
  ABaseUtils3, AConfigObject, AErrorTypes, AIoTypes, ATypes;

type
  TParam = class
  private
    FName: String;
    FValue: String;
  public
    function GetName: String;
    function GetValue: String;
    function SetName(Value: String): TError;
    function SetValue(Value: String): TError;
  end;

type
  TConfigDB = class(TConfig)
  private
    FConnection: TAdoConnection;
    FFileName: String;
    FTable: TAdoTable;
    FTableName: String;
  public
    function Finalize: TError; override;
    function Initialize: TError; override;
    function ReadBool(Section, Name: String; var Value: Boolean): TError; override;
    function ReadInt32(Section, Name: String; var Value: Int32): Boolean; override;
    function ReadString(Section, Name: String; var Value: String): Boolean; override;
    function ReadUInt64(Section, Name: String; var Value: UInt64): Boolean; override;
    function WriteBool(Section, Name: String; Value: Boolean): TError; override;
    function WriteInt32(Section, Name: String; Value: Int32): TError; override;
    function WriteString(Section, Name, Value: String): TError; override;
    function WriteUInt64(Section, Name: String; Value: UInt64): Boolean; override;
  public
    property Connection: TAdoConnection read FConnection write FConnection;
    property FileName: String read FFileName write FFileName;
    property Table: TAdoTable read FTable write FTable;
    property TableName: String read FTableName write FTableName;
  end;

type
  TConfigFileText = class(TConfig)
  private
    FParams: array of TParam;
  public
    function AddParam(Param: TParam): Int32;
    function Clear: TError;
    function GetCountParams: UInt32;
    function GetParam(Index: UInt32): TParam;
    function GetParamByName(Name: String): TParam;

    function GetParamValueByName(const Name: String): String;
    function GetParamValueByNameAsBoolean(const Name: String): Boolean;
    function GetParamValueByNameAsInt32(const Name: String): Int32;
    function GetParamValueByNameAsUInt64(const Name: String): UInt64;

    function Load(FileName: String): TError;
    function NewParam(Name, Value: String): Int32;

    function ReadParamValueByName(const Name: String; var Value: String): Boolean;
    function ReadParamValueByNameAsBoolean(const Name: String; var Value: Boolean): Boolean;
    function ReadParamValueByNameAsInt32(const Name: String; var Value: Int32): Boolean;
    function ReadParamValueByNameAsUInt64(const Name: String; var Value: UInt64): Boolean;

    function ReadStr(Name: String; var Value: String): Boolean; deprecated; // Use ReadString()
    function ReadString(Section, Name: String; var Value: String): Boolean; override;
    function ReadUInt08(Name: String; var Value: UInt08): Boolean; override;
    function Save(FileName: String): TError;
    function SetParamValueByName(Name, Value: String): TError; override;
    function SetParamValueByNameAsBoolean(Name: String; Value: Boolean): TError; override;
    function SetParamValueByNameAsInt32(Name: String; Value: Int32): TError; override;
    function WriteBool(Section, Name: String; Value: Boolean): TError; override;
    function WriteFloat64(Name: String; Value: Float64): TError; override;
    function WriteInt32(Section, Name: String; Value: Int32): TError; override;
    function WriteStr(Name, Value: String): TError; deprecated; // Use WriteString()
    function WriteString(Section, Name, Value: String): TError; virtual;
    function WriteUInt32(Name: String; Value: UInt32): TError; override;
  public
    procedure Free; override;
  end;

implementation

{ TConfigDB }

function TConfigDB.Finalize: TError;
begin
  if Assigned(FTable) then
  begin
    FTable.Close;
    FTable.Free;
    FTable := nil;
  end;
  Result := inherited Finalize;
end;

function TConfigDB.Initialize: TError;
begin
  Result := 0;
  if Assigned(FTable) then Exit;
  Result := ER_Error;
  if (FTableName = '') then Exit;
  if not(Assigned(FConnection)) then
  begin
    if (FFileName = '') then Exit;
    FConnection := TAdoConnection.Create(nil);
    FConnection.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;' +
      'Data Source='+FFileName+';Persist Security Info=False';
    FConnection.LoginPrompt := False;
    FConnection.Connected := True;
  end;
  FTable := TAdoTable.Create(nil);
  FTable.Connection := FConnection;
  FTable.TableName := FTableName;
  FTable.Active := True;
  Result := 0;
end;

function TConfigDB.ReadBool(Section, Name: String; var Value: Boolean): TError;
begin
  Result := -1;
  if not(Assigned(FTable)) then Exit;
  if FTable.RecordCount = 0 then Exit;
  FTable.First;
  repeat
    if (FTable.FieldByName('Section').Value = Section)
    and (FTable.FieldByName('Name').Value = Name) then
    begin
      if FTable.FieldByName('Value').Value = 'True' then
      begin
        Value := True;
        Result := 0;
      end
      else
      if (FTable.FieldByName('Value').Value = 'False') then
      begin
        Value := False;
        Result := 0;
      end;
      Exit;
    end;
    FTable.Next;
  until FTable.Eof;
end;

function TConfigDB.ReadInt32(Section, Name: String; var Value: Int32): Boolean;
begin
  Result := False;
  if not(Assigned(FTable)) then Exit;
  if FTable.RecordCount = 0 then Exit;
  FTable.First;
  repeat
    if (FTable.FieldByName('Section').Value = Section)
    and (FTable.FieldByName('Name').Value = Name) then begin
      Result := (_StrToInt32(FTable.FieldByName('Value').Value, Value) = 0);
      Exit;
    end;
    FTable.Next;
  until FTable.Eof;
end;

function TConfigDB.ReadString(Section, Name: String; var Value: String): Boolean;
begin
  Result := False;
  if not(Assigned(FTable)) then Exit;
  if FTable.RecordCount = 0 then Exit;
  FTable.First;
  repeat
    if (FTable.FieldByName('Section').Value = Section)
    and (FTable.FieldByName('Name').Value = Name) then begin
      Value := FTable.FieldByName('Value').Value;
      Result := True;
      Exit;
    end;
    FTable.Next;
  until FTable.Eof;
end;

function TConfigDB.ReadUInt64(Section, Name: String; var Value: UInt64): Boolean;
begin
  Result := False;
  if not(Assigned(FTable)) then Exit;
  if FTable.RecordCount = 0 then Exit;
  FTable.First;
  repeat
    if (FTable.FieldByName('Section').Value = Section)
    and (FTable.FieldByName('Name').Value = Name) then begin
      Result := (_StrToUInt64(FTable.FieldByName('Value').Value, Value) = 0);
      Exit;
    end;
    FTable.Next;
  until FTable.Eof;
end;

function TConfigDB.WriteBool(Section, Name: String; Value: Boolean): TError;
begin
  Result := -1;
  if not(Assigned(FTable)) then Exit;
  if FTable.RecordCount > 0 then
  begin
    FTable.First;
    repeat
      if (FTable.FieldByName('Section').Value = Section)
      and (FTable.FieldByName('Name').Value = Name) then begin
        if Value then
          FTable.FieldByName('Value').Value := 'True'
        else
          FTable.FieldByName('Value').Value := 'False';
        Exit;
      end;
      FTable.Next;
    until FTable.Eof;
  end;
  FTable.Insert;
  FTable.FieldByName('Section').Value := Section;
  FTable.FieldByName('Name').Value := Name;
  if Value then
    FTable.FieldByName('Value').Value := 'True'
  else
    FTable.FieldByName('Value').Value := 'False';
  FTable.Post;
  Result := 0;
end;

function TConfigDB.WriteInt32(Section, Name: String; Value: Int32): TError;
begin
  Result := -1;
  if not(Assigned(FTable)) then Exit;
  if FTable.RecordCount > 0 then
  begin
    FTable.First;
    repeat
      if (FTable.FieldByName('Section').Value = Section)
      and (FTable.FieldByName('Name').Value = Name) then
      begin
        FTable.FieldByName('Value').Value := cInt32ToStr(Value);
        Result := 0;
        Exit;
      end;
      FTable.Next;
    until FTable.Eof;
  end;
  FTable.Insert;
  FTable.FieldByName('Section').Value := Section;
  FTable.FieldByName('Name').Value := Name;
  FTable.FieldByName('Value').Value := cInt32ToStr(Value);
  FTable.Post;
  Result := 0;
end;

function TConfigDB.WriteString(Section, Name, Value: String): TError;
begin
  Result := -1;
  if not(Assigned(FTable)) then Exit;
  if FTable.RecordCount > 0 then
  begin
    FTable.First;
    repeat
      if (FTable.FieldByName('Section').Value = Section)
      and (FTable.FieldByName('Name').Value = Name) then
      begin
        FTable.FieldByName('Value').Value := Value;
        Result := 0;
        Exit;
      end;
      FTable.Next;
    until FTable.Eof;
  end;
  FTable.Insert;
  FTable.FieldByName('Section').Value := Section;
  FTable.FieldByName('Name').Value := Name;
  FTable.FieldByName('Value').Value := Value;
  FTable.Post;
  Result := 0;
end;

function TConfigDB.WriteUInt64(Section, Name: String; Value: UInt64): Boolean;
begin
  Result := False;
  if not(Assigned(FTable)) then Exit;
  if FTable.RecordCount > 0 then begin
    FTable.First;
    repeat
      if (FTable.FieldByName('Section').Value = Section)
      and (FTable.FieldByName('Name').Value = Name) then begin
        FTable.FieldByName('Value').Value := cUInt64ToStr(Value);
        Result := True;
        Exit;
      end;
      FTable.Next;
    until FTable.Eof;
  end;
  FTable.Insert;
  FTable.FieldByName('Section').Value := Section;
  FTable.FieldByName('Name').Value := Name;
  FTable.FieldByName('Value').Value := cUInt64ToStr(Value);
  FTable.Post;
  Result := True;
end;

{ TConfigFileText }

function TConfigFileText.AddParam(Param: TParam): Int32;
begin
  Result := Length(FParams);
  SetLength(FParams, Result + 1);
  FParams[Result] := Param;
end;

function TConfigFileText.Clear: TError;
var
  I: Int32;
begin
  for I := 0 to High(FParams) do FParams[I].Free;
  SetLength(FParams, 0);
  Result := 0;
end;

procedure TConfigFileText.Free;
begin
  Clear;
  inherited Free;
end;

function TConfigFileText.GetCountParams: UInt32;
begin
  Result := Length(FParams);
end;

function TConfigFileText.GetParam(Index: UInt32): TParam;
begin
  if Index >= UInt32(Length(FParams)) then
    Result := nil
  else
    Result := FParams[Index];
end;

function TConfigFileText.GetParamByName(Name: String): TParam;
var
  I: Int32;
begin
  for I := 0 to High(FParams) do begin
    if FParams[I].GetName = Name then begin
      Result := FParams[I];
      Exit;
    end;
  end;
  Result := nil;
end;

function TConfigFileText.GetParamValueByName(const Name: String): String;
begin
  ReadParamValueByName(Name, Result);
end;

function TConfigFileText.GetParamValueByNameAsBoolean(const Name: String): Boolean;
begin
  ReadParamValueByNameAsBoolean(Name, Result);
end;

function TConfigFileText.GetParamValueByNameAsInt32(const Name: String): Int32;
begin
  ReadParamValueByNameAsInt32(Name, Result);
end;

function TConfigFileText.GetParamValueByNameAsUInt64(const Name: String): UInt64;
begin
  ReadParamValueByNameAsUInt64(Name, Result);
end;

function TConfigFileText.Load(FileName: String): TError;
var
  F: TProfFileText;
  Name: String;
  Value: String;
begin
  F := TProfFileText.Create();
  Result := F.Open(FileName);
  if Result <> 0 then Exit;
  while not(F.Eof) do begin
    F.ReadLn(Name);
    Name := Copy(Name, 2, Length(Name) - 2);
    F.ReadLn(Value);
    NewParam(Name, Value);
  end;
  F.Free;
end;

function TConfigFileText.NewParam(Name, Value: String): Int32;
var
  Param: TParam;
begin
  Param := TParam.Create;
  Param.SetName(Name);
  Param.SetValue(Value);
  Result := AddParam(Param);
end;

function TConfigFileText.ReadParamValueByName(const Name: String; var Value: String): Boolean;
var
  Param: TParam;
begin
  Param := GetParamByName(Name);
  Result := Assigned(Param);
  if not(Result) then Exit;
  Value := Param.GetValue;
end;

function TConfigFileText.ReadParamValueByNameAsBoolean(const Name: String; var Value: Boolean): Boolean;
var
  S: String;
begin
  Result := ReadParamValueByName(Name, S);
  if not(Result) then Exit;
  Value := (S = 'True');
end;

function TConfigFileText.ReadParamValueByNameAsInt32(const Name: String; var Value: Int32): Boolean;
var
  S: String;
begin
  Result := ReadParamValueByName(Name, S);
  if not(Result) then Exit;
  Value := cStrToInt32(S);
end;

function TConfigFileText.ReadParamValueByNameAsUInt64(const Name: String; var Value: UInt64): Boolean;
var
  S: String;
begin
  Result := ReadParamValueByName(Name, S);
  if not(Result) then Exit;
  Value := cStrToInt32(S);
end;

function TConfigFileText.ReadStr(Name: String; var Value: String): Boolean;
begin
  Result := ReadString('', Name, Value);
end;

function TConfigFileText.ReadString(Section, Name: String; var Value: String): Boolean;
begin
  Result := ReadParamValueByName(Name, Value);
end;

function TConfigFileText.ReadUInt08(Name: String; var Value: UInt08): Boolean;
var
  S: String;
begin
  Result := ReadStr(Name, S);
  if not(Result) then Exit;
  Result := (_StrToUInt08(S, Value) = 0);
end;

function TConfigFileText.Save(FileName: String): TError;
var
  F: TProfFileText;
  I: Int32;
begin
  F := TProfFileText.Create();
  Result := F.OpenCreate(FileName);
  if Result <> 0 then Exit;
  for I := 0 to High(FParams) do begin
    F.WriteLn('[' + FParams[I].GetName + ']');
    F.WriteLn(FParams[I].GetValue);
  end;
  F.Free;
end;

function TConfigFileText.SetParamValueByName(Name, Value: String): TError;
var
  Param: TParam;
begin
  Param := GetParamByName(Name);
  if not(Assigned(Param)) then begin
    NewParam(Name, Value);
  end else
    Param.SetValue(Value);
  Result := 0;
end;

function TConfigFileText.SetParamValueByNameAsBoolean(Name: String; Value: Boolean): TError;
var
  S: String;
begin
  if Value then S := 'True' else S := 'False';
  Result := SetParamValueByName(Name, S);
end;

function TConfigFileText.SetParamValueByNameAsInt32(Name: String; Value: Int32): TError;
begin
  Result := SetParamValueByName(Name, cInt32ToStr(Value));
end;

function TConfigFileText.WriteBool(Section, Name: String; Value: Boolean): TError;
var
  S: String;
begin
  if Value then S := 'True' else S := 'False';
  Result := SetParamValueByName(Name, S);
end;

function TConfigFileText.WriteFloat64(Name: String; Value: Float64): TError;
begin
  Result := SetParamValueByName(Name, cFloat64ToStr(Value));
end;

function TConfigFileText.WriteInt32(Section, Name: String; Value: Int32): TError;
begin
  Result := SetParamValueByName(Name, cInt32ToStr(Value));
end;

function TConfigFileText.WriteStr(Name, Value: String): TError;
begin
  Result := WriteString('', Name, Value);
end;

function TConfigFileText.WriteString(Section, Name, Value: String): TError;
begin
  Result := SetParamValueByName(Name, Value);
end;

function TConfigFileText.WriteUInt32(Name: String; Value: UInt32): TError;
begin
  Result := SetParamValueByName(Name, cUInt32ToStr(Value));
end;

{ TParam }

function TParam.GetName: String;
begin
  Result := FName;
end;

function TParam.GetValue: String;
begin
  Result := FValue;
end;

function TParam.SetName(Value: String): TError;
begin
  FName := Value;
  Result := 0;
end;

function TParam.SetValue(Value: String): TError;
begin
  FValue := Value;
  Result := 0;
end;

end.
