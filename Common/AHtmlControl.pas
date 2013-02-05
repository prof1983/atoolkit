{**
@Abstract Контрол для работы с XHTML
@Author Prof1983 <prof1983@ya.ru>
@Created 11.03.2007
@LastMod 04.02.2013
}
unit AHtmlControl;

interface

uses
  ExtCtrls, StdCtrls,
  ABase, AHtmlConst, ANodeIntf, AXmlDocumentImpl, AXmlNodeUtils;

type
  //** @abstract(Класс для отрисовки элементов управления XHTML)
  THtmlControl = class
  private
    //** Панель для отрисовки элементов
    FController: TPanel;
    //** XHTML код для отрисовки
    FHtmlCode: WideString;
    //** Имя формы - имя тега для построения XML ответа
    FFormName: WideString;
    procedure RefreshForm(Form: AXmlNode);
  public
    //** Удалить все элементы
    procedure Clear();
    //** Перерисовать
    procedure Refresh();
  public
    //** Панель для отрисовки элементов
    property Controller: TPanel read FController write FController;
    //** XHTML код для отрисовки
    property HtmlCode: WideString read FHtmlCode write FHtmlCode;
  end;

const
  HTML_ATTR_FORM_NAME = 'name';

implementation

{ THtmlControl }

procedure THtmlControl.Clear();
var
  i: Integer;
begin
  if Assigned(FController) then
  try
    for i := FController.ControlCount - 1 downto 0 do
    begin
      FController.Controls[i].Free();
    end;
  except
  end;
end;

procedure THtmlControl.Refresh();
var
  nBody: AXmlNode;
  nForm: AXmlNode;
  xhtml: TProfXmlDocument;
  de: AXmlNode;
begin
  Clear();

  xhtml := TProfXmlDocument.Create();
  try
    xhtml.Initialize();
    xhtml.Document.XML.Clear();
    xhtml.Document.XML.Add(FHtmlCode);
    xhtml.Document.Active := True;
    de := xhtml.GetDocumentElement();
    // TODO: Сделать проверку главного тега
    if (AXmlNode_GetName(de) = HTML_TAG_HTML) then
    try
      // Получаем элемент body
      nBody := AXmlNode_GetChildNodeByName(de, HTML_TAG_BODY);
      if (nBody <> 0) then
      begin
        // Получаем элемент form
        nForm := AXmlNode_GetChildNodeByName(nBody, HTML_TAG_FORM);
        RefreshForm(nForm);
      end;
    except
    end;
    xhtml.CloseDocument();
  except
  end;
  xhtml.Free();
end;

procedure THtmlControl.RefreshForm(Form: AXmlNode);
var
  i: Integer;
  nElement: AXmlNode;
  aType: WideString;
var
  ed: TEdit;
  lbl: TLabel;
begin
  if (Form = 0) then Exit;
  try
    // Получаем все элементы и стром форму
    FFormName := AXmlNode_GetAttributeValue(Form, HTML_ATTR_FORM_NAME);
    for i := 0 to AXmlNode_GetChildNodeCount(Form) - 1 do
    begin
      aType := '';
      nElement := AXmlNode_GetChildNodeByIndex(Form, i);
      if (nElement <> 0) then
      begin
        if (AXmlNode_GetName(nElement) = HTML_TAG_FORM_INPUT) then
        begin
          aType := AXmlNode_GetAttributeValue(nElement, HTML_ATTR_FORM_INPUT_TYPE);
          if (aType = HTML_ATTR_FORM_INPUT_TYPE_TEXT) then
          begin
            ed := TEdit.Create(FController);
            ed.Parent := FController;
            ed.Left := 10;
            ed.Top := 10 + i * 25;
            // ...
          end
        end
        else if (AXmlNode_GetName(nElement) = 'b') then
        begin
          lbl := TLabel.Create(FController);
          lbl.Parent := FController;
          lbl.Left := 10;
          lbl.Top := 10 + i * 25;
          //lbl.Caption := nElement.AsString;
        end;
        // TODO: Реализовать полностью
      end;
    end;
  except
  end;
end;

end.
