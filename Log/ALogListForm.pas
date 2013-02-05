{**
@Author Prof1983 <prof1983@ya.ru>
@Created 19.01.2005
@LastMod 05.02.2013
}
unit ALogListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  ATypes, fShablon;

type
  TfmLogList = class(TfmShablon)
  private
    ListBox: TListBox;
  protected
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{ TFormLog }

function TfmLogList.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
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

constructor TfmLogList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Top := Screen.Height - 200;
  Height := 170;
  Left := 0;
  Width := Screen.Width;

  Caption := 'Logs';

  ListBox := TListBox.Create(Self);
  ListBox.Parent := Self;
  ListBox.Align := alClient;
end;

end.
