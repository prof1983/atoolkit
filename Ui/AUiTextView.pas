{**
@Abstract AUi text view
@Author Prof1983 <prof1983@ya.ru>
@Created 12.11.2012
@LastMod 16.04.2013
}
unit AUiTextView;

{$define AStdCall}

interface

uses
  ComCtrls, Controls, Graphics, StdCtrls,
  ABase,
  AStringMain,
  AUiBase, AUiData;

// --- AUi_TextView ---

{** Добавляет строку в элемент TextView }
function AUiTextView_AddLine(TextView: AControl; const Text: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

{** Создает новый элемент редактирования текста
    @param ViewType: 0 - TMemo; 1 - RichEdit }
function AUiTextView_AddLineP(TextView: AControl; const Text: APascalString): AInteger; {$ifdef AStdCall}stdcall;{$endif}

{** Создает новый элемент редактирования текста
    @param ViewType: 0 - TMemo; 1 - RichEdit }
function AUiTextView_New(Parent: AControl; ViewType: AInteger): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiTextView_SetFont(TextView: AControl; const FontName: AString_Type; FontSize: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiTextView_SetFontP(TextView: AControl; const FontName: APascalString; FontSize: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiTextView_SetReadOnly(TextView: AControl; ReadOnly: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Set scroll bars
    @param ScrollBars: 0 - ssNone; 1 - ssHorizontal; 2 - ssVertical; 3 - ssBoth }
function AUiTextView_SetScrollBars(TextView: AControl; ScrollBars: AUiScrollStyle): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiTextView_SetWordWrap(TextView: AControl; Value: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

// --- AUi_TextView ---

// Добавляет строку в элемент TextView
function AUi_TextView_AddLine(TextView: AControl; const Text: AString_Type): AInteger; stdcall; deprecated; // Use AUiTextView_AddLine()

{ Создает новый элемент редактирования текста
  ViewType
    0 - TMemo
    1 - RichEdit }
function AUi_TextView_New(Parent: AControl; ViewType: AInteger): AControl; stdcall; deprecated; // Use AUiTextView_New()

procedure AUi_TextView_SetFont(TextView: AControl; const FontName: AString_Type; FontSize: AInteger); stdcall; deprecated; // AUiTextView_SetFont()

procedure AUi_TextView_SetReadOnly(TextView: AControl; ReadOnly: ABoolean); stdcall; deprecated; // Use AUiTextView_SetReadOnly()

{ ScrollBars
    0 - ssNone
    1 - ssHorizontal
    2 - ssVertical
    3 - ssBoth }
procedure AUi_TextView_SetScrollBars(TextView: AControl; ScrollBars: AInteger); stdcall; deprecated; // Use AUiTextView_SetScrollBars()

procedure AUi_TextView_SetWordWrap(TextView: AControl; Value: ABoolean); stdcall; deprecated; // Use AUiTextView_SetWordWrap()

{ --- UI_TextView --- }

//** Добавляет строку в элемент TextView.
function UI_TextView_AddLine(TextView: AControl; const Text: APascalString): AInteger; stdcall;

{ Создает новый элемент редактирования текста
  ViewType
    0 - TMemo
    1 - RichEdit }
function UI_TextView_New(Parent: AControl; ViewType: AInteger): AControl; stdcall;

procedure UI_TextView_SetFont(TextView: AControl; const FontName: APascalString; FontSize: AInteger); stdcall;

//** Устанавливает значение параметра "Только чтение".
procedure UI_TextView_SetReadOnly(TextView: AControl; ReadOnly: ABoolean); stdcall;

{**
  Указывает какие ползунки отображать.
  ScrollBars
    0 - ssNone
    1 - ssHorizontal
    2 - ssVertical
    3 - ssBoth
}
procedure UI_TextView_SetScrollBars(TextView: AControl; ScrollBars: AInteger); stdcall;

//** Задает параметр "переносить по словам".
procedure UI_TextView_SetWordWrap(TextView: AControl; Value: ABoolean); stdcall;

implementation

// --- AUiTextView ---

function AUiTextView_AddLine(TextView: AControl; const Text: AString_Type): AInteger;
begin
  Result := AUiTextView_AddLineP(TextView, AString_ToP(Text));
end;

function AUiTextView_AddLineP(TextView: AControl; const Text: APascalString): AInteger;
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

function AUiTextView_New(Parent: AControl; ViewType: AInteger): AControl;
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

function AUiTextView_SetFont(TextView: AControl; const FontName: AString_Type; FontSize: AInteger): AError;
begin
  Result := AUiTextView_SetFontP(TextView, AString_ToP(FontName), FontSize);
end;

function AUiTextView_SetFontP(TextView: AControl; const FontName: APascalString; FontSize: AInteger): AError;

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

function AUiTextView_SetReadOnly(TextView: AControl; ReadOnly: ABoolean): AError;
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

function AUiTextView_SetWordWrap(TextView: AControl; Value: ABoolean): AError;
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

// --- AUi_TextView ---

function AUi_TextView_AddLine(TextView: AControl; const Text: AString_Type): AInteger;
begin
  Result := AUiTextView_AddLineP(TextView, AString_ToP(Text));
end;

function AUi_TextView_New(Parent: AControl; ViewType: AInteger): AControl;
begin
  Result := AUiTextView_New(Parent, ViewType);
end;

procedure AUi_TextView_SetFont(TextView: AControl; const FontName: AString_Type; FontSize: AInteger);
begin
  AUiTextView_SetFontP(TextView, AString_ToP(FontName), FontSize);
end;

procedure AUi_TextView_SetReadOnly(TextView: AControl; ReadOnly: ABoolean);
begin
  AUiTextView_SetReadOnly(TextView, ReadOnly);
end;

procedure AUi_TextView_SetScrollBars(TextView: AControl; ScrollBars: AInteger);
begin
  AUiTextView_SetScrollBars(TextView, ScrollBars);
end;

procedure AUi_TextView_SetWordWrap(TextView: AControl; Value: ABoolean);
begin
  AUiTextView_SetWordWrap(TextView, Value);
end;

{ TextView }

function UI_TextView_AddLine(TextView: AControl; const Text: APascalString): AInteger;
begin
  Result := AUiTextView_AddLineP(TextView, Text);
end;

function UI_TextView_New(Parent: AControl; ViewType: AInteger): AControl;
begin
  Result := AUiTextView_New(Parent, ViewType);
end;

procedure UI_TextView_SetFont(TextView: AControl; const FontName: APascalString; FontSize: AInteger);
begin
  AUiTextView_SetFontP(TextView, FontName, FontSize);
end;

procedure UI_TextView_SetReadOnly(TextView: AControl; ReadOnly: ABoolean);
begin
  AUiTextView_SetReadOnly(TextView, ReadOnly);
end;

procedure UI_TextView_SetScrollBars(TextView: AControl; ScrollBars: AInteger);
begin
  AUiTextView_SetScrollBars(TextView, ScrollBars);
end;

procedure UI_TextView_SetWordWrap(TextView: AControl; Value: ABoolean);
begin
  AUiTextView_SetWordWrap(TextView, Value);
end;

end.
