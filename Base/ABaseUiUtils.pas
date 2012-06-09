{**
@Abstract(Базовый модуль основных типов и их преобразования. Базовые функции for Delphi 5,7,2005,2006)
@Author(Prof1983 prof1983@ya.ru)
@Created(06.06.2004)
@LastMod(09.06.2012)
@Version(0.5)

from ABaseUtils2.pas
}
unit ABaseUiUtils;

interface

uses
  Dialogs, ExtCtrls, Forms; {Math, StrUtils, SysUtils, Windows,
  ATypes;}


{$IFNDEF VER170}
function wndClose(Handle: THandle32): TError;
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
  var Value: UInt064;           {in/out}{Значение}
  uType: TWndType = 1           {in}{Тип окна}
  ): TWndRes;

function wnd_Message( {Выводит окно с сообщением}
  HParent: THandle32;          {in}{Идентификатор родительского окна}
  Caption: String;              {in}{Заголовок окна}
  Text: String;                 {in}{Текст окна}
  uType: TWndType = 0           {in}{=mb_OkCancel}
  ): TWndRes;                   {Нажатая кнопка}
{$ENDIF}

implementation

{$IFNDEF VER170}
function wndClose(Handle: THandle32): TError;
begin
  Result := (Integer(__CloseHandle(Handle)));
end;
{$ENDIF}

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
    FreeAndNil(Dialog);
  end;
end;

function wnd_Input(HParent: THandle32; Caption: String; Text: String; var Value: String; uType: TWndType): TWndRes;
begin
  if InputQuery(Caption, Text, Value) then
    Result := 0
  else
    Result := 1;
end;

{$IFNDEF VER170}
function wnd_InputUInt064(HParent: THandle32; Caption, Text: String; var Value: UInt64; uType: TWndType = 1): TWndRes;
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
{$ENDIF}

end.
