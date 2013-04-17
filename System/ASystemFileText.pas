{**
@Abstract ASystem function
@Author Prof1983 <prof1983@ya.ru>
@Created 31.01.2013
@LastMod 31.01.2013
}
unit ASystemFileText;

interface

uses
  ABase;

// --- File ---

function ASystem_FileTextClose(FileId: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_FileTextEof(FileId: AInt): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_FileTextGetIndex(FileId: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_FileTextOpenP(const FileName: APascalString): AInt; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_FileTextReadLnAnsi(FileId: AInt; var Stroka: AnsiString): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

{ Private }

type
  TATextFile = record
    ID: Integer;
    F: TextFile;
  end;

var
  FTextFiles: array of TATextFile;

function _FileText_GetIndex(FileId: AInt): AInt;
var
  J: Integer;
begin
  for J := 0 to High(FTextFiles) do
  begin
    if (FTextFiles[J].ID = FileID) then
    begin
      Result := J;
      Exit;
    end;
  end;
  Result := -1;
end;

{ --- }

function ASystem_FileTextClose(FileId: AInt): AError;
var
  I: Integer;
begin
  try
    I := _FileText_GetIndex(FileID);
    if (I < 0) then
    begin
      Result := -2;
      Exit;
    end;
    {$I-}CloseFile(FTextFiles[I].F);{$I+}

    if (I < High(FTextFiles)) then
      FTextFiles[I] := FTextFiles[High(FTextFiles)];
    SetLength(FTextFiles, High(FTextFiles));

    Result := 0;
  except
    Result := -1;
  end;
end;

function ASystem_FileTextEof(FileId: AInt): ABool;
var
  I: Integer;
  Value: Boolean;
begin
  try
    I := _FileText_GetIndex(FileID);
    if (I < 0) then
    begin
      Result := True;
      Exit;
    end;

    {$I-}Value := Eof(FTextFiles[I].F);{$I+}
    if (IOResult() <> 0) then
    begin
      Result := True;
      Exit;
    end
    else
      Result := Value;
  except
    Result := True;
  end;
end;

function ASystem_FileTextGetIndex(FileId: AInt): AInt;
begin
  try
    Result := _FileText_GetIndex(FileID);
  except
    Result := -1;
  end;
end;

function ASystem_FileTextOpenP(const FileName: APascalString): AInt;
var
  I: Integer;
  J: Integer;
  Max: Integer;
begin
  I := Length(FTextFiles);
  SetLength(FTextFiles, I + 1);
  FTextFiles[I].ID := 0;
  try
    AssignFile(FTextFiles[I].F, FileName);
    {$I-}Reset(FTextFiles[I].F);{$I+}
    if (IOResult() <> 0) then
    begin
      {$I-}Reset(FTextFiles[I].F);{$I+}
      if (IOResult() <> 0) then
      begin
        Result := -2;
        Exit;
      end;
    end;

    Max := 0;
    for J := 0 to High(FTextFiles)-1 do
    begin
      if (FTextFiles[J].ID > Max) then
        Max := FTextFiles[J].ID;
    end;

    FTextFiles[I].ID := Max + 1;

    Result := Max + 1;
  except
    Result := -1;
  end;
end;

function ASystem_FileTextReadLnAnsi(FileId: AInt; var Stroka: AnsiString): AError;
var
  I: Integer;
begin
  try
    I := _FileText_GetIndex(FileID);
    if (I < 0) then
    begin
      Result := -2;
      Exit;
    end;
    {$I-}ReadLn(FTextFiles[I].F, Stroka);{$I+}
    if (IOResult() <> 0) then
    begin
      Result := -3;
      Exit;
    end;
    Result := 0;
  except
    Result := -1;
  end;
end;

end.
