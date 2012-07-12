{**
@Abstract(Конфигурации формы)
@Author(Prof1983 prof1983@ya.ru)
@Created(18.03.2006)
@LastMod(12.07.2012)
@Version(0.5)
}
unit AConfigFormUtils;

interface

uses
  Forms, XmlIntf,
  ABase, AConfig2007, ANodeIntf, ATypes, AXmlNodeUtils, AXmlUtils;

type
  TConfigForm = class //(TProfObject)
  protected
    FConfig: AConfig;
    //FConfigNode: IProfNode;
    //FConfigNode: TConfigNode1;
    //FConfigNodeXml: IXmlNode;
    FForm: TForm;
  public
      //** Загрузить конфигурации формы
    function ConfigureLoad(): WordBool;
      //** Сохранить конфигурации формы
    function ConfigureSave(): WordBool;
  public
    //constructor Create(AConfigDocument: IXmlDocument = nil; ANodeName: WideString = ''; AForm: TForm = nil; AAddToLog: TAddToLog = nil); overload;
    //constructor Create(AConfigNode: IXmlNode = nil; AForm: TForm = nil; AAddToLog: TAddToLog = nil); overload;
    constructor Create(AConfigDocument: TConfigDocument = nil; ANodeName: WideString = ''; AForm: TForm = nil; AAddToLog: TAddToLog = nil); overload;
    constructor Create(AConfigNode: TConfigNode1 = nil; AForm: TForm = nil; AAddToLog: TAddToLog = nil); overload;
  public
      //** Элемент конфигураций из которого загружать и сохранять
    //property ConfigNode: IProfNode read FConfigNode write FConfigNode;
      //** Элемент конфигураций из которого загружать и сохранять
    //property ConfigNode: TConfigNode1 read FConfigNode write FConfigNode;
      //** Элемент конфигураций из которого загружать и сохранять
    //property ConfigNodeXml: IXmlNode read FConfigNodeXml write FConfigNodeXml;
      //** Форма
    property Form: TForm read FForm write FForm;
  end;

resourcestring // Сообщения ----------------------------------------------------
  stLoadOk = 'Конфигурации загружены';
  stSaveOk = 'Конфигурации созранены';

{** Load from form }
function AConfig_PullFromForm(Config: AConfig; Form: TForm): AError;
{** Load from form }
function AConfig_PullFromForm1(AConfig: TConfigNode1; AForm: TForm): WordBool;
{** Load from form }
function AConfig_PullFromForm2(AConfig: IProfNode; AForm: TForm): WordBool;
{** Load from form }
function AConfig_PullFromForm3(AConfig: IXmlNode; AForm: TForm): WordBool;
{** Save to form }
function AConfig_PushToForm(Config: AConfig; Form: TForm): AError;
{** Save to form }
function AConfig_PushToForm1(AConfig: TConfigNode1; AForm: TForm): WordBool;
{** Save to form }
function AConfig_PushToForm2(AConfig: IProfNode; AForm: TForm): WordBool;
{** Save to form }
function AConfig_PushToForm3(AConfig: IXmlNode; AForm: TForm): WordBool;

function ConfigFromForm(AConfig: IProfNode; AForm: TForm): WordBool;
function ConfigToForm(AConfig: IProfNode; AForm: TForm): WordBool;
function XmlToFormConfig(const AXml: WideString; AForm: TForm): WordBool;
function XmlFromFormConfig(var AXml: WideString; AForm: TForm): WordBool;

implementation

// --- AConfig ---

function AConfig_PullFromForm(Config: AConfig; Form: TForm): AError;
begin
  if (TObject(Config) is TConfigNode1) then
  begin
    if AConfig_PullFromForm1(TConfigNode1(Config), Form) then
      Result := 0
    else
      Result := -3;
  end
  else
    Result := -2;
end;

function AConfig_PullFromForm1(AConfig: TConfigNode1; AForm: TForm): WordBool;
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

function AConfig_PullFromForm2(AConfig: IProfNode; AForm: TForm): WordBool;
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
  Result := False;
end;

function AConfig_PullFromForm3(AConfig: IXmlNode; AForm: TForm): WordBool;
begin
  try
    Result := Assigned(AForm) and Assigned(AConfig);
    if not(Result) then Exit;
    if (AForm.WindowState <> wsMaximized) then
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

function AConfig_PushToForm(Config: AConfig; Form: TForm): AError;
begin
  if (TObject(Config) is TConfigNode1) then
  begin
    if AConfig_PushToForm1(TConfigNode1(Config), Form) then
      Result := 0
    else
      Result := -3;
  end
  else
    Result := -2;
end;

function AConfig_PushToForm1(AConfig: TConfigNode1; AForm: TForm): WordBool;
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

function AConfig_PushToForm2(AConfig: IProfNode; AForm: TForm): WordBool;
{var
  I: Integer;
  S: WideString;}
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
  Result := False;
end;

function AConfig_PushToForm3(AConfig: IXmlNode; AForm: TForm): WordBool;
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

// --- Old ---

function ConfigFromForm(AConfig: IProfNode; AForm: TForm): WordBool;
begin
  Result := AConfig_PullFromForm2(AConfig, AForm);
end;

function ConfigToForm(AConfig: IProfNode; AForm: TForm): WordBool;
begin
  Result := AConfig_PushToForm2(AConfig, AForm);
end;

function XmlFromFormConfig(var AXml: WideString; AForm: TForm): WordBool;
var
  c: TConfigDocument;
begin
  C := TConfigDocument.Create();
  try
    C.CreateDocument();
    Result := (AConfig_PullFromForm(C.DocumentElement, AForm) >= 0);
    AXml := AXmlNode_GetXml(C.DocumentElement);
  finally
    C.Free();
  end;
end;
(*function XmlFromFormConfig(var AXml: WideString; AForm: TForm): WordBool;
//var
//  c: IXmlDocument;
begin
  Result := False;
  {c := IProfXmlDocument.Create();
  Result := ConfigFromForm(c.DocumentElement, AForm);
  AXml := c.DocumentElement.Xml;
  c.Free();}
end;*)

function XmlToFormConfig(const AXml: WideString; AForm: TForm): WordBool;
var
  C: TConfigDocument;
begin
  C := TConfigDocument.Create();
  AXmlNode_SetXml(C.DocumentElement, AXml);
  Result := (AConfig_PushToForm(C.DocumentElement, AForm) >= 0);
  C.Free();
end;
(*function XmlToFormConfig(const AXml: WideString; AForm: TForm): WordBool;
//var
//  c: TConfigDocument;
begin
  Result := False;
  {c := TConfigDocument.Create();
  c.DocumentElement.Xml := AXml;
  Result := ConfigToForm(c.DocumentElement, AForm);
  c.Free();}
end;*)

{ TConfigForm }

function TConfigForm.ConfigureLoad(): WordBool;
begin
  {if Assigned(FConfigNode) then
    Result := ConfigToForm(FConfigNode, FForm)
  else}
    Result := (AConfig_PullFromForm(FConfig, FForm) >= 0);
end;

function TConfigForm.ConfigureSave(): WordBool;
begin
  {if Assigned(FConfigNode) then
    Result := ConfigFromForm(FConfigNode, FForm)
  else}
    Result := (AConfig_PushToForm(FConfig, FForm) >= 0);
end;

constructor TConfigForm.Create(AConfigDocument: TConfigDocument; ANodeName: WideString;
    AForm: TForm; AAddToLog: TAddToLog);
begin
  inherited Create();
  FConfig := AXmlNode_GetChildNodeByName(AConfigDocument.DocumentElement, ANodeName);
  FForm := AForm;
end;
{constructor TConfigForm.Create(AConfigDocument: IXmlDocument = nil; ANodeName: WideString = ''; AForm: TForm = nil; AAddToLog: TAddToLog = nil);
begin
  inherited Create();
  FConfigNode := TProfXmlNode.GetNodeByNameA(AConfigDocument.DocumentElement, ANodeName);
  FForm := AForm;
end;}

constructor TConfigForm.Create(AConfigNode: TConfigNode1; AForm: TForm; AAddToLog: TAddToLog);
begin
  inherited Create();
  FConfig := AConfig(AConfigNode);
  FForm := AForm;
end;
{constructor TConfigForm.Create(AConfigNode: IXmlNode = nil; AForm: TForm = nil; AAddToLog: TAddToLog = nil);
begin
  inherited Create();
  FConfigNode := AConfigNode;
  FForm := AForm;
end;}

end.
