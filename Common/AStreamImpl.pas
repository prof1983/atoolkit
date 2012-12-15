{**
@Abstract Базовый класс потока ввода/вывода
@Author Prof1983 <prof1983@ya.ru>
@Created 18.04.2004
@LastMod 15.12.2012
}
unit AStreamImpl;

interface

uses
  Classes, SysUtils,
  AIoTypes, AStreamIntf, ATypes;

type //** Поток
  TProfStream = class(TStreamAdapter, IProfStream)
  private
    FOpened: Boolean;
    FStream: TStream;
  public
    function Clear(): TError; virtual;
    function Close(): TError; virtual;
    constructor Create(AStream: TStream);
    function GetSize(): UInt64; virtual;
    function LoadFromFileN(FileName: String): TError; virtual;
    procedure Open();
    function ReadArray(var Value: TArrayByte; Count: UInt32): TError; virtual;
    function ReadBuf(var Buf; Size: UInt32): TError;
    function ReadInt08(var Value: Int08): TError; virtual;
    function ReadInt16(var Value: Int16): TError; virtual;
    function ReadInt32(var Value: Int32): TError; virtual;
    function ReadInt64(var Value: Int64): TError; virtual;
    function ReadUInt08(var Value: UInt08): TError; virtual;
    function ReadUInt16(var Value: UInt16): TError; virtual;
    function ReadUInt32(var Value: UInt32): TError; virtual;
    function ReadUInt64(var Value: UInt64): TError; virtual;
    //function SaveToFile(F: TProfFile): Boolean; virtual;
    function Seek(Offset: Int64; Mode: TStreamSeekMode): TError; virtual;
    function WriteArray(A: TArrayByte; Count: UInt64): UInt64; virtual;
    function WriteInt08(Value: Int08): TError; virtual;
    function WriteInt16(Value: Int16): TError; virtual;
    function WriteInt32(Value: Int32): TError; virtual;
    function WriteInt64(Value: Int64): TError; virtual;
    function WriteUInt08(Value: UInt08): TError; virtual;
    function WriteUInt16(Value: UInt16): TError; virtual;
    function WriteUInt32(Value: UInt32): TError; virtual;
    function WriteUInt64(Value: UInt64): TError; virtual;
    function ReadInteger(var Value: Integer): WordBool; virtual;
    function WriteInteger(Value: Integer): WordBool;
  end;

type //** Файл
  TProfFile = class
  protected
    FFileName: String;
    FStream: TProfStream;
  public
    function Close(): TError;
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

  // Use AStreamObj.pas
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

// Functions -------------------------------------------------------------------

function ProfStreamMemory_LoadFromFileN(const FileName: string): TError;

implementation

{ Public }

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

{ TProfFileText }

function TProfFileText.Append(FileName: String): TError;
begin
  {$I-}
  AssignFile(F, FileName);
  System.Append(F);
  Result := 0;
  if (IOResult = 0) then Exit;
  Reset(F);
  Result := 0;
  if (IOResult = 0) then Exit;
  Rewrite(F);
  if (IOResult = 0) then
    Result := 0
  else
    Result := -1;
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

// TProfStream -----------------------------------------------------------------

function TProfStream.Clear(): TError;
begin
  Result := -1;
end;

function TProfStream.Close: TError;
begin
  Result := 0;
  FOpened := False;
end;

constructor TProfStream.Create(AStream: TStream);
begin
  inherited Create(AStream);
  FStream := AStream;
  FOpened := False;
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

function TProfStream.ReadBuf(var Buf; Size: UInt32): TError;
begin
  if (FStream.Read(Buf, Size) = Size) then
    Result := 0
  else
    Result := -1;
end;

function TProfStream.ReadInt08(var Value: Int08): TError;
begin
  if (FStream.Read(Value, SizeOf(Value)) = SizeOf(Value)) then
    Result := 0
  else
    Result := -1;
end;

function TProfStream.ReadInt16(var Value: Int16): TError;
begin
  if (FStream.Read(Value, SizeOf(Value)) = SizeOf(Value)) then
    Result := 0
  else
    Result := -1;
end;

function TProfStream.ReadInt32(var Value: Int32): TError;
begin
  if (FStream.Read(Value, SizeOf(Value)) = SizeOf(Value)) then
    Result := 0
  else
    Result := -1;
end;

function TProfStream.ReadInt64(var Value: Int64): TError;
begin
  if (FStream.Read(Value, SizeOf(Value)) = SizeOf(Value)) then
    Result := 0
  else
    Result := -1;
end;

function TProfStream.ReadInteger(var Value: Integer): WordBool;
begin
  Result := Self.ReadInt32(Value);
end;

function TProfStream.ReadUInt08(var Value: UInt08): TError;
begin
  if (FStream.Read(Value, SizeOf(Value)) = SizeOf(Value)) then
    Result := 0
  else
    Result := -1;
end;

function TProfStream.ReadUInt16(var Value: UInt16): TError;
begin
  if (FStream.Read(Value, SizeOf(Value)) = SizeOf(Value)) then
    Result := 0
  else
    Result := -1;
end;

function TProfStream.ReadUInt32(var Value: UInt32): TError;
begin
  if (FStream.Read(Value, SizeOf(Value)) = SizeOf(Value)) then
    Result := 0
  else
    Result := -1;
end;

function TProfStream.ReadUInt64(var Value: UInt64): TError;
begin
  if (FStream.Read(Value, SizeOf(Value)) = SizeOf(Value)) then
    Result := 0
  else
    Result := -1;
end;

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
  FStream.Seek(Offset, Word(Mode));
  Result := 0;
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

end.
