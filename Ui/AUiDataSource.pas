{**
@Author Prof1983 <prof1983@ya.ru>
@Created 12.12.2012
@LastMod 12.12.2012
}
unit AUiDataSource;

interface

uses
  DB,
  ABase, AUiBase, AUiData, AUiEventsObj;

// --- UI_DataSource ---

function UI_DataSource_New(): PADataSource; stdcall;

//procedure UI_DataSource_SetDataSet(DataSource: PADataSource; Value: PADataSet); stdcall;

procedure UI_DataSource_SetOnDataChange(DataSource: PADataSource; OnDataChange: ACallbackProc02); stdcall;

implementation

// --- UI_DataSource ---

function UI_DataSource_New(): PADataSource;
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

{procedure UI_DataSource_SetDataSet(DataSource: PADataSource; Value: PADataSet);
begin
  TDataSource(DataSource).DataSet := TDataSet(DataSet);
end;}

procedure UI_DataSource_SetOnDataChange(DataSource: PADataSource; OnDataChange: ACallbackProc02);
var
  i: Integer;
begin
  i := FindDataSource(DataSource);
  if (i >= 0) then
  begin
    FDataSources[i].OnDataChange02 := OnDataChange;
  end;
end;

end.
 