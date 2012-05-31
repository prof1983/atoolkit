{**
@Abstract(Модуль)
@Author(Prof1983 prof1983@ya.ru)
@Created(28.08.2007)
@LastMod(26.04.2012)
@Version(0.5)

-Модуль может иметь неограниченное число точек расширения (ExtensionPoint).
Модуль может зависеть от других модулей (Dependences).
Зависимости определяются в информации о модуле (Information).
}
unit AModuleIntf;

interface

uses
  AMessageIntf, AModuleInformationIntf, ATypes;

type
  IProfModule = interface
    // Protected methods

    function GetInformation(): IModuleInformation;
    function GetLocalId(): Integer;
    function GetLocalName(): WideString;

    // Public methods

    function Initialize(): TProfError;
    function Finalize(): TProfError;
    function Start(): Integer;
    function Stop(): Integer;
    function Pause(): Integer;

    // Обработать сообщение
    function PushMessage(Msg: ISimpleMessage): Integer;

    // Public properties

    // Информация о модуле
    property Information: IModuleInformation read GetInformation;
    // Локальный идентификатор
    property LocalID: Integer read GetLocalID;
    {
      Локальное имя.
      Локальное имя служит для идентификации модуля в случае,
      если создается несколько одинаковых модулей
      (например несколько одинаковых агентов).
    }
    property LocalName: WideString read GetLocalName;
  end;
  //IModule = IProfModule;

type
  IComponent = IProfModule; // deprecated

implementation

end.
