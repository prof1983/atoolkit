{**
@Abstract Функции работы с видео
@Author Prof1983 <prof1983@ya.ru>
@Created 31.03.2006
@LastMod 19.12.2012

Канал(Chanel) - приемник видеоизображения с видеоисточника
Видеоисточник(Source) - любой источник видео сигналов, картинок
}
unit AVideoGlobals;

interface

uses
  ActiveX, Classes, Graphics, SyncObjs, SysUtils, Windows,
  ABase, AConfig2007, AConfigUtils, AConsts2, AEventObj, ALogObj;

type
  TPictureEventProc = procedure(AChanelNum: Integer; ABitmap: Graphics.TBitmap) of object;

{type // Запись для канала ------------------------------------------------------
  TChanelRec = record
    Enabled: Boolean;   // Включено
    NumCamera: Integer; // Номер камеры
    Save: Boolean;      // Сохранять
    Source: Integer;    // Видеоисточник
  end;}

type
  //IVideoCamera = interface;
  IVideoChanel = interface;
  IVideoSource = interface;

  {// Интерфейс для видеокамеры -------------------------------------------------
  IVideoCamera = interface
    function GetEnabled(): WordBool;
    procedure SetEnabled(Value: WordBool);
    function GetNumCamera(): Integer;
    procedure SetNumCamera(Value: Integer);
    // Видеоканал включен
    property Enabled: WordBool read GetEnabled write SetEnabled;
    // Номер камеры
    property NumCamera: Integer read GetNumCamera write SetNumCamera;
  end;}

  // Интерфейс видеоканала -----------------------------------------------------
  IVideoChanel = interface
    function GetEnabled(): WordBool;
    function GetNumCamera(): Integer;
    function GetSource(): IVideoSource;
    procedure SetEnabled(Value: WordBool);
    procedure SetNumCamera(Value: Integer);
    procedure SetSource(Value: IVideoSource);
    // Видеоканал включен
    property Enabled: WordBool read GetEnabled write SetEnabled;
    // Номер камеры
    property NumCamera: Integer read GetNumCamera write SetNumCamera;
    // Видеоисточник
    property Source: IVideoSource read GetSource write SetSource;
  end;

  // Интерфейс видеоисточника --------------------------------------------------
  IVideoSource = interface
    // Загрузить конфигурации
    function ConfigureLoad(Config: AConfig): AError;
    // Сохранить конфигурации
    function ConfigureSave(Config: AConfig): AError;
    // Получить BitMap последней захваченой картинки. Должно выполняться после GetPicture, когда IsReceived=True
    function GetBitmap(): Graphics.TBitmap;
    // Получить канал
    function GetChanel(Index: Integer): IVideoChanel;
    // Получить колличество каналов видеоисточника
    function GetChanelCount(): Integer;
    function GetID(): Integer;
    // Получить информацию о видеоисточнике в виде строки
    function GetInfo(): WideString;
    // Картинка получена по запросу
    function GetIsReceived(): WordBool;
    // Название видеоисточника
    function GetName(): WideString;
    // Запрос на получение картинки с камеры NumCamera [0..3]
    function GetPicture(NumCamera: Integer): WordBool;
    procedure SetID(Value: Integer);

    function Connect(): WordBool;
    procedure Disconnect();
    function Reconnect(): WordBool;

    // Колличество каналов
    property ChanelCount: Integer read GetChanelCount;
    // Видеоканалы
    property Chanels[Index: Integer]: IVideoChanel read GetChanel;
    // ID видеоисточника
    property ID: Integer read GetID write SetID;
    // Информация о видеоисточнике в виде строки с переносами
    property Info: WideString read GetInfo;
    // Картинка получена (после запроса GetPicture)
    property IsReceived: WordBool read GetIsReceived;
    // Название видеоисточника
    property Name: WideString read GetName;
    // Если SaveNow=True - Сохранить текущую картинку в файл. SaveNow=False - Сохранить в файл после получения картинки
    function SavePicture(const FileName: WideString; NumCamera: Integer = 0; SaveNow: WordBool = False): WordBool;
  end;

type // ------------------------------------------------------------------------
  TEventPicture = class(TAEvent)
  private
    FList: array of TPictureEventProc;
  public
    function Connect(Proc: TPictureEventProc): WordBool;
    function Disconnect(Proc: TPictureEventProc): WordBool;
    procedure Run(AChanelNum: Integer; ABitmap: Graphics.TBitmap);
  end;

type // Настройки видео канала
  TSetupVideoChanel = class //(TSetupRecItem)
  private
    FEnabled: Boolean;
    FNumCamera: Integer;
    FSave: Boolean;
    FSource: Integer;
  public
    procedure Assign(AChanel: TSetupVideoChanel);
  public
    property Enabled: Boolean read FEnabled write FEnabled;
    property NumCamera: Integer read FNumCamera write FNumCamera;
    property Save: Boolean read FSave write FSave;
    property Source: Integer read FSource write FSource;
  end;

type
  TVideoChanel = class
  private
    FEnabled: Boolean;      // Канал включен
    FIndex: Integer;        // Индекс
    FNumCamera: Integer;    // Номер камеры
    FSave: Boolean;         // Сохранять изображения
    FSource: IVideoSource;  // Видеоисточник
    FSource_Index: Integer; // Индекс источника видеосигнала
    FVisible: Boolean;      // Показывать этот канал
  public
    //property ChanelRec: TChanelRec read GetChanelRec write SetChanelRec;
    property Enabled: Boolean read FEnabled write FEnabled;
    property Index: Integer read FIndex write FIndex;
    property NumCamera: Integer read FNumCamera write FNumCamera;
    property Save: Boolean read FSave write FSave;
    property Source: IVideoSource read FSource write FSource;
    property Source_Index: Integer read FSource_Index write FSource_Index;
    property Visible: Boolean read FVisible write FVisible;
  end;

type // Подпроцесс чтения картинок из видеоисточника ---------------------------
  TVideoThread = class(TThread)
  private
    FBitmap: Graphics.TBitmap;
    FChanelNum: Integer;
    FCritical: TCriticalSection;
    FErrorCount: Integer;
    FMaxErrorCount: Integer;
    FMaxTimeout: Integer;
    FOnPicture: TEventPicture;
    FVideoSource: IVideoSource;
    tmpChanelNum: Integer;      // Временная переменная для вызова события обновления картинок
    procedure DoPicture();
    procedure SetChanelNum(Value: Integer);
    procedure SetVideoSource(Value: IVideoSource);
  protected
    procedure Execute(); override;
  public
    constructor Create(AIsStoped: Boolean);
    procedure Free();
    procedure Start();
    procedure Stop();
  public
    // Номер канала видеоисточника с которого читать картинки или -1, если требуется читать со всех каналов по порядку.
    property ChanelNum: Integer read FChanelNum write SetChanelNum;
    // Колличество ошибок от последней принятой картинки
    property ErrorCount: Integer read FErrorCount;
    // Максимальное колличество ошибок до переприсоединения
    property MaxErrorCount: Integer read FMaxErrorCount write FMaxErrorCount;
    // Максимальное время ожидания картинки
    property MaxTimeout: Integer read FMaxTimeout write FMaxTimeout;
    property OnPicture: TEventPicture read FOnPicture;
    // Видеоисточник
    property VideoSource: IVideoSource read FVideoSource write SetVideoSource;
  end;

type // Видеоисточник (шаблон)
  TVideoSource = class(TInterfacedObject, IVideoSource)
  private
    FID: Integer;
  protected
    FIsReceived: WordBool;
    FName: WideString;
    FOnPicture: TEventPicture;
    function GetBitmap(): Graphics.TBitmap; virtual;
    function GetChanel(Index: Integer): IVideoChanel; virtual;
    function GetChanelCount(): Integer; virtual;
    function GetID(): Integer;
    function GetInfo(): WideString; virtual;
    function GetIsReceived(): WordBool; virtual;
    function GetName(): WideString; virtual;
    function GetPicture(ANumCamera: Integer): WordBool; virtual;
    procedure SetID(Value: Integer);
  public
    function ConfigureLoad(Config: AConfig): AError; virtual;
    function ConfigureSave(Config: AConfig): AError; virtual;
    function Connect(): WordBool; virtual;
    procedure Disconnect(); virtual;
    function Reconnect(): WordBool; virtual;
    function SavePicture(const AFileName: WideString; ANumCamera: Integer = 0; ASaveNow: WordBool = False): WordBool; virtual;
  public
    constructor Create();
    procedure Free(); virtual;
  public
    property OnPicture: TEventPicture read FOnPicture;
  end;

type // Видеоисточники (Класс работы с подпроцессами чтения видеоизображений) --
  TVideoSources = class(TLoggerObject)
  private
    FChanels: array of TVideoChanel;
    FCritical: TCriticalSection;
    FOnPicture: TEventPicture;
    FSources: array of IVideoSource;
    FVideoThreads: array of TVideoThread;
    function GetChanel(Index: Integer): TVideoChanel;
    function GetChanelCount(): Integer;
    function GetSource(Index: Integer): IVideoSource;
    function GetSourceCount(): Integer;
    function GetVideoThread(Index: Integer): TVideoThread;
    function GetVideoThreadCount(): Integer;
    procedure SetChanelCount(Value: Integer);
    procedure SetChanel(Index: Integer; Value: TVideoChanel);
  protected
    function GetBitmap(Chanel: Integer): Graphics.TBitmap; virtual;
  public
    // Добавить видеоканал
    function AddChanel(AChanel: TVideoChanel): Integer;
    // Добавить источник
    function AddSource(ASource: IVideoSource): Integer;
    // Удаление всех видеоисточников и подпроцессов
    procedure Clear();
    function ConfigureSave(Config: AConfig): AError;
    // Возвращает информацию об видеоисточниках и видеоканалах в виде строки с переносами
    function GetInfo(): WideString;
    function NewChanel(): TVideoChanel;
    procedure Start();
    procedure Stop();
  public
    constructor Create();
    procedure Free();
  public
    // Возвращает картинку, если это возможно. Иначе nil
    property Bitmap[Chanel: Integer]: Graphics.TBitmap read GetBitmap;
    // Номер канала (только по этому каналу будут запрашиваться изображения)
    // 04.08.2006
    //property ChanelNum: Integer read GetChanelNum write SetChanelNum;
    // Колличество каналов
    property ChanelCount: Integer read GetChanelCount write SetChanelCount;
    // Видеоканалы
    property Chanels[Index: Integer]: TVideoChanel read GetChanel write SetChanel;
    property OnPicture: TEventPicture read FOnPicture;
    // Колличество видеоисточников
    property SourceCount: Integer read GetSourceCount;
    // Видеоисточники
    property Sources[Index: Integer]: IVideoSource read GetSource;
    // Колличество подпроцессов работы с видеоисточниками
    property VideoThreadCount: Integer read GetVideoThreadCount;
    // Подпроцессы работы с видеосточниками
    property VideoThreads[Index: Integer]: TVideoThread read GetVideoThread;
  end;

implementation

{ TEventPicture }

function TEventPicture.Connect(Proc: TPictureEventProc): WordBool;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to High(FList) do
    if Addr(Proc) = Addr(FList[I]) then
      Exit;

  I := Length(FList);
  SetLength(FList, I + 1);
  FList[I] := Proc;
end;

function TEventPicture.Disconnect(Proc: TPictureEventProc): WordBool;
var
  I: Integer;
  I2: Integer;
begin
  Result := False;
  for I := 0 to High(FList) do
    if Addr(FList[I]) = Addr(Proc) then
    begin
      for I2 := I to High(FList) - 1 do
        FList[I] := FList[I + 1];
      SetLength(FList, High(FList));
      Result := True;
      Exit;
    end;
end;

procedure TEventPicture.Run(AChanelNum: Integer; ABitmap: Graphics.TBitmap);
var
  I: Integer;
begin
  for I := 0 to High(FList) do
  try
    FList[I](AChanelNum, ABitmap);
  except
  end;
end;

{ TSetupVideoChanel }

procedure TSetupVideoChanel.Assign(AChanel: TSetupVideoChanel);
begin
  FEnabled := AChanel.Enabled;
  FNumCamera := AChanel.NumCamera;
  FSave := AChanel.Save;
  FSource := AChanel.Source;
end;

{ TVideoSource }

function TVideoSource.ConfigureLoad(Config: AConfig): AError;
begin
  if (Config = 0) then
  begin
    Result := -2;
    Exit;
  end;
  Result := 0;
end;

function TVideoSource.ConfigureSave(Config: AConfig): AError;
begin
  if (Config = 0) then
  begin
    Result := -2;
    Exit;
  end;
  Result := 0;
end;

function TVideoSource.Connect(): WordBool;
begin
  Result := False;
end;

constructor TVideoSource.Create();
begin
  inherited Create();
  FOnPicture := TEventPicture.Create(0, 'OnPicture');
end;

procedure TVideoSource.Disconnect();
begin
end;

procedure TVideoSource.Free();
begin
  FOnPicture.Free();
end;

function TVideoSource.GetBitmap(): Graphics.TBitmap;
begin
  Result := nil;
end;

function TVideoSource.GetChanel(Index: Integer): IVideoChanel;
begin
  Result := nil;
end;

function TVideoSource.GetChanelCount(): Integer;
begin
  Result := 0;
end;

function TVideoSource.GetInfo(): WideString;
begin
  Result := '';
end;

function TVideoSource.GetID(): Integer;
begin
  Result := FID;
end;

function TVideoSource.GetIsReceived(): WordBool;
begin
  Result := FIsReceived;
end;

function TVideoSource.GetName(): WideString;
begin
  Result := FName;
end;

function TVideoSource.GetPicture(ANumCamera: Integer): WordBool;
begin
  Result := False;
end;

function TVideoSource.Reconnect(): WordBool;
begin
  Disconnect();
  Result := Connect;
end;

function TVideoSource.SavePicture(const AFileName: WideString; ANumCamera: Integer; ASaveNow: WordBool): WordBool;
begin
  Result := False;
end;

procedure TVideoSource.SetID(Value: Integer);
begin
  FID := Value;
end;

{ TVideoSources }

function TVideoSources.AddChanel(AChanel: TVideoChanel): Integer;
begin
  Result := Length(FChanels);
  SetLength(FChanels, Result + 1);
  FChanels[Result] := AChanel;
end;

function TVideoSources.AddSource(ASource: IVideoSource): Integer;
begin
  FCritical.Enter();
  Result := Length(FSources);
  SetLength(FSources, Result + 1);
  FSources[Result] := ASource;
  // Присоединяемся к получению событий
  //FSources[Result].OnPicture.Connect(
  FCritical.Release();
end;

procedure TVideoSources.Clear();
var
  I: Integer;
begin
  FCritical.Enter();
  // Удаление всех подпроцессов
  for I := 0 to High(FVideoThreads) do
  try
    FVideoThreads[I].Stop();
    FVideoThreads[I].WaitFor();
    FVideoThreads[I].Free();
  except
  end;
  SetLength(FVideoThreads, 0);

  // Удаление всех видеоисточников
  for I := 0 to High(FSources) do
  try
    //FSources[I].Free();
  finally
    FSources[I] := nil;
  end;
  SetLength(FSources, 0);
  FCritical.Release();
end;

function TVideoSources.ConfigureSave(Config: AConfig): AError;
var
  I: Integer;
  Node: AConfig;
  nChanel: AConfig;
  C: TVideoChanel;
begin
  if (Config = 0) then
  begin
    Result := -2;
    Exit;
  end;

  FCritical.Enter();
  Node := AConfig_GetChildNodeByName(Config, 'Chanels');
  for I := 0 to High(FChanels) do
  begin
    c := FChanels[I];
    //unConfig.SaveObjectToConfig(Node.GetNodeByName('Chanel'+IntToStr(I)), FChanels[I], nil);
    NChanel := AConfig_GetChildNodeByName(Node, 'Chanel'+IntToStr(I));
    AConfig_WriteBool(nChanel, 'Enabled', C.Enabled);
    AConfig_WriteInt32(nChanel, 'NumCamera', C.NumCamera);
    AConfig_WriteBool(nChanel, 'Save', C.Save);
    AConfig_WriteInt32(nChanel, 'Source', C.Source.Id);
    AConfig_WriteBool(nChanel, 'Visible', C.Visible);
  end;
  FCritical.Release();

  Node := AConfig_GetChildNodeByName(Config, 'Sources');
  for I := 0 to High(FSources) do
    FSources[I].ConfigureSave(AConfig_GetChildNodeByName(Node, 'Source'+IntToStr(I)));
  Result := 0;
end;

constructor TVideoSources.Create();
begin
  inherited Create();
  FCritical := TCriticalSection.Create();
  FOnPicture := TEventPicture.Create(0, 'OnPicture');
end;

procedure TVideoSources.Free();
begin
  if Assigned(FOnPicture) then
  try
    FOnPicture.Free();
  finally
    FOnPicture := nil;
  end;

  if Assigned(FCritical) then
  try
    FCritical.Free();
  finally
    FCritical := nil;
  end;

  inherited Free();
end;

function TVideoSources.GetBitmap(Chanel: Integer): Graphics.TBitmap;
var
  C: TVideoChanel;
  S: IVideoSource;
  //V: TVideoClient;
begin
  Result := nil;
  if (Chanel < 0) or (Chanel >= ChanelCount) then Exit;
  C := Chanels[Chanel];
  //if not(Assigned(C)) then Exit;
  if not(C.Enabled) then Exit;
  S := C.Source; //Sources[C.Source];
  if not(Assigned(S)) then Exit;

  Result := S.GetBitmap();

  {if Assigned(FClient) then
  begin
    Result := FClient.BitMap;
    FClient.GetPicture(Chanel);
  end;}

  {if (S is TVideoClient) then
  begin
    V := (S as TVideoClient);
    Result := V.Bitmap;
  end;}
end;

function TVideoSources.GetChanel(Index: Integer): TVideoChanel;
begin
  if (Index >= 0) and (Index < Length(FChanels)) then
    Result := FChanels[Index]
  else
    Result := nil;
end;

function TVideoSources.GetChanelCount(): Integer;
begin
  //Result := Settings.VideoChanels.Count;
  Result := Length(FChanels);
end;

function TVideoSources.GetInfo(): WideString;

  {function GetSourceName(Index: Integer): WideString;
  begin
    if (Index >= 0) and (Index < Length(FSources)) then
      Result := FSources[Index].Name
    else
      Result := '<uncnown>';
  end;}

var
  i: Integer;
begin
  FCritical.Enter();
  Result := '=========================================='+
    #13#10'  Информация о видеоисточниках ('+IntToStr(Length(FSources))+')'+
    #13#10'==========================================';
    for i := 0 to High(FSources) do
    begin
      Result := Result + #13#10'  ' + {GetSourceName(i)} FSources[i].Name + ' (' + IntToStr(i) + ')'+
        #13#10'------------------------------------------'+
        #13#10+FSources[i].GetInfo();
      if i <> High(FSources) then
        Result := Result + #13#10'------------------------------------------';
    end;
    Result := Result + #13#10'=========================================='+
    #13#10'  Информация о видеоканалах ('+IntToStr(Length(FChanels))+')'+
    #13#10'==========================================';
    for i := 0 to High(FChanels) do
    begin
      Result := Result + '  Видеоканал ' + IntToStr(i) +
        #13#10'------------------------------------------'+
        #13#10'Enabled:    ' + STR_BOOL[FChanels[i].Enabled]+
        #13#10'NumCamera:  ' + IntToStr(FChanels[i].NumCamera)+
        #13#10'Save:       ' + STR_BOOL[FChanels[i].Save]+
        #13#10'Source:     ' + {GetSourceName(FChanels[i].Source)} FChanels[i].Source.Name + ' (' + IntToStr(FChanels[i].Source.ID) + ')';
      if i <> High(FChanels) then
        Result := Result + #13#10'------------------------------------------';
    end;
    Result := Result + #13#10'==========================================';
  FCritical.Release();
end;

function TVideoSources.GetSource(Index: Integer): IVideoSource;
begin
  if (Index >= 0) and (Index < Length(FSources)) then
    Result := FSources[Index]
  else
    Result := nil;
end;

function TVideoSources.GetSourceCount(): Integer;
begin
  Result := Length(FSources);
end;

function TVideoSources.GetVideoThread(Index: Integer): TVideoThread;
begin
  if (Index >= 0) and (Index < Length(FVideoThreads)) then
    Result := FVideoThreads[Index]
  else
    Result := nil;
end;

function TVideoSources.GetVideoThreadCount(): Integer;
begin
  Result := Length(FVideoThreads);
end;

function TVideoSources.NewChanel(): TVideoChanel;
begin
  Result := TVideoChanel.Create();
  AddChanel(Result);
end;

procedure TVideoSources.SetChanel(Index: Integer; Value: TVideoChanel);
begin
  try
    FChanels[Index] := Value;
  except
  end;
end;

procedure TVideoSources.SetChanelCount(Value: Integer);
var
  I: Integer;
  oldCount: Integer;
begin
  oldCount := Length(FChanels);
  if oldCount = Value then Exit;
  if oldCount > Value then
  begin
    for I := Value to High(FChanels) do
      FChanels[I].Free();
    SetLength(FChanels, Value);
  end
  else
  begin
    SetLength(FChanels, Value);
    for I := oldCount to High(FChanels) do
      FChanels[I] := TVideoChanel.Create();
  end;

  //SetLength(FChanels, Value);
end;

procedure TVideoSources.Start();
var
  I: Integer;
begin
  for I := 0 to High(FVideoThreads) do
    FVideoThreads[I].Start();
end;

procedure TVideoSources.Stop();
var
  I: Integer;
begin
  for I := 0 to High(FVideoThreads) do
    FVideoThreads[I].Stop();
end;

{ TVideoThread }

constructor TVideoThread.Create(AIsStoped: Boolean);
begin
  inherited Create(AIsStoped);
  FMaxErrorCount := 30;
  FMaxTimeout := 250;
  FCritical := TCriticalSection.Create();
  FOnPicture := TEventPicture.Create();
end;

procedure TVideoThread.DoPicture();
begin
  FOnPicture.Run(tmpChanelNum, FBitmap);
end;

procedure TVideoThread.Execute();
var
  Res: Boolean;
  I: Integer;
begin
  if Assigned(FVideoSource) then
  repeat
    // Чтение картинок с видеоисточника -----------------
    // Запросить картинку
    if FChanelNum > 0 then
      tmpChanelNum := FChanelNum
    else
    begin
      Inc(tmpChanelNum);
      if tmpChanelNum >= FVideoSource.ChanelCount then
        tmpChanelNum := 0;
    end;

    FCritical.Enter();
    Res := FVideoSource.GetPicture(tmpChanelNum);
    FCritical.Release();

    if Res then
    begin
      Res := False;
      // Подождать пока придет картинка, но не более MaxTimeout
      for I := 0 to 15 do
      begin
        Sleep(FMaxTimeout div 16);
        if FVideoSource.IsReceived then
        begin
          Res := True;
          FCritical.Enter();
          FBitmap := FVideoSource.GetBitmap();
          FCritical.Release();
          // Вызываем событие обновления картинок
          Synchronize(DoPicture);
          FErrorCount := 0;
          Break;
        end;
      end;
      if not(Res) then
        Inc(FErrorCount);
    end
    else
    begin
      Sleep(100); // Подождать
      Inc(FErrorCount);
    end;

    if FErrorCount > FMaxErrorCount then
    begin
      // Переприсоединиться
      FCritical.Enter();
      FVideoSource.Reconnect();
      FCritical.Release();
    end;
  until Terminated;
end;

procedure TVideoThread.Free();
begin
  if Assigned(FOnPicture) then
  try
    FOnPicture.Free();
  finally
    FOnPicture := nil;
  end;
  if Assigned(FCritical) then
  try
    FCritical.Free();
  finally
    FCritical := nil;
  end;
  inherited Free();
end;

procedure TVideoThread.SetChanelNum(Value: Integer);
begin
  FCritical.Enter();
  FChanelNum := Value;
  FCritical.Release()
end;

procedure TVideoThread.SetVideoSource(Value: IVideoSource);
var
  oldIsStoped: Boolean;
begin
  oldIsStoped := Self.Suspended;
  // Останавливаем процесс
  Self.Terminate();
  Self.WaitFor();
  FVideoSource := Value;
  // Запускаем процесс, если был запущен
  Self.Suspended := oldIsStoped;
end;

procedure TVideoThread.Start();
begin
  Self.Suspend();
end;

procedure TVideoThread.Stop();
begin
  Self.Terminate();
end;

end.
