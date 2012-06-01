{**
@Abstract(Класс записи параметров в INI файл)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.02.2007)
@LastMod(25.05.2012)
@Version(0.5)
}
unit AStorageWriterIni;

interface

uses
  IniFiles,
  AWriterIntf, AStorageIntf;

type
  //** @abstract(Класс записи параметров в INI секцию файла)
  TProfWriterIni = class(TInterfacedObject, IProfWriter2)
  private
    FFile: TIniFile;
    FSection: WideString;
    FWriters: array of TProfWriterIni;
  protected
    function GetWriterByName(const Name: WideString): IProfWriter2; safecall;
  public
    function WriteBool(const Name: WideString; Value: WordBool): WordBool; safecall;
    function WriteDateTime(const Name: WideString; Value: TDateTime): WordBool; safecall;
    function WriteFloat64(const Name: WideString; Value: Double): WordBool; safecall;
    function WriteInt32(const Name: WideString; Value: Integer): WordBool; safecall;
    function WriteInt64(const Name: WideString; Value: Int64): WordBool; safecall;
    function WriteString(const Name, Value: WideString): WordBool; safecall;
  public
    property Section: WideString read FSection write FSection;
  end;

  //** @abstract(Класс записи параметров в INI файл)
  TProfStorageWriterIni = class(TProfWriterIni, IStorageWriter)
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

{ TProfWriterIni }

function TProfWriterIni.GetWriterByName(const Name: WideString): IProfWriter2;
var
  i: Integer;
  tmpSection: WideString;
begin
  Result := nil;
  tmpSection := FSection + '.' + Name;
  // Поиск в массиве
  for i := 0 to High(FWriters) do
    if FWriters[i].Section = tmpSection then
    begin
      Result := FWriters[i];
      Exit;
    end;

  // Создание элемента
  try
    i := Length(FWriters);
    SetLength(FWriters, i + 1);
    FWriters[i] := TProfWriterIni.Create();
    FWriters[i].FFile := FFile;
    FWriters[i].Section := tmpSection;
    Result := FWriters[i];
  except
  end;
end;

function TProfWriterIni.WriteBool(const Name: WideString; Value: WordBool): WordBool;
begin
  Result := Assigned(FFile);
  if not(Result) then Exit;
  try
    FFile.WriteBool(FSection, Name, Value);
  except
    Result := False;
  end;
end;

function TProfWriterIni.WriteDateTime(const Name: WideString; Value: TDateTime): WordBool;
begin
  Result := Assigned(FFile);
  if not(Result) then Exit;
  try
    FFile.WriteDateTime(FSection, Name, Value);
  except
    Result := False;
  end;
end;

function TProfWriterIni.WriteFloat64(const Name: WideString; Value: Double): WordBool;
begin
  Result := Assigned(FFile);
  if not(Result) then Exit;
  try
    FFile.WriteFloat(FSection, Name, Value);
  except
    Result := False;
  end;
end;

function TProfWriterIni.WriteInt32(const Name: WideString; Value: Integer): WordBool;
begin
  Result := Assigned(FFile);
  if not(Result) then Exit;
  try
    FFile.WriteInteger(FSection, Name, Value);
  except
    Result := False;
  end;
end;

function TProfWriterIni.WriteInt64(const Name: WideString; Value: Int64): WordBool;
begin
  Result := Assigned(FFile);
  if not(Result) then Exit;
  try
    FFile.WriteInteger(FSection, Name, Value);
  except
    Result := False;
  end;
end;

function TProfWriterIni.WriteString(const Name, Value: WideString): WordBool;
begin
  Result := Assigned(FFile);
  if not(Result) then Exit;
  try
    FFile.WriteString(FSection, Name, Value);
  except
    Result := False;
  end;
end;

{ TProfStorageWriterIni }

procedure TProfStorageWriterIni.Close();
begin
  if Assigned(FFile) then
  try
    FFile.Free();
    FFile := nil;
  except
  end;
end;

constructor TProfStorageWriterIni.Create();
begin
  inherited Create();
  FSection := 'Section1';
  FFile := nil;
end;

procedure TProfStorageWriterIni.Free();
begin
end;

function TProfStorageWriterIni.Open(): WordBool;
begin
  Result := Assigned(FFile);
  if not(Result) then
  try
    FFile := TIniFile.Create(FFileName);
    Result := True;
  except
  end;
end;

end.
