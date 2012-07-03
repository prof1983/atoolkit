{**
@Abstract(Интерфейс элемента логирования)
@Author(Prof1983 prof1983@ya.ru)
@Created(12.03.2012)
@LastMod(03.07.2012)
@Version(0.5)
}
unit ALogNodeIntf;

interface

uses
  ABase, ANodeIntf, ATypes;

type //** Интерфейс элемента логирования
  IProfLogNode = interface //(IProfNode)
    {**
      Добавить сообщение
      @returns(Возвращает номер добавленого сообщения или 0)
    }
    function AddMsg(const AMsg: WideString): Integer;

    {**
      Добавить строку
      @returns(Возвращает номер добавленой строки или 0)
    }
    function AddStr(const AStr: WideString): Integer;

    {**
      Добавляет лог-сообщение.
      @returns Возвращает номер добавленого лог-сообщения или 0
    }
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: WideString): AInt;

      //** Скрыть/Свернуть
    procedure Hide();
      //** Отобразить/развернуть
    procedure Show();
  end;

  //** Интерфейс элемента логирования
  ILogNode2 = interface
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

    {**
      Добавить сообщение
      @returns(Возвращает номер добавленого сообщения или 0)
    }
    function AddMsg(const AMsg: WideString): Integer;
    //procedure AddMsg(const AMsg: WideString);

    {**
      Добавить строку
      @returns(Возвращает номер добавленой строки или 0)
    }
    function AddStr(const AStr: WideString): Integer;
    //procedure AddStr(const AStr: WideString);

      //** Функция логирования
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer;
      //** Функция логирования c Enum
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer;

    procedure Hide();
    procedure Show();

    property GroupEnum: EnumGroupMessage read Get_GroupEnum write Set_GroupEnum;
    property Id: Integer read Get_Id write Set_Id;
    property LogType: EnumTypeMessage read Get_LogType write Set_LogType;
    property StrMsg: WideString read Get_StrMsg write Set_StrMsg;
    property Parent: Integer read Get_Parent write Set_Parent;
    property StatusEnum: EnumNodeStatus read Get_StatusEnum write Set_StatusEnum;
  end;

type
  IProfLogNodes = IProfNodes;

implementation

end.
