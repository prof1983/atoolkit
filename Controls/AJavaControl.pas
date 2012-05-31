{**
@Abstract(Контрол для вывода сообщений Java программ)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.04.2007)
@LastMod(26.04.2012)
@Version(0.5)
}
unit AJavaControl;

interface

uses
  SysUtils,
  ALogGlobals, AMemoControl, ATypes,
  Jni;

type //** Контрол для вывода сообщений Java программ
  TJavaControl = class(TProfMemoControl)
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; override;
    function Printf(filepointer: Pointer; const format: pchar; args: va_list): jint; stdcall;
  end;

implementation

{ TJavaControl }

function TJavaControl.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
begin
  Result := AddMessage(GetLogTypeStr(AType, '[', '] ') + AStrMsg);
end;

function TJavaControl.Printf(filepointer: Pointer; const format: pchar; args: va_list): jint;
begin
  AddMessage(IntToStr(Integer(filepointer)) + ' ' + string(format) + ' ' + string(args));
  Result := 0;
end;

end.
