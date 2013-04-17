{**
@Abstract AUiImage
@Author Prof1983 <prof1983@ya.ru>
@Created 05.09.2012
@LastMod 16.04.2013
}
unit AUiImages;

{$define AStdCall}

interface

uses
  Controls, ExtCtrls,
  ABase,
  AStringMain,
  AUiBase, AUiData;

// --- AUiImage ---

{** Загружает изображение из файла }
function AUiImage_LoadFromFile(Image: AControl; const FileName: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Загружает изображение из файла }
function AUiImage_LoadFromFileA(Image: AControl; FileName: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Загружает изображение из файла }
function AUiImage_LoadFromFileP(Image: AControl; const FileName: APascalString): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Загружает изображение из файла }
function AUiImage_LoadFromFileWS(Image: AControl; const FileName: AWideString): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Создает новый элемент-изображение }
function AUiImage_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiImage_SetProportional(Image: AControl; Value: ABool): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiImage_SetStretch(Image: AControl; Value: ABool): AError; {$ifdef AStdCall}stdcall;{$endif}

// --- AUi_Image ---

function AUi_Image_LoadFromFile(Image: AControl; const FileName: AString_Type): ABoolean; stdcall;

function AUi_Image_New(Parent: AControl): AControl; stdcall;

// --- UI_Image ---

{** Загружает изображение из файла }
function UI_Image_LoadFromFile(Image: AControl; const FileName: APascalString): ABoolean; stdcall;

{** Создает новый элемент-изображение }
function UI_Image_New(Parent: AControl): AControl; stdcall;

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
    TImage(Image).Picture.LoadFromFile(FileName);
    Result := 0
  except
    Result := -1;
  end;
end;

function AUiImage_LoadFromFileWS(Image: AControl; const FileName: AWideString): AError;
begin
  Result := AUiImage_LoadFromFileP(Image, FileName);
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

function AUiImage_SetProportional(Image: AControl; Value: ABool): AError;
begin
  if (Image = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    if not(TObject(Image) is TImage) then
    begin
      Result := -3;
      Exit;
    end;
    TImage(Image).Proportional := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiImage_SetStretch(Image: AControl; Value: ABool): AError;
begin
  if (Image = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    if not(TObject(Image) is TImage) then
    begin
      Result := -3;
      Exit;
    end;
    TImage(Image).Stretch := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

// --- AUi_Image ---

function AUi_Image_LoadFromFile(Image: AControl; const FileName: AString_Type): ABoolean;
begin
  try
    Result := (AUiImage_LoadFromFileP(Image, AString_ToPascalString(FileName)) = 0);
  except
    Result := False;
  end;
end;

function AUi_Image_New(Parent: AControl): AControl;
begin
  Result := AUiImage_New(Parent);
end;

// --- UI_Image ---

function UI_Image_LoadFromFile(Image: AControl; const FileName: APascalString): ABoolean;
begin
  Result := (AUiImage_LoadFromFileP(Image, FileName) = 0);
end;

function UI_Image_New(Parent: AControl): AControl;
begin
  Result := AUiImage_New(Parent);
end;

end.
