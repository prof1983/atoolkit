{**
@Author Prof1983 <prof1983@ya.ru>
@Created 25.04.2006
@LastMod 26.04.2012
}
unit AAutoSubObject;

interface

uses
  ActiveX, ComObj, SysUtils,
  AAutoObject, ATypes;

type //** @abstract(Объект реализующий работу с подобъектами)
  TAutoSubObject = class(TAutoIntfObject)
  private
    FIsReadOnly: Boolean;
    FOwner: TProfAutoObject;
  protected
    //** В случае если клиент не может модифицировать данный вызывается исключение
    procedure CheckReadOnly();
    procedure DoCreate(); virtual; safecall;
    procedure DoCreated(); virtual; safecall;
    procedure DoDestroy(); virtual; safecall;
    function DoFinalize(): WordBool; virtual; safecall;
    function DoFinalized(): WordBool; virtual; safecall;
    function DoInitialize(): WordBool; virtual; safecall;
    function DoInitialized(): WordBool; virtual; safecall;
    function DoStart(): WordBool; virtual; safecall;
    function DoStarted(): WordBool; virtual; safecall;
    function DoStop(): WordBool; virtual; safecall;
    function DoStoped(): WordBool; virtual; safecall;
  public
    //** Срабатывает сразу после создания
    procedure AfterConstruction(); override;
    //** Срабатывает перед уничтожением
    procedure BeforeDestruction(); override;
    constructor Create(AOwner: TProfAutoObject; const ATypeLib: ITypeLib; const ADispIntf: TGUID; AIsReadOnly: Boolean = False);
    //** Срабатывает при возникновении исключения
    function SafeCallException(ExceptObject: TObject; ExceptAddr: Pointer): HResult; override;
  public
    //** Признак запрета для редактирования
    property IsReadOnly: Boolean read FIsReadOnly;
    //** Владелец данного подобъекта
    property Owner: TProfAutoObject read FOwner;
  end;

implementation

resourcestring
  err_OleAutoErrorEx     = 'ОШИБКА: msg - "%s", code - "%s", class - "%s", exception - "%s".';
  err_Not_ModifyObject   = 'Объект открыт только для чтения!';

{ TAutoSubObject }

procedure TAutoSubObject.AfterConstruction();
begin
  inherited AfterConstruction();
  {while (FOwner.ServiceNT.ServiceStatus.dwCurrentState = SERVICE_START_PENDING) do
    Sleep(10);}
  DoCreate();
  DoCreated();
end;

procedure TAutoSubObject.BeforeDestruction();
begin
  DoDestroy();
  inherited BeforeDestruction();
end;

constructor TAutoSubObject.Create(AOwner: TProfAutoObject; const ATypeLib: ITypeLib; const ADispIntf: TGUID; AIsReadOnly: boolean);
begin
  FOwner := AOwner;
  if Assigned(ATypeLib) then
    inherited Create(ATypeLib, ADispIntf);
  FIsReadOnly := AIsReadOnly;
end;

procedure TAutoSubObject.DoCreate();
begin
end;

procedure TAutoSubObject.DoCreated();
begin
end;

procedure TAutoSubObject.DoDestroy();
begin
end;

function TAutoSubObject.DoFinalize(): WordBool;
begin
  Result := True;
end;

function TAutoSubObject.DoFinalized(): WordBool;
begin
  Result := True;
end;

function TAutoSubObject.DoInitialize(): WordBool;
begin
  Result := True;
end;

function TAutoSubObject.DoInitialized(): WordBool;
begin
  Result := True;
end;

function TAutoSubObject.DoStart(): WordBool;
begin
  Result := False;
end;

function TAutoSubObject.DoStarted(): WordBool;
begin
  Result := False;
end;

function TAutoSubObject.DoStop(): WordBool;
begin
  Result := False;
end;

function TAutoSubObject.DoStoped(): WordBool;
begin
  Result := False;
end;

procedure TAutoSubObject.CheckReadOnly();
begin
  //if FIsReadOnly then
  //  raise EOleException.Create(err_Not_ModifyObject, CO_E_NOT_SUPPORTED, Self.ClassName, '', 0);
end;

function TAutoSubObject.SafeCallException(ExceptObject: TObject; ExceptAddr: Pointer): HResult;
begin
  if (ExceptObject is EOleException) then
  begin
    FOwner.AddToLog(lgGeneral, ltError, err_OleAutoErrorEx); //[EOleException(ExceptObject).Message, '$' + IntToHex(EOleException(ExceptObject).ErrorCode, 8), ClassName, ExceptObject.ClassName]);
  end else
  if (ExceptObject is Exception) then
  begin
    FOwner.AddToLog(lgGeneral, ltError, err_OleAutoErrorEx); //[Exception(ExceptObject).Message, 0, ClassName, ExceptObject.ClassName]);
  end;
  Result := inherited SafeCallException(ExceptObject, ExceptAddr);
end;

end.
