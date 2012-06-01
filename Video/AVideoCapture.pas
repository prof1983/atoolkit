{**
@Abstract(Работа с видео изображением)
@Author(Prof1983 prof1983@ya.ru)
@Created(17.05.2005)
@LastMod(04.05.2012)
@Version(0.5)

Использует AVICAP32.DLL
Источник: http://www.sources.ru/delphi/graphics/capture_image_from_video.shtml
}
unit AVideoCapture;

interface

uses
  ActiveX, Graphics, Messages, SysUtils, Windows,
  AConfig2007, AConsts2, AVideoGlobals;

type // ------------------------------------------------------------------------
  PCAPTUREPARMS                   = ^TCAPTUREPARMS;
  TCAPTUREPARMS                   = record
      dwRequestMicroSecPerFrame   : DWORD ;   // Requested capture rate
      fMakeUserHitOKToCapture     : BOOL  ;   // Show "Hit OK to cap" dlg?
      wPercentDropForError        : UINT  ;   // Give error msg if > (10%)
      fYield                      : BOOL  ;   // Capture via background task?
      dwIndexSize                 : DWORD ;   // Max index size in frames (32K)
      wChunkGranularity           : UINT  ;   // Junk chunk granularity (2K)
      fUsingDOSMemory             : BOOL  ;   // Use DOS buffers?
      wNumVideoRequested          : UINT  ;   // # video buffers, If 0, autocalc
      fCaptureAudio               : BOOL  ;   // Capture audio?
      wNumAudioRequested          : UINT  ;   // # audio buffers, If 0, autocalc
      vKeyAbort                   : UINT  ;   // Virtual key causing abort
      fAbortLeftMouse             : BOOL  ;   // Abort on left mouse?
      fAbortRightMouse            : BOOL  ;   // Abort on right mouse?
      fLimitEnabled               : BOOL  ;   // Use wTimeLimit?
      wTimeLimit                  : UINT  ;   // Seconds to capture
      fMCIControl                 : BOOL  ;   // Use MCI video source?
      fStepMCIDevice              : BOOL  ;   // Step MCI device?
      dwMCIStartTime              : DWORD ;   // Time to start in MS
      dwMCIStopTime               : DWORD ;   // Time to stop in MS
      fStepCaptureAt2x            : BOOL  ;   // Perform spatial averaging 2x
      wStepCaptureAverageFrames   : UINT  ;   // Temporal average n Frames
      dwAudioBufferSize           : DWORD ;   // Size of audio bufs (0 = default)
      fDisableWriteCache          : BOOL  ;   // Attempt to disable write cache
      AVStreamMaster              : UINT  ;   // Which stream controls length?
  end;

type
  TCaptureParams = TCAPTUREPARMS;

{type // ------------------------------------------------------------------------
  TCapture = class
  private
    FHandle: Integer;
  public
    function EditCopy: Boolean;
    function Sequence: Boolean;
    function SequenceNoFile: Boolean;
  end;}

{type // ------------------------------------------------------------------------
  TVideoSource1 = class(TInterfacedObject, IVideoSource)
  private
    VideoFormat: pBitmapInfo;
    hWndC: THandle;
    FIndexDevice: Integer;
    // Hanlde вызывающей формы
    FOwnerHandle: Integer;
  protected
    function GetIsReceived(): Boolean;
    function GetName: string;
  public
    // Вывести диалог выбора видеоисточника
    procedure ChangeVideoSource();
    // Присоединиться к видеоисточнику
    procedure Connect();
    constructor Create(AOwnerHandle: Integer);
    // Поместить картинку в буфер обмена
    procedure EditCopy();
    procedure Free();
    // Послать запрос на получение картинки
    function GetPicture(NumCamera: Integer): Boolean;
    // Получить высоту изображения
    function GetWidth: Integer;
    // Номер устройства
    property IndexDevice: Integer read FIndexDevice write FIndexDevice;
    procedure PreviewScale();
    // Изменить размер и расположение
    function Resize(Left, Top, Width, Height: Integer): Boolean;
    // Установить размер
    procedure SetSize(Width, Height: Integer);
  end;}

type // Класс для получения видеопотока из видео драйвера ----------------------
  TVideoSourceCapture = class(TVideoSource) //(TInterfacedObject, IVideoSource)
  private
    VideoFormat: pBitmapInfo;
    hWndC: THandle;
    FIndexDevice: Integer;
    // Hanlde вызывающей формы
    FOwnerHandle: Integer;
  private
    FCapturingAvi: Boolean;
    FHandle: Integer;
  protected
    function GetBitmap(): Graphics.TBitmap; override;
    function GetChanel(Index: Integer): IVideoChanel; override;
    function GetChanelCount(): Integer; override;
    function GetInfo(): WideString; override;
    function GetIsReceived(): WordBool; override;
    function GetName(): WideString; override;
  public
    // Вывести диалог выбора видеоисточника
    procedure ChangeVideoSource();
    function ConfigureLoad(AConfig: TConfigNode1): WordBool; override;
    function ConfigureSave(AConfig: TConfigNode1): WordBool; override;
    // Присоединиться к видеоисточнику
    function Connect(): WordBool; override;
    constructor Create(AOwnerHandle: Integer);
    procedure Disconnect(); override;
    // Поместить картинку в буфер обмена
    procedure EditCopy();
    procedure Free(); override;
    // Послать запрос на получение картинки
    function GetPicture(NumCamera: Integer): WordBool; override;
    // Получить высоту изображения
    function GetWidth(): Integer;
    // Номер устройства
    property IndexDevice: Integer read FIndexDevice write FIndexDevice;
    function Reconnect(): WordBool; override;
    procedure PreviewScale();
    // Изменить размер и расположение
    function Resize(Left, Top, Width, Height: Integer): Boolean;
    // Установить размер
    procedure SetSize(Width, Height: Integer);
  public
    function Abort(): Boolean;
    function Close(): Boolean;
    function Finalize(): WordBool;
    function GetCapturingAvi(): Boolean;
    function GetSetup(var Params: TCaptureParams): Boolean;
    function GrabFrame(): Boolean;
    function Initialize(): WordBool;
    function SaveBmp(FileName: WideString): Boolean;
    function SavePicture(const FileName: WideString; NumCamera: Integer = 0; SaveNow: WordBool = False): WordBool; override;
    function StartAvi(FileName: WideString): Boolean;
    function StopAvi(): Boolean;
    function ToWindow(Handle, Left, Top, Width, Height: Integer): Integer;
  end;

function capCreateCaptureWindowA(
  lpszWindowName: PChar;
  dwStyle: LongWord;
  x: Integer;
  y: Integer;
  nWidth: Integer;
  nHeight: Integer;
  ParentWin: THandle;
  nId: Integer
  ): THandle; stdcall;

implementation

// Constants -------------------------------------------------------------------

const WM_CAP_START                  = WM_USER;
const WM_CAP_STOP                   = WM_CAP_START + 68;
const WM_CAP_DRIVER_CONNECT         = WM_CAP_START + 10;
const WM_CAP_DRIVER_DISCONNECT      = WM_CAP_START + 11;
const WM_CAP_SAVEDIB                = WM_CAP_START + 25;
const WM_CAP_GRAB_FRAME             = WM_CAP_START + 60;
const WM_CAP_SEQUENCE               = WM_CAP_START + 62;
const WM_CAP_FILE_SET_CAPTURE_FILEA = WM_CAP_START + 20;
const WM_CAP_GET_VIDEOFORMAT        = WM_CAP_START + 44;
const WM_CAP_SET_VIDEOFORMAT        = WM_CAP_START + 45;
const WM_CAP_SET_SCALE              = WM_CAP_START + 53;
const WM_CAP_DLG_VIDEOSOURCE        = WM_CAP_START + 42;
const WM_CAP_SET_MCI_DEVICE         = WM_CAP_START + 66;
const WM_CAP_GET_MCI_DEVICE         = WM_CAP_START + 67;
const WM_CAP_EDIT_COPY              = WM_CAP_START + 30;

{
#define WM_CAP_SET_MCI_DEVICEW         (WM_CAP_UNICODE_START+  66)
#define WM_CAP_GET_MCI_DEVICEW         (WM_CAP_UNICODE_START+  67)
#ifdef UNICODE
#define WM_CAP_SET_MCI_DEVICE           WM_CAP_SET_MCI_DEVICEW
#define WM_CAP_GET_MCI_DEVICE           WM_CAP_GET_MCI_DEVICEW
 ((BOOL)AVICapSM(hwnd, WM_CAP_GET_MCI_DEVICE, (WPARAM)(wSize), (LPARAM)(LPVOID)(LPTSTR)(szName)))}

{640 x 480

    biSize: 40;
    biWidth: 640;
    biHeight: 480;
    biPlanes: 1;
    biBitCount: 16;
    biCompression: 0;
    biSizeImage: 614400=640*480*2;
    biXPelsPerMeter: 0;
    biYPelsPerMeter: 0;
    biClrUsed: 0;
    biClrImportant: 0;

    rgbBlue: 11;
    rgbGreen: 0;
    rgbRed: 0;
    rgbReserved: 0;   }
{ Использовано из заголовочного файла С++ или С Vfw.h
define AVICapSM(hwnd,m,w,l) ( (::IsWindow(hwnd)) ? ::SendMessage(hwnd,m,w,l) : 0)
#define capGetVideoFormat(hwnd, s, wSize)          ((DWORD)AVICapSM(hwnd, WM_CAP_GET_VIDEOFORMAT, (WPARAM)(wSize), (LPARAM)(LPVOID)(s)))
#define capGetVideoFormatSize(hwnd)            ((DWORD)AVICapSM(hwnd, WM_CAP_GET_VIDEOFORMAT, 0, 0L))
#define WM_CAP_SET_SCALE                (WM_CAP_START+  53)
{#define capPreviewScale(hwnd, f)                   ((BOOL)AVICapSM(hwnd, WM_CAP_SET_SCALE, (WPARAM)(BOOL)f, 0L))}

// External functions ----------------------------------------------------------

function capCreateCaptureWindowA(
  lpszWindowName: PChar;
  dwStyle: LongWord;
  x: Integer;
  y: Integer;
  nWidth: Integer;
  nHeight: Integer;
  ParentWin: THandle;
  nId: Integer
  ): THandle; stdcall; external 'AVICAP32.DLL';

{function capCreateCaptureWindowA(lpszWindowName: PCHAR;
                                 dwStyle: longint;
                                 x: integer;
                                 y: integer;
                                 nWidth: integer;
                                 nHeight: integer;
                                 ParentWin: HWND;
                                 nId: integer): HWND;
                                 STDCALL EXTERNAL 'AVICAP32.DLL';


function capGetVideoFormat(hWndC: HWND;
                           var VideoFormat: pBitmapInfo;
                           wSize: integer): bool;

function capSetVideoFormat(hWndC: HWND;
                           var VideoFormat: pBitmapInfo;
                           wSize: integer): bool;

function capGetVideoFormatSize(hWndC: HWND): DWord;

function capPreviewScale(hWndC: HWND;  Scale: Bool): Bool;

function capEditCopy(hWndC: HWND): Bool;}

// Functions -------------------------------------------------------------------

function capEditCopy(hWndC: HWND): Bool;
begin
  SendMessage(hWndC, WM_CAP_EDIT_COPY, 0, 0);
  Result := True;
end;

function capPreviewScale(hWndC: HWND; Scale: Bool): Bool;
begin
  SendMessage(hWndC, WM_CAP_SET_SCALE, WPARAM(BOOL(Scale)), 0);
  Result := True;
end;

function capGetVideoFormat(hWndC: HWND; var VideoFormat: pBitmapInfo; wSize: integer): bool;
begin
  SendMessage(hWndC, WM_CAP_GET_VIDEOFORMAT, WPARAM(wSize), LongInt(VideoFormat));
  Result := True;
end;

function capSetVideoFormat(hWndC: HWND; var VideoFormat: pBitmapInfo; wSize: integer): bool;
begin
  SendMessage(hWndC, WM_CAP_SET_VIDEOFORMAT, WPARAM(wSize),LongInt(VideoFormat));
  Result := True;
end;

function capGetVideoFormatSize(hWndC: HWND): DWord;
begin
  Result := SendMessage(HwndC,WM_CAP_GET_VIDEOFORMAT,0,0);
end;

{ TCapture }

(*
function TCapture.EditCopy: Boolean;
begin
  Result := capEditCopy(FHandle);
end;

function TCapture.Sequence: Boolean;
begin
  Result := False;
  {Result := SendMessage(FHandle, WM_CAP_SEQUENCE, 0, 0);}
  {Result := capCaptureSequence(FHandle);}
end;

function TCapture.SequenceNoFile: Boolean;
begin
  Result := False;
  {Result := SendMessage(FHandle, WM_CAP_SEQUENCE_NOFILE, 0, 0);}
  {Result := capCaptureSequenceNoFile(FHandle);}
end;*)

{ TVideoSourceCapture }

function TVideoSourceCapture.Abort(): Boolean;
begin
  {if FHandle > 0 then
    Result := capCaptureAbort(FHandle)
  else}
    Result := False;
end;

procedure TVideoSourceCapture.ChangeVideoSource();
begin
  if hWndC <> 0 then
    SendMessage(hWndC, WM_CAP_DLG_VIDEOSOURCE, 0, 0);
end;

function TVideoSourceCapture.Close(): Boolean;
begin
  if FHandle <> 0 then begin
    SendMessage(FHandle, WM_CAP_DRIVER_DISCONNECT, 0, 0);
    FHandle := 0;
  end;
  Result := True;
end;

function TVideoSourceCapture.ConfigureLoad(AConfig: TConfigNode1): WordBool;
begin
  Result := Assigned(AConfig);
  if not(Result) then Exit;
  // ...
end;

function TVideoSourceCapture.ConfigureSave(AConfig: TConfigNode1): WordBool;
begin
  Result := Assigned(AConfig);
  if not(Result) then Exit;
  // ...
end;

function TVideoSourceCapture.Connect(): WordBool;
begin
  Result := False;
  if (hWndC <> 0) then
  begin
    SendMessage(hWndC, WM_CAP_DRIVER_CONNECT, IndexDevice, 0);
    capGetVideoFormat(hWndC, VideoFormat, capGetVideoFormatSize(hWndC));
    Result := True;
  end;
end;

constructor TVideoSourceCapture.Create(AOwnerHandle: Integer);
begin
  inherited Create();
  FOwnerHandle := AOwnerHandle;
  New(VideoFormat);
end;

procedure TVideoSourceCapture.Disconnect();
begin
  if hWndC <> 0 then
  begin
    SendMessage(hWndC, WM_CAP_DRIVER_DISCONNECT, 0, 0);
    hWndC := 0;
  end;
end;

procedure TVideoSourceCapture.EditCopy();
begin
  if hWndC <> 0 then
    capEditCopy(hWndC);
end;

procedure TVideoSourceCapture.Free();
begin
  Disconnect();
  inherited Free();
end;

function TVideoSourceCapture.Finalize(): WordBool;
begin
  Result := Close;
end;

function TVideoSourceCapture.GrabFrame(): Boolean;
begin
  if FHandle <> 0 then
    SendMessage(FHandle, WM_CAP_GRAB_FRAME, 0, 0);
  Result := True;
end;

function TVideoSourceCapture.GetBitmap(): Graphics.TBitmap;
begin
  Result := nil;
  // ...
end;

function TVideoSourceCapture.GetChanel(Index: Integer): IVideoChanel;
begin
  Result := nil;
  // ...
end;

function TVideoSourceCapture.GetChanelCount(): Integer;
begin
  Result := 0;
  // ...
end;

function TVideoSourceCapture.GetCapturingAvi(): Boolean;
begin
  Result := FCapturingAvi;
end;

function TVideoSourceCapture.GetIsReceived(): WordBool;
begin
  Result := True;
end;

function TVideoSourceCapture.GetInfo(): WideString;
begin
  Result := 'CapturingAvi:    '+STR_BOOL[FCapturingAvi]+
    #13#10'Handle:          '+IntToStr(FHandle)+
    #13#10'IndexDevice:     '+IntToStr(FIndexDevice)+
    #13#10'OwnerHandle:     '+IntToStr(FOwnerHandle)+
    #13#10'hWndC:           '+IntToStr(hWndC)+
    #13#10'VideoFormat:     <videoformat>';
    {biSize: DWORD;
    biWidth: Longint;
    biHeight: Longint;
    biPlanes: Word;
    biBitCount: Word;
    biCompression: DWORD;
    biSizeImage: DWORD;
    biXPelsPerMeter: Longint;
    biYPelsPerMeter: Longint;
    biClrUsed: DWORD;
    biClrImportant: DWORD;}
end;

function TVideoSourceCapture.GetName(): WideString;
begin
  Result := 'Capture';
end;

function TVideoSourceCapture.GetPicture(NumCamera: Integer): WordBool;
begin
  Result := GrabFrame();
end;

function TVideoSourceCapture.GetSetup(var Params: TCaptureParams): Boolean;
begin
  {Result := False;}
  {SendMessage(FHandle, WM_CAP_GET_SEQUENCE_SETUP, SizeOf(TCaptureParams), P);}
  {if FHandle > 0 then
    Result := capGetSetup(FHandle, Params)
  else}
    Result := False;
end;

function TVideoSourceCapture.GetWidth(): Integer;
begin
  Result := 0;
  if Assigned(VideoFormat) then begin
    capGetVideoFormat(hWndC, VideoFormat, capGetVideoFormatSize(hWndC));
    Result := VideoFormat.bmiHeader.biWidth;
  end;
end;

function TVideoSourceCapture.Initialize: WordBool;
begin
  {Result := Open;}
  Result := True;
end;

procedure TVideoSourceCapture.PreviewScale();
begin
  if hWndC <> 0 then
    capPreviewScale(hWndC, True);
end;

function TVideoSourceCapture.Reconnect(): WordBool;
begin
  Disconnect();
  Result := Connect();
end;

function TVideoSourceCapture.Resize(Left, Top, Width, Height: Integer): Boolean;
begin
  if hWndC <> 0 then
  begin
    SendMessage(hWndC, WM_CAP_DRIVER_DISCONNECT, IndexDevice, 0);
  end;
  hWndC := 0;
  hWndC := capCreateCaptureWindowA('My Own Capture Window',
                                 WS_CHILD or WS_VISIBLE ,
                                 Left,
                                 Top,
                                 Width,
                                 Height,
                                 FOwnerHandle, 0);
  Result := (hWndC <> 0);
end;

function TVideoSourceCapture.SaveBmp(FileName: WideString): Boolean;
begin
  if FHandle <> 0 then
  begin
    SendMessage(
      FHandle,
      WM_CAP_SAVEDIB,
      0,
      LongInt(PChar(string(FileName))));
  end;
  Result := True;
end;

function TVideoSourceCapture.SavePicture(const FileName: WideString; NumCamera: Integer = 0; SaveNow: WordBool = False): WordBool;
begin
  Result := SaveBmp(FileName);
end;

procedure TVideoSourceCapture.SetSize(Width, Height: Integer);
begin
  VideoFormat.bmiHeader.biWidth := 640;
  VideoFormat.bmiHeader.biHeight := 480;
  VideoFormat.bmiHeader.biSizeImage := 2 * (VideoFormat.bmiHeader.biWidth) * (VideoFormat.bmiHeader.biHeight);
  capSetVideoFormat(hWndC, VideoFormat, capGetVideoFormatSize(hWndC));
end;

function TVideoSourceCapture.StartAvi(FileName: WideString): Boolean;
begin
  if FHandle <> 0 then
  begin
    FCapturingAvi := True;
    SendMessage(
      FHandle,
      WM_CAP_FILE_SET_CAPTURE_FILEA,
      0,
      LongInt(PChar(string(FileName))));
    SendMessage(FHandle, WM_CAP_SEQUENCE, 0, 0);
  end;
  Result := True;
end;

function TVideoSourceCapture.StopAvi(): Boolean;
begin
  if FHandle <> 0 then
  begin
    SendMessage(FHandle, WM_CAP_STOP, 0, 0);
    FCapturingAvi := False;
  end;
  Result := True;
end;

function TVideoSourceCapture.ToWindow(Handle, Left, Top, Width, Height: Integer): Integer;
begin
  Close();
  FHandle := capCreateCaptureWindowA(
    'My Own Capture Window',
    WS_CHILD or WS_VISIBLE ,
    Left,
    Top,
    Width,
    Height,
    Handle,
    0);
  if FHandle <> 0 then
    SendMessage(FHandle, WM_CAP_DRIVER_CONNECT, 0, 0);
  Result := FHandle;
end;

end.
