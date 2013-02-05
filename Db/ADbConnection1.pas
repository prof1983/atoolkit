{**
@Author Prof1983 <prof1983@ya.ru>
@Created 26.10.2005
@LastMod 05.02.2013
}
unit ADbConnection1;

interface

uses
  AdoDB, Classes, SysUtils;

type
  TProfAdoConnection = class(TAdoConnection)
  private
    FDBFileName: WideString;
  public
    constructor Create(AOwner: TComponent = nil); override;
    {** Close Connection }
    function Finalize(): WordBool; virtual;
    procedure Free(); virtual;
    {** Open Connection }
    function Initialize(): WordBool; virtual;
    class function OpenConnection(const AConnectionString: WideString): TAdoConnection;
  public
    property DBFileName: WideString read FDBFileName write FDBFileName;
  end;

implementation

{ TProfAdoConnection }

constructor TProfAdoConnection.Create(AOwner: TComponent = nil);
begin
  inherited Create(AOwner);
  FDBFileName := '';
end;

function TProfAdoConnection.Finalize(): WordBool;
begin
  try
    Close();
    Result := True;
  except
    Result := False;
  end;
end;

procedure TProfAdoConnection.Free();
begin
  inherited Free();
end;

function TProfAdoConnection.Initialize(): WordBool;
begin
  try
    Result := Connected;
    if Result then Exit;

    if ConnectionString = '' then
    begin
      if FDBFileName <> '' then
      begin
        ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;'+
          'Data Source='+FDBFileName+';Persist Security Info=False';
      end;
    end;

    Connected := True;
    Result := Connected;
  except
    Result := False;
  end;
end;

class function TProfAdoConnection.OpenConnection(const AConnectionString: WideString): TAdoConnection;
begin
  Result := TAdoConnection.Create(nil);
  try
    Result.ConnectionString := AConnectionString;
    Result.LoginPrompt := False;
    Result.Open();
  except
    Result.Free();
    Result := nil;
  end;
end;

end.
