{**
@Abstract(Конфигурации формы)
@Author(Prof1983 prof1983@ya.ru)
@Created(18.03.2006)
@LastMod(02.05.2012)
@Version(0.5)
}
unit AConfigForm2006;

// TODO: Use AConfigFormUtils.pas

interface

uses
  Forms, XmlIntf,
  AConfig2007, ALogObj, ATypes, AXmlUtils;

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
  try
    Result := Assigned(AForm) and Assigned(AConfig);
    if not(Result) then Exit;
    if AForm.WindowState <> wsMaximized then
    begin
      ProfXmlNode_WriteInt32(AConfig, 'Left', AForm.Left);
      ProfXmlNode_WriteInt32(AConfig, 'Top', AForm.Top);
      ProfXmlNode_WriteInt32(AConfig, 'Width', AForm.Width);
      ProfXmlNode_WriteInt32(AConfig, 'Height', AForm.Height);
    end;
    ProfXmlNode_WriteInt32(AConfig, 'WindowState', Integer(AForm.WindowState));
    ProfXmlNode_WriteString(AConfig, 'Caption', AForm.Caption); // Заголовок окна
    //AddToLog(lgGeneral, ltInformation, stSaveOk, []);
  except
    Result := False;
  end;
end;

function ConfigFromForm2006(AConfig: TConfigNode1; AForm: TForm): WordBool;
begin
  try
    Result := Assigned(AForm) and Assigned(AConfig);
    if not(Result) then Exit;
    if AForm.WindowState <> wsMaximized then
    begin
      AConfig.WriteInt32('Left', AForm.Left);
      AConfig.WriteInt32('Top', AForm.Top);
      AConfig.WriteInt32('Width', AForm.Width);
      AConfig.WriteInt32('Height', AForm.Height);
    end;
    AConfig.WriteInt32('WindowState', Integer(AForm.WindowState));
    AConfig.WriteString('Caption', AForm.Caption); // Заголовок окна
    //AddToLog(lgGeneral, ltInformation, stSaveOk, []);
  except
    Result := False;
  end;
end;

function ConfigToForm(AConfig: IXmlNode; AForm: TForm): WordBool;
var
  I: Integer;
  S: WideString;
begin
  try
    Result := Assigned(AForm) and Assigned(AConfig);
    if not(Result) then Exit;
    if ProfXmlNode_ReadInt32(AConfig, 'Left', I) then AForm.Left := I;
    if ProfXmlNode_ReadInt32(AConfig, 'Top', I) then AForm.Top := I;
    if ProfXmlNode_ReadInt32(AConfig, 'Width', I) then AForm.Width := I;
    if ProfXmlNode_ReadInt32(AConfig, 'Height', I) then AForm.Height := I;
    if ProfXmlNode_ReadInt32(AConfig, 'WindowState', I) then AForm.WindowState := TWindowState(I);
    if ProfXmlNode_ReadString(AConfig, 'Caption', S) then AForm.Caption := S; // Заголовок окна
    //AddToLog(lgGeneral, ltInformation, stLoadOk, []);
  except
    Result := False;
  end;
end;

function ConfigToForm2006(AConfig: TConfigNode1; AForm: TForm): WordBool;
var
  I: Integer;
  S: WideString;
begin
  try
    Result := Assigned(AForm) and Assigned(AConfig);
    if not(Result) then Exit;
    if AConfig.ReadInt32('Left', I) then AForm.Left := I;
    if AConfig.ReadInt32('Top', I) then AForm.Top := I;
    if AConfig.ReadInt32('Width', I) then AForm.Width := I;
    if AConfig.ReadInt32('Height', I) then AForm.Height := I;
    if AConfig.ReadInt32('WindowState', I) then AForm.WindowState := TWindowState(I);
    if AConfig.ReadString('Caption', S) then AForm.Caption := S; // Заголовок окна
    //AddToLog(lgGeneral, ltInformation, stLoadOk, []);
  except
    Result := False;
  end;
end;

function XmlFromFormConfig(var AXml: WideString; AForm: TForm): WordBool;
var
  c: TConfigDocument;
begin
  c := TConfigDocument.Create();
  Result := ConfigFromForm(c.DocumentElement, AForm);
  AXml := c.DocumentElement.Xml;
  c.Free();
end;

function XmlToFormConfig(const AXml: WideString; AForm: TForm): WordBool;
var
  C: TConfigDocument;
begin
  C := TConfigDocument.Create();
  C.Controller.XML.Text{C.DocumentElement.Xml} := AXml;
  Result := ConfigToForm(C.DocumentElement, AForm);
  C.Free();
end;
{function XmlToFormConfig2006(const AXml: WideString; AForm: TForm): WordBool;
var
  c: TConfigDocument;
begin
  c := TConfigDocument.Create();
  c.DocumentElement.Xml := AXml;
  Result := ConfigToForm(c.DocumentElement, AForm);
  c.Free();
end;}

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
