{**
@Abstract(Дополнительные процедуры и функции)
@Author(Prof1983 prof1983@ya.ru)
@Created(19.06.2006)
@LastMod(04.07.2012)
@Version(0.5)
}
unit AUiXmlUtils;

interface

uses
  Menus,
  ABase, AXmlNodeImpl, AXmlNodeUtils;

procedure ConfigureLoadMenuItem(Items: TMenuItem; c: TProfXmlNode1); deprecated; // Use MenuItem_LoadConfigure()

function MenuItem_LoadConfigure(Item: TMenuItem; C: AXmlNode): AError;

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
    ConfigureLoadMenuItem(Items.Items[i], c.GetNodeByName1(n));
  end;
end;

// --- MenuItem ---

function MenuItem_LoadConfigure(Item: TMenuItem; C: AXmlNode): AError;
var
  I: Integer;
  Name: WideString;
  Text: APascalString;
begin
  if not(Assigned(Item)) then
  begin
    Result := -2;
    Exit;
  end;
  if (C = 0) then
  begin
    Result := -2;
    Exit;
  end;

  for I := 0 to Item.Count - 1 do
  begin
    Name := Item.Items[i].Name;
    AXmlNode_ReadString(C, Name, Text);
    if (Text <> '') then
      Item.Items[I].Caption := Text
    else // Запись значения по умолчанию
      AXmlNode_WriteString(C, Name, Item.Items[I].Caption);
    MenuItem_LoadConfigure(Item.Items[I], AXmlNode_GetChildNodeByName(C, Name));
  end;
  Result := 0;
end;

end.
 