{**
@Abstract(Работа с XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.10.2005)
@LastMod(06.07.2012)
@Version(0.5)
}
unit AXml2007;

{$I A.inc}

interface

uses
  ComCtrls, ComObj,
  ABase, AXmlDocumentImpl, AXmlNodeImpl;

//type
  //IXmlDomNode = IXmlNode;

type // Используемые классы для работы с XML -----------------------------------
  TProfXmlDocument = AXmlDocumentImpl.TProfXmlDocument;
  TProfXmlNode = TProfXmlNode1;

const // Сообщения -------------------------------------------------------------
  err_SaveToFile = 'Ошибка при сохранении файла "%s" "%s"';
  err_Load1      = 'Не найден закрывающий тег "?>" Line=%d';
  err_Load2      = 'Не задан элемент Line=%d';
  err_ReadNodes_1 = 'Не найдена закрывающая символ ">"';

// -----------------------------------------------------------------------------

{**
  Формировать документы в формате XML достаточно просто. Следует лишь познакомится с
  конкретным DTD и образцами корректных документов. А вот загрузка может быть достаточно
  трудна, если не прибегать к помощи готовых решений в виде XML парсеров. Их довольно
  много для разных платформ и при желании можно найти их описания в WWW. Одним из
  наиболее распространенным на платформе Windows является Microsoft XML Parser. Дело в том,
  что он входит в состав Microsoft Explorer 5.0 и более позние версии. Он доступен в виде
  объекта ActiveX. Данный парсер является верифицирующим, то есть проверяет не только
  синтаксическую проверку документа, но и семантическую корректность в соответствии с заданным DTD.
  http://www.codenet.ru/progr/delphi/stat/delphi_xml.php
}
procedure LoadOnixDoc(TV: TTreeView; const FileName: string);

// Functions Forward -----------------------------------------------------------

{**
  Переводит строку со спец символими в строку Html формата со спецсимволами
}
function StrHtmlFromStr(const Value: WideString): WideString;

{**
  Переводит строку Html формата с тегами в простую строку с символами
  Обратная процедура StrHtmlFromStr
}
function StrHtmlToStr(Value: WideString): WideString;

implementation

// Functions -------------------------------------------------------------------

procedure LoadOnixDoc(TV: TTreeView; const FileName: string);
var
  XML: variant;
  mainNode, childNodes: variant;
  TreeNode: TTreeNode;

  procedure LoadItems(TreeNode: TTreeNode; Node: variant);
  var i: integer;
  begin
    TreeNode := TV.Items.AddChild(TreeNode, Node.nodeName);
    TreeNode.ImageIndex := TreeNode.Level;
    TreeNode.SelectedIndex := TreeNode.ImageIndex;
    if Node.nodeName = '#text' then
    begin
      TreeNode.Text := Node.nodeValue;
      //TV.SetNodeBoldState(TreeNode, true);
    end;
    for i:=0 to Node.childNodes.length-1 do
      LoadItems(TreeNode, Node.childNodes.item[i]);
  end;

begin
  XML := CreateOleObject('Microsoft.XMLDOM');
  XML.load(FileName);

  if XML.parseError.reason <> '' then
  begin
    //ShowMessage( XML.parseError.reason );
  end
  else
  begin
    mainNode := XML.documentElement;
    childNodes := mainNode.childNodes;
    LoadItems(nil, mainNode);
    TreeNode := TV.Items[1];
    while Assigned(TreeNode) do
    begin
      TreeNode.Expand(false);
      TreeNode := TreeNode.GetNextSibling;
    end;
    if Assigned(TV.Items[0]) then TV.Items[0].Expand(false);
  end;
end;

function StrHtmlFromStr(const Value: WideString): WideString;
var
  I: Int32;
begin
  Result := '';
  for I := 1 to Length(Value) do case Value[I] of
    '<': Result := Result + '&lt;';
    '>': Result := Result + '&gt;';
  else
    Result := Result + Value[I];
  end;
end;

function StrHtmlToStr(Value: WideString): WideString;
var
  Igt: Int32;
  Ilt: Int32;
begin
  Result := '';
  repeat
    Igt := Pos(WideString('&gt;'), Value);
    Ilt := Pos(WideString('&lt;'), Value);
    if (Igt > 0) and (Ilt > 0) and (Igt < Ilt) then
    begin
      Result := Result + Copy(Value, 1, Igt - 1) + '>';
      Delete(Value, 1, Igt + 3);
    end else if (Igt > 0) and (Ilt > 0) and (Ilt < Igt) then
    begin
      Result := Result + Copy(Value, 1, Ilt - 1) + '<';
      Delete(Value, 1, Ilt + 3);
    end else if (Igt > 0) then
    begin
      Result := Result + Copy(Value, 1, Igt - 1) + '>';
      Delete(Value, 1, Igt + 3);
    end else if (Ilt > 0) then
    begin
      Result := Result + Copy(Value, 1, Ilt - 1) + '<';
      Delete(Value, 1, Ilt + 3);
    end else Result := Result + Value;
  until (Igt = 0) and (Ilt = 0);
end;

end.
