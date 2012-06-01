{**
@Abstract(Форма "О программе")
@Author(Prof1983 prof1983@ya.ru)
@Created(04.04.2006)
@LastMod(25.04.2012)
@Version(0.5)

История версий:
0.1.0.1 - 05.07.2007 - fmAbout -> AboutForm
0.1.0.0 - 19.06.2007 - Создан из ProfAboutForm
}
unit fAbout1;

interface

uses
  Buttons, Classes, Controls, Dialogs, ExtCtrls, Graphics, Forms, Messages,
  ShellAPI, SysUtils, StdCtrls, Windows;

type //** Форма "О программе"
  TAboutForm = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    BitBtn1: TBitBtn;
    Bevel1: TBevel;
    lbWWW: TLabel;
    lbCopyright: TLabel;
    lbName: TLabel;
    procedure lbWWWClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    {$IFDEF Prof_Program}FProgram: TProgram;{$ENDIF}
    procedure SetProgramName(const Value: WideString);
    function GetPicture(): TPicture;
    function GetProgramName(): WideString;
    function GetReference(): WideString;
    {$IFDEF Prof_Program}procedure SetProgram(Value: TProgram);{$ENDIF}
    procedure SetReference(Value: WideString);
  public
      //** Картинка для отображения
    property Picture: TPicture read GetPicture;
      //** Название программы
    property ProgramName: WideString read GetProgramName write SetProgramName;
      //** Ссылка на сайт программы
    property Reference: WideString read GetReference write SetReference;
  end;

implementation

{$R *.DFM}

{ TAboutForm }

procedure TAboutForm.FormCreate(Sender: TObject);
type
  arrc = array[0..$ffff] of char;
var
  Wnd, InfoSize, Size: DWORD;
  VersionInfo: Pointer;
  st: ShortString;
  p: ^arrc{ absolute VersionInfo};
begin
  Caption := 'О программе';

  lbName.Caption := (Owner as TForm).Caption;
  lbWWW.Caption := '';
  InfoSize := GetFileVersionInfoSize(PChar(Paramstr(0)), Wnd);
  if (InfoSize <> 0) then
  begin
    GetMem(VersionInfo, InfoSize);
    try
      if GetFileVersionInfo(PChar(Paramstr(0)), Wnd, InfoSize, VersionInfo) then begin
        if(VerQueryValue(VersionInfo, '\StringFileInfo\041904E3\ProductName', pointer(p),Size))and(Size>1)then
        begin
          setlength(st,size); st:=copy(p^,1,Size);
          lbCopyright.Caption:=lbCopyright.Caption+st;
        if(VerQueryValue(VersionInfo, '\StringFileInfo\041904E3\ProductVersion', pointer(p),Size))and(Size>1) then
        begin
          setlength(st,size); st:=copy(p^,1,Size);
          lbCopyright.Caption:=lbCopyright.Caption+' ('+st+')'#13#10;
        end else lbCopyright.Caption:=lbCopyright.Caption+#13#10;
        end;
        if(VerQueryValue(VersionInfo, '\StringFileInfo\041904E3\OriginalFilename', pointer(p),Size))and(Size>1) then
        begin
          setlength(st,size); st:=copy(p^,1,Size);
          lbCopyright.Caption:=lbCopyright.Caption+'Имя файла: '+st+#13#10;
        end;
        if(VerQueryValue(VersionInfo, '\StringFileInfo\041904E3\InternalName', pointer(p),Size))and(Size>1) then
        begin
          setlength(st,size); st:=copy(p^,1,Size);
          lbCopyright.Caption:=lbCopyright.Caption+st+#13#10;
        end;
        if(VerQueryValue(VersionInfo, '\StringFileInfo\041904E3\FileVersion', pointer(p),Size))and(Size>1) then
        begin
          setlength(st,size); st:=copy(p^,1,Size);
          lbCopyright.Caption:=lbCopyright.Caption+'Версия: '+st+#13#10;
        end;
        if(VerQueryValue(VersionInfo, '\StringFileInfo\041904E3\LegalCopyright', pointer(p),Size))and(Size>1) then
        begin
          setlength(st,size); st:=copy(p^,1,Size);
          lbCopyright.Caption:=lbCopyright.Caption+st+#13#10;
        end;
        if(VerQueryValue(VersionInfo, '\StringFileInfo\041904E3\CompanyName', pointer(p),Size))and(Size>1) then
        begin
          setlength(st,size); st:=copy(p^,1,Size);
          lbCopyright.Caption:=lbCopyright.Caption+'Компания: '+st+#13#10;
        end;
        if(VerQueryValue(VersionInfo, '\StringFileInfo\041904E3\FileDescription', pointer(p),Size))and(Size>1) then
        begin
          setlength(st,size); st:=copy(p^,1,Size);
          lbCopyright.Caption:=lbCopyright.Caption+'Описание: '+st+#13#10;
        end;
        lbCopyright.Width:=Width-lbCopyright.Left-5;
        lbCopyright.AutoSize:=True;
        if lbCopyright.Height>70 then Height:=lbCopyright.Height+90;
      end;
    finally
      FreeMem(VersionInfo);
    end;
  end;

{
var
   Ver: TVersionInfo;
begin
  Ver := TVersionInfo.Create(Application.ExeName);
  Label1.Caption := Ver.FileVersion;
  Label2.Caption := Ver.LegalCopyright;
  Caption := Ver.ProductName;
end;
}
end;

function TAboutForm.GetPicture(): TPicture;
begin
  Result := Image1.Picture;
end;

function TAboutForm.GetProgramName(): WideString;
begin
  Result := lbName.Caption;
end;

function TAboutForm.GetReference(): WideString;
begin
  Result := lbWww.Caption;
end;

procedure TAboutForm.lbWWWClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(lbwww.Caption), nil, nil, 0);
end;

procedure TAboutForm.SetProgramName(const Value: WideString);
begin
  lbName.Caption := Value;
end;

procedure TAboutForm.SetReference(Value: WideString);
begin
  lbWww.Caption := Value;
end;

end.
