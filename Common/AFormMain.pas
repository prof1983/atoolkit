{**
@Abstract Класс главной форма - оболочка для TForm
@Author Prof1983 <prof1983@ya.ru>
@Created 16.11.2005
@LastMod 04.02.2013
}
unit AFormMain;

interface

uses
  Classes, Forms, SysUtils, XmlIntf,
  ABase,
  AConsts2,
  AFormMainUtils,
  AFormObj,
  ALogDocumentListObj,
  ALogDocumentsAllUtils,
  ALogNodeUtils,
  AUiForm,
  ASystemData,
  ATypes,
  AXmlDocumentImpl, AXmlDocumentUtils, AXmlNodeUtils, AXmlUtils;

type
  TProfFormMain = class(TAFormObject)
  protected
    FIsConfigDocumentInit: Boolean; // ConfigDocument инициализирован в этом объекте
    FIsLogDocumentsInit: Boolean;   // LogDocuments инициализирован в этом объекте
    FLogID: Integer;
    FLogName: string;
    FLogTypeSet: TLogTypeSet;
  protected
    FLogDocuments: TALogDocumentListObject;
  public
      //** Финализация программы (конфигурации, логирование)
    function Finalize(): AError; override;
      //** Инициализация программы (конфигурации, логирование)
    procedure Init(); virtual;
      //** Initialize config
    procedure InitConfig(); virtual;
      //** Initialize log
    procedure InitLog(); virtual;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ALog: TALogDocumentListObject read FLogDocuments write FLogDocuments;
      //** ID программы для подключения к системе логирования
    property LogID: Integer read FLogID write FLogID;
      //** Имя программы для подключения к системе логирования
    property LogName: string read FLogName write FLogName;
      //** Устанавливаем в какие места выводить Log
    property LogTypeSet: TLogTypeSet read FLogTypeSet write FLogTypeSet;
  end;

implementation

// Function --------------------------------------------------------------------

function StrPosEnd(const St: WideString; C: WideChar): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := Length(St) downto 1 do if St[I] = C then begin Result := I; Exit; end;
end;

{ TProfFormMain }

constructor TProfFormMain.Create(AOwner: TComponent);
begin
  FLogID := 123;
  FLogName := ChangeFileExt(ExtractFileName(ParamStr(0)), '');
  inherited Create(AOwner);
  FIsConfigDocumentInit := False;
  FIsLogDocumentsInit := False;
end;

function TProfFormMain.Finalize(): AError;
begin
  if Assigned(FLogDocuments) then
  try
    FLogDocuments.Finalize();
  finally
    FLogDocuments := nil;
  end;

  AUiForm.Form_SaveConfig(Self, FConfig);

  Result := inherited Finalize();

  if FIsConfigDocumentInit and (FConfigDocument1 <> 0) then
  try
    if not(FileExists(FConfigFileName)) then
    begin
      ForceDirectories(ExtractFilePath(FConfigFileName));
    end;

    AXmlDocument_SaveToFileP(FConfigDocument1, FConfigFileName);
    FreeAndNil(FConfigDocument1);
  except
  end;
end;

procedure TProfFormMain.Init();
begin
  AFormMain_GetExePathP();
  InitConfig();
  AUiForm.Form_LoadConfig(Self, FConfig);
  InitLog();
end;

procedure TProfFormMain.InitConfig();
begin
  if (AFormMain_InitConfig(FConfigDocument1, FConfig) = 1) then
    FIsConfigDocumentInit := True;
  ASystemData.FConfig := FConfig;
end;

procedure TProfFormMain.InitLog();
begin
  if (AFormMain_InitLog(FLogTypeSet, FLogDocuments, FLog) = 1) then
    FIsLogDocumentsInit := True;
end;

end.
