{**
@Abstract Events
@Author Prof1983 <prof1983@ya.ru>
@Created 30.08.2011
@LastMod 24.07.2012
}
unit AEventsExp;

interface

uses
  AEvents;

exports
  AEvents.Event_Clear name 'AEvent_Clear',
  AEvents.Event_Free name 'AEvent_Free',
  AEvents.Event_GetListenersCount name 'AEvent_GetListenersCount',
  AEvents.Event_GetName name 'AEvent_GetName',
  AEvents.Event_Connect name 'AEvent_Connect',
  AEvents.Event_Disconnect name 'AEvent_Disconnect',
  AEvents.Event_Invoke name 'AEvent_Invoke',
  AEvents.Event_New name 'AEvent_New';

implementation

end.
 