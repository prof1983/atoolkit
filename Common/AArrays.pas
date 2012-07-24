{**
@Abstract AArrays
@Author Prof1983 <prof1983@ya.ru>
@Created 15.09.2011
@LastMod 24.07.2012
}
unit AArrays;

interface

uses
  ABase, ABaseTypes;

function Array_AddFloat32(var Arr: AArray_Type; Value: AFloat32): AInteger;

function Array_AddInt(var Arr: AArray_Type; Value: AInteger): AInteger;

function Array_AddPointer(var Arr: AArray_Type; Rec: Pointer): AInteger;

procedure Array_Clear(var Arr: AArray_Type);

// Analog: free() <stdlib.h>
procedure Array_Free(var Arr: AArray_Type);

function Array_GetPointer(var Arr: AArray_Type; Index: AInteger): Pointer;

// Analog: realloc() <stdlib.h>
function Array_Reallocate(var Arr: AArray_Type; NewSize: AInteger): AInteger;

{ IntArray }

function IntArray_Add(var IntArray: TIntArray; Value: AInteger): AInteger;
function IntArray_Add1(var IntArray: TIntArray; Value: AInteger): AInteger;
procedure IntArray_Clear(var IntArray: TIntArray);
procedure IntArray_Copy(var Dest: TIntArray; const Source: TIntArray);
function IntArray_Find(const IntArray: TIntArray; Value: AInteger): AInteger;

implementation

{ Array }

function Array_AddFloat32(var Arr: AArray_Type; Value: AFloat32): AInteger;
var
  NewSize: AInteger;
begin
  if (Arr.AllocateLen <= Arr.Len) then
  begin
    // New allocated size OldAllocateLen+64; 64 = 16*4
    NewSize := Arr.AllocateLen + 64;
    if (Array_Reallocate(Arr, NewSize) <> NewSize) then
    begin
      Result := -1;
      Exit;
    end;
  end;
  AFloat32(Pointer(Integer(Arr.Data) + (Arr.Len)*4)^) := Value;
  Arr.Len := Arr.Len + 1;
  Result := Arr.Len - 1;
end;

function Array_AddInt(var Arr: AArray_Type; Value: AInteger): AInteger;
var
  NewSize: AInteger;
begin
  if (Arr.AllocateLen < Arr.Len) then
  begin
    // New allocated size OldAllocateLen+64; 64 = 16*4
    NewSize := Arr.AllocateLen + 64;
    if (Array_Reallocate(Arr, NewSize) <> NewSize) then
    begin
      Result := -1;
      Exit;
    end;
  end;
  Integer(Pointer(Integer(Arr.Data) + (Arr.Len)*SizeOf(AInteger))^) := Value;
  Arr.Len := Arr.Len + 1;
  Result := Arr.Len - 1;
end;

function Array_AddPointer(var Arr: AArray_Type; Rec: Pointer): AInteger;
var
  NewSize: AInteger;
begin
  if (Arr.AllocateLen <= Arr.Len) then
  begin
    // New allocated size OldAllocateLen+64; 64 = 16*4
    NewSize := Arr.AllocateLen + 64;
    if (Array_Reallocate(Arr, NewSize) <> NewSize) then
    begin
      Result := -1;
      Exit;
    end;
  end;
  Integer(Pointer(Integer(Arr.Data) + (Arr.Len)*SizeOf(Pointer))^) := Integer(Rec);
  Arr.Len := Arr.Len + 1;
  Result := Arr.Len - 1;
end;

{procedure Array_Clear(Arr: AArray);
begin
  if not(Assigned(Arr)) then
    Exit;
  Arr^.Len := 0;
end;}
procedure Array_Clear(var Arr: AArray_Type);
begin
  Arr.Len := 0;
end;

procedure Array_Free(var Arr: AArray_Type);
begin
  FreeMem(Arr.Data, Arr.AllocateLen);
  Arr.AllocateLen := 0;
  Arr.Len := 0;
end;

function Array_GetPointer(var Arr: AArray_Type; Index: AInteger): Pointer;
begin
  if (Index >= 0) and (Index < Arr.Len) then
    Result := Pointer(Pointer(Integer(Arr.Data) + Index*SizeOf(Pointer))^)
  else
    Result := nil;
end;

{function Array_Reallocate(Arr: AArray; NewSize: AInteger): AInteger;
begin
  if not(Assigned(Arr)) then
  begin
    Result := 0;
    Exit;
  end;
  Result := _Reallocate(Arr^, NewSize);
end;}
function Array_Reallocate(var Arr: AArray_Type; NewSize: AInteger): AInteger;
var
  P: Pointer;
  MoveSize: AInteger;
begin
  try
    GetMem(P, NewSize);
    if (Arr.AllocateLen > NewSize) then
      MoveSize := NewSize
    else
      MoveSize := Arr.AllocateLen;
    Move(Arr.Data, P, MoveSize);
    Arr.Data := P;
    Arr.AllocateLen := NewSize;
    Result := NewSize;
  except
    Result := 0;
  end;
end;

{ IntArray }

function IntArray_Add(var IntArray: TIntArray; Value: AInteger): AInteger;
begin
  Result := Length(IntArray);
  SetLength(IntArray, Result + 1);
  IntArray[Result] := Value;
end;

function IntArray_Add1(var IntArray: TIntArray; Value: AInteger): AInteger;
begin
  Result := IntArray_Find(IntArray, Value);
  if (Result < 0) then
    Result := IntArray_Add(IntArray, Value);
end;

procedure IntArray_Clear(var IntArray: TIntArray);
begin
  SetLength(IntArray, 0);
end;

procedure IntArray_Copy(var Dest: TIntArray; const Source: TIntArray);
var
  I: Integer;
begin
  SetLength(Dest, Length(Source));
  for I := 0 to High(Source) do
    Dest[I] := Source[i];
end;

function IntArray_Find(const IntArray: TIntArray; Value: AInteger): AInteger;
var
  I: Integer;
begin
  for I := 0 to High(IntArray) do
  begin
    if (IntArray[I] = Value) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

end.
