{**
@Abstract(Контрол для работы с XHTML)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.03.2007)
@LastMod(27.04.2012)
@Version(0.5)
}
unit AHtmlControl;

interface

uses
  ExtCtrls, StdCtrls,
  AHtmlConst, ANodeIntf, AXmlDocument; 

type
  //** @abstract(Класс для отрисовки элементов управления XHTML)
  THtmlControl = class
  private
    //FEdit: TEdit;
  private
    //** Панель для отрисовки элементов
    FController: TPanel;
    //** XHTML код для отрисовки
    FHtmlCode: WideString;
    //** Имя формы - имя тега для построения XML ответа
    FFormName: WideString;
    procedure RefreshForm(AForm: IProfNode);
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
//  if Assigned(FEdit) then
//  begin
//    FEdit.Free();
//    FEdit := nil;
//  end;
end;

procedure THtmlControl.Refresh();
var
  nBody: IProfNode;
  nForm: IProfNode;
  xhtml: TProfXmlDocument;
begin
  Clear();

  xhtml := TProfXmlDocument.Create();
  xhtml.Initialize();
  xhtml.Document.XML.Clear();
  xhtml.Document.XML.Add(FHtmlCode);
  try
    xhtml.Document.Active := True;
    xhtml.OpenA();
    // TODO: Сделать проверку главного тега
    if (xhtml.Document.DocumentElement.NodeName = HTML_TAG_HTML) then
    try
      // Получаем элемент body
      nBody := xhtml.NodeByName[HTML_TAG_BODY];
      if Assigned(nBody) and Assigned(nBody.ChildNodes) then
      begin
        // Получаем элемент form
        nForm := nBody.ChildNodes.NodeByName[HTML_TAG_FORM];
        RefreshForm(nForm);
      end;
    except
    end;
    xhtml.Document.Active := False;
  except
  end;
  xhtml.CloseDocument();
  xhtml.Free();
end;

procedure THtmlControl.RefreshForm(AForm: IProfNode);
var
  i: Integer;
  nElement: IProfNode;
  aType: WideString;
var
  ed: TEdit;
  lbl: TLabel;
begin
  if Assigned(AForm) then
  try
    // Получаем все элементы и стром форму
    FFormName := AForm.Attributes.AttributeByName[HTML_ATTR_FORM_NAME].Value;
    for i := 0 to AForm.ChildNodes.Count - 1 do
    begin
      aType := '';
      nElement := AForm.ChildNodes.NodeByIndex[i];
      if Assigned(nElement) then
      begin
        if (nElement.Name = HTML_TAG_FORM_INPUT) then
        begin
          aType := nElement.Attributes.AttributeByName[HTML_ATTR_FORM_INPUT_TYPE].Value;
          if (aType = HTML_ATTR_FORM_INPUT_TYPE_TEXT) then
          begin
            ed := TEdit.Create(FController);
            ed.Parent := FController;
            ed.Left := 10;
            ed.Top := 10 + i * 25;
            // ...
          end
        end
        else if (nElement.Name = 'b') then
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
