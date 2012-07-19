{
Author:  Prof1983 prof1983@yandex.ru
Created: 21.11.2008
LastMod: 14.09.2011
Version: 0.3.2

0.3.2
[+] Stream_ReadLineA() (14.09.2011)
}
unit AStreams;

interface

uses
  Classes, ABase;

type
  AStream = type AInteger;

{ Mode:
    fmCreate         = $FFFF; (Classes)
    fmOpenRead       = $0000; (SysUtils)
    fmOpenWrite      = $0001; (SysUtils)
    fmOpenReadWrite  = $0002; (SysUtils) }
function Stream_CreateFileStream(const FileName: string; Mode: Word): AStream;
function Stream_ReadBytes(Stream: AStream; Bytes: PChar; Count: Integer): Integer;
function Stream_ReadColor(Stream: AStream; out Value: AColor): ABoolean;
function Stream_ReadFloat(Stream: AStream; out Value: AFloat): ABoolean;
function Stream_ReadInteger(Stream: AStream; out Value: AInteger): ABoolean;
function Stream_ReadLineA(Stream: AStream; out Value: AnsiString): AInteger;
function Stream_ReadStringA(Stream: AStream; out Value: AnsiString): ABoolean;
function Stream_WriteBytes(Stream: AStream; Bytes: PChar; Count: Integer): Integer;
function Stream_WriteInteger(Stream: AStream; Value: AInteger): ABoolean;
function Stream_WriteFloat(Stream: AStream; Value: AFloat): ABoolean;
function Stream_WriteStringA(Stream: AStream; const Value: AnsiString): ABoolean;

function Stream_Read(Stream: AStream; var Buf; Count: Integer): Integer;

procedure Stream_Free(Stream: AStream);

implementation

{ Public }

function Stream_CreateFileStream(const FileName: string; Mode: Word): AStream;
begin
  Result := AStream(TFileStream.Create(FileName, Mode));
end;

procedure Stream_Free(Stream: AStream);
begin
  TStream(Stream).Free();
end;

function Stream_Read(Stream: AStream; var Buf; Count: Integer): Integer;
begin
  Result := TStream(Stream).Read(Buf, Count);
end;

function Stream_ReadBytes(Stream: AStream; Bytes: PChar; Count: Integer): Integer;
begin
  Result := TStream(Stream).Read(Bytes^, Count);
end;

function Stream_ReadColor(Stream: AStream; out Value: AColor): ABoolean;
begin
  Result := (TStream(Stream).Read(Value, SizeOf(AColor)) = SizeOf(AColor));
end;

function Stream_ReadFloat(Stream: AStream; out Value: AFloat): ABoolean;
begin
  Result := (TStream(Stream).Read(Value, SizeOf(Double)) = SizeOf(Double));
end;

function Stream_ReadInteger(Stream: AStream; out Value: AInteger): ABoolean;
begin
  Result := (TStream(Stream).Read(Value, SizeOf(Integer)) = SizeOf(Integer));
end;

function Stream_ReadLineA(Stream: AStream; out Value: AnsiString): AInteger;
var
  Buf: AnsiChar;
  IsEndLine: Boolean;
  Count: Integer;
begin
  IsEndLine := False;
  Count := 0;
  SetLength(Value, 1024);
  repeat
    // Читаем очередной символ
    if (TStream(Stream).Read(Buf, 1) <> 1) then
      Break;
    // Если конец строки в формате #0, то выходим
    if (Buf = #0) then
      Break;
    // Если конец строки в формате #10, то выходим
    if (Buf = #10) then
      Break;
    // Если конец строки в формате #13#10
    if (Buf = #13) then
    begin
      // Читаем следующий символ. Должен быть #10.
      if (TStream(Stream).Read(Buf, 1) <> 1) then
        Break;
      // Если символ не #10, то возврашаем указатель на предыдущий символ
      if (Buf <> #10) then
        TStream(Stream).Seek(-1, soCurrent);
      Break;
    end;
    // --- Добавляем символ ---
    Inc(Count);
    // Увеличиваем длину строки, если требуется
    if (Length(Value) < Count) then
      SetLength(Value, Length(Value)+1024);
    // Записываем очередной символ
    Value[Count] := Buf;
  until IsEndLine;
  SetLength(Value, Count);
  Result := Count;
end;

function Stream_ReadStringA(Stream: AStream; out Value: AnsiString): ABoolean;
var
  Count: Integer;
  P: PAnsiChar;
  S: string;
begin
  Result := Stream_ReadInteger(Stream, Count);
  if Result then
  begin
    GetMem(P, Count+1);
    Result := (Stream_ReadBytes(Stream, P, Count) = Count);
    if Result then
    begin
      S := P;
      Value := S;
    end;
    FreeMem(P);
  end;
end;

function Stream_WriteBytes(Stream: AStream; Bytes: PChar; Count: Integer): Integer;
begin
  Result := TStream(Stream).Write(Bytes^, Count);
end;

function Stream_WriteFloat(Stream: AStream; Value: AFloat): ABoolean;
begin
  Result := (TStream(Stream).Write(Value, SizeOf(Double)) = SizeOf(Double));
end;

function Stream_WriteInteger(Stream: AStream; Value: AInteger): ABoolean;
begin
  Result := (TStream(Stream).Write(Value, SizeOf(Integer)) = SizeOf(Integer));
end;

function Stream_WriteStringA(Stream: AStream; const Value: AnsiString): ABoolean;
var
  S: AnsiString;
begin
  Stream_WriteInteger(Stream, Length(Value));
  S := Value;
  Result := (Stream_WriteBytes(Stream, PChar(S), Length(S)) = Length(S))
end;

end.
 