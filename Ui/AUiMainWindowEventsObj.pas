{**
@Abstract AUi events object
@Author Prof1983 <prof1983@ya.ru>
@Created 29.01.2013
@LastMod 26.03.2013
}
unit AUiMainWindowEventsObj;

{$I Defines.inc}

{$ifndef NoRuntime}
  {$define UseRuntime}
{$endif}

interface

uses
  ABase,
  {$ifdef UseRuntime}ARuntimeMain,{$endif}
  AUiData;

{ Classes }

type
  TUiEventsObj = class
  public
    procedure MainFormCloseQuery(Sender: TObject; var CanClose: Boolean);
  end;

var
  UiEventsObj: TUiEventsObj;

implementation

uses
  AUiMainWindow;

{ TUiEventsObj }

procedure TUiEventsObj.MainFormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if FHideOnClose then
  begin
    {$ifdef UseRuntime}
    CanClose := ARuntime_GetIsShutdown();
    {$else}
    CanClose := True;
    {$endif}
    if not(CanClose) then
      FIsShowApp := False;
  end
  else
    AUiMainWindow_Shutdown();
end;

end.
