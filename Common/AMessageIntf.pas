{**
@Abstract AMessage interface
@Author Prof1983 <prof1983@ya.ru>
@Created 05.09.2007
@LastMod 04.02.2013
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

  //IMessage = ISimpleMessage; // deprecated

implementation

end.
