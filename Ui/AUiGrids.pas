{**
@Abstract AUi grids
@Author Prof1983 <prof1983@ya.ru>
@Created 11.01.2010
@LastMod 16.04.2013
}
unit AUiGrids;

{$I Defines.inc}

{$IFNDEF NoSettings}
  {$DEFINE USE_SETTINGS}
{$ENDIF}

{$define AStdCall}

interface

uses
  Classes, Controls, Db, DbGrids, Grids, SysUtils,
  ABase,
  {$IFDEF USE_SETTINGS}ASettings,{$ENDIF}
  AStringMain,
  AUiBase;

{ Grid }

{** Производит очистку таблицы. Пока работает только для TStringGrid. }
function AUiGrid_Clear(Grid: AControl): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiGrid_AddColumnP(Grid: AControl; const FieldName, Title: APascalString;
    Width: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Производит очистку таблицы. Пока работает только для TStringGrid. }
function AUiGrid_Clear2(Grid: AControl; FixedRows: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Удаляет строчку. Работает пока только для TStringGrid. }
function AUiGrid_DeleteRow(Grid: AControl): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Удаляет указанную строку }
function AUiGrid_DeleteRow2(Grid: AControl; Row: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Производит поиск значения в заданной колонке. Работает пока только для TStringGrid. }
function AUiGrid_FindInt(Grid: AControl; Col, Value: AInteger): AInteger; {$ifdef AStdCall}stdcall;{$endif}

{**
    @param GridType
      0 - StringGrid
      1 - DBGrid }
function AUiGrid_New(Parent: AControl; GridType: AInteger): AControl; {$ifdef AStdCall}stdcall;{$endif}

{** Восстанавливает колоноки DBGrid или StringGrid }
function AUiGrid_RestoreColProps(Grid: AControl; Config: AConfig; const Key: AString_Type;
    Delimer: AChar = '\'): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Восстанавливает колоноки DBGrid или StringGrid }
function AUiGrid_RestoreColPropsA(Grid: AControl; Config: AConfig; Key: AStr;
    Delimer: AChar = '\'): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Восстанавливает колоноки DBGrid или StringGrid }
function AUiGrid_RestoreColPropsP(Grid: AControl; Config: AConfig; const Key: APascalString;
    Delimer: AChar = '\'): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Восстанавливает колоноки DBGrid или StringGrid }
function AUiGrid_RestoreColPropsWS(Grid: AControl; Config: AConfig; const Key: AWideString;
    Delimer: AWideChar = '\'): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Перемещает строчку ниже. Работает пока только для TStringGrid. }
function AUiGrid_RowDown(Grid: AControl): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Перемещает строчку выше. Работает пока только для TStringGrid. }
function AUiGrid_RowUp(Grid: AControl): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Сохраняет колоноки DBGrid или StringGrid }
function AUiGrid_SaveColProps(Grid: AControl; Config: AConfig; const Key: AString_Type;
    Delimer: AChar = '\'): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Сохраняет колоноки DBGrid или StringGrid }
function AUiGrid_SaveColPropsA(Grid: AControl; Config: AConfig; Key: AStr;
    Delimer: AChar = '\'): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Сохраняет колоноки DBGrid или StringGrid }
function AUiGrid_SaveColPropsP(Grid: AControl; Config: AConfig; const Key: APascalString;
    Delimer: AChar = '\'): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Сохраняет колоноки DBGrid или StringGrid }
function AUiGrid_SaveColPropsWS(Grid: AControl; Config: AConfig; const Key: AWideString;
    Delimer: AWideChar = '\'): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiGrid_SetColumnWidth(Grid: AControl; ColumnIndex, Width, Persent, MinWidth: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiGrid_SetColumnWidth2(Grid: AControl; ColumnIndex, Width, Persent, MinWidth, MaxWidth: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiGrid_SetDataSource(Grid: AControl; Value: PADataSource): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Задает кол-во строк в таблице. Работает пока только для TStringGrid }
function AUiGrid_SetRowCount(Grid: AControl; Count: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

{ DBGrid }

function DBGrid_New(Parent: TWinControl): TDBGrid;
// Восстанавливает колоноки DBGrid
procedure DBGrid_RestoreColProps(Grid: TDBGrid; Config: AConfig; const Key: APascalString; Delimer: AChar = '\');
// Сохраняет колоноки DBGrid
procedure DBGrid_SaveColProps(Grid1: TDBGrid; Config: AConfig; const Key: APascalString; Delimer: AChar = '\');
// Изменяет ширину колонки в DBGrid
procedure DBGrid_SetColumnWidth(Grid1: TDBGrid; ColumnIndex, Width, Persent, MinWidth: AInteger);
procedure DBGrid_SetColumnWidthA(Grid1: TDBGrid; ColumnIndex, Width, Persent, MinWidth, MaxWidth: AInteger);

{ StringGrid }

procedure StringGrid_Clear(Grid: TStringGrid);
procedure StringGrid_ClearA(Grid: TStringGrid; FixedRows: Integer);
procedure StringGrid_ClearCol(Grid: TStringGrid; Col: Integer);
procedure StringGrid_DeleteRowByValue(Grid: TStringGrid; Col: Integer; const Value: string);

// Возвращает номер строки с указанным значением в указанной ячейке.
function StringGrid_Find(Grid: TStringGrid; Col: Integer; const Value: string): Integer;

function StringGrid_Find2P(Grid: TStringGrid; const Value: APascalString; Col, FromRow, ToRow: AInt): AInt;

// Возвращает номер строки с указанным значением в указанной ячейке.
function StringGrid_FindInt(Grid: TStringGrid; Col, Value: Integer): Integer;

// Возвращает номер строки с указанным значением в указанной ячейке.
function StringGrid_FindInt_Trim(Grid: TStringGrid; Col, Value: Integer): Integer;

function StringGrid_New(Parent: TWinControl): TStringGrid;
function StringGrid_RowAdd(Grid: TStringGrid): Integer;
function StringGrid_RowAddA(Grid: TStringGrid): Integer;
procedure StringGrid_RowClear(Grid: TStringGrid);
procedure StringGrid_RowClearA(Grid: TStringGrid; Row: Integer);

// Удаляет текущую строку.
procedure StringGrid_RowDelete(Grid: TStringGrid);

// Удаляет указанную строку.
procedure StringGrid_RowDeleteA(Grid: TStringGrid; Row: Integer);

{ Перемещает строчку ниже.
  Use UI_Grid_RowDown() }
procedure StringGrid_RowDown(Grid: TStringGrid); deprecated;
// Перемещает указанную строчку ниже.
procedure StringGrid_RowDownA(Grid: TStringGrid; Row: Integer);
procedure StringGrid_RowInsert(Grid: TStringGrid);
// Перемещает строчку выше.
procedure StringGrid_RowUp(Grid: TStringGrid);
procedure StringGrid_RowSelect(Grid: TStringGrid; Row: Integer);
// Восстанавливает колоноки StringGrid
procedure StringGrid_RestoreColProps(Grid: TStringGrid; Config: AConfig; const Key: APascalString; Delimer: AChar = '\');
// Восстанавливает колоноки StringGrid
procedure StringGrid_RestoreColPropsA(Grid: TStringGrid; Config: AConfig; const Parent, Name: APascalString; Delimer: AChar = '\');
// Сохраняет колоноки StringGrid
procedure StringGrid_SaveColProps(Grid: TStringGrid; Config: AConfig; const Key: APascalString; Delimer: AChar = '\');
// Сохраняет колоноки StringGrid
procedure StringGrid_SaveColPropsA(Grid: TStringGrid; Config: AConfig; const Parent, Name: APascalString; Delimer: AChar = '\');
// Задает кол-во строк в таблице.
procedure StringGrid_SetRowCount(Grid: TStringGrid; Count: Integer);
procedure StringGrid_Sort_Float(Grid: TStringGrid);
procedure StringGrid_Sort_Int(Grid: TStringGrid);

{ UI_Grid }

procedure UI_Grid_AddColumn(Grid: AControl; const FieldName, Title: APascalString;
    Width: Integer); stdcall; deprecated; // Use AUiGrid_AddColumn()

// Производит очистку таблицы. Пока работает только для TStringGrid.
function UI_Grid_Clear(Grid: AControl): AError; deprecated; // Use AUiGrid_Clear()

// Производит поиск значения в заданной колонке. Работает пока только для TStringGrid.
function UI_Grid_FindInt(Grid: TObject; Col, Value: Integer): Integer;

{ GridType
    0 - StringGrid
    1 - DBGrid }
function UI_Grid_New(Parent: AControl; GridType: AInteger): AControl; stdcall; deprecated; // Use AUiGrid_New()

// Восстанавливает колоноки DBGrid или StringGrid.
procedure UI_Grid_RestoreColProps(Grid: TObject; Config: AConfig; const Key: APascalString;
    Delimer: AChar); stdcall; deprecated; // Use AUiGrid_RestoreColProps()

// Удаляет строчку. Работает пока только для TStringGrid.
function UI_Grid_RowDelete(Grid: AControl): AError;

// Перемещает строчку ниже. Работает пока только для TStringGrid.
procedure UI_Grid_RowDown(Grid: AControl);

// Перемещает строчку выше. Работает пока только для TStringGrid.
procedure UI_Grid_RowUp(Grid: AControl);

// Сохраняет колоноки DBGrid или StringGrid.
procedure UI_Grid_SaveColProps(Grid: TObject; Config: AConfig; const Key: APascalString;
    Delimer: AChar); stdcall; deprecated; // Use AUiGrid_SaveColPropsP()

// Изменяет ширину колонки в DBGrid
procedure UI_Grid_SetColumnWidth(Grid: AControl; ColumnIndex, Width, Persent, MinWidth: AInteger); stdcall;

procedure UI_Grid_SetColumnWidthA(Grid: AControl; ColumnIndex, Width, Persent, MinWidth, MaxWidth: AInteger); stdcall;

procedure UI_Grid_SetDataSource(Grid: AControl; Value: PADataSource); stdcall;

// Задает кол-во строк в таблице. Работает пока только для TStringGrid.
procedure UI_Grid_SetRowCount(Grid: AControl; Count: AInteger);

implementation

{ Types }

type
  TAUIColumn = {$IFDEF UNIX}TGridColumn{$ELSE}TColumn{$ENDIF};

// --- AUiGrid ---

function AUiGrid_AddColumnP(Grid: AControl; const FieldName, Title: APascalString; Width: AInteger): AError;
var
  Column: TAUiColumn;
begin
  try
    {$IFNDEF FPC}
    Column := TDBGrid(Grid).Columns.Add;
    Column.FieldName := FieldName;
    Column.Title.Caption := Title;
    Column.Width := Width;
    {$ENDIF}
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiGrid_Clear(Grid: AControl): AError;
begin
  try
    if (TObject(Grid) is TStringGrid) then
    begin
      StringGrid_Clear(TStringGrid(Grid));
      Result := 0;
    end
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function AUiGrid_Clear2(Grid: AControl; FixedRows: AInteger): AError;
begin
  try
    StringGrid_ClearA(TStringGrid(Grid), FixedRows);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiGrid_DeleteRow(Grid: AControl): AError;
begin
  try
    Result := UI_Grid_RowDelete(Grid);
  except
    Result := -1;
  end;
end;

function AUiGrid_DeleteRow2(Grid: AControl; Row: AInteger): AError;
begin
  try
    StringGrid_RowDeleteA(TStringGrid(Grid), Row);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiGrid_FindInt(Grid: AControl; Col, Value: AInteger): AInteger;
begin
  if (Grid = 0) then
  begin
    Result := -2;
    Exit;
  end;

  try
    Result := UI_Grid_FindInt(TObject(Grid), Col, Value);
  except
    Result := -1;
  end;
end;

function AUiGrid_New(Parent: AControl; GridType: AInteger): AControl;
begin
  try
    Result := AUIGrids.UI_Grid_New(Parent, GridType);
  except
    Result := 0;
  end;
end;

function AUiGrid_RestoreColProps(Grid: AControl; Config: AConfig; const Key: AString_Type;
    Delimer: AChar = '\'): AError;
begin
  Result := AUiGrid_RestoreColPropsP(Grid, Config, AString_ToPascalString(Key), Delimer);
end;

function AUiGrid_RestoreColPropsA(Grid: AControl; Config: AConfig; Key: AStr;
    Delimer: AChar = '\'): AError;
begin
  Result := AUiGrid_RestoreColPropsP(Grid, Config, AnsiString(Key), Delimer);
end;

function AUiGrid_RestoreColPropsP(Grid: AControl; Config: AConfig; const Key: APascalString;
    Delimer: AChar): AError;
var
  GridObj: TObject;
begin
  try
    GridObj := TObject(Grid);
    if not(Assigned(GridObj)) then
    begin
      Result := -2;
      Exit;
    end;
    if (GridObj is TDBGrid) then
      DBGrid_RestoreColProps(TDBGrid(GridObj), Config, Key, Delimer)
    else if (GridObj is TStringGrid) then
      StringGrid_RestoreColProps(TStringGrid(GridObj), Config, Key, Delimer);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiGrid_RestoreColPropsWS(Grid: AControl; Config: AConfig; const Key: AWideString;
    Delimer: AWideChar): AError;
var
  S: AnsiString;
  C: AChar;
begin
  try
    S := Delimer;
    C := AnsiString_GetChar(S, 1);
    Result := AUiGrid_RestoreColPropsP(Grid, Config, Key, C);
  except
    Result := -1;
  end;
end;

function AUiGrid_RowDown(Grid: AControl): AError;
begin
  try
    UI_Grid_RowDown(Grid);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiGrid_RowUp(Grid: AControl): AError;
begin
  try
    UI_Grid_RowUp(Grid);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiGrid_SaveColProps(Grid: AControl; Config: AConfig; const Key: AString_Type;
    Delimer: AChar): AError;
begin
  Result := AUiGrid_SaveColPropsP(Grid, Config, AString_ToPascalString(Key), Delimer);
end;

function AUiGrid_SaveColPropsA(Grid: AControl; Config: AConfig; Key: AStr;
    Delimer: AChar): AError;
begin
  Result := AUiGrid_SaveColPropsP(Grid, Config, AnsiString(Key), Delimer);
end;

function AUiGrid_SaveColPropsP(Grid: AControl; Config: AConfig; const Key: APascalString;
    Delimer: AChar): AError;
var
  GridObj: TObject;
begin
  if (Grid = 0) then
  begin
    Result := -2;
    Exit;
  end;

  try
    GridObj := TObject(Grid);
    if not(Assigned(GridObj)) then
    begin
      Result := -2;
      Exit;
    end;
    if (GridObj is TDBGrid) then
      DBGrid_SaveColProps(TDBGrid(GridObj), Config, Key, Delimer)
    else if (GridObj is TStringGrid) then
      StringGrid_SaveColProps(TStringGrid(GridObj), Config, Key, Delimer);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiGrid_SaveColPropsWS(Grid: AControl; Config: AConfig; const Key: AWideString;
    Delimer: AWideChar): AError;
var
  S: AnsiString;
  C: AChar;
begin
  try
    S := Delimer;
    C := AnsiString_GetChar(S, 1);
    Result := AUiGrid_SaveColPropsP(Grid, Config, Key, C);
  except
    Result := -1;
  end;
end;

function AUiGrid_SetColumnWidth(Grid: AControl; ColumnIndex, Width, Persent, MinWidth: AInteger): AError;
begin
  try
    UI_Grid_SetColumnWidth(Grid, ColumnIndex, Width, Persent, MinWidth);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiGrid_SetColumnWidth2(Grid: AControl; ColumnIndex, Width, Persent, MinWidth, MaxWidth: AInteger): AError;
begin
  try
    UI_Grid_SetColumnWidthA(Grid, ColumnIndex, Width, Persent, MinWidth, MaxWidth);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiGrid_SetDataSource(Grid: AControl; Value: PADataSource): AError;
begin
  try
    UI_Grid_SetDataSource(Grid, Value);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiGrid_SetRowCount(Grid: AControl; Count: AInteger): AError;
begin
  try
    UI_Grid_SetRowCount(Grid, Count);
    Result := 0;
  except
    Result := -1;
  end;
end;

{ DBGrid }

function DBGrid_New(Parent: TWinControl): TDBGrid;
var
  Grid: TDBGrid;
begin
  Grid := TDBGrid.Create(Parent);
  Grid.Parent := Parent;
  Grid.Align := alClient;
  Result := Grid;
end;

procedure DBGrid_RestoreColProps(Grid: TDBGrid; Config: AConfig; const Key: APascalString; Delimer: AChar);
{$IFDEF USE_SETTINGS}
var
  i: SmallInt;
  k: SmallInt;
  idx: Integer;
  wdt: Integer;
  C: TColumn;
  C1: TColumn;
  default: Boolean;
  S: TStringList;
  S1: TStringList;
{$ENDIF}
begin
  {$IFDEF USE_SETTINGS}
  {$IFNDEF FPC}
  default := (Grid.Columns.State = csDefault);
  try
    C := TColumn.Create(nil);
    C1 := TColumn.Create(nil);
    S := TStringList.Create;
    S1 := TStringList.Create;
    try
      for i := 0 to Grid.Columns.Count - 1 do
      begin
        wdt := ASettings.Config_ReadIntegerDefWS(Config, Key + Delimer + Grid.Name + Delimer + Grid.Columns.Items[i].FieldName, 'Width', 0);
        if (wdt > 0) then
          Grid.Columns.Items[i].Width := wdt;
      end;

      for i := 0 to Grid.Columns.Count - 1 do
      begin
        C.Assign(Grid.Columns.Items[i]);
        idx := ASettings.Config_ReadIntegerDefWS(Config, Key + Delimer + Grid.Name + Delimer + Grid.Columns.Items[i].FieldName, 'Index', -1);
        if (idx <> -1) and (idx >= Grid.Columns.Count) then
        begin
          if not default then
          begin
            if (i <> idx) then
            begin
              C1.Assign(Grid.Columns.Items[idx]);
              Grid.Columns.Items[i].Assign(C1);
            end;
            Grid.Columns.Items[idx].Assign(C);
          end
          else
          begin
            S.Add(Grid.Columns.Items[i].FieldName+'='+IntToStr(idx));
          end;
        end;
      end;

      for i := 0 to S.Count - 1 do
        for k := 0 to S.Count - 1 do
        begin
          if (StrToInt(S.Values[S.Names[k]])) = i then
          begin
            S1.Add(S[k]);
            Break;
          end;
        end;

      for i := 0 to S1.Count - 1 do
        for k := 0 to Grid.Columns.Count - 1 do
        begin
          if (Grid.Columns.Items[k].FieldName = S1.Names[i]) then
          begin
            Grid.Columns.Items[k].Index := StrToInt(S1.Values[S1.Names[i]]);
            Break;
          end;
        end;
    finally
      C.Free;
      C1.Free;
      S.Free;
      S1.Free;
    end;
  except
  end;
  {$ENDIF}
  {$ENDIF USE_SETTINGS}
end;

procedure DBGrid_SaveColProps(Grid1: TDBGrid; Config: AConfig; const Key: APascalString; Delimer: AChar);
{$IFDEF USE_SETTINGS}
var
  I: Integer;
  C: TColumn;
  SectionName: string;
{$ENDIF}
begin
  {$IFDEF USE_SETTINGS}
  {$IFNDEF FPC}
  for I := 0 to Grid1.Columns.Count - 1 do
  begin
    C := Grid1.Columns.Items[I];
    SectionName := Key+Delimer+Grid1.Name+Delimer+C.FieldName;
    ASettings.Config_WriteIntegerWS(Config, SectionName, 'Index', I);
    ASettings.Config_WriteIntegerWS(Config, SectionName, 'Width', C.Width);
  end;
  {$ENDIF}
  {$ENDIF}
end;

procedure DBGrid_SetColumnWidth(Grid1: TDBGrid; ColumnIndex, Width, Persent, MinWidth: AInteger);
var
  tmpWidth: Integer;
  Column: TColumn;
begin
  {$IFNDEF FPC}
  Column := Grid1.Columns.Items[ColumnIndex];
  tmpWidth := (Width * Persent) div 100;
  if (tmpWidth >= MinWidth) then
    Column.Width := tmpWidth
  else
    Column.Width := MinWidth;
  {$ENDIF}
end;

procedure DBGrid_SetColumnWidthA(Grid1: TDBGrid; ColumnIndex, Width, Persent, MinWidth, MaxWidth: AInteger);
var
  tmpWidth: Integer;
  Column: TColumn;
begin
  {$IFNDEF FPC}
  Column := Grid1.Columns.Items[ColumnIndex];
  tmpWidth := Round((Width - 30) * Persent / 100) - 4;
  if (tmpWidth < MinWidth) then
    tmpWidth := MinWidth
  else if (tmpWidth > MaxWidth) then
    tmpWidth := MaxWidth;
  Column.Width := tmpWidth;
  {$ENDIF}
end;

{ StringGrid }

procedure StringGrid_Clear(Grid: TStringGrid);
var
  i: Integer;
  j: Integer;
begin
  Grid.RowCount := Grid.FixedRows+1;
  j := Grid.FixedRows;
  for i := 0 to Grid.ColCount-1 do
    Grid.Cells[i,j] := '';
end;

procedure StringGrid_ClearA(Grid: TStringGrid; FixedRows: Integer);
var
  I: Integer;
begin
  Grid.RowCount := FixedRows+1;
  Grid.FixedRows := FixedRows;
  for I := 0 to Grid.ColCount-1 do
    Grid.Cells[I, FixedRows] := '';
end;

procedure StringGrid_ClearCol(Grid: TStringGrid; Col: Integer);
var
  I: Integer;
begin
  for I := Grid.FixedRows to Grid.RowCount-1 do
    Grid.Cells[Col,I] := '';
end;

procedure StringGrid_DeleteRowByValue(Grid: TStringGrid; Col: Integer; const Value: string);
var
  I: Integer;
begin
  for I := 0 to Grid.RowCount-1 do
    if (Grid.Cells[Col,I] = Value) then
      StringGrid_RowDelete(Grid);
end;

function StringGrid_Find(Grid: TStringGrid; Col: Integer; const Value: string): Integer;
var
  I: Integer;
begin
  for I := Grid.FixedRows to Grid.RowCount - 1 do
  begin
    if (Grid.Cells[Col,I] = Value) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function StringGrid_Find2P(Grid: TStringGrid; const Value: APascalString; Col, FromRow, ToRow: AInt): AInt;
var
  TR: Integer;
  I: Integer;
  SRect: TGridRect;
begin
  Tr := Grid.Row;
  for I := FromRow to ToRow do
  begin
    if (Grid.Cells[Col,I] = Value) then
    begin
      SRect.Top := I;
      SRect.Left := Col;
      SRect.Bottom := I;
      SRect.Right := Col;
      if ((I < Grid.TopRow) or (I > Grid.TopRow+Grid.VisibleRowCount)) then
        TR := I-2;
      if (TR > 2) then
        Grid.TopRow := TR
      else
        Grid.TopRow := 2;
      Grid.Selection := SRect;
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function StringGrid_FindInt(Grid: TStringGrid; Col, Value: Integer): Integer;
var
  I: Integer;
begin
  for I := Grid.FixedRows to Grid.RowCount - 1 do
  begin
    if (StrToIntDef(Grid.Cells[Col,I], 0) = Value) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function StringGrid_FindInt_Trim(Grid: TStringGrid; Col, Value: Integer): Integer;
var
  I: Integer;
begin
  for I := Grid.FixedRows to Grid.RowCount - 1 do
  begin
    if (StrToIntDef(Trim(Grid.Cells[Col,I]),0) = Value) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function StringGrid_New(Parent: TWinControl): TStringGrid;
var
  SGrid: TStringGrid;
begin
  SGrid := TStringGrid.Create(Parent);
  SGrid.Parent := Parent;
  SGrid.ColCount := 4;
  SGrid.RowCount := 2;
  SGrid.FixedCols := 1;
  SGrid.FixedRows := 1;
  SGrid.Cells[0,0] := '№';
  SGrid.Cells[1,0] := 'Subject';
  SGrid.Cells[2,0] := 'Property';
  SGrid.Cells[3,0] := 'Object';
  SGrid.ColWidths[0] := 30;
  SGrid.ColWidths[1] := 150;
  SGrid.ColWidths[2] := 150;
  SGrid.ColWidths[3] := 150;
  SGrid.DefaultRowHeight := 16;
  Result := SGrid;
end;

procedure StringGrid_RestoreColProps(Grid: TStringGrid; Config: AConfig; const Key: APascalString; Delimer: AChar = '\');
begin
  StringGrid_RestoreColPropsA(Grid, Config, Key, Grid.Name, Delimer);
end;

procedure StringGrid_RestoreColPropsA(Grid: TStringGrid; Config: AConfig; const Parent, Name: APascalString; Delimer: AChar = '\');
{$IFDEF USE_SETTINGS}
var
  i: Integer;
{$ENDIF}
begin
  {$IFDEF USE_SETTINGS}
  for i := 0 to Grid.ColCount - 1 do
    Grid.ColWidths[i] := ASettings.Config_ReadIntegerDefWS(Config, Parent + Delimer + Name + Delimer + IntToStr(i), 'Width', Grid.ColWidths[i]);
  {$ENDIF}
end;

function StringGrid_RowAdd(Grid: TStringGrid): Integer;
begin
  Result := Grid.RowCount;
  Grid.RowCount := Result+1;
end;

function StringGrid_RowAddA(Grid: TStringGrid): Integer;
var
  i: Integer;
  IsClear: Boolean;
begin
  if (Grid.RowCount = Grid.FixedRows+1) then
  begin
    IsClear := True;
    for i := Grid.FixedCols to Grid.ColCount do
    begin
      IsClear := False;
      Break;
    end;
    if IsClear then
    begin
      Result := Grid.FixedRows;
      Exit;
    end;
  end;
  Result := Grid.RowCount;
  Grid.RowCount := Result+1;
end;

procedure StringGrid_RowClear(Grid: TStringGrid);
begin
  StringGrid_RowClearA(Grid, Grid.Row);
end;

procedure StringGrid_RowClearA(Grid: TStringGrid; Row: Integer);
var
  I: Integer;
begin
  for I := 0 to Grid.ColCount - 1 do
    Grid.Cells[I,Row] := '';
end;

procedure StringGrid_RowDelete(Grid: TStringGrid);
begin
  StringGrid_RowDeleteA(Grid, Grid.Row);
end;

procedure StringGrid_RowDeleteA(Grid: TStringGrid; Row: Integer);
var
  ic: Integer;
begin
  if (Grid.RowCount <= Grid.FixedRows+1) then
    StringGrid_Clear(Grid)
  else
  begin
    for ic := Row to Grid.RowCount - 1 do
      Grid.Rows[ic] := Grid.Rows[ic+1];
    Grid.RowCount := Grid.RowCount - 1;
  end;
end;

procedure StringGrid_RowDown(Grid: TStringGrid);
begin
  StringGrid_RowDownA(Grid, Grid.Row);
end;

procedure StringGrid_RowDownA(Grid: TStringGrid; Row: Integer);
var
  i: Integer;
  S: string;
begin
  if (Row < Grid.RowCount - 1) then
  begin
    for i := 0 to Grid.ColCount - 1 do
    begin
      S := Grid.Cells[i,Row];
      Grid.Cells[i,Row] := Grid.Cells[i,Row+1];
      Grid.Cells[i,Row+1] := S;
    end;
    Grid.Row := Row + 1;
  end;
end;

procedure StringGrid_RowInsert(Grid: TStringGrid);
var
  ic: Integer;
  jc: Integer;
  SRect: TGridRect;
begin
  for ic := Grid.RowCount - 1 downto Grid.Row + 1 do
    Grid.Rows[ic+1] := Grid.Rows[ic];
  for jc := 0 to Grid.ColCount-1 do
    Grid.Cells[jc,Grid.Row+1] := '';
  Grid.RowCount := Grid.RowCount + 1;
  SRect.Top := Grid.Row + 1;
  SRect.Left := 0 + Grid.FixedCols;
  SRect.Bottom := Grid.Row + 1;
  SRect.Right := 0 + Grid.FixedCols;
  Grid.Selection := SRect;
end;

procedure StringGrid_RowSelect(Grid: TStringGrid; Row: Integer);
var
  Srect: TGridRect;
begin
  SRect.Top := Row;
  SRect.Left := 0;
  SRect.Bottom := Row;
  SRect.Right := 0;
  Grid.Selection := SRect;
end;

procedure StringGrid_RowUp(Grid: TStringGrid);
var
  I: Integer;
  Row: Integer;
  S: string;
begin
  Row := Grid.Row;
  if (Row > Grid.FixedRows) then
  begin
    for I := 0 to Grid.ColCount - 1 do
    begin
      S := Grid.Cells[I,Row];
      Grid.Cells[I,Row] := Grid.Cells[I,Row-1];
      Grid.Cells[I,Row-1] := S;
    end;
    Grid.Row := Row - 1;
  end;
end;

procedure StringGrid_SaveColProps(Grid: TStringGrid; Config: AConfig; const Key: APascalString; Delimer: AChar = '\');
begin
  StringGrid_SaveColPropsA(Grid, Config, Key, Grid.Name, Delimer);
end;

procedure StringGrid_SaveColPropsA(Grid: TStringGrid; Config: AConfig; const Parent, Name: APascalString; Delimer: AChar = '\');
{$IFDEF USE_SETTINGS}
var
  I: Integer;
  SectionName: string;
{$ENDIF}
begin
  {$IFDEF USE_SETTINGS}
  for I := 0 to Grid.ColCount - 1 do
  begin
    SectionName := Parent+Delimer+Name+Delimer+IntToStr(i);
    ASettings.Config_WriteIntegerWS(Config, SectionName, 'Width', Grid.ColWidths[i]);
  end;
  {$ENDIF}
end;

procedure StringGrid_SetRowCount(Grid: TStringGrid; Count: Integer);
begin
  if (Count >= Grid.FixedRows+1) then
    Grid.RowCount := Count
  else
    StringGrid_Clear(Grid);
end;

procedure StringGrid_Sort_Float(Grid: TStringGrid);
var
  IsWork: Boolean;
  Col: Integer;
  i: Integer;
  a: Double;
  b: Double;
begin
  Col := Grid.Col;
  IsWork := True;
  while (IsWork) do
  begin
    IsWork := False;
    for i := Grid.FixedRows to Grid.RowCount - 2 do
    begin
      a := StrToFloatDef(Grid.Cells[Col,i],0);
      b := StrToFloatDef(Grid.Cells[Col,i+1],0);
      if (a > b) then
      begin
        StringGrid_RowDownA(Grid, i);
        IsWork := True;
      end;
    end;
  end;
end;

procedure StringGrid_Sort_Int(Grid: TStringGrid);
var
  IsWork: Boolean;
  Col: Integer;
  I: Integer;
  a: Integer;
  b: Integer;
begin
  Col := Grid.Col;
  IsWork := True;
  while (IsWork) do
  begin
    IsWork := False;
    for I := Grid.FixedRows to Grid.RowCount - 2 do
    begin
      a := StrToIntDef(Grid.Cells[Col,I],0);
      b := StrToIntDef(Grid.Cells[Col,I+1],0);
      if (a > b) then
      begin
        StringGrid_RowDownA(Grid, I);
        IsWork := True;
      end;
    end;
  end;
end;

// --- UI_Grid ---

procedure UI_Grid_AddColumn(Grid: AControl; const FieldName, Title: APascalString; Width: Integer);
begin
  AUiGrid_AddColumnP(Grid, FieldName, Title, Width);
end;

function UI_Grid_Clear(Grid: AControl): AError;
begin
  Result := AUiGrid_Clear(Grid);
end;

function UI_Grid_FindInt(Grid: TObject; Col, Value: Integer): Integer;
begin
  if not(Assigned(Grid)) then
  begin
    Result := -2;
    Exit;
  end;
  Result := StringGrid_FindInt(TStringGrid(Grid), Col, Value);
end;

function UI_Grid_New(Parent: AControl; GridType: AInteger): AControl;
begin
  if (GridType = 0) then
    Result := AControl(StringGrid_New(TWinControl(Parent)))
  else if (GridType = 1) then
    Result := AControl(DBGrid_New(TWinControl(Parent)))
  else
    Result := 0;
end;

procedure UI_Grid_RestoreColProps(Grid: TObject; Config: AConfig; const Key: APascalString; Delimer: AChar);
begin
  AUiGrid_RestoreColPropsP(AControl(Grid), Config, Key, Delimer);
end;

function UI_Grid_RowDelete(Grid: AControl): AError;
begin
  if (TObject(Grid) is TStringGrid) then
  begin
    StringGrid_RowDelete(TStringGrid(Grid));
    Result := 0;
  end
  else
    Result := -1;
end;

procedure UI_Grid_RowDown(Grid: AControl);
begin
  StringGrid_RowDownA(TStringGrid(Grid), TStringGrid(Grid).Row);
end;

procedure UI_Grid_RowUp(Grid: AControl);
begin
  StringGrid_RowUp(TObject(Grid) as TStringGrid);
end;

procedure UI_Grid_SaveColProps(Grid: TObject; Config: AConfig; const Key: APascalString; Delimer: AChar);
begin
  AUiGrid_SaveColPropsP(AControl(Grid), Config, Key, Delimer);
end;

procedure UI_Grid_SetColumnWidth(Grid: AControl; ColumnIndex, Width, Persent, MinWidth: AInteger); stdcall;
{var
  tmpWidth: Integer;
  Column: TColumn;}
begin
  DBGrid_SetColumnWidth(TDBGrid(Grid), ColumnIndex, Width, Persent, MinWidth);

  {$IFNDEF FPC}
  {Column := TDBGrid(Grid).Columns.Items[ColumnIndex];
  tmpWidth := (Width * Persent) div 100;
  if (tmpWidth >= MinWidth) then
    Column.Width := tmpWidth
  else
    Column.Width := MinWidth;}
  {$ENDIF}
end;

procedure UI_Grid_SetColumnWidthA(Grid: AControl; ColumnIndex, Width, Persent, MinWidth, MaxWidth: AInteger); stdcall;
{var
  tmpWidth: Integer;
  Column: TColumn;}
begin
  DBGrid_SetColumnWidthA(TDBGrid(Grid), ColumnIndex, Width, Persent, MinWidth, MaxWidth);

  {$IFNDEF FPC}
  {Column := TDBGrid(Grid).Columns.Items[ColumnIndex];
  tmpWidth := Round((Width - 30) * Persent / 100) - 4;
  if (tmpWidth < MinWidth) then
    tmpWidth := MinWidth
  else if (tmpWidth > MaxWidth) then
    tmpWidth := MaxWidth;
  Column.Width := tmpWidth;}
  {$ENDIF}
end;

procedure UI_Grid_SetDataSource(Grid: AControl; Value: PADataSource); stdcall;
begin
  TDBGrid(Grid).DataSource := TDataSource(Value);
end;

procedure UI_Grid_SetRowCount(Grid: AControl; Count: AInteger);
begin
  StringGrid_SetRowCount(TStringGrid(Grid), Count);
end;

end.
