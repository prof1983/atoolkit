{**
@Author Prof1983 <prof1983@ya.ru>
@Created 12.12.2012
@LastMod 20.02.2013
}
unit AUiDataSource;

{define AStdCall}

interface

uses
  Db,
  ABase,
  AUiBase,
  AUiData;
  //AUiEventsObj;

// --- AUiDataSource ---

function AUiDataSource_New(): PADataSource; {$ifdef AStdCall}stdcall;{$endif}

//function AUiDataSource_SetDataSet(DataSource: PADataSource; Value: PADataSet): AError; stdcall;

function AUiDataSource_SetOnDataChange(DataSource: PADataSource; OnDataChange: ACallbackProc): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

type
  TUiDataSourceEvents = class
  public
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
  end;

var
  _DataSourceEvents: TUiDataSourceEvents;

// --- AUiDataSource ---

function AUiDataSource_New(): PADataSource;
var
  DataSource: TDataSource;
  i: Integer;
begin
  if not(Assigned(_DataSourceEvents)) then
    _DataSourceEvents := TUiDataSourceEvents.Create();

  DataSource := TDataSource.Create(nil);
  DataSource.OnDataChange := _DataSourceEvents.DataSourceDataChange;
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

{ TUiDataSourceEvents }

procedure TUiDataSourceEvents.DataSourceDataChange(Sender: TObject; Field: TField);
var
  I: Integer;
begin
  I := FindDataSource(PADataSource(Sender));
  if (I >= 0) then
  begin
    if Assigned(FDataSources[I].OnDataChange) then
      FDataSources[I].OnDataChange(Integer(Sender), Integer(Field));
  end;
end;

end.
 