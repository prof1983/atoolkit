{**
@Abstract(Базовый класс потока ввода/вывода)
@Author(Prof1983 prof1983@ya.ru)
@Created(18.04.2004)
@LastMod(19.06.2012)
@Version(0.5)
}
unit AStreamObj;

interface

uses
  Classes, SysUtils,
  ABase, AIoTypes, ATypes;

type //** Поток
  TProfStream = class
  private
    FOpened: Boolean;
  public
    function Clear(): TError; virtual;
    function Close(): TError; virtual;
    constructor Create();
    function GetPosition(): Integer;
    function GetSize(): UInt64; virtual;
    function LoadFromFileN(FileName: String): TError; virtual;
    procedure Open(); virtual;
    function ReadArray(var Value: TArrayByte; Count: UInt32): TError; virtual;
    function ReadBuf(var Buf; Size: AInt): AError; virtual;
    function ReadInt08(var Value: Int08): TError; virtual;
    function ReadInt16(var Value: Int16): TError; virtual;
    function ReadInt32(var Value: Int32): TError; virtual;
    function ReadInt64(var Value: Int64): TError; virtual;
    function ReadStr(var Value: string): TError; virtual;
    function ReadUInt08(var Value: UInt08): TError; virtual;
    function ReadUInt16(var Value: UInt16): TError; virtual;
    function ReadUInt32(var Value: UInt32): TError; virtual;
    function ReadUInt64(var Value: UInt64): TError; virtual;
    //function SaveToFile(F: TProfFile): Boolean; virtual; - Use AStream_SaveToFile()
    function Seek(Offset: Int64; Mode: TStreamSeekMode): TError; virtual;
    procedure SetPosition(Value: Integer);
    procedure SetSize(Value: UInt64);
    function WriteArray(A: TArrayByte; Count: UInt64): UInt64; virtual;
    function WriteInt08(Value: Int08): TError; virtual;
    function WriteInt16(Value: Int16): TError; virtual;
    function WriteInt32(Value: Int32): TError; virtual;
    function WriteInt64(Value: Int64): TError; virtual;
    function WriteStr(const Value: string): TError; virtual;
    function WriteUInt08(Value: UInt08): TError; virtual;
    function WriteUInt16(Value: UInt16): TError; virtual;
    function WriteUInt32(Value: UInt32): TError; virtual;
    function WriteUInt64(Value: UInt64): TError; virtual;
    function ReadInteger(var Value: Integer): WordBool; virtual;
    function WriteInteger(Value: Integer): WordBool;
  public
    property Position: Integer read GetPosition write SetPosition;
    property Size: UInt64 read GetSize write SetSize;
  end;

type //** Поток
  TProfStreamAdapter = class(TProfStream) //(TStreamAdapter, IProfStream)
  private
    FStream: TStream{TStreamAdapter};
    FOpened: Boolean;
  public
    function Clear(): AError; override;
    function Close(): AError; override;
    function GetSize(): UInt64; override;
    function LoadFromFileN(FileName: String): TError; override;
    procedure Open(); override;
    function ReadArray(var Value: TArrayByte; Count: UInt32): TError; override;
    function ReadBuf(var Buf; Size: AInt): AError; override;
    function ReadInt08(var Value: Int08): TError; override;
    function ReadInt16(var Value: Int16): TError; override;
    function ReadInt32(var Value: Int32): TError; override;
    function ReadInt64(var Value: Int64): TError; override;
    function ReadUInt08(var Value: UInt08): AError; override;
    function ReadUInt16(var Value: UInt16): TError; override;
    function ReadUInt32(var Value: UInt32): TError; override;
    function ReadUInt64(var Value: UInt64): TError; override;
    //function SaveToFile(F: TProfFile{TMyFile}): TError; override; - Use AStream_SaveToFile()
    function Seek(Offset: Int64; Mode: TStreamSeekMode): TError; override;
    function WriteArray(A: TArrayByte; Count: UInt64): UInt64; override;
    function WriteInt08(Value: Int08): TError; override;
    function WriteInt16(Value: Int16): TError; override;
    function WriteInt32(Value: Int32): TError; override;
    function WriteInt64(Value: Int64): TError; override;
    function WriteUInt08(Value: UInt08): TError; override;
    function WriteUInt16(Value: UInt16): TError; override;
    function WriteUInt32(Value: UInt32): TError; override;
    function WriteUInt64(Value: UInt64): TError; override;
    function ReadInteger(var Value: Integer): WordBool; override;
  public
    constructor Create(Stream: TStream);
  public
    property Stream: TStream read FStream;
  end;

type //** Файл
  TProfFile = class
  protected
    FFileName: String;
    FStream: TProfStream;
  public
    function Close(): AError;
    function FileDelete(FileName: String): Boolean;
    function FileExist(FileName: String): Boolean;
    property FileName: String read FFileName write FFileName;
    procedure Free();
    function GetStream(): TProfStream;
    //function Read(var A: TArrayByte; Count: UInt64): UInt64;
    function ReadFloat32(var Value: Float32): TError;
    function ReadFloat64(var Value: Float64): TError;
    function ReadInt08(var Value: Int08): TError;
    function ReadInt16(var Value: Int16): TError;
    function ReadInt32(var Value: Int32): TError;
    function ReadInt64(var Value: Int64): TError;
    function ReadUInt08(var Value: UInt08): TError;
    function ReadUInt16(var Value: UInt16): TError;
    function ReadUInt32(var Value: UInt32): TError;
    function ReadUInt64(var Value: UInt64): TError;
    function Open(FileName: String; Mode: TProfFileOpenMode): Boolean; virtual;
    function OpenCreate(FileName: String): TError;
    //function Write(A: TArrayByte; Count: UInt64): UInt64;
    function WriteFloat32(Value: Float32): TError;
    function WriteFloat64(Value: Float64): TError;
    function WriteInt08(Value: Int08): TError;
    function WriteInt16(Value: Int16): TError;
    function WriteInt32(Value: Int32): TError;
    function WriteInt64(Value: Int64): TError;
    function WriteUInt08(Value: UInt08): TError;
    function WriteUInt16(Value: UInt16): TError;
    function WriteUInt32(Value: UInt32): TError;
    function WriteUInt64(Value: UInt64): TError;
    function Seek(Offset: Int64; Origin: TStreamSeekMode = Prof_soBeginning): TError;
    function SetStream(Value: TProfStream): TError;
  end;

  //** Директория (Папка)
  TProfFileDir = class
  private
    FName: String;
  public
    function GetName(): String;
    function SetName(Value: String): TError;
  end;

  //** Текстовый файл
  TProfFileText = class
  private
    F: TextFile;
    FFileName: String;
  public
    function Append(FileName: String): TError;
    function Close(): TError;
    function Eof(): Boolean;
    procedure Free(); //override;
    function GetFileName(): String;
    function Open(FileName: String): TError;
    function OpenCreate(FileName: String): TError;
    function Read(var S: String): TError;
    function ReadLn(var S: String): TError;
    function Write(const S: String): TError;
    function WriteLn(const S: String): TError;
  end;

{type //** Поток-файл
  TProfStreamFile = TProfStream;}

type //** Поток-память
  TProfMemoryStream = class(TProfStream)
  private
    FBytes: array of UInt08;
  public
    function Clear: TError; override;
    function LoadFromFileN(FileName: String): TError; override;
  end;
  TProfStreamMemory = TProfMemoryStream;

// Functions -------------------------------------------------------------------

function AStream_SaveToFile(Stream: TProfStream; F: TProfFile): TError;

function AStream_Write(Stream: TProfStream; const Buffer; Count: Longint): Longint;


// Скопировать один файл
procedure CopyOneFile(const Src, Target: String);

function ProfStreamMemory_LoadFromFileN(const FileName: string): TError;

implementation

{ Public }

procedure CopyOneFile(const Src, Target: String);
var
  S: TFileStream;
  T: TFileStream;
begin
  S := TFileStream.Create(Src, SysUtils.fmOpenRead);
  try
    T := TFileStream.Create(Target, SysUtils.fmOpenWrite or Classes.fmCreate);
    try
      T.CopyFrom(S, S.Size)
    finally
      T.Free;
    end
  finally
    S.Free;
  end
end;

function ProfStreamMemory_LoadFromFileN(const FileName: string): TError;
var
  Count: UInt32;
  F: file;
  FBytes: array of UInt08;
begin
  AssignFile(F, FileName);
  {$I-}Reset(F, 1);{$I+}
  if (IOResult <> 0) then
  begin
    Result := -1;
    Exit;
  end;
  Count := 0;
  while not(Eof(F)) do
  begin
    Inc(Count);
    SetLength(FBytes, Count);
    BlockRead(F, FBytes[Count - 1], SizeOf(UInt08));
  end;
  CloseFile(F);
  Result := 0;
end;

{ AStream }

function AStream_Write(Stream: TProfStream; const Buffer; Count: Longint): Longint;
begin
  if (Stream is TProfStreamAdapter) then
    Result := TProfStreamAdapter(Stream).FStream.Write(Buffer, Count)
  else
    Result := -1;
end;

function AStream_SaveToFile(Stream: TProfStream; F: TProfFile): TError;
{const
  BufSize = 4096;
var
  Buf: TArrayByte;
  I: Int32;
  Size: Int32;}
begin
  {SetLength(Buf, BufSize);
  Size := GetSize;
  I := 0;
  repeat
    Inc(I);
    if I * BufSize > Size then
      SetLength(Buf, Size - (I - 1) * BufSize);
    Read(Buf, Length(Buf));
    F.Write(Buf, Length(Buf));
  until I * BufSize < Size;
  Result := True;}
  Result := -1;
end;

{ TProfFile }

function TProfFile.Close(): AError;
begin
  if not(Assigned(FStream)) then
  begin
    Result := -1;
    Exit;
  end;
  FStream.Free();
  FStream := nil;
  Result := 0;
end;

function TProfFile.FileDelete(FileName: String): Boolean;
begin
  Result := SysUtils.DeleteFile(FileName);
end;

function TProfFile.FileExist(FileName: String): Boolean;
begin
  Result := SysUtils.FileExists(FileName);
  {H := ioFileOpen(FileName, 0);
  if (H > 0) then begin
    ioFileClose(H);
    Result := True;
  end else Result := False;}
end;

procedure TProfFile.Free;
begin
  if Assigned(FStream) then FStream.Free;
  inherited Free;
end;

function TProfFile.GetStream: TProfStream;
begin
  Result := FStream;
end;

function TProfFile.Open(FileName: String; Mode: TProfFileOpenMode): Boolean;
var
  Stream: TFileStream;
begin
  Close;

  {if not(Assigned(FStream)) then
  begin
    Result := False;
    Exit;
  end;}

  if (FileName <> '') then
    FFileName := FileName;

  if (Mode = Prof_fmCreate) then
  begin
    Result := (OpenCreate(FileName) >= 0);
    Exit;
  end;

  case Mode of
    Prof_fmOpenRead: Stream := TFileStream.Create(FFileName, fmOpenRead);
    Prof_fmOpenWrite: Stream := TFileStream.Create(FFileName, SysUtils.fmOpenWrite);
    Prof_fmOpenReadWrite: Stream := TFileStream.Create(FFileName, SysUtils.fmOpenReadWrite);
  else
    if FileExist(FFileName) then
      Stream := TFileStream.Create(FFileName, SysUtils.fmOpenReadWrite)
    else
    begin
      Result := (OpenCreate(FileName) >= 0);
      Exit;
    end;
  end;

  FStream := TProfStreamAdapter.Create(Stream);
  Result := True;
end;

function TProfFile.OpenCreate(FileName: String): TError;
begin
  Result := 0;
  Close;
  if (FileName <> '') then
    FFileName := FileName;
  FStream := TProfStreamAdapter.Create(TFileStream.Create(FFileName, Classes.fmCreate));
end;

{function TProfFile.Read(var A: TArrayByte; Count: UInt64): UInt64;
begin
  if Assigned(FStream) then
    Result := FStream.Read(A, Count)
  else
    Result := 1;
end;}

function TProfFile.ReadFloat32(var Value: Float32): TError;
begin
  {if Assigned(FStream) then
    Result := FStream.ReadFloat32(Value)
  else}
    Result := -1;
end;

function TProfFile.ReadFloat64(var Value: Float64): TError;
begin
  {if Assigned(FStream) then
    Result := FStream.ReadFloat64(Value)
  else}
    Result := -1;
end;

function TProfFile.ReadInt08(var Value: Int08): TError;
begin
  if Assigned(FStream) then
    Result := FStream.ReadInt08(Value)
  else
    Result := -1;
end;

function TProfFile.ReadInt16(var Value: Int16): TError;
begin
  if Assigned(FStream) then
    Result := FStream.ReadInt16(Value)
  else
    Result := -1;
end;

function TProfFile.ReadInt32(var Value: Int32): TError;
begin
  if Assigned(FStream) then
    Result := FStream.ReadInt32(Value)
  else
    Result := -1;
end;

function TProfFile.ReadInt64(var Value: Int64): TError;
begin
  if Assigned(FStream) then
    Result := FStream.ReadInt64(Value)
  else
    Result := -1;
end;

function TProfFile.ReadUInt08(var Value: UInt08): TError;
begin
  if Assigned(FStream) then
    Result := FStream.ReadUInt08(Value)
  else
    Result := -1;
end;

function TProfFile.ReadUInt16(var Value: UInt16): TError;
begin
  if Assigned(FStream) then
    Result := FStream.ReadUInt16(Value)
  else
    Result := -1;
end;

function TProfFile.ReadUInt32(var Value: UInt32): TError;
begin
  if Assigned(FStream) then
    Result := FStream.ReadUInt32(Value)
  else
    Result := -1;
end;

function TProfFile.ReadUInt64(var Value: UInt64): TError;
begin
  if Assigned(FStream) then
    Result := FStream.ReadUInt64(Value)
  else
    Result := -1;
end;

function TProfFile.Seek(Offset: Int64; Origin: TStreamSeekMode = Prof_soBeginning): TError;
{(soBeginning, soCurrent, soEnd)}
begin
  Result := -1;
  if not(Assigned(FStream)) then Exit;
  FStream.Seek(Offset, Origin);
  Result := 0;
end;

function TProfFile.SetStream(Value: TProfStream): TError;
begin
  FStream := Value;
  Result := 0;
end;

{function TProfFile.Write(A: TArrayByte; Count: UInt64): UInt64;
begin
  if Assigned(FStream) then
    Result := FStream.Write(A, Count)
  else
    Result := False;
end;}

function TProfFile.WriteFloat32(Value: Float32): TError;
begin
  {if Assigned(FStream) then
    Result := FStream.WriteFloat32(A, Count)
  else}
    Result := -1;
end;

function TProfFile.WriteFloat64(Value: Float64): TError;
begin
  {if Assigned(FStream) then
    Result := FStream.WriteFloat64(Value)
  else}
    Result := -1;
end;

function TProfFile.WriteInt08(Value: Int08): TError;
begin
  if Assigned(FStream) then
    Result := FStream.WriteInt08(Value)
  else
    Result := -1;
end;

function TProfFile.WriteInt16(Value: Int16): TError;
begin
  if Assigned(FStream) then
    Result := FStream.WriteInt16(Value)
  else
    Result := -1;
end;

function TProfFile.WriteInt32(Value: Int32): TError;
begin
  if Assigned(FStream) then
    Result := FStream.WriteInt32(Value)
  else
    Result := -1;
end;

function TProfFile.WriteInt64(Value: Int64): TError;
begin
  if Assigned(FStream) then
    Result := FStream.WriteInt64(Value)
  else
    Result := -1;
end;

function TProfFile.WriteUInt08(Value: UInt08): TError;
begin
  if Assigned(FStream) then
    Result := FStream.WriteUInt08(Value)
  else
    Result := -1;
end;

function TProfFile.WriteUInt16(Value: UInt16): TError;
begin
  if Assigned(FStream) then
    Result := FStream.WriteUInt16(Value)
  else
    Result := -1;
end;

function TProfFile.WriteUInt32(Value: UInt32): TError;
begin
  if Assigned(FStream) then
    Result := FStream.WriteUInt32(Value)
  else
    Result := -1;
end;

function TProfFile.WriteUInt64(Value: UInt64): TError;
begin
  if Assigned(FStream) then
    Result := FStream.WriteUInt64(Value)
  else
    Result := -1;
end;

{ TProfFileDir }

function TProfFileDir.GetName: String;
begin
  Result := FName;
end;

function TProfFileDir.SetName(Value: String): TError;
begin
  FName := Value;
  Result := 0;
end;

{ TProfFileText }

function TProfFileText.Append(FileName: String): TError;
begin
  {$I-}
  AssignFile(F, FileName);
  System.Append(F);
  if (IOResult = 0) then
  begin
    Result := 0;
    Exit;
  end;
  Reset(F);
  if (IOResult = 0) then
  begin
    Result := 0;
    Exit;
  end;
  Rewrite(F);
  Result := IOResult();
  {$I+}
end;

function TProfFileText.Close: TError;
begin
  {$I-}CloseFile(F);{$I+}
  if (IOResult = 0) then
    Result := 0
  else
    Result := -1;
end;

function TProfFileText.Eof: Boolean;
begin
  {$I-}Result := System.Eof(F);{$I+}
  if IOResult <> 0 then Result := True;
end;

procedure TProfFileText.Free;
begin
  Close;
  inherited Free;
end;

function TProfFileText.GetFileName: String;
begin
  Result := FFileName;
end;

function TProfFileText.Open(FileName: String): TError;
begin
  AssignFile(F, FileName);
  {$I-}Reset(F);{$I+}
  if (IOResult = 0) then
    Result := 0
  else
    Result := -1;
  FFileName := FileName;
end;

function TProfFileText.OpenCreate(FileName: String): TError;
begin
  AssignFile(F, FileName);
  {$I-}Rewrite(F);{$I+}
  if (IOResult = 0) then
    Result := 0
  else
    Result := -1;
  FFileName := FileName;
end;

function TProfFileText.Read(var S: String): TError;
begin
  {$I-}System.Read(F, S);{$I+}
  if (IOResult = 0) then
    Result := 0
  else
    Result := -1;
end;

function TProfFileText.ReadLn(var S: String): TError;
begin
  {$I-}System.ReadLn(F, S);{$I+}
  if (IOResult = 0) then
    Result := 0
  else
    Result := -1;
end;

function TProfFileText.Write(const S: String): TError;
begin
  {$I-}System.Write(F, S);{$I+}
  if (IOResult = 0) then
    Result := 0
  else
    Result := -1;
end;

function TProfFileText.WriteLn(const S: String): TError;
begin
  {$I-}System.WriteLn(F, S);{$I+}
  if (IOResult = 0) then
    Result := 0
  else
    Result := -1;
end;

{ TProfStream }

function TProfStream.Clear(): TError;
begin
  Result := -1;
end;

function TProfStream.Close: TError;
begin
  Result := 0;
  FOpened := False;
end;

constructor TProfStream.Create();
begin
  inherited Create();
  FOpened := False;
end;

function TProfStream.GetPosition(): Integer;
begin
  Result := 0;
end;

function TProfStream.GetSize: UInt64;
begin
  Result := 0;
end;

function TProfStream.LoadFromFileN(FileName: String): TError;
begin
  Result := -1;
end;

procedure TProfStream.Open;
begin
  FOpened := True;
end;

function TProfStream.ReadArray(var Value: TArrayByte; Count: UInt32): TError;
begin
  Result := -1;
end;

function TProfStream.ReadBuf(var Buf; Size: AInt): AError;
begin
  Result := -1;
end;

function TProfStream.ReadInt08(var Value: Int08): TError;
begin
  Result := -1;
end;

function TProfStream.ReadInt16(var Value: Int16): TError;
begin
  Result := -1;
end;

function TProfStream.ReadInt32(var Value: Int32): TError;
begin
  Result := -1;
end;

function TProfStream.ReadInt64(var Value: Int64): TError;
begin
  Result := -1;
end;

function TProfStream.ReadInteger(var Value: Integer): WordBool;
begin
  Result := False;
end;

function TProfStream.ReadStr(var Value: string): TError;
begin
  Result := -1;
end;

function TProfStream.ReadUInt08(var Value: UInt08): TError;
begin
  Result := -1;
end;

function TProfStream.ReadUInt16(var Value: UInt16): TError;
begin
  Result := -1;
end;

function TProfStream.ReadUInt32(var Value: UInt32): TError;
begin
  Result := -1;
end;

function TProfStream.ReadUInt64(var Value: UInt64): TError;
begin
  Result := -1;
end;

// Use AStream_SaveToFile()
(*function TProfStream.SaveToFile(F: TProfFile): Boolean;
{const
  BufSize = 4096;
var
  Buf: TArrayByte;
  I: Int32;
  Size: Int32;}
begin
  {SetLength(Buf, BufSize);
  Size := GetSize;
  I := 0;
  repeat
    Inc(I);
    if I * BufSize > Size then
      SetLength(Buf, Size - (I - 1) * BufSize);
    Read(Buf, Length(Buf));
    F.Write(Buf, Length(Buf));
  until I * BufSize < Size;
  Result := True;}
  Result := False;
end;*)

function TProfStream.Seek(Offset: Int64; Mode: TStreamSeekMode): TError;
begin
  Result := -1;
end;

procedure TProfStream.SetPosition(Value: Integer);
begin
  Self.Seek(Value, Prof_soBeginning);
end;

procedure TProfStream.SetSize(Value: UInt64);
begin
end;

function TProfStream.WriteArray(A: TArrayByte; Count: UInt64): UInt64;
begin
  Result := 0;
end;

function TProfStream.WriteInt08(Value: Int08): TError;
begin
  Result := -1;
end;

function TProfStream.WriteInt16(Value: Int16): TError;
begin
  Result := -1;
end;

function TProfStream.WriteInt32(Value: Int32): TError;
begin
  Result := -1;
end;

function TProfStream.WriteInt64(Value: Int64): TError;
begin
  Result := -1;
end;

function TProfStream.WriteInteger(Value: Integer): WordBool;
begin
  Result := False;
end;

function TProfStream.WriteStr(const Value: string): TError;
begin
  Result := -1;
end;

function TProfStream.WriteUInt08(Value: UInt08): TError;
begin
  Result := -1;
end;

function TProfStream.WriteUInt16(Value: UInt16): TError;
begin
  Result := -1;
end;

function TProfStream.WriteUInt32(Value: UInt32): TError;
begin
  Result := -1;
end;

function TProfStream.WriteUInt64(Value: UInt64): TError;
begin
  Result := -1;
end;

{ TProfStreamAdapter }

function TProfStreamAdapter.Clear(): AError;
begin
  Result := -1;
end;

function TProfStreamAdapter.Close(): AError;
begin
  FStream.Free();
  FStream := nil;
  FOpened := False;
  Result := 0;
end;

constructor TProfStreamAdapter.Create(Stream: TStream);
begin
  inherited Create();
  Self.FStream := Stream;
  FOpened := False;
end;

function TProfStreamAdapter.GetSize(): UInt64;
begin
  Result := FStream.Size;
end;

function TProfStreamAdapter.LoadFromFileN(FileName: String): TError;
begin
  Result := -1;
end;

procedure TProfStreamAdapter.Open;
begin
  FOpened := True;
end;

function TProfStreamAdapter.ReadArray(var Value: TArrayByte; Count: UInt32): TError;
begin
  Result := -1;
end;

function TProfStreamAdapter.ReadBuf(var Buf; Size: AInt): AError;
begin
  if (FStream.Read(Buf, Size) = Size) then
    Result := 0
  else
    Result := -2;
end;

function TProfStreamAdapter.ReadInt08(var Value: Int08): TError;
begin
  if (FStream.Read(Value, SizeOf(Value)) = SizeOf(Value)) then
    Result := 0
  else
    Result := -1;
end;

function TProfStreamAdapter.ReadInt16(var Value: Int16): TError;
begin
  if (FStream.Read(Value, SizeOf(Value)) = SizeOf(Value)) then
    Result := 0
  else
    Result := -1;
end;

function TProfStreamAdapter.ReadInt32(var Value: Int32): TError;
begin
  if (FStream.Read(Value, SizeOf(Value)) = SizeOf(Value)) then
    Result := 0
  else
    Result := -1;
end;

function TProfStreamAdapter.ReadInt64(var Value: Int64): TError;
begin
  if (FStream.Read(Value, SizeOf(Value)) = SizeOf(Value)) then
    Result := 0
  else
    Result := -1;
end;

function TProfStreamAdapter.ReadInteger(var Value: Integer): WordBool;
begin
  Result := (FStream.Read(Value, SizeOf(Value)) = SizeOf(Value));
end;

function TProfStreamAdapter.ReadUInt08(var Value: UInt08): AError;
begin
  if (FStream.Read(Value, SizeOf(Value)) = SizeOf(Value)) then
    Result := 0
  else
    Result :=  -1;
end;

function TProfStreamAdapter.ReadUInt16(var Value: UInt16): TError;
begin
  if (FStream.Read(Value, SizeOf(Value)) = SizeOf(Value)) then
    Result := 0
  else
    Result := -1;
end;

function TProfStreamAdapter.ReadUInt32(var Value: UInt32): TError;
begin
  if (FStream.Read(Value, SizeOf(Value)) = SizeOf(Value)) then
    Result := 0
  else
    Result := -1;
end;

function TProfStreamAdapter.ReadUInt64(var Value: UInt64): TError;
begin
  if (FStream.Read(Value, SizeOf(Value)) = SizeOf(Value)) then
    Result := 0
  else
    Result := -1;
end;

function TProfStreamAdapter.Seek(Offset: Int64; Mode: TStreamSeekMode): TError;
begin
  if (FStream.Seek(Offset, Word(Mode)) = Offset) then
    Result := 0
  else
    Result := -1;
end;

function TProfStreamAdapter.WriteArray(A: TArrayByte; Count: UInt64): UInt64;
begin
  Result := 0;
end;

function TProfStreamAdapter.WriteInt08(Value: Int08): TError;
begin
  Result := -1;
end;

function TProfStreamAdapter.WriteInt16(Value: Int16): TError;
begin
  Result := -1;
end;

function TProfStreamAdapter.WriteInt32(Value: Int32): TError;
begin
  Result := -1;
end;

function TProfStreamAdapter.WriteInt64(Value: Int64): TError;
begin
  Result := -1;
end;

function TProfStreamAdapter.WriteUInt08(Value: UInt08): TError;
begin
  Result := -1;
end;

function TProfStreamAdapter.WriteUInt16(Value: UInt16): TError;
begin
  Result := -1;
end;

function TProfStreamAdapter.WriteUInt32(Value: UInt32): TError;
begin
  Result := -1;
end;

function TProfStreamAdapter.WriteUInt64(Value: UInt64): TError;
begin
  Result := -1;
end;

{ TProfStreamMemory }

function TProfMemoryStream.Clear(): TError;
begin
  SetLength(FBytes, 0);
  Result := 0;
end;

function TProfMemoryStream.LoadFromFileN(FileName: String): TError;
var
  Count: UInt32;
  F: file;
begin
  Result := -1;
  AssignFile(F, FileName);
  {$I-}Reset(F, 1);{$I+}
  if IOResult <> 0 then Exit;
  Count := 0;
  while not(Eof(F)) do
  begin
    Inc(Count);
    SetLength(FBytes, Count);
    BlockRead(F, FBytes[Count - 1], SizeOf(UInt08));
  end;
  CloseFile(F);
  Result := 0;
end;

end.
