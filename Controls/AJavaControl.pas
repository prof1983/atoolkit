{**
@Author Prof1983 <prof1983@ya.ru>
@Created 07.04.2007
@LastMod 23.11.2012
}
unit AJavaControl;

interface

uses
  SysUtils,
  ALogGlobals, AMemoControl, ATypes,
  Jni;

type
  TJavaControl = class(TAMemoControl)
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
