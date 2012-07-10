{**
@Abstract(Форма "О программе")
@Author(Prof1983 prof1983@ya.ru)
@Created(04.04.2006)
@LastMod(10.07.2012)
@Version(0.5)

История версий:
0.1.0.1 - 05.07.2007 - fmAbout -> AboutForm
0.1.0.0 - 19.06.2007 - Создан из ProfAboutForm
}
unit fAbout1;

interface

uses
  Buttons, Classes, Controls, Dialogs, ExtCtrls, Graphics, Forms, Messages,
  ShellAPI, SysUtils, StdCtrls, Windows,
  AProgramUtils, ATypes;

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
var
  VersionInfo: TFileVersionInfoA;
begin
  Caption := 'О программе';

  lbName.Caption := (Owner as TForm).Caption;
  lbWWW.Caption := '';
  VersionInfo := GetProgramVersionInfo(ParamStr(0));

  lbCopyright.Caption := lbCopyright.Caption + VersionInfo.ProductName;
  if (Length(VersionInfo.ProductVersion) > 0) then
    lbCopyright.Caption:=lbCopyright.Caption+' ('+VersionInfo.ProductVersion+')'#13#10
  else
    lbCopyright.Caption := lbCopyright.Caption+#13#10;
  if (Length(VersionInfo.OriginalFileName) > 0) then
    lbCopyright.Caption := lbCopyright.Caption+'Имя файла: '+VersionInfo.OriginalFileName+#13#10;
  if (Length(VersionInfo.InternalName) > 0) then
    lbCopyright.Caption := lbCopyright.Caption+VersionInfo.InternalName+#13#10;
  if (Length(VersionInfo.FileVersion) > 0) then
    lbCopyright.Caption := lbCopyright.Caption+'Версия: '+VersionInfo.FileVersion+#13#10;
  if (Length(VersionInfo.LegalCopyright) > 0) then
    lbCopyright.Caption := lbCopyright.Caption+VersionInfo.LegalCopyright+#13#10;
  if (Length(VersionInfo.CompanyName) > 0) then
    lbCopyright.Caption := lbCopyright.Caption+'Компания: '+VersionInfo.CompanyName+#13#10;
  if (Length(VersionInfo.FileDescription) > 0) then
    lbCopyright.Caption := lbCopyright.Caption+'Описание: '+VersionInfo.FileDescription+#13#10;
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
