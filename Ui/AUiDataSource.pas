{**
@Author Prof1983 <prof1983@ya.ru>
@Created 12.12.2012
@LastMod 30.01.2013
}
unit AUiDataSource;

interface

uses
  DB,
  ABase, AUiBase, AUiData, AUiEventsObj;

// --- UI_DataSource ---

function AUiDataSource_New(): PADataSource; stdcall;

//function AUiDataSource_SetDataSet(DataSource: PADataSource; Value: PADataSet): AError; stdcall;

function AUiDataSource_SetOnDataChange(DataSource: PADataSource; OnDataChange: ACallbackProc): AError; stdcall;

implementation

// --- UI_DataSource ---

function AUiDataSource_New(): PADataSource;
var
  DataSource: TDataSource;
  i: Integer;
begin
  DataSource := TDataSource.Create(nil);
  DataSource.OnDataChange := UI_.DataSourceDataChange;
  Result := PADataSource(DataSource);
  i := Length(FDataSources);
  SetLength(FDataSources, i + 1);
  FDataSources[i].DataSource := Result;
end;

{function AUiDataSource_SetDataSet(DataSource: PADataSource; Value: PADataSet): AError;
begin
  TDataSource(DataSource).DataSet := TDataSet(DataSet);
  Result := 0;
end;}

function AUiDataSource_SetOnDataChange(DataSource: PADataSource; OnDataChange: ACallbackProc): AError;
var
  I: Integer;
begin
  I := FindDataSource(DataSource);
  if (I >= 0) then
  begin
    FDataSources[I].OnDataChange := OnDataChange;
  end;
  Result := 0;
end;

end.
 