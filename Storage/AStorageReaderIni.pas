{**
@Abstract(Класс чтения параметров из INI файла)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.02.2007)
@LastMod(25.05.2012)
@Version(0.5)
}
unit AStorageReaderIni;

interface

uses
  IniFiles,
  AReaderIntf, AStorageIntf;

type
  //** @abstract(Класс чтения параметров из INI секции файла)
  TProfReaderIni = class(TInterfacedObject, IProfReader2)
  private
    FFile: TIniFile;
    FReaders: array of TProfReaderIni;
    FSection: WideString;
  protected
    function GetReaderByName(const Name: WideString): IProfReader2; safecall;
  public
    function ReadBool(const Name: WideString; var Value: WordBool): WordBool; safecall;
    function ReadBoolDef(const Name: WideString; DefValue: WordBool): WordBool; safecall;
    function ReadDateTime(const Name: WideString; var Value: TDateTime): WordBool; safecall;
    function ReadDateTimeDef(const Name: WideString; DefValue: TDateTime): TDateTime; safecall;
    function ReadFloat64(const Name: WideString; var Value: Double): WordBool; safecall;
    function ReadFloat64Def(const Name: WideString; DefValue: Double): Double; safecall;
    function ReadInt32(const Name: WideString; var Value: Integer): WordBool; safecall;
    function ReadInt32Def(const Name: WideString; DefValue: Integer): Integer; safecall;
    function ReadInt64(const Name: WideString; var Value: Int64): WordBool; safecall;
    function ReadInt64Def(const Name: WideString; DefValue: Int64): Int64; safecall;
    function ReadString(const Name: WideString; var Value: WideString): WordBool; safecall;
    function ReadStringDef(const Name: WideString; const DefValue: WideString): WideString; safecall;
  public
    property ReaderByName[const Name: WideString]: IProfReader2 read GetReaderByName;
    property Section: WideString read FSection write FSection;
  end;

type
  //** @abstract(Класс чтения параметров из INI файла)
  TProfStorageReaderIni = class(TProfReaderIni, IStorageReader)
  private
    FFileName: WideString;
  public
    procedure Close(); safecall;
    function Open(): WordBool; safecall;
  public
    constructor Create();
    procedure Free();
  public
    property FileName: WideString read FFileName write FFileName;
  end;

implementation

{ TProfReaderIni }

function TProfReaderIni.GetReaderByName(const Name: WideString): IProfReader2;
var
  i: Integer;
  tmpSection: WideString;
  tmpReader: TProfReaderIni;
begin
  Result := nil;
  tmpSection := FSection + '.' + Name;
  // Ищем необходимую ветку в массиве
  for i := 0 to High(FReaders) do
    if FReaders[i].Section = tmpSection then
    begin
      Result := FReaders[i];
      Exit;
    end;

  // Проверяем наличие секции в INI файле
  if FFile.SectionExists(tmpSection) then
  try
    // Создаем ветку для доступа к секции
    tmpReader := TProfReaderIni.Create();
    tmpReader.FFile := FFile;
    tmpReader.Section := tmpSection;
    i := Length(FReaders);
    SetLength(FReaders, i + 1);
    FReaders[i] := tmpReader;
    Result := tmpReader;
  except
  end;
end;

function TProfReaderIni.ReadBool(const Name: WideString; var Value: WordBool): WordBool;
begin
  Result := Assigned(FFile);
  if not(Result) then Exit;
  try
    Result := FFile.ValueExists(FSection, Name);
    if not(Result) then Exit;
    Value := FFile.ReadBool(FSection, Name, Value);
  except
    Result := False;
  end;
end;

function TProfReaderIni.ReadBoolDef(const Name: WideString; DefValue: WordBool): WordBool;
begin
  Result := DefValue;
  ReadBool(Name, Result);
end;

function TProfReaderIni.ReadDateTime(const Name: WideString; var Value: TDateTime): WordBool;
var
  tmp: Double;
begin
  tmp := Value;
  Result := ReadFloat64(Name, tmp);
  Value := tmp;
end;

function TProfReaderIni.ReadDateTimeDef(const Name: WideString; DefValue: TDateTime): TDateTime;
begin
  Result := DefValue;
  ReadDateTime(Name, Result);
end;

function TProfReaderIni.ReadFloat64(const Name: WideString; var Value: Double): WordBool;
begin
  Result := Assigned(FFile);
  if not(Result) then Exit;
  try
    Result := FFile.ValueExists(FSection, Name);
    if not(Result) then Exit;
    Value := FFile.ReadFloat(FSection, Name, Value);
  except
    Result := False;
  end;
end;

function TProfReaderIni.ReadFloat64Def(const Name: WideString; DefValue: Double): Double;
begin
  Result := DefValue;
  ReadFloat64(Name, Result);
end;

function TProfReaderIni.ReadInt32(const Name: WideString; var Value: Integer): WordBool;
begin
  Result := Assigned(FFile);
  if not(Result) then Exit;
  try
    Result := FFile.ValueExists(FSection, Name);
    if not(Result) then Exit;
    Value := FFile.ReadInteger(FSection, Name, Value);
  except
    Result := False;
  end;
end;

function TProfReaderIni.ReadInt32Def(const Name: WideString; DefValue: Integer): Integer;
begin
  Result := DefValue;
  ReadInt32(Name, Result);
end;

function TProfReaderIni.ReadInt64(const Name: WideString; var Value: Int64): WordBool;
begin
  Result := Assigned(FFile);
  if not(Result) then Exit;
  try
    Result := FFile.ValueExists(FSection, Name);
    if not(Result) then Exit;
    Value := FFile.ReadInteger(FSection, Name, Value);
  except
    Result := False;
  end;
end;

function TProfReaderIni.ReadInt64Def(const Name: WideString; DefValue: Int64): Int64;
begin
  Result := DefValue;
  ReadInt64(Name, Result);
end;

function TProfReaderIni.ReadString(const Name: WideString; var Value: WideString): WordBool;
begin
  Result := Assigned(FFile);
  if not(Result) then Exit;
  try
    Result := FFile.ValueExists(FSection, Name);
    if not(Result) then Exit;
    Value := FFile.ReadString(FSection, Name, Value);
  except
    Result := False;
  end;
end;

function TProfReaderIni.ReadStringDef(const Name, DefValue: WideString): WideString;
begin
  Result := DefValue;
  ReadString(Name, Result);
end;

{ TProfStorageReaderIni }

procedure TProfStorageReaderIni.Close();
begin
  if Assigned(FFile) then
  try
    FFile.Free();
    FFile := nil;
  except
  end;
end;

constructor TProfStorageReaderIni.Create();
begin
  inherited Create();
  FSection := 'Section1';
  FFile := nil;
end;

procedure TProfStorageReaderIni.Free();
begin
end;

function TProfStorageReaderIni.Open(): WordBool;
begin
  Result := Assigned(FFile);
  if not(Result) then
  try
    FFile := TIniFile.Create(FFileName);
    Result := True;
  except
    FFile := nil;
  end;
end;

end.
