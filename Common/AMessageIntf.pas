{**
@Abstract(AMessage interface)
@Author(Prof1983 prof1983@ya.ru)
@Created(05.09.2007)
@LastMod(26.04.2012)
@Version(0.5)
}
unit AMessageIntf;

interface

type
  ISimpleMessage = interface
    function GetPersistent(): Integer;
    function GetReceiver(): Integer;
    function GetSender(): Integer;

    property Persistent: Integer read GetPersistent;
    property Receiver: Integer read GetReceiver;
    property Sender: Integer read GetSender;
  end;

type
  IMessage = ISimpleMessage; // deprecated

implementation

end.
