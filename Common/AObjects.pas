{**
@Author Prof1983 <prof1983@ya.ru>
@Created 02.04.2013
@LastMod 02.04.2013
}
unit AObjects;

interface

uses
  ABase;

type
  AObject_Type = record
    ObjConst: AInt; // = 'AObj' = $414F626A
    Reserved1: AInt;
    Reserved2: AInt;
    Reserved3: AInt;
  end;

type
  PObject = ^AObject_Type;

// --- AObject ---

function AObject_Assigned(Obj: AObject): ABool;

function AObject_New(Size: AInt): AObject;

implementation

// --- AObject ---

function AObject_Assigned(Obj: AObject): ABool;
begin
  if (Obj = 0) then
  begin
    Result := False;
    Exit;
  end;
  Result := (PObject(Obj)^.ObjConst = AObjConst);
end;

function AObject_New(Size: AInt): AObject;
var
  P: Pointer;
begin
  GetMem(P, Size);
  FillChar(P, Size, 0);
  PObject(P)^.ObjConst := AObjConst;
  Result := AObject(P);
end;

end.
