{**
@Author Prof1983 <prof1983@ya.ru>
@Created 27.12.2012
@LastMod 27.12.2012
}
unit ADataModelMain;

interface

uses
  ABase,
  ADataBase;

function ADataModel_SetReadOnly(DataModel: ADataModel; ReadOnly: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

function ADataModel_SetReadOnly(DataModel: ADataModel; ReadOnly: ABoolean): AError;
begin
  // ...
  Result := -1;
end;

end.
 