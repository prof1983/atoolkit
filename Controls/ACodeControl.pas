{**
@Author Prof1983 <prof1983@ya.ru>
@Created 09.11.2006
@LastMod 05.02.2013
}
unit ACodeControl;

interface

uses
  Classes, Controls, StdCtrls,
  ABase, AControlImpl;

type
  TArCodeControl = class(TAControl)
  private
    FMemo: TMemo;
    function GetLines(): TStrings;
  public
    procedure AddCode(ACode: WideString);
    function Initialize(): AError; override;
    procedure LoadFromFile(const FileName: WideString);
  public
    property Lines: TStrings read GetLines;
  end;

implementation

{ TARCodeControl }

procedure TArCodeControl.AddCode(ACode: WideString);
var
  i: Integer;
  tmp: WideString;
begin
  tmp := '';
  for i := 1 to Length(ACode) do
  begin
    if ACode[i] = #0 then
    begin
      FMemo.Lines.Add(tmp);
      tmp := '';
    end
    else
      tmp := tmp + ACode[i];
  end;
  FMemo.Lines.Add(tmp);
end;

function TArCodeControl.GetLines(): TStrings;
begin
  Result := nil;
  if Assigned(FMemo) then
    Result := FMemo.Lines;
end;

function TArCodeControl.Initialize(): AError;
begin
  Result := inherited Initialize();
  FMemo := TMemo.Create(FControl);
  FMemo.Parent := FControl;
  FMemo.Align := alClient;
  FMemo.Font.Name := 'Courier New';
  FMemo.ScrollBars := ssBoth;
end;

procedure TArCodeControl.LoadFromFile(const FileName: WideString);
begin
  FMemo.Clear();
  try
    FMemo.Lines.LoadFromFile(FileName);
  except
  end;
end;

end.
