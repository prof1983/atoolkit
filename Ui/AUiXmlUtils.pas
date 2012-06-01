{**
@Abstract(Дополнительные процедуры и функции)
@Author(Prof1983 prof1983@ya.ru)
@Created(19.06.2006)
@LastMod(02.05.2012)
@Version(0.5)
}
unit AUiXmlUtils;

interface

uses
  Menus,
  AXml2007;

procedure ConfigureLoadMenuItem(Items: TMenuItem; c: TProfXmlNode1);

implementation

procedure ConfigureLoadMenuItem(Items: TMenuItem; c: TProfXmlNode1);
var
  i: Integer;
  n: WideString;
  t: WideString;
begin
  if not(Assigned(Items)) or not(Assigned(c)) then Exit;
  for i := 0 to Items.Count - 1 do
  begin
    n := Items.Items[i].Name;
    c.ReadString(n, t);
    if t <> '' then
      Items.Items[i].Caption := t
    else // Запись значения по умолчанию
      c.WriteString(n, Items.Items[i].Caption);
    ConfigureLoadMenuItem(Items.Items[i], c.GetNodeByName(n));
  end;
end;

end.
 