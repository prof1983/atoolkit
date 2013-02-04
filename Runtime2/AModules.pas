{**
@Abstract(Класс для работа с модулями в режиме runtime)
@Author(Prof1983 prof1983@ya.ru)
@Created(28.08.2007)
@LastMod(10.07.2012)
@Version(0.5)
}
unit AModules;

interface

uses
  AModuleIntf, AModuleInformationIntf;

type
  TRuntimeModules = class
  private
    FModules: array of IProfModule;
    FModuleInformations: array of IModuleInformation;
  public
    function GetIndexByID(ID: WideString): Integer;
    function GetModuleByID(ID: WideString): IProfModule;
    function GetModuleByIndex(Index: Integer): IProfModule;
    function GetModuleCount(): Integer;
    function GetModuleInfoByIndex(Index: Integer): IModuleInformation;
      //** Загрузить модуль FModules[Index] по данным FModuleInformations[Index]
    procedure LoadModuleByIndex(Index: Integer);
  public
      //** Добавить модуль в список
    procedure AddModule(Module: IProfModule);
  public
    property ModuleByID[ID: WideString]: IProfModule read GetModuleByID;
    property ModuleByIndex[Index: Integer]: IProfModule read GetModuleByIndex;
    property ModuleCount: Integer read GetModuleCount;
    property ModuleInformationByIndex[Index: Integer]: IModuleInformation read GetModuleInfoByIndex;
  end;

implementation

{ TRuntimeModules }

procedure TRuntimeModules.AddModule(Module: IProfModule);
var
  id: WideString;
  mi: IModuleInformation;
  i: Integer;
begin
  if not(Assigned(Module)) then Exit;
  mi := Module.Information;
  if Assigned(mi) then
  begin
    id := mi.ID;
    if id <> '' then
    begin
      i := GetIndexByID(id);
      if (i >= 0) then
      begin
        FModules[i] := Module;
        Exit;
      end;
    end;
  end;

  i := Length(FModules);
  SetLength(FModules, i + 1);
  SetLength(FModuleInformations, i + 1);
  FModules[i] := Module;
  FModuleInformations[i] := Module.Information;
end;

function TRuntimeModules.GetIndexByID(ID: WideString): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to High(FModuleInformations) do
    if Assigned(FModuleInformations[i]) and (FModuleInformations[i].ID = ID) then
    begin
      Result := i;
      Exit;
    end;
end;

function TRuntimeModules.GetModuleByID(ID: WideString): IProfModule;
var
  index: Integer;
begin
  Result := nil;
  index := GetIndexByID(ID);
  if (index < 0) then Exit;
  Result := GetModuleByIndex(index);
end;

function TRuntimeModules.GetModuleByIndex(Index: Integer): IProfModule;
begin
  Result := nil;
  if (Index < 0) or (Index >= Length(FModules)) then Exit;
  if not(Assigned(FModules[Index])) then
  begin
    LoadModuleByIndex(Index);
  end;
  Result := FModules[Index];
end;

function TRuntimeModules.GetModuleCount(): Integer;
begin
  Result := Length(FModules);
end;

function TRuntimeModules.GetModuleInfoByIndex(Index: Integer): IModuleInformation;
var
  m: IProfModule;
begin
  if (Index >= 0) or (Index < Length(FModuleInformations)) then
  begin
    Result := FModuleInformations[Index];
    if not(Assigned(Result)) then
    begin
      m := FModules[Index];
      if Assigned(m) then
        Result := m.Information;
    end;
  end
  else
    Result := nil;
end;

procedure TRuntimeModules.LoadModuleByIndex(Index: Integer);
begin
  // ...
end;

end.
