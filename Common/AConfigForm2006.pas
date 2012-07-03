{**
@Abstract(Конфигурации формы)
@Author(Prof1983 prof1983@ya.ru)
@Created(18.03.2006)
@LastMod(03.05.2012)
@Version(0.5)
}
unit AConfigForm2006;

// TODO: Use AConfigFormUtils.pas

interface

uses
  Forms, XmlIntf,
  AConfig2007, AConfigFormUtils, ALogObj, ATypes; {AXmlUtils;}

type
  TConfigForm = class(TLoggerObject)
  private
    FConfigNode: TConfigNode1;
    FConfigNodeXml: IXmlNode;
    FForm: TForm;
  public
      //** Загрузить конфигурации формы
    function ConfigureLoad(): WordBool;
      //** Сохранить конфигурации формы
    function ConfigureSave(): WordBool;
    constructor Create(AConfigDocument: TConfigDocument = nil; ANodeName: WideString = ''; AForm: TForm = nil; AAddToLog: TAddToLog = nil); overload;
    constructor Create(AConfigNode: TConfigNode1 = nil; AForm: TForm = nil; AAddToLog: TAddToLog = nil); overload;
  public
      //** Элемент конфигураций из которого загружать и сохранять
    property ConfigNode: TConfigNode1 read FConfigNode write FConfigNode;
      //** Элемент конфигураций из которого загружать и сохранять
    property ConfigNodeXml: IXmlNode read FConfigNodeXml write FConfigNodeXml;
      //** Форма
    property Form: TForm read FForm write FForm;
  end;


resourcestring // Сообщения ----------------------------------------------------
  stLoadOk = 'Конфигурации загружены';
  stSaveOk = 'Конфигурации созранены';

function ConfigFromForm(AConfig: IXmlNode; AForm: TForm): WordBool;
function ConfigToForm(AConfig: IXmlNode; AForm: TForm): WordBool;
function XmlToFormConfig(const AXml: WideString; AForm: TForm): WordBool;
function XmlFromFormConfig(var AXml: WideString; AForm: TForm): WordBool;

function ConfigFromForm2006(AConfig: TConfigNode1; AForm: TForm): WordBool;
function ConfigToForm2006(AConfig: TConfigNode1; AForm: TForm): WordBool;

implementation

// --- Public ---

function ConfigFromForm(AConfig: IXmlNode; AForm: TForm): WordBool;
begin
  Result := AConfig_PullFromForm3(AConfig, AForm);
end;

function ConfigFromForm2006(AConfig: TConfigNode1; AForm: TForm): WordBool;
begin
  Result := AConfig_PullFromForm2(AConfig, AForm);
end;

function ConfigToForm(AConfig: IXmlNode; AForm: TForm): WordBool;
begin
  Result := AConfig_PushToForm3(AConfig, AForm);
end;

function ConfigToForm2006(AConfig: TConfigNode1; AForm: TForm): WordBool;
begin
  Result := AConfig_PushToForm1(AConfig, AForm);
end;

function XmlFromFormConfig(var AXml: WideString; AForm: TForm): WordBool;
begin
  Result := AConfigFormUtils.XmlFromFormConfig(AXml, AForm);
end;

function XmlToFormConfig(const AXml: WideString; AForm: TForm): WordBool;
begin
  Result := AConfigFormUtils.XmlToFormConfig(AXml, AForm);
end;

{ TConfigForm }

function TConfigForm.ConfigureLoad(): WordBool;
begin
  if ConfigToForm2006(FConfigNode, FForm) then
  begin
    Result := True;
    Exit;
  end;
  if ConfigToForm(FConfigNodeXml, FForm) then
  begin
    Result := True;
    Exit;
  end;
  Result := False;
end;

function TConfigForm.ConfigureSave(): WordBool;
begin
  if ConfigFromForm2006(FConfigNode, FForm) then
  begin
    Result := True;
    Exit;
  end;
  if ConfigFromForm(FConfigNodeXml, FForm) then
  begin
    Result := True;
    Exit;
  end;
  Result := False;
end;

constructor TConfigForm.Create(AConfigDocument: TConfigDocument = nil; ANodeName: WideString = ''; AForm: TForm = nil; AAddToLog: TAddToLog = nil);
begin
  inherited Create();
  FConfigNodeXml := ProfXmlNode_GetNodeByName(AConfigDocument.DocumentElement, ANodeName);
  FForm := AForm;
end;

constructor TConfigForm.Create(AConfigNode: TConfigNode1 = nil; AForm: TForm = nil; AAddToLog: TAddToLog = nil);
begin
  inherited Create();
  FConfigNode := AConfigNode;
  FForm := AForm;
end;

end.
