{**
@Abstract(Окно вывода сообщений программы в виде списка)
@Author(Prof1983 prof1983@ya.ru)
@Created(19.01.2005)
@LastMod(02.05.2012)
@Version(0.5)
}
unit ALogListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  ATypes, fShablon;

type //** Окно вывода сообщений программы в виде списка
  TfmLogList = class(TfmShablon)
  private
    ListBox: TListBox;
  protected
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
    //function AddToLogProf(AType: TTypeMessage; APlace: TPlaceMessage; AMsg, AParams: String): UInt32; override;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{ TFormLog }

function TfmLogList.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
var
  S: String;
begin
  {try
    S := '[' + CHR_LOG_TYPE_MESSAGE[AType] + '] ' +
       CHR_LOG_GROUP_MESSAGE[AGroup] + ': ' +
       Format(AStrMsg, AParams);
    ListBox.Items.Insert(0, S);
  except
    S := '[' + CHR_LOG_TYPE_MESSAGE[AType] + '] ' +
       CHR_LOG_GROUP_MESSAGE[AGroup] + ': ' + AStrMsg;
    ListBox.Items.Insert(0, S);
  end;}
end;

{function TProfFormLog.AddToLogProf(AType: TTypeMessage; APlace: TPlaceMessage; AMsg, AParams: String): UInt32;
var
  S: String;
begin
  S := '[' + TypeMessage_Chr[AType] + '] ' +
       PlaceMessage_Chr[APlace] + ': '+ AMsg + ' ' + AParams;
  ListBox.Items.Insert(0, S);
end;}

constructor TfmLogList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Top := Screen.Height - 200;
  Height := 170;
  Left := 0;
  Width := Screen.Width;

  Caption := 'Сообщения программы';

  ListBox := TListBox.Create(Self);
  ListBox.Parent := Self;
  ListBox.Align := alClient;
end;

end.
