{**
@Abstract(Просмотр видеоизображений с видеоисточников)
@Author(Prof1983 prof1983@ya.ru)
@Created(05.04.2006)
@LastMod(10.07.2012)
@Version(0.5)
}
unit AVideoViewerForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls,
  ATypes;

type
  VideoStatusEnum = Integer;
const
  vsWork = $00000000;
  vsNotWork = $00000001;

type
  TVideoViewerForm = class(TForm)
    tmGetPicture: TTimer;
    Splitter6: TSplitter;
    sbMain: TStatusBar;
    pnLog: TPanel;
    lbLog: TListBox;
    mmCommand: TMemo;
    pn09: TPanel;
    Splitter28: TSplitter;
    Splitter29: TSplitter;
    pn09_1: TPanel;
    Image36: TImage;
    Image39: TImage;
    Splitter30: TSplitter;
    Splitter33: TSplitter;
    Image42: TImage;
    pn09_2: TPanel;
    Image37: TImage;
    Image40: TImage;
    Splitter31: TSplitter;
    Splitter34: TSplitter;
    Image43: TImage;
    pn09_3: TPanel;
    Image38: TImage;
    Image41: TImage;
    Splitter32: TSplitter;
    Splitter35: TSplitter;
    Image44: TImage;
    pn06: TPanel;
    Splitter23: TSplitter;
    pn06_1: TPanel;
    Image30: TImage;
    Image31: TImage;
    Splitter24: TSplitter;
    Splitter25: TSplitter;
    Image34: TImage;
    pn06_2: TPanel;
    Image32: TImage;
    Image33: TImage;
    Splitter26: TSplitter;
    Splitter27: TSplitter;
    Image35: TImage;
    pn05t: TPanel;
    Splitter19: TSplitter;
    pn05t1: TPanel;
    Image25: TImage;
    Splitter20: TSplitter;
    Image26: TImage;
    Splitter21: TSplitter;
    Image27: TImage;
    pn05t2: TPanel;
    Image28: TImage;
    Splitter22: TSplitter;
    Image29: TImage;
    pn04: TPanel;
    Splitter16: TSplitter;
    pn04_1: TPanel;
    Image21: TImage;
    Splitter17: TSplitter;
    Image22: TImage;
    pn04_2: TPanel;
    Image23: TImage;
    Splitter18: TSplitter;
    Image24: TImage;
    pn03t: TPanel;
    Splitter3: TSplitter;
    im04b_4: TImage;
    pn03t1: TPanel;
    im04b_1: TImage;
    Splitter4: TSplitter;
    im04b_3: TImage;
    Splitter5: TSplitter;
    im04b_2: TImage;
    pn03r: TPanel;
    Splitter13: TSplitter;
    im: TImage;
    pn03r1: TPanel;
    Image18: TImage;
    Splitter14: TSplitter;
    Image19: TImage;
    Splitter15: TSplitter;
    Image20: TImage;
    pn03l: TPanel;
    Splitter10: TSplitter;
    im04l_4: TImage;
    pn03l1: TPanel;
    im04l_1: TImage;
    Splitter11: TSplitter;
    im04l_3: TImage;
    Splitter12: TSplitter;
    im04l_2: TImage;
    pn03b: TPanel;
    Splitter7: TSplitter;
    im04t_1: TImage;
    pn03b1: TPanel;
    im04t_2: TImage;
    Splitter8: TSplitter;
    im04t_4: TImage;
    Splitter9: TSplitter;
    im04t_3: TImage;
    pn02v: TPanel;
    im02v_1: TImage;
    Splitter1: TSplitter;
    im02v_2: TImage;
    pn02h: TPanel;
    im02h_1: TImage;
    Splitter2: TSplitter;
    im02h_2: TImage;
    pn01: TPanel;
    im01: TImage;
  private
    //FEvents: IVideoViewerFormEvents;
    FStatus: VideoStatusEnum;
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
    procedure ApplyStatus();
    procedure ApplyViewType();
    procedure Initialize();
    function SetPicture(Chanel: Integer; const Picture: TPicture): WordBool;
  end;

var
  VideoViewerForm: TVideoViewerForm;

const
  LOG_COLOR: array[TLogTypeMessage] of TColor = (clBlack, clRed, clBlue, clGreen, clBlack, clBlack);

implementation

{$R *.dfm}

{ TVideoViewerForm }

function TVideoViewerForm.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
begin
  if lbLog.Items.Count > 100 then
    lbLog.Items.Clear();
  lbLog.Font.Color := LOG_COLOR[AType];
  lbLog.Items.Insert(0, FormatDateTime('hh.mm.ss', Now)+' ['+CHR_LOG_GROUP_MESSAGE[AGroup]+'] '+CHR_LOG_TYPE_MESSAGE[AType]+': '+Format(AStrMsg, AParams));
  //if lbLog.ItemIndex > 0 then lbLog.ItemIndex := lbLog.ItemIndex + 1;
  Result := True;
end;

procedure TVideoViewerForm.ApplyStatus();
begin
  case FStatus of
    vsWork:
      begin
        sbMain.Font.Color := clBlack;
        sbMain.Panels.Items[0].Text := 'Работает'
      end;
  else
    sbMain.Font.Color := clRed;
    sbMain.Panels.Items[0].Text := 'Не работает';
  end;
end;

procedure TVideoViewerForm.ApplyViewType();
begin
  pn01.Visible := False;
  pn02v.Visible := False;
  pn02h.Visible := False;
  pn03t.Visible := False;
  pn03b.Visible := False;
  pn03l.Visible := False;
  pn03r.Visible := False;
  pn04.Visible := False;
  pn05t.Visible := False;
  pn06.Visible := False;
  pn09.Visible := False;

  AddToLog(lgGeneral, ltInformation, 'Применение типа просмотра ViewType=%d', [{Integer(Setup.ViewType)}]);
  {if Assigned(Setup) then case Setup.ViewType of
    vt01: pn01.Visible := True;
    vt02v: pn02v.Visible := True;
    vt02h: pn02h.Visible := True;
    vt03t: pn03t.Visible := True;
    vt03b: pn03b.Visible := True;
    vt03l: pn03l.Visible := True;
    vt03r: pn03r.Visible := True;
    vt04: pn04.Visible := True;
    vt05t: pn05t.Visible := True;
    vt06: pn06.Visible := True;
    vt09: pn09.Visible := True;
  else
    pn01.Visible := True;
  end;}
end;

procedure TVideoViewerForm.Initialize();
begin
  {OnActivate := ActivateEvent;
  OnClick := ClickEvent;
  OnCreate := CreateEvent;
  OnDblClick := DblClickEvent;
  OnDeactivate := DeactivateEvent;
  OnDestroy := DestroyEvent;
  OnKeyPress := KeyPressEvent;
  OnPaint := PaintEvent;}

  pn01.Align := alClient;
  pn02v.Align := alClient;
  pn02h.Align := alClient;
  pn03t.Align := alClient;
  pn03b.Align := alClient;
  pn03l.Align := alClient;
  pn03r.Align := alClient;
  pn04.Align := alClient;
  pn05t.Align := alClient;
  pn06.Align := alClient;
  pn09.Align := alClient;

  {try
    Setup := TSetup.Create(ExtractFilePath(ParamStr(0)) + DEFAULT_DB_DIR + '\', 'Statica_VideoViewer', AddToLog);
    Setup.ViewType := vt01;
    Setup.LoadParams();
    ApplyViewType();
  except
    Setup := nil;
  end;}
end;

function TVideoViewerForm.SetPicture(Chanel: Integer; const Picture: TPicture): WordBool;
begin
  Result := False;
  {if not(Assigned(Setup)) then Exit;
  Result := True;
  case Setup.ViewType of
    vt01:
      case Chanel of
        0: SetOlePicture(im01.Picture, Picture);
      else
        Result := False;
      end;
    vt02v:
      case Chanel of
        0: SetOlePicture(im02v_1.Picture, Picture);
        1: SetOlePicture(im02v_2.Picture, Picture);
      else
        Result := False;
      end;
  else
    Result := False;
  end;}
end;

end.
