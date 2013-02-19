{**
@Abstract AUi text view
@Author Prof1983 <prof1983@ya.ru>
@Created 12.11.2012
@LastMod 19.02.2013
}
unit AUiTextView;
                         
{define AStdCall}

interface

uses
  ComCtrls,
  Controls,
  Graphics,
  StdCtrls,
  ABase,
  AStringMain,
  AUiBase,
  AUiData;

// --- AUi_TextView ---

{** Добавляет строку в элемент TextView }
function AUiTextView_AddLine(TextView: AControl; const Text: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

{** Создает новый элемент редактирования текста
    @param ViewType: 0 - TMemo; 1 - RichEdit }
function AUiTextView_AddLineP(TextView: AControl; const Text: APascalString): AInt; {$ifdef AStdCall}stdcall;{$endif}

{** Создает новый элемент редактирования текста
    @param ViewType: 0 - TMemo; 1 - RichEdit }
function AUiTextView_New(Parent: AControl; ViewType: AInt): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiTextView_SetFont(TextView: AControl; const FontName: AString_Type; FontSize: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiTextView_SetFontP(TextView: AControl; const FontName: APascalString; FontSize: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiTextView_SetReadOnly(TextView: AControl; ReadOnly: ABool): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Set scroll bars
    @param ScrollBars: 0 - ssNone; 1 - ssHorizontal; 2 - ssVertical; 3 - ssBoth }
function AUiTextView_SetScrollBars(TextView: AControl; ScrollBars: AUiScrollStyle): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiTextView_SetWordWrap(TextView: AControl; Value: ABool): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

// --- AUiTextView ---

function AUiTextView_AddLine(TextView: AControl; const Text: AString_Type): AInt;
begin
  Result := AUiTextView_AddLineP(TextView, AString_ToPascalString(Text));
end;

function AUiTextView_AddLineP(TextView: AControl; const Text: APascalString): AInt;
begin
  try
    if (TObject(TextView) is TMemo) then
      Result := TMemo(TextView).Lines.Add(Text)
    {$IFNDEF FPC}
    else if (TObject(TextView) is TRichEdit) then
      Result := TRichEdit(TextView).Lines.Add(Text)
    {$ENDIF}
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function AUiTextView_New(Parent: AControl; ViewType: AInt): AControl;
var
  Memo: TMemo;
  {$IFNDEF FPC}
  Rich: TRichEdit;
  {$ENDIF}
begin
  try
    if (ViewType = 0) then
    begin
      Memo := TMemo.Create(TWinControl(Parent));
      Memo.Parent := TWinControl(Parent);
      Result := AddObject(Memo);
    end
    else
    begin
      {$IFNDEF FPC}
      Rich := TRichEdit.Create(TWinControl(Parent));
      Rich.Parent := TWinControl(Parent);
      Result := AddObject(Rich);
      {$ENDIF}
    end;
  except
    Result := 0;
  end;
end;

function AUiTextView_SetFont(TextView: AControl; const FontName: AString_Type; FontSize: AInt): AError;
begin
  Result := AUiTextView_SetFontP(TextView, AString_ToPascalString(FontName), FontSize);
end;

function AUiTextView_SetFontP(TextView: AControl; const FontName: APascalString; FontSize: AInt): AError;

  procedure SetFont(Font: TFont);
  begin
    if (FontName <> '') then
      Font.Name := FontName;
    if (FontSize <> 0) then
      Font.Size := FontSize;
  end;

begin
  try
    {$IFNDEF FPC}
    if (TObject(TextView) is TRichEdit) then
      SetFont(TRichEdit(TextView).Font);
    {$ENDIF}
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiTextView_SetReadOnly(TextView: AControl; ReadOnly: ABool): AError;
begin
  try
    if (TObject(TextView) is TMemo) then
      TMemo(TextView).ReadOnly := ReadOnly
    {$IFNDEF FPC}
    else if (TObject(TextView) is TRichEdit) then
      TRichEdit(TextView).ReadOnly := ReadOnly;
    {$ENDIF}
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiTextView_SetScrollBars(TextView: AControl; ScrollBars: AUiScrollStyle): AError;
begin
  try
    if (TObject(TextView) is TMemo) then
      TMemo(TextView).ScrollBars := TScrollStyle(ScrollBars)
    {$IFNDEF FPC}
    else if (TObject(TextView) is TRichEdit) then
      TRichEdit(TextView).ScrollBars := TScrollStyle(ScrollBars);
    {$ENDIF}
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiTextView_SetWordWrap(TextView: AControl; Value: ABool): AError;
begin
  try
    if (TObject(TextView) is TMemo) then
      TMemo(TextView).WordWrap := Value
    {$IFNDEF FPC}
    else if (TObject(TextView) is TRichEdit) then
      TRichEdit(TextView).WordWrap := Value;
    {$ENDIF}
    Result := 0;
  except
    Result := -1;
  end;
end;

end.
