{**
@Abstract
@Author Prof1983 <prof1983@ya.ru>
@Created 31.01.2008
@LastMod 14.11.2012
}
unit ATaskObj;

interface

type //** @abstract(Класс для задания)
  TATask = class
  private
    FComment: String;
    FTitle: String;
  public
    function GetName(): String;
    function GetText(): String;
    procedure SetName(const Value: String);
    procedure SetText(const Value: String);
  public
    property Comment: String read FComment write FComment;
    property Title: String read FTitle write FTitle;
  end;

type
  TATasks = array of TATask;

implementation

{ TATask }

function TATask.GetName(): String;
begin
  Result := FTitle;
end;

function TATask.GetText(): String;
begin
  Result := FComment;
end;

procedure TATask.SetName(const Value: string);
begin
  FTitle := Value;
end;

procedure TATask.SetText(const Value: string);
begin
  FComment := Value;
end;

end.
 