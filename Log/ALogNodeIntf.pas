{**
@Abstract(Интерфейс элемента логирования)
@Author(Prof1983 prof1983@ya.ru)
@Created(12.03.2012)
@LastMod(26.04.2012)
@Version(0.5)
}
unit ALogNodeIntf;

interface

uses
  ANodeIntf, ATypes;

type //** Интерфейс элемента логирования
  IProfLogNode = interface(IProfNode)
    //function Get_Document(): ILogDocument; safecall;
    //function Get_GroupEnum(): GroupMessageEnum; safecall;
    //function GetId(): Integer; safecall; -> IProfEntity
    //function Get_LogType(): TypeMessageEnum; safecall;
    //function Get_Parent(): Integer; safecall;
    //function Get_StatusEnum(): StatusNodeEnum; safecall;
    //function Get_StrMsg(): WideString; safecall;
    //procedure Set_GroupEnum(Value: GroupMessageEnum); safecall;
    //procedure SetId(Value: Integer); safecall; -> IProfEntity
    //procedure Set_LogType(Value: TypeMessageEnum); safecall;
    //procedure Set_StrMsg(const Value: WideString); safecall;
    //procedure Set_Parent(Value: Integer); safecall;
    //procedure Set_StatusEnum(Value: StatusNodeEnum); safecall;

    {**
      Добавить сообщение
      @returns(Возвращает номер добавленого сообщения или 0)
    }
    function AddMsg(const AMsg: WideString): Integer; safecall;
    {**
      Добавить строку
      @returns(Возвращает номер добавленой строки или 0)
    }
    function AddStr(const AStr: WideString): Integer; safecall;
    {**
      Добавить лог-сообщение
      @returns(Возвращает номер добавленого лог-сообщения или 0)
    }
    {function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; -> IProfEntity}
      //** Скрыть/Свернуть
    procedure Hide(); safecall;
      //** Отобразить/развернуть
    procedure Show(); safecall;

    //property GroupEnum: EnumGroupMessage read Get_GroupEnum write Set_GroupEnum;
    //property Id: Integer read GetID write SetID; -> IProfEntity
    //property Document: ILogDocument read Get_Document;
    //property LogType: EnumTypeMessage read Get_LogType write Set_LogType;
    //property StrMsg: WideString read Get_StrMsg write Set_StrMsg;
    //property Parent: Integer read Get_Parent write Set_Parent;
    //property StatusEnum: StatusNodeEnum read Get_StatusEnum write Set_StatusEnum;
  end;

  //** Интерфейс элемента логирования
  ILogNode2 = interface
    //function Get_Document(): ILogDocument;
    function Get_GroupEnum(): GroupMessageEnum;
    function Get_ID(): Integer;
    function Get_LogType(): EnumTypeMessage;
    function Get_Parent(): Integer;
    function Get_StatusEnum(): StatusNodeEnum;
    function Get_StrMsg(): WideString;
    procedure Set_GroupEnum(Value: EnumGroupMessage);
    procedure Set_Id(Value: Integer);
    procedure Set_LogType(Value: EnumTypeMessage);
    procedure Set_StrMsg(const Value: WideString);
    procedure Set_Parent(Value: Integer);
    procedure Set_StatusEnum(Value: StatusNodeEnum);

      //** Функция логирования
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; safecall;
      //** Функция логирования c Enum
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer; safecall;

    procedure AddStr(const AStr: WideString); safecall;
    procedure AddMsg(const AMsg: WideString); safecall;
    procedure Hide(); safecall;
    procedure Show(); safecall;
    //function ToLogA(AGroup: EnumGroupMessage; AType: EnumTypeMessage; const AStrMsg: WideString): Integer;

    property GroupEnum: EnumGroupMessage read Get_GroupEnum write Set_GroupEnum;
    property ID: Integer read Get_ID write Set_ID;
    //property Document: ILogDocument read Get_Document;
    property LogType: EnumTypeMessage read Get_LogType write Set_LogType;
    property StrMsg: WideString read Get_StrMsg write Set_StrMsg;
    property Parent: Integer read Get_Parent write Set_Parent;
    property StatusEnum: EnumNodeStatus read Get_StatusEnum write Set_StatusEnum;
  end;

type
  IProfLogNodes = IProfNodes;

implementation

end.
