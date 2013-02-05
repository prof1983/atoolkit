{**
@Abstract Форма "О программе"
@Author Prof1983 <prof1983@ya.ru>
@Created 04.04.2006
@LastMod 17.12.2012
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
    lbName: TLabel;
    DescriptionMemo: TMemo;
    procedure lbWWWClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure SetProgramName(const Value: WideString);
    function GetPicture(): TPicture;
    function GetProgramName(): WideString;
    function GetReference(): WideString;
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

const
  AboutStr = 'О программе';

{ TAboutForm }

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  Caption := AboutStr;
  lbName.Caption := (Owner as TForm).Caption;
  lbWWW.Caption := '';
  DescriptionMemo.Text := GetProgramVersionInfoStr(ParamStr(0));
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
