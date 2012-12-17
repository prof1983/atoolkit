{**
@Abstract Базовый модуль основных типов и их преобразования. Базовые функции for Delphi 5,7,2005,2006
@Author Prof1983 <prof1983@ya.ru>
@Created 06.06.2004
@LastMod 17.12.2012
}
unit ABaseUiUtils;

interface

uses
  Dialogs, ExtCtrls, Forms, Windows,
  ABase, ABaseUtils2, ATypes;

type
  TWndType = type AInt; // Windows.UINT
  TWndRes = type AInt;

{IFNDEF VER170}
function wndClose(Handle: THandle32): AError;
function wndDialogOpen(var AFileName: WideString): WordBool;

// wnd_Input2
function wnd_Input(
  HParent: THandle32;          {in}{Идентификатор родительского окна}
  Caption: String;              {in}{Заголовок окна}
  Text: String;                 {in}{Текст окна}
  var Value: String;            {in/out}{Указатель на строку}
  uType: TWndType = 1           {in}{Тип окна}
  ): TWndRes;                   {Нажатая кнопка}

function wnd_InputUInt064( {}
  HParent: THandle32;          {in}{Идентификатор родительского окна}
  Caption: String;              {in}{Заголовок окна}
  Text: String;                 {in}{Текст окна}
  var Value: AUInt64;           {in/out}{Значение}
  uType: TWndType = 1           {in}{Тип окна}
  ): TWndRes;

function wnd_Message( {Выводит окно с сообщением}
  HParent: THandle32;          {in}{Идентификатор родительского окна}
  Caption: String;              {in}{Заголовок окна}
  Text: String;                 {in}{Текст окна}
  uType: TWndType = 0           {in}{=mb_OkCancel}
  ): TWndRes;                   {Нажатая кнопка}
{ENDIF}

implementation

// -- API ---

function __CloseHandle(hObject: THandle32): Boolean; stdcall; external 'kernel32.dll' name 'CloseHandle';
function __GetLastError(): AInt32; stdcall; external 'kernel32.dll' name 'GetLastError';

// --- Public ---

{IFNDEF VER170}
function wndClose(Handle: THandle32): AError;
begin
  Result := (Integer(__CloseHandle(Handle)));
end;
{ENDIF}

function wndDialogOpen(var AFileName: WideString): WordBool;
// Диалог выбора файла
var
  Dialog: TOpenDialog;
begin
  Dialog := TOpenDialog.Create(nil);
  try
    Dialog.FileName := AFileName;
    Result := Dialog.Execute;
    if Result then AFileName := Dialog.FileName;
  finally
    Dialog.Free();
  end;
end;

function wnd_Input(HParent: THandle32; Caption: String; Text: String; var Value: String; uType: TWndType): TWndRes;
begin
  if InputQuery(Caption, Text, Value) then
    Result := 0
  else
    Result := 1;
end;

{IFNDEF VER170}
function wnd_InputUInt064(HParent: THandle32; Caption, Text: String; var Value: AUInt64; uType: TWndType = 1): TWndRes;
var
  S: String;
begin
  repeat
    S := cUInt64ToStr(Value);
    Result := wnd_Input(HParent, PChar(Caption), PChar(Text), S, uType);
    Value := cStrToUInt64(S);
  until False;
end;

function wnd_Memo(HParent: THandle32; Caption, Text: String): TWndRes;
begin
  Result := wnd_Message(HParent, PChar(Caption), PChar(Text), $0);
end;

function wnd_Message(HParent: THandle32; Caption, Text: String; uType: TWndType = 0): TWndRes;
begin
  Result := MessageBox(HParent, PChar(Text), PChar(Caption), uType);
end;
{ENDIF}

end.
