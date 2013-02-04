{**
@Abstract Сообщения для передачи команд между модулями и внутри программы
@Author Prof1983 <prof1983@ya.ru>
@Created 04.11.2005
@LastMod 12.11.2012
}
unit AMessageObj;

interface

uses
  ATypes;

type
  TAMessageObj = class
  public
    FMessage: TProfMessageRec;
  public
    // TODO: Сделать функции Get*, Set* если требуется
    (*
      //** Содержание сообщения
    property Content: WideString read FContent write FContent;
      //** Идентификатор сообщений
    property ConversationID: WideString read FConversationID write FConversationID;
      //** Строка, идентифицирующая сообщение соответствует параметру reply-with при ответе на сообщение
    property InReplyTo: WideString read FInReplyTo write FInReplyTo;
      //** Имя получателя
    property ReceiverName: WideString read FReceiverName write FReceiverName;
      //** Время, к которому необходимо получить ответ
    property ReplyBy: TDateTime read FReplyBy write FReplyBy;
      //** Строка, идентифицирующая сообщение
    property ReplyWith: WideString read FReplyWith write FReplyWith;
      //** Имя отправителя
    property SenderName: WideString read FSenderName write FSenderName;
    *)
  end;

  //TProfMessage3 = TAMessageObj;

implementation

end.
