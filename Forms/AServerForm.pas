{**
@Abstract(Server form)
@Author(Prof1983 prof1983@ya.ru)
@Created(31.10.2005)
@LastMod(09.07.2012)
@Version(0.5)
}
unit AServerForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, Registry, StdCtrls, ExtCtrls,
  AConfig2007, AFormImpl, ALogNodeImpl;

type
  TClient = record
    Name: String;
    Color: TColor;
    CustomWinSocket: TCustomWinSocket;
    Error: Boolean;
  end;

  TBlock = record
    Ident: Byte;
    AddressFrom: String[16];
    Com: Byte;
    S: ShortString;
  end;

  TProfFormServer = class(TProfForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FListBox: TListBox;
    FServerSocket: TServerSocket;
    procedure ServerSocket1ClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocket1ClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocket1ClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ServerSocket1ClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
  public
    A: array of TClient;
    {Reg: TRegistry;}
    constructor Create(AConfig: TConfigNode1 = nil; ALog: TALogNode = nil; AOwner: TComponent = nil);
    procedure Free();
    procedure RefreshA;
    procedure Refresh(Socket: TCustomWinSocket);
    procedure DeleteSocket(Socket: TCustomWinSocket);
    property ServerSocket: TServerSocket read FServerSocket write FServerSocket;
  end;

implementation

{$R *.dfm}

{TProfFormServer}

constructor TProfFormServer.Create(AConfig: TConfigNode1 = nil; ALog: TALogNode = nil; AOwner: TComponent = nil);
begin
  inherited Create(AOwner);
  //Self.Config := AConfig;
  //Self.Log := ALog;
  {Создание компонентов}
  if not(Assigned(FListBox)) then
    FListBox := TListBox.Create(Self);
  FListBox.Parent := Self;
  FListBox.Align := alClient;
end;

procedure TProfFormServer.DeleteSocket(Socket: TCustomWinSocket);
var
  I: Integer;
  I2: Integer;
begin
  {Удаление клиента}
  for I := 0 to High(A) do
    if A[I].CustomWinSocket = Socket then
    begin
      for I2 := I to High(A) - 1 do A[I2] := A[I2 - 1];
      SetLength(A, High(A));
    end;
  RefreshA;
end;

procedure TProfFormServer.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  {Reg := TRegistry.Create;
  with Reg do
  begin
    OpenKey('Software', True);
    OpenKey('Prof', True);
    OpenKey('Net', True);
    OpenKey('Server', True);
    OpenKey('1.0', True);
    if Reg.ValueExists('Port') then I := Reg.ReadInteger('Port') else I := 10;
  end;
  ServerSocket1.Port := I;
  ServerSocket1.Active := True;}
end;

procedure TProfFormServer.FormDestroy(Sender: TObject);
begin
  {Послать всем сообщения об отбое}
  SetLength(A, 0);
end;

procedure TProfFormServer.Free;
begin
  FListBox.Free;
  inherited Free;
end;

procedure TProfFormServer.Refresh(Socket: TCustomWinSocket);
var
  Buf: TBlock;
begin
  if not(Assigned(FServerSocket)) then Exit;
  Buf.Ident := 0;
  Buf.AddressFrom := FServerSocket.Socket.LocalAddress;
  Buf.Com := 0;
  Buf.S := 'Запрос на возвращение имени';
  Socket.SendBuf(Buf, SizeOf(Buf));
  Buf.Com := 4;
  Buf.S := 'Запрос на возвращение цвета';
  Socket.SendBuf(Buf, SizeOf(Buf));
  Buf.Com := 3;
  Buf.S := 'Сообщение об изменениях';
end;

procedure TProfFormServer.RefreshA;
var
  I: Integer;
  Buf: TBlock;
begin
  if not(Assigned(FServerSocket)) then Exit;
  FListBox.Items.Clear;
  Buf.Ident := 0;
  Buf.AddressFrom := FServerSocket.Socket.LocalAddress;
  Buf.Com := 3;
  Buf.S := 'Сообщение об изменениях';
  for I := 0 to High(A) do
  begin
    FListBox.Items.Add(A[I].Name + ' - ' + A[I].CustomWinSocket.RemoteAddress);
    A[I].CustomWinSocket.SendBuf(Buf, SizeOf(Buf));
  end;
end;

procedure TProfFormServer.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  I: Integer;
begin
  {Связь с клиентом}
  I := Length(A);
  SetLength(A, I + 1);
  A[I].CustomWinSocket := Socket;
  Refresh(Socket);
end;

procedure TProfFormServer.ServerSocket1ClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  DeleteSocket(Socket);
end;

procedure TProfFormServer.ServerSocket1ClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
var
  I: Integer;
begin
  for I := 0 to High(A) do
    if A[I].CustomWinSocket = Socket then
    begin
      if A[I].Error = False then
      begin
        A[I].Error := True;
        Exit;
      end
      else
      begin
        {Если ошибка 2 раз то удаление}
        DeleteSocket(Socket);
      end;
    end;
end;

procedure TProfFormServer.ServerSocket1ClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
  Buf: TBlock;
  I: Integer;
begin              
  Socket.ReceiveBuf(Buf, SizeOf(Buf));
  if Buf.Ident <> 0 then Exit;
  case Buf.Com of
    0:begin {Возвращение имени}
      for I := 0 to High(A) do
        {if A[I].CustomWinSocket.RemoteAddress = Buf.AddressFrom then}
        if A[I].CustomWinSocket = Socket then
        begin
          A[I].Name := Buf.S;
          RefreshA;
          Break;
        end;
    end;
    1:begin {Отослать сообщение}
      {Memo1.Lines.Add(Buf.S);}
      {if Buf.AddressOut = 'All' then
      begin
        for I := 0 to High(A) do
          A[I].CustomWinSocket.SendBuf(Buf, SizeOf(Buf));
      end
      else
      begin
        for I := 0 to High(A) do
          if A[I].CustomWinSocket.RemoteAddress = Buf.AddressOut then
          begin
            A[I].CustomWinSocket.SendBuf(Buf, SizeOf(Buf));
            Break;
          end;
      end;}
    end;
    2:begin {Запрос на возвращение списка имен}
      if Buf.S = '0' then
      begin
        Buf.AddressFrom := FServerSocket.Socket.LocalAddress;
        Buf.S := IntToStr(Length(A)) + ' ' + IntToStr(3);
        Socket.SendBuf(Buf, SizeOf(Buf));
        for I := 0 to High(A) do
        begin
          Buf.S := A[I].Name;
          Socket.SendBuf(Buf, SizeOf(Buf));
          Buf.S := A[I].CustomWinSocket.RemoteAddress;
          Socket.SendBuf(Buf, SizeOf(Buf));
          Buf.S := IntToStr(A[I].Color);
          Socket.SendBuf(Buf, SizeOf(Buf));
        end;
      end
      else
      begin
        Buf.AddressFrom := FServerSocket.Socket.LocalAddress;
        Buf.S := IntToStr(Length(A));
        Socket.SendBuf(Buf, SizeOf(Buf));
        for I := 0 to High(A) do
        begin
          Buf.S := A[I].Name;
          Socket.SendBuf(Buf, SizeOf(Buf));
          Buf.S := A[I].CustomWinSocket.RemoteAddress;
          Socket.SendBuf(Buf, SizeOf(Buf));
        end;
      end;
    end;
    3:begin {Сообщение об изменении}
      Refresh(Socket);
      RefreshA;
    end;
    4:begin {Возвращение цвета}
      for I := 0 to High(A) do
        if A[I].CustomWinSocket.RemoteAddress = Buf.AddressFrom then
        begin
          A[I].Color := StrToInt(Buf.S);
          RefreshA;
          Break;
        end;
    end;
  end;
end;

end.

{
0.0.0.1 - 31.10.2005
}
