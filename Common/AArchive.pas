{**
@Abstract(Простой способ сжатия повторяющихся символов)
@Author(Prof1983 prof1983@ya.ru)
@Created(27.01.2004)
@LastMod(26.04.2012)
@Version(0.5)

Если символы не повторяются, то размер увеличивается вдвое.
}
unit AArchive;

interface

uses
  Classes, SysUtils;

type
  TArhiv = class;
  TBase = class;
  TTable = class;

  TMode = (amArhiv, amDesArhiv); // Архивирование / Разархивирование
  TProcedure = procedure of object;
  TString = array of Byte;

  {TArhiv}

  TArhiv = class(TThread)
  private
    FCaption: WideString;
    FFileNameIn: WideString;
    FFileNameOut: WideString;
    FMaxSizeModule: Integer;
    FMode: TMode;
    FOnUpdate: TProcedure;
    FRuned: Boolean;
    FSizeModule: Integer;
    procedure SetFileNameIn(Value: WideString);
    procedure SetFileNameOut(Value: WideString);
    procedure SetMode(Value: TMode);
    procedure SetRuned(Value: Boolean);
    procedure SetSizeModule(Value: Integer);
    procedure UpdateCaption();
  protected
    procedure Execute(); override;
  public
    property Caption: WideString read FCaption;
    constructor Create;
    property FileNameIn: WideString read FFileNameIn write SetFileNameIn;
    property FileNameOut: WideString read FFileNameOut write SetFileNameOut;
    property MaxSizeModule: Integer read FMaxSizeModule write FMaxSizeModule;
    property Mode: TMode read FMode write SetMode;
    property OnUpdate: TProcedure read FOnUpdate write FOnUpdate;
    procedure Run();
    property Runed: Boolean read FRuned write SetRuned;
    property SizeModule: Integer read FSizeModule write SetSizeModule;
  end;

  {TBase}

  TBase = class
  public
    function ArhiveBlock(SizeBlock: Integer; var Buf: array of Byte): Integer;
    procedure DesArhivBlock(IndexString: Integer; var Buf: array of Byte);
  end;

  {TTable}

  TTable = class
  public
    Strings: array of TString;
    constructor Create(LengthString: Integer);
    procedure CreateData();
    procedure GetEndElements(var Buf: array of Byte);
    function Search(var Buf: array of Byte): Integer;
    procedure ShiftRight();
    procedure Sorting();
    procedure WriteToFile(FileName: String);
  end;

implementation

// TArhiv ----------------------------------------------------------------------
// -----------------------------------------------------------------------------
constructor TArhiv.Create();
begin
  inherited Create(True);
  FMaxSizeModule := 1024;
  FMode := amArhiv;
  FRuned := False;
  FSizeModule := 1024;
end;

// -----------------------------------------------------------------------------
procedure TArhiv.Execute();
var
  B: Byte;
  B2: Byte;
  Base: TBase;
  Buf: array of Byte;
  CountModules: Integer;
  I: Integer;
  I2: Integer;
  IndexString: Integer;
  IndexModule: Integer;
  FIn: TFileStream;
  FOut: TFileStream;

  procedure Update(Str: String);
  begin
    FCaption := Str;
    {Synchronize(}UpdateCaption{)};
  end;

begin
  Base := TBase.Create;
  //Open Files
  FIn := TFileStream.Create(FFileNameIn, fmOpenRead);
  FOut := TFileStream.Create(FFileNameOut, fmCreate);

  if FIn.Size > FMaxSizeModule then
  begin
    Update('FIn.Size > FMaxSizeModule');
    Exit;
  end;

  IndexModule := 0;
  case FMode of
    amArhiv: begin
      Update('Архивирование...');
      //Выбор размера блока (модуля)
      I := FIn.Size;
      if I < FSizeModule then FSizeModule := I;
      {CountModules := I div FSizeModule;
      if I mod FSizeModule <> 0 then Inc(CountModules);
      FOut.Write(CountModules, SizeOf(CountModules));
      FOut.Write(FSizeModule, SizeOf(FSizeModule));}
      //Построение таблицы
      SetLength(Buf, FSizeModule);
      {repeat}
        {Inc(IndexModule);}
        FIn.Read(Buf[0], FSizeModule);
        IndexString := Base.ArhiveBlock(FSizeModule, Buf);
        {Update(IntToStr(IndexModule * 100 div CountModules) + '%');}
        FOut.Write(IndexString, SizeOf(IndexString));
        //Запись
        I := 0;
        repeat
          B := Buf[I];
          B2 := 0;
          repeat
            if B2 = 255 then
            begin
              B2 := 0;
              FOut.Write(B2, SizeOf(B2));
            end;
            Inc(B2);
            Inc(I);
          until (I >= Length(Buf)) or (Buf[I] <> B);
          FOut.Write(B2, SizeOf(B2));
          FOut.Write(B, SizeOf(B));
        until I >= Length(Buf);
      {until FIn.Position >= FIn.Size;}
      Update('Архивирование закончено');
    end;
    amDesArhiv: begin
      Update('Разархивирование...');
      //Чтение
      {FIn.Read(CountModules, SizeOf(CountModules));}
      {}
      {if CountModules > 1 then
      begin
        Update('CountModules > 1');
        Exit;
      end;}
      {}
      {FIn.Read(FSizeModule, SizeOf(FSizeModule));}
      {repeat}
        {Inc(IndexModule);}
        //Чтение
        FIn.Read(IndexString, SizeOf(IndexString));
        SetLength(Buf, 0);
        repeat
          I2 := Length(Buf);
          repeat
            FIn.Read(B, SizeOf(B));
            if B = 0 then
              SetLength(Buf, Length(Buf) + 256)
            else
              SetLength(Buf, Length(Buf) + B);
          until B <> 0;
          FIn.Read(B2, SizeOf(B2));
          for I := I2 to Length(Buf) - 1 do Buf[I] := B2;
        until (FIn.Position >= FIn.Size) or (Length(Buf) >= FSizeModule);
        {Update('1');}
        Base.DesArhivBlock(IndexString, Buf);
        {Update(IntToStr(IndexModule * 100 div CountModules) + '%');}
        //Запись
        FOut.Write(Buf[0], Length(Buf));
      {until IndexModule >= CountModules;}
      Update('Разархивирование закончено');
    end;
  end;
  //Close Files
  FIn.Destroy();
  FOut.Destroy();
  Base.Destroy();
  FRuned := False;
end;

// -----------------------------------------------------------------------------
procedure TArhiv.Run();
begin
  SetRuned(True);
end;

// -----------------------------------------------------------------------------
procedure TArhiv.SetFileNameIn(Value: WideString);
begin
  if FRuned = False then FFileNameIn := Value;
end;

// -----------------------------------------------------------------------------
procedure TArhiv.SetFileNameOut(Value: WideString);
begin
  if FRuned = False then FFileNameOut := Value;
end;

// -----------------------------------------------------------------------------
procedure TArhiv.SetMode(Value: TMode);
begin
  if Runed = False then FMode := Value;
end;

// -----------------------------------------------------------------------------
procedure TArhiv.SetRuned(Value: Boolean);
begin
  if FRuned <> Value then
  begin
    FRuned := Value;
    {Suspended := not(FRuned);} Execute;
  end;
end;

// -----------------------------------------------------------------------------
procedure TArhiv.SetSizeModule(Value: Integer);
begin
  if (FRuned = False) and (Value < FMaxSizeModule) then
    FSizeModule := Value
  else
    FSizeModule := FMaxSizeModule;
end;

// -----------------------------------------------------------------------------
procedure TArhiv.UpdateCaption();
begin
  if Assigned(FOnUpdate) then FOnUpdate;
end;

{TBase}

function TBase.ArhiveBlock(SizeBlock: Integer; var Buf: array of Byte): Integer;
var
  Table: TTable;
  I: Integer;
begin
  Table := TTable.Create(Length(Buf));
  with Table do
  begin
    for I := 0 to Length(Buf) - 1 do Strings[0, I] := Buf[I];
    CreateData;
    {WriteToFile('A1.txt');}
    Sorting;
    {WriteToFile('A2.txt');}
    Result := Search(Buf);
    GetEndElements(Buf);
  end;
  Table.Destroy;
end;

procedure TBase.DesArhivBlock(IndexString: Integer; var Buf: array of Byte);
var
  I: Integer;
  I2: Integer;
  LengthString: Integer;
  Table: TTable;
begin
  LengthString := Length(Buf);
  Table := TTable.Create(LengthString);
  with Table do
  begin
    //Заполнение таблици
    for I2 := 0 to LengthString - 2 do
    begin
      ShiftRight;
      for I := 0 to LengthString - 1 do
        Strings[I, 0] := Buf[I];
      Sorting;
    end;
    {WriteToFile('D1.txt');}
    for I := 0 to LengthString - 2 do
      Buf[I] := Strings[IndexString, I];
    {Buf[LengthString - 1] остается прежним}
  end;
  Table.Destroy;
end;

{TTable}

constructor TTable.Create(LengthString: Integer);
var
  I: Integer;
begin
  SetLength(Strings, LengthString);
  for I := 0 to LengthString - 1 do
    SetLength(Strings[I], LengthString);
end;

procedure TTable.CreateData;
var
  I: Integer;
  I2: Integer;
begin
  if Length(Strings) > 0 then
  begin
    for I := 1 to Length(Strings) - 1 do
    begin
      for I2 := 0 to I - 1 do
        Strings[I, I2] := Strings[0, Length(Strings) - I + I2];
      for I2 := I to Length(Strings) - 1 do
        Strings[I, I2] := Strings[0, I2 - I];
    end;
  end;
end;

procedure TTable.GetEndElements(var Buf: array of Byte);
var
  I: Integer;
begin
  for I := 0 to Length(Strings) - 1 do
    Buf[I] := Strings[I, Length(Strings) - 1];
end;

function TTable.Search(var Buf: array of Byte): Integer;
var
  I: Integer;
  I2: Integer;
label
  L1;
begin
  Result := -1;
  for I := 0 to Length(Strings) - 1 do
  begin
    for I2 := 0 to Length(Strings) - 1 do
      if Strings[I, I2] <> Buf[I2] then goto L1;
    Result := I;
    Exit;
L1:
  end;
end;

procedure TTable.ShiftRight;
var
  I: Integer;
  I2: Integer;
begin
  for I := 0 to Length(Strings) - 1 do
    for I2 := Length(Strings) - 2 downto 0 do
      Strings[I, I2 + 1] := Strings[I, I2];
end;

procedure TTable.Sorting;
var
  I: Integer;
  I2: Integer;
  I3: Integer;
  LengthString: Integer;
  TempString: TString;
label
  L1;
begin
  {Сортировка методом перестановки по возростанию}
  LengthString := Length(Strings);
  for I := 0 to LengthString do
  begin
    for I3 := 0 to LengthString - 2 do
    begin
      for I2 := 0 to LengthString - 1 do
      begin
        if Strings[I3, I2] > Strings[I3 + 1, I2] then
        begin
          TempString := Strings[I3];
          Strings[I3] := Strings[I3 + 1];
          Strings[I3 + 1] := TempString;
          goto L1;
        end
        else
        if Strings[I3, I2] < Strings[I3 + 1, I2] then goto L1;
      end;
      L1:
    end;
  end;
end;

procedure TTable.WriteToFile(FileName: String);
var
  B: Byte;
  I: Integer;
  I2: Integer;
  I3: Integer;
  F: TFileStream;
  S: String;
begin
  F := TFileStream.Create(FileName, fmCreate);
  for I := 0 to Length(Strings) - 1 do
  begin
    for I2 := 0 to Length(Strings) - 1 do
    begin
      S := IntToStr(Strings[I, I2]);
      for I3 := Length(S) to 4 do S := S + ' ';
      F.Write(S[1], 4)
    end;
    B := $0D;
    F.Write(B, SizeOf(B));
    B := $0A;
    F.Write(B, SizeOf(B));
  end;
  F.Destroy;
end;

end.

