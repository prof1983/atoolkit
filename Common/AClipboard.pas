{**
@Author Prof1983 <prof1983@ya.ru>
@Created 05.05.2011
@LastMod 01.03.2013
}
unit AClipboard;

interface

uses
  Clipbrd,
  Windows,
  ABase;

// --- Public ---

{** Вставляет данные в буфер обмена }
function AClipboard_BufferToClipboardP(const Buffer: APascalString): AError;

{** Очищает буфер обмена }
function AClipboard_Clear(): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

// --- Clipboard ---

function AClipboard_BufferToClipboardP(const Buffer: APascalString): AError;
var
  WideBuffer: WideString;
  BuffSize: Cardinal;
  Data: THandle;
  DataPtr: Pointer;
begin
  if (Length(Buffer) <= 0) then
  begin
    Result := 1;
    Exit;
  end;
  try
    WideBuffer := Buffer;
    BuffSize := Length(Buffer) * SizeOf(WideChar);
    Data := GlobalAlloc(GMEM_MOVEABLE+GMEM_DDESHARE+GMEM_ZEROINIT, BuffSize + 2);
    if (Data = 0) then
    begin
      Result := -2;
      Exit;
    end;
    try
      DataPtr := GlobalLock(Data);
      try
        Move(PWideChar(WideBuffer)^, Pointer(Cardinal(DataPtr))^, BuffSize);
      finally
        GlobalUnlock(Data);
      end;
      Clipboard.SetAsHandle(CF_UNICODETEXT, Data);
      Result := 0;
    except
      GlobalFree(Data);
      Result := -1;
    end;
  except
    Result := -1;
  end;
end;

function AClipboard_Clear(): AError;
begin
  try
    Clipboard.Clear();
    Result := 0;
  except
    Result := -1;
  end;
end;

end.
