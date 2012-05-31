{**
@Abstract(Конфигурации формы)
@Author(Prof1983 prof1983@ya.ru)
@Created(18.03.2006)
@LastMod(02.05.2012)
@Version(0.5)
}
unit AConfigFormUtils;

interface

uses
  Forms,
  ANodeIntf, AObjectImpl;

type
  TConfigForm = class(TProfObject)
  private
    FConfigNode: IProfNode;
    FForm: TForm;
  public
      //** Элемент конфигураций из которого загружать и сохранять
    property ConfigNode: IProfNode read FConfigNode write FConfigNode;
      //** Загрузить конфигурации формы
    function ConfigureLoad(): WordBool;
      //** Сохранить конфигурации формы
    function ConfigureSave(): WordBool;
    //constructor Create(AConfigDocument: IXmlDocument = nil; ANodeName: WideString = ''; AForm: TForm = nil; AAddToLog: TAddToLog = nil); overload;
    //constructor Create(AConfigNode: IXmlNode = nil; AForm: TForm = nil; AAddToLog: TAddToLog = nil); overload;
      //** Форма
    property Form: TForm read FForm write FForm;
  end;

resourcestring // Сообщения ----------------------------------------------------
  stLoadOk = 'Конфигурации загружены';
  stSaveOk = 'Конфигурации созранены';

function ConfigFromForm(AConfig: IProfNode; AForm: TForm): WordBool;
function ConfigToForm(AConfig: IProfNode; AForm: TForm): WordBool;
function XmlToFormConfig(const AXml: WideString; AForm: TForm): WordBool;
function XmlFromFormConfig(var AXml: WideString; AForm: TForm): WordBool;

implementation

// -----------------------------------------------------------------------------
function ConfigFromForm(AConfig: IProfNode; AForm: TForm): WordBool;
begin
  {try
    Result := Assigned(AForm) and Assigned(AConfig);
    if not(Result) then Exit;
    if AForm.WindowState <> wsMaximized then
    begin
      TProfXmlNode.WriteIntegerA(AConfig, 'Left', AForm.Left);
      TProfXmlNode.WriteIntegerA(AConfig, 'Top', AForm.Top);
      TProfXmlNode.WriteIntegerA(AConfig, 'Width', AForm.Width);
      TProfXmlNode.WriteIntegerA(AConfig, 'Height', AForm.Height);
    end;
    TProfXmlNode.WriteIntegerA(AConfig, 'WindowState', Integer(AForm.WindowState));
    TProfXmlNode.WriteStringA(AConfig, 'Caption', AForm.Caption); // Заголовок окна
    //AddToLog(lgGeneral, ltInformation, stSaveOk, []);
  except
    Result := False;
  end;}
end;

// -----------------------------------------------------------------------------
function ConfigToForm(AConfig: IProfNode; AForm: TForm): WordBool;
var
  I: Integer;
  S: WideString;
begin
  {try
    Result := Assigned(AForm) and Assigned(AConfig);
    if not(Result) then Exit;
    if TProfXmlNode.ReadIntegerA(AConfig, 'Left', I) then AForm.Left := I;
    if TProfXmlNode.ReadIntegerA(AConfig, 'Top', I) then AForm.Top := I;
    if TProfXmlNode.ReadIntegerA(AConfig, 'Width', I) then AForm.Width := I;
    if TProfXmlNode.ReadIntegerA(AConfig, 'Height', I) then AForm.Height := I;
    if TProfXmlNode.ReadIntegerA(AConfig, 'WindowState', I) then AForm.WindowState := TWindowState(I);
    if TProfXmlNode.ReadStringA(AConfig, 'Caption', S) then AForm.Caption := S; // Заголовок окна
    //AddToLog(lgGeneral, ltInformation, stLoadOk, []);
  except
    Result := False;
  end;}
end;

// -----------------------------------------------------------------------------
function XmlFromFormConfig(var AXml: WideString; AForm: TForm): WordBool;
//var
//  c: IXmlDocument;
begin
  Result := False;
  {c := IProfXmlDocument.Create();
  Result := ConfigFromForm(c.DocumentElement, AForm);
  AXml := c.DocumentElement.Xml;
  c.Free();}
end;

// -----------------------------------------------------------------------------
function XmlToFormConfig(const AXml: WideString; AForm: TForm): WordBool;
//var
//  c: TConfigDocument;
begin
  Result := False;
  {c := TConfigDocument.Create();
  c.DocumentElement.Xml := AXml;
  Result := ConfigToForm(c.DocumentElement, AForm);
  c.Free();}
end;

{ TConfigForm }

function TConfigForm.ConfigureLoad(): WordBool;
begin
  Result := ConfigToForm(FConfigNode, FForm);
end;

function TConfigForm.ConfigureSave(): WordBool;
begin
  Result := ConfigFromForm(FConfigNode, FForm);
end;

{constructor TConfigForm.Create(AConfigDocument: IXmlDocument = nil; ANodeName: WideString = ''; AForm: TForm = nil; AAddToLog: TAddToLog = nil);
begin
  inherited Create();
  FConfigNode := TProfXmlNode.GetNodeByNameA(AConfigDocument.DocumentElement, ANodeName);
  FForm := AForm;
end;}

{constructor TConfigForm.Create(AConfigNode: IXmlNode = nil; AForm: TForm = nil; AAddToLog: TAddToLog = nil);
begin
  inherited Create();
  FConfigNode := AConfigNode;
  FForm := AForm;
end;}

end.
