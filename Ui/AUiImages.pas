{**
@Abstract AUiImage
@Author Prof1983 <prof1983@ya.ru>
@Created 05.09.2012
@LastMod 20.02.2013
}
unit AUiImages;

{define AStdCall}

interface

uses
  Controls,
  ExtCtrls,
  ABase,
  AStringMain,
  AUiBase,
  AUiData;

// --- AUiImage ---

{** Загружает изображение из файла }
function AUiImage_LoadFromFile(Image: AControl; const FileName: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Загружает изображение из файла }
function AUiImage_LoadFromFileA(Image: AControl; FileName: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Загружает изображение из файла }
function AUiImage_LoadFromFileP(Image: AControl; const FileName: APascalString): AError;

{** Создает новый элемент-изображение }
function AUiImage_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiImage_SetCenter(Image: AControl; Value: ABool): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiImage_SetTransparent(Image: AControl; Value: ABool): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

// --- AUiImage ---

function AUiImage_LoadFromFile(Image: AControl; const FileName: AString_Type): AError;
begin
  Result := AUiImage_LoadFromFileP(Image, AString_ToPascalString(FileName));
end;

function AUiImage_LoadFromFileA(Image: AControl; FileName: AStr): AError;
begin
  Result := AUiImage_LoadFromFileP(Image, AnsiString(FileName));
end;

function AUiImage_LoadFromFileP(Image: AControl; const FileName: APascalString): AError;
begin
  try
    if not(TObject(Image) is TImage) then
    begin
      Result := -2;
      Exit;
    end;
    TImage(Image).Picture.LoadFromFile(FileName);
    Result := 0
  except
    Result := -1;
  end;
end;

function AUiImage_New(Parent: AControl): AControl;
var
  Image: TImage;
begin
  try
    Image := TImage.Create(TWinControl(Parent));
    Image.Parent := TWinControl(Parent);
    Result := AddObject(Image);
  except
    Result := 0;
  end;
end;

function AUiImage_SetCenter(Image: AControl; Value: ABool): AError;
begin
  try
    if not(TObject(Image) is TImage) then
    begin
      Result := -2;
      Exit;
    end;
    TImage(Image).Center := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiImage_SetTransparent(Image: AControl; Value: ABool): AError;
begin
  try
    if not(TObject(Image) is TImage) then
    begin
      Result := -2;
      Exit;
    end;
    TImage(Image).Transparent := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

end.
