{**
@Author Prof1983 <prof1983@ya.ru>
@Created 27.12.2012
@LastMod 25.02.2013
}
unit ADataModelMain;

interface

uses
  ABase,
  ADataBase;

// --- ADataModel ---

function ADataModel_SetReadOnly(DataModel: ADataModel; ReadOnly: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

// --- ADataModel ---

function ADataModel_SetReadOnly(DataModel: ADataModel; ReadOnly: ABoolean): AError;
begin
  // ...
  Result := -1;
end;

end.
 